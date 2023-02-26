Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240796A2F1E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 11:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBZKqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 05:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBZKqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 05:46:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82008FF02;
        Sun, 26 Feb 2023 02:45:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E136B80B46;
        Sun, 26 Feb 2023 10:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A10C4339B;
        Sun, 26 Feb 2023 10:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677408355;
        bh=sjXnkeFErCwNBCwrTz0/jv2XB8AFeiZG0yaWL0OX2cg=;
        h=Date:From:To:Cc:Subject:From;
        b=Px9SDKvu/SO8+X+cUzVwxqyoAAd/+PeGmzfB+6Qt8RkUBDshzXWgka6ZTKFPxGWrL
         CpRMZ7mQHyKDnxtZ9IlkHJcVc+2EGP9++VER2a4D5TZs3o4wfeGOyb8QpYa5ntcoxW
         pwTKbnmFG0aqbUwkKBwrAa7Loh1ySaojbOT3IroDK2ElFjZxCg/9sXo5xeYHC5MmOY
         rBOFCI0sQa3CE6b7tNFvpgD9F9OFk76OIiW+4koTBY6LmRYdnZX2XpqMqiHVNYLFWI
         V6zfWQDS2XZeh7CX3yfgLIJvZ2imi4iTcSLi19PlZKdaf6sXhTQGPZoKBg5cKf8p21
         UjfNcAqwY0lNQ==
Date:   Sun, 26 Feb 2023 11:45:51 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Subject: [GIT PULL for v6.3-rc1] media updates
Message-ID: <20230226114551.68480d44@coco.lan>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/m=
edia/v6.3-1

For:

- Removal of several VB1-only deprecated drivers: cpia2, fsl-viu, meye,=20
  stkwebcam, tm6000, vpfe_capture and zr364xx;
- saa7146 recovered from staging/deprecated. We opted to give ti a chance,
  and, instead of deprecating it, the intention is to write patches
  migrating it from VB1 to VB2.
- av7110 returned from staging/deprecated/ to staging/ as we're not
  planning on dropping it any time soon;
- media controller API has gained experimental support for
  G_ROUTING and streams API. No drivers use it right now. We're planning to=
=20
  add one after -rc1, giving some time to experience the API and eventually
  have changes during the next development cycle;
- New sensor drivers: imx296, imx415, ov8858;
- Atomisp had lots of changes, specially on its sensor's interface,
  making atomisp  sensor drivers closer to normal sensor drivers;
- media controller kAPI has gained some helpers to traverse pipelines;
- uvcvideo now better support power line control;
- lots of bug fixes, cleanups and driver improvements.

