{% import "util.macro" as util %}

{%- macro format_box(box, depth) %}
  {%- if not box.EtherCAT -%}
    (Not EtherCAT?)
  {%- else -%}
    {%- if depth % 2 == 0 -%}
      **
    {%- endif %}
    {{- box.name | trim("=+-") }} [ID: {{ box.attributes.Id }}]
    {%- if depth % 2 == 0 -%}
      **
    {%- endif %}
    {%- set ethercat = box.EtherCAT[0] %}

    {%+ if box.attributes.Disabled == "true" %}
      {{ "(**Disabled**)" }}
    {%- endif %}
    {%- if ethercat.SuName %}
      ( **SyncUnit={{ ethercat.SuName[0].text }}** )
    {%- endif %}
    {{ ethercat.attributes.Type }}
  {%- endif -%}
{%- endmacro -%}

{%- macro format_tree(box, children, depth) %}
{% set box_text = format_box(box, depth) %}
#. {{ box_text }}

  {% for child, grandchildren in children.items() %}
    {% set child_text = format_tree(child, grandchildren, depth + 1) %}
    {{ child_text | indent(width=4, first=False, blank=False) }}

  {% endfor %}
{%- endmacro -%}


{{ util.section("Box Hierarchy") }}

{% for box, children in get_box_hierarchy(tsproj.obj).items() %}

{% set child_text = format_tree(box, children, 0) %}
{{ child_text }}

{% endfor %}{# for box_id... #}
