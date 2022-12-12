Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59688649A59
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 09:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiLLItc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 03:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiLLIta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 03:49:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9F16473;
        Mon, 12 Dec 2022 00:49:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97A7960EB8;
        Mon, 12 Dec 2022 08:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71509C433D2;
        Mon, 12 Dec 2022 08:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670834965;
        bh=Sn5uyDKsq/wFPsZRsWe+kz4sArfNOv8PX5BVUx+yGZ0=;
        h=Date:From:To:Cc:Subject:From;
        b=NWClw6VTZPuLQlTA6nqOTZQQ2f4vKajzg2361sDJSynIlFXsYI5lEHcqJa7vQ/lSR
         HazfY0D6rsewjjDoc2V3IKB/0At0GgjD3onu2//+lWgXT6rlluSSrkmX4v9daf0VCS
         q9QluxwTMyBWwWoRzrNiHDeJcof+L+/F8rQw8SmtgOwtwceE2/Gz0fACa0hrUU3IQR
         0amwsm69Gbn7ahUdFJ8yZgBJgPLBkpka23GdCpIdDHV9fbfInuATHa3p5qxznjZ/Jj
         OkZ39/W2TiN96cGpuJ033vzvgLNVpWnoXaf6U4WkbjPP3aZneANSlu0qg4J2nklhLh
         oAAh+h6SGNtHw==
Date:   Mon, 12 Dec 2022 08:49:20 +0000
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v6.2-rc1] media updates
Message-ID: <20221212084920.756bfd7b@sal.lan>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
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
  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/me=
dia/v6.2-1

For:
  - some DVB core changes to avoid refcount troubles and UAF;
  - DVB API/core has gained support for DVB-C2 and DVB-S2X;
  - New sensor drivers: ov08x40, ov4689.c, st-vgxy61 and tc358746.c;
  - Removal of an unused sensor driver: s5k4ecgx;
  - Move microchip_csi2dc to a new directory, named after the manufacturer;
  - Add media controller support to Microship drivers;
  - Old Atmel/Microship drivers that don't use media controler got moved to
    staging;
  - New drivers added for Renesas RZ/G2L CRU and MIPI CSI-2 support;
  - Allwinner A31 camera sensor driver code was now split into a bridge and
    a separate processor driver;
  - Added a virtual stateless decoder driver in order to test core support
    for stateless drivers and test userspace apps using it;
  - removed platform-based support for ov9650, as this is not used anymore;
  - atomisp now uses videobuf2 and supports normal mmap mode;
  - the imx7-media-csi driver got promoted from staging;
  - rcar-vin driver has gained support for gen3 UDS (Up Down Scaler);
  - most i2c drivers now use I2C .probe_new() kAPI;
  - lots of drivers fixes, cleanups and improvements.

Thanks,
Mauro

---

The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/me=
dia/v6.2-1

for you to fetch changes up to 3178804c64ef7c8c87a53cd5bba0b2942dd64fec:

  Merge tag 'br-v6.2i' of git://linuxtv.org/hverkuil/media_tree into media_=
stage (2022-12-07 17:58:47 +0100)

----------------------------------------------------------------
media updates for v6.2-rc1

----------------------------------------------------------------
Aakarsh Jain (9):
      media: s5p-mfc: fix usage of symbolic permissions to octal
      media: s5p-mfc:fix usage of Block comment alignment
      media: s5p-mfc: Optimisation of code to remove error message
      media: s5p-mfc: fix usage of symbolic permissions to octal
      media: s5p-mfc:fix usage of Block comment alignment
      media: s5p-mfc: Optimisation of code to remove error message
      media: dt-bindings: s5p-mfc: Add new compatible string for Exynos3250=
 SoC
      media: s5p-mfc: Add variant data for MFC v7 hardware for Exynos 3250 =
SoC
      media: s5p-mfc: Add variant data for MFC v7 hardware for Exynos 3250 =
SoC

Adam Borowski (2):
      media: ipu3-cio2: make the bridge depend on i2c
      media: ipu3-cio2: make the bridge depend on i2c

Alexander Stein (2):
      media: dt-bindings: media: Add compatible for ov9281
      media: i2c: ov9282: Add ov9281 compatible

Andrzej Pietrasiewicz (1):
      media: rkvdec: Add required padding

Andy Shevchenko (11):
      media: c8sectpfe: Add missed header(s)
      media: subdev: Replace custom implementation of device_match_fwnode()
      media: staging: media: tegra-video: Replace custom implementation of =
device_match_fwnode()
      media: atomisp: Make bds_factors_list be type of struct u32_fract
      media: ov2740: Remove duplicative pointer in struct nvm_data
      media: ov2740: Switch from __maybe_unused to pm_sleep_ptr() etc
      media: ov2740: Remove duplicate check for NULL fwnode
      media: ov2740: Drop redundant assignments of ret =3D 0
      media: ov2740: Switch to use dev_err_probe()
      media: ov2740: Add missed \n to the end of the messages
      media: ov2740: Use traditional pattern when checking error codes

Baisong Zhong (1):
      media: dvb-usb: az6027: fix null-ptr-deref in az6027_i2c_xfer()

Benjamin Mugnier (10):
      media: v4l: Add 1X16 16-bit greyscale media bus code definition
      media: v4l: ctrls: Add a control for HDR mode
      media: dt-bindings: Add ST VGXY61 camera sensor binding
      media: Documentation: Add ST VGXY61 driver documentation
      media: i2c: Add driver for ST VGXY61 camera sensor
      media: i2c: st-vgxy61: Fix regulator counter underflow
      media: Documentation: st-vgxy61: Limit driver specific documentation =
to 80 characters
      media: Documentation: st-vgxy61: Remove quotes around 'No HDR' identi=
fier
      media: Documentation: st-vgxy61: Fix driver specific documentation no=
t being included in the index
      media: i2c: st-vgxy61: Fix smatch warnings

Bryan O'Donoghue (3):
      media: dt-bindings: imx412: Extend compatible strings
      media: i2c: imx412: Assign v4l2 device subname based on compat string
      media: i2c: imx412: Add new compatible strings

Chen Zhongjin (4):
      media: vidtv: Fix use-after-free in vidtv_bridge_dvb_init()
      media: vimc: Fix wrong function called when vimc_init() fails
      media: vidtv: Fix use-after-free in vidtv_bridge_dvb_init()
      media: dvb-core: Fix ignored return value in dvb_register_frontend()

Chen-Yu Tsai (1):
      media: dt-bindings: allwinner: h6-vpu-g2: Add IOMMU reference property

Christophe JAILLET (6):
      media: imx: imx7-media-csi: Remove a useless include
      media: i2c: aptina-pll: Remove a useless include
      media: pt3: Use dma_set_mask_and_coherent() and simplify code
      media: ths7303: Fix the include guard
      headers: Remove some left-over license text in include/uapi/linux/dvb/
      headers: Remove some left-over license text in include/uapi/linux/v4l=
2-*

Chuck Ritola (1):
      media: dvb-frontends: a8293: fix LNB powerup failure in PCTV 461e

Colin Ian King (12):
      media: atomisp: Fix spelling mistake "modee" -> "mode"
      media: mxl5005s: Make array RegAddr static const
      media: atomisp: Fix spelling mistake "mis-match" -> "mismatch"
      media: vivid: remove redundant assignment to variable checksum
      media: platform: s5p-mfc: Fix spelling mistake "mmaping" -> "mmapping"
      radio-terratec: Remove variable p
      media: saa7164: remove variable cnt
      media: rkisp1: make const arrays ae_wnd_num and hist_wnd_num static
      media: dvb-core: remove variable n, turn for-loop to while-loop
      media: dvbdev: remove redundant initialization of variable ret
      media: dvb-usb: m920x: make read-only arrays static const
      media: i2c: isl7998x: make const array isl7998x_video_in_chan_map sta=
tic

Dafna Hirschfeld (2):
      media: vimc: Update device configuration in the documentation
      media: vimc: Update device configuration in the documentation

Dan Carpenter (1):
      media: rzg2l-cru: fix a test for timeout

Daniel Almeida (2):
      media: visl: add virtual stateless decoder driver
      media: visl: add virtual stateless decoder driver

Dave Stevenson (26):
      media: i2c: ov9282: Remove duplication of registers
      media: i2c: ov9282: Split registers into common and mode specific
      media: i2c: ov9282: Remove format code from the mode
      media: i2c: ov9282: Remove pixel rate from mode definition
      media: i2c: ov9282: Support more than 1 mode.
      media: i2c: ov9282: Correct HTS register for configured pixel rate
      media: i2c: ov9282: Reduce vblank_min values based on testing
      media: i2c: ov9282: Add selection for CSI2 clock mode
      media: i2c: ov9282: Add the properties from fwnode
      media: i2c: ov9282: Action CID_VBLANK when set.
      media: i2c: ov9282: Add HFLIP and VFLIP support
      media: i2c: ov9282: Make V4L2_CID_HBLANK r/w
      media: i2c: ov9282: Add selection API calls for cropping info
      media: i2c: ov9282: Add support for 1280x800 and 640x400 modes
      media: i2c: ov9282: Add support for 8bit readout
      media: i2c: ov9282: Support event handlers
      media: dt-bindings: media: ovti,ov9282: Add optional regulators
      media: i2c: ov9282: Add support for regulators.
      media: i2c: ov2680: Set V4L2_CTRL_FLAG_MODIFY_LAYOUT on flips
      media: i2c: imx208: Set V4L2_CTRL_FLAG_MODIFY_LAYOUT on flips
      media: i2c: imx319: Set V4L2_CTRL_FLAG_MODIFY_LAYOUT on flips
      media: i2c: imx355: Set V4L2_CTRL_FLAG_MODIFY_LAYOUT on flips
      media: i2c: ov08d10: Set V4L2_CTRL_FLAG_MODIFY_LAYOUT on flips
      media: i2c: ov9282: Fix missing documentation in structures
      media: i2c: ov9282: Make common_regs_list static
      media: i2c: ov9282: Add missing clk_disable_unprepare to error path

Deepak R Varma (2):
      staging: media: meson: vdec: use min() for comparison and assignment
      media: staging: media: meson: vdec: use min() for comparison and assi=
gnment

Deming Wang (1):
      media: vivid.rst: fix TV and S-Video Inputs section

Dmitry Torokhov (2):
      media: i2c: s5k6a3: switch to using gpiod API
      media: i2c: s5k5baf: switch to using gpiod API