The following changes since commit 4ec5183ec48656cec489c49f989c508b68b518e3:

  Linux 6.2-rc7 (2023-02-05 13:13:28 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/me=
dia/v6.3-1

for you to fetch changes up to 3e62aba8284de0994a669d07983299242e68fe72:

  media: imx-mipi-csis: Check csis_fmt validity before use (2023-02-26 11:2=
1:33 +0100)

----------------------------------------------------------------
media updates for v6.3-rc1

----------------------------------------------------------------
Adam Ford (2):
      media: i2c: imx219: Split common registers from mode tables
      media: i2c: imx219: Support four-lane operation

Alexander Stein (2):
      media: i2c: ov9282: remove unused and unset i2c_client member
      media: i2c: ov9282: Switch to use dev_err_probe helper

Andrey Skvortsov (1):
      media: ov5640: Update last busy timestamp to reset autosuspend timer

Andy Shevchenko (1):
      media: i2c: st-vgxy61: Use asm intead of asm-generic

Arnd Bergmann (3):
      media: camss: csiphy-3ph: avoid undefined behavior
      media: platform: mtk-mdp3: fix Kconfig dependencies
      media: atomisp: fix videobuf2 Kconfig depenendency

Benjamin Roszak (1):
      media: meson: vdec: remove redundant if statement

Brent Pappas (4):
      media: atomisp: pci: Replace bytes macros with functions
      media: atomisp: pci: hive_isp_css_common: host: vmem: Replace SUBWORD=
 macros with functions
      media: atomisp: pci: sh_css: Inline single invocation of macro STATS_=
ENABLED()
      media: imx: imx-media-fim: Replace macro icap_enabled() with function

Chen-Yu Tsai (1):
      media: hantro: Use core-generated bus_info value

Colin Ian King (2):
      media: vidtv: make const array DURATION static
      media: rkisp1: make a few const arrays static

Deepak R Varma (1):
      media: staging: media: imx: change imx_media_fim_set_stream() to retu=
rn void

Dmitry Torokhov (1):
      media: i2c: s5c73m3: remove support for platform data

Dong Chuanjian (1):
      media: drivers/media/v4l2-core/v4l2-h264 : add detection of null poin=
ters

Duoming Zhou (2):
      media: rc: Fix use-after-free bugs caused by ene_tx_irqsim()
      media: usb: siano: Fix use after free bugs caused by do_submit_urb

Eugen Hristev (1):
      media: microchip: microchip-isc: replace v4l2_{dbg|info|err} with dev=
-*

Gaosheng Cui (1):
      media: ti: cal: fix possible memory leak in cal_ctx_create()

Gerald Loacker (1):
      media: i2c: add imx415 cmos image sensor driver

Guenter Roeck (1):
      media: uvcvideo: Handle errors from calls to usb_string

Guoniu.zhou (1):
      media: ov5640: set correct default format for CSI-2 mode

Hans Verkuil (31):
      media: uvcvideo: Check for INACTIVE in uvc_ctrl_is_accessible()
      media: uvcvideo: Improve error logging in uvc_query_ctrl()
      media: meye: remove this deprecated driver
      media: cpia2: remove deprecated driver
      media: fsl-viu: remove deprecated driver
      media: stkwebcam: remove deprecated driver
      media: zr364xx: remove deprecated driver
      media: vpfe_capture: remove deprecated davinci drivers
      media: tm6000: remove deprecated driver
      media: videobuf2-core: drop obsolete sanity check in __vb2_queue_free=
()
      media: s5p-mfc: use vb2_is_streaming()
      media: v4l2-mem2mem: use vb2_is_streaming()
      media: go7007: don't modify q->streaming
      media: atomisp: use vb2_start_streaming_called()
      media: visl: make visl_qops static
      media: davinci/vpif.c: drop unnecessary cast
      media: i2c: s5c73m3: return 0 instead of 'ret'.
      media: dvb-frontends: cxd2880: return 0 instead of 'ret'.
      media: usb: dvb-usb-v2: af9015.c: return 0 instead of 'ret'.
      media: dvb-frontends: cxd2880: return 0 instead of 'ret'.
      media: marvell: change return to goto for proper unwind
      media: dvb-frontends: drx39xyj: replace return with goto for proper u=
nwind
      media: mediatek: mdp3: replace return by goto for proper unwind
      media: mediatek: vcodec/venc: return 0 instead of 'ret'.
      media: ti: davinci: vpbe_display.c: return 0 instead of 'ret'.
      media: i2c: ov7670: 0 instead of -EINVAL was returned
      media: dvb-frontends: mb86a16.c: always use the same error path
      media: Revert "media: av7110: move to staging/media/deprecated/saa714=
6"
      media: Revert "media: saa7146: deprecate hexium_gemini/orion, mxb and=
 ttpci"
      media: v4l2-ctrls-api.c: move ctrl->is_new =3D 1 to the correct line
      media: v4l2-subdev.c: clear stream field

Hans de Goede (55):
      media: atomisp: Propagate set_fmt() errors in queue_setup()
      media: atomisp: Only set default_run_mode on first open of a stream/a=
sd
      media: atomisp: Fix WARN() when the vb2 start_streaming callback fails
      media: atomisp: Check buffer index is in range inside atomisp_qbuf_wr=
apper()
      media: atomisp: Fix regulator registers on BYT devices with CRC PMIC
      media: atomisp: Remove atomisp_sw_contex struct
      media: atomisp: Move power-management over to a custom pm-domain
      media: atomisp: Silence "isys dma store at addr, val" debug messages
      media: atomisp: Remove non working doorbell check from punit_ddr_dvfs=
_enable()
      media: atomisp: Remove useless msleep(10) before power-on on BYT
      media: atomisp: Remove custom ATOMISP_IOC_ISP_MAKERNOTE ioctl
      media: atomisp: Remove custom ATOMISP_IOC_G_SENSOR_MODE_DATA ioctl
      media: atomisp: Remove V4L2_CID_BIN_FACTOR_HORZ/_VERT
      media: atomisp: Remove no longer used binning info from sensor resolu=
tion info
      media: atomisp: Remove deferred firmware loading support
      media: atomisp: Drop atomisp_init_pipe()
      media: atomisp: Remove unnecessary memset(foo, 0, sizeof(foo)) calls
      media: atomisp: Do not turn off sensor when the atomisp-sub-dev does =
not own it
      media: atomisp: Allow sensor drivers without a s_power callback
      media: atomisp: Remove atomisp_gmin_find_subdev()
      media: atomisp: Add atomisp_register_sensor_no_gmin() helper
      media: atomisp: Drop ffmt local var from atomisp_set_fmt()
      media: atomisp: Stop overriding padding w/h to 12 on BYT
      media: atomisp: Put sensor ACPI devices in D3 before disable ACPI pow=
er-resources
      media: atomisp: Remove isp_subdev_link_setup()
      media: atomisp: Remove csi2_link_setup()
      media: atomisp: Properly initialize function field of media-entity li=
nks
      media: core: add ov_16bit_addr_reg_helpers.h
      media: atomisp: ov2680: Use the new ov_16bit_addr_reg_helpers.h
      media: atomisp: ov2680: Rework flip ctrls
      media: atomisp: ov2680: Drop custom ATOMISP_IOC_S_EXPOSURE support
      media: atomisp: ov2680: Add exposure and gain controls
      media: atomisp: ov2680: Add test pattern control
      media: atomisp: ov2680: Fix window settings and enable window for all=
 resolutions
      media: atomisp: ov2680: Make setting the modes algorithm based
      media: atomisp: ov2680: Use defines for fps, lines-per-frame and skip=
-frames
      media: atomisp: ov2680: Drop unused res member from struct ov2680_dev=
ice
      media: atomisp: ov2680: Fix ov2680_enum_frame_interval()
      media: atomisp: ov2680: Drop v4l2_find_nearest_size() call from set_f=
mt()
      media: atomisp: ov2680: Drop struct ov2680_resolution / ov2680_res_pr=
eview
      media: atomisp: ov2680: Fix frame_size list
      media: atomisp: ov2680: Remove unused data-types and defines from ov2=
680.h
      media: atomisp: ov2680: Drop MAX_FMTS define
      media: atomisp: ov2680: Consistently indent define values
      media: atomisp: ov2680: Cleanup includes
      media: atomisp: ov2680: Delay power-on till streaming is started
      media: atomisp: ov2680: Add runtime-pm support
      media: atomisp: ov2680: s/dev/sensor/
      media: atomisp: ov2680: Add dev local variable to probe()
      media: atomisp: ov2680: Use devm_kzalloc() for sensor data struct
      media: atomisp: ov2680: Switch over to ACPI powermanagement
      media: atomisp: ov2722: Call atomisp_gmin_remove_subdev() on probe fa=
ilure
      media: atomisp: ov2722: Fix GPIO1 polarity
      media: atomisp: ov2722: Don't take the input_lock for try_fmt calls.
      media: atomisp: ov2722: Power on sensor from set_fmt() callback

Jacopo Mondi (11):
      media: Documentation: Add GS_ROUTING documentation
      media: subdev: Add for_each_active_route() macro
      media: dt-bindings: media: Add OmniVision OV8858
      media: dt-bindings: Add OV5670
      media: i2c: ov5670: Allow probing with OF
      media: i2c: ov5670: Use common clock framework
      media: i2c: ov5670: Probe regulators
      media: i2c: ov5670: Probe GPIOs
      media: i2c: ov5670: Add runtime_pm operations
      media: i2c: ov5670: Implement init_cfg
      media: i2c: ov5670: Handle RO controls in set_ctrl

Jai Luthra (3):
      media: ov5640: Fix soft reset sequence and timings
      media: ov5640: Handle delays when no reset_gpio set
      media: i2c: imx219: Fix binning for RAW8 capture

Jammy Huang (2):
      media: docs: aspeed-video: Update reference
      media: docs: pixfmt-reserved: Update reference

Jean Delvare (1):
      media: rc: Drop obsolete dependencies on COMPILE_TEST

Jean-Michel Hautbois (1):
      media: i2c: ov5670: Add .get_selection() support

Jiasheng Jiang (1):
      media: platform: ti: Add missing check for devm_regulator_get

Kees Cook (1):
      media: uvcvideo: Silence memcpy() run-time false positive warnings

Krzysztof Kozlowski (11):
      media: docs: admin-guide: media: align HDMI CEC node names with dtsch=
ema
      media: exynos4-is: drop unused pctrl field and headers
      media: dt-bindings: amlogic,meson-gx-ao-cec: move to cec subfolder
      media: dt-bindings: st,stm32-cec: move to cec subfolder
      media: dt-bindings: cec: convert common CEC properties to DT schema
      media: dt-bindings: amlogic,meson-gx-ao-cec: reference common CEC pro=
perties
      media: dt-bindings: chrontel,ch7322: reference common CEC properties
      media: dt-bindings: samsung,s5p-cec: convert to DT schema
      media: dt-bindings: cec-gpio: convert to DT schema
      media: dt-bindings: nvidia,tegra114-cec: convert to DT schema
      media: dt-bindings: st,stih-cec: convert to DT schema

Laurent Pinchart (64):
      media: uvcvideo: Remove format descriptions
      media: uvcvideo: Factor out usb_string() calls
      media: dt-bindings: media: i2c: max9286: Add support for per-port sup=
plies
      media: dt-bindings: media: i2c: max9286: Add property to select I2C s=
peed
      media: dt-bindings: media: i2c: max9286: Add property to select bus w=
idth
      media: i2c: max9286: Support manual framesync operation
      media: i2c: max9286: Rename MAX9286_DATATYPE_RAW11 to RAW12
      media: i2c: max9286: Support 12-bit raw bayer formats
      media: i2c: max9286: Define macros for all bits of register 0x15
      media: i2c: max9286: Configure remote I2C speed from device tree
      media: i2c: max9286: Configure bus width from device tree
      media: i2c: max9286: Select HS as data enable signal
      media: i2c: max9286: Print power-up GMSL link configuration
      media: mc: Improve the media_entity_has_pad_interdep() documentation
      media: subdev: Add [GS]_ROUTING subdev ioctls and operations
      media: subdev: add v4l2_subdev_routing_validate() helper
      media: v4l2-subdev: Add v4l2_subdev_state_xlate_streams() helper
      media: v4l2-subdev: Add subdev .(enable|disable)_streams() operations
      media: v4l2-subdev: Add v4l2_subdev_s_stream_helper() function
      media: i2c: imx290: Group functions in sections
      media: i2c: imx290: Factor out subdev init and cleanup to functions
      media: i2c: imx290: Factor out control update code to a function
      media: i2c: imx290: Access link_freq_index directly
      media: i2c: imx290: Pass format and mode to imx290_calc_pixel_rate()
      media: i2c: imx290: Compute pixel rate and blanking in one place
      media: i2c: imx290: Factor out black level setting to a function
      media: i2c: imx290: Factor out DT parsing to separate function
      media: i2c: imx290: Use dev_err_probe()
      media: i2c: imx290: Factor out clock initialization to separate funct=
ion
      media: i2c: imx290: Use V4L2 subdev active state
      media: i2c: imx290: Rename, extend and expand usage of imx290_pixfmt
      media: i2c: imx290: Use runtime PM autosuspend
      media: i2c: imx290: Initialize runtime PM before subdev
      media: i2c: imx290: Configure data lanes at start time
      media: i2c: imx290: Simplify imx290_set_data_lanes()
      media: i2c: imx290: Handle error from imx290_set_data_lanes()
      media: mc: entity: Add pad iterator for media_pipeline
      media: mc: entity: Add entity iterator for media_pipeline
      media: ti: omap3isp: Use media_pipeline_for_each_entity()
      media: ti: omap4iss: Use media_pipeline_for_each_entity()
      media: xilinx: dma: Use media_pipeline_for_each_pad()
      media: mc: Get media_device directly from pad
      media: mc: entity: Fix minor issues in comments and documentation
      media: i2c: IMX296 camera sensor driver
      media: imx: imx7-media-csi: Drop imx7_csi.cc field
      media: imx: imx7-media-csi: Simplify imx7_csi_video_init_format()
      media: imx: imx7-media-csi: Drop unneeded check when starting streami=
ng
      media: imx: imx7-media-csi: Drop unneeded src_sd check
      media: imx: imx7-media-csi: Drop unneeded pad checks
      media: imx: imx7-media-csi: Cleanup errors in imx7_csi_async_register=
()
      media: imx: imx7-media-csi: Zero format struct before calling .get_fm=
t()
      media: imx: imx7-media-csi: Use V4L2 subdev active state
      media: imx-mipi-csis: Rename error labels with 'err_' prefix
      media: imx-mipi-csis: Don't take lock in runtime PM handlers
      media: imx-mipi-csis: Pass format explicitly to internal functions
      media: imx-mipi-csis: Use V4L2 subdev active state
      media: imx-mipi-csis: Implement .init_cfg() using .set_fmt()
      media: imx-pxp: Sort headers alphabetically
      media: imx-pxp: Don't set bus_info manually in .querycap()
      media: imx-pxp: Add media controller support
      media: imx-pxp: Pass pixel format value to find_format()
      media: imx-pxp: Implement frame size enumeration
      media: imx-pxp: Introduce pxp_read() and pxp_write() wrappers
      media: imx-pxp: Use non-threaded IRQ

Li Jun (1):
      media: rc: gpio-ir-recv: add remove function

Manivannan Sadhasivam (1):
      media: dt-bindings: media: i2c: Add IMX296 CMOS sensor binding

Marco Felsch (3):
      media: i2c: tc358746: fix missing return assignment
      media: i2c: tc358746: fix ignoring read error in g_register callback
      media: i2c: tc358746: fix possible endianness issue

Marek Vasut (2):
      media: dt-bindings: media: imx7-csi: Document i.MX8M power-domains pr=
operty
      media: imx-mipi-csis: Check csis_fmt validity before use

Mauro Carvalho Chehab (4):
      Merge tag 'v6.2-rc1' into media_tree
      Merge tag 'media-uvc-next-20230115' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/pinchartl/linux into media_stage
      Merge tag 'v6.2-rc7' into media_tree
      Merge git://git.linuxtv.org/media_stage into media_tree

Miaoqian Lin (1):
      media: mc: entity: Fix doc for media_graph_walk_init

Michael Riesch (1):
      media: dt-bindings: media: i2c: add imx415 cmos image sensor

Michael Tretter (8):
      media: dt-bindings: media: fsl-pxp: convert to yaml
      media: imx-pxp: detect PXP version
      media: imx-pxp: extract helper function to setup data path
      media: imx-pxp: explicitly disable unused blocks
      media: imx-pxp: disable LUT block
      media: imx-pxp: make data_path_ctrl0 platform dependent
      media: imx-pxp: add support for i.MX7D
      media: imx-pxp: convert to regmap

Ming Qian (5):
      media: amphion: remove redundant check of colorspace in venc_s_fmt
      media: v4l2-jpeg: correct the skip count in jpeg_parse_app14_data
      media: v4l2-jpeg: ignore the unknown APP14 marker
      media: imx-jpeg: Apply clk_bulk api instead of operating specific clk
      media: amphion: correct the unspecified color space

Nicholas Roth (1):
      media: i2c: Add driver for OmniVision OV8858

Nicolas Dufresne (1):
      media: hantro: Fix JPEG encoder ENUM_FRMSIZE on RK3399

Oleg Verych (2):
      media: sun4i-csi: Use CSI_INT_STA_REG name, fix typo in a comment
      media: sun4i-csi: Fix 'Unbalanced pm_runtime_enable!'

Paul Elder (1):
      media: ov5640: Fix analogue gain control

Paul Kocialkowski (10):
      media: sun6i-csi: bridge: Error out on invalid port to fix warning
      media: sun6i-csi: capture: Remove useless ret initialization
      media: sun6i-mipi-csi2: Clarify return code handling in stream off pa=
th
      media: sun8i-a83t-mipi-csi2: Clarify return code handling in stream o=
ff path
      media: sun6i-isp: proc: Fix return code handling in stream off path
      media: sun6i-isp: proc: Error out on invalid port to fix warning
      media: sun6i-isp: proc: Declare subdev ops as static
      media: sun6i-isp: capture: Fix uninitialized variable use
      media: sun6i-isp: params: Fix incorrect indentation
      media: sun6i-isp: params: Unregister pending buffer on cleanup

Pedro Guilherme Siqueira Moreira (3):
      media: uvcvideo: Fix missing newline after declarations
      media: uvcvideo: Fix assignment inside if condition
      media: uvcvideo: Fix usage of symbolic permissions to octal

Qiheng Lin (1):
      media: platform: mtk-mdp3: Fix return value check in mdp_probe()

Quentin Schulz (4):
      media: dt-bindings: ov5675: document YAML binding
      media: ov5675: add device-tree support and support runtime PM
      media: i2c: ov5675: parse and register V4L2 device tree properties
      media: i2c: ov5675: add .get_selection support

Ricardo Ribalda (18):
      media: uvcvideo: Handle cameras with invalid descriptors
      media: uvcvideo: Only create input devs if hw supports it
      media: uvcvideo: Remove void casting for the status endpoint
      media: uvcvideo: Recover stalled ElGato devices
      media: uvcvideo: Limit power line control for Acer EasyCamera
      media: uvcvideo: Return -EACCES for Wrong state error
      media: uvcvideo: Do not return positive errors in uvc_query_ctrl()
      media: uvcvideo: Fix handling on Bitmask controls
      media: uvcvideo: Refactor __uvc_ctrl_add_mapping
      media: uvcvideo: Limit power line control for Acer EasyCamera
      media: uvcvideo: Extend documentation of uvc_video_clock_decode()
      media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU
      media: uvcvideo: Refactor uvc_ctrl_mappings_uvcXX
      media: uvcvideo: Refactor power_line_frequency_controls_limited
      media: uvcvideo: Fix power line control for Lenovo Integrated Camera
      media: uvcvideo: Use standard names for menus
      media: uvcvideo: Fix race condition with usb_kill_urb
      media: uvcvideo: Quirk for autosuspend in Logitech B910 and C910

Sakari Ailus (3):
      media: Add stream to frame descriptor
      media: Documentation: Update documentation for streams
      media: ipu3-cio2: Fix PM runtime usage_count in driver unbind

Shang XiaoJing (3):
      media: max9286: Fix memleak in max9286_v4l2_register()
      media: ov2740: Fix memleak in ov2740_init_controls()
      media: ov5675: Fix memleak in ov5675_init_controls()

Tasos Sahanidis (1):
      media: saa7134: Use video_unregister_device for radio_dev

Thomas Nizan (1):
      media: i2c: max9286: Add support for port regulators

Tomi Valkeinen (12):
      media: v4l2-subdev: Sort includes
      media: add V4L2_SUBDEV_FL_STREAMS
      media: add V4L2_SUBDEV_CAP_STREAMS
      media: subdev: Require code change to enable [GS]_ROUTING
      media: subdev: add v4l2_subdev_has_pad_interdep()
      media: subdev: add v4l2_subdev_set_routing helper()
      media: Documentation: add multiplexed streams documentation
      media: subdev: add stream based configuration
      media: subdev: use streams in v4l2_subdev_link_validate()
      media: subdev: add "opposite" stream helper funcs
      media: subdev: add streams to v4l2_subdev_get_fmt() helper function
      media: subdev: add v4l2_subdev_set_routing_with_fmt() helper

Uwe Kleine-K=C3=B6nig (23):
      media: dvb-frontends/dvb-pll: Convert to i2c's .probe_new()
      media: dvb-frontends/m88ds3103: Convert to i2c's .probe_new()
      media: dvb-frontends/mn88443x: Convert to i2c's .probe_new()
      media: dvb-frontends/tc90522: Convert to i2c's .probe_new()
      media: i2c/adv7180: Convert to i2c's .probe_new()
      media: i2c/adv7604: Convert to i2c's .probe_new()
      media: i2c/cs53l32a: Convert to i2c's .probe_new()
      media: i2c/ir-kbd-i2c: Convert to i2c's .probe_new()
      media: i2c/msp3400-driver: Convert to i2c's .probe_new()
      media: i2c/mt9p031: Convert to i2c's .probe_new()
      media: i2c/mt9v032: Convert to i2c's .probe_new()
      media: i2c/ov7670: Convert to i2c's .probe_new()
      media: i2c/saa7115: Convert to i2c's .probe_new()
      media: i2c/saa7127: Convert to i2c's .probe_new()
      media: i2c/tda1997x: Convert to i2c's .probe_new()
      media: i2c/tvaudio: Convert to i2c's .probe_new()
      media: i2c/tvp514x: Convert to i2c's .probe_new()
      media: i2c/video-i2c: Convert to i2c's .probe_new()
      media: tuners/si2157: Convert to i2c's .probe_new()
      media: rc/ir-rx51: Drop empty platform remove function
      media: ti/davinci: vpbe_osd: Drop empty platform remove function
      media: ti/davinci: vpbe_venc: Drop empty platform remove function
      media: chips-media/imx-vdoa: Drop empty platform remove function

Xavier Roumegue (1):
      media: dw100: Add a missing unwind goto in dw100_probe()

Yang Li (1):
      media: rzg2l-cru: Remove unneeded semicolon

Yang Yingliang (1):
      media: imx: imx7-media-csi: fix missing clk_disable_unprepare() in im=
x7_csi_init()

Yassine Oudjana (3):
      media: dt-bindings: ak7375: Convert to DT schema
      media: dt-bindings: ak7375: Add supplies
      media: i2c: ak7375: Add regulator management

Yuan Can (1):
      media: i2c: ov772x: Fix memleak in ov772x_probe()

Yunfei Dong (1):
      media: mediatek: vcodec: Using pm_runtime_put instead of pm_runtime_p=
ut_sync

Zhou jie (1):
      media: radio/wl128x: remove unnecessary (void*) conversions

 .clang-format                                      |    1 +
 Documentation/admin-guide/media/cec.rst            |    4 +-
 Documentation/admin-guide/media/cpia2.rst          |  145 --
 Documentation/admin-guide/media/dvb-drivers.rst    |    1 -
 Documentation/admin-guide/media/meye.rst           |   93 -
 .../admin-guide/media/other-usb-cardlist.rst       |   14 -
 Documentation/admin-guide/media/pci-cardlist.rst   |    1 -
 .../admin-guide/media/platform-cardlist.rst        |    1 -
 .../admin-guide/media/tm6000-cardlist.rst          |   83 -
 Documentation/admin-guide/media/usb-cardlist.rst   |    7 -
 Documentation/admin-guide/media/v4l-drivers.rst    |    2 -
 Documentation/admin-guide/media/zr364xx.rst        |  102 -
 .../devicetree/bindings/media/cec-gpio.txt         |   42 -
 Documentation/devicetree/bindings/media/cec.txt    |    8 -
 .../media/{ =3D> cec}/amlogic,meson-gx-ao-cec.yaml   |   11 +-
 .../devicetree/bindings/media/cec/cec-common.yaml  |   28 +
 .../devicetree/bindings/media/cec/cec-gpio.yaml    |   74 +
 .../bindings/media/cec/nvidia,tegra114-cec.yaml    |   58 +
 .../bindings/media/cec/samsung,s5p-cec.yaml        |   66 +
 .../devicetree/bindings/media/cec/st,stih-cec.yaml |   66 +
 .../bindings/media/cec/st,stm32-cec.yaml           |   53 +
 .../devicetree/bindings/media/fsl,imx6ull-pxp.yaml |   88 +
 .../devicetree/bindings/media/fsl-pxp.txt          |   26 -
 .../devicetree/bindings/media/i2c/ak7375.txt       |    8 -
 .../bindings/media/i2c/asahi-kasei,ak7375.yaml     |   52 +
 .../bindings/media/i2c/chrontel,ch7322.yaml        |   11 +-
 .../bindings/media/i2c/maxim,max9286.yaml          |   51 +-
 .../devicetree/bindings/media/i2c/ovti,ov5670.yaml |   93 +
 .../devicetree/bindings/media/i2c/ovti,ov5675.yaml |  122 +
 .../devicetree/bindings/media/i2c/ovti,ov8858.yaml |  106 +
 .../devicetree/bindings/media/i2c/sony,imx296.yaml |  106 +
 .../devicetree/bindings/media/i2c/sony,imx415.yaml |  122 +
 .../devicetree/bindings/media/nxp,imx7-csi.yaml    |   15 +
 .../devicetree/bindings/media/s5p-cec.txt          |   36 -
 .../devicetree/bindings/media/stih-cec.txt         |   27 -
 .../devicetree/bindings/media/tegra-cec.txt        |   27 -
 .../driver-api/media/drivers/cpia2_devel.rst       |   56 -
 Documentation/driver-api/media/drivers/index.rst   |    1 -
 Documentation/driver-api/media/mc-core.rst         |   10 +-
 Documentation/driver-api/media/v4l2-subdev.rst     |    8 +
 .../userspace-api/media/drivers/aspeed-video.rst   |    2 +-
 .../userspace-api/media/drivers/index.rst          |    1 -
 .../userspace-api/media/drivers/meye-uapi.rst      |   53 -
 .../userspace-api/media/v4l/dev-subdev.rst         |  166 ++
 .../userspace-api/media/v4l/pixfmt-reserved.rst    |    2 +-
 .../userspace-api/media/v4l/user-func.rst          |    1 +
 .../v4l/vidioc-subdev-enum-frame-interval.rst      |    5 +-
 .../media/v4l/vidioc-subdev-enum-frame-size.rst    |    5 +-
 .../media/v4l/vidioc-subdev-enum-mbus-code.rst     |    5 +-
 .../media/v4l/vidioc-subdev-g-crop.rst             |    5 +-
 .../media/v4l/vidioc-subdev-g-fmt.rst              |    5 +-
 .../media/v4l/vidioc-subdev-g-frame-interval.rst   |    5 +-
 .../media/v4l/vidioc-subdev-g-routing.rst          |  147 ++
 .../media/v4l/vidioc-subdev-g-selection.rst        |    5 +-
 MAINTAINERS                                        |   73 +-
 drivers/media/common/Kconfig                       |    1 +
 drivers/media/common/Makefile                      |    2 +-
 .../common =3D> media/common/saa7146}/Kconfig        |    0
 .../common =3D> media/common/saa7146}/Makefile       |    0
 .../common =3D> media/common/saa7146}/saa7146_core.c |    2 +-
 .../common =3D> media/common/saa7146}/saa7146_fops.c |    2 +-
 .../common =3D> media/common/saa7146}/saa7146_hlp.c  |    2 +-
 .../common =3D> media/common/saa7146}/saa7146_i2c.c  |    2 +-
 .../common =3D> media/common/saa7146}/saa7146_vbi.c  |    2 +-
 .../common/saa7146}/saa7146_video.c                |    2 +-
 drivers/media/common/videobuf2/videobuf2-core.c    |   25 +-
 .../media/dvb-frontends/cxd2880/cxd2880_tnrdmd.c   |    4 +-
 .../dvb-frontends/cxd2880/cxd2880_tnrdmd_dvbt.c    |   14 +-
 .../dvb-frontends/cxd2880/cxd2880_tnrdmd_dvbt2.c   |   14 +-
 drivers/media/dvb-frontends/drx39xyj/drxj.c        |    9 +-
 drivers/media/dvb-frontends/dvb-pll.c              |    5 +-
 drivers/media/dvb-frontends/m88ds3103.c            |    6 +-
 drivers/media/dvb-frontends/mb86a16.c              |    9 +-
 drivers/media/dvb-frontends/mn88443x.c             |    6 +-
 drivers/media/dvb-frontends/tc90522.c              |    6 +-
 drivers/media/i2c/Kconfig                          |   40 +
 drivers/media/i2c/Makefile                         |    3 +
 drivers/media/i2c/adv7180.c                        |    6 +-
 drivers/media/i2c/adv7604.c                        |    6 +-
 drivers/media/i2c/ak7375.c                         |   38 +
 drivers/media/i2c/cs53l32a.c                       |    6 +-
 drivers/media/i2c/imx219.c                         |  311 ++-
 drivers/media/i2c/imx290.c                         | 1059 +++++----
 drivers/media/i2c/imx296.c                         | 1172 ++++++++++
 drivers/media/i2c/imx415.c                         | 1300 +++++++++++
 drivers/media/i2c/ir-kbd-i2c.c                     |    5 +-
 drivers/media/i2c/max9286.c                        |  463 +++-
 drivers/media/i2c/msp3400-driver.c                 |    5 +-
 drivers/media/i2c/mt9p031.c                        |    6 +-
 drivers/media/i2c/mt9v032.c                        |    6 +-
 drivers/media/i2c/ov2740.c                         |    4 +-
 drivers/media/i2c/ov5640.c                         |   86 +-
 drivers/media/i2c/ov5670.c                         |  312 ++-
 drivers/media/i2c/ov5675.c                         |  198 +-
 drivers/media/i2c/ov7670.c                         |    8 +-
 drivers/media/i2c/ov772x.c                         |    3 +-
 drivers/media/i2c/ov8858.c                         | 2008 ++++++++++++++++
 drivers/media/i2c/ov9282.c                         |    9 +-
 drivers/media/i2c/s5c73m3/s5c73m3-core.c           |   22 +-
 drivers/media/i2c/s5c73m3/s5c73m3-ctrls.c          |    1 -
 drivers/media/i2c/s5c73m3/s5c73m3.h                |    1 -
 drivers/media/i2c/saa7115.c                        |    6 +-
 drivers/media/i2c/saa7127.c                        |    6 +-
 drivers/media/i2c/st-vgxy61.c                      |    4 +-
 drivers/media/i2c/tc358746.c                       |    9 +-
 drivers/media/i2c/tda1997x.c                       |    6 +-
 drivers/media/i2c/tvaudio.c                        |    5 +-
 drivers/media/i2c/tvp514x.c                        |    6 +-
 drivers/media/i2c/video-i2c.c                      |    6 +-
 drivers/media/mc/mc-entity.c                       |   86 +-
 drivers/media/pci/Kconfig                          |    2 +
 drivers/media/pci/Makefile                         |    4 +-
 drivers/media/pci/intel/ipu3/ipu3-cio2-main.c      |    3 +
 drivers/media/pci/saa7134/saa7134-core.c           |    2 +-
 .../saa7146 =3D> media/pci}/saa7146/Kconfig          |   15 +-
 .../saa7146 =3D> media/pci}/saa7146/Makefile         |    0
 .../saa7146 =3D> media/pci}/saa7146/hexium_gemini.c  |    2 +-
 .../saa7146 =3D> media/pci}/saa7146/hexium_orion.c   |    2 +-
 .../deprecated/saa7146 =3D> media/pci}/saa7146/mxb.c |    2 +-
 .../deprecated/saa7146 =3D> media/pci}/ttpci/Kconfig |   17 +-
 .../saa7146 =3D> media/pci}/ttpci/Makefile           |    0
 .../saa7146 =3D> media/pci}/ttpci/budget-av.c        |    2 +-
 .../saa7146 =3D> media/pci}/ttpci/budget-ci.c        |    0
 .../saa7146 =3D> media/pci}/ttpci/budget-core.c      |    0
 .../saa7146 =3D> media/pci}/ttpci/budget.c           |    0
 .../saa7146 =3D> media/pci}/ttpci/budget.h           |    2 +-
 drivers/media/platform/amphion/venc.c              |   18 +-
 drivers/media/platform/amphion/vpu_color.c         |    6 +-
 drivers/media/platform/chips-media/imx-vdoa.c      |    6 -
 drivers/media/platform/marvell/mmp-driver.c        |    2 +-
 drivers/media/platform/mediatek/mdp3/Kconfig       |    7 +-
 .../media/platform/mediatek/mdp3/mtk-mdp3-comp.c   |    3 +-
 .../media/platform/mediatek/mdp3/mtk-mdp3-core.c   |    7 +-
 .../platform/mediatek/vcodec/mtk_vcodec_dec_pm.c   |    6 +-
 .../platform/mediatek/vcodec/venc/venc_h264_if.c   |    4 +-
 .../media/platform/microchip/microchip-isc-base.c  |  109 +-
 drivers/media/platform/nxp/dw100/dw100.c           |    2 +-
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c     |   35 +-
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h     |    4 +-
 drivers/media/platform/nxp/imx-mipi-csis.c         |  252 +-
 drivers/media/platform/nxp/imx-pxp.c               |  359 ++-
 drivers/media/platform/nxp/imx7-media-csi.c        |  239 +-
 .../platform/qcom/camss/camss-csiphy-3ph-1-0.c     |    3 +-
 .../media/platform/renesas/rzg2l-cru/rzg2l-csi2.c  |    2 +-
 .../media/platform/renesas/rzg2l-cru/rzg2l-video.c |    2 +-
 .../platform/rockchip/rkisp1/rkisp1-capture.c      |   15 +-
 .../media/platform/samsung/exynos4-is/fimc-is.h    |    3 -
 .../media/platform/samsung/exynos4-is/media-dev.h  |    1 -
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c   |    4 +-
 drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c |    1 +
 drivers/media/platform/sunxi/sun4i-csi/sun4i_dma.c |    4 +-
 drivers/media/platform/ti/cal/cal.c                |    4 +-
 drivers/media/platform/ti/davinci/vpbe_display.c   |    2 +-
 drivers/media/platform/ti/davinci/vpbe_osd.c       |    6 -
 drivers/media/platform/ti/davinci/vpbe_venc.c      |    6 -
 drivers/media/platform/ti/davinci/vpif.c           |    2 +-
 drivers/media/platform/ti/omap3isp/isp.c           |    9 +
 drivers/media/platform/ti/omap3isp/ispvideo.c      |   20 +-
 drivers/media/platform/verisilicon/hantro_drv.c    |    2 -
 drivers/media/platform/verisilicon/hantro_v4l2.c   |    9 +-
 drivers/media/platform/xilinx/xilinx-dma.c         |   28 +-
 drivers/media/radio/wl128x/fmdrv_common.c          |    2 +-
 drivers/media/rc/Kconfig                           |    4 +-
 drivers/media/rc/ene_ir.c                          |    3 +-
 drivers/media/rc/gpio-ir-recv.c                    |   18 +
 drivers/media/rc/ir-rx51.c                         |    6 -
 drivers/media/rc/pwm-ir-tx.c                       |    2 +-
 drivers/media/test-drivers/vidtv/vidtv_psi.c       |    2 +-
 drivers/media/test-drivers/visl/visl-video.c       |    2 +-
 drivers/media/tuners/si2157.c                      |    6 +-
 drivers/media/usb/dvb-usb-v2/af9015.c              |    4 +-
 drivers/media/usb/go7007/go7007-v4l2.c             |    6 +-
 drivers/media/usb/siano/smsusb.c                   |    1 +
 drivers/media/usb/uvc/uvc_ctrl.c                   |  340 ++-
 drivers/media/usb/uvc/uvc_driver.c                 |  181 +-
 drivers/media/usb/uvc/uvc_entity.c                 |    2 +-
 drivers/media/usb/uvc/uvc_status.c                 |  125 +-
 drivers/media/usb/uvc/uvc_v4l2.c                   |  111 +-
 drivers/media/usb/uvc/uvc_video.c                  |   58 +-
 drivers/media/usb/uvc/uvcvideo.h                   |   39 +-
 drivers/media/v4l2-core/v4l2-h264.c                |    4 +
 drivers/media/v4l2-core/v4l2-ioctl.c               |   25 +-
 drivers/media/v4l2-core/v4l2-jpeg.c                |    4 +-
 drivers/media/v4l2-core/v4l2-mem2mem.c             |    4 +-
 drivers/media/v4l2-core/v4l2-subdev.c              | 1017 +++++++-
 drivers/staging/media/Kconfig                      |   10 +-
 drivers/staging/media/Makefile                     |    9 +-
 drivers/staging/media/atomisp/Kconfig              |    2 +-
 drivers/staging/media/atomisp/i2c/atomisp-gc0310.c |  249 --
 drivers/staging/media/atomisp/i2c/atomisp-gc2235.c |  176 --
 .../staging/media/atomisp/i2c/atomisp-mt9m114.c    |  206 --
 drivers/staging/media/atomisp/i2c/atomisp-ov2680.c | 1280 ++++------
 drivers/staging/media/atomisp/i2c/atomisp-ov2722.c |  195 +-
 drivers/staging/media/atomisp/i2c/gc0310.h         |   10 -
 drivers/staging/media/atomisp/i2c/gc2235.h         |   31 -
 drivers/staging/media/atomisp/i2c/mt9m114.h        |   15 -
 drivers/staging/media/atomisp/i2c/ov2680.h         |  836 +------
 drivers/staging/media/atomisp/i2c/ov2722.h         |   36 +-
 .../media/atomisp/i2c/ov5693/atomisp-ov5693.c      |  195 --
 drivers/staging/media/atomisp/i2c/ov5693/ov5693.h  |   61 -
 .../staging/media/atomisp/include/linux/atomisp.h  |   50 -
 .../atomisp/include/linux/atomisp_gmin_platform.h  |    2 -
 .../media/atomisp/include/linux/atomisp_platform.h |   11 +-
 drivers/staging/media/atomisp/notes.txt            |    6 -
 drivers/staging/media/atomisp/pci/atomisp_cmd.c    |   90 +-
 drivers/staging/media/atomisp/pci/atomisp_cmd.h    |    9 +-
 drivers/staging/media/atomisp/pci/atomisp_csi2.c   |   41 +-
 drivers/staging/media/atomisp/pci/atomisp_csi2.h   |    5 -
 drivers/staging/media/atomisp/pci/atomisp_fops.c   |   89 +-
 drivers/staging/media/atomisp/pci/atomisp_fops.h   |    3 +-
 .../media/atomisp/pci/atomisp_gmin_platform.c      |  120 +-
 .../staging/media/atomisp/pci/atomisp_internal.h   |    7 +-
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c  |   60 +-
 drivers/staging/media/atomisp/pci/atomisp_subdev.c |  171 +-
 drivers/staging/media/atomisp/pci/atomisp_subdev.h |   13 -
 drivers/staging/media/atomisp/pci/atomisp_tpg.c    |    2 +-
 drivers/staging/media/atomisp/pci/atomisp_v4l2.c   |  165 +-
 .../pci/css_2401_system/host/isys_dma_private.h    |    2 -
 .../atomisp/pci/hive_isp_css_common/host/vmem.c    |   20 +-
 drivers/staging/media/atomisp/pci/sh_css.c         |    7 +-
 drivers/staging/media/atomisp/pci/sh_css_params.c  |   38 +-
 .../media/{deprecated/saa7146 =3D> }/av7110/Kconfig  |   20 +-
 .../media/{deprecated/saa7146 =3D> }/av7110/Makefile |    3 +-
 drivers/staging/media/av7110/TODO                  |    3 +
 .../av7110/audio-bilingual-channel-select.rst      |    0
 .../saa7146 =3D> }/av7110/audio-channel-select.rst   |    0
 .../saa7146 =3D> }/av7110/audio-clear-buffer.rst     |    0
 .../saa7146 =3D> }/av7110/audio-continue.rst         |    0
 .../saa7146 =3D> }/av7110/audio-fclose.rst           |    0
 .../saa7146 =3D> }/av7110/audio-fopen.rst            |    0
 .../saa7146 =3D> }/av7110/audio-fwrite.rst           |    0
 .../saa7146 =3D> }/av7110/audio-get-capabilities.rst |    0
 .../saa7146 =3D> }/av7110/audio-get-status.rst       |    0
 .../saa7146 =3D> }/av7110/audio-pause.rst            |    0
 .../{deprecated/saa7146 =3D> }/av7110/audio-play.rst |    0
 .../saa7146 =3D> }/av7110/audio-select-source.rst    |    0
 .../saa7146 =3D> }/av7110/audio-set-av-sync.rst      |    0
 .../saa7146 =3D> }/av7110/audio-set-bypass-mode.rst  |    0
 .../saa7146 =3D> }/av7110/audio-set-id.rst           |    0
 .../saa7146 =3D> }/av7110/audio-set-mixer.rst        |    0
 .../saa7146 =3D> }/av7110/audio-set-mute.rst         |    0
 .../saa7146 =3D> }/av7110/audio-set-streamtype.rst   |    0
 .../{deprecated/saa7146 =3D> }/av7110/audio-stop.rst |    0
 .../{deprecated/saa7146 =3D> }/av7110/audio.rst      |    0
 .../saa7146 =3D> }/av7110/audio_data_types.rst       |    0
 .../saa7146 =3D> }/av7110/audio_function_calls.rst   |    0
 .../media/{deprecated/saa7146 =3D> }/av7110/av7110.c |    0
 .../media/{deprecated/saa7146 =3D> }/av7110/av7110.h |    2 +-
 .../{deprecated/saa7146 =3D> }/av7110/av7110_av.c    |    0
 .../{deprecated/saa7146 =3D> }/av7110/av7110_av.h    |    0
 .../{deprecated/saa7146 =3D> }/av7110/av7110_ca.c    |    0
 .../{deprecated/saa7146 =3D> }/av7110/av7110_ca.h    |    0
 .../{deprecated/saa7146 =3D> }/av7110/av7110_hw.c    |    0
 .../{deprecated/saa7146 =3D> }/av7110/av7110_hw.h    |    0
 .../{deprecated/saa7146 =3D> }/av7110/av7110_ipack.c |    0
 .../{deprecated/saa7146 =3D> }/av7110/av7110_ipack.h |    0
 .../{deprecated/saa7146 =3D> }/av7110/av7110_ir.c    |    0
 .../{deprecated/saa7146 =3D> }/av7110/av7110_v4l.c   |    0
 .../{deprecated/saa7146 =3D> }/av7110/budget-patch.c |    0
 .../{deprecated/saa7146 =3D> }/av7110/dvb_filter.c   |    0
 .../{deprecated/saa7146 =3D> }/av7110/dvb_filter.h   |    0
 .../media/{deprecated/saa7146 =3D> }/av7110/sp8870.c |    0
 .../media/{deprecated/saa7146 =3D> }/av7110/sp8870.h |    0
 .../saa7146 =3D> }/av7110/video-clear-buffer.rst     |    0
 .../saa7146 =3D> }/av7110/video-command.rst          |    0
 .../saa7146 =3D> }/av7110/video-continue.rst         |    0
 .../saa7146 =3D> }/av7110/video-fast-forward.rst     |    0
 .../saa7146 =3D> }/av7110/video-fclose.rst           |    0
 .../saa7146 =3D> }/av7110/video-fopen.rst            |    0
 .../saa7146 =3D> }/av7110/video-freeze.rst           |    0
 .../saa7146 =3D> }/av7110/video-fwrite.rst           |    0
 .../saa7146 =3D> }/av7110/video-get-capabilities.rst |    0
 .../saa7146 =3D> }/av7110/video-get-event.rst        |    0
 .../saa7146 =3D> }/av7110/video-get-frame-count.rst  |    0
 .../saa7146 =3D> }/av7110/video-get-pts.rst          |    0
 .../saa7146 =3D> }/av7110/video-get-size.rst         |    0
 .../saa7146 =3D> }/av7110/video-get-status.rst       |    0
 .../{deprecated/saa7146 =3D> }/av7110/video-play.rst |    0
 .../saa7146 =3D> }/av7110/video-select-source.rst    |    0
 .../saa7146 =3D> }/av7110/video-set-blank.rst        |    0
 .../av7110/video-set-display-format.rst            |    0
 .../saa7146 =3D> }/av7110/video-set-format.rst       |    0
 .../saa7146 =3D> }/av7110/video-set-streamtype.rst   |    0
 .../saa7146 =3D> }/av7110/video-slowmotion.rst       |    0
 .../saa7146 =3D> }/av7110/video-stillpicture.rst     |    0
 .../{deprecated/saa7146 =3D> }/av7110/video-stop.rst |    0
 .../saa7146 =3D> }/av7110/video-try-command.rst      |    0
 .../{deprecated/saa7146 =3D> }/av7110/video.rst      |    0
 .../saa7146 =3D> }/av7110/video_function_calls.rst   |    0
 .../saa7146 =3D> }/av7110/video_types.rst            |    0
 drivers/staging/media/deprecated/cpia2/Kconfig     |   13 -
 drivers/staging/media/deprecated/cpia2/Makefile    |    4 -
 drivers/staging/media/deprecated/cpia2/TODO        |    6 -
 drivers/staging/media/deprecated/cpia2/cpia2.h     |  475 ----
 .../staging/media/deprecated/cpia2/cpia2_core.c    | 2434 ----------------=
