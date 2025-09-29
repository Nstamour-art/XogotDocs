<!-- Remove this line to publish to docs.xogot.com -->
# Upgrading from Godot 4.4 to Godot 4.5

For most games and apps made with 4.4 it should be relatively safe to migrate to 4.5.
This page intends to cover everything you need to pay attention to when migrating
your project.

## Breaking changes

If you are migrating from 4.4 to 4.5, the breaking changes listed here might
affect you. Changes are grouped by areas/systems.

> Warning:
>
> In order to support new Google Play requirements Android now requires
> targeting .NET 9 when exporting C# projects to Android, other platforms
> continue to use .NET 8 as the minimum required version but newer versions
> are supported and encouraged.
>
> If you are using C# in your project and want to export to Android, you will
> need to upgrade your project to .NET 9 (see Upgrading to a new .NET version
> for instructions).
>

This article indicates whether each breaking change affects GDScript and whether
the C# breaking change is binary compatible or source compatible:

- **Binary compatible** - Existing binaries will load and execute successfully without
recompilation, and the run-time behavior won't change.

- **Source compatible** - Source code will compile successfully without changes when
upgrading Godot.

### Core

Change | GDScript Compatible | C# Binary Compatible | C# Source Compatible | Introduced
------ | ------------------- | -------------------- | -------------------- | ----------
**JSONRPC** |  |  |  | 
Methodset_scopereplaced byset_methodoptional parameter | |❌| | |✔️ with compat| | |✔️ with compat| | GH-104890
**Node** |  |  |  | 
Methodget_rpc_configrenamed toget_node_rpc_config | |❌| | |✔️ with compat| | |✔️ with compat| | GH-106848
Methodset_namechangesnameparameter type fromStringtoStringName | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-76560

### Rendering

Change | GDScript Compatible | C# Binary Compatible | C# Source Compatible | Introduced
------ | ------------------- | -------------------- | -------------------- | ----------
**DisplayServer** |  |  |  | 
Methodfile_dialog_showadds a newparent_window_idoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-98194
Methodfile_dialog_with_options_showadds a newparent_window_idoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-98194
**RenderingDevice** |  |  |  | 
Methodtexture_create_from_extensionadds a newmipmapsoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-105570
**RenderingServer** |  |  |  | 
Methodinstance_reset_physics_interpolationremoved | |❌| | |✔️ with compat| | |✔️ with compat| | GH-104269
Methodinstance_set_interpolatedremoved | |❌| | |✔️ with compat| | |✔️ with compat| | GH-104269

> Note:
>
> In C#, the enum RenderingDevice.Features breaks compatibility because of the way the bindings generator
> detects the enum prefix. New members were added to the enum in GH-103941 that caused the enum member
> Address to be renamed to BufferDeviceAddress.
>

### GLTF

Change | GDScript Compatible | C# Binary Compatible | C# Source Compatible | Introduced
------ | ------------------- | -------------------- | -------------------- | ----------
**GLTFAccessor** |  |  |  | 
Propertybyte_offsetchanges type metadata fromint32toint64 | |✔️| | |❌| | |❌| | GH-106220
Propertycomponent_typechanges type frominttoGLTFAccessor::GLTFComponentType | |✔️| | |❌| | |❌| | GH-106220
Propertycountchanges type metadata fromint32toint64 | |✔️| | |❌| | |❌| | GH-106220
Propertysparse_countchanges type metadata fromint32toint64 | |✔️| | |❌| | |❌| | GH-106220
Propertysparse_indices_byte_offsetchanges type metadata fromint32toint64 | |✔️| | |❌| | |❌| | GH-106220
Propertysparse_indices_component_typechanges type frominttoGLTFAccessor::GLTFComponentType | |✔️| | |❌| | |❌| | GH-106220
Propertysparse_values_byte_offsetchanges type metadata fromint32toint64 | |✔️| | |❌| | |❌| | GH-106220
**GLTFBufferView** |  |  |  | 
Propertybyte_lengthchanges type metadata fromint32toint64 | |✔️| | |❌| | |❌| | GH-106220
Propertybyte_offsetchanges type metadata fromint32toint64 | |✔️| | |❌| | |❌| | GH-106220
Propertybyte_stridechanges type metadata fromint32toint64 | |✔️| | |❌| | |❌| | GH-106220

