Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8215E6EDCF0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 09:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbjDYHnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 03:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbjDYHm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 03:42:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C752193;
        Tue, 25 Apr 2023 00:42:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4123D62185;
        Tue, 25 Apr 2023 07:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E17C4339B;
        Tue, 25 Apr 2023 07:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682408571;
        bh=Zx22utvbLxdU9pDRTxZTdtw1RhFBcbKYJo8Zvl8WU8s=;
        h=Date:From:To:Cc:Subject:From;
        b=K0BDqjeprraKg1QO9FFCL/B2JFsY2R5KzpsW5tW34UHo843QnpMlhDby0ZSJ4p2AM
         gJYkJrBG0ju97KhgeBJ6qccxgHM9SYQSHwZeGZf0wi+7sQXJGuAALamR8RrYKwsBlM
         S2x9keTc1YaFWKcFxOvyatKHH0qsTaC9icXWRh+TcKOlwo1L2FwAOEpRAVcpATJ58G
         IIi45zx7OETXDkPW4sNfExLfJtf6rzky/qwImA7Xi/TIdRyCfiWBIQfgUMAytPZZJ3
         WOop6UeFm/txglZuzzqxA+rRrARj2fd/l/8XAD1vSA+OjOu2uDnCYaNgWUXqkE6z30
         v5hoYTWcMXmXw==
Date:   Tue, 25 Apr 2023 08:42:45 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v6.4-rc1] media updates
Message-ID: <20230425084238.5033de10@sal.lan>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/me=
dia/v6.4-1

For:

- Removal of some old unused sensor drivers: ad9389b, m5mols, mt9m032,
  mt9t001, noon010pc30, s5k6aa, sr030pc30 and vs6624;
- New i.MX8 image sensor interface driver;
- Some new RC keymaps;
- lots of cleanups at atomisp driver to make it support standard features
  present on other webcam drivers;
- the cx18 and saa7146 now uses VB2;
- lots of cleanups and driver improvements.

Regards,
Mauro

---

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/me=
dia/v6.4-1

for you to fetch changes up to 73b41dc51fbeffa4a216b20193274cfe92b5d95b:

  media: ov5670: Fix probe on ACPI (2023-04-25 08:30:18 +0100)

----------------------------------------------------------------
media updates for v6.4-rc1

----------------------------------------------------------------
Alexander Stein (5):
      media: dt-bindings: media: i2c: Add imx327 version to IMX327 bindings
      media: i2c: imx290: Add support for imx327 variant
      media: imx: imx7-media-csi: Fix mbus framefmt field init
      media: imx: imx7-media-csi: Fail on invalid type in VIDIOC_G_SELECTION
      media: i2c: imx290: Add missing \n on dev_err_probe() message

Allen-KH Cheng (2):
      media: dt-bindings: media: mediatek: Rename child node names for deco=
der
      media: dt-bindings: media: mediatek: Remove "dma-ranges" property for=
 decoder

Andy Shevchenko (2):
      media: i2c: imx290: Make use of get_unaligned_le24(), put_unaligned_l=
e24()
      media: i2c: imx290: Use device_property_read_u32() directly

Arec Kao (1):
      media: ov13b10: Support device probe in non-zero ACPI D state

Arnd Bergmann (1):
      media: i2c: imx290: fix conditional function definitions

Benjamin Gaignard (7):
      media: verisilicon: Do not set context src/dst formats in reset funct=
ions
      media: verisilicon: Do not use ctx fields as format storage when rese=
tting
      media: verisilicon: Do not set ctx->bit_depth in hantro_try_ctrl()
      media: verisilicon: Do not change context bit depth before validating=
 the format
      media: verisilicon: HEVC: Only propose 10 bits compatible pixels form=
ats
      media: verisilicon: VP9: Only propose 10 bits compatible pixels forma=
ts
      media: verisilicon: Fix crash when probing encoder

Benjamin Mugnier (4):
      media: i2c: st-vgxy61: Remove duplicate default mode set on probe
      media: i2c: st-vgxy61: Move 'detect' call to 'power_on'
      media: i2c: st-vgxy61: Fix control flow error on probe
      media: i2c: st-vgxy61: Use VGXY61_NB_POLARITIES instead of hardcoded =
value in tx_from_ep

Biju Das (2):
      media: dt-bindings: media: renesas,fcp: Document RZ/{G2L,V2L} FCPVD b=
indings
      media: dt-bindings: media: renesas,vsp1: Document RZ/V2L VSPD bindings

Bingbu Cao (3):
      media: ov13b10: remove streaming mode set from reg_list
      media: ipu3-cio2: support multiple sensors and VCMs with same HID
      media: ipu3-cio2: support more camera sensors in cio2-bridge

Bryan O'Donoghue (1):
      media: MAINTAINERS: Add myself as CAMSS maintainer

Christian Hewitt (3):
      media: dt-bindings: rc: add rc-dreambox
      media: dt-bindings: rc: add rc-beelink-mxiii
      media: rc: add Beelink Mini MXIII keymap

Christophe JAILLET (1):
      media: i2c: ov7670: Use the devm_clk_get_optional() helper

Colin Ian King (1):
      media: platform: exynos4-is: Fix spelling mistake "palne" -> "plane"

Dan Carpenter (1):
      media: av7110: prevent underflow in write_ts_to_decoder()

Daniel Lundberg Pedersen (1):
      media: docs: vidioc-g-ext-ctrls.rst: Document p_s32 and p_s64 fields

Dave Stevenson (15):
      media: dt-bindings: media: i2c: Add mono version to IMX290 bindings
      media: i2c: imx290: Add support for the mono sensor variant
      media: i2c: imx290: Match kernel coding style on whitespace
      media: i2c: imx290: Set the colorspace fields in the format
      media: i2c: imx290: Add V4L2_SUBDEV_FL_HAS_EVENTS and subscribe hooks
      media: i2c: imx290: Fix the pixel rate at 148.5Mpix/s
      media: i2c: imx290: Support 60fps in 2 lane operation
      media: i2c: imx290: Use CSI timings as per datasheet
      media: i2c: imx290: Convert V4L2_CID_HBLANK to read/write
      media: i2c: imx290: Convert V4L2_CID_VBLANK to read/write
      media: i2c: imx290: VMAX is mode dependent
      media: i2c: imx290: Remove duplicated write to IMX290_CTRL_07
      media: i2c: imx290: Add support for 74.25MHz external clock
      media: i2c: imx290: Add support for H & V Flips
      media: i2c: imx290: Add the error code to logs in start_streaming

Dikshita Agarwal (1):
      venus: venc: add handling for VIDIOC_ENCODER_CMD

Dorota Czaplejewicz (2):
      media: doc/media api: Try to make enum usage clearer
      media: media api: Try to make enum usage clearer

Emanuel Strobel (1):
      media: rc: add common keymap for Dreambox RC10/RC0 and RC20/RC-BT rem=
otes

Florian Fainelli (2):
      dt-bindings: media: gpio-ir-receiver: Document wakeup-souce property
      media: rc: gpio-ir-recv: Fix support for wake-up

Frieder Schrempf (1):
      media: imx: imx7-media-csi: Fix error handling in imx7_csi_async_regi=
ster()

Fritz Koenig (1):
      media: venus: Correct P010 buffer alignment

Gaosheng Cui (1):
      media: vsp1: Remove unused vsp1_subdev_internal_ops declaration

Hans Verkuil (41):
      media: vb2: set owner before calling vb2_read
      media: v4l2-dev.c: check for V4L2_CAP_STREAMING to enable streaming i=
octls
      media: cx18: convert to vb2
      media: cx18: fix incorrect input counting
      media: cx18: properly report pixelformats
      media: cx18: missing CAP_AUDIO for vbi stream
      media: cx18: reorder fmt_vid_cap functions in cx18-ioctl.c
      media: cx18: fix format compliance issues
      media: admin-guide/media/cec.rst: update CEC debugging doc
      media: stm32: dma2d: remove unused fb_buf
      media: zoran: drop two obsolete prototypes from zoran_device.h
      media: common: btcx-risc.h: drop obsolete header
      media: saa7146: drop overlay support
      media: saa7134: drop overlay support
      media: bttv: drop overlay support
      media: vivid: drop overlay support
      media: vivid: drop bitmap and clipping output overlay support
      media: v4l2-core: drop v4l2_window clipping and bitmap support
      media: videodev.h: drop V4L2_FBUF_CAP_LIST/BITMAP_CLIPPING
      media: v4l2-core: zero field base in struct v4l2_framebuffer
      media: Documentation: userspace-api: media: drop clipping, destructiv=
e overlays
      media: cec: core: not all messages were passed on when monitoring
      media: Documentation: admin-guide: cec.rst: document NTP issue
      media: common: saa7146: disable clipping
      media: common/saa7146: fix VFL direction for vbi output
      media: pci: saa7146: hexium_orion: initialize input 0
      media: saa7146: drop 'dev' and 'resources' from struct saa7146_fh
      media: common: saa7146: drop 'fmt' from struct saa7146_buf
      media: common: saa7146: replace BUG_ON by WARN_ON
      media: staging: media: av7110: replace BUG_ON by WARN_ON
      media: common: saa7146: fix broken V4L2_PIX_FMT_YUV422P support
      media: common: saa7146: use for_each_sg_dma_page
      media: saa7146: convert to vb2
      media: common: saa7146: fix compliance problems with field handling
      media: common: saa7146: check minimum video format size
      media: common: saa7146: allow S_STD(G_STD)
      media: mxb: update the tvnorms when changing input
      media: common: saa7146: add support for missing .vidioc_try_fmt_vbi_c=