----
 .../media/deprecated/cpia2/cpia2_registers.h       |  463 ----
 drivers/staging/media/deprecated/cpia2/cpia2_usb.c |  966 --------
 drivers/staging/media/deprecated/cpia2/cpia2_v4l.c | 1226 ----------
 drivers/staging/media/deprecated/fsl-viu/Kconfig   |   15 -
 drivers/staging/media/deprecated/fsl-viu/Makefile  |    2 -
 drivers/staging/media/deprecated/fsl-viu/TODO      |    7 -
 drivers/staging/media/deprecated/fsl-viu/fsl-viu.c | 1599 -------------
 drivers/staging/media/deprecated/meye/Kconfig      |   19 -
 drivers/staging/media/deprecated/meye/Makefile     |    2 -
 drivers/staging/media/deprecated/meye/TODO         |    6 -
 drivers/staging/media/deprecated/meye/meye.c       | 1814 ---------------
 drivers/staging/media/deprecated/meye/meye.h       |  311 ---
 drivers/staging/media/deprecated/saa7146/Kconfig   |    5 -
 drivers/staging/media/deprecated/saa7146/Makefile  |    2 -
 .../staging/media/deprecated/saa7146/av7110/TODO   |    9 -
 .../staging/media/deprecated/saa7146/saa7146/TODO  |    7 -
 .../staging/media/deprecated/saa7146/ttpci/TODO    |    7 -
 drivers/staging/media/deprecated/stkwebcam/Kconfig |   18 -
 .../staging/media/deprecated/stkwebcam/Makefile    |    5 -
 drivers/staging/media/deprecated/stkwebcam/TODO    |   12 -
 .../media/deprecated/stkwebcam/stk-sensor.c        |  587 -----
 .../media/deprecated/stkwebcam/stk-webcam.c        | 1434 ------------
 .../media/deprecated/stkwebcam/stk-webcam.h        |  123 -
 drivers/staging/media/deprecated/tm6000/Kconfig    |   37 -
 drivers/staging/media/deprecated/tm6000/Makefile   |   14 -
 drivers/staging/media/deprecated/tm6000/TODO       |    7 -
 .../staging/media/deprecated/tm6000/tm6000-alsa.c  |  440 ----
 .../staging/media/deprecated/tm6000/tm6000-cards.c | 1397 -----------
 .../staging/media/deprecated/tm6000/tm6000-core.c  |  916 --------
 .../staging/media/deprecated/tm6000/tm6000-dvb.c   |  454 ----
 .../staging/media/deprecated/tm6000/tm6000-i2c.c   |  317 ---
 .../staging/media/deprecated/tm6000/tm6000-input.c |  503 ----
 .../staging/media/deprecated/tm6000/tm6000-regs.h  |  588 -----
 .../staging/media/deprecated/tm6000/tm6000-stds.c  |  623 -----
 .../media/deprecated/tm6000/tm6000-usb-isoc.h      |   38 -
 .../staging/media/deprecated/tm6000/tm6000-video.c | 1703 --------------
 drivers/staging/media/deprecated/tm6000/tm6000.h   |  396 ----
 .../staging/media/deprecated/vpfe_capture/Kconfig  |   58 -
 .../staging/media/deprecated/vpfe_capture/Makefile |    4 -
 drivers/staging/media/deprecated/vpfe_capture/TODO |    7 -
 .../media/deprecated/vpfe_capture/ccdc_hw_device.h |   80 -
 .../media/deprecated/vpfe_capture/dm355_ccdc.c     |  934 --------
 .../media/deprecated/vpfe_capture/dm355_ccdc.h     |  308 ---
 .../deprecated/vpfe_capture/dm355_ccdc_regs.h      |  297 ---
 .../media/deprecated/vpfe_capture/dm644x_ccdc.c    |  879 -------
 .../media/deprecated/vpfe_capture/dm644x_ccdc.h    |  171 --
 .../deprecated/vpfe_capture/dm644x_ccdc_regs.h     |  140 --
 .../staging/media/deprecated/vpfe_capture/isif.c   | 1127 ---------
 .../staging/media/deprecated/vpfe_capture/isif.h   |  518 -----
 .../media/deprecated/vpfe_capture/isif_regs.h      |  256 --
 .../media/deprecated/vpfe_capture/vpfe_capture.c   | 1902 ---------------
 drivers/staging/media/deprecated/zr364xx/Kconfig   |   18 -
 drivers/staging/media/deprecated/zr364xx/Makefile  |    3 -
 drivers/staging/media/deprecated/zr364xx/TODO      |    7 -
 drivers/staging/media/deprecated/zr364xx/zr364xx.c | 1635 -------------
 drivers/staging/media/imx/imx-media-csi.c          |    7 +-
 drivers/staging/media/imx/imx-media-fim.c          |   13 +-
 drivers/staging/media/imx/imx-media.h              |    6 +-
 drivers/staging/media/meson/vdec/esparser.c        |    3 +-
 drivers/staging/media/omap4iss/iss_video.c         |   66 +-
 include/media/davinci/ccdc_types.h                 |   30 -
 .../common =3D> include/media/drv-intf}/saa7146.h    |    0
 .../common =3D> include/media/drv-intf}/saa7146_vv.h |    2 +-
 include/media/i2c/s5c73m3.h                        |   41 -
 include/media/media-entity.h                       |  102 +-
 include/media/ov_16bit_addr_reg_helpers.h          |   92 +
 include/media/v4l2-subdev.h                        |  377 +++
 include/uapi/linux/meye.h                          |   65 -
 include/uapi/linux/uvcvideo.h                      |    6 +-
 include/uapi/linux/v4l2-controls.h                 |    8 +-
 include/uapi/linux/v4l2-subdev.h                   |   74 +-
 366 files changed, 11573 insertions(+), 33748 deletions(-)
 delete mode 100644 Documentation/admin-guide/media/cpia2.rst
 delete mode 100644 Documentation/admin-guide/media/meye.rst
 delete mode 100644 Documentation/admin-guide/media/tm6000-cardlist.rst
 delete mode 100644 Documentation/admin-guide/media/zr364xx.rst
 delete mode 100644 Documentation/devicetree/bindings/media/cec-gpio.txt
 delete mode 100644 Documentation/devicetree/bindings/media/cec.txt
 rename Documentation/devicetree/bindings/media/{ =3D> cec}/amlogic,meson-g=