> Note:
>
> As a result of changing the type metadata, the C# bindings changed the type from int (32-bytes) to long (64-bytes).
>

### Text

Change | GDScript Compatible | C# Binary Compatible | C# Source Compatible | Introduced
------ | ------------------- | -------------------- | -------------------- | ----------
**CanvasItem** |  |  |  | 
Methoddraw_charadds a newoversamplingoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-104872
Methoddraw_char_outlineadds a newoversamplingoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-104872
Methoddraw_multiline_stringadds a newoversamplingoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-104872
Methoddraw_multiline_string_outlineadds a newoversamplingoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-104872
Methoddraw_stringadds a newoversamplingoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-104872
Methoddraw_string_outlineadds a newoversamplingoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-104872
**Font** |  |  |  | 
Methoddraw_charadds a newoversamplingoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-104872
Methoddraw_char_outlineadds a newoversamplingoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-104872
Methoddraw_multiline_stringadds a newoversamplingoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-104872
Methoddraw_multiline_string_outlineadds a newoversamplingoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-104872
Methoddraw_stringadds a newoversamplingoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-104872
Methoddraw_string_outlineadds a newoversamplingoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-104872
**RichTextLabel** |  |  |  | 
Methodadd_imageadds a newalt_textoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-76829
Methodadd_imagereplacedsize_in_percentparameter bywidth_in_percentandheight_in_percent | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-107347
Methodpush_strikethroughadds optionalcolorparameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-106300
Methodpush_tableadds a newnameoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-76829
Methodpush_underlineadds optionalcolorparameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-106300
Methodupdate_imagereplacedsize_in_percentparameter bywidth_in_percentandheight_in_percent | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-107347
**TextLine** |  |  |  | 
Methoddrawadds a newoversamplingoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-104872
Methoddraw_outlineadds a newoversamplingoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-104872
**TextParagraph** |  |  |  | 
Methoddrawadds a newoversamplingoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-104872
Methoddraw_dropcapadds a newoversamplingoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-104872
Methoddraw_dropcap_outlineadds a newoversamplingoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-104872
Methoddraw_lineadds a newoversamplingoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-104872
Methoddraw_line_outlineadds a newoversamplingoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-104872
Methoddraw_outlineadds a newoversamplingoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-104872
**TextServer** |  |  |  | 
Methodfont_draw_glyphadds a newoversamplingoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-104872
Methodfont_draw_glyph_outlineadds a newoversamplingoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-104872
Methodshaped_text_drawadds a newoversamplingoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-104872
Methodshaped_text_draw_outlineadds a newoversamplingoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-104872
**TreeItem** |  |  |  | 
Methodadd_buttonadds a newalt_textoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-76829
**TextServerExtension** |  |  |  | 
Method_font_draw_glyphadds a newoversamplingoptional parameter | |❌| | |❌| | |❌| | GH-104872
Method_font_draw_glyph_outlineadds a newoversamplingoptional parameter | |❌| | |❌| | |❌| | GH-104872
Method_shaped_text_drawadds a newoversamplingoptional parameter | |❌| | |❌| | |❌| | GH-104872
Method_shaped_text_draw_outlineadds a newoversamplingoptional parameter | |❌| | |❌| | |❌| | GH-104872

### XR