Eugen Hristev (12):
      media: atmel: move microchip_csi2dc to dedicated microchip platform
      media: microchip: add ISC driver as Microchip ISC
      media: microchip: microchip-isc: prepare for media controller support
      media: microchip: microchip-isc: implement media controller
      media: microchip: microchip-isc: move media_pipeline_* to (un)prepare=
 cb
      media: atmel: atmel-isc: move to staging
      media: atmel: move microchip_csi2dc to dedicated microchip platform
      media: microchip: add ISC driver as Microchip ISC
      media: microchip: microchip-isc: prepare for media controller support
      media: microchip: microchip-isc: implement media controller
      media: microchip: microchip-isc: move media_pipeline_* to (un)prepare=
 cb
      media: atmel: atmel-isc: move to staging

Gaosheng Cui (8):
      media: dvb-frontends: remove unused drx_dap_fasi_funct_g declaration
      media: cxd2820r: remove unused cxd2820r_debug declaration
      media: saa7134: remove unused declarations in saa7134.h
      saa7164: remove unused saa7164_call_i2c_clients declaration
      cx25821: remove unused cx25821_video_wakeup() declaration
      bttv: remove unused tea5757_set_freq declaration
      media: zoran: remove unused declarations in zoran_device.h
      media: dib0700: remove orphan dvb_usb_dib0700_ir_proto declaration

Gautam Menghani (1):
      media: imon: fix a race condition in send_packet()

Geert Uytterhoeven (2):
      media: dvb_ringbuffer: Fix typo in dvb_ringbuffer_pkt_write() kerneld=
oc
      media: staging: stkwebcam: Restore MEDIA_{USB,CAMERA}_SUPPORT depende=
ncies

Guoniu.zhou (2):
      media: ov5640: set correct default link frequency
      media: ov5640: report correct frame rate to user

Gustavo A. R. Silva (1):
      media: usb: pwc-uncompress: Use flex array destination for memcpy()

Hans Verkuil (15):
      videodev2.h: add p_s32 and p_s64 pointers
      vivid: add INTEGER and INTEGER64 test control arrays
      media: meson/vdec: always init coef_node_start
      atomisp: fix potential NULL pointer dereferences
      media: admin-guide: cec.rst
      vb2: add (un)prepare_streaming queue ops
      vb2/au0828: move the v4l_vb2q_enable_media_source to the au0828 driver
      media: admin-guide: cec.rst
      media: vb2: add (un)prepare_streaming queue ops
      media: vb2/au0828: move the v4l_vb2q_enable_media_source to the au082=
8 driver
      media: videobuf2: revert "get_userptr: buffers are always writable"
      media: media/frontend.h.rst.exceptions: add exceptions for new dvb de=
fines
      media: dvb-frontends: drx39xyj: set missing error code
      media: i2c: tc358746: make DEFINE_RUNTIME_DEV_PM_OPS static
      media: sun6i-csi: clarify return value, fix uninited variable and add=
 missing static

Hans de Goede (40):
      media: atomisp: Add hmm_create_from_vmalloc_buf() function
      media: atomisp: Add ia_css_frame_init_from_info() function
      media: atomisp: Make atomisp_q_video_buffers_to_css() static
      media: atomisp: On streamoff wait for buffers owned by the CSS to be =
given back
      media: atomisp: Remove unused atomisp_buffers_queued[_pipe] functions
      media: atomisp: Also track buffers in a list when submitted to the ISP
      media: atomisp: Add an index helper variable to atomisp_buf_done()
      media: atomisp: Use new atomisp_flush_video_pipe() helper in atomisp_=
streamoff()
      media: atomisp: Add ia_css_frame_get_info() helper
      media: atomisp: Convert to videobuf2
      media: atomisp: Make it possible to call atomisp_set_fmt() without a =
file handle
      media: atomisp: Fix VIDIOC_REQBUFS failing when VIDIOC_S_FMT has not =
been called yet
      media: atomisp: Refactor atomisp_adjust_fmt()
      media: atomisp: Fix atomisp_try_fmt_cap() always returning YUV420 pix=
elformat
      media: atomisp: Make atomisp_g_fmt_cap() default to YUV420
      media: atomisp: Remove __atomisp_get_pipe() helper
      media: atomisp: gc0310: Power on sensor from set_fmt() callback
      media: atomisp: Silence: 'atomisp_q_one_s3a_buffer: drop one s3a stat=
 which has exp_id xx' log messages
      media: atomisp: Remove accelerator pipe creation code
      media: atomisp: Remove unused QOS defines / structure member
      media: atomisp: Flush queue on atomisp_css_start() error
      media: atomisp: Log an error on failing to alloc private-mem
      media: atomisp: Fix deadlock when the /dev/video# node is closed whil=
e still streaming
      media: atomisp: Remove 2 unused accelerator mode related functions
      media: atomisp: Remove atomisp_css_yuvpp_configure_viewfinder() funct=
ion
      media: atomisp: Remove unused ia_css_frame_*() functions
      media: atomisp: Drop userptr support from hmm
      media: atomisp: Remove double atomisp_mrfld_power_down()/_up() calls =
from atomisp_reset()
      media: atomisp: Remove atomisp_mrfld_power_down()/_up()
      media: atomisp: Remove clearing of config from atomisp_css_uninit()
      media: atomisp: Remove atomisp_css_suspend()/_resume()
      media: atomisp: Remove sw_contex.power_state checks
      media: atomisp: Remove duplication between runtime-pm and normal-pm c=
ode
      media: atomisp: Move calling of css_[un]init() to power_on()/_off()
      media: atomisp: Remove atomisp_ospm_dphy_down() call from probe error=
 path
      media: atomisp: Remove atomisp_ospm_dphy_up()/_down() functions
      media: atomisp_ov2680: Fix 1280x720 -> 1296x736 resolution
      media: MAINTAINERS: Add Hans de Goede as staging/atomisp maintainer
      media: ov5693: Add support for a privacy-led GPIO
      media: MAINTAINERS: Add Hans de Goede as staging/atomisp maintainer

Hidenori Kobayashi (1):
      media: ov8856: Add runtime PM callbacks

Ian Cowan (3):
      staging: media: sunxi: cedrus: make vb2_ops struct definition const
      media: staging: media: sunxi: cedrus: make vb2_ops struct definition =
const
      media: staging: omap4iss: remove cacheflush import

Irui Wang (2):
      media: mediatek: vcodec: Skip unsupported h264 encoder profile
      media: dt-bindings: mediatek: vcodec: Add the platform compatible to =
schema

Jacopo Mondi (10):
      media: ar0521: Implement enum_frame_sizes
      media: ar0521: Add V4L2_CID_ANALOG_GAIN
      media: ar0521: Set maximum resolution to 2592x1944
      media: ar0521: Rework PLL computation
      media: ar0521: Refuse unsupported controls
      media: ar0521: Add LINK_FREQ control
      media: ar0521: Adjust exposure and blankings limits
      media: ar0521: Setup controls at s_stream time
      media: ar0521: Rework startup sequence
      media: ar0521: Tab-align definitions

Jammy Huang (7):
      media: v4l: Add definition for the Aspeed JPEG format
      media: v4l2-ctrls: Reserve controls for ASPEED
      media: Documentation: aspeed-video: Add user documentation for the as=
peed-video driver
      media: aspeed: Support aspeed mode to reduce compressed data
      media: aspeed: Extend debug message
      media: aspeed: Use v4l2_dbg to replace v4l2_warn to avoid log spam
      media: aspeed: Use v4l2_dbg to replace v4l2_warn to avoid log spam

Jason Wang (1):
      media: imx-jpeg: Remove unnecessary memset() after dma_alloc_coherent=
()

Jernej Skrabec (19):
      media: v4l2-ioctl.c: Unify YCbCr/YUV terms in format descriptions
      media: cedrus: hevc: Fix offset adjustments
      media: cedrus: h265: Associate mv col buffers with buffer
      media: cedrus: h264: Optimize mv col buffer allocation
      media: cedrus: remove superfluous call
      media: cedrus: Add format reset helpers
      media: cedrus: use helper to set default formats
      media: cedrus: Add helper for checking capabilities
      media: cedrus: Filter controls based on capability
      media: cedrus: set codec ops immediately
      media: cedrus: Remove cedrus_codec enum
      media: cedrus: prefer untiled capture format
      media: cedrus: initialize controls a bit later
      media: cedrus: Adjust buffer size based on codec
      media: cedrus: h265: Support decoding 10-bit frames
      media: cedrus: Relax HEVC SPS restrictions
      media: cedrus: Adjust buffer size based on codec
      media: cedrus: h265: Support decoding 10-bit frames
      media: cedrus: Relax HEVC SPS restrictions

Jianhua Lin (2):
      dt-bindings: media: mediatek-jpeg-decoder: Add MT8188 compatible stri=
ng
      dt-bindings: media: mediatek-jpeg-encoder: Add MT8188 compatible stri=
ng

Jiapeng Chong (1):
      media: rzg2l-cru: Fix missing error code in rzg2l_cru_start_streaming=
_vq()

Jiasheng Jiang (3):
      media: coda: jpeg: Add check for kmalloc
      media: coda: Add check for dcoda_iram_alloc
      media: coda: Add check for kmalloc

Jonathan Neusch=C3=A4fer (1):
      media: davinci/vpbe: Fix a typo ("defualt_mode")

Keita Suzuki (1):
      media: dvb-core: Fix double free in dvb_register_device()

Kieran Bingham (1):
      media: i2c: ov08x40: Make remove callback return void

Lad Prabhakar (14):
      media: i2c: ov5645: Drop fetching the clk reference by name
      media: ARM: dts: imx6qdl-pico: Drop clock-names property
      media: ARM: dts: imx6qdl-wandboard: Drop clock-names property
      media: arm64: dts: renesas: aistarvision-mipi-adapter-2.1: Drop clock=
-names property
      media: dt-bindings: ov5645: Convert OV5645 binding to a schema
      media: i2c: ov5645: Use runtime PM
      media: i2c: ov5645: Drop empty comment
      media: i2c: ov5645: Make sure to call PM functions
      media: i2c: ov5645: Call ov5645_entity_init_cfg() before registering =
the subdev
      media: dt-bindings: Document Renesas RZ/G2L CSI-2 block
      media: dt-bindings: Document Renesas RZ/G2L CRU block
      media: platform: Add Renesas RZ/G2L MIPI CSI-2 receiver driver
      media: platform: Add Renesas RZ/G2L CRU driver
      media: platform: renesas: rzg2l-cru: Add missing documentation for im=
age_conv_irq