ap
      media: mxb: allow tuner/input/audio ioctls for vbi
      media: pci: saa7146: advertise only those TV standard that are suppor=
ted
      media: staging: media: av7110: fix VBI output support

Hans de Goede (38):
      media: atomisp: Remove depth-mode support
      media: atomisp: Remove continuous mode support
      media: atomisp: Remove delayed_init related code
      media: atomisp: Remove crop_needs_override from atomisp_set_fmt()
      media: atomisp: Remove atomisp_css_enable_raw_binning()
      media: atomisp: Remove atomisp_get_metadata_type()
      media: atomisp: Remove unused SOC_CAMERA, XENON_FLASH and FILE_INPUT =
subdev types
      media: atomisp: Remove ATOMISP_USE_YUVPP()
      media: atomisp: Remove yuvpp_mode
      media: atomisp: Remove online_process setting
      media: atomisp: Add v4l2_get_acpi_sensor_info() helper
      media: atomisp: ov2680: Use v4l2_get_acpi_sensor_info() for the GPIO =
lookups
      media: atomisp: ov2680: Error handling fixes
      media: atomisp: gc0310: Remove some unused structure definitions
      media: atomisp: gc0310: Remove GC0310_TOK_*
      media: atomisp: gc0310: Simplify gc0310_write_reg_array()
      media: atomisp: gc0310: Remove enum gc0310_tok_type
      media: atomisp: gc0310: Replace custom reg access functions with smbu=
s helpers
      media: atomisp: gc0310: Remove non working flip-controls
      media: atomisp: gc0310: Remove read-only exposure control
      media: atomisp: gc0310: Drop custom ATOMISP_IOC_S_EXPOSURE support
      media: atomisp: gc0310: Add exposure and gain controls
      media: atomisp: gc0310: Add error_unlock label to s_stream()
      media: atomisp: gc0310: Modernize and simply set_fmt(), get_fmt(), et=
c.
      media: atomisp: gc0310: Delay power-on till streaming is started
      media: atomisp: gc0310: Add runtime-pm support
      media: atomisp: gc0310: Use devm_kzalloc() for data struct
      media: atomisp: gc0310: Switch over to ACPI powermanagement
      media: atomisp: Remove duplicate atomisp_[start|stop]_streaming() pro=
totypes
      media: atomisp: Remove continuous mode related code from atomisp_set_=
fmt()
      media: atomisp: Remove custom V4L2_CID_FMT_AUTO control
      media: atomisp: Remove snr_mbus_fmt local var from atomisp_try_fmt()
      media: atomisp: Remove unused ATOM_ISP_MAX_WIDTH_TMP and ATOM_ISP_MAX=
_HEIGHT_TMP
      media: atomisp: Remove atomisp_try_fmt() call from atomisp_set_fmt()
      media: atomisp: Drop support for streaming from 2 sensors at once
      media: atomisp: Remove struct atomisp_sub_device index field
      media: atomisp: gmin_platform: Make DMI quirks take precedence over t=
he _DSM table
      media: atomisp: gmin_platform: Add Lenovo Ideapad Miix 310 gmin_vars

Irui Wang (1):
      media: mediatek: vcodec: Coverity issues in encoder driver

Jacopo Mondi (5):
      media: i2c: ov5647: Use bus-locked i2c_transfer()
      media: i2c: ov5670: Properly handle !CONFIG_HAVE_CLK
      media: imx258: Register H/V flip controls
      media: imx258: Remove mandatory 180 degrees rotation
      media: nxp: imx8-isi: Remove 300ms sleep after enabling channel

Jakub Kicinski (1):
      media: drop unnecessary networking includes

Jason Kim (1):
      media: mc-device: remove unnecessary __must_check

Javier Martinez Canillas (2):
      media: Revert "venus: firmware: Correct non-pix start and end address=
es"
      media: venus: dec: Fix capture formats enumeration order

Jiasheng Jiang (2):
      media: bdisp: Add missing check for create_workqueue
      media: platform: mtk-mdp3: Add missing check and free for ida_alloc

Jim Lai (1):
      media: hi556: add 2592x1444 resolution

Jonathan Neusch=C3=A4fer (1):
      media: dvb-frontends: Fix a typo ("Unknow sleep mode")

Kees Cook (2):
      media: mxl5005s: Bounds check size used for max array index
      media: imx-jpeg: Bounds check sizeimage access

Kevin Chiu (1):
      media: platform: cros-ec: Add Gladios/Lisbon to the match table

Krzysztof Kozlowski (21):
      media: dt-bindings: silabs,si470x: Convert to DT schema
      media: dt-bindings: samsung-fimc: drop simple-bus
      media: samsung: exynos4-is: do not require pinctrl
      media: samsung: exynos4-is: drop simple-bus from compatibles
      media: dt-bindings: i2c: samsung,s5k6a3: convert to dtschema
      media: dt-bindings: i2c: samsung,s5k5baf: convert to dtschema
      media: dt-bindings: samsung,exynos4210-csis: convert to dtschema
      media: dt-bindings: samsung,exynos4212-fimc-lite: convert to dtschema
      media: dt-bindings: samsung,exynos4212-is: convert to dtschema
      media: dt-bindings: samsung,fimc: convert to dtschema
      media: dt-bindings: samsung,s5c73m3: convert to dtschema
      media: dt-bindings: st,stm32-cec: drop obsolete file
      media: dt-bindings: qcom,venus: cleanup
      media: dt-bindings: qcom,venus: split common properties
      media: dt-bindings: qcom,msm8996-venus: document interconnects
      media: dt-bindings: qcom,sc7180-venus: document OPP table
      media: dt-bindings: qcom,sc7280-venus: document OPP table
      media: dt-bindings: qcom,sdm845-venus-v2: document OPP table
      media: dt-bindings: qcom,sm8250-venus: document OPP table
      media: dt-bindings: qcom,venus: document firmware-name
      media: venus: drop unused opp_table field documentation

Laurent Pinchart (27):
      media: i2c: imx296: Use v4l2_subdev_get_fmt()
      media: max9286: Free control handler
      media: vsp1: Replace vb2_is_streaming() with vb2_start_streaming_call=
ed()
      staging: media: imx: Drop imx_media_subdev_bound()
      staging: media: imx: Drop IMX_MEDIA_GRP_ID_CSI
      staging: media: imx: Drop unused helper functions
      staging: media: imx: Make imx_media_of_add_csi() static
      media: i2c: adv7604: Enable video adjustment
      media: i2c: adv7604: Fix range of hue control
      media: Accept non-subdev sinks in v4l2_create_fwnode_links_to_pad()
      media: Fix indentation issues introduced by subdev-wide state struct
      media: imx-jpeg: Fix incorrect indentation
      media: Zero-initialize all structures passed to subdev pad operations
      media: Prefer designated initializers over memset for subdev pad ops
      media: Use designated initializers for all subdev pad ops
      media: i2c: Drop unused ad9389b video encoder driver
      media: i2c: Drop unused m5mols camera sensor driver
      media: i2c: Drop unused mt9m032 camera sensor driver
      media: i2c: Drop unused mt9t001 camera sensor driver
      media: i2c: Drop unused noon010pc30 camera sensor driver
      media: i2c: Drop unused s5k6aa camera sensor driver
      media: i2c: Drop unused sr030pc30 camera sensor driver
      media: i2c: Drop unused vs6624 camera sensor driver
      media: dt-bindings: media: Add i.MX8 ISI DT bindings
      media: nxp: Add i.MX8 ISI driver
      media: nxp: imx8-isi: Drop partial support for i.MX8QM and i.MX8QXP
      media: nxp: imx8-isi: Replace udelay() with fsleep()

Luca Weiss (8):
      media: i2c: ov5670: Use dev_err_probe in probe function
      media: i2c: ov5670: Support single-lane operation
      media: i2c: ov2685: Add print for power on write failed
      media: i2c: ov2685: Add controls from fwnode
      media: i2c: ov2685: Add .get_selection() support
      media: dt-bindings: media: rkisp1: complete ov2685 example
      media: dt-bindings: ov2685: convert to dtschema
      media: i2c: ov2685: Make reset gpio optional

Marek Vasut (1):
      media: stm32-dcmi: Enable incoherent buffer allocation

Martin Kepplinger (2):
      media: imx: imx8mq-mipi-csi2: Use V4L2 subdev active state
      media: imx: imx8mq-mipi-csi2: Remove unneeded state variable and func=
tion

Miaoqian Lin (2):
      media: v4l2-ctrls: Fix doc for v4l2_ctrl_request_hdl_find
      media: rcar_fdp1: Fix refcount leak in probe and remove function

Micha=C5=82 Krawczyk (1):
      media: venus: dec: Fix handling of the start cmd

Milen Mitkov (4):
      media: camss: sm8250: Virtual channels for CSID
      media: camss: vfe: Reserve VFE lines on stream start and link to CSID
      media: camss: vfe-480: Multiple outputs support for SM8250
      media: camss: sm8250: Pipeline starting and stopping for multiple vir=
