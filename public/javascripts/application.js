// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
<script>
function do_my_thing(newtag)
{
	var mytglist =	document.forms[0].tag_list.value;
	mytglist = mytglist + " " + newtag;
	document.forms[0].tag_list.value = mytglist;
}
</script>