Laurent Pinchart (30):
      media: v4l2-ctrls: Fix off-by-one error in integer menu control check
      media: Fix documentation typos in media-entity.h
      media: dt-bindings: Convert imx290.txt to YAML
      media: i2c: imx290: Use device lock for the control handler
      media: i2c: imx290: Print error code when I2C transfer fails
      media: i2c: imx290: Replace macro with explicit ARRAY_SIZE()
      media: i2c: imx290: Drop imx290_write_buffered_reg()
      media: i2c: imx290: Drop regmap cache
      media: i2c: imx290: Specify HMAX values in decimal
      media: i2c: imx290: Support variable-sized registers
      media: i2c: imx290: Correct register sizes
      media: i2c: imx290: Simplify error handling when writing registers
      media: i2c: imx290: Define more register macros
      media: i2c: imx290: Add exposure time control
      media: i2c: imx290: Fix max gain value
      media: i2c: imx290: Split control initialization to separate function
      media: i2c: imx290: Implement HBLANK and VBLANK controls
      media: i2c: imx290: Create controls for fwnode properties
      media: i2c: imx290: Move registers with fixed value to init array
      media: i2c: imx290: Factor out format retrieval to separate function
      media: i2c: imx290: Add crop selection targets support
      media: i2c: imx290: Replace GAIN control with ANALOGUE_GAIN
      media: Documentation: Drop deprecated bytesused =3D=3D 0
      media: imx: imx7-media-csi: Move variable to loop scope
      media: imx: imx7-media-csi: Rename phys variables to dma_addr
      media: imx: imx7-media-csi: Clear BIT_MIPI_DOUBLE_CMPNT for <16b form=
ats
      media: imx: Decouple imx8mq-mipi-csi2 from imx7-media-csi
      media: imx: Unstage the imx7-media-csi driver
      media: dt-bindings: media: Add macros for video interface bus types
      media: dt-bindings: Use new video interface bus type macros in exampl=
es

Lecopzer Chen (2):
      media: mantis: Kconfig: add depends on DVB_CORE for MANTIS_CORE
      media: Kconfig: Make DVB_CORE=3Dm possible when MEDIA_SUPPORT=3Dy

Liang He (1):
      media: c8sectpfe: Add of_node_put() when breaking out of loop

Lin Ma (3):
      media: dvbdev: adopts refcnt to avoid UAF
      media: dvbdev: fix build warning due to comments
      media: dvbdev: fix refcnt bug

Linus Walleij (6):
      media: ov2640: Drop legacy includes
      media: ov7670: Drop unused include
      media: ov9650: Drop platform data code path
      media: s5k4ecgx: Switch to GPIO descriptors
      media: s5k4ecgx: Delete driver
      media: s5c73m3: Switch to GPIO descriptors

Liu Shixin (3):
      media: aspeed: use DEFINE_SHOW_ATTRIBUTE to simplify code
      media: vivid: fix compose size exceed boundary
      media: saa7164: fix missing pci_disable_device()

Luca Ceresoli (2):
      staging: media: tegra-video: fix chan->mipi value on error
      staging: media: tegra-video: fix device_node use after free

Lukas Bulwahn (2):
      media: i2c: refer to config VIDEO_DEV to make ov08x40 image sensor dr=
iver usable
      media: imx: remove code for non-existing config IMX_GPT_ICAP

Marco Felsch (5):
      phy: dphy: refactor get_default_config
      phy: dphy: add support to calculate the timing based on hs_clk_rate
      media: dt-bindings: add bindings for Toshiba TC358746
      media: tc358746: add Toshiba TC358746 Parallel to CSI-2 bridge driver
      media: tc358746: drop selecting COMMON_CLK

Marek Szyprowski (1):
      media: exynos4-is: don't rely on the v4l2_async_subdev internals

Marek Vasut (2):
      media: mt9p031: Drop bogus v4l2_subdev_get_try_crop() call from mt9p0=
31_init_cfg()
      media: mt9p031: Increase post-reset delay

Mauro Carvalho Chehab (8):
      Merge tag 'br-v6.2b' of git://linuxtv.org/hverkuil/media_tree into me=
dia_stage
      Merge git://linuxtv.org/sailus/media_tree into media_stage
      Merge tag 'tag-venus-for-v6.2' of git://linuxtv.org/svarbanov/media_t=
ree into media_stage
      Merge tag 'br-v6.2e' of git://linuxtv.org/hverkuil/media_tree into me=
dia_stage
      Merge tag 'br-v6.2d' of git://linuxtv.org/hverkuil/media_tree into me=
dia_stage
      Merge tag 'br-v6.2g' of git://linuxtv.org/hverkuil/media_tree into me=
dia_stage
      Merge tag 'br-v6.2f' of git://linuxtv.org/hverkuil/media_tree into me=
dia_stage
      Merge tag 'br-v6.2i' of git://linuxtv.org/hverkuil/media_tree into me=
dia_stage

Maximilian Luz (1):
      ipu3-imgu: Fix NULL pointer dereference in imgu_subdev_set_selection()

Mazin Al Haddad (1):
      media: dvb-usb: fix memory leak in dvb_usb_adapter_init()

Ma=C3=ADra Canal (1):
      dt-bindings: media: s5c73m3: Fix reset-gpio descriptor

Michael Riesch (2):
      dt-bindings: media: video-interfaces: add support for dual edge sampl=
ing
      media: v4l2-mediabus: add support for dual edge sampling

Mikhail Rudenko (3):
      media: dt-bindings: i2c: document OV4689
      media: i2c: add support for OV4689
      media: i2c: ov4689: code cleanup

Ming Qian (18):
      media: imx-jpeg: Add a timeout mechanism for each frame
      media: imx-jpeg: Don't clear stop state in handling dynamic resolutio=
n change
      media: imx-jpeg: Disable useless interrupt to avoid kernel panic
      media: imx-jpeg: Implement g_selection and s_selection
      media: imx-jpeg: Support contiguous and non contiguous format
      media: imx-jpeg: Lock on ioctl encoder/decoder stop cmd
      media: amphion: reset instance if it's aborted before codec header pa=
rsed
      media: amphion: add lock around vdec_g_fmt
      media: amphion: apply vb2_queue_error instead of setting manually
      media: amphion: add lock around vdec_g_fmt
      media: amphion: apply vb2_queue_error instead of setting manually
      media: add nv12_8l128 and nv12_10be_8l128 video format.
      media: amphion: tell and handle contiguous and non contiguous format
      media: amphion: decoder add support for contiguous planes
      media: amphion: encoder add support for contiguous planes
      media: amphion: try to wakeup vpu core to avoid failure
      media: amphion: cancel vpu before release instance
      media: amphion: lock and check m2m_ctx in event handler

Mirela Rabulea (1):
      media: imx-jpeg: Fix Coverity issue in probe

Moses Christopher Bollavarapu (1):
      drivers: staging: media: omap4iss: Use BIT macro instead of left shif=
ting

Moudy Ho (5):
      media: platform: mtk-mdp3: remove unused VIDEO_MEDIATEK_VPU config
      media: platform: mtk-mdp3: extend shared memory structure to 4-byte a=
ligned
      media: platform: mtk-mdp3: fix error handling in mdp_cmdq_send()
      media: platform: mtk-mdp3: fix error handling about components clock_=
on
      media: platform: mtk-mdp3: fix error handling in mdp_probe()

Nathan Chancellor (1):
      media: rzg2l-cru: Remove unnecessary shadowing of ret in rzg2l_csi2_s=
_stream()

Niklas S=C3=B6derlund (5):
      media: adv748x: Remove dead function declaration
      media: adv748x: afe: Select input port when initializing AFE
      media: rcar-vin: Do not cache remote rectangle
      media: rcar-vin: Store scaler in a function pointer
      media: rcar-vin: Add support for Gen3 UDS (Up Down Scaler)

Paul Elder (1):
      media: imx: imx7-media-csi: Add support for fast-tracking queued buff=
ers

Paul Kocialkowski (37):
      media: sun6i-csi: Add bridge v4l2 subdev with port management
      media: sun6i-csi: Rename sun6i_video to sun6i_csi_capture
      media: sun6i-csi: Add capture state using vsync for page flip
      media: sun6i-csi: Rework register definitions, invert misleading fiel=
ds
      media: sun6i-csi: Add dimensions and format helpers to capture
      media: sun6i-csi: Implement address configuration without indirection
      media: sun6i-csi: Split stream sequences and irq code in capture
      media: sun6i-csi: Move power management to runtime pm in capture
      media: sun6i-csi: Move register configuration to capture
      media: sun6i-csi: Rework capture format management with helper
      media: sun6i-csi: Remove custom format helper and rework configure
      media: sun6i-csi: Add bridge dimensions and format helpers
      media: sun6i-csi: Get mbus code from bridge instead of storing it
      media: sun6i-csi: Tidy capture configure code
      media: sun6i-csi: Introduce bridge format structure, list and helper
      media: sun6i-csi: Introduce capture format structure, list and helper
      media: sun6i-csi: Configure registers from format tables
      media: sun6i-csi: Implement capture link validation with logic
      media: sun6i-csi: Get bridge subdev directly in capture stream ops
      media: sun6i-csi: Move hardware control to the bridge
      media: sun6i-csi: Rename the capture video device to sun6i-csi-capture
      media: sun6i-csi: Cleanup headers and includes, update copyright lines
      media: sun6i-csi: Add support for MIPI CSI-2 to the bridge code
      media: sun6i-csi: Only configure capture when streaming
      media: sun6i-csi: Add extra checks to the interrupt routine
      media: sun6i-csi: Request a shared interrupt
      media: MAINTAINERS: Add myself as sun6i-csi maintainer and rename/mov=
e entry
      media: dt-bindings: media: Add Allwinner A31 ISP bindings documentati=
on
      media: dt-bindings: media: sun6i-a31-csi: Add internal output port to=
 the ISP
      media: staging: media: Add support for the Allwinner A31 ISP
      media: MAINTAINERS: Add entry for the Allwinner A31 ISP driver
      media: sun6i-csi: Detect the availability of the ISP
      media: sun6i-csi: Add support for hooking to the isp devices
      media: sun6i-mipi-csi2: Require both pads to be connected for streami=
ng
      media: sun8i-a83t-mipi-csi2: Require both pads to be connected for st=
reaming
      media: sun6i-mipi-csi2: Register async subdev with no sensor attached
      media: sun8i-a83t-mipi-csi2: Register async subdev with no sensor att=
ached

Peter Robinson (1):
      media: Add dependency on ARCH_ASPEED

Philipp Zabel (1):
      media: imx: Use get_mbus_config instead of parsing upstream DT endpoi=
nts

Rafael Mendonca (2):
      media: i2c: hi846: Fix memory leak in hi846_parse_dt()
      media: i2c: ov5648: Free V4L2 fwnode data on unbind