tual channels

Ming Qian (15):
      media: amphion: decoder implement display delay enable
      media: add Sorenson Spark video format
      media: amphion: support to decode sorenson spark video
      media: add RealVideo format RV30 and RV40
      media: amphion: support to decode RealVideo video
      media: Add P012 and P012M video format
      media: Add Y012 video format
      media: Add Y212 v4l2 format info
      media: Add YUV48_12 video format
      media: Add BGR48_12 video format
      media: Add ABGR64_12 video format
      media: imx-jpeg: Refine the function mxc_jpeg_find_format
      media: imx-jpeg: Clear slot next desc ptr if config error
      media: imx-jpeg: Decoder add support for 12bit jpeg
      media: imx-jpeg: Encoder add support for 12bit jpeg

Moudy Ho (12):
      media: platform: mtk-mdp3: fix potential frame size overflow in mdp_t=
ry_fmt_mplane()
      media: platform: mtk-mdp3: add files for chip configuration
      media: platform: mtk-mdp3: chip config split about component settings
      media: platform: mtk-mdp3: chip config split about subcomponents
      media: platform: mtk-mdp3: chip config split about color format
      media: platform: mtk-mdp3: chip config split about resolution limitat=
ions
      media: platform: mtk-mdp3: chip config split about pipe info
      media: platform: mtk-mdp3: extend mdp_color format for compressed mode
      media: platform: mtk-mdp3: dynamically allocate component clocks
      media: platform: mtk-mdp3: Split general definitions used in MDP3
      media: platform: mtk-mdp3: decompose hardware-related information in =
shared memory
      media: platform: mtk-mdp3: reconfigure shared memory

Neil Armstrong (1):
      media: dt-bindings: media: convert meson-ir.txt to dt-schema

Niklas S=C3=B6derlund (6):
      media: i2c: adv748x: Fix lookup of DV timings
      media: i2c: adv748x: Write initial DV timings to device
      media: i2c: adv748x: Report correct DV timings for pattern generator
      media: dt-bindings: media: renesas,isp: Add binding for V4H
      media: dt-bindings: media: renesas,csi2: Add binding for V4H
      media: dt-bindings: media: renesas,vin: Add binding for V4H

Oliver Neukum (1):
      usbtv: usbtv_set_regs: the pipe is output

Paul Elder (3):
      media: docs: media: v4l: uapi: Fix field type for SUBDEV_ENUM_FRAME_S=
IZE
      media: rkisp1: Add NV16M and NV61M to output formats
      media: rkisp1: Implement ENUM_FRAMESIZES

Pin-yen Lin (1):
      media: mediatek: vcodec: Use 4K frame size when supported by stateful=
 decoder

Ricardo Ribalda (1):
      media: ov8856: Do not check for for module version

Rob Herring (2):
      media: dt-bindings: Drop unneeded quotes
      media: Use of_property_present() for testing DT property presence

Robert Mader (1):
      media: i2c: imx258: Parse and register properties

Sakari Ailus (12):
      media: v4l: subdev: Make link validation safer
      media: ov2685: Select VIDEO_V4L2_SUBDEV_API
      media: v4l: async: Return async sub-devices to subnotifier list
      MAINTAINERS: Assume ov8856 driver maintainership
      media: dt-bindings: ov8856: Assign maintainership to myself
      media: ccs: Align flipping behaviour with other drivers
      media: ccs: Add V4L2 controls from properties
      media: ccs: Support 16-bit sensor revision number register
      media: ccs: Apply module manufacturer hack on non-CCS devices only
      media: ccs: Differentiate SMIA and MIPI vendors in static data
      media: ccs: Document CCS static data file names
      media: ov5670: Fix probe on ACPI

Shravan Chippa (4):
      media: i2c: imx334: replace __v4l2_ctrl_s_ctrl to __v4l2_ctrl_modify_=
range
      media: i2c: imx334: add missing reset values for mode 3840x2160_regs[]
      media: i2c: imx334: support lower bandwidth mode
      media: dt-bindings: media: i2c: imx334 add new link_freq

Tom Rix (1):
      media: pvrusb2: VIDEO_PVRUSB2 depends on DVB_CORE to use dvb_* symbols

Tomi Valkeinen (6):
      media: subdev: Fix validation state lockdep issue
      media: subdev: Use 'shall' instead of 'may' in route validation
      media: subdev: Split V4L2_SUBDEV_ROUTING_NO_STREAM_MIX
      media: subdev: Add V4L2_SUBDEV_ROUTING_NO_MULTIPLEXING
      media: vsp1: Add underrun debug print
      media: v4l2-subdev: Add new ioctl for client capabilities

Tsuchiya Yuto (1):
      media: atomisp: Remove remaining instance of call to trace_printk

Uwe Kleine-K=C3=B6nig (128):
      media: cec-gpio: Convert to platform remove callback returning void
      media: cros-ec-cec: Don't exit early in .remove() callback
      media: cros-ec-cec: Convert to platform remove callback returning void
      media: ao-cec-g12a: Convert to platform remove callback returning void
      media: ao-cec: Convert to platform remove callback returning void
      media: s5p_cec: Convert to platform remove callback returning void
      media: seco-cec: Convert to platform remove callback returning void
      media: stih-cec: Convert to platform remove callback returning void
      media: stm32-cec: Convert to platform remove callback returning void
      media: tegra_cec: Convert to platform remove callback returning void
      media: rtl2832_sdr: Convert to platform remove callback returning void
      media: zd1301_demod: Convert to platform remove callback returning vo=
id
      media: allegro-core: Convert to platform remove callback returning vo=
id
      media: ge2d: Convert to platform remove callback returning void
      media: vpu_core: Convert to platform remove callback returning void
      media: vpu_drv: Convert to platform remove callback returning void
      media: aspeed-video: Convert to platform remove callback returning vo=
id
      media: atmel-isi: Convert to platform remove callback returning void
      media: cdns-csi2rx: Convert to platform remove callback returning void
      media: cdns-csi2tx: Convert to platform remove callback returning void
      media: coda-common: Convert to platform remove callback returning void
      media: pxa_camera: Convert to platform remove callback returning void
      media: m2m-deinterlace: Convert to platform remove callback returning=
 void
      media: marvell: Simplify remove callback
      media: marvell: Convert to platform remove callback returning void
      media: mtk_jpeg_core: Convert to platform remove callback returning v=
oid
      media: mtk_mdp_core: Convert to platform remove callback returning vo=
id
      media: mtk-mdp3-core: Convert to platform remove callback returning v=
oid
      media: mtk_vcodec_dec_drv: Convert to platform remove callback return=
ing void
      media: mtk_vcodec_enc_drv: Convert to platform remove callback return=
ing void
      media: mtk_vpu: Convert to platform remove callback returning void
      media: microchip-csi2dc: Convert to platform remove callback returnin=
g void
      media: microchip-sama5d2-isc: Convert to platform remove callback ret=
urning void
      media: microchip-sama7g5-isc: Convert to platform remove callback ret=
urning void
      media: vde: Convert to platform remove callback returning void
      media: dw100: Convert to platform remove callback returning void
      media: mxc-jpeg: Convert to platform remove callback returning void
      media: imx-mipi-csis: Convert to platform remove callback returning v=
oid
      media: imx-pxp: Convert to platform remove callback returning void
      media: imx7-media-csi: Convert to platform remove callback returning =
void
      media: mx2_emmaprp: Convert to platform remove callback returning void
      media: camss: Convert to platform remove callback returning void
      media: venus: Warn only once about problems in .remove()
      media: venus: Convert to platform remove callback returning void
      media: vdec: Convert to platform remove callback returning void
      media: venc: Convert to platform remove callback returning void
      media: rcar-fcp: Convert to platform remove callback returning void
      media: rcar-isp: Convert to platform remove callback returning void
      media: rcar-core: Convert to platform remove callback returning void
      media: rcar-csi2: Convert to platform remove callback returning void
      media: rcar_drif: Convert to platform remove callback returning void
      media: rcar_fdp1: Convert to platform remove callback returning void
      media: rcar_jpu: Convert to platform remove callback returning void
      media: renesas-ceu: Convert to platform remove callback returning void
      media: rzg2l-core: Convert to platform remove callback returning void
      media: rzg2l-csi2: Convert to platform remove callback returning void
      media: sh_vou: Convert to platform remove callback returning void
      media: vsp1_drv: Convert to platform remove callback returning void
      media: rga: Convert to platform remove callback returning void
      media: rkisp1-dev: Convert to platform remove callback returning void
      media: gsc-core: Convert to platform remove callback returning void
      media: fimc-core: Convert to platform remove callback returning void
      media: fimc-is-i2c: Convert to platform remove callback returning void
      media: fimc-is: Convert to platform remove callback returning void
      media: fimc-lite: Convert to platform remove callback returning void
      media: media-dev: Convert to platform remove callback returning void
      media: mipi-csis: Convert to platform remove callback returning void
      media: camif-core: Convert to platform remove callback returning void
      media: g2d: Convert to platform remove callback returning void
      media: jpeg-core: Convert to platform remove callback returning void
      media: s5p_mfc: Convert to platform remove callback returning void
      media: bdisp-v4l2: Convert to platform remove callback returning void
      media: c8sectpfe-core: Convert to platform remove callback returning =