x-ao-cec.yaml (86%)
 create mode 100644 Documentation/devicetree/bindings/media/cec/cec-common.=
yaml
 create mode 100644 Documentation/devicetree/bindings/media/cec/cec-gpio.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/media/cec/nvidia,tegr=
a114-cec.yaml
 create mode 100644 Documentation/devicetree/bindings/media/cec/samsung,s5p=
-cec.yaml
 create mode 100644 Documentation/devicetree/bindings/media/cec/st,stih-cec=
.yaml
 create mode 100644 Documentation/devicetree/bindings/media/cec/st,stm32-ce=
c.yaml
 create mode 100644 Documentation/devicetree/bindings/media/fsl,imx6ull-pxp=
.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/fsl-pxp.txt
 delete mode 100644 Documentation/devicetree/bindings/media/i2c/ak7375.txt
 create mode 100644 Documentation/devicetree/bindings/media/i2c/asahi-kasei=
,ak7375.yaml
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5670=
.yaml
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5675=
.yaml
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov8858=
.yaml
 create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx296=
.yaml
 create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx415=
.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/s5p-cec.txt
 delete mode 100644 Documentation/devicetree/bindings/media/stih-cec.txt
 delete mode 100644 Documentation/devicetree/bindings/media/tegra-cec.txt
 delete mode 100644 Documentation/driver-api/media/drivers/cpia2_devel.rst
 delete mode 100644 Documentation/userspace-api/media/drivers/meye-uapi.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-subdev-g-r=