Randy Dunlap (1):
      media: dvb/frontend.h: fix kernel-doc warnings

Ricardo Ribalda (1):
      media: i2c: ad5820: Fix error path

Robert Schlabbach (3):
      media: dvb_frontend: add missing DSS switch cases
      media: dvb: add DVB-C2 and DVB-S2X parameter values
      media: dvb-core: Enhance shared multi-frontend support

Sakari Ailus (3):
      media: v4l: subdev: Document s_power() callback is deprecated
      dw9768: Enable low-power probe on ACPI
      v4l: subdev: Warn if disabling streaming failed, return success

Shang XiaoJing (1):
      media: stm32: dcmi: Remove redundant dev_err call

Shawn Tu (1):
      media: i2c: Add ov08x40 image sensor driver

Shigeru Yoshida (1):
      media: si470x: Fix use-after-free in si470x_int_in_callback()

Smitha T Murthy (3):
      media: s5p-mfc: Fix in register read and write for H264
      media: s5p-mfc: Clear workbit to handle error condition
      media: s5p-mfc: Fix to handle reference queue during finishing

Stanimir Varbanov (4):
      MAINTAINERS: Change email for Venus driver
      venus: firmware: Correct reset bit
      venus: firmware: Correct non-pix start and end addresses
      venus: firmware: Correct assertion of reset bit on remote processor

Takashi Iwai (1):
      media: dvb-core: Fix UAF due to refcount races at releasing

Tang Bin (1):
      venus: pm_helpers: Fix error check in vcodec_domains_get()

Uwe Kleine-K=C3=B6nig (96):
      media: dvb-frontends/a8293: Convert to i2c's .probe_new()
      media: dvb-frontends/af9013: Convert to i2c's .probe_new()
      media: dvb-frontends/af9033: Convert to i2c's .probe_new()
      media: dvb-frontends/au8522_decoder: Convert to i2c's .probe_new()
      media: dvb-frontends/cxd2099: Convert to i2c's .probe_new()
      media: dvb-frontends/cxd2820r_core: Convert to i2c's .probe_new()
      media: dvb-frontends/helene: Convert to i2c's .probe_new()
      media: dvb-frontends/lgdt3306a: Convert to i2c's .probe_new()
      media: dvb-frontends/lgdt330x: Convert to i2c's .probe_new()
      media: dvb-frontends/mn88472: Convert to i2c's .probe_new()
      media: dvb-frontends/mn88473: Convert to i2c's .probe_new()
      media: dvb-frontends/mxl692: Convert to i2c's .probe_new()
      media: dvb-frontends/rtl2830: Convert to i2c's .probe_new()
      media: dvb-frontends/rtl2832: Convert to i2c's .probe_new()
      media: dvb-frontends/si2165: Convert to i2c's .probe_new()
      media: dvb-frontends/si2168: Convert to i2c's .probe_new()
      media: dvb-frontends/sp2: Convert to i2c's .probe_new()
      media: dvb-frontends/stv090x: Convert to i2c's .probe_new()
      media: dvb-frontends/stv6110x: Convert to i2c's .probe_new()
      media: dvb-frontends/tda10071: Convert to i2c's .probe_new()
      media: dvb-frontends/ts2020: Convert to i2c's .probe_new()
      media: i2c/ad5820: Convert to i2c's .probe_new()
      media: i2c/ad9389b: Convert to i2c's .probe_new()
      media: i2c/adp1653: Convert to i2c's .probe_new()
      media: i2c/adv7170: Convert to i2c's .probe_new()
      media: i2c/adv7175: Convert to i2c's .probe_new()
      media: i2c/adv7183: Convert to i2c's .probe_new()
      media: i2c/adv7393: Convert to i2c's .probe_new()
      media: i2c/adv7511-v4l2: Convert to i2c's .probe_new()
      media: i2c/adv7842: Convert to i2c's .probe_new()
      media: i2c/ak881x: Convert to i2c's .probe_new()
      media: i2c/bt819: Convert to i2c's .probe_new()
      media: i2c/bt856: Convert to i2c's .probe_new()
      media: i2c/bt866: Convert to i2c's .probe_new()
      media: i2c/cs3308: Convert to i2c's .probe_new()
      media: i2c/cs5345: Convert to i2c's .probe_new()
      media: cx25840: Convert to i2c's .probe_new()
      media: i2c/ks0127: Convert to i2c's .probe_new()
      media: i2c/lm3560: Convert to i2c's .probe_new()
      media: i2c/lm3646: Convert to i2c's .probe_new()
      media: i2c/m52790: Convert to i2c's .probe_new()
      media: m5mols: Convert to i2c's .probe_new()
      media: i2c/ml86v7667: Convert to i2c's .probe_new()
      media: i2c/mt9m032: Convert to i2c's .probe_new()
      media: i2c/mt9t001: Convert to i2c's .probe_new()
      media: i2c/mt9t112: Convert to i2c's .probe_new()
      media: i2c/mt9v011: Convert to i2c's .probe_new()
      media: i2c/noon010pc30: Convert to i2c's .probe_new()
      media: i2c/ov13858: Convert to i2c's .probe_new()
      media: i2c/ov6650: Convert to i2c's .probe_new()
      media: i2c/ov7640: Convert to i2c's .probe_new()
      media: i2c/ov9640: Convert to i2c's .probe_new()
      media: i2c/rj54n1cb0c: Convert to i2c's .probe_new()
      media: i2c/s5k4ecgx: Convert to i2c's .probe_new()
      media: i2c/s5k6aa: Convert to i2c's .probe_new()
      media: i2c/saa6588: Convert to i2c's .probe_new()
      media: i2c/saa6752hs: Convert to i2c's .probe_new()
      media: i2c/saa7110: Convert to i2c's .probe_new()
      media: i2c/saa717x: Convert to i2c's .probe_new()
      media: i2c/saa7185: Convert to i2c's .probe_new()
      media: i2c/sony-btf-mpx: Convert to i2c's .probe_new()
      media: i2c/sr030pc30: Convert to i2c's .probe_new()
      media: i2c/tda7432: Convert to i2c's .probe_new()
      media: i2c/tda9840: Convert to i2c's .probe_new()
      media: i2c/tea6415c: Convert to i2c's .probe_new()
      media: i2c/tea6420: Convert to i2c's .probe_new()
      media: i2c/ths7303: Convert to i2c's .probe_new()
      media: i2c/tlv320aic23b: Convert to i2c's .probe_new()
      media: i2c/tw2804: Convert to i2c's .probe_new()
      media: i2c/tw9903: Convert to i2c's .probe_new()
      media: i2c/tw9906: Convert to i2c's .probe_new()
      media: i2c/tw9910: Convert to i2c's .probe_new()
      media: i2c/uda1342: Convert to i2c's .probe_new()
      media: i2c/upd64031a: Convert to i2c's .probe_new()
      media: i2c/upd64083: Convert to i2c's .probe_new()
      media: i2c/vp27smpx: Convert to i2c's .probe_new()
      media: i2c/vpx3220: Convert to i2c's .probe_new()
      media: i2c/vs6624: Convert to i2c's .probe_new()
      media: i2c/wm8739: Convert to i2c's .probe_new()
      media: i2c/wm8775: Convert to i2c's .probe_new()
      media: radio/radio-tea5764: Convert to i2c's .probe_new()
      media: radio/saa7706h: Convert to i2c's .probe_new()
      media: radio/tef6862: Convert to i2c's .probe_new()
      media: vidtv: Convert to i2c's .probe_new()
      media: tuners/e4000: Convert to i2c's .probe_new()
      media: tuners/fc2580: Convert to i2c's .probe_new()
      media: tuners/m88rs6000t: Convert to i2c's .probe_new()
      media: tuners/mt2060: Convert to i2c's .probe_new()
      media: tuners/mxl301rf: Convert to i2c's .probe_new()
      media: tuners/qm1d1b0004: Convert to i2c's .probe_new()
      media: tuners/qm1d1c0042: Convert to i2c's .probe_new()
      media: tuners/tda18212: Convert to i2c's .probe_new()
      media: tuners/tda18250: Convert to i2c's .probe_new()
      media: tuners/tua9001: Convert to i2c's .probe_new()
      media: usb: go7007: s2250-board: Convert to i2c's .probe_new()
      media: v4l2-core/tuner-core: Convert to i2c's .probe_new()

Vikash Garodia (1):
      MAINTAINERS: Add Vikash as VENUS video driver co-maintainer

Vladimir Zapolskiy (4):
      media: camss: Clean up received buffers on failed start of streaming
      media: camss: Do not attach an already attached power domain on MSM89=
16 platform
      media: camss: Collect information about a number of lite VFEs
      media: camss: Split power domain management

Wan Jiabing (1):
      media: dvb-frontends: clean up unneeded else

Wei Yongjun (1):
      media: ir-spi: silence no spi_device_id warnings

Xiu Jianfeng (1):
      media: v4l: Use memset_after() helper

Yan Lei (1):
      media: dvb-frontends: fix leak of memory fw

Yang Li (1):
      media: sun6i-csi: Remove unnecessary print function dev_err()

Yang Yingliang (6):
      media: platform: exynos4-is: fix return value check in fimc_md_probe()
      media: solo6x10: fix possible memory leak in solo_sysfs_init()
      media: mtk-jpegdec: add missing destroy_workqueue()
      media: solo6x10: fix possible memory leak in solo_sysfs_init()
      media: mtk-jpegdec: add missing destroy_workqueue()
      media: Switch to use dev_err_probe() helper

YongSu Yoo (1):
      media: dvb_ringbuffer : Fix a bug in dvb_ringbuffer.c

Yuan Can (5):
      media: platform: exynos4-is: Fix error handling in fimc_md_init()
      media: amphion: Fix error handling in vpu_driver_init()
      media: platform: exynos4-is: Fix error handling in fimc_md_init()
      media: amphion: Fix error handling in vpu_driver_init()
      media: dvb-usb: dib0700_devices: Remove unused struct dibx090p_adc

Yunfei Dong (6):
      media: mediatek: vcodec: fix h264 cavlc bitstream fail
      media: mediatek: vcodec: Fix getting NULL pointer for dst buffer
      media: mediatek: vcodec: Can't set dst buffer to done when lat decode=
 error
      media: mediatek: vcodec: Fix h264 set lat buffer error
      media: mediatek: vcodec: Setting lat buf to lat_list when lat decode =
error
      media: mediatek: vcodec: Core thread depends on core_list