void
      media: delta-v4l2: Convert to platform remove callback returning void
      media: hva-v4l2: Convert to platform remove callback returning void
      media: dma2d: Convert to platform remove callback returning void
      media: stm32-dcmi: Convert to platform remove callback returning void
      media: sun4i_csi: Convert to platform remove callback returning void
      media: sun6i_csi: Convert to platform remove callback returning void
      media: sun6i_mipi_csi2: Convert to platform remove callback returning=
 void
      media: sun8i_a83t_mipi_csi2: Convert to platform remove callback retu=
rning void
      media: sun8i-di: Convert to platform remove callback returning void
      media: sun8i_rotate: Convert to platform remove callback returning vo=
id
      media: am437x-vpfe: Convert to platform remove callback returning void
      media: cal: Convert to platform remove callback returning void
      media: vpif: Convert to platform remove callback returning void
      media: vpif_capture: Convert to platform remove callback returning vo=
id
      media: vpif_display: Convert to platform remove callback returning vo=
id
      media: omap_vout: Convert to platform remove callback returning void
      media: isp: Convert to platform remove callback returning void
      media: vpe: Convert to platform remove callback returning void
      media: hantro_drv: Convert to platform remove callback returning void
      media: via-camera: Convert to platform remove callback returning void
      media: video-mux: Convert to platform remove callback returning void
      media: xilinx-csi2rxss: Convert to platform remove callback returning=
 void
      media: xilinx-tpg: Convert to platform remove callback returning void
      media: xilinx-vipp: Convert to platform remove callback returning void
      media: xilinx-vtc: Convert to platform remove callback returning void
      media: radio-si476x: Convert to platform remove callback returning vo=
id
      media: radio-timb: Convert to platform remove callback returning void
      media: radio-wl1273: Convert to platform remove callback returning vo=
id
      media: radio-platform-si4713: Convert to platform remove callback ret=
urning void
      media: gpio-ir-recv: Convert to platform remove callback returning vo=
id
      media: img-ir-core: Convert to platform remove callback returning void
      media: ir-hix5hd2: Convert to platform remove callback returning void
      media: meson-ir-tx: Convert to platform remove callback returning void
      media: meson-ir: Convert to platform remove callback returning void
      media: mtk-cir: Convert to platform remove callback returning void
      media: st_rc: Convert to platform remove callback returning void
      media: sunxi-cir: Convert to platform remove callback returning void
      media: vicodec-core: Convert to platform remove callback returning vo=
id
      media: vidtv_bridge: Convert to platform remove callback returning vo=
id
      media: vim2m: Convert to platform remove callback returning void
      media: vimc-core: Convert to platform remove callback returning void
      media: visl-core: Convert to platform remove callback returning void
      media: vivid-core: Convert to platform remove callback returning void
      media: it913x: Convert to platform remove callback returning void
      media: staging: media: atmel-sama5d2-isc: Convert to platform remove =
callback returning void
      media: staging: media: atmel-sama7g5-isc: Convert to platform remove =
callback returning void
      media: staging: media: imx-media-csi: Convert to platform remove call=
back returning void
      media: staging: media: imx-media-dev: Convert to platform remove call=
back returning void
      media: staging: media: imx6-mipi-csi2: Convert to platform remove cal=
lback returning void
      media: staging: media: imx8mq-mipi-csi2: Convert to platform remove c=
allback returning void
      media: staging: media: meson: vdec: Convert to platform remove callba=
ck returning void
      media: staging: media: omap4iss: Convert to platform remove callback =
returning void
      media: staging: media: rkvdec: Convert to platform remove callback re=
turning void
      media: staging: media: sunxi: cedrus: Convert to platform remove call=
back returning void
      media: staging: media: sun6i-isp: Convert to platform remove callback=
 returning void

Valentine Barshak (1):
      media: i2c: ov5647: Add test pattern control

Viswanath Boma (2):
      venus: Fix for H265 decoding failure.
      venus: Add support for min/max qp range.

Wei Chen (2):
      media: hi846: Fix memleak in hi846_init_controls()
      media: mediatek: vcodec: Fix potential array out-of-bounds in decoder=
 queue_setup

Wolfram Sang (3):
      media: rcar-vin: remove R-Car H3 ES1.* handling
      media: rcar-vin: csi2: remove R-Car H3 ES1.* handling
      media: renesas: fdp1: remove R-Car H3 ES1.* handling

Yang Li (2):
      media: tc358746: Remove unneeded semicolon
      media: atmel: atmel-isc: Use devm_platform_ioremap_resource()

Ye Xingchen (4):
      media: dw100: use devm_platform_get_and_ioremap_resource()
      media: platform: renesas: use=C2=A0devm_platform_get_and_ioremap_reso=
urce()
      media: platform: stm32: use=C2=A0devm_platform_get_and_ioremap_resour=
ce()
      media: hantro: use=C2=A0devm_reset_control_array_get_optional_exclusi=
ve()

Yu Zhe (1):
      media: au0828: remove unnecessary (void*) conversions

Yunfei Dong (13):
      media: dt-bindings: media: mediatek: vcodec: adapt to the 'clock-name=
s' of different platforms
      media: dt-bindings: media: mediatek: vcodec: Change the max reg value=
 to 2
      media: mediatek: vcodec: Make MM21 the default capture format
      media: mediatek: vcodec: Force capture queue format to MM21
      media: mediatek: vcodec: add params to record lat and core lat_buf co=
unt
      media: mediatek: vcodec: using each instance lat_buf count replace co=
re ready list
      media: mediatek: vcodec: move lat_buf to the top of core list
      media: mediatek: vcodec: add core decode done event
      media: mediatek: vcodec: remove unused lat_buf
      media: mediatek: vcodec: making sure queue_work successfully
      media: mediatek: vcodec: change lat thread decode error condition
      media: mediatek: vcodec: fix decoder disable pm crash
      media: mediatek: vcodec: add remove function for decoder platform dri=
ver

Zheng Wang (4):
      media: cedrus: fix use after free bug in cedrus_remove due to race co=
ndition
      media: rkvdec: fix use after free bug in rkvdec_remove
      media: dm1105: Fix use after free bug in dm1105_remove due to race co=
ndition
      media: saa7134: fix use after free bug in saa7134_finidev due to race=
 condition

Zoey Wu (1):
      media: platform: cros-ec: Add aurash to the match table

harperchen (3):
      media: cx23885: Fix a null-ptr-deref bug in buffer_prepare() and buff=
er_finish()
      media: platform: via: Handle error for dma_set_mask
      media: pci: tw68: Fix null-ptr-deref bug in buf prepare and finish

kyrie wu (7):
      media: mtk-jpeg: Fixes jpeghw multi-core judgement
      media: mtk-jpeg: add jpeg single core initial function
      media: mtk-jpeg: Fixes jpeg enc&dec worker sw flow
      media: mtk-jpeg: reconstructs the initialization mode of worker
      media: mtk-jpeg: Remove some unnecessary variables
      media: mtk-jpeg: refactor some variables
      media: mtk-jpeg: refactor hw dev initializaiton