outing.rst
 rename drivers/{staging/media/deprecated/saa7146/common =3D> media/common/=
saa7146}/Kconfig (100%)
 rename drivers/{staging/media/deprecated/saa7146/common =3D> media/common/=
saa7146}/Makefile (100%)
 rename drivers/{staging/media/deprecated/saa7146/common =3D> media/common/=
saa7146}/saa7146_core.c (99%)
 rename drivers/{staging/media/deprecated/saa7146/common =3D> media/common/=
saa7146}/saa7146_fops.c (99%)
 rename drivers/{staging/media/deprecated/saa7146/common =3D> media/common/=
saa7146}/saa7146_hlp.c (99%)
 rename drivers/{staging/media/deprecated/saa7146/common =3D> media/common/=
saa7146}/saa7146_i2c.c (99%)
 rename drivers/{staging/media/deprecated/saa7146/common =3D> media/common/=
saa7146}/saa7146_vbi.c (99%)
 rename drivers/{staging/media/deprecated/saa7146/common =3D> media/common/=
saa7146}/saa7146_video.c (99%)
 create mode 100644 drivers/media/i2c/imx296.c
 create mode 100644 drivers/media/i2c/imx415.c
 create mode 100644 drivers/media/i2c/ov8858.c
 rename drivers/{staging/media/deprecated/saa7146 =3D> media/pci}/saa7146/K=