kyrie wu (15):
      dt-bindings: mediatek: Add mediatek, mt8195-jpgenc compatible
      mtk-jpegenc: export jpeg encoder functions
      mtk-jpegenc: support jpegenc multi-hardware
      mtk-jpegenc: add jpegenc timeout func interface
      mtk-jpegenc: add jpeg encode worker interface
      mtk-jpegenc: add output pic reorder interface
      mtk-jpegenc: add stop cmd interface for jpgenc
      dt-bindings: mediatek: Add mediatek,mt8195-jpgdec compatible
      media: mtk-jpegdec: export jpeg decoder functions
      media: mtk-jpegdec: support jpegdec multi-hardware
      media: mtk-jpegdec: add jpegdec timeout func interface
      media: mtk-jpegdec: add jpeg decode worker interface
      media: mtk-jpegdec: add output pic reorder interface
      media: mtk-jpegdec: refactor jpegdec func interface
      mtk-jpegdec: add stop cmd interface for jpgdec

wangjianli (1):
      media: media/dvb-frontends: fix repeated words in comments

 Documentation/admin-guide/media/cec-drivers.rst    |   10 -
 Documentation/admin-guide/media/cec.rst            |  369 +++
 Documentation/admin-guide/media/index.rst          |    3 +-
 Documentation/admin-guide/media/pulse8-cec.rst     |   13 -
 Documentation/admin-guide/media/v4l-drivers.rst    |    1 +
 Documentation/admin-guide/media/vimc.rst           |    8 +-
 Documentation/admin-guide/media/visl.rst           |  175 ++
 Documentation/admin-guide/media/vivid.rst          |    2 +-
 .../bindings/media/allwinner,sun50i-h6-vpu-g2.yaml |    5 +
 .../bindings/media/allwinner,sun6i-a31-csi.yaml    |    4 +
 .../bindings/media/allwinner,sun6i-a31-isp.yaml    |  101 +
 .../devicetree/bindings/media/i2c/imx290.txt       |   57 -
 .../devicetree/bindings/media/i2c/mipi-ccs.yaml    |    3 +-
 .../devicetree/bindings/media/i2c/ov5645.txt       |   54 -
 .../devicetree/bindings/media/i2c/ovti,ov4689.yaml |  134 +
 .../devicetree/bindings/media/i2c/ovti,ov5645.yaml |  104 +
 .../devicetree/bindings/media/i2c/ovti,ov772x.yaml |    3 +-
 .../devicetree/bindings/media/i2c/ovti,ov9282.yaml |   14 +-
 .../devicetree/bindings/media/i2c/sony,imx290.yaml |  129 +
 .../devicetree/bindings/media/i2c/sony,imx412.yaml |    4 +-
 .../bindings/media/i2c/st,st-vgxy61.yaml           |  113 +
 .../bindings/media/i2c/toshiba,tc358746.yaml       |  178 ++
 .../bindings/media/marvell,mmp2-ccic.yaml          |    3 +-
 .../bindings/media/mediatek,mt8195-jpegdec.yaml    |  168 +
 .../bindings/media/mediatek,mt8195-jpegenc.yaml    |  147 +
 .../bindings/media/mediatek,vcodec-encoder.yaml    |   12 +-
 .../bindings/media/mediatek-jpeg-decoder.yaml      |    1 +
 .../bindings/media/mediatek-jpeg-encoder.yaml      |    1 +
 .../devicetree/bindings/media/microchip,xisc.yaml  |    3 +-
 .../bindings/media/renesas,rzg2l-cru.yaml          |  157 +
 .../bindings/media/renesas,rzg2l-csi2.yaml         |  149 +
 .../devicetree/bindings/media/s5p-mfc.txt          |   10 +-
 .../devicetree/bindings/media/samsung-s5c73m3.txt  |    2 +-
 .../devicetree/bindings/media/st,stm32-dcmi.yaml   |    4 +-
 .../bindings/media/video-interfaces.yaml           |    5 +-
 .../userspace-api/media/cec/cec-pin-error-inj.rst  |    2 +
 .../userspace-api/media/drivers/aspeed-video.rst   |   65 +
 .../userspace-api/media/drivers/index.rst          |    2 +
 .../userspace-api/media/drivers/st-vgxy61.rst      |   25 +
 .../media/dvb/fe_property_parameters.rst           |   25 +-
 .../userspace-api/media/frontend.h.rst.exceptions  |   28 +
 Documentation/userspace-api/media/v4l/buffer.rst   |   11 +-
 .../userspace-api/media/v4l/ext-ctrls-camera.rst   |    8 +
 .../userspace-api/media/v4l/pixfmt-reserved.rst    |   17 +
 .../userspace-api/media/v4l/pixfmt-yuv-planar.rst  |    8 +
 .../userspace-api/media/v4l/subdev-formats.rst     |   37 +
 MAINTAINERS                                        |   74 +-
 arch/arm/boot/dts/imx6qdl-pico.dtsi                |    1 -
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi           |    1 -
 .../dts/renesas/aistarvision-mipi-adapter-2.1.dtsi |    1 -
 drivers/media/Kconfig                              |    2 +-
 drivers/media/cec/platform/stm32/stm32-cec.c       |    9 +-
 drivers/media/common/videobuf2/frame_vector.c      |   10 +-
 drivers/media/common/videobuf2/videobuf2-core.c    |   26 +-
 .../media/common/videobuf2/videobuf2-dma-contig.c  |    3 +-
 drivers/media/common/videobuf2/videobuf2-dma-sg.c  |    4 +-
 drivers/media/common/videobuf2/videobuf2-memops.c  |    6 +-
 drivers/media/common/videobuf2/videobuf2-vmalloc.c |    4 +-
 drivers/media/dvb-core/dmxdev.c                    |    8 +
 drivers/media/dvb-core/dvb_ca_en50221.c            |    2 +-
 drivers/media/dvb-core/dvb_demux.c                 |    4 +-
 drivers/media/dvb-core/dvb_frontend.c              |   33 +-
 drivers/media/dvb-core/dvb_ringbuffer.c            |    4 +-
 drivers/media/dvb-core/dvbdev.c                    |   36 +-
 drivers/media/dvb-frontends/a8293.c                |  160 +-
 drivers/media/dvb-frontends/a8293.h                |    3 +
 drivers/media/dvb-frontends/af9013.c               |    5 +-
 drivers/media/dvb-frontends/af9033.c               |    5 +-
 drivers/media/dvb-frontends/au8522_decoder.c       |    5 +-
 drivers/media/dvb-frontends/bcm3510.c              |    1 +
 drivers/media/dvb-frontends/cxd2099.c              |    5 +-
 drivers/media/dvb-frontends/cxd2820r_core.c        |    7 +-
 drivers/media/dvb-frontends/cxd2820r_priv.h        |    2 -
 .../media/dvb-frontends/drx39xyj/drx_dap_fasi.h    |    2 -
 drivers/media/dvb-frontends/drx39xyj/drxj.c        |    1 +
 drivers/media/dvb-frontends/helene.c               |    5 +-
 drivers/media/dvb-frontends/lgdt3306a.c            |    5 +-
 drivers/media/dvb-frontends/lgdt330x.c             |    5 +-
 drivers/media/dvb-frontends/mn88472.c              |    5 +-
 drivers/media/dvb-frontends/mn88473.c              |    5 +-
 drivers/media/dvb-frontends/mxl5xx.c               |    2 -
 drivers/media/dvb-frontends/mxl692.c               |    5 +-
 drivers/media/dvb-frontends/rtl2830.c              |    5 +-
 drivers/media/dvb-frontends/rtl2832.c              |    5 +-
 drivers/media/dvb-frontends/si2165.c               |    5 +-
 drivers/media/dvb-frontends/si2168.c               |    5 +-
 drivers/media/dvb-frontends/sp2.c                  |    5 +-
 drivers/media/dvb-frontends/stv090x.c              |    5 +-
 drivers/media/dvb-frontends/stv6110x.c             |    5 +-
 drivers/media/dvb-frontends/tda10071.c             |    5 +-
 drivers/media/dvb-frontends/ts2020.c               |    5 +-
 drivers/media/i2c/Kconfig                          |   62 +-
 drivers/media/i2c/Makefile                         |    5 +-
 drivers/media/i2c/ad5820.c                         |   33 +-
 drivers/media/i2c/ad9389b.c                        |    4 +-
 drivers/media/i2c/adp1653.c                        |    5 +-
 drivers/media/i2c/adv7170.c                        |    5 +-
 drivers/media/i2c/adv7175.c                        |    5 +-
 drivers/media/i2c/adv7183.c                        |    5 +-
 drivers/media/i2c/adv7393.c                        |    5 +-
 drivers/media/i2c/adv748x/adv748x-afe.c            |    4 +
 drivers/media/i2c/adv748x/adv748x.h                |    3 -
 drivers/media/i2c/adv7511-v4l2.c                   |    4 +-
 drivers/media/i2c/adv7842.c                        |    5 +-
 drivers/media/i2c/ak881x.c                         |    5 +-
 drivers/media/i2c/aptina-pll.c                     |    1 -
 drivers/media/i2c/ar0521.c                         |  352 ++-
 drivers/media/i2c/bt819.c                          |    5 +-
 drivers/media/i2c/bt856.c                          |    5 +-
 drivers/media/i2c/bt866.c                          |    5 +-
 drivers/media/i2c/cs3308.c                         |    5 +-
 drivers/media/i2c/cs5345.c                         |    5 +-
 drivers/media/i2c/cx25840/cx25840-core.c           |    5 +-
 drivers/media/i2c/dw9768.c                         |   33 +-
 drivers/media/i2c/hi846.c                          |   14 +-
 drivers/media/i2c/imx208.c                         |    4 +
 drivers/media/i2c/imx274.c                         |    5 +-
 drivers/media/i2c/imx290.c                         |  786 +++--
 drivers/media/i2c/imx319.c                         |    4 +
 drivers/media/i2c/imx355.c                         |    4 +
 drivers/media/i2c/imx412.c                         |    9 +-
 drivers/media/i2c/isl7998x.c                       |    2 +-
 drivers/media/i2c/ks0127.c                         |    4 +-
 drivers/media/i2c/lm3560.c                         |    5 +-
 drivers/media/i2c/lm3646.c                         |    5 +-
 drivers/media/i2c/m52790.c                         |    5 +-
 drivers/media/i2c/m5mols/m5mols_core.c             |    5 +-
 drivers/media/i2c/ml86v7667.c                      |    5 +-
 drivers/media/i2c/mt9m032.c                        |    5 +-
 drivers/media/i2c/mt9p031.c                        |    9 +-
 drivers/media/i2c/mt9t001.c                        |    5 +-
 drivers/media/i2c/mt9t112.c                        |    5 +-
 drivers/media/i2c/mt9v011.c                        |    5 +-
 drivers/media/i2c/noon010pc30.c                    |    5 +-
 drivers/media/i2c/ov08d10.c                        |    5 +
 drivers/media/i2c/ov08x40.c                        | 3325 ++++++++++++++++=