oushixiong (1):
      media: mtk-jpegenc: Fix a compilation issue

 Documentation/admin-guide/media/cec.rst            |   79 +-
 Documentation/admin-guide/media/i2c-cardlist.rst   |    8 -
 .../bindings/media/allwinner,sun4i-a10-ir.yaml     |    2 +-
 .../bindings/media/allwinner,sun50i-h6-vpu-g2.yaml |    4 +-
 .../bindings/media/amlogic,axg-ge2d.yaml           |    4 +-
 .../devicetree/bindings/media/amlogic,gx-vdec.yaml |    4 +-
 .../bindings/media/amlogic,meson-ir-tx.yaml        |    4 +-
 .../bindings/media/amlogic,meson6-ir.yaml          |   47 +
 .../devicetree/bindings/media/exynos-fimc-lite.txt |   16 -
 .../devicetree/bindings/media/exynos4-fimc-is.txt  |   50 -
 .../bindings/media/gpio-ir-receiver.yaml           |    3 +
 .../bindings/media/i2c/chrontel,ch7322.yaml        |    4 +-
 .../bindings/media/i2c/dongwoon,dw9768.yaml        |    6 +-
 .../bindings/media/i2c/maxim,max9286.yaml          |    2 +-
 .../devicetree/bindings/media/i2c/ov2685.txt       |   41 -
 .../devicetree/bindings/media/i2c/ov8856.yaml      |    2 +-
 .../bindings/media/i2c/ovti,ov02a10.yaml           |    2 +-
 .../devicetree/bindings/media/i2c/ovti,ov2685.yaml |  101 ++
 .../bindings/media/i2c/samsung,s5k5baf.yaml        |  101 ++
 .../bindings/media/i2c/samsung,s5k6a3.yaml         |   98 ++
 .../devicetree/bindings/media/i2c/sony,imx290.yaml |   25 +-
 .../devicetree/bindings/media/i2c/sony,imx334.yaml |    2 +-
 .../bindings/media/mediatek,mdp3-rdma.yaml         |    2 +-
 .../media/mediatek,vcodec-subdev-decoder.yaml      |  117 +-
 .../devicetree/bindings/media/meson-ir.txt         |   20 -
 .../bindings/media/microchip,sama5d4-vdec.yaml     |    4 +-
 .../devicetree/bindings/media/nxp,imx8-isi.yaml    |  173 ++
 .../devicetree/bindings/media/nxp,imx8mq-vpu.yaml  |    4 +-
 .../bindings/media/qcom,msm8916-camss.yaml         |    4 +-
 .../bindings/media/qcom,msm8916-venus.yaml         |   86 +-
 .../bindings/media/qcom,msm8996-camss.yaml         |    4 +-
 .../bindings/media/qcom,msm8996-venus.yaml         |  146 +-
 .../bindings/media/qcom,sc7180-venus.yaml          |   97 +-
 .../bindings/media/qcom,sc7280-venus.yaml          |  132 +-
 .../bindings/media/qcom,sdm660-camss.yaml          |    4 +-
 .../bindings/media/qcom,sdm660-venus.yaml          |  144 +-
 .../bindings/media/qcom,sdm845-camss.yaml          |    4 +-
 .../bindings/media/qcom,sdm845-venus-v2.yaml       |  108 +-
 .../bindings/media/qcom,sdm845-venus.yaml          |  104 +-
 .../bindings/media/qcom,sm8250-camss.yaml          |    4 +-
 .../bindings/media/qcom,sm8250-venus.yaml          |  122 +-
 .../bindings/media/qcom,venus-common.yaml          |   73 +
 Documentation/devicetree/bindings/media/rc.yaml    |    4 +-
 .../devicetree/bindings/media/renesas,csi2.yaml    |    1 +
 .../devicetree/bindings/media/renesas,fcp.yaml     |   45 +-
 .../devicetree/bindings/media/renesas,isp.yaml     |    1 +
 .../devicetree/bindings/media/renesas,vin.yaml     |    1 +
 .../devicetree/bindings/media/renesas,vsp1.yaml    |   13 +-
 .../bindings/media/rockchip,rk3568-vepu.yaml       |    4 +-
 .../devicetree/bindings/media/rockchip-isp1.yaml   |   19 +-
 .../devicetree/bindings/media/rockchip-vpu.yaml    |    4 +-
 .../bindings/media/samsung,exynos4210-csis.yaml    |  170 ++
 .../bindings/media/samsung,exynos4210-fimc.yaml    |  152 ++
 .../bindings/media/samsung,exynos4212-fimc-is.yaml |  220 +++
 .../media/samsung,exynos4212-fimc-lite.yaml        |   63 +
 .../devicetree/bindings/media/samsung,fimc.yaml    |  279 ++++
 .../devicetree/bindings/media/samsung,s5c73m3.yaml |  165 ++
 .../devicetree/bindings/media/samsung-fimc.txt     |  209 ---
 .../bindings/media/samsung-mipi-csis.txt           |   81 -
 .../devicetree/bindings/media/samsung-s5c73m3.txt  |   97 --
 .../devicetree/bindings/media/samsung-s5k5baf.txt  |   58 -
 .../devicetree/bindings/media/samsung-s5k6a3.txt   |   33 -
 Documentation/devicetree/bindings/media/si470x.txt |   26 -
 .../devicetree/bindings/media/silabs,si470x.yaml   |   48 +
 .../devicetree/bindings/media/st,stm32-cec.yaml    |   53 -
 .../devicetree/bindings/media/ti,cal.yaml          |    2 +-
 Documentation/driver-api/media/drivers/ccs/ccs.rst |   22 +
 .../userspace-api/media/v4l/dev-overlay.rst        |   10 +-
 .../userspace-api/media/v4l/pixfmt-compressed.rst  |   25 +
 .../userspace-api/media/v4l/pixfmt-packed-yuv.rst  |   28 +
 .../userspace-api/media/v4l/pixfmt-rgb.rst         |   42 +
 .../userspace-api/media/v4l/pixfmt-yuv-luma.rst    |   15 +
 .../userspace-api/media/v4l/pixfmt-yuv-planar.rst  |   94 ++
 .../userspace-api/media/v4l/user-func.rst          |    1 +
 .../userspace-api/media/v4l/vidioc-g-ext-ctrls.rst |   10 +
 .../userspace-api/media/v4l/vidioc-g-fbuf.rst      |   52 +-
 .../media/v4l/vidioc-subdev-enum-frame-size.rst    |   44 +-
 .../media/v4l/vidioc-subdev-enum-mbus-code.rst     |   39 +-
 .../media/v4l/vidioc-subdev-g-client-cap.rst       |   83 +
 MAINTAINERS                                        |   48 +-
 drivers/media/cec/core/cec-adap.c                  |    7 +-
 drivers/media/cec/platform/cec-gpio/cec-gpio.c     |    5 +-
 drivers/media/cec/platform/cros-ec/cros-ec-cec.c   |   22 +-
 drivers/media/cec/platform/meson/ao-cec-g12a.c     |    6 +-
 drivers/media/cec/platform/meson/ao-cec.c          |    6 +-
 drivers/media/cec/platform/s5p/s5p_cec.c           |    5 +-
 drivers/media/cec/platform/seco/seco-cec.c         |    6 +-
 drivers/media/cec/platform/sti/stih-cec.c          |    6 +-
 drivers/media/cec/platform/stm32/stm32-cec.c       |    6 +-
 drivers/media/cec/platform/tegra/tegra_cec.c       |    6 +-
 drivers/media/common/btcx-risc.h                   |   29 -
 drivers/media/common/saa7146/Kconfig               |    2 +-
 drivers/media/common/saa7146/saa7146_core.c        |   40 +-
 drivers/media/common/saa7146/saa7146_fops.c        |  373 +----
 drivers/media/common/saa7146/saa7146_hlp.c         |  355 +----
 drivers/media/common/saa7146/saa7146_vbi.c         |  287 ++--
 drivers/media/common/saa7146/saa7146_video.c       |  959 +++---------
 drivers/media/common/videobuf2/videobuf2-v4l2.c    |    5 +-
 drivers/media/dvb-frontends/drx39xyj/drxj.c        |    2 +-
 drivers/media/dvb-frontends/drxk_hard.c            |    2 +-
 drivers/media/dvb-frontends/rtl2832_sdr.c          |    6 +-
 drivers/media/dvb-frontends/zd1301_demod.c         |    6 +-
 drivers/media/i2c/Kconfig                          |   68 +-
 drivers/media/i2c/Makefile                         |    8 -
 drivers/media/i2c/ad9389b.c                        | 1215 --------------
 drivers/media/i2c/adv748x/adv748x-hdmi.c           |   21 +-
 drivers/media/i2c/adv7604.c                        |    5 +-
 drivers/media/i2c/ccs/ccs-core.c                   |  157 +-
 drivers/media/i2c/ccs/ccs.h                        |   14 -
 drivers/media/i2c/hi556.c                          |  150 +-
 drivers/media/i2c/hi846.c                          |   11 +-
 drivers/media/i2c/imx258.c                         |   33 +-
 drivers/media/i2c/imx290.c                         |  602 +++++--
 drivers/media/i2c/imx296.c                         |   11 +-
 drivers/media/i2c/imx334.c                         |  322 +++-
 drivers/media/i2c/m5mols/Kconfig                   |    8 -
 drivers/media/i2c/m5mols/Makefile                  |    4 -
 drivers/media/i2c/m5mols/m5mols.h                  |  349 -----
 drivers/media/i2c/m5mols/m5mols_capture.c          |  158 --
 drivers/media/i2c/m5mols/m5mols_controls.c         |  625 --------
 drivers/media/i2c/m5mols/m5mols_core.c             | 1051 -------------
 drivers/media/i2c/m5mols/m5mols_reg.h              |  359 -----
 drivers/media/i2c/max9286.c                        |    1 +
 drivers/media/i2c/mt9m032.c                        |  891 -----------
 drivers/media/i2c/mt9t001.c                        |  992 ------------
 drivers/media/i2c/noon010pc30.c                    |  821 ----------
 drivers/media/i2c/ov13b10.c                        |   75 +-
 drivers/media/i2c/ov2685.c                         |   80 +-
 drivers/media/i2c/ov5647.c                         |   56 +-
 drivers/media/i2c/ov5670.c                         |  116 +-
 drivers/media/i2c/ov7670.c                         |   11 +-
 drivers/media/i2c/ov8856.c                         |   40 -
 drivers/media/i2c/s5k6aa.c                         | 1652 ----------------=