config (67%)
 rename drivers/{staging/media/deprecated/saa7146 =3D> media/pci}/saa7146/M=
akefile (100%)
 rename drivers/{staging/media/deprecated/saa7146 =3D> media/pci}/saa7146/h=
exium_gemini.c (99%)
 rename drivers/{staging/media/deprecated/saa7146 =3D> media/pci}/saa7146/h=
exium_orion.c (99%)
 rename drivers/{staging/media/deprecated/saa7146 =3D> media/pci}/saa7146/m=
xb.c (99%)
 rename drivers/{staging/media/deprecated/saa7146 =3D> media/pci}/ttpci/Kco=
nfig (83%)
 rename drivers/{staging/media/deprecated/saa7146 =3D> media/pci}/ttpci/Mak=
efile (100%)
 rename drivers/{staging/media/deprecated/saa7146 =3D> media/pci}/ttpci/bud=
get-av.c (99%)
 rename drivers/{staging/media/deprecated/saa7146 =3D> media/pci}/ttpci/bud=
get-ci.c (100%)
 rename drivers/{staging/media/deprecated/saa7146 =3D> media/pci}/ttpci/bud=
get-core.c (100%)
 rename drivers/{staging/media/deprecated/saa7146 =3D> media/pci}/ttpci/bud=