++++
 drivers/media/i2c/ov13858.c                        |    5 +-
 drivers/media/i2c/ov2640.c                         |    2 -
 drivers/media/i2c/ov2680.c                         |    2 +
 drivers/media/i2c/ov2740.c                         |  134 +-
 drivers/media/i2c/ov4689.c                         | 1018 ++++++
 drivers/media/i2c/ov5640.c                         |   25 +-
 drivers/media/i2c/ov5645.c                         |  148 +-
 drivers/media/i2c/ov5648.c                         |    1 +
 drivers/media/i2c/ov5693.c                         |   10 +
 drivers/media/i2c/ov6650.c                         |    5 +-
 drivers/media/i2c/ov7640.c                         |    5 +-
 drivers/media/i2c/ov7670.c                         |    1 -
 drivers/media/i2c/ov8856.c                         |   33 +-
 drivers/media/i2c/ov9282.c                         |  611 +++-
 drivers/media/i2c/ov9640.c                         |    5 +-
 drivers/media/i2c/ov9650.c                         |   49 +-
 drivers/media/i2c/rj54n1cb0c.c                     |    5 +-
 drivers/media/i2c/s5c73m3/s5c73m3-core.c           |  107 +-
 drivers/media/i2c/s5c73m3/s5c73m3-ctrls.c          |    1 -
 drivers/media/i2c/s5c73m3/s5c73m3.h                |   10 +-
 drivers/media/i2c/s5k4ecgx.c                       | 1032 ------
 drivers/media/i2c/s5k5baf.c                        |   64 +-
 drivers/media/i2c/s5k6a3.c                         |   30 +-
 drivers/media/i2c/s5k6aa.c                         |    5 +-
 drivers/media/i2c/saa6588.c                        |    5 +-
 drivers/media/i2c/saa6752hs.c                      |    5 +-
 drivers/media/i2c/saa7110.c                        |    5 +-
 drivers/media/i2c/saa717x.c                        |    5 +-
 drivers/media/i2c/saa7185.c                        |    5 +-
 drivers/media/i2c/sony-btf-mpx.c                   |    5 +-
 drivers/media/i2c/sr030pc30.c                      |    5 +-
 drivers/media/i2c/st-vgxy61.c                      | 1963 ++++++++++++
 drivers/media/i2c/tc358743.c                       |    9 +-
 drivers/media/i2c/tc358746.c                       | 1694 ++++++++++
 drivers/media/i2c/tda7432.c                        |    5 +-
 drivers/media/i2c/tda9840.c                        |    5 +-
 drivers/media/i2c/tea6415c.c                       |    5 +-
 drivers/media/i2c/tea6420.c                        |    5 +-
 drivers/media/i2c/ths7303.c                        |    5 +-
 drivers/media/i2c/tlv320aic23b.c                   |    5 +-
 drivers/media/i2c/tw2804.c                         |    5 +-
 drivers/media/i2c/tw9903.c                         |    5 +-
 drivers/media/i2c/tw9906.c                         |    5 +-
 drivers/media/i2c/tw9910.c                         |    5 +-
 drivers/media/i2c/uda1342.c                        |    5 +-
 drivers/media/i2c/upd64031a.c                      |    5 +-
 drivers/media/i2c/upd64083.c                       |    5 +-
 drivers/media/i2c/vp27smpx.c                       |    5 +-
 drivers/media/i2c/vpx3220.c                        |    5 +-
 drivers/media/i2c/vs6624.c                         |    5 +-
 drivers/media/i2c/wm8739.c                         |    5 +-
 drivers/media/i2c/wm8775.c                         |    5 +-
 drivers/media/pci/bt8xx/bttv.h                     |    1 -
 drivers/media/pci/cx25821/cx25821-video.h          |    3 -
 drivers/media/pci/intel/ipu3/Kconfig               |    1 +
 drivers/media/pci/mantis/Kconfig                   |    2 +-
 drivers/media/pci/pt3/pt3.c                        |   16 +-
 drivers/media/pci/saa7134/saa7134.h                |    4 -
 drivers/media/pci/saa7164/saa7164-core.c           |   10 +-
 drivers/media/pci/saa7164/saa7164.h                |    2 -
 drivers/media/pci/solo6x10/solo6x10-core.c         |    1 +
 drivers/media/pci/zoran/zoran_device.h             |    2 -
 drivers/media/platform/Kconfig                     |    1 +
 drivers/media/platform/Makefile                    |    1 +
 drivers/media/platform/amphion/vdec.c              |  218 +-
 drivers/media/platform/amphion/venc.c              |   41 +-
 drivers/media/platform/amphion/vpu.h               |    5 +-
 drivers/media/platform/amphion/vpu_cmds.c          |   39 +-
 drivers/media/platform/amphion/vpu_dbg.c           |    8 +-
 drivers/media/platform/amphion/vpu_drv.c           |    6 +-
 drivers/media/platform/amphion/vpu_helpers.c       |   45 +-
 drivers/media/platform/amphion/vpu_helpers.h       |    2 +
 drivers/media/platform/amphion/vpu_malone.c        |    4 +-
 drivers/media/platform/amphion/vpu_msgs.c          |    2 +
 drivers/media/platform/amphion/vpu_v4l2.c          |  199 +-
 drivers/media/platform/amphion/vpu_v4l2.h          |    3 +-
 drivers/media/platform/amphion/vpu_windsor.c       |    9 +-
 drivers/media/platform/aspeed/Kconfig              |    1 +
 drivers/media/platform/aspeed/aspeed-video.c       |  346 +-
 drivers/media/platform/atmel/Kconfig               |   51 -
 drivers/media/platform/atmel/Makefile              |    7 -
 drivers/media/platform/chips-media/coda-bit.c      |   14 +-
 drivers/media/platform/chips-media/coda-jpeg.c     |   10 +-
 drivers/media/platform/mediatek/jpeg/Makefile      |   14 +-
 .../media/platform/mediatek/jpeg/mtk_jpeg_core.c   |  490 ++-
 .../media/platform/mediatek/jpeg/mtk_jpeg_core.h   |  169 +-
 .../media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c |  325 +-
 .../media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.h |    6 +-
 .../platform/mediatek/jpeg/mtk_jpeg_dec_reg.h      |    1 +
 .../media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c |  255 ++
 drivers/media/platform/mediatek/mdp/mtk_mdp_comp.c |    5 +-
 drivers/media/platform/mediatek/mdp3/Kconfig       |    1 -
 drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h |   76 +-
 .../media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c   |   51 +-
 .../media/platform/mediatek/mdp3/mtk-mdp3-comp.c   |   24 +-
 .../media/platform/mediatek/mdp3/mtk-mdp3-core.c   |   15 +-
 .../mediatek/vcodec/mtk_vcodec_dec_stateless.c     |   13 +-
 .../platform/mediatek/vcodec/mtk_vcodec_enc.c      |    5 +-
 .../mediatek/vcodec/vdec/vdec_h264_req_multi_if.c  |   60 +-
 .../mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c     |   15 +-
 .../platform/mediatek/vcodec/vdec_msg_queue.c      |    2 +-
 drivers/media/platform/microchip/Kconfig           |   61 +
 drivers/media/platform/microchip/Makefile          |    9 +
 .../{atmel =3D> microchip}/microchip-csi2dc.c        |    0
 .../media/platform/microchip/microchip-isc-base.c  | 2040 ++++++++++++
 .../media/platform/microchip/microchip-isc-clk.c   |  311 ++
 .../media/platform/microchip/microchip-isc-regs.h  |  413 +++
 .../platform/microchip/microchip-isc-scaler.c      |  267 ++
 drivers/media/platform/microchip/microchip-isc.h   |  400 +++
 .../platform/microchip/microchip-sama5d2-isc.c     |  683 ++++
 .../platform/microchip/microchip-sama7g5-isc.c     |  646 ++++
 drivers/media/platform/nxp/Kconfig                 |   13 +
 drivers/media/platform/nxp/Makefile                |    1 +
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c  |    4 +-
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c     |  612 +++-
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h     |   10 +-
 .../imx =3D> media/platform/nxp}/imx7-media-csi.c    |  138 +-
 drivers/media/platform/qcom/camss/camss-vfe-170.c  |   20 +-
 drivers/media/platform/qcom/camss/camss-vfe-480.c  |   20 +-
 drivers/media/platform/qcom/camss/camss-video.c    |    3 +-
 drivers/media/platform/qcom/camss/camss.c          |   61 +-
 drivers/media/platform/qcom/camss/camss.h          |    1 +
 drivers/media/platform/qcom/venus/firmware.c       |   20 +-
 drivers/media/platform/qcom/venus/pm_helpers.c     |    4 +-
 drivers/media/platform/renesas/Kconfig             |    1 +
 drivers/media/platform/renesas/Makefile            |    1 +
 .../media/platform/renesas/rcar-vin/rcar-core.c    |   22 +-
 drivers/media/platform/renesas/rcar-vin/rcar-dma.c |  104 +-
 .../media/platform/renesas/rcar-vin/rcar-v4l2.c    |   93 +-
 drivers/media/platform/renesas/rcar-vin/rcar-vin.h |    9 +-
 drivers/media/platform/renesas/rzg2l-cru/Kconfig   |   33 +
 drivers/media/platform/renesas/rzg2l-cru/Makefile  |    6 +
 .../media/platform/renesas/rzg2l-cru/rzg2l-core.c  |  338 ++
 .../media/platform/renesas/rzg2l-cru/rzg2l-cru.h   |  154 +
 .../media/platform/renesas/rzg2l-cru/rzg2l-csi2.c  |  875 ++++++
 .../media/platform/renesas/rzg2l-cru/rzg2l-ip.c    |  255 ++
 .../media/platform/renesas/rzg2l-cru/rzg2l-video.c | 1058 +++++++
 .../media/platform/rockchip/rkisp1/rkisp1-params.c |    4 +-
 .../media/platform/samsung/exynos4-is/fimc-core.c  |    2 +-
 .../media/platform/samsung/exynos4-is/media-dev.c  |   14 +-
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c   |   73 +-
 .../media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c  |    4 +-
 .../media/platform/samsung/s5p-mfc/s5p_mfc_enc.c   |   12 +-
 .../platform/samsung/s5p-mfc/s5p_mfc_opr_v6.c      |   14 +-
 .../platform/st/sti/c8sectpfe/c8sectpfe-core.c     |    9 +-
 drivers/media/platform/st/stm32/stm32-dcmi.c       |   31 +-
 drivers/media/platform/sunxi/sun6i-csi/Makefile    |    2 +-
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c |  779 +----
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h |  145 +-
 .../platform/sunxi/sun6i-csi/sun6i_csi_bridge.c    |  868 +++++
 .../platform/sunxi/sun6i-csi/sun6i_csi_bridge.h    |   69 +
 .../platform/sunxi/sun6i-csi/sun6i_csi_capture.c   | 1102 +++++++
 .../platform/sunxi/sun6i-csi/sun6i_csi_capture.h   |   89 +
 .../media/platform/sunxi/sun6i-csi/sun6i_csi_reg.h |  362 ++-
 .../media/platform/sunxi/sun6i-csi/sun6i_video.c   |  733 -----
 .../media/platform/sunxi/sun6i-csi/sun6i_video.h   |   35 -
 .../sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c        |   23 +-
 .../sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c    |   23 +-
 drivers/media/platform/ti/omap3isp/isp.c           |    3 +-
 drivers/media/platform/xilinx/xilinx-csi2rxss.c    |    8 +-
 drivers/media/radio/radio-tea5764.c                |    5 +-
 drivers/media/radio/radio-terratec.c               |    3 -
 drivers/media/radio/saa7706h.c                     |    5 +-
 drivers/media/radio/si470x/radio-si470x-usb.c      |    4 +-
 drivers/media/radio/tef6862.c                      |    5 +-
 drivers/media/rc/gpio-ir-recv.c                    |   10 +-
 drivers/media/rc/gpio-ir-tx.c                      |    9 +-
 drivers/media/rc/imon.c                            |    6 +-
 drivers/media/rc/ir-rx51.c                         |    9 +-
 drivers/media/rc/ir-spi.c                          |    7 +
 drivers/media/test-drivers/Kconfig                 |    1 +
 drivers/media/test-drivers/Makefile                |    1 +
 drivers/media/test-drivers/vidtv/vidtv_bridge.c    |   22 +-
 drivers/media/test-drivers/vidtv/vidtv_demod.c     |    5 +-
 drivers/media/test-drivers/vidtv/vidtv_tuner.c     |    5 +-
 drivers/media/test-drivers/vimc/vimc-core.c        |    2 +-
 drivers/media/test-drivers/visl/Kconfig            |   29 +
 drivers/media/test-drivers/visl/Makefile           |    8 +
 drivers/media/test-drivers/visl/visl-core.c        |  541 ++++
 drivers/media/test-drivers/visl/visl-debugfs.c     |  112 +
 drivers/media/test-drivers/visl/visl-debugfs.h     |   40 +
 drivers/media/test-drivers/visl/visl-dec.c         |  499 +++
 drivers/media/test-drivers/visl/visl-dec.h         |   67 +
 drivers/media/test-drivers/visl/visl-trace-fwht.h  |   66 +
 drivers/media/test-drivers/visl/visl-trace-h264.h  |  349 ++
 drivers/media/test-drivers/visl/visl-trace-hevc.h  |  405 +++
 drivers/media/test-drivers/visl/visl-trace-mpeg2.h |   99 +
 .../media/test-drivers/visl/visl-trace-points.c    |   10 +
 drivers/media/test-drivers/visl/visl-trace-vp8.h   |  156 +
 drivers/media/test-drivers/visl/visl-trace-vp9.h   |  292 ++
 drivers/media/test-drivers/visl/visl-video.c       |  767 +++++
 drivers/media/test-drivers/visl/visl-video.h       |   27 +
 drivers/media/test-drivers/visl/visl.h             |  176 ++
 drivers/media/test-drivers/vivid/vivid-ctrls.c     |   28 +
 drivers/media/test-drivers/vivid/vivid-vbi-gen.c   |    1 -
 drivers/media/test-drivers/vivid/vivid-vid-cap.c   |    1 +
 drivers/media/tuners/e4000.c                       |    5 +-
 drivers/media/tuners/fc2580.c                      |    5 +-
 drivers/media/tuners/m88rs6000t.c                  |    5 +-
 drivers/media/tuners/mt2060.c                      |    5 +-
 drivers/media/tuners/mxl301rf.c                    |    5 +-
 drivers/media/tuners/mxl5005s.c                    |    2 +-
 drivers/media/tuners/qm1d1b0004.c                  |    4 +-
 drivers/media/tuners/qm1d1c0042.c                  |    5 +-
 drivers/media/tuners/tda18212.c                    |    5 +-
 drivers/media/tuners/tda18250.c                    |    5 +-
 drivers/media/tuners/tua9001.c                     |    5 +-
 drivers/media/usb/au0828/au0828-vbi.c              |    2 +
 drivers/media/usb/au0828/au0828-video.c            |    1 +
 drivers/media/usb/dvb-usb/az6027.c                 |    4 +
 drivers/media/usb/dvb-usb/dib0700.h                |    1 -
 drivers/media/usb/dvb-usb/dib0700_devices.c        |    7 -
 drivers/media/usb/dvb-usb/dvb-usb-init.c           |    6 +-
 drivers/media/usb/dvb-usb/m920x.c                  |   16 +-
 drivers/media/usb/em28xx/em28xx-dvb.c              |    6 +
 drivers/media/usb/go7007/s2250-board.c             |    5 +-
 drivers/media/usb/pwc/pwc-uncompress.c             |    2 +-
 drivers/media/usb/uvc/uvc_driver.c                 |    9 +-
 drivers/media/v4l2-core/tuner-core.c               |    6 +-
 drivers/media/v4l2-core/v4l2-ctrls-core.c          |    2 +-
 drivers/media/v4l2-core/v4l2-ctrls-defs.c          |    2 +
 drivers/media/v4l2-core/v4l2-fwnode.c              |   23 +-
 drivers/media/v4l2-core/v4l2-ioctl.c               |  121 +-
 drivers/media/v4l2-core/v4l2-subdev.c              |   17 +-
 drivers/phy/phy-core-mipi-dphy.c                   |   31 +-
 drivers/staging/media/Kconfig                      |    1 +
 drivers/staging/media/Makefile                     |    1 +
 drivers/staging/media/atomisp/i2c/atomisp-gc0310.c |   14 +-
 drivers/staging/media/atomisp/i2c/gc0310.h         |    1 +
 drivers/staging/media/atomisp/i2c/ov2680.h         |   46 +-
 drivers/staging/media/atomisp/include/hmm/hmm.h    |    3 +-
 drivers/staging/media/atomisp/include/hmm/hmm_bo.h |    4 +-
 drivers/staging/media/atomisp/pci/atomisp_cmd.c    |  442 +--
 drivers/staging/media/atomisp/pci/atomisp_cmd.h    |   17 +-
 drivers/staging/media/atomisp/pci/atomisp_common.h |    6 +-
 drivers/staging/media/atomisp/pci/atomisp_compat.h |   14 +-
 .../media/atomisp/pci/atomisp_compat_css20.c       |   96 +-
 drivers/staging/media/atomisp/pci/atomisp_fops.c   |  535 +---
 drivers/staging/media/atomisp/pci/atomisp_fops.h   |   13 -
 .../staging/media/atomisp/pci/atomisp_internal.h   |    1 -
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c  |  615 +---
 drivers/staging/media/atomisp/pci/atomisp_ioctl.h  |   10 +-
 drivers/staging/media/atomisp/pci/atomisp_subdev.c |    2 +
 drivers/staging/media/atomisp/pci/atomisp_subdev.h |   22 +-
 drivers/staging/media/atomisp/pci/atomisp_v4l2.c   |  104 +-
 .../camera/pipe/interface/ia_css_pipe_binarydesc.h |   13 +-
 .../camera/pipe/interface/ia_css_pipe_stagedesc.h  |    5 -
 .../atomisp/pci/camera/pipe/src/pipe_binarydesc.c  |   55 +-
 .../atomisp/pci/camera/pipe/src/pipe_stagedesc.c   |   21 -
 .../pci/css_2401_system/host/pixelgen_private.h    |    2 +-
 drivers/staging/media/atomisp/pci/hmm/hmm.c        |   20 +-
 drivers/staging/media/atomisp/pci/hmm/hmm_bo.c     |   64 +-
 .../media/atomisp/pci/ia_css_frame_public.h        |  108 +-
 drivers/staging/media/atomisp/pci/ia_css_pipe.h    |    3 +-
 .../staging/media/atomisp/pci/ia_css_pipe_public.h |   69 -
 .../ipu2_io_ls/bayer_io_ls/ia_css_bayer_io.host.c  |   10 +-
 .../yuv444_io_ls/ia_css_yuv444_io.host.c           |   10 +-
 .../pci/isp/kernels/ref/ref_1.0/ia_css_ref.host.c  |    2 +-
 .../pci/isp/kernels/tnr/tnr_1.0/ia_css_tnr.host.c  |    4 +-
 .../media/atomisp/pci/runtime/binary/src/binary.c  |   42 +-
 .../atomisp/pci/runtime/debug/src/ia_css_debug.c   |   33 +-
 .../media/atomisp/pci/runtime/frame/src/frame.c    |  203 +-
 .../runtime/pipeline/interface/ia_css_pipeline.h   |    2 -
 .../atomisp/pci/runtime/pipeline/src/pipeline.c    |    8 -
 drivers/staging/media/atomisp/pci/sh_css.c         |  646 +---
 .../staging/media/atomisp/pci/sh_css_internal.h    |   13 -
 drivers/staging/media/atomisp/pci/sh_css_legacy.h  |    1 -
 .../media/atomisp/pci/sh_css_param_shading.c       |   19 +-
 drivers/staging/media/atomisp/pci/sh_css_params.c  |   17 +-
 drivers/staging/media/atomisp/pci/sh_css_sp.c      |   54 +-
 drivers/staging/media/deprecated/atmel/Kconfig     |   47 +
 drivers/staging/media/deprecated/atmel/Makefile    |    8 +
 drivers/staging/media/deprecated/atmel/TODO        |   34 +
 .../media/deprecated}/atmel/atmel-isc-base.c       |   20 +-
 .../media/deprecated}/atmel/atmel-isc-clk.c        |    8 +-
 .../media/deprecated}/atmel/atmel-isc-regs.h       |    0
 .../media/deprecated}/atmel/atmel-isc.h            |   16 +-
 .../media/deprecated}/atmel/atmel-sama5d2-isc.c    |   18 +-
 .../media/deprecated}/atmel/atmel-sama7g5-isc.c    |   18 +-
 drivers/staging/media/deprecated/stkwebcam/Kconfig |    2 +-
 drivers/staging/media/imx/Kconfig                  |   17 +-
 drivers/staging/media/imx/Makefile                 |    3 +-
 drivers/staging/media/imx/TODO                     |   41 -
 drivers/staging/media/imx/imx-media-csi.c          |  135 +-
 drivers/staging/media/imx/imx-media-fim.c          |   57 +-
 drivers/staging/media/imx/imx-media-utils.c        |   33 -
 drivers/staging/media/imx/imx-media.h              |    1 -
 drivers/staging/media/ipu3/ipu3-v4l2.c             |   57 +-
 drivers/staging/media/meson/vdec/codec_vp9.c       |   10 +-
 drivers/staging/media/omap4iss/iss_video.c         |    2 -
 drivers/staging/media/omap4iss/iss_video.h         |   18 +-
 drivers/staging/media/rkvdec/rkvdec-vp9.c          |    3 +
 drivers/staging/media/sunxi/Kconfig                |    1 +
 drivers/staging/media/sunxi/Makefile               |    1 +
 drivers/staging/media/sunxi/cedrus/cedrus.c        |  112 +-
 drivers/staging/media/sunxi/cedrus/cedrus.h        |   38 +-
 drivers/staging/media/sunxi/cedrus/cedrus_dec.c    |    4 +-
 drivers/staging/media/sunxi/cedrus/cedrus_h264.c   |  120 +-
 drivers/staging/media/sunxi/cedrus/cedrus_h265.c   |  125 +-
 drivers/staging/media/sunxi/cedrus/cedrus_hw.c     |   18 +-
 drivers/staging/media/sunxi/cedrus/cedrus_hw.h     |    2 +-
 drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c  |    2 +-
 drivers/staging/media/sunxi/cedrus/cedrus_regs.h   |   18 +
 drivers/staging/media/sunxi/cedrus/cedrus_video.c  |  184 +-
 drivers/staging/media/sunxi/cedrus/cedrus_video.h  |    2 +
 drivers/staging/media/sunxi/cedrus/cedrus_vp8.c    |    2 +-
 drivers/staging/media/sunxi/sun6i-isp/Kconfig      |   15 +
 drivers/staging/media/sunxi/sun6i-isp/Makefile     |    4 +
 drivers/staging/media/sunxi/sun6i-isp/TODO.txt     |    6 +
 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c  |  555 ++++
 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.h  |   90 +
 .../media/sunxi/sun6i-isp/sun6i_isp_capture.c      |  742 +++++
 .../media/sunxi/sun6i-isp/sun6i_isp_capture.h      |   78 +
 .../media/sunxi/sun6i-isp/sun6i_isp_params.c       |  566 ++++
 .../media/sunxi/sun6i-isp/sun6i_isp_params.h       |   52 +
 .../staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c |  577 ++++
 .../staging/media/sunxi/sun6i-isp/sun6i_isp_proc.h |   66 +
 .../staging/media/sunxi/sun6i-isp/sun6i_isp_reg.h  |  275 ++
 .../media/sunxi/sun6i-isp/uapi/sun6i-isp-config.h  |   43 +
 drivers/staging/media/tegra-video/csi.c            |    4 +-
 drivers/staging/media/tegra-video/csi.h            |    2 +-
 drivers/staging/media/tegra-video/vi.c             |    2 +-
 include/dt-bindings/media/video-interfaces.h       |   16 +
 include/linux/phy/phy-mipi-dphy.h                  |    3 +
 include/media/davinci/vpbe.h                       |    2 +-
 include/media/dvb_ringbuffer.h                     |    2 +-
 include/media/dvbdev.h                             |   38 +-
 include/media/frame_vector.h                       |    2 +-
 include/media/i2c/ov9650.h                         |   24 -
 include/media/i2c/s5c73m3.h                        |   15 -
 include/media/i2c/s5k4ecgx.h                       |   33 -
 include/media/i2c/ths7303.h                        |    4 +-
 include/media/media-entity.h                       |    4 +-
 include/media/v4l2-mediabus.h                      |   17 +-
 include/media/v4l2-subdev.h                        |   11 +-
 include/media/videobuf2-core.h                     |   14 +
 include/media/videobuf2-memops.h                   |    3 +-
 include/uapi/linux/aspeed-video.h                  |   14 +
 include/uapi/linux/dvb/audio.h                     |   15 -
 include/uapi/linux/dvb/ca.h                        |   15 -
 include/uapi/linux/dvb/dmx.h                       |   15 -
 include/uapi/linux/dvb/frontend.h                  |   77 +-
 include/uapi/linux/dvb/net.h                       |   15 -
 include/uapi/linux/dvb/osd.h                       |   15 -
 include/uapi/linux/dvb/version.h                   |   15 -
 include/uapi/linux/dvb/video.h                     |   15 -
 include/uapi/linux/media-bus-format.h              |    3 +-
 include/uapi/linux/v4l2-common.h                   |   39 -
 include/uapi/linux/v4l2-controls.h                 |   46 +-
 include/uapi/linux/v4l2-dv-timings.h               |    9 -
 include/uapi/linux/v4l2-mediabus.h                 |    4 -
 include/uapi/linux/v4l2-subdev.h                   |   13 -
 include/uapi/linux/videodev2.h                     |    5 +
 489 files changed, 33829 insertions(+), 8815 deletions(-)
 delete mode 100644 Documentation/admin-guide/media/cec-drivers.rst
 create mode 100644 Documentation/admin-guide/media/cec.rst
 delete mode 100644 Documentation/admin-guide/media/pulse8-cec.rst
 create mode 100644 Documentation/admin-guide/media/visl.rst
 create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun6i=