Change | GDScript Compatible | C# Binary Compatible | C# Source Compatible | Introduced
------ | ------------------- | -------------------- | -------------------- | ----------
**OpenXRAPIExtension** |  |  |  | 
Methodregister_composition_layer_providerchangesextensionparameter type fromOpenXRExtensionWrapperExtensiontoOpenXRExtensionWrapper | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-104087
Methodregister_projection_views_extensionchangesextensionparameter type fromOpenXRExtensionWrapperExtensiontoOpenXRExtensionWrapper | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-104087
Methodunregister_composition_layer_providerchangesextensionparameter type fromOpenXRExtensionWrapperExtensiontoOpenXRExtensionWrapper | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-104087
Methodunregister_projection_views_extensionchangesextensionparameter type fromOpenXRExtensionWrapperExtensiontoOpenXRExtensionWrapper | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-104087
**OpenXRBindingModifierEditor** |  |  |  | 
TypeOpenXRBindingModifierEditorchanged API type from Core to Editor | |❌| | |❌| | |❌| | GH-103869
**OpenXRInteractionProfileEditor** |  |  |  | 
TypeOpenXRInteractionProfileEditorchanged API type from Core to Editor | |❌| | |❌| | |❌| | GH-103869
**OpenXRInteractionProfileEditorBase** |  |  |  | 
TypeOpenXRInteractionProfileEditorBasechanged API type from Core to Editor | |❌| | |❌| | |❌| | GH-103869

> Note:
>
> Classes OpenXRBindingModifierEditor, OpenXRInteractionProfileEditor, and OpenXRInteractionProfileEditorBase
> are only available in the editor. Using them outside of the editor will result in a compilation error.
>
> In C#, this means the types are moved from the GodotSharp assembly to the GodotSharpEditor assembly.
> Make sure to wrap code that uses these types in a #if TOOLS block to ensure they are not included in an exported game.
>
> **This change was also backported to 4.4.1.**
>

### Editor plugins

Change | GDScript Compatible | C# Binary Compatible | C# Source Compatible | Introduced
------ | ------------------- | -------------------- | -------------------- | ----------
**EditorExportPlatform** |  |  |  | 
Methodget_forced_export_filesadds a newpresetoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-71542
**EditorUndoRedoManager** |  |  |  | 
Methodcreate_actionadds a newmark_unsavedoptional parameter | |✔️| | |✔️ with compat| | |✔️ with compat| | GH-106121
**EditorExportPlatformExtension** |  |  |  | 
Method_get_option_iconchanges return type fromImageTexturetoTexture2D | |✔️| | |❌| | |❌| | GH-108825

## Behavior changes

In 4.5, some behavior changes have been introduced, which might require you to adjust your project.

### TileMapLayer

