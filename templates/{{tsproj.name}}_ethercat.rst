{% import "util.macro" as util %}

{% macro format_box_html(box, depth) %}
  {%- if not box.EtherCAT -%}
    (Not EtherCAT?)
  {%- else -%}
    {%- set ethercat = box.EtherCAT[0] %}
    <table width="100%">
      <tr>
        <td width="10%">
          ID={{ box.attributes.Id }}:
        </td>
        <td width="75%">
          {{- box.name | trim("=+-") }}
        </td>
        <td>
          {%- if ethercat.SuName %}
            <b>
              SyncUnit {{ ethercat.SuName[0].text }}
            </b>
          {%- endif %}
        </td>
      </tr>
      <tr>
        <td>
          {%+ if box.attributes.Disabled == "true" %}
            <b>
              Disabled
            </b>
          {%- endif %}
        </td>
        <td colspan="2">
          {{ ethercat.attributes.Type }}
        </td>
      </tr>
    </table>
  {%- endif -%}
{%- endmacro -%}

{%- macro format_tree_html(box, children, depth) %}
  {% set box_text = format_box_html(box, depth) %}
  <li>
  {% if not children %}
    {{ box_text }}
  {% else %}
    <details open>
      <summary>
        {{ box_text }}
      </summary>
      <ul>
        {% for child, grandchildren in children.items() %}

          {% set child_text = format_tree_html(child, grandchildren, depth + 1) %}
          {{ child_text | indent(width=10, first=False, blank=False) }}

        {% endfor %}
      </ul>
    </details>
  {% endif %}
  </li>

{%- endmacro -%}

{{ util.section("EtherCAT Terminals") }}

.. raw:: html

    <ul class="tree">

{% for box, children in get_box_hierarchy(tsproj.obj).items() %}

{% set child_text = format_tree_html(box, children, 0) %}

    {{ child_text }}

{% endfor %}{# for box_id... #}

    </ul>