-a31-isp.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/i2c/imx290.txt
 delete mode 100644 Documentation/devicetree/bindings/media/i2c/ov5645.txt
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov4689=
.yaml
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5645=
.yaml
 create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx290=
.yaml
 create mode 100644 Documentation/devicetree/bindings/media/i2c/st,st-vgxy6=
1.yaml
 create mode 100644 Documentation/devicetree/bindings/media/i2c/toshiba,tc3=
58746.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8195=
-jpegdec.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8195=
-jpegenc.yaml
 create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-c=
ru.yaml
 create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-c=
si2.yaml
 create mode 100644 Documentation/userspace-api/media/drivers/aspeed-video.=
rst
 create mode 100644 Documentation/userspace-api/media/drivers/st-vgxy61.rst
 create mode 100644 drivers/media/i2c/ov08x40.c
 create mode 100644 drivers/media/i2c/ov4689.c
 delete mode 100644 drivers/media/i2c/s5k4ecgx.c
 create mode 100644 drivers/media/i2c/st-vgxy61.c
 create mode 100644 drivers/media/i2c/tc358746.c
 create mode 100644 drivers/media/platform/microchip/Kconfig
 create mode 100644 drivers/media/platform/microchip/Makefile
 rename drivers/media/platform/{atmel =3D> microchip}/microchip-csi2dc.c (1=
00%)
 create mode 100644 drivers/media/platform/microchip/microchip-isc-base.c
 create mode 100644 drivers/media/platform/microchip/microchip-isc-clk.c
 create mode 100644 drivers/media/platform/microchip/microchip-isc-regs.h
 create mode 100644 drivers/media/platform/microchip/microchip-isc-scaler.c
 create mode 100644 drivers/media/platform/microchip/microchip-isc.h
 create mode 100644 drivers/media/platform/microchip/microchip-sama5d2-isc.c
 create mode 100644 drivers/media/platform/microchip/microchip-sama7g5-isc.c
 rename drivers/{staging/media/imx =3D> media/platform/nxp}/imx7-media-csi.=