----
 drivers/media/i2c/sr030pc30.c                      |  762 ---------
 drivers/media/i2c/st-vgxy61.c                      |   23 +-
 drivers/media/i2c/tc358746.c                       |    4 +-
 drivers/media/i2c/vs6624.c                         |  854 ----------
 drivers/media/i2c/vs6624_regs.h                    |  325 ----
 drivers/media/mc/mc-device.c                       |    3 +-
 drivers/media/pci/bt8xx/Kconfig                    |    2 +-
 drivers/media/pci/bt8xx/btcx-risc.c                |  153 --
 drivers/media/pci/bt8xx/btcx-risc.h                |    9 -
 drivers/media/pci/bt8xx/bttv-cards.c               |   15 -
 drivers/media/pci/bt8xx/bttv-driver.c              |  436 +-----
 drivers/media/pci/bt8xx/bttv-risc.c                |  131 --
 drivers/media/pci/bt8xx/bttvp.h                    |   28 +-
 drivers/media/pci/cobalt/cobalt-v4l2.c             |   21 +-
 drivers/media/pci/cx18/Kconfig                     |    2 +-
 drivers/media/pci/cx18/cx18-driver.c               |    4 +-
 drivers/media/pci/cx18/cx18-driver.h               |   24 +-
 drivers/media/pci/cx18/cx18-fileops.c              |   85 +-
 drivers/media/pci/cx18/cx18-fileops.h              |    3 +-
 drivers/media/pci/cx18/cx18-ioctl.c                |  391 ++---
 drivers/media/pci/cx18/cx18-mailbox.c              |   27 +-
 drivers/media/pci/cx18/cx18-streams.c              |  278 ++--
 drivers/media/pci/cx23885/cx23885-core.c           |    4 +-
 drivers/media/pci/cx23885/cx23885-video.c          |   13 +-
 drivers/media/pci/dm1105/dm1105.c                  |    1 +
 drivers/media/pci/intel/ipu3/cio2-bridge.c         |   23 +-
 drivers/media/pci/intel/ipu3/cio2-bridge.h         |    3 +-
 drivers/media/pci/intel/ipu3/ipu3-cio2-main.c      |    1 +
 drivers/media/pci/saa7134/saa7134-cards.c          |    1 -
 drivers/media/pci/saa7134/saa7134-core.c           |   32 -
 drivers/media/pci/saa7134/saa7134-empress.c        |    4 +-
 drivers/media/pci/saa7134/saa7134-ts.c             |    1 +
 drivers/media/pci/saa7134/saa7134-vbi.c            |    1 +
 drivers/media/pci/saa7134/saa7134-video.c          |  412 +----
 drivers/media/pci/saa7134/saa7134.h                |   13 -
 drivers/media/pci/saa7146/hexium_gemini.c          |   23 +-
 drivers/media/pci/saa7146/hexium_orion.c           |   24 +-
 drivers/media/pci/saa7146/mxb.c                    |   53 +-
 drivers/media/pci/ttpci/budget-av.c                |    5 +-
 drivers/media/pci/tw68/tw68-video.c                |   16 +-
 drivers/media/pci/zoran/zoran_device.h             |    2 -
 drivers/media/platform/allegro-dvt/allegro-core.c  |    6 +-
 drivers/media/platform/amlogic/meson-ge2d/ge2d.c   |    6 +-
 drivers/media/platform/amphion/vdec.c              |   53 +
 drivers/media/platform/amphion/vpu_codec.h         |    3 +-
 drivers/media/platform/amphion/vpu_core.c          |    6 +-
 drivers/media/platform/amphion/vpu_drv.c           |    6 +-
 drivers/media/platform/amphion/vpu_malone.c        |   45 +-
 drivers/media/platform/amphion/vpu_malone.h        |    1 +
 drivers/media/platform/aspeed/aspeed-video.c       |    6 +-
 drivers/media/platform/atmel/atmel-isi.c           |   10 +-
 drivers/media/platform/cadence/cdns-csi2rx.c       |    6 +-
 drivers/media/platform/cadence/cdns-csi2tx.c       |    6 +-
 drivers/media/platform/chips-media/coda-common.c   |    5 +-
 drivers/media/platform/intel/pxa_camera.c          |   10 +-
 drivers/media/platform/m2m-deinterlace.c           |    6 +-
 drivers/media/platform/marvell/mcam-core.c         |    4 +-
 drivers/media/platform/marvell/mmp-driver.c        |   16 +-
 .../media/platform/mediatek/jpeg/mtk_jpeg_core.c   |  140 +-
 .../media/platform/mediatek/jpeg/mtk_jpeg_core.h   |   28 +-
 .../media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c |   43 +-
 .../media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c |   38 +-
 drivers/media/platform/mediatek/mdp/mtk_mdp_core.c |    5 +-
 drivers/media/platform/mediatek/mdp3/Makefile      |    2 +-
 .../media/platform/mediatek/mdp3/mdp_cfg_data.c    |  453 ++++++
 .../media/platform/mediatek/mdp3/mdp_sm_mt8183.h   |  144 ++
 drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h |  189 +--
 .../media/platform/mediatek/mdp3/mtk-mdp3-cfg.h    |   20 +
 .../media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c   |  148 +-
 .../media/platform/mediatek/mdp3/mtk-mdp3-comp.c   |  539 ++++---
 .../media/platform/mediatek/mdp3/mtk-mdp3-comp.h   |   24 +-
 .../media/platform/mediatek/mdp3/mtk-mdp3-core.c   |   53 +-
 .../media/platform/mediatek/mdp3/mtk-mdp3-core.h   |   18 +-
 .../media/platform/mediatek/mdp3/mtk-mdp3-m2m.c    |   36 +-
 .../media/platform/mediatek/mdp3/mtk-mdp3-m2m.h    |    1 -
 .../media/platform/mediatek/mdp3/mtk-mdp3-regs.c   |  293 +---
 .../media/platform/mediatek/mdp3/mtk-mdp3-regs.h   |  214 +--
 .../media/platform/mediatek/mdp3/mtk-mdp3-type.h   |   53 +
 .../media/platform/mediatek/mdp3/mtk-mdp3-vpu.c    |  193 +--
 .../media/platform/mediatek/mdp3/mtk-mdp3-vpu.h    |   29 +-
 .../platform/mediatek/vcodec/mtk_vcodec_dec.c      |   31 +-
 .../platform/mediatek/vcodec/mtk_vcodec_dec_drv.c  |   10 +-
 .../platform/mediatek/vcodec/mtk_vcodec_dec_hw.c   |    8 +
 .../mediatek/vcodec/mtk_vcodec_dec_stateful.c      |   12 +-
 .../mediatek/vcodec/mtk_vcodec_dec_stateless.c     |   14 +-
 .../platform/mediatek/vcodec/mtk_vcodec_enc.c      |    2 +-
 .../platform/mediatek/vcodec/mtk_vcodec_enc_drv.c  |   23 +-
 .../mediatek/vcodec/vdec/vdec_h264_req_multi_if.c  |    2 +-
 .../mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c     |    2 +-
 .../platform/mediatek/vcodec/vdec_msg_queue.c      |   95 +-
 .../platform/mediatek/vcodec/vdec_msg_queue.h      |   12 +
 drivers/media/platform/mediatek/vpu/mtk_vpu.c      |    6 +-
 .../media/platform/microchip/microchip-csi2dc.c    |    6 +-
 .../media/platform/microchip/microchip-isc-base.c  |    5 +-
 .../platform/microchip/microchip-sama5d2-isc.c     |    6 +-
 .../platform/microchip/microchip-sama7g5-isc.c     |    6 +-
 drivers/media/platform/nvidia/tegra-vde/vde.c      |    6 +-
 drivers/media/platform/nxp/Kconfig                 |    2 +
 drivers/media/platform/nxp/Makefile                |    1 +
 drivers/media/platform/nxp/dw100/dw100.c           |   10 +-
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.c  |   19 +-
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h  |    5 +-
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c     |  344 +++-
 drivers/media/platform/nxp/imx-mipi-csis.c         |    6 +-
 drivers/media/platform/nxp/imx-pxp.c               |    6 +-
 drivers/media/platform/nxp/imx7-media-csi.c        |   33 +-
 drivers/media/platform/nxp/imx8-isi/Kconfig        |   22 +
 drivers/media/platform/nxp/imx8-isi/Makefile       |    8 +
 .../media/platform/nxp/imx8-isi/imx8-isi-core.c    |  539 +++++++
 .../media/platform/nxp/imx8-isi/imx8-isi-core.h    |  394 +++++
 .../platform/nxp/imx8-isi/imx8-isi-crossbar.c      |  529 +++++++
 .../media/platform/nxp/imx8-isi/imx8-isi-debug.c   |  109 ++
 drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c  |  650 ++++++++
 drivers/media/platform/nxp/imx8-isi/imx8-isi-m2m.c |  858 ++++++++++
 .../media/platform/nxp/imx8-isi/imx8-isi-pipe.c    |  867 ++++++++++
 .../media/platform/nxp/imx8-isi/imx8-isi-regs.h    |  418 +++++
 .../media/platform/nxp/imx8-isi/imx8-isi-video.c   | 1512 ++++++++++++++++=
++
 drivers/media/platform/nxp/mx2_emmaprp.c           |    6 +-
 .../media/platform/qcom/camss/camss-csid-gen2.c    |   54 +-
 drivers/media/platform/qcom/camss/camss-csid.c     |   44 +-
 drivers/media/platform/qcom/camss/camss-csid.h     |   11 +-
 drivers/media/platform/qcom/camss/camss-vfe-170.c  |    4 +-
 drivers/media/platform/qcom/camss/camss-vfe-480.c  |   61 +-
 drivers/media/platform/qcom/camss/camss-vfe-gen1.c |    4 +-
 drivers/media/platform/qcom/camss/camss-vfe.c      |    1 +
 drivers/media/platform/qcom/camss/camss-video.c    |   26 +-
 drivers/media/platform/qcom/camss/camss.c          |    8 +-
 drivers/media/platform/qcom/venus/core.c           |    6 +-
 drivers/media/platform/qcom/venus/core.h           |   10 +-
 drivers/media/platform/qcom/venus/firmware.c       |    4 +-
 drivers/media/platform/qcom/venus/helpers.c        |    4 +-
 drivers/media/platform/qcom/venus/hfi_cmds.c       |   23 +
 drivers/media/platform/qcom/venus/hfi_helper.h     |   18 +
 .../media/platform/qcom/venus/hfi_plat_bufs_v6.c   |    4 +-
 drivers/media/platform/qcom/venus/vdec.c           |   29 +-
 drivers/media/platform/qcom/venus/venc.c           |  115 +-
 drivers/media/platform/renesas/rcar-fcp.c          |    6 +-
 drivers/media/platform/renesas/rcar-isp.c          |   11 +-
 .../media/platform/renesas/rcar-vin/rcar-core.c    |   42 +-
 .../media/platform/renesas/rcar-vin/rcar-csi2.c    |   21 +-
 drivers/media/platform/renesas/rcar_drif.c         |    8 +-
 drivers/media/platform/renesas/rcar_fdp1.c         |   21 +-
 drivers/media/platform/renesas/rcar_jpu.c          |    6 +-
 drivers/media/platform/renesas/renesas-ceu.c       |   10 +-
 .../media/platform/renesas/rzg2l-cru/rzg2l-core.c  |    6 +-
 .../media/platform/renesas/rzg2l-cru/rzg2l-csi2.c  |    6 +-
 drivers/media/platform/renesas/sh_vou.c            |    5 +-
 drivers/media/platform/renesas/vsp1/vsp1_drm.c     |   26 +-
 drivers/media/platform/renesas/vsp1/vsp1_drv.c     |   17 +-
 drivers/media/platform/renesas/vsp1/vsp1_entity.c  |   11 +-
 drivers/media/platform/renesas/vsp1/vsp1_entity.h  |    2 -
 drivers/media/platform/renesas/vsp1/vsp1_pipe.h    |    2 +
 drivers/media/platform/renesas/vsp1/vsp1_regs.h    |    2 +
 drivers/media/platform/renesas/vsp1/vsp1_video.c   |    7 +-
 drivers/media/platform/rockchip/rga/rga.c          |    6 +-
 .../platform/rockchip/rkisp1/rkisp1-capture.c      |   52 +
 .../media/platform/rockchip/rkisp1/rkisp1-dev.c    |    6 +-
 .../platform/rockchip/rkisp1/rkisp1-resizer.c      |   14 +-
 .../media/platform/samsung/exynos-gsc/gsc-core.c   |    5 +-
 .../platform/samsung/exynos4-is/fimc-capture.c     |   18 +-
 .../media/platform/samsung/exynos4-is/fimc-core.c  |    5 +-
 .../platform/samsung/exynos4-is/fimc-is-errno.c    |    2 +-
 .../platform/samsung/exynos4-is/fimc-is-errno.h    |    2 +-
 .../platform/samsung/exynos4-is/fimc-is-i2c.c      |    6 +-
 .../media/platform/samsung/exynos4-is/fimc-is.c    |    6 +-
 .../platform/samsung/exynos4-is/fimc-isp-video.c   |   10 +-
 .../media/platform/samsung/exynos4-is/fimc-lite.c  |   14 +-
 .../media/platform/samsung/exynos4-is/media-dev.c  |   18 +-
 .../media/platform/samsung/exynos4-is/mipi-csis.c  |    6 +-
 .../platform/samsung/s3c-camif/camif-capture.c     |    5 +-
 .../media/platform/samsung/s3c-camif/camif-core.c  |   11 +-
 drivers/media/platform/samsung/s5p-g2d/g2d.c       |    5 +-
 .../media/platform/samsung/s5p-jpeg/jpeg-core.c    |    6 +-
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c   |    5 +-
 drivers/media/platform/st/sti/bdisp/bdisp-v4l2.c   |    8 +-
 .../platform/st/sti/c8sectpfe/c8sectpfe-core.c     |    6 +-
 drivers/media/platform/st/sti/delta/delta-v4l2.c   |    6 +-
 drivers/media/platform/st/sti/hva/hva-v4l2.c       |    6 +-
 drivers/media/platform/st/stm32/dma2d/dma2d.c      |   11 +-
 drivers/media/platform/st/stm32/dma2d/dma2d.h      |    2 -
 drivers/media/platform/st/stm32/stm32-dcmi.c       |    7 +-
 drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c |    6 +-
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c |    6 +-
 .../sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c        |    6 +-
 .../sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c    |    6 +-
 drivers/media/platform/sunxi/sun8i-di/sun8i-di.c   |    6 +-
 .../platform/sunxi/sun8i-rotate/sun8i_rotate.c     |    6 +-
 drivers/media/platform/ti/am437x/am437x-vpfe.c     |   41 +-
 drivers/media/platform/ti/cal/cal-video.c          |   37 +-
 drivers/media/platform/ti/cal/cal.c                |    6 +-
 drivers/media/platform/ti/davinci/vpif.c           |    6 +-
 drivers/media/platform/ti/davinci/vpif_capture.c   |    5 +-
 drivers/media/platform/ti/davinci/vpif_display.c   |    6 +-
 drivers/media/platform/ti/omap/omap_vout.c         |    5 +-
 drivers/media/platform/ti/omap3isp/isp.c           |    6 +-
 drivers/media/platform/ti/omap3isp/ispccdc.c       |    5 +-
 drivers/media/platform/ti/omap3isp/ispvideo.c      |   20 +-
 drivers/media/platform/ti/vpe/vpe.c                |    6 +-
 drivers/media/platform/verisilicon/hantro_drv.c    |   56 +-
 .../media/platform/verisilicon/hantro_postproc.c   |    2 +-
 drivers/media/platform/verisilicon/hantro_v4l2.c   |  100 +-
 drivers/media/platform/verisilicon/hantro_v4l2.h   |    3 +-
 drivers/media/platform/verisilicon/imx8m_vpu_hw.c  |    2 +
 drivers/media/platform/via/via-camera.c            |   13 +-
 drivers/media/platform/video-mux.c                 |    6 +-
 drivers/media/platform/xilinx/xilinx-csi2rxss.c    |    6 +-
 drivers/media/platform/xilinx/xilinx-dma.c         |    5 +-
 drivers/media/platform/xilinx/xilinx-tpg.c         |    6 +-
 drivers/media/platform/xilinx/xilinx-vipp.c        |    6 +-
 drivers/media/platform/xilinx/xilinx-vtc.c         |    8 +-
 drivers/media/radio/radio-si476x.c                 |    6 +-
 drivers/media/radio/radio-timb.c                   |    5 +-
 drivers/media/radio/radio-wl1273.c                 |    6 +-
 drivers/media/radio/si4713/radio-platform-si4713.c |    6 +-
 drivers/media/rc/gpio-ir-recv.c                    |    8 +-
 drivers/media/rc/img-ir/img-ir-core.c              |    5 +-
 drivers/media/rc/ir-hix5hd2.c                      |    5 +-
 drivers/media/rc/keymaps/Makefile                  |    2 +
 drivers/media/rc/keymaps/rc-beelink-mxiii.c        |   57 +
 drivers/media/rc/keymaps/rc-dreambox.c             |  151 ++
 drivers/media/rc/meson-ir-tx.c                     |    6 +-
 drivers/media/rc/meson-ir.c                        |    6 +-
 drivers/media/rc/mtk-cir.c                         |    6 +-
 drivers/media/rc/st_rc.c                           |    5 +-
 drivers/media/rc/sunxi-cir.c                       |    6 +-
 drivers/media/test-drivers/vicodec/vicodec-core.c  |    6 +-
 drivers/media/test-drivers/vidtv/vidtv_bridge.c    |    6 +-
 drivers/media/test-drivers/vim2m.c                 |    6 +-
 drivers/media/test-drivers/vimc/vimc-common.c      |    8 +-
 drivers/media/test-drivers/vimc/vimc-core.c        |    6 +-
 drivers/media/test-drivers/visl/visl-core.c        |    6 +-
 drivers/media/test-drivers/vivid/vivid-core.c      |   54 +-
 drivers/media/test-drivers/vivid/vivid-core.h      |   19 -
 .../media/test-drivers/vivid/vivid-kthread-cap.c   |  131 +-
 drivers/media/test-drivers/vivid/vivid-vid-cap.c   |  272 ----
 drivers/media/test-drivers/vivid/vivid-vid-cap.h   |    3 -
 drivers/media/test-drivers/vivid/vivid-vid-out.c   |   74 -
 drivers/media/tuners/it913x.c                      |    6 +-
 drivers/media/tuners/mxl5005s.c                    |   12 +-
 drivers/media/usb/au0828/au0828-core.c             |   11 +-
 drivers/media/usb/au0828/au0828-dvb.c              |    4 +-
 drivers/media/usb/dvb-usb/cxusb-analog.c           |   14 +-
 drivers/media/usb/dvb-usb/pctv452e.c               |    2 +
 drivers/media/usb/pvrusb2/Kconfig                  |    2 +-
 drivers/media/usb/usbtv/usbtv-core.c               |    2 +-
 drivers/media/v4l2-core/v4l2-async.c               |   13 +-
 drivers/media/v4l2-core/v4l2-common.c              |    6 +
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c      |   85 +-
 drivers/media/v4l2-core/v4l2-dev.c                 |    5 +-
 drivers/media/v4l2-core/v4l2-ioctl.c               |   86 +-
 drivers/media/v4l2-core/v4l2-mc.c                  |   15 +-
 drivers/media/v4l2-core/v4l2-subdev.c              |  200 ++-
 drivers/staging/media/atomisp/i2c/atomisp-gc0310.c | 1003 +++---------
 drivers/staging/media/atomisp/i2c/atomisp-ov2680.c |   33 +-
 drivers/staging/media/atomisp/i2c/gc0310.h         |  416 ++---
 drivers/staging/media/atomisp/i2c/ov2680.h         |    1 -
 .../staging/media/atomisp/include/linux/atomisp.h  |   28 -
 .../media/atomisp/include/linux/atomisp_platform.h |   11 +-
 drivers/staging/media/atomisp/pci/atomisp_cmd.c    | 1078 ++-----------
 drivers/staging/media/atomisp/pci/atomisp_cmd.h    |    9 -
 drivers/staging/media/atomisp/pci/atomisp_compat.h |   11 +-
 .../media/atomisp/pci/atomisp_compat_css20.c       |  420 +----
 drivers/staging/media/atomisp/pci/atomisp_fops.c   |  119 +-
 .../media/atomisp/pci/atomisp_gmin_platform.c      |  289 +++-
 .../staging/media/atomisp/pci/atomisp_internal.h   |   41 +-
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c  |  226 +--
 drivers/staging/media/atomisp/pci/atomisp_ioctl.h  |    6 -
 drivers/staging/media/atomisp/pci/atomisp_subdev.c |  189 +--
 drivers/staging/media/atomisp/pci/atomisp_subdev.h |   22 -
 drivers/staging/media/atomisp/pci/atomisp_v4l2.c   |   75 +-
 drivers/staging/media/av7110/av7110.c              |    6 +-
 drivers/staging/media/av7110/av7110_av.c           |    4 +-
 drivers/staging/media/av7110/av7110_hw.c           |    3 +-
 drivers/staging/media/av7110/av7110_v4l.c          |  148 +-
 .../media/deprecated/atmel/atmel-isc-base.c        |    9 +-
 .../media/deprecated/atmel/atmel-sama5d2-isc.c     |   10 +-
 .../media/deprecated/atmel/atmel-sama7g5-isc.c     |   10 +-
 drivers/staging/media/imx/imx-media-capture.c      |   40 +-
 drivers/staging/media/imx/imx-media-csi.c          |    6 +-
 drivers/staging/media/imx/imx-media-dev-common.c   |   14 -
 drivers/staging/media/imx/imx-media-dev.c          |    6 +-
 drivers/staging/media/imx/imx-media-of.c           |    5 +-
 drivers/staging/media/imx/imx-media-utils.c        |   76 +-
 drivers/staging/media/imx/imx-media.h              |   13 -
 drivers/staging/media/imx/imx6-mipi-csi2.c         |    6 +-
 drivers/staging/media/imx/imx8mq-mipi-csi2.c       |  158 +-
 drivers/staging/media/meson/vdec/vdec.c            |    6 +-
 drivers/staging/media/omap4iss/iss.c               |    6 +-
 drivers/staging/media/omap4iss/iss_video.c         |   16 +-
 drivers/staging/media/rkvdec/rkvdec.c              |    7 +-
 drivers/staging/media/sunxi/cedrus/cedrus.c        |    7 +-
 drivers/staging/media/sunxi/sun6i-isp/sun6i_isp.c  |    6 +-
 drivers/staging/media/tegra-video/vi.c             |   10 +-
 include/media/drv-intf/saa7146_vv.h                |   65 +-
 include/media/dvb_net.h                            |    6 +-
 include/media/i2c/ad9389b.h                        |   37 -
 include/media/i2c/m5mols.h                         |   25 -
 include/media/i2c/mt9m032.h                        |   22 -
 include/media/i2c/mt9t001.h                        |   10 -
 include/media/i2c/noon010pc30.h                    |   21 -
 include/media/i2c/s5k6aa.h                         |   48 -
 include/media/i2c/sr030pc30.h                      |   17 -
 include/media/media-device.h                       |    5 +-
 include/media/rc-map.h                             |    2 +
 include/media/tveeprom.h                           |    2 +-
 include/media/v4l2-ctrls.h                         |    2 +-
 include/media/v4l2-mc.h                            |    8 +-
 include/media/v4l2-subdev.h                        |   33 +-
 include/uapi/linux/v4l2-subdev.h                   |   21 +
 include/uapi/linux/videodev2.h                     |   13 +
 443 files changed, 15631 insertions(+), 21783 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/amlogic,meson6-=
