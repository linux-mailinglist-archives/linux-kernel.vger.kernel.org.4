Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E3F60808B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 23:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiJUVID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 17:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiJUVIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 17:08:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EFD2A389E;
        Fri, 21 Oct 2022 14:07:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39903B82D5F;
        Fri, 21 Oct 2022 21:07:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6638FC433D6;
        Fri, 21 Oct 2022 21:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666386474;
        bh=jw19vJNAmA3X7/jTXA/51e9bwHETs0k1NDnHRMHRorQ=;
        h=Date:From:To:Cc:Subject:From;
        b=NJcTAs0dF243lkFm+v6qlVThRvUsIcAgMttFjyDL9x38rpE0F+js3q3UQ/efShq9h
         FASjI0wco9CjxoP0j5I7waWl/iqywWwSmv91JyyMA14/TPFsLdR4Fv2wSTj0VZwq0d
         KAeVeH+L7g6k2MmZJvL6O4Ca3R82IomGryM2OQ36Txjuiwo1PHOZOokOXFa3OqOXXc
         59Qsejck+fUe3R9GhF+O3OZos3k5dyNxqvo4EisWSxckyBaobl9avP+20nJW6uq5EF
         O7mW5yiCmkkoFBUccy/ztPQxCuMz5rayEDNgVJ0cqdVqAQXQmLK7ZzZPYy4qmcJbPv
         TyolvLC/pBDMg==
Date:   Fri, 21 Oct 2022 22:07:48 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v6.1-rc2] media updates
Message-ID: <20221021220748.144ffe20@sal.lan>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

It seems I screw-up with my previous pull request: it ends that only half of
the media patches that are linux-next got merged on -rc1. Could you please
accept a late PR? If so, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/me=
dia/v6.1-2


For:

- a DVB core security fix;
- lots of fixes and cleanups for atomisp staging driver;
- old drivers that are VB1 are being moved to staging to be deprecated;
- several driver updates - mostly for embedded systems, but there are
  also some things addressing issues with some PC webcams, at the UVC
  video driver.

Regards,
Mauro

---