[TileMapLayer.get_coords_for_body_rid()](https://docs.godotengine.org/en/stable/classes/class_tilemaplayer_method_get_coords_for_body_rid.html#class-tilemaplayer_method_get_coords_for_body_rid)
will return different values in 4.5 compared to 4.4,
as TileMapLayer physics chunking is enabled by default. Higher values of
[TileMapLayer.physics_quadrant_size](https://docs.godotengine.org/en/stable/classes/class_tilemaplayer_property_physics_quadrant_size.html#class-tilemaplayer_property_physics_quadrant_size)
will make this function less precise. To get the exact cell coordinates like in 4.4 and prior
versions, you need to set
[TileMapLayer.physics_quadrant_size](https://docs.godotengine.org/en/stable/classes/class_tilemaplayer_property_physics_quadrant_size.html#class-tilemaplayer_property_physics_quadrant_size)
to 1, which disables physics chunking.

### 3D Model Import

A fix has been made to the 3D model importers to correctly handle non-joint nodes within a skeleton hierarchy (GH-104184).
To preserve compatibility, the default behavior is to import existing files with the same behavior as before (GH-107352).
New .gltf, .glb, .blend, and .fbx files (without a corresponding .import file)
will be imported with the new behavior. However, for existing files, if you want to use the
new behavior, you must change the "Naming Version" option at the bottom of the Import dock:

@Image(source: "gltf_naming_version.png")

### Core

> Note:
>
> [Resource.duplicate(true)](https://docs.godotengine.org/en/stable/classes/class_resource_method_duplicate.html#class-resource_method_duplicate) (which performs
> deep duplication) now only duplicates resources internal to the resource file
> it's called on. In 4.4, this duplicated everything instead, including external resources.
> If you were deep-duplicating a resource that contained references to other
> external resources, those external resources aren't duplicated anymore. You must call
> [Resource.duplicate_deep(RESOURCE_DEEP_DUPLICATE_ALL)](https://docs.godotengine.org/en/stable/classes/class_resource_method_duplicate_deep.html#class-resource_method_duplicate_deep)
> instead to keep the old behavior.
>

> Note:
>
> [ProjectSettings.add_property_info()](https://docs.godotengine.org/en/stable/classes/class_projectsettings_method_add_property_info.html#class-projectsettings_method_add_property_info)
> now prints a warning when the dictionary parameter has missing keys or invalid keys.
> Most importantly, it will now warn when a usage key is passed, as this key is not used.
> This was also the case before 4.5, but it was silently ignored instead.
> As a reminder, to set property usage information correctly, you must use
> [ProjectSettings.set_as_basic()](https://docs.godotengine.org/en/stable/classes/class_projectsettings_method_set_as_basic.html#class-projectsettings_method_set_as_basic),
> [ProjectSettings.set_restart_if_changed()](https://docs.godotengine.org/en/stable/classes/class_projectsettings_method_set_restart_if_changed.html#class-projectsettings_method_set_restart_if_changed),
> or [ProjectSettings.set_as_internal()](https://docs.godotengine.org/en/stable/classes/class_projectsettings_method_set_as_internal.html#class-projectsettings_method_set_as_internal) instead.
>

> Note:
>
> In C#, StringExtensions.PathJoin now avoids adding an extra path separator when the original string is empty,
> or when the appended path starts with a path separator (GH-105281).
>

> Note:
>
> In C#, StringExtensions.GetExtension now returns an empty string instead of the original string
> when the original string does not contain an extension (GH-108041).
>

> Note:
>
> In C#, the Quaternion(Vector3, Vector3) constructor now correctly creates a quaternion representing
> the shortest arc between the two input vectors. Previously, it would return incorrect values for certain inputs
> (GH-107618).
>

### Navigation

> Note:
>
> By default, the regions in a NavigationServer map now update asynchronously using threads to improve performance.
> This can cause additional delay in the update due to thread synchronisation.
> The asynchronous region update can be toggled with the navigation/world/region_use_async_iterations project setting.
>

> Note:
> The merging of navmeshes in the NavigationServer has changed processing order. Regions now merge and cache
> internal navmeshes first, then the remaining free edges are merged by the navigation map.
> If a project had navigation map synchronisation errors before, it might now have shifted
> affected edges, making already existing errors in a layout more noticeable in the pathfinding.
> The navigation/2d_or_3d/merge_rasterizer_cell_scale project setting can be set to a lower value
> to increase the detail of the rasterization grid (with `0.01` being the smallest cell size possible).
> If edge merge errors still persist with the lowest possible rasterization scale value,
> the error may be caused by overlap: two navmeshes are stacked on top of each other, causing geometry conflict.
>

### Physics

> Note:
>
> When the 3D physics engine is set to Jolt Physics, you will now always have overlaps between Area3D and static
> bodies reported by default, as the physics/jolt_physics_3d/simulation/areas_detect_static_bodies project setting
> has been removed (GH-105746). If you still want such overlaps to be ignored, you will need to change the collision mask
> or layer of either the Area3D or the static body instead.
>

### Text

> Note:
>
> In GDScript, calls to functions RichTextLabel::add_image and RichTextLabel::update_image will continue to work,
> but the size_in_percent argument will now be used as the value for width_in_percent and height_in_percent
> will default to false (GH-107347). To restore the previous behavior, you can explicitly set height_in_percent
> to the same value you were passing as size_in_percent.
>