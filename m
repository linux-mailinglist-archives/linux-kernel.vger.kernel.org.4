Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9F15F51B1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 11:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiJEJXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 05:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJEJXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 05:23:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C81C6F26C;
        Wed,  5 Oct 2022 02:23:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B854615DB;
        Wed,  5 Oct 2022 09:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A063C433D7;
        Wed,  5 Oct 2022 09:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664961810;
        bh=Hm6PRzQjtt3OFrHnu5k0gL+5efpelxt/VBeaTrLhdtI=;
        h=Date:From:To:Cc:Subject:From;
        b=Jn13vjCZ4NXc8wqC7nq0AbzR4EKAOfrmQdtsDF4vNhk9T2YjR55YRB+Ck/qFnVlcZ
         nfZtLYFwOIzQiLeIm2SNzwlK9zVohAdMAMghxI/SfR8mbkldYKbg76RImC8ILgF3XB
         o4RzR+B/XbTw0PktrCmzWf4NQOMigkP37rv0qaiT7XCIUwHGkc+MRtG8QbsHbHbOEK
         3FXPXqBEAwuLfmPJU19Mm06djKAN55dplCVhTYDbLvRja17mQ9Z2AYw4EQCzTPBnPv
         fpn4w2hJR9zFwvp63N9RZ7wVjTRjePcd836zvb+eqUapoQdIN21DZ3BCj1P0K9oF0l
         HW6wVqZbORGgw==
Date:   Wed, 5 Oct 2022 10:23:23 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v6.1-rc1] media updates
Message-ID: <20221005102323.4f751c1a@sal.lan>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
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
dia/v6.1-1


For:

- New driver for Mediatek MDP V3;
- New driver for NXP i.MX DW100 dewarper;
- Zoran driver got promoted from staging;
- Hantro and related drivers got promoted from staging;
- Several VB1 drivers got moved to staging/deprecated (cpia2, fsl-viu,=20
  meye, saa7146, av7110, stkwebcam, tm6000, vpfe_capture, davinci,
  zr364xx);
- Usual set of driver fixes, improvements and cleanups.

Regards,
Mauro

---

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/me=
dia/v6.1-1

for you to fetch changes up to fbb6c848dd89786fe24856ee6b5e773910ded29c:

  media: destage Hantro VPU driver (2022-08-31 10:23:50 +0200)

----------------------------------------------------------------
media updates for v6.1-rc1

----------------------------------------------------------------
Biju Das (5):
      media: dt-bindings: media: renesas,vsp1: Document RZ/G2L VSPD bindings
      media: renesas: vsp1: Add support to deassert/assert reset line
      media: renesas: vsp1: Add support for VSP software version
      media: renesas: vsp1: Add VSP1_HAS_NON_ZERO_LBA feature bit
      media: renesas: vsp1: Add support for RZ/G2L VSPD

Christophe JAILLET (1):
      media: dw100: Fix an error handling path in dw100_probe()

Daniel Lee Kruse (1):
      media: cx23885: reset DMA on AMD Renior/Cezanne IOMMU due to RiSC eng=
ine stall

Deborah Brouwer (1):
      media: v4l2-ctrls: Fix typo in VP8 comment

Dmitry Osipenko (2):
      media: cedrus: Set the platform driver data earlier
      media: cedrus: Fix endless loop in cedrus_h265_skip_bits()

Dongliang Mu (1):
      media: airspy: fix memory leak in airspy probe

Ezequiel Garcia (3):
      media: cedrus: Use vb2_find_buffer
      media: videobuf2: Remove vb2_find_timestamp()
      media: destage Hantro VPU driver

Hangyu Hua (1):
      media: platform: fix some double free in meson-ge2d and mtk-jpeg and =
s5p-mfc

Hans Verkuil (29):
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

Jason Wang (5):
      media: dib8000: Fix comment typo
      media: sun6i-csi: Fix comment typo
      media: drxk: Fix comment typo
      media: technisat-usb2: Fix comment typo
      media: v4l2-flash: Fix comment typo

Jos=C3=A9 Exp=C3=B3sito (1):
      media: uvcvideo: Fix memory leak in uvc_gpio_parse

Laurent Pinchart (1):
      media: uvcvideo: Use indexed loops in uvc_ctrl_init_ctrl()

Li zeming (1):
      media: staging/media/av7110/av7110: Fix typo in string

Liang He (1):
      media: exynos4-is: fimc-is: Add of_node_put() when breaking out of lo=
op

Miaoqian Lin (1):
      media: xilinx: vipp: Fix refcount leak in xvip_graph_dma_init

Ming Qian (4):
      media: amphion: insert picture startcode after seek for vc1g format
      media: amphion: adjust the encoder's value range of gop size
      media: amphion: don't change the colorspace reported by decoder.
      media: amphion: fix a bug that vpu core may not resume after suspend

Moudy Ho (3):
      media: dt-binding: mediatek: add bindings for MediaTek MDP3 components
      media: dt-binding: mediatek: add bindings for MediaTek CCORR and WDMA
      media: platform: mtk-mdp3: add MediaTek MDP3 driver

Nicolas Dufresne (1):
      media: cedrus: Fix watchdog race condition

Ondrej Jirman (1):
      media: rockchip: rga: Fix probe rga_parse_dt bugs

Petko Manolov (1):
      media: staging: media: imx: imx7-media-csi: Increase video mem limit

Slark Xiao (9):
      media: dvb-frontends: Fix typo 'the the' in comment
      media: cx88: Fix typo 'the the' in comment
      media: ivtv: Fix typo 'the the' in comment
      media: saa7164: Fix typo 'the the' in comment
      media: platform: ti: Fix typo 'the the' in comment
      media: gspca: Fix typo 'the the' in comment
      media: tm6000: Fix typo 'the the' in comment
      media: v4l2-ioctl: Fix typo 'the the' in comment
      media: uvcvideo: Fix typo 'the the' in comment

Tomi Valkeinen (5):
      media: ti: cal: fix useless variable init
      media: ti: cal: rename sd_state to state
      media: ti: cal: use CSI-2 frame number for seq number
      media: ti: cal: combine wdma irq handling
      media: ti: cal: fix wdma irq for metadata

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

 .../bindings/media/mediatek,mdp3-rdma.yaml         |   95 ++
 .../bindings/media/mediatek,mdp3-rsz.yaml          |   77 +
 .../bindings/media/mediatek,mdp3-wrot.yaml         |   80 +
 .../bindings/media/mediatek,vcodec-encoder.yaml    |    1 +
 .../media/mediatek,vcodec-subdev-decoder.yaml      |    1 +
 .../devicetree/bindings/media/nxp,dw100.yaml       |   69 +
 .../devicetree/bindings/media/renesas,vsp1.yaml    |   53 +-
 .../bindings/soc/mediatek/mediatek,ccorr.yaml      |   68 +
 .../bindings/soc/mediatek/mediatek,wdma.yaml       |   81 +
 .../driver-api/media/drivers/pxa_camera.rst        |    2 +-
 .../userspace-api/media/drivers/dw100.rst          |   84 +
 .../userspace-api/media/drivers/index.rst          |    1 +
 Documentation/userspace-api/media/v4l/async.rst    |    9 -
 .../userspace-api/media/v4l/dev-raw-vbi.rst        |    2 +-
 Documentation/userspace-api/media/v4l/dev-sdr.rst  |    2 +-
 .../userspace-api/media/v4l/dev-sliced-vbi.rst     |    2 +-
 .../userspace-api/media/v4l/hist-v4l2.rst          |    2 +-
 Documentation/userspace-api/media/v4l/io.rst       |    4 +-
 .../userspace-api/media/v4l/vidioc-dqevent.rst     |    5 +
 .../userspace-api/media/v4l/vidioc-querycap.rst    |    3 -
 .../userspace-api/media/videodev2.h.rst.exceptions |    1 +
 MAINTAINERS                                        |   24 +-
 drivers/media/cec/platform/sti/stih-cec.c          |    4 +-
 drivers/media/common/Kconfig                       |    1 -
 drivers/media/common/Makefile                      |    2 +-
 drivers/media/common/videobuf2/videobuf2-core.c    |   14 +-
 drivers/media/common/videobuf2/videobuf2-dvb.c     |    4 +-
 drivers/media/common/videobuf2/videobuf2-v4l2.c    |   17 +-
 drivers/media/dvb-frontends/dib8000.c              |    2 +-
 drivers/media/dvb-frontends/drxk_hard.c            |    2 +-
 drivers/media/dvb-frontends/rtl2832_sdr.c          |    2 +-
 drivers/media/dvb-frontends/tda1002x.h             |    2 +-
 drivers/media/dvb-frontends/tda10048.c             |    2 +-
 drivers/media/i2c/adv7511-v4l2.c                   |    4 +-
 drivers/media/i2c/adv7604.c                        |    4 +-
 drivers/media/i2c/adv7842.c                        |    4 +-
 drivers/media/i2c/cx25840/cx25840-ir.c             |    2 +-
 drivers/media/i2c/tc358743.c                       |    2 +
 drivers/media/pci/Kconfig                          |    4 +-
 drivers/media/pci/Makefile                         |    6 +-
 drivers/media/pci/cx18/cx18-av-audio.c             |    2 +-
 drivers/media/pci/cx18/cx18-firmware.c             |    2 +-
 drivers/media/pci/cx23885/cx23885-core.c           |    3 +
 drivers/media/pci/cx23885/cx23888-ir.c             |    2 +-
 drivers/media/pci/cx88/cx88-dsp.c                  |    2 +-
 drivers/media/pci/cx88/cx88-vbi.c                  |    9 +-
 drivers/media/pci/cx88/cx88-video.c                |   43 +-
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
 .../media/platform/mediatek/mdp3/mtk-mdp3-comp.c   | 1033 ++++++++++++
 .../media/platform/mediatek/mdp3/mtk-mdp3-comp.h   |  186 +++
 .../media/platform/mediatek/mdp3/mtk-mdp3-core.c   |  357 ++++
 .../media/platform/mediatek/mdp3/mtk-mdp3-core.h   |   94 ++
 .../media/platform/mediatek/mdp3/mtk-mdp3-m2m.c    |  724 +++++++++
 .../media/platform/mediatek/mdp3/mtk-mdp3-m2m.h    |   48 +
 .../media/platform/mediatek/mdp3/mtk-mdp3-regs.c   |  735 +++++++++
 .../media/platform/mediatek/mdp3/mtk-mdp3-regs.h   |  373 +++++
 .../media/platform/mediatek/mdp3/mtk-mdp3-vpu.c    |  313 ++++
 .../media/platform/mediatek/mdp3/mtk-mdp3-vpu.h    |   78 +
 .../platform/mediatek/vcodec/mtk_vcodec_dec.c      |    2 +
 .../platform/mediatek/vcodec/mtk_vcodec_dec_drv.c  |    4 +
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h      |    6 +
 .../platform/mediatek/vcodec/mtk_vcodec_enc.c      |   19 +-
 .../platform/mediatek/vcodec/mtk_vcodec_enc_drv.c  |   22 +-
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
 drivers/media/platform/renesas/vsp1/vsp1.h         |    4 +
 drivers/media/platform/renesas/vsp1/vsp1_drv.c     |  101 +-
 drivers/media/platform/renesas/vsp1/vsp1_lif.c     |   12 +-
 drivers/media/platform/renesas/vsp1/vsp1_regs.h    |    6 +
 drivers/media/platform/renesas/vsp1/vsp1_video.c   |    2 +-
 drivers/media/platform/rockchip/rga/rga.c          |    2 +-
 .../media/platform/samsung/exynos4-is/fimc-core.h  |    2 +-
 .../media/platform/samsung/exynos4-is/fimc-is.c    |    1 +
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc.c   |    5 +-
 .../media/platform/sunxi/sun6i-csi/sun6i_video.c   |    2 +-
 drivers/media/platform/ti/am437x/am437x-vpfe.h     |    2 +-
 drivers/media/platform/ti/cal/cal-camerarx.c       |   31 +-
 drivers/media/platform/ti/cal/cal-video.c          |    5 +-
 drivers/media/platform/ti/cal/cal.c                |  139 +-
 drivers/media/platform/ti/cal/cal.h                |    7 +-
 drivers/media/platform/ti/davinci/Kconfig          |   49 -
 drivers/media/platform/ti/davinci/Makefile         |    4 -
 drivers/media/platform/ti/davinci/vpbe.c           |    2 +-
 drivers/media/platform/ti/davinci/vpif.h           |   60 +-
 drivers/media/platform/ti/davinci/vpif_capture.c   |    6 +-
 drivers/media/platform/ti/davinci/vpif_capture.h   |    2 +-
 drivers/media/platform/ti/davinci/vpif_display.c   |    6 +-
 drivers/media/platform/ti/davinci/vpif_display.h   |    6 +-
 drivers/media/platform/ti/omap/omap_voutlib.c      |    2 +-
 drivers/media/platform/ti/omap3isp/isp.c           |    2 +-
 drivers/media/platform/ti/omap3isp/ispvideo.c      |    2 +-
 .../hantro =3D> media/platform/verisilicon}/Kconfig  |    6 +-
 .../hantro =3D> media/platform/verisilicon}/Makefile |    0
 .../hantro =3D> media/platform/verisilicon}/hantro.h |    0
 .../platform/verisilicon}/hantro_drv.c             |    0
 .../platform/verisilicon}/hantro_g1.c              |    0
 .../platform/verisilicon}/hantro_g1_h264_dec.c     |    0
 .../platform/verisilicon}/hantro_g1_mpeg2_dec.c    |    0
 .../platform/verisilicon}/hantro_g1_regs.h         |    0
 .../platform/verisilicon}/hantro_g1_vp8_dec.c      |    0
 .../platform/verisilicon}/hantro_g2.c              |    0
 .../platform/verisilicon}/hantro_g2_hevc_dec.c     |    0
 .../platform/verisilicon}/hantro_g2_regs.h         |    0
 .../platform/verisilicon}/hantro_g2_vp9_dec.c      |    0
 .../platform/verisilicon}/hantro_h1_jpeg_enc.c     |    0
 .../platform/verisilicon}/hantro_h1_regs.h         |    0
 .../platform/verisilicon}/hantro_h264.c            |    0
 .../platform/verisilicon}/hantro_hevc.c            |    0
 .../platform/verisilicon}/hantro_hw.h              |    0
 .../platform/verisilicon}/hantro_jpeg.c            |    0
 .../platform/verisilicon}/hantro_jpeg.h            |    0
 .../platform/verisilicon}/hantro_mpeg2.c           |    0
 .../platform/verisilicon}/hantro_postproc.c        |    0
 .../platform/verisilicon}/hantro_v4l2.c            |    0
 .../platform/verisilicon}/hantro_v4l2.h            |    0
 .../platform/verisilicon}/hantro_vp8.c             |    0
 .../platform/verisilicon}/hantro_vp9.c             |    0
 .../platform/verisilicon}/hantro_vp9.h             |    0
 .../platform/verisilicon}/imx8m_vpu_hw.c           |    0
 .../verisilicon}/rockchip_vpu2_hw_h264_dec.c       |    0
 .../verisilicon}/rockchip_vpu2_hw_jpeg_enc.c       |    0
 .../verisilicon}/rockchip_vpu2_hw_mpeg2_dec.c      |    0
 .../verisilicon}/rockchip_vpu2_hw_vp8_dec.c        |    0
 .../platform/verisilicon}/rockchip_vpu2_regs.h     |    0
 .../platform/verisilicon}/rockchip_vpu_hw.c        |    0
 .../platform/verisilicon}/sama5d4_vdec_hw.c        |    0
 .../platform/verisilicon}/sunxi_vpu_hw.c           |    0
 drivers/media/platform/xilinx/xilinx-csi2rxss.c    |    1 +
 drivers/media/platform/xilinx/xilinx-vip.c         |    2 +
 drivers/media/platform/xilinx/xilinx-vipp.c        |    9 +-
 drivers/media/test-drivers/vim2m.c                 |    2 +-
 drivers/media/test-drivers/vivid/vivid-core.h      |    5 +-
 drivers/media/test-drivers/vivid/vivid-ctrls.c     |   14 +
 drivers/media/test-drivers/vivid/vivid-vid-cap.c   |    4 +
 drivers/media/usb/Kconfig                          |    3 -
 drivers/media/usb/Makefile                         |    3 -
 drivers/media/usb/airspy/airspy.c                  |    6 +-
 drivers/media/usb/au0828/au0828-video.c            |    4 +-
 drivers/media/usb/cx231xx/cx231xx-vbi.c            |    2 +-
 drivers/media/usb/cx231xx/cx231xx-video.c          |    2 +-
 drivers/media/usb/dvb-usb/technisat-usb2.c         |    2 +-
 drivers/media/usb/em28xx/em28xx-video.c            |    4 +-
 drivers/media/usb/gspca/finepix.c                  |    2 +-
 drivers/media/usb/msi2500/msi2500.c                |    2 +-
 drivers/media/usb/pvrusb2/pvrusb2-dvb.c            |    2 +-
 drivers/media/usb/uvc/uvc_ctrl.c                   |  117 +-
 drivers/media/usb/uvc/uvc_driver.c                 |   17 +-
 drivers/media/usb/uvc/uvc_video.c                  |    2 +-
 drivers/media/v4l2-core/v4l2-ctrls-api.c           |   62 +-
 drivers/media/v4l2-core/v4l2-ctrls-core.c          |  218 ++-
 drivers/media/v4l2-core/v4l2-flash-led-class.c     |    2 +-
 drivers/media/v4l2-core/v4l2-ioctl.c               |    2 +-
 drivers/media/v4l2-core/v4l2-mem2mem.c             |    6 +-
 drivers/staging/media/Kconfig                      |   29 +-
 drivers/staging/media/Makefile                     |   12 +-
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
 drivers/staging/media/imx/imx7-media-csi.c         |    2 +-
 drivers/staging/media/meson/vdec/vdec_hevc.c       |    6 +-
 drivers/staging/media/omap4iss/iss_video.c         |    2 +-
 drivers/staging/media/sunxi/cedrus/cedrus.c        |    4 +-
 drivers/staging/media/sunxi/cedrus/cedrus.h        |   24 +-
 drivers/staging/media/sunxi/cedrus/cedrus_dec.c    |    4 +-
 drivers/staging/media/sunxi/cedrus/cedrus_h264.c   |   16 +-
 drivers/staging/media/sunxi/cedrus/cedrus_h265.c   |   23 +-
 drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c  |   28 +-
 drivers/staging/media/sunxi/cedrus/cedrus_vp8.c    |   43 +-
 drivers/staging/media/zoran/TODO                   |   19 -
 drivers/staging/media/zoran/zoran_device.h         |   60 -
 include/media/davinci/vpbe_display.h               |    6 +-
 include/media/v4l2-ctrls.h                         |  140 +-
 include/media/v4l2-mem2mem.h                       |   12 +-
 include/media/videobuf2-core.h                     |   16 +-
 include/media/videobuf2-dvb.h                      |    2 +-
 include/media/videobuf2-v4l2.h                     |   16 -
 include/uapi/linux/dw100.h                         |   14 +
 include/uapi/linux/v4l2-controls.h                 |    8 +-
 include/uapi/linux/videodev2.h                     |    7 +-
 380 files changed, 9472 insertions(+), 1471 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-r=
dma.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-r=
sz.yaml
 create mode 100644 Documentation/devicetree/bindings/media/mediatek,mdp3-w=
rot.yaml
 create mode 100644 Documentation/devicetree/bindings/media/nxp,dw100.yaml
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
ro_drv.c (100%)
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
ro_g2_hevc_dec.c (100%)
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
ro_hevc.c (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/hant=
ro_hw.h (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/hant=
ro_jpeg.c (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/hant=
ro_jpeg.h (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/hant=
ro_mpeg2.c (100%)
 rename drivers/{staging/media/hantro =3D> media/platform/verisilicon}/hant=
ro_postproc.c (100%)
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
m_vpu_hw.c (100%)
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

