load("//build/kernel/kleaf:kernel.bzl", "kernel_module")

# mt7663u_build_path is "wlan_driver" in the Amlogic wifi build framework
# (mt7663u_src_path = $(DRIVER_DIR)/mtk/drivers/mt7663u), so this directory
# holds the module Makefile.  Its default goal ("all") builds "modules", and it
# also provides "modules_install".
#
# mt7663u_args is "CONFIG_MTK_USB=y"; kleaf cannot pass extra make variables,
# but the Makefile already falls back to HIF=usb when neither CONFIG_MTK_SDIO
# nor CONFIG_MTK_USB is set, which yields the same MODULE_NAME.
#
# MODULE_NAME is wlan_$(WIFI_TARGET)_$(HIF) = wlan_mt7663_usb, and
# CONFIG_MTK_PREALLOC_MEMORY=y adds the wlan_mt7663_usb_prealloc module; both
# match what configs/wifi_ko_list.bzl expects.
def mt7663u_module(name, kernel_build, deps = None):
    kernel_module(
        name = name,
        srcs = ["//vendor/amlogic/mtk-drivers/mt7663u/wlan_driver:mt7663u_srcs"],
        makefile = ["//vendor/amlogic/mtk-drivers/mt7663u/wlan_driver:Makefile"],
        deps = deps,
        outs = [
            "wlan_mt7663_usb.ko",
            "wlan_mt7663_usb_prealloc.ko",
        ],
        kernel_build = kernel_build,
    )