get.c (100%)
 rename drivers/{staging/media/deprecated/saa7146 =3D> media/pci}/ttpci/bud=
get.h (98%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/Kconfig (82=
%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/Makefile (7=
8%)
 create mode 100644 drivers/staging/media/av7110/TODO
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/audio-bilin=
gual-channel-select.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/audio-chann=
el-select.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/audio-clear=
-buffer.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/audio-conti=
nue.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/audio-fclos=
e.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/audio-fopen=
.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/audio-fwrit=
e.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/audio-get-c=
apabilities.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/audio-get-s=
tatus.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/audio-pause=
.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/audio-play.=
rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/audio-selec=
t-source.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/audio-set-a=
v-sync.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/audio-set-b=
ypass-mode.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/audio-set-i=
d.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/audio-set-m=
ixer.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/audio-set-m=
ute.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/audio-set-s=
treamtype.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/audio-stop.=
rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/audio.rst (=
100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/audio_data_=
types.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/audio_funct=
ion_calls.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/av7110.c (1=
00%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/av7110.h (9=
9%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/av7110_av.c=
 (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/av7110_av.h=
 (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/av7110_ca.c=
 (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/av7110_ca.h=
 (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/av7110_hw.c=
 (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/av7110_hw.h=
 (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/av7110_ipac=
k.c (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/av7110_ipac=
k.h (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/av7110_ir.c=
 (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/av7110_v4l.=
c (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/budget-patc=
h.c (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/dvb_filter.=
c (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/dvb_filter.=
h (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/sp8870.c (1=
00%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/sp8870.h (1=
00%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/video-clear=
-buffer.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/video-comma=
nd.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/video-conti=
nue.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/video-fast-=
forward.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/video-fclos=
e.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/video-fopen=
.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/video-freez=
e.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/video-fwrit=
e.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/video-get-c=
apabilities.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/video-get-e=
vent.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/video-get-f=
rame-count.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/video-get-p=
ts.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/video-get-s=
ize.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/video-get-s=
tatus.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/video-play.=
rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/video-selec=
t-source.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/video-set-b=
lank.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/video-set-d=
isplay-format.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/video-set-f=
ormat.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/video-set-s=
treamtype.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/video-slowm=
otion.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/video-still=
picture.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/video-stop.=
rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/video-try-c=
ommand.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/video.rst (=
100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/video_funct=
ion_calls.rst (100%)
 rename drivers/staging/media/{deprecated/saa7146 =3D> }/av7110/video_types=
.rst (100%)
 delete mode 100644 drivers/staging/media/deprecated/cpia2/Kconfig
 delete mode 100644 drivers/staging/media/deprecated/cpia2/Makefile
 delete mode 100644 drivers/staging/media/deprecated/cpia2/TODO
 delete mode 100644 drivers/staging/media/deprecated/cpia2/cpia2.h
 delete mode 100644 drivers/staging/media/deprecated/cpia2/cpia2_core.c
 delete mode 100644 drivers/staging/media/deprecated/cpia2/cpia2_registers.h
 delete mode 100644 drivers/staging/media/deprecated/cpia2/cpia2_usb.c
 delete mode 100644 drivers/staging/media/deprecated/cpia2/cpia2_v4l.c
 delete mode 100644 drivers/staging/media/deprecated/fsl-viu/Kconfig
 delete mode 100644 drivers/staging/media/deprecated/fsl-viu/Makefile
 delete mode 100644 drivers/staging/media/deprecated/fsl-viu/TODO
 delete mode 100644 drivers/staging/media/deprecated/fsl-viu/fsl-viu.c
 delete mode 100644 drivers/staging/media/deprecated/meye/Kconfig
 delete mode 100644 drivers/staging/media/deprecated/meye/Makefile
 delete mode 100644 drivers/staging/media/deprecated/meye/TODO
 delete mode 100644 drivers/staging/media/deprecated/meye/meye.c
 delete mode 100644 drivers/staging/media/deprecated/meye/meye.h
 delete mode 100644 drivers/staging/media/deprecated/saa7146/Kconfig
 delete mode 100644 drivers/staging/media/deprecated/saa7146/Makefile
 delete mode 100644 drivers/staging/media/deprecated/saa7146/av7110/TODO
 delete mode 100644 drivers/staging/media/deprecated/saa7146/saa7146/TODO
 delete mode 100644 drivers/staging/media/deprecated/saa7146/ttpci/TODO
 delete mode 100644 drivers/staging/media/deprecated/stkwebcam/Kconfig
 delete mode 100644 drivers/staging/media/deprecated/stkwebcam/Makefile
 delete mode 100644 drivers/staging/media/deprecated/stkwebcam/TODO
 delete mode 100644 drivers/staging/media/deprecated/stkwebcam/stk-sensor.c
 delete mode 100644 drivers/staging/media/deprecated/stkwebcam/stk-webcam.c
 delete mode 100644 drivers/staging/media/deprecated/stkwebcam/stk-webcam.h
 delete mode 100644 drivers/staging/media/deprecated/tm6000/Kconfig
 delete mode 100644 drivers/staging/media/deprecated/tm6000/Makefile
 delete mode 100644 drivers/staging/media/deprecated/tm6000/TODO
 delete mode 100644 drivers/staging/media/deprecated/tm6000/tm6000-alsa.c
 delete mode 100644 drivers/staging/media/deprecated/tm6000/tm6000-cards.c
 delete mode 100644 drivers/staging/media/deprecated/tm6000/tm6000-core.c
 delete mode 100644 drivers/staging/media/deprecated/tm6000/tm6000-dvb.c
 delete mode 100644 drivers/staging/media/deprecated/tm6000/tm6000-i2c.c
 delete mode 100644 drivers/staging/media/deprecated/tm6000/tm6000-input.c
 delete mode 100644 drivers/staging/media/deprecated/tm6000/tm6000-regs.h
 delete mode 100644 drivers/staging/media/deprecated/tm6000/tm6000-stds.c
 delete mode 100644 drivers/staging/media/deprecated/tm6000/tm6000-usb-isoc=
.h
 delete mode 100644 drivers/staging/media/deprecated/tm6000/tm6000-video.c
 delete mode 100644 drivers/staging/media/deprecated/tm6000/tm6000.h
 delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/Kconfig
 delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/Makefile
 delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/TODO
 delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/ccdc_hw_d=
evice.h
 delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/dm355_ccd=
c.c
 delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/dm355_ccd=
c.h
 delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/dm355_ccd=
c_regs.h
 delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/dm644x_cc=
dc.c
 delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/dm644x_cc=
dc.h
 delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/dm644x_cc=
dc_regs.h
 delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/isif.c
 delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/isif.h
 delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/isif_regs=
.h
 delete mode 100644 drivers/staging/media/deprecated/vpfe_capture/vpfe_capt=
ure.c
 delete mode 100644 drivers/staging/media/deprecated/zr364xx/Kconfig
 delete mode 100644 drivers/staging/media/deprecated/zr364xx/Makefile
 delete mode 100644 drivers/staging/media/deprecated/zr364xx/TODO
 delete mode 100644 drivers/staging/media/deprecated/zr364xx/zr364xx.c
 delete mode 100644 include/media/davinci/ccdc_types.h
 rename {drivers/staging/media/deprecated/saa7146/common =3D> include/media=
/drv-intf}/saa7146.h (100%)
 rename {drivers/staging/media/deprecated/saa7146/common =3D> include/media=
/drv-intf}/saa7146_vv.h (99%)
 delete mode 100644 include/media/i2c/s5c73m3.h
 create mode 100644 include/media/ov_16bit_addr_reg_helpers.h
 delete mode 100644 include/uapi/linux/meye.h