c (91%)
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/Kconfig
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/Makefile
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
 create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge=
.c
 create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge=
.h
 create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_captur=
e.c
 create mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_captur=
e.h
 delete mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
 delete mode 100644 drivers/media/platform/sunxi/sun6i-csi/sun6i_video.h
 create mode 100644 drivers/media/test-drivers/visl/Kconfig
 create mode 100644 drivers/media/test-drivers/visl/Makefile
 create mode 100644 drivers/media/test-drivers/visl/visl-core.c
 create mode 100644 drivers/media/test-drivers/visl/visl-debugfs.c
 create mode 100644 drivers/media/test-drivers/visl/visl-debugfs.h
 create mode 100644 drivers/media/test-drivers/visl/visl-dec.c
 create mode 100644 drivers/media/test-drivers/visl/visl-dec.h
 create mode 100644 drivers/media/test-drivers/visl/visl-trace-fwht.h
 create mode 100644 drivers/media/test-drivers/visl/visl-trace-h264.h
 create mode 100644 drivers/media/test-drivers/visl/visl-trace-hevc.h
 create mode 100644 drivers/media/test-drivers/visl/visl-trace-mpeg2.h
 create mode 100644 drivers/media/test-drivers/visl/visl-trace-points.c
 create mode 100644 drivers/media/test-drivers/visl/visl-trace-vp8.h
 create mode 100644 drivers/media/test-drivers/visl/visl-trace-vp9.h
 create mode 100644 drivers/media/test-drivers/visl/visl-video.c
 create mode 100644 drivers/media/test-drivers/visl/visl-video.h
 create mode 100644 drivers/media/test-drivers/visl/visl.h
 create mode 100644 drivers/staging/media/deprecated/atmel/Kconfig
 create mode 100644 drivers/staging/media/deprecated/atmel/Makefile
 create mode 100644 drivers/staging/media/deprecated/atmel/TODO
 rename drivers/{media/platform =3D> staging/media/deprecated}/atmel/atmel-=
isc-base.c (99%)
 rename drivers/{media/platform =3D> staging/media/deprecated}/atmel/atmel-=
isc-clk.c (97%)
 rename drivers/{media/platform =3D> staging/media/deprecated}/atmel/atmel-=
isc-regs.h (100%)
 rename drivers/{media/platform =3D> staging/media/deprecated}/atmel/atmel-=
isc.h (96%)
 rename drivers/{media/platform =3D> staging/media/deprecated}/atmel/atmel-=
sama5d2-isc.c (97%)
 rename drivers/{media/platform =3D> staging/media/deprecated}/atmel/atmel-=
sama7g5-isc.c (97%)
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/Kconfig
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/Makefile
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/TODO.txt
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.h
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture=
.c
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_capture=
.h
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.c
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_params.h
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.h
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_reg.h
 create mode 100644 drivers/staging/media/sunxi/sun6i-isp/uapi/sun6i-isp-co=
nfig.h
 create mode 100644 include/dt-bindings/media/video-interfaces.h
 delete mode 100644 include/media/i2c/ov9650.h
 delete mode 100644 include/media/i2c/s5k4ecgx.h
 create mode 100644 include/uapi/linux/aspeed-video.h