ir.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/exynos-fimc-lit=
e.txt
 delete mode 100644 Documentation/devicetree/bindings/media/exynos4-fimc-is=
.txt
 delete mode 100644 Documentation/devicetree/bindings/media/i2c/ov2685.txt
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov2685=
.yaml
 create mode 100644 Documentation/devicetree/bindings/media/i2c/samsung,s5k=
5baf.yaml
 create mode 100644 Documentation/devicetree/bindings/media/i2c/samsung,s5k=
6a3.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/meson-ir.txt
 create mode 100644 Documentation/devicetree/bindings/media/nxp,imx8-isi.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/media/qcom,venus-comm=
on.yaml
 create mode 100644 Documentation/devicetree/bindings/media/samsung,exynos4=
210-csis.yaml
 create mode 100644 Documentation/devicetree/bindings/media/samsung,exynos4=
210-fimc.yaml
 create mode 100644 Documentation/devicetree/bindings/media/samsung,exynos4=
212-fimc-is.yaml
 create mode 100644 Documentation/devicetree/bindings/media/samsung,exynos4=
212-fimc-lite.yaml
 create mode 100644 Documentation/devicetree/bindings/media/samsung,fimc.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/media/samsung,s5c73m3=
.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/samsung-fimc.txt
 delete mode 100644 Documentation/devicetree/bindings/media/samsung-mipi-cs=
is.txt
 delete mode 100644 Documentation/devicetree/bindings/media/samsung-s5c73m3=
.txt
 delete mode 100644 Documentation/devicetree/bindings/media/samsung-s5k5baf=
.txt
 delete mode 100644 Documentation/devicetree/bindings/media/samsung-s5k6a3.=
txt
 delete mode 100644 Documentation/devicetree/bindings/media/si470x.txt
 create mode 100644 Documentation/devicetree/bindings/media/silabs,si470x.y=
aml
 delete mode 100644 Documentation/devicetree/bindings/media/st,stm32-cec.ya=
ml
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-subdev-g-c=
lient-cap.rst
 delete mode 100644 drivers/media/common/btcx-risc.h
 delete mode 100644 drivers/media/i2c/ad9389b.c
 delete mode 100644 drivers/media/i2c/m5mols/Kconfig
 delete mode 100644 drivers/media/i2c/m5mols/Makefile
 delete mode 100644 drivers/media/i2c/m5mols/m5mols.h
 delete mode 100644 drivers/media/i2c/m5mols/m5mols_capture.c
 delete mode 100644 drivers/media/i2c/m5mols/m5mols_controls.c
 delete mode 100644 drivers/media/i2c/m5mols/m5mols_core.c
 delete mode 100644 drivers/media/i2c/m5mols/m5mols_reg.h
 delete mode 100644 drivers/media/i2c/mt9m032.c
 delete mode 100644 drivers/media/i2c/mt9t001.c
 delete mode 100644 drivers/media/i2c/noon010pc30.c
 delete mode 100644 drivers/media/i2c/s5k6aa.c
 delete mode 100644 drivers/media/i2c/sr030pc30.c
 delete mode 100644 drivers/media/i2c/vs6624.c
 delete mode 100644 drivers/media/i2c/vs6624_regs.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_cfg_data.c
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_sm_mt8183.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-cfg.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-type.h
 create mode 100644 drivers/media/platform/nxp/imx8-isi/Kconfig
 create mode 100644 drivers/media/platform/nxp/imx8-isi/Makefile
 create mode 100644 drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
 create mode 100644 drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
 create mode 100644 drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
 create mode 100644 drivers/media/platform/nxp/imx8-isi/imx8-isi-debug.c
 create mode 100644 drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c
 create mode 100644 drivers/media/platform/nxp/imx8-isi/imx8-isi-m2m.c
 create mode 100644 drivers/media/platform/nxp/imx8-isi/imx8-isi-pipe.c
 create mode 100644 drivers/media/platform/nxp/imx8-isi/imx8-isi-regs.h
 create mode 100644 drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
 create mode 100644 drivers/media/rc/keymaps/rc-beelink-mxiii.c
 create mode 100644 drivers/media/rc/keymaps/rc-dreambox.c
 delete mode 100644 include/media/i2c/ad9389b.h
 delete mode 100644 include/media/i2c/m5mols.h
 delete mode 100644 include/media/i2c/mt9m032.h
 delete mode 100644 include/media/i2c/mt9t001.h
 delete mode 100644 include/media/i2c/noon010pc30.h
 delete mode 100644 include/media/i2c/s5k6aa.h
 delete mode 100644 include/media/i2c/sr030pc30.h