The following changes since commit 3a99c4474112f49a5459933d8758614002ca0ddc:

  media: rkvdec: Disable H.264 error detection (2022-09-27 10:24:44 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/me=
dia/v6.1-2

for you to fetch changes up to d67614f276c1499ad939fa5c1aadd35498cc6b34:

  Merge fixes into media_stage (2022-09-27 10:27:56 +0200)

----------------------------------------------------------------
media fixes for v6.1-rc2

----------------------------------------------------------------
Alan Stern (1):
      media: mceusb: Use new usb_control_msg_*() routines

Alexander Stein (1):
      media: v4l2: Fix v4l2_i2c_subdev_set_name function documentation

Andy Shevchenko (2):
      media: atomisp_gmin_platform: Switch to use acpi_evaluate_dsm_typed()
      media: atomisp_gmin_platform: Unexport and split camera_sensor_csi()

Benjamin Gaignard (7):
      media: hantro: Store HEVC bit depth in context
      media: hantro: HEVC: Fix auxilary buffer size calculation
      media: hantro: HEVC: Fix chroma offset computation
      media: hantro: postproc: Configure output regs to support 10bit
      media: Hantro: HEVC: Allows 10-bit bitstream
      media: hantro: imx8m: Enable 10bit decoding
      media: hantro: Allows luma and chroma depth to be different

Biju Das (5):
      media: dt-bindings: media: renesas,vsp1: Document RZ/G2L VSPD bindings
      media: renesas: vsp1: Add support to deassert/assert reset line
      media: renesas: vsp1: Add support for VSP software version
      media: renesas: vsp1: Add VSP1_HAS_NON_ZERO_LBA feature bit
      media: renesas: vsp1: Add support for RZ/G2L VSPD

Bryan O'Donoghue (2):
      media: venus: dec: Handle the case where find_format fails
      media: venus: Fix NV12 decoder buffer discovery on HFI_VERSION_1XX

Christophe JAILLET (4):
      media: dw100: Fix an error handling path in dw100_probe()
      media: ov8865: Fix an error handling path in ov8865_probe()
      media: sunxi: Fix some error handling path of sun8i_a83t_mipi_csi2_pr=
obe()
      media: sunxi: Fix some error handling path of sun6i_mipi_csi2_probe()

Dan Carpenter (2):
      media: platform: mtk-mdp3: fix error code in mdp_vpu_dev_init()
      media: atomisp: prevent integer overflow in sh_css_set_black_frame()

Daniel Gonz=C3=A1lez Cabanelas (1):
      media: cx88: add IR remote support for NotOnlyTV LV3H

Daniel Lee Kruse (1):
      media: cx23885: reset DMA on AMD Renior/Cezanne IOMMU due to RiSC eng=
ine stall

Daniel Lundberg Pedersen (1):
      media: docs: libv4l-introduction.rst: Fix function signature and link

Deborah Brouwer (1):
      media: v4l2-ctrls: Fix typo in VP8 comment

Dikshita Agarwal (1):
      media: venus : Addition of support for VIDIOC_TRY_ENCODER_CMD

Dmitry Osipenko (2):
      media: cedrus: Set the platform driver data earlier
      media: cedrus: Fix endless loop in cedrus_h265_skip_bits()

Dongliang Mu (1):
      media: airspy: fix memory leak in airspy probe

Ezequiel Garcia (3):
      media: cedrus: Use vb2_find_buffer
      media: videobuf2: Remove vb2_find_timestamp()
      media: destage Hantro VPU driver

Hangyu Hua (2):
      media: platform: fix some double free in meson-ge2d and mtk-jpeg and =
s5p-mfc
      media: meson: vdec: fix possible refcount leak in vdec_probe()

Hans Verkuil (34):
      media: v4l2-ctrls: allocate space for arrays
      media: v4l2-ctrls: alloc arrays in ctrl_ref
      media: v4l2-ctrls: add v4l2_ctrl_modify_dimensions
      media: v4l2-ctrls: add change flag for when dimensions change
      media: vivid: add pixel_array test control
      media: v4l2-ctrls: optimize type_ops for arrays
      media: zoran: fix checkpatch --strict issues
      media: zoran: the video device is video capture only, not M2M
      media: zoran: from VB2_READ/WRITE: read/write isn't supported
      media: zoran: move to mainline
      media: media/pci/ngene/ngene.h: remove #ifdef NGENE_V4L
      media: vb2: videobuf -> videobuf2
      media: media/v4l2-mem2mem.h: rename 'videobuf' to 'vb2'
      media: platform: ti: avoid using 'videobuf' or 'video-buf'
      media: staging/media/omap4iss/iss_video.c: videobuf -> vb2
      media: avoid use of 'videobuf'
      media: staging/media: add a STAGING_MEDIA_DEPRECATED option
      media: cpia2: deprecate this driver
      media: meye: deprecate this driver
      media: zr364xx: deprecate this driver
      media: tm6000: deprecate this driver
      media: fsl-viu: deprecate this driver
      media: davinci: deprecate dm644x_ccdc, dm355_cddc and dm365_isif
      media: saa7146: deprecate hexium_gemini/orion, mxb and ttpci
      media: av7110: move to staging/media/deprecated/saa7146
      media: videodev2.h: drop V4L2_CAP_ASYNCIO
      media: MAINTAINERS: change tc358743 maintainer
      media: media/cec: use CEC_MAX_MSG_SIZE instead of hardcoded 16
      media: tc358743: limit msg.len to CEC_MAX_MSG_SIZE
      media: s5p_cec: limit msg.len to CEC_MAX_MSG_SIZE
      media: cros-ec-cec: limit msg.len to CEC_MAX_MSG_SIZE
      media: v4l2-ctrls: drop 'elems' argument from control type ops.
      media: dvb-frontends/drxk: initialize err to 0
      media: cec: add support for Absolute Volume Control

Hans de Goede (41):
      media: atomisp-ov2680: Fix ov2680_set_fmt()
      media: atomisp-ov2680: Don't take the input_lock for try_fmt calls.
      media: atomisp-ov2680: Improve ov2680_set_fmt() error handling
      media: atomisp-notes: Add info about sensors v4l2_get_subdev_hostdata=
() use
      media: atomisp: Fix VIDIOC_TRY_FMT
      media: atomisp: Make atomisp_try_fmt_cap() take padding into account
      media: atomisp: hmm_bo: Simplify alloc_private_pages()
      media: atomisp: hmm_bo: Further simplify alloc_private_pages()
      media: atomisp: hmm_bo: Rewrite alloc_private_pages() using pages_arr=
ay helper funcs
      media: atomisp: hmm_bo: Rewrite free_private_pages() using pages_arra=
y helper funcs
      media: atomisp: hmm_bo: Drop PFN code path from alloc_user_pages()
      media: atomisp: Ensure that USERPTR pointers are page aligned
      media: atomisp: Fix device_caps reporting of the registered video-devs
      media: atomisp: Remove file-injection support
      media: atomisp: Remove atomisp_file_fops and atomisp_file_ioctl_ops
      media: atomisp: Remove the outq videobuf queue
      media: atomisp: Remove never set file_input flag
      media: atomisp: Remove the ACC device node
      media: atomisp: Remove some further ATOMISP_ACC_* related dead code
      media: atomisp: Remove empty atomisp_css_set_cont_prev_start_time() f=
unction
      media: atomisp: Split subdev and video-node registration into 2 steps
      media: atomisp: Register /dev/* nodes at the end of atomisp_pci_probe=
()
      media: atomisp: Remove loading mutex
      media: atomisp: Fix v4l2_fh resource leak on open errors
      media: atomisp: Simplify v4l2_fh_open() error handling
      media: atomisp: Use a normal mutex for the main lock
      media: atomisp: Remove unused lock member from struct atomisp_sub_dev=
ice
      media: atomisp: Fix locking around asd->streaming read/write
      media: atomisp: Remove asd =3D=3D NULL checks from ioctl handling
      media: atomisp: Add atomisp_pipe_check() helper
      media: atomisp: Remove watchdog timer
      media: atomisp: Move atomisp_streaming_count() check into __atomisp_c=
ss_recover()
      media: atomisp: Rework asd->streaming state update in __atomisp_strea=
moff()
      media: atomisp: Drop streamoff_mutex
      media: atomisp: Use video_dev.lock for ioctl locking
      media: atomisp: Remove a couple of not useful function wrappers
      media: atomisp: Drop unnecessary first_streamoff check
      media: atomisp: Make atomisp_set_raw_buffer_bitmap() static
      media: atomisp: Remove unused atomisp_css_get_dis_statistics()
      media: atomisp: Remove const/fixed camera_caps
      media: atomisp: Remove atomisp_source_pad_to_stream_id()

Hirokazu Honda (1):
      media: mediatek: vcodec: Skip non CBR bitrate mode

Irui Wang (6):
      media: mediatek: vcodec: Add encoder driver support for 34-bit iova
      media: dt-bindings: media: mediatek: vcodec: Add encoder dt-bindings =
for mt8188
      media: mediatek: vcodec: Add mt8188 encoder driver
      media: mediatek: vcodec: Remove encoder driver get IRQ resource
      media: mediatek: vcodec: Fix bitstream crop information error
      media: mediatek: vcodec: Use ctx vb2_queue mutex instead of device mu=
tex

Jacopo Mondi (1):
      media: mc: entity: Add iterator helper for entity pads

Jason Wang (5):
      media: dib8000: Fix comment typo
      media: sun6i-csi: Fix comment typo
      media: drxk: Fix comment typo
      media: technisat-usb2: Fix comment typo
      media: v4l2-flash: Fix comment typo

Jean-Michel Hautbois (1):
      media: staging: ipu3-imgu: Fix BNR wb gain documentation

Jilin Yuan (3):
      media: usb/msi2500: fix repeated words in comments
      media: usb/dvb-usb-v2: fix repeated words in comments
      media: pci/cx18: fix repeated words in comments

Jos=C3=A9 Exp=C3=B3sito (1):
      media: uvcvideo: Fix memory leak in uvc_gpio_parse

Krzysztof Kozlowski (2):
      media: dt-bindings: dongwoon,dw9714: convert to dtschema
      media: dt-bindings: media: samsung,exynos5250-gsc: convert to dtschema

Laurent Pinchart (23):
      media: uvcvideo: Use indexed loops in uvc_ctrl_init_ctrl()
      media: rockchip: rkisp1: Set DPCC methods enable bits inside loop
      media: rockchip: rkisp1: Mask invalid bits in DPCC parameters
      media: rockchip: rkisp1: Define macros for DPCC configurations in UAPI
      media: rkisp1: Initialize color space on ISP sink and source pads
      media: rkisp1: Allow setting color space on ISP sink pad
      media: rkisp1: Fix source pad format configuration
      media: rkisp1: Allow setting all color space fields on ISP source pad
      media: rkisp1: Configure quantization using ISP source pad
      media: rkisp1: Don't pass the quantization to rkisp1_csm_config()
      media: rkisp1: Configure CSM based on YCbCr encoding
      media: rkisp1: Initialize color space on resizer sink and source pads
      media: rkisp1: Allow setting color space on resizer sink pad
      media: rkisp1: Clean up LSC configuration code
      media: rkisp1: Store LSC register values in u32 variables
      media: rkisp1: Simplify LSC x/y size and grad register macros
      media: rkisp1: Use correct macro for gradient registers
      media: rkisp1: Configure LSC after enabling the ISP
      media: rkisp1: Zero v4l2_subdev_format fields in when validating links
      media: mc: entity: Merge media_entity_enum_init and __media_entity_en=
um_init
      media: mc: entity: Move media_entity_get_fwnode_pad() out of graph wa=
lk section
      media: mc: entity: Add media_entity_pipeline() to access the media pi=
peline
      media: mc: entity: Rewrite media_pipeline_start()

Li zeming (1):
      media: staging/media/av7110/av7110: Fix typo in string

Liang He (1):
      media: exynos4-is: fimc-is: Add of_node_put() when breaking out of lo=
op

Linus Walleij (2):
      media: i2c: isl7998x: Use right include
      media: si4713: Use the right include

Lukas Bulwahn (3):
      media: remove reference to CONFIG_EMBEDDED in MEDIA_SUPPORT_FILTER
      media: MAINTAINERS: adjust entry to zoran driver movement
      media: MAINTAINERS: rectify entry in SAA7146 VIDEO4LINUX-2 DRIVER

Mauro Carvalho Chehab (2):
      media: atomisp: don't store an unused sink data on a var
      Merge fixes into media_stage

Miaoqian Lin (1):
      media: xilinx: vipp: Fix refcount leak in xvip_graph_dma_init

Ming Qian (5):
      media: amphion: insert picture startcode after seek for vc1g format
      media: amphion: adjust the encoder's value range of gop size
      media: amphion: don't change the colorspace reported by decoder.
      media: amphion: fix a bug that vpu core may not resume after suspend
      media: amphion: release m2m ctx when releasing vpu instance

Moudy Ho (4):
      media: dt-binding: mediatek: add bindings for MediaTek MDP3 components
      media: dt-binding: mediatek: add bindings for MediaTek CCORR and WDMA
      media: platform: mtk-mdp3: add MediaTek MDP3 driver
      media: platform: mtk-mdp3: add pointer checks and use devm_kfree

Nicolas Dufresne (1):
      media: cedrus: Fix watchdog race condition

Ondrej Jirman (1):
      media: rockchip: rga: Fix probe rga_parse_dt bugs

Paul Elder (1):
      media: ov5640: Use runtime PM

Paul Kocialkowski (22):
      media: sun6i-mipi-csi2: Add a Kconfig dependency on RESET_CONTROLLER
      media: sun8i-a83t-mipi-csi2: Add a Kconfig dependency on RESET_CONTRO=
LLER
      media: sun6i-csi: Add a Kconfig dependency on RESET_CONTROLLER
      media: sun4i-csi: Add a Kconfig dependency on RESET_CONTROLLER
      media: sun8i-di: Add a Kconfig dependency on RESET_CONTROLLER
      media: sun8i-rotate: Add a Kconfig dependency on RESET_CONTROLLER
      media: cedrus: Add a Kconfig dependency on RESET_CONTROLLER
      media: sun6i-csi: Define and use driver name and (reworked) descripti=
on
      media: sun6i-csi: Refactor main driver data structures
      media: sun6i-csi: Tidy up platform code
      media: sun6i-csi: Always set exclusive module clock rate
      media: sun6i-csi: Define and use variant to get module clock rate
      media: sun6i-csi: Use runtime pm for clocks and reset
      media: sun6i-csi: Tidy up Kconfig
      media: sun6i-csi: Tidy up v4l2 code
      media: sun6i-csi: Tidy up video code
      media: sun6i-csi: Pass and store csi device directly in video code
      media: sun6i-csi: Register the media device after creation
      media: sun6i-csi: Remove controls handler from the driver
      media: sun6i-csi: Add media ops with link notify callback
      media: sun6i-csi: Introduce and use video helper functions
      media: sun6i-csi: Move csi buffer definition to main header file

Petko Manolov (1):
      media: staging: media: imx: imx7-media-csi: Increase video mem limit

Philipp Zabel (1):
      media: coda: jpeg: drop coda9_jpeg_dec_huff_setup() return value

Rory Liu (1):
      media: platform: cros-ec: Add Kuldax to the match table

Sakari Ailus (6):
      media: ar0521: Remove redundant variable ret
      media: ipu3-imgu: Fix NULL pointer dereference in active selection ac=
cess
      media: v4l: subdev: Fail graciously when getting try data for NULL st=
ate
      media: ar0521: Fix return value check in writing initial registers
      media: sun6i-mipi-csi2: Depend on PHY_SUN6I_MIPI_DPHY
      media: Remove incorrect comment from struct v4l2_fwnode_endpoint

Sean Young (1):
      media: mceusb: set timeout to at least timeout provided

Slark Xiao (10):
      media: dvb-frontends: Fix typo 'the the' in comment
      media: cx88: Fix typo 'the the' in comment
      media: ivtv: Fix typo 'the the' in comment
      media: saa7164: Fix typo 'the the' in comment
      media: platform: ti: Fix typo 'the the' in comment
      media: gspca: Fix typo 'the the' in comment
      media: tm6000: Fix typo 'the the' in comment
      media: v4l2-ioctl: Fix typo 'the the' in comment
      media: uvcvideo: Fix typo 'the the' in comment
      media: i2c: mt9v111: Fix typo 'the the' in comment

Stanimir Varbanov (4):
      media: venus : Add default values for the control
      media: venus : CAPTURE Plane width/height alignment with OUT plane.
      media: venus: venc_ctrls: Add default value for CLL info
      media: venus: venc: Set HDR10 PQ SEI property only for MAIN10 profile

Sun Ke (1):
      media: platform: mtk-mdp3: fix PM reference leak in mdp_comp_clock_on=
()

Tomi Valkeinen (16):
      media: ti: cal: fix useless variable init
      media: ti: cal: rename sd_state to state
      media: ti: cal: use CSI-2 frame number for seq number
      media: ti: cal: combine wdma irq handling
      media: ti: cal: fix wdma irq for metadata
      media: Documentation: mc: add definitions for stream and pipeline
      media: media-entity.h: add include for min()
      media: subdev: increase V4L2_FRAME_DESC_ENTRY_MAX to 8
      media: mc: entity: Rename streaming_count -> start_count
      media: v4l2-dev: Add videodev wrappers for media pipelines
      media: drivers: use video device pipeline start/stop
      media: drivers: use video_device_pipeline()
      media: mc: entity: add alloc variant of pipeline_start
      media: drivers: use video_device_pipeline_alloc_start()
      media: mc: entity: Add has_pad_interdep entity operation
      media: mc: convert pipeline funcs to take media_pad

Vikash Garodia (1):
      media: venus : Allow MIN/MAX settings for the v4l2 encoder controls d=
efined range.

Viswanath Boma (3):
      media: venus : Addition of control support - V4L2_CID_MIN_BUFFERS_FOR=
_OUTPUT
      media: venus : Addition of EOS Event support for Encoder
      media: venus : Remove the capture plane settings for venc_g_parm/venc=
_s_parm

Volodymyr Kharuk (2):
      media: xilinx: csi2rxss: Add 1X12 greyscale format
      media: xilinx: video: Add 1X12 greyscale format

Xavier Roumegue (7):
      media: v4l2-ctrls: Export default v4l2_ctrl_type_ops callbacks
      media: Documentation: dw100: Add user documentation for the DW100 dri=
ver
      media: v4l: uapi: Add user control base for DW100 controls
      media: uapi: Add a control for DW100 driver
      media: dt-bindings: media: Add i.MX8MP DW100 binding
      media: dw100: Add i.MX8MP dw100 dewarper driver
      media: MAINTAINERS: add entry for i.MX8MP DW100 v4l2 mem2mem driver

Xu Qiang (1):
      media: meson: vdec: add missing clk_disable_unprepare on error in vde=
c_hevc_start()

Yang Yingliang (1):
      media: ar0521: fix error return code in ar0521_power_on()

Yunfei Dong (3):
      media: dt-bindings: media: mediatek: vcodec: add decoder dt-bindings =
for mt8188
      media: mediatek: vcodec: add decoder compatible to support mt8188
      media: mediatek: vcodec: Add mt8188 encoder's chip name

Yunke Cao (1):
      media: uvcvideo: Use entity get_cur in uvc_ctrl_set

Zeng Jingxiang (1):
      media: tm6000: Fix unused value in vidioc_try_fmt_vid_cap()

Zheyu Ma (1):
      media: cx88: Fix a null-ptr-deref bug in buffer_prepare()

huanglei (1):
      media: uvcvideo: Limit power line control for Sonix Technology

wangjianli (5):
      media: i2c/cx25840: fix repeated words in comments
      media: pci/cx18: fix repeated words in comments
      media: pci/cx18: fix repeated words in comments
      media: pci/cx23885: fix repeated words in comments
      media: ti/omap: fix repeated words in comments

ye xingchen (4):
      media: imon: Remove the unneeded result variable
      media: radio-si476x: Remove the unneeded result variable
      media: tuners: Remove the unneeded result variable
      media: venus: hfi: Remove the unneeded result variable

 .../devicetree/bindings/media/exynos5-gsc.txt      |   38 -
 .../bindings/media/i2c/dongwoon,dw9714.txt         |    9 -
 .../bindings/media/i2c/dongwoon,dw9714.yaml        |   47 +
 .../bindings/media/mediatek,mdp3-rdma.yaml         |   95 ++
 .../bindings/media/mediatek,mdp3-rsz.yaml          |   77 +
 .../bindings/media/mediatek,mdp3-wrot.yaml         |   80 +
 .../bindings/media/mediatek,vcodec-encoder.yaml    |    1 +
 .../media/mediatek,vcodec-subdev-decoder.yaml      |    1 +
 .../devicetree/bindings/media/nxp,dw100.yaml       |   69 +
 .../devicetree/bindings/media/renesas,vsp1.yaml    |   53 +-
 .../bindings/media/samsung,exynos5250-gsc.yaml     |  109 ++
 .../bindings/soc/mediatek/mediatek,ccorr.yaml      |   68 +
 .../bindings/soc/mediatek/mediatek,wdma.yaml       |   81 +
 .../driver-api/media/drivers/pxa_camera.rst        |    2 +-
 Documentation/driver-api/media/mc-core.rst         |   19 +-
 .../userspace-api/media/cec.h.rst.exceptions       |    2 +
 .../userspace-api/media/drivers/dw100.rst          |   84 +
 .../userspace-api/media/drivers/index.rst          |    1 +
 Documentation/userspace-api/media/v4l/async.rst    |    9 -
 .../userspace-api/media/v4l/dev-raw-vbi.rst        |    2 +-
 Documentation/userspace-api/media/v4l/dev-sdr.rst  |    2 +-
 .../userspace-api/media/v4l/dev-sliced-vbi.rst     |    2 +-
 .../userspace-api/media/v4l/hist-v4l2.rst          |    2 +-
 Documentation/userspace-api/media/v4l/io.rst       |    4 +-
 .../media/v4l/libv4l-introduction.rst              |    4 +-
 .../userspace-api/media/v4l/vidioc-dqevent.rst     |    5 +
 .../userspace-api/media/v4l/vidioc-querycap.rst    |    3 -
 .../userspace-api/media/videodev2.h.rst.exceptions |    1 +
 MAINTAINERS                                        |   29 +-
 drivers/media/Kconfig                              |    2 +-
 drivers/media/cec/core/cec-adap.c                  |    1 +
 drivers/media/cec/platform/cros-ec/cros-ec-cec.c   |    4 +
 drivers/media/cec/platform/s5p/s5p_cec.c           |    2 +
 drivers/media/cec/platform/sti/stih-cec.c          |    4 +-
 drivers/media/common/Kconfig                       |    1 -
 drivers/media/common/Makefile                      |    2 +-
 drivers/media/common/videobuf2/videobuf2-core.c    |   14 +-
 drivers/media/common/videobuf2/videobuf2-dvb.c     |    4 +-
 drivers/media/common/videobuf2/videobuf2-v4l2.c    |   17 +-
 drivers/media/dvb-frontends/dib8000.c              |    2 +-
 drivers/media/dvb-frontends/drxk_hard.c            |    4 +-
 drivers/media/dvb-frontends/rtl2832_sdr.c          |    2 +-
 drivers/media/dvb-frontends/tda1002x.h             |    2 +-
 drivers/media/dvb-frontends/tda10048.c             |    2 +-
 drivers/media/i2c/adv7511-v4l2.c                   |    4 +-
 drivers/media/i2c/adv7604.c                        |    4 +-
 drivers/media/i2c/adv7842.c                        |    4 +-
 drivers/media/i2c/ar0521.c                         |   11 +-
 drivers/media/i2c/cx25840/cx25840-ir.c             |    2 +-
 drivers/media/i2c/ir-kbd-i2c.c                     |   47 +
 drivers/media/i2c/isl7998x.c                       |    2 +-
 drivers/media/i2c/mt9v111.c                        |    2 +-
 drivers/media/i2c/ov5640.c                         |  123 +-
 drivers/media/i2c/ov8865.c                         |   10 +-
 drivers/media/i2c/tc358743.c                       |    2 +
 drivers/media/mc/mc-device.c                       |   13 +-
 drivers/media/mc/mc-entity.c                       |  648 ++++++--
 drivers/media/pci/Kconfig                          |    4 +-
 drivers/media/pci/Makefile                         |    6 +-
 drivers/media/pci/cx18/cx18-av-audio.c             |    2 +-
 drivers/media/pci/cx18/cx18-av-core.c              |    4 +-
 drivers/media/pci/cx18/cx18-firmware.c             |    2 +-
 drivers/media/pci/cx23885/cx23885-core.c           |    3 +
 drivers/media/pci/cx23885/cx23888-ir.c             |    2 +-
 drivers/media/pci/cx88/cx88-dsp.c                  |    2 +-
 drivers/media/pci/cx88/cx88-input.c                |    2 +-
 drivers/media/pci/cx88/cx88-vbi.c                  |    9 +-
 drivers/media/pci/cx88/cx88-video.c                |   44 +-
 drivers/media/pci/intel/ipu3/ipu3-cio2-main.c      |    6 +-
 drivers/media/pci/ivtv/ivtv-yuv.c                  |    2 +-
 drivers/media/pci/ngene/ngene.h                    |   78 -
 drivers/media/pci/saa7164/saa7164-core.c           |    2 +-
 drivers/media/pci/solo6x10/solo6x10-v4l2-enc.c     |    2 +-
 drivers/{staging/media =3D> media/pci}/zoran/Kconfig |    0
 .../{staging/media =3D> media/pci}/zoran/Makefile    |    0
 .../media =3D> media/pci}/zoran/videocodec.c         |    7 +-
 .../media =3D> media/pci}/zoran/videocodec.h         |  190 +--
 drivers/{staging/media =3D> media/pci}/zoran/zoran.h |   30 +-
 .../media =3D> media/pci}/zoran/zoran_card.c         |   56 +-
 .../media =3D> media/pci}/zoran/zoran_card.h         |    9 +-
 .../media =3D> media/pci}/zoran/zoran_device.c       |   37 +-
 drivers/media/pci/zoran/zoran_device.h             |   60 +
 .../media =3D> media/pci}/zoran/zoran_driver.c       |   59 +-
 .../{staging/media =3D> media/pci}/zoran/zr36016.c   |  142 +-
 .../{staging/media =3D> media/pci}/zoran/zr36016.h   |    0
 .../{staging/media =3D> media/pci}/zoran/zr36050.c   |  182 +--
 .../{staging/media =3D> media/pci}/zoran/zr36050.h   |    0
 .../{staging/media =3D> media/pci}/zoran/zr36057.h   |  130 +-
 .../{staging/media =3D> media/pci}/zoran/zr36060.c   |    7 +-
 .../{staging/media =3D> media/pci}/zoran/zr36060.h   |   86 +-
 drivers/media/platform/Kconfig                     |    1 +
 drivers/media/platform/Makefile                    |    1 +
 drivers/media/platform/amlogic/meson-ge2d/ge2d.c   |    1 -
 drivers/media/platform/amphion/vdec.c              |   16 +-
 drivers/media/platform/amphion/venc.c              |    2 +-
 drivers/media/platform/amphion/vpu.h               |    1 -
 drivers/media/platform/amphion/vpu_core.c          |   84 +-
 drivers/media/platform/amphion/vpu_core.h          |    1 +
 drivers/media/platform/amphion/vpu_dbg.c           |    9 +-
 drivers/media/platform/amphion/vpu_malone.c        |    2 +-
 drivers/media/platform/amphion/vpu_v4l2.c          |   11 +-
 drivers/media/platform/chips-media/coda-jpeg.c     |   13 +-
 drivers/media/platform/intel/pxa_camera.c          |    8 +-
 drivers/media/platform/marvell/mcam-core.h         |    2 +-
 drivers/media/platform/mediatek/Kconfig            |    1 +
 drivers/media/platform/mediatek/Makefile           |    1 +
 .../media/platform/mediatek/jpeg/mtk_jpeg_core.c   |    1 -
 drivers/media/platform/mediatek/mdp3/Kconfig       |   21 +
 drivers/media/platform/mediatek/mdp3/Makefile      |    6 +
 .../media/platform/mediatek/mdp3/mdp_reg_ccorr.h   |   19 +
 .../media/platform/mediatek/mdp3/mdp_reg_rdma.h    |   65 +
 drivers/media/platform/mediatek/mdp3/mdp_reg_rsz.h |   39 +
 .../media/platform/mediatek/mdp3/mdp_reg_wdma.h    |   47 +
 .../media/platform/mediatek/mdp3/mdp_reg_wrot.h    |   55 +
 drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h |  290 ++++
 .../media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c   |  466 ++++++
 .../media/platform/mediatek/mdp3/mtk-mdp3-cmdq.h   |   43 +
 .../media/platform/mediatek/mdp3/mtk-mdp3-comp.c   | 1034 ++++++++++++
 .../media/platform/mediatek/mdp3/mtk-mdp3-comp.h   |  186 +++
 .../media/platform/mediatek/mdp3/mtk-mdp3-core.c   |  358 ++++
 .../media/platform/mediatek/mdp3/mtk-mdp3-core.h   |   94 ++
 .../media/platform/mediatek/mdp3/mtk-mdp3-m2m.c    |  724 +++++++++
 .../media/platform/mediatek/mdp3/mtk-mdp3-m2m.h    |   48 +
 .../media/platform/mediatek/mdp3/mtk-mdp3-regs.c   |  735 +++++++++
 .../media/platform/mediatek/mdp3/mtk-mdp3-regs.h   |  373 +++++
 .../media/platform/mediatek/mdp3/mtk-mdp3-vpu.c    |  314 ++++
 .../media/platform/mediatek/mdp3/mtk-mdp3-vpu.h    |   78 +
 .../platform/mediatek/vcodec/mtk_vcodec_dec.c      |    2 +
 .../platform/mediatek/vcodec/mtk_vcodec_dec_drv.c  |    4 +
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h      |    6 +
 .../platform/mediatek/vcodec/mtk_vcodec_enc.c      |   19 +-
 .../platform/mediatek/vcodec/mtk_vcodec_enc_drv.c  |   14 +
 .../platform/mediatek/vcodec/venc/venc_h264_if.c   |  200 ++-
 .../media/platform/mediatek/vcodec/venc_ipi_msg.h  |   24 +
 .../media/platform/mediatek/vcodec/venc_vpu_if.c   |   76 +-
 drivers/media/platform/nxp/Kconfig                 |   13 +-
 drivers/media/platform/nxp/Makefile                |    2 +-
 drivers/media/platform/nxp/dw100/Kconfig           |   16 +
 drivers/media/platform/nxp/dw100/Makefile          |    3 +
 drivers/media/platform/nxp/dw100/dw100.c           | 1707 ++++++++++++++++=
++++
 drivers/media/platform/nxp/dw100/dw100_regs.h      |  117 ++
 drivers/media/platform/qcom/camss/camss-video.c    |    6 +-
 drivers/media/platform/qcom/venus/helpers.c        |   13 +-
 drivers/media/platform/qcom/venus/hfi.c            |    5 +-
 drivers/media/platform/qcom/venus/vdec.c           |    2 +
 drivers/media/platform/qcom/venus/venc.c           |   29 +-
 drivers/media/platform/qcom/venus/venc_ctrls.c     |   38 +-
 .../media/platform/renesas/rcar-vin/rcar-core.c    |    5 +-
 drivers/media/platform/renesas/rcar-vin/rcar-dma.c |   18 +-
 drivers/media/platform/renesas/vsp1/vsp1.h         |    4 +
 drivers/media/platform/renesas/vsp1/vsp1_drv.c     |  101 +-
 drivers/media/platform/renesas/vsp1/vsp1_lif.c     |   12 +-
 drivers/media/platform/renesas/vsp1/vsp1_regs.h    |    6 +
 drivers/media/platform/renesas/vsp1/vsp1_video.c   |    8 +-
 drivers/media/platform/rockchip/rga/rga.c          |    2 +-
 .../platform/rockchip/rkisp1/rkisp1-capture.c      |   21 +-
 .../media/platform/rockchip/rkisp1/rkisp1-common.h |   30 +-
 .../media/platform/rockchip/rkisp1/rkisp1-isp.c    |  144 +-
 .../media/platform/rockchip/rkisp1/rkisp1-params.c |  531 +++---
 .../media/platform/rockchip/rkisp1/rkisp1-regs.h   |   47 +-
 .../platform/rockchip/rkisp1/rkisp1-resizer.c      |   45 +-
 .../platform/samsung/exynos4-is/fimc-capture.c     |    9 +-
 .../media/platform/samsung/exynos4-is/fimc-core.h  |    2 +-
 .../media/platform/samsung/exynos4-is/fimc-is.c    |    1 +
 .../platform/samsung/exynos4-is/fimc-isp-video.c   |    9 +-
 .../media/platform/samsung/exynos4-is/fimc-lite.c  |    9 +-
 .../platform/samsung/s3c-camif/camif-capture.c     |    6 +-
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c   |    5 +-
 drivers/media/platform/st/stm32/stm32-dcmi.c       |    6 +-
 drivers/media/platform/sunxi/sun4i-csi/Kconfig     |    2 +-
 drivers/media/platform/sunxi/sun4i-csi/sun4i_dma.c |    6 +-
 drivers/media/platform/sunxi/sun6i-csi/Kconfig     |   12 +-
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c |  592 ++++---
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h |   64 +-
 .../media/platform/sunxi/sun6i-csi/sun6i_video.c   |  594 +++----
 .../media/platform/sunxi/sun6i-csi/sun6i_video.h   |   23 +-
 .../media/platform/sunxi/sun6i-mipi-csi2/Kconfig   |    4 +-
 .../sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c        |   20 +-
 .../platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig    |    2 +-
 .../sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c    |   23 +-
 drivers/media/platform/sunxi/sun8i-di/Kconfig      |    2 +-
 drivers/media/platform/sunxi/sun8i-rotate/Kconfig  |    2 +-
 drivers/media/platform/ti/am437x/am437x-vpfe.h     |    2 +-
 drivers/media/platform/ti/cal/cal-camerarx.c       |   31 +-
 drivers/media/platform/ti/cal/cal-video.c          |   11 +-
 drivers/media/platform/ti/cal/cal.c                |  139 +-
 drivers/media/platform/ti/cal/cal.h                |    8 +-
 drivers/media/platform/ti/davinci/Kconfig          |   49 -
 drivers/media/platform/ti/davinci/Makefile         |    4 -
 drivers/media/platform/ti/davinci/vpbe.c           |    2 +-
 drivers/media/platform/ti/davinci/vpif.h           |   60 +-
 drivers/media/platform/ti/davinci/vpif_capture.c   |    6 +-
 drivers/media/platform/ti/davinci/vpif_capture.h   |    2 +-
 drivers/media/platform/ti/davinci/vpif_display.c   |    6 +-
 drivers/media/platform/ti/davinci/vpif_display.h   |    6 +-
 drivers/media/platform/ti/omap/omap_voutlib.c      |    2 +-
 drivers/media/platform/ti/omap3isp/isp.c           |    6 +-
 drivers/media/platform/ti/omap3isp/ispvideo.c      |   11 +-
 drivers/media/platform/ti/omap3isp/ispvideo.h      |   11 +-
 .../hantro =3D> media/platform/verisilicon}/Kconfig  |    6 +-
 .../hantro =3D> media/platform/verisilicon}/Makefile |    0
 .../hantro =3D> media/platform/verisilicon}/hantro.h |    0
 .../platform/verisilicon}/hantro_drv.c             |   14 +-
 .../platform/verisilicon}/hantro_g1.c              |    0
 .../platform/verisilicon}/hantro_g1_h264_dec.c     |    0
 .../platform/verisilicon}/hantro_g1_mpeg2_dec.c    |    0
 .../platform/verisilicon}/hantro_g1_regs.h         |    0
 .../platform/verisilicon}/hantro_g1_vp8_dec.c      |    0
 .../platform/verisilicon}/hantro_g2.c              |    0
 .../platform/verisilicon}/hantro_g2_hevc_dec.c     |    4 +-
 .../platform/verisilicon}/hantro_g2_regs.h         |    0
 .../platform/verisilicon}/hantro_g2_vp9_dec.c      |    0
 .../platform/verisilicon}/hantro_h1_jpeg_enc.c     |    0
 .../platform/verisilicon}/hantro_h1_regs.h         |    0
 .../platform/verisilicon}/hantro_h264.c            |    0
 .../platform/verisilicon}/hantro_hevc.c            |    4 +-
 .../platform/verisilicon}/hantro_hw.h              |    0
 .../platform/verisilicon}/hantro_jpeg.c            |    0
 .../platform/verisilicon}/hantro_jpeg.h            |    0
 .../platform/verisilicon}/hantro_mpeg2.c           |    0
 .../platform/verisilicon}/hantro_postproc.c        |    7 +-
 .../platform/verisilicon}/hantro_v4l2.c            |    0
 .../platform/verisilicon}/hantro_v4l2.h            |    0
 .../platform/verisilicon}/hantro_vp8.c             |    0
 .../platform/verisilicon}/hantro_vp9.c             |    0
 .../platform/verisilicon}/hantro_vp9.h             |    0
 .../platform/verisilicon}/imx8m_vpu_hw.c           |   27 +
 .../verisilicon}/rockchip_vpu2_hw_h264_dec.c       |    0
 .../verisilicon}/rockchip_vpu2_hw_jpeg_enc.c       |    0
 .../verisilicon}/rockchip_vpu2_hw_mpeg2_dec.c      |    0
 .../verisilicon}/rockchip_vpu2_hw_vp8_dec.c        |    0
 .../platform/verisilicon}/rockchip_vpu2_regs.h     |    0
 .../platform/verisilicon}/rockchip_vpu_hw.c        |    0
 .../platform/verisilicon}/sama5d4_vdec_hw.c        |    0
 .../platform/verisilicon}/sunxi_vpu_hw.c           |    0
 drivers/media/platform/xilinx/xilinx-csi2rxss.c    |    1 +
 drivers/media/platform/xilinx/xilinx-dma.c         |   11 +-
 drivers/media/platform/xilinx/xilinx-dma.h         |    9 +-
 drivers/media/platform/xilinx/xilinx-vip.c         |    2 +
 drivers/media/platform/xilinx/xilinx-vipp.c        |    9 +-
 drivers/media/radio/radio-si476x.c                 |    5 +-
 drivers/media/radio/si4713/si4713.c                |    2 +-
 drivers/media/rc/imon.c                            |    4 +-
 drivers/media/rc/mceusb.c                          |   37 +-
 drivers/media/test-drivers/vim2m.c                 |    2 +-
 drivers/media/test-drivers/vimc/vimc-capture.c     |    7 +-
 drivers/media/test-drivers/vivid/vivid-core.h      |    5 +-
 drivers/media/test-drivers/vivid/vivid-ctrls.c     |   14 +
 drivers/media/test-drivers/vivid/vivid-vid-cap.c   |    4 +
 drivers/media/tuners/xc4000.c                      |    4 +-
 drivers/media/usb/Kconfig                          |    3 -
 drivers/media/usb/Makefile                         |    3 -
 drivers/media/usb/airspy/airspy.c                  |    6 +-
 drivers/media/usb/au0828/au0828-core.c             |    8 +-
 drivers/media/usb/au0828/au0828-video.c            |    4 +-
 drivers/media/usb/cx231xx/cx231xx-vbi.c            |    2 +-
 drivers/media/usb/cx231xx/cx231xx-video.c          |    2 +-
 drivers/media/usb/dvb-usb-v2/af9035.c              |    2 +-
 drivers/media/usb/dvb-usb/technisat-usb2.c         |    2 +-
 drivers/media/usb/em28xx/em28xx-video.c            |    4 +-
 drivers/media/usb/gspca/finepix.c                  |    2 +-
 drivers/media/usb/msi2500/msi2500.c                |    4 +-
 drivers/media/usb/pvrusb2/pvrusb2-dvb.c            |    2 +-
 drivers/media/usb/uvc/uvc_ctrl.c                   |  117 +-
 drivers/media/usb/uvc/uvc_driver.c                 |   17 +-
 drivers/media/usb/uvc/uvc_video.c                  |    2 +-
 drivers/media/v4l2-core/v4l2-ctrls-api.c           |   62 +-
 drivers/media/v4l2-core/v4l2-ctrls-core.c          |  217 ++-
 drivers/media/v4l2-core/v4l2-dev.c                 |   72 +
 drivers/media/v4l2-core/v4l2-flash-led-class.c     |    2 +-
 drivers/media/v4l2-core/v4l2-ioctl.c               |    2 +-
 drivers/media/v4l2-core/v4l2-mem2mem.c             |    6 +-
 drivers/staging/media/Kconfig                      |   29 +-
 drivers/staging/media/Makefile                     |   12 +-
 drivers/staging/media/atomisp/Makefile             |    1 -
 drivers/staging/media/atomisp/i2c/atomisp-ov2680.c |   19 +-
 drivers/staging/media/atomisp/include/hmm/hmm_bo.h |    6 -
 .../staging/media/atomisp/include/linux/atomisp.h  |   14 -
 .../atomisp/include/linux/atomisp_gmin_platform.h  |    2 -
 .../media/atomisp/include/linux/atomisp_platform.h |   18 -
 drivers/staging/media/atomisp/notes.txt            |   19 +
 drivers/staging/media/atomisp/pci/atomisp_cmd.c    |  715 +-------
 drivers/staging/media/atomisp/pci/atomisp_cmd.h    |   11 +-
 drivers/staging/media/atomisp/pci/atomisp_compat.h |   10 -
 .../media/atomisp/pci/atomisp_compat_css20.c       |  100 +-
 drivers/staging/media/atomisp/pci/atomisp_file.c   |  229 ---
 drivers/staging/media/atomisp/pci/atomisp_file.h   |   44 -
 drivers/staging/media/atomisp/pci/atomisp_fops.c   |  274 +---
 .../media/atomisp/pci/atomisp_gmin_platform.c      |   94 +-
 .../staging/media/atomisp/pci/atomisp_internal.h   |   55 +-
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c  |  776 ++-------
 drivers/staging/media/atomisp/pci/atomisp_ioctl.h  |   14 +-
 drivers/staging/media/atomisp/pci/atomisp_subdev.c |  133 +-
 drivers/staging/media/atomisp/pci/atomisp_subdev.h |   71 +-
 drivers/staging/media/atomisp/pci/atomisp_v4l2.c   |  164 +-
 drivers/staging/media/atomisp/pci/atomisp_v4l2.h   |    3 -
 drivers/staging/media/atomisp/pci/hmm/hmm_bo.c     |  198 +--
 drivers/staging/media/atomisp/pci/sh_css_params.c  |    4 +-
 drivers/staging/media/av7110/TODO                  |    3 -
 .../usb =3D> staging/media/deprecated}/cpia2/Kconfig |    5 +-
 .../media/deprecated}/cpia2/Makefile               |    0
 drivers/staging/media/deprecated/cpia2/TODO        |    6 +
 .../usb =3D> staging/media/deprecated}/cpia2/cpia2.h |    0
 .../media/deprecated}/cpia2/cpia2_core.c           |    0
 .../media/deprecated}/cpia2/cpia2_registers.h      |    0
 .../media/deprecated}/cpia2/cpia2_usb.c            |    0
 .../media/deprecated}/cpia2/cpia2_v4l.c            |    0
 drivers/staging/media/deprecated/fsl-viu/Kconfig   |   15 +
 drivers/staging/media/deprecated/fsl-viu/Makefile  |    2 +
 drivers/staging/media/deprecated/fsl-viu/TODO      |    7 +
 .../media/deprecated/fsl-viu}/fsl-viu.c            |    0
 .../pci =3D> staging/media/deprecated}/meye/Kconfig  |    5 +-
 .../pci =3D> staging/media/deprecated}/meye/Makefile |    0
 drivers/staging/media/deprecated/meye/TODO         |    6 +
 .../pci =3D> staging/media/deprecated}/meye/meye.c   |    0
 .../pci =3D> staging/media/deprecated}/meye/meye.h   |    0
 drivers/staging/media/deprecated/saa7146/Kconfig   |    5 +
 drivers/staging/media/deprecated/saa7146/Makefile  |    2 +
 .../media/{ =3D> deprecated/saa7146}/av7110/Kconfig  |   20 +-
 .../media/{ =3D> deprecated/saa7146}/av7110/Makefile |    3 +-
 .../staging/media/deprecated/saa7146/av7110/TODO   |    9 +
 .../av7110/audio-bilingual-channel-select.rst      |    0
 .../saa7146}/av7110/audio-channel-select.rst       |    0
 .../saa7146}/av7110/audio-clear-buffer.rst         |    0
 .../saa7146}/av7110/audio-continue.rst             |    0
 .../saa7146}/av7110/audio-fclose.rst               |    0
 .../saa7146}/av7110/audio-fopen.rst                |    0
 .../saa7146}/av7110/audio-fwrite.rst               |    0
 .../saa7146}/av7110/audio-get-capabilities.rst     |    0
 .../saa7146}/av7110/audio-get-status.rst           |    0
 .../saa7146}/av7110/audio-pause.rst                |    0
 .../{ =3D> deprecated/saa7146}/av7110/audio-play.rst |    0
 .../saa7146}/av7110/audio-select-source.rst        |    0
 .../saa7146}/av7110/audio-set-av-sync.rst          |    0
 .../saa7146}/av7110/audio-set-bypass-mode.rst      |    0
 .../saa7146}/av7110/audio-set-id.rst               |    0
 .../saa7146}/av7110/audio-set-mixer.rst            |    0
 .../saa7146}/av7110/audio-set-mute.rst             |    0
 .../saa7146}/av7110/audio-set-streamtype.rst       |    0
 .../{ =3D> deprecated/saa7146}/av7110/audio-stop.rst |    0
 .../{ =3D> deprecated/saa7146}/av7110/audio.rst      |    0
 .../saa7146}/av7110/audio_data_types.rst           |    0
 .../saa7146}/av7110/audio_function_calls.rst       |    0
 .../media/{ =3D> deprecated/saa7146}/av7110/av7110.c |    0
 .../media/{ =3D> deprecated/saa7146}/av7110/av7110.h |    2 +-
 .../{ =3D> deprecated/saa7146}/av7110/av7110_av.c    |    2 +-
 .../{ =3D> deprecated/saa7146}/av7110/av7110_av.h    |    0
 .../{ =3D> deprecated/saa7146}/av7110/av7110_ca.c    |    0
 .../{ =3D> deprecated/saa7146}/av7110/av7110_ca.h    |    0
 .../{ =3D> deprecated/saa7146}/av7110/av7110_hw.c    |    0
 .../{ =3D> deprecated/saa7146}/av7110/av7110_hw.h    |    0
 .../{ =3D> deprecated/saa7146}/av7110/av7110_ipack.c |    0
 .../{ =3D> deprecated/saa7146}/av7110/av7110_ipack.h |    0
 .../{ =3D> deprecated/saa7146}/av7110/av7110_ir.c    |    0
 .../{ =3D> deprecated/saa7146}/av7110/av7110_v4l.c   |    0
 .../{ =3D> deprecated/saa7146}/av7110/budget-patch.c |    0
 .../{ =3D> deprecated/saa7146}/av7110/dvb_filter.c   |    0
 .../{ =3D> deprecated/saa7146}/av7110/dvb_filter.h   |    0
 .../media/{ =3D> deprecated/saa7146}/av7110/sp8870.c |    0
 .../media/{ =3D> deprecated/saa7146}/av7110/sp8870.h |    0
 .../saa7146}/av7110/video-clear-buffer.rst         |    0
 .../saa7146}/av7110/video-command.rst              |    0
 .../saa7146}/av7110/video-continue.rst             |    0
 .../saa7146}/av7110/video-fast-forward.rst         |    0
 .../saa7146}/av7110/video-fclose.rst               |    0
 .../saa7146}/av7110/video-fopen.rst                |    0
 .../saa7146}/av7110/video-freeze.rst               |    0
 .../saa7146}/av7110/video-fwrite.rst               |    0
 .../saa7146}/av7110/video-get-capabilities.rst     |    0
 .../saa7146}/av7110/video-get-event.rst            |    0
 .../saa7146}/av7110/video-get-frame-count.rst      |    0
 .../saa7146}/av7110/video-get-pts.rst              |    0
 .../saa7146}/av7110/video-get-size.rst             |    0
 .../saa7146}/av7110/video-get-status.rst           |    0
 .../{ =3D> deprecated/saa7146}/av7110/video-play.rst |    0
 .../saa7146}/av7110/video-select-source.rst        |    0
 .../saa7146}/av7110/video-set-blank.rst            |    0
 .../saa7146}/av7110/video-set-display-format.rst   |    0
 .../saa7146}/av7110/video-set-format.rst           |    0
 .../saa7146}/av7110/video-set-streamtype.rst       |    0
 .../saa7146}/av7110/video-slowmotion.rst           |    0
 .../saa7146}/av7110/video-stillpicture.rst         |    0
 .../{ =3D> deprecated/saa7146}/av7110/video-stop.rst |    0
 .../saa7146}/av7110/video-try-command.rst          |    0
 .../{ =3D> deprecated/saa7146}/av7110/video.rst      |    0
 .../saa7146}/av7110/video_function_calls.rst       |    0
 .../saa7146}/av7110/video_types.rst                |    0
 .../media/deprecated/saa7146/common}/Kconfig       |    0
 .../media/deprecated/saa7146/common}/Makefile      |    0
 .../media/deprecated/saa7146/common}/saa7146.h     |    0
 .../deprecated/saa7146/common}/saa7146_core.c      |    2 +-
 .../deprecated/saa7146/common}/saa7146_fops.c      |    2 +-
 .../media/deprecated/saa7146/common}/saa7146_hlp.c |    2 +-
 .../media/deprecated/saa7146/common}/saa7146_i2c.c |    2 +-
 .../media/deprecated/saa7146/common}/saa7146_vbi.c |    2 +-
 .../deprecated/saa7146/common}/saa7146_video.c     |    2 +-
 .../media/deprecated/saa7146/common}/saa7146_vv.h  |    2 +-
 .../media/deprecated/saa7146}/saa7146/Kconfig      |   15 +-
 .../media/deprecated/saa7146}/saa7146/Makefile     |    0
 .../staging/media/deprecated/saa7146/saa7146/TODO  |    7 +
 .../deprecated/saa7146}/saa7146/hexium_gemini.c    |    2 +-
 .../deprecated/saa7146}/saa7146/hexium_orion.c     |    2 +-
 .../media/deprecated/saa7146}/saa7146/mxb.c        |    2 +-
 .../media/deprecated/saa7146}/ttpci/Kconfig        |   17 +-
 .../media/deprecated/saa7146}/ttpci/Makefile       |    0
 .../staging/media/deprecated/saa7146/ttpci/TODO    |    7 +
 .../media/deprecated/saa7146}/ttpci/budget-av.c    |    2 +-
 .../media/deprecated/saa7146}/ttpci/budget-ci.c    |    0
 .../media/deprecated/saa7146}/ttpci/budget-core.c  |    0
 .../media/deprecated/saa7146}/ttpci/budget.c       |    0
 .../media/deprecated/saa7146}/ttpci/budget.h       |    2 +-
 .../media/{ =3D> deprecated}/stkwebcam/Kconfig       |    0
 .../media/{ =3D> deprecated}/stkwebcam/Makefile      |    0
 .../staging/media/{ =3D> deprecated}/stkwebcam/TODO  |    0
 .../media/{ =3D> deprecated}/stkwebcam/stk-sensor.c  |    0
 .../media/{ =3D> deprecated}/stkwebcam/stk-webcam.c  |    0
 .../media/{ =3D> deprecated}/stkwebcam/stk-webcam.h  |    0
 .../media/deprecated}/tm6000/Kconfig               |    5 +-
 .../media/deprecated}/tm6000/Makefile              |    0
 drivers/staging/media/deprecated/tm6000/TODO       |    7 +
 .../media/deprecated}/tm6000/tm6000-alsa.c         |    0
 .../media/deprecated}/tm6000/tm6000-cards.c        |    0
 .../media/deprecated}/tm6000/tm6000-core.c         |    0
 .../media/deprecated}/tm6000/tm6000-dvb.c          |    0
 .../media/deprecated}/tm6000/tm6000-i2c.c          |    0
 .../media/deprecated}/tm6000/tm6000-input.c        |    0
 .../media/deprecated}/tm6000/tm6000-regs.h         |    0
 .../media/deprecated}/tm6000/tm6000-stds.c         |    0
 .../media/deprecated}/tm6000/tm6000-usb-isoc.h     |    0
 .../media/deprecated}/tm6000/tm6000-video.c        |    2 -
 .../media/deprecated}/tm6000/tm6000.h              |    0
 .../staging/media/deprecated/vpfe_capture/Kconfig  |   58 +
 .../staging/media/deprecated/vpfe_capture/Makefile |    4 +
 drivers/staging/media/deprecated/vpfe_capture/TODO |    7 +
 .../deprecated/vpfe_capture}/ccdc_hw_device.h      |    0
 .../media/deprecated/vpfe_capture}/dm355_ccdc.c    |    2 +-
 .../media/deprecated/vpfe_capture}/dm355_ccdc.h    |    0
 .../deprecated/vpfe_capture}/dm355_ccdc_regs.h     |    0
 .../media/deprecated/vpfe_capture}/dm644x_ccdc.c   |    2 +-
 .../media/deprecated/vpfe_capture}/dm644x_ccdc.h   |    0
 .../deprecated/vpfe_capture}/dm644x_ccdc_regs.h    |    0
 .../media/deprecated/vpfe_capture}/isif.c          |    2 +-
 .../staging/media/deprecated/vpfe_capture}/isif.h  |    0
 .../media/deprecated/vpfe_capture}/isif_regs.h     |    0
 .../media/deprecated/vpfe_capture}/vpfe_capture.c  |    0
 .../media/deprecated}/zr364xx/Kconfig              |    7 +-
 .../media/deprecated}/zr364xx/Makefile             |    0
 drivers/staging/media/deprecated/zr364xx/TODO      |    7 +
 .../media/deprecated}/zr364xx/zr364xx.c            |    0
 drivers/staging/media/hantro/TODO                  |    2 -
 drivers/staging/media/imx/imx-media-utils.c        |    8 +-
 drivers/staging/media/imx/imx7-media-csi.c         |    8 +-
 .../staging/media/ipu3/include/uapi/intel-ipu3.h   |    7 +-
 drivers/staging/media/ipu3/ipu3-v4l2.c             |   37 +-
 drivers/staging/media/meson/vdec/vdec.c            |    2 +
 drivers/staging/media/meson/vdec/vdec_hevc.c       |    6 +-
 drivers/staging/media/omap4iss/iss.c               |    4 +-
 drivers/staging/media/omap4iss/iss_video.c         |   11 +-
 drivers/staging/media/omap4iss/iss_video.h         |   11 +-
 drivers/staging/media/sunxi/cedrus/Kconfig         |    1 +
 drivers/staging/media/sunxi/cedrus/cedrus.c        |    4 +-
 drivers/staging/media/sunxi/cedrus/cedrus.h        |   24 +-
 drivers/staging/media/sunxi/cedrus/cedrus_dec.c    |    4 +-
 drivers/staging/media/sunxi/cedrus/cedrus_h264.c   |   16 +-
 drivers/staging/media/sunxi/cedrus/cedrus_h265.c   |   23 +-
 drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c  |   28 +-
 drivers/staging/media/sunxi/cedrus/cedrus_vp8.c    |   43 +-
 drivers/staging/media/tegra-video/tegra210.c       |    6 +-
 drivers/staging/media/zoran/TODO                   |   19 -
 drivers/staging/media/zoran/zoran_device.h         |   60 -
 include/media/davinci/vpbe_display.h               |    6 +-
 include/media/i2c/ir-kbd-i2c.h                     |    1 +
 include/media/media-device.h                       |   15 -
 include/media/media-entity.h                       |  169 +-
 include/media/v4l2-common.h                        |    3 +-
 include/media/v4l2-ctrls.h                         |  148 +-
 include/media/v4l2-dev.h                           |  102 ++
 include/media/v4l2-fwnode.h                        |    4 -
 include/media/v4l2-mem2mem.h                       |   12 +-
 include/media/v4l2-subdev.h                        |   12 +-
 include/media/videobuf2-core.h                     |   16 +-
 include/media/videobuf2-dvb.h                      |    2 +-
 include/media/videobuf2-v4l2.h                     |   16 -
 include/uapi/linux/cec-funcs.h                     |   14 +
 include/uapi/linux/cec.h                           |    2 +
 include/uapi/linux/dw100.h                         |   14 +
 include/uapi/linux/rkisp1-config.h                 |   77 +-
 include/uapi/linux/v4l2-controls.h                 |    8 +-
 include/uapi/linux/videodev2.h                     |    7 +-
 489 files changed, 12756 insertions(+), 5363 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/exynos5-gsc.txt
 delete mode 100644 Documentation/devicetree/bindings/media/i2c/dongwoon,dw=
9714.txt
 create mode 100644 Documentation/devicetree/bindings/media/i2c/dongwoon,dw=
9714.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-r=
dma.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-r=
sz.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-w=
rot.yaml
 create mode 100644 Documentation/devicetree/bindings/media/nxp,dw100.yaml
 create mode 100644 Documentation/devicetree/bindings/media/samsung,exynos5=
250-gsc.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek=
,ccorr.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek=
,wdma.yaml
 create mode 100644 Documentation/userspace-api/media/drivers/dw100.rst
 delete mode 100644 Documentation/userspace-api/media/v4l/async.rst
 rename drivers/{staging/media =3D> media/pci}/zoran/Kconfig (100%)
 rename drivers/{staging/media =3D> media/pci}/zoran/Makefile (100%)
 rename drivers/{staging/media =3D> media/pci}/zoran/videocodec.c (97%)
 rename drivers/{staging/media =3D> media/pci}/zoran/videocodec.h (65%)
 rename drivers/{staging/media =3D> media/pci}/zoran/zoran.h (90%)
 rename drivers/{staging/media =3D> media/pci}/zoran/zoran_card.c (97%)
 rename drivers/{staging/media =3D> media/pci}/zoran/zoran_card.h (72%)
 rename drivers/{staging/media =3D> media/pci}/zoran/zoran_device.c (96%)
 create mode 100644 drivers/media/pci/zoran/zoran_device.h
 rename drivers/{staging/media =3D> media/pci}/zoran/zoran_driver.c (94%)
 rename drivers/{staging/media =3D> media/pci}/zoran/zr36016.c (73%)
 rename drivers/{staging/media =3D> media/pci}/zoran/zr36016.h (100%)
 rename drivers/{staging/media =3D> media/pci}/zoran/zr36050.c (82%)
 rename drivers/{staging/media =3D> media/pci}/zoran/zr36050.h (100%)
 rename drivers/{staging/media =3D> media/pci}/zoran/zr36057.h (50%)
 rename drivers/{staging/media =3D> media/pci}/zoran/zr36060.c (99%)
 rename drivers/{staging/media =3D> media/pci}/zoran/zr36060.h (72%)
 create mode 100644 drivers/media/platform/mediatek/mdp3/Kconfig
 create mode 100644 drivers/media/platform/mediatek/mdp3/Makefile
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_ccorr.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_rdma.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_rsz.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_wdma.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_wrot.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
 create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
 create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
 create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c
 create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c
 create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.h
 create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c
 create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.h
 create mode 100644 drivers/media/platform/nxp/dw100/Kconfig
 create mode 100644 drivers/media/platform/nxp/dw100/Makefile
 create mode 100644 drivers/media/platform/nxp/dw100/dw100.c
 create mode 100644 drivers/media/platform/nxp/dw100/dw100_regs.h
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/Kcon=
fig (91%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/Make=
file (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/hant=
ro.h (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/hant=
ro_drv.c (99%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/hant=
ro_g1.c (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/hant=
ro_g1_h264_dec.c (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/hant=
ro_g1_mpeg2_dec.c (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/hant=
ro_g1_regs.h (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/hant=
ro_g1_vp8_dec.c (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/hant=
ro_g2.c (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/hant=
ro_g2_hevc_dec.c (99%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/hant=
ro_g2_regs.h (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/hant=
ro_g2_vp9_dec.c (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/hant=
ro_h1_jpeg_enc.c (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/hant=
ro_h1_regs.h (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/hant=
ro_h264.c (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/hant=
ro_hevc.c (97%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/hant=
ro_hw.h (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/hant=
ro_jpeg.c (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/hant=
ro_jpeg.h (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/hant=
ro_mpeg2.c (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/hant=
ro_postproc.c (97%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/hant=
ro_v4l2.c (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/hant=
ro_v4l2.h (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/hant=
ro_vp8.c (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/hant=
ro_vp9.c (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/hant=
ro_vp9.h (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/imx8=
m_vpu_hw.c (93%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/rock=
chip_vpu2_hw_h264_dec.c (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/rock=
chip_vpu2_hw_jpeg_enc.c (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/rock=
chip_vpu2_hw_mpeg2_dec.c (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/rock=
chip_vpu2_hw_vp8_dec.c (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/rock=
chip_vpu2_regs.h (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/rock=
chip_vpu_hw.c (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/sama=
5d4_vdec_hw.c (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/sunx=
i_vpu_hw.c (100%)
 delete mode 100644 drivers/staging/media/atomisp/pci/atomisp_file.c
 delete mode 100644 drivers/staging/media/atomisp/pci/atomisp_file.h
 delete mode 100644 drivers/staging/media/av7110/TODO
 rename drivers/{media/usb =3D> staging/media/deprecated}/cpia2/Kconfig (66=
%)
 rename drivers/{media/usb =3D> staging/media/deprecated}/cpia2/Makefile (1=
00%)
 create mode 100644 drivers/staging/media/deprecated/cpia2/TODO
 rename drivers/{media/usb =3D> staging/media/deprecated}/cpia2/cpia2.h (10=
0%)
 rename drivers/{media/usb =3D> staging/media/deprecated}/cpia2/cpia2_core.=
c (100%)
 rename drivers/{media/usb =3D> staging/media/deprecated}/cpia2/cpia2_regis=
ters.h (100%)
 rename drivers/{media/usb =3D> staging/media/deprecated}/cpia2/cpia2_usb.c=
 (100%)
 rename drivers/{media/usb =3D> staging/media/deprecated}/cpia2/cpia2_v4l.c=
 (100%)
 create mode 100644 drivers/staging/media/deprecated/fsl-viu/Kconfig
 create mode 100644 drivers/staging/media/deprecated/fsl-viu/Makefile
 create mode 100644 drivers/staging/media/deprecated/fsl-viu/TODO
 rename drivers/{media/platform/nxp =3D> staging/media/deprecated/fsl-viu}/=
fsl-viu.c (100%)
 rename drivers/{media/pci =3D> staging/media/deprecated}/meye/Kconfig (73%)
 rename drivers/{media/pci =3D> staging/media/deprecated}/meye/Makefile (10=
0%)
 create mode 100644 drivers/staging/media/deprecated/meye/TODO
 rename drivers/{media/pci =3D> staging/media/deprecated}/meye/meye.c (100%)
 rename drivers/{media/pci =3D> staging/media/deprecated}/meye/meye.h (100%)
 create mode 100644 drivers/staging/media/deprecated/saa7146/Kconfig
 create mode 100644 drivers/staging/media/deprecated/saa7146/Makefile
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/Kconfig (82=
%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/Makefile (7=
8%)
 create mode 100644 drivers/staging/media/deprecated/saa7146/av7110/TODO
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/audio-bilin=
gual-channel-select.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/audio-chann=
el-select.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/audio-clear=
-buffer.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/audio-conti=
nue.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/audio-fclos=
e.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/audio-fopen=
.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/audio-fwrit=
e.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/audio-get-c=
apabilities.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/audio-get-s=
tatus.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/audio-pause=
.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/audio-play.=
rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/audio-selec=
t-source.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/audio-set-a=
v-sync.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/audio-set-b=
ypass-mode.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/audio-set-i=
d.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/audio-set-m=
ixer.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/audio-set-m=
ute.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/audio-set-s=
treamtype.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/audio-stop.=
rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/audio.rst (=
100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/audio_data_=
types.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/audio_funct=
ion_calls.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/av7110.c (1=
00%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/av7110.h (9=
9%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/av7110_av.c=
 (99%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/av7110_av.h=
 (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/av7110_ca.c=
 (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/av7110_ca.h=
 (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/av7110_hw.c=
 (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/av7110_hw.h=
 (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/av7110_ipac=
k.c (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/av7110_ipac=
k.h (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/av7110_ir.c=
 (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/av7110_v4l.=
c (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/budget-patc=
h.c (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/dvb_filter.=
c (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/dvb_filter.=
h (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/sp8870.c (1=
00%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/sp8870.h (1=
00%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/video-clear=
-buffer.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/video-comma=
nd.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/video-conti=
nue.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/video-fast-=
forward.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/video-fclos=
e.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/video-fopen=
.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/video-freez=
e.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/video-fwrit=
e.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/video-get-c=
apabilities.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/video-get-e=
vent.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/video-get-f=
rame-count.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/video-get-p=
ts.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/video-get-s=
ize.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/video-get-s=
tatus.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/video-play.=
rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/video-selec=
t-source.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/video-set-b=
lank.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/video-set-d=
isplay-format.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/video-set-f=
ormat.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/video-set-s=
treamtype.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/video-slowm=
otion.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/video-still=
picture.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/video-stop.=
rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/video-try-c=
ommand.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/video.rst (=
100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/video_funct=
ion_calls.rst (100%)
 rename drivers/staging/media/{ =3D> deprecated/saa7146}/av7110/video_types=
.rst (100%)
 rename drivers/{media/common/saa7146 =3D> staging/media/deprecated/saa7146=
/common}/Kconfig (100%)
 rename drivers/{media/common/saa7146 =3D> staging/media/deprecated/saa7146=
/common}/Makefile (100%)
 rename {include/media/drv-intf =3D> drivers/staging/media/deprecated/saa71=
46/common}/saa7146.h (100%)
 rename drivers/{media/common/saa7146 =3D> staging/media/deprecated/saa7146=
/common}/saa7146_core.c (99%)
 rename drivers/{media/common/saa7146 =3D> staging/media/deprecated/saa7146=
/common}/saa7146_fops.c (99%)
 rename drivers/{media/common/saa7146 =3D> staging/media/deprecated/saa7146=
/common}/saa7146_hlp.c (99%)
 rename drivers/{media/common/saa7146 =3D> staging/media/deprecated/saa7146=
/common}/saa7146_i2c.c (99%)
 rename drivers/{media/common/saa7146 =3D> staging/media/deprecated/saa7146=
/common}/saa7146_vbi.c (99%)
 rename drivers/{media/common/saa7146 =3D> staging/media/deprecated/saa7146=
/common}/saa7146_video.c (99%)
 rename {include/media/drv-intf =3D> drivers/staging/media/deprecated/saa71=
46/common}/saa7146_vv.h (99%)
 rename drivers/{media/pci =3D> staging/media/deprecated/saa7146}/saa7146/K=
config (67%)
 rename drivers/{media/pci =3D> staging/media/deprecated/saa7146}/saa7146/M=
akefile (100%)
 create mode 100644 drivers/staging/media/deprecated/saa7146/saa7146/TODO
 rename drivers/{media/pci =3D> staging/media/deprecated/saa7146}/saa7146/h=
exium_gemini.c (99%)
 rename drivers/{media/pci =3D> staging/media/deprecated/saa7146}/saa7146/h=
exium_orion.c (99%)
 rename drivers/{media/pci =3D> staging/media/deprecated/saa7146}/saa7146/m=
xb.c (99%)
 rename drivers/{media/pci =3D> staging/media/deprecated/saa7146}/ttpci/Kco=
nfig (83%)
 rename drivers/{media/pci =3D> staging/media/deprecated/saa7146}/ttpci/Mak=
efile (100%)
 create mode 100644 drivers/staging/media/deprecated/saa7146/ttpci/TODO
 rename drivers/{media/pci =3D> staging/media/deprecated/saa7146}/ttpci/bud=
get-av.c (99%)
 rename drivers/{media/pci =3D> staging/media/deprecated/saa7146}/ttpci/bud=
get-ci.c (100%)
 rename drivers/{media/pci =3D> staging/media/deprecated/saa7146}/ttpci/bud=
get-core.c (100%)
 rename drivers/{media/pci =3D> staging/media/deprecated/saa7146}/ttpci/bud=
get.c (100%)
 rename drivers/{media/pci =3D> staging/media/deprecated/saa7146}/ttpci/bud=
get.h (98%)
 rename drivers/staging/media/{ =3D> deprecated}/stkwebcam/Kconfig (100%)
 rename drivers/staging/media/{ =3D> deprecated}/stkwebcam/Makefile (100%)
 rename drivers/staging/media/{ =3D> deprecated}/stkwebcam/TODO (100%)
 rename drivers/staging/media/{ =3D> deprecated}/stkwebcam/stk-sensor.c (10=
0%)
 rename drivers/staging/media/{ =3D> deprecated}/stkwebcam/stk-webcam.c (10=
0%)
 rename drivers/staging/media/{ =3D> deprecated}/stkwebcam/stk-webcam.h (10=
0%)
 rename drivers/{media/usb =3D> staging/media/deprecated}/tm6000/Kconfig (8=
4%)
 rename drivers/{media/usb =3D> staging/media/deprecated}/tm6000/Makefile (=
100%)
 create mode 100644 drivers/staging/media/deprecated/tm6000/TODO
 rename drivers/{media/usb =3D> staging/media/deprecated}/tm6000/tm6000-als=
a.c (100%)
 rename drivers/{media/usb =3D> staging/media/deprecated}/tm6000/tm6000-car=
ds.c (100%)
 rename drivers/{media/usb =3D> staging/media/deprecated}/tm6000/tm6000-cor=
e.c (100%)
 rename drivers/{media/usb =3D> staging/media/deprecated}/tm6000/tm6000-dvb=
.c (100%)
 rename drivers/{media/usb =3D> staging/media/deprecated}/tm6000/tm6000-i2c=
.c (100%)
 rename drivers/{media/usb =3D> staging/media/deprecated}/tm6000/tm6000-inp=
ut.c (100%)
 rename drivers/{media/usb =3D> staging/media/deprecated}/tm6000/tm6000-reg=
s.h (100%)
 rename drivers/{media/usb =3D> staging/media/deprecated}/tm6000/tm6000-std=
s.c (100%)
 rename drivers/{media/usb =3D> staging/media/deprecated}/tm6000/tm6000-usb=
-isoc.h (100%)
 rename drivers/{media/usb =3D> staging/media/deprecated}/tm6000/tm6000-vid=
eo.c (99%)
 rename drivers/{media/usb =3D> staging/media/deprecated}/tm6000/tm6000.h (=
100%)
 create mode 100644 drivers/staging/media/deprecated/vpfe_capture/Kconfig
 create mode 100644 drivers/staging/media/deprecated/vpfe_capture/Makefile
 create mode 100644 drivers/staging/media/deprecated/vpfe_capture/TODO
 rename drivers/{media/platform/ti/davinci =3D> staging/media/deprecated/vp=
fe_capture}/ccdc_hw_device.h (100%)
 rename drivers/{media/platform/ti/davinci =3D> staging/media/deprecated/vp=
fe_capture}/dm355_ccdc.c (99%)
 rename {include/media/davinci =3D> drivers/staging/media/deprecated/vpfe_c=
apture}/dm355_ccdc.h (100%)
 rename drivers/{media/platform/ti/davinci =3D> staging/media/deprecated/vp=
fe_capture}/dm355_ccdc_regs.h (100%)
 rename drivers/{media/platform/ti/davinci =3D> staging/media/deprecated/vp=
fe_capture}/dm644x_ccdc.c (99%)
 rename {include/media/davinci =3D> drivers/staging/media/deprecated/vpfe_c=
apture}/dm644x_ccdc.h (100%)
 rename drivers/{media/platform/ti/davinci =3D> staging/media/deprecated/vp=
fe_capture}/dm644x_ccdc_regs.h (100%)
 rename drivers/{media/platform/ti/davinci =3D> staging/media/deprecated/vp=
fe_capture}/isif.c (99%)
 rename {include/media/davinci =3D> drivers/staging/media/deprecated/vpfe_c=
apture}/isif.h (100%)
 rename drivers/{media/platform/ti/davinci =3D> staging/media/deprecated/vp=
fe_capture}/isif_regs.h (100%)
 rename drivers/{media/platform/ti/davinci =3D> staging/media/deprecated/vp=
fe_capture}/vpfe_capture.c (100%)
 rename drivers/{media/usb =3D> staging/media/deprecated}/zr364xx/Kconfig (=
65%)
 rename drivers/{media/usb =3D> staging/media/deprecated}/zr364xx/Makefile =
(100%)
 create mode 100644 drivers/staging/media/deprecated/zr364xx/TODO
 rename drivers/{media/usb =3D> staging/media/deprecated}/zr364xx/zr364xx.c=
 (100%)
 delete mode 100644 drivers/staging/media/hantro/TODO
 delete mode 100644 drivers/staging/media/zoran/TODO
 delete mode 100644 drivers/staging/media/zoran/zoran_device.h
 create mode 100644 include/uapi/linux/dw100.h

