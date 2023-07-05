Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38C9747D80
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjGEGwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjGEGwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:52:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432051990;
        Tue,  4 Jul 2023 23:51:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5F7961229;
        Wed,  5 Jul 2023 06:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F4AC433C7;
        Wed,  5 Jul 2023 06:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688539850;
        bh=apUvxDZrfUb/XBPRwyylAlm9OZidR5x0Hc2+TdWC4WA=;
        h=Date:From:To:Cc:Subject:From;
        b=rn7zHi0MMtWXwIsAPSde+3ketX1nvHyGZwkaCuXKHQWlCLAx2bfGbFvmZ2Xp2ys+O
         l8dO+Jo53Xo7YZBom/GUIJi+md4BnbWNaWi4cbBB9yNYDrdKFCT/tPGNA/LIabT1Lx
         lpO4NHU1TTMu19td8G3HF9iXH/6oIQz+ko/4npUApfDxeyahhsZENMT12fDYmXTbn1
         x/B92dIRGbmVIx4J/SkpkBT1rWZzbFm+uxJiSDJIVXHQsWgg53J8ZKBQR9hHw/hk5Z
         da1nLlg2GndSEZLeho95aGCYwljzRnpNFpqu/a1aTv9FXbHaa3xioI3o1z/vZuTUsb
         ocDb6W2nOFbOQ==
Date:   Wed, 5 Jul 2023 08:50:45 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v6.5-rc1] media updates
Message-ID: <20230705085045.1feaaacc@coco.lan>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
dia/v6.5-1

For:

- Lots of improvement at atomisp driver, which is starting to look into
  a good shape;
- Mediatek vcodec driver has gained support for av1 and hevc stateless code=
cs;
- New sensor driver: ov01a10;
- verisilicon driver has gained AV1 entropy helpers;
- tegra-video has gained support for Tegra20 parallel input;
- dvb core has gained an extra property to better support DVB-S2X;
- as usual, lots of cleanups, fixes and improvements on media drivers.

Regards,
Mauro

---

Note: we did lots of efforts to prioritize fixes and address reports from
CI, to reduce possible issues specially during the merge window. The=20
media-stage tree, where our development happens, is now tested by=20
Intel 0-day robot (lkp), which checked the changeset we're requesting
to pull:

	https://lore.kernel.org/linux-media/202306302306.IWDYTf49-lkp@intel.com/

And we're improving our process to speed up handling fix patches, in
special build time fixes, and to have a broader CI coverage (both on
our Jenkins instance and with other ones, like Kernel CI).

The following changes since commit 9561de3a55bed6bdd44a12820ba81ec416e705a7:

  Linux 6.4-rc5 (2023-06-04 14:04:27 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/me=
dia/v6.5-1

for you to fetch changes up to c61480a2ea5e5b997d10dfda556d3a63e31f87cd:

  media: wl128x: fix a clang warning (2023-06-29 09:56:13 +0200)

----------------------------------------------------------------
media updates for v6.5-rc1

----------------------------------------------------------------
Alain Volmat (1):
      media: sti: c8sectpfe: drop of_match_ptr() to avoid unused variables

Alexander Stein (5):
      media: staging: media: imx6-mipi-csi2: Add log_status core callback
      media: video-mux: Add missing media_entity_cleanup upon async registe=
r fail
      media: imx: imx7-media-csi: Get rid of superfluous call to imx7_csi_m=
bus_fmt_to_pix_fmt
      media: imx: imx7-media-csi: Remove incorrect interlacing support
      media: imx: imx7-media-csi: Relax width constraints for non-8bpp form=
ats

Andrey Konovalov (1):
      media: camss: set VFE bpl_alignment to 16 for sdm845 and sm8250

Angel Alberto Carretero (1):
      media: imx: utils: Enclose IMX_BUS_FMTS macro in parenthesis

Arnd Bergmann (1):
      media: tc358746: select CONFIG_GENERIC_PHY

Artur Weber (1):
      media: Revert "media: exynos4-is: Remove dependency on obsolete SoC s=
upport"

Athanasios Oikonomou (2):
      media: dvb: add missing DVB-S2X FEC parameter values
      media: dvb: bump DVB API version

Atin Bainada (1):
      media: av7110: Remove unnecessary (void*) conversions

Benjamin Gaignard (14):
      media: verisilicon: Simplify error handling in tile_buffer_reallocate=
()
      media: uapi: HEVC: Add num_delta_pocs_of_ref_rps_idx field
      media: dt-bindings: media: rockchip-vpu: Add rk3588 vpu compatible
      media: AV1: Make sure that bit depth in correctly initialize
      media: Add NV15_4L4 pixel format
      media: verisilicon: Get bit depth for V4L2_PIX_FMT_NV15_4L4
      media: verisilicon: Add AV1 decoder mode and controls
      media: verisilicon: Check AV1 bitstreams bit depth
      media: verisilicon: Compute motion vectors size for AV1 frames
      media: verisilicon: Add AV1 entropy helpers
      media: verisilicon: Add Rockchip AV1 decoder
      media: verisilicon: Add film grain feature to AV1 driver
      media: verisilicon: Enable AV1 decoder on rk3588
      media: verisilicon: Conditionally ignore native formats

Bingbu Cao (1):
      media: i2c: add ov01a10 image sensor driver

Bryan O'Donoghue (1):
      media: MAINTAINERS: Add myself as Venus reviewer

Christophe JAILLET (2):
      media: common: saa7146: Avoid a leak in vmalloc_to_sg()
      media: ov5693: Simplify an error message

Dan Carpenter (2):
      media: i2c: imx296: fix error checking in imx296_read_temperature()
      media: atomisp: gmin_platform: fix out_len in gmin_get_config_dsm_var=
()

Daniel Almeida (1):
      media: Add AV1 uAPI

Daniel Lundberg Pedersen (2):
      media: videodev2.h: Fix p_s32 and p_s64 pointer types
      media: docs: vidioc-g-ext-ctrls.rst: Update p_s32 and p_s64 types

Daniel Scally (2):
      media: i2c: Correct format propagation for st-mipid02
      media: st-mipid02: Propagate format from sink to source pad

Daniil Dulov (1):
      media: usb: Check az6007_read() return value

Deepak R Varma (1):
      media: platform: mtk-mdp3: release node reference before returning

Dikshita Agarwal (8):
      media: venus: add firmware version based check
      media: venus: enable sufficient sequence change support for vp9
      media: venus: fix EOS handling in decoder stop command
      media: venus: replace arrary index with enum for supported formats
      media: venus: add support for V4L2_PIX_FMT_P010 color format
      media: venus: update calculation for dpb buffers
      media: venus: add handling of bit depth change from firmware
      media: venus: return P010 as preferred format for 10 bit decode

Dmitry Perchanov (2):
      media: uapi: v4l: Intel metadata format update
      media: uvcvideo: Enable Intel RealSense metadata for devices

Dmitry Torokhov (1):
      media: c8sectpfe: switch to using gpiod API

Duoming Zhou (1):
      media: usb: siano: Fix warning due to null work_func_t function point=
er

Fei Shao (1):
      media: mediatek: vcodec: mtk_vcodec_dec_hw: Use devm_pm_runtime_enabl=
e()

Geert Uytterhoeven (2):
      media: Add common header file with JPEG marker definitions
      media: renesas: fdp1: Identify R-Car Gen2 versions

Guoniu.zhou (1):
      media: ov5640: correct comments for default VGA to avoid confusion

Gustavo A. R. Silva (5):
      media: pci: cx18-av-vbi: Replace one-element array with flexible-arra=
y member
      media: venus: hfi_cmds: Replace fake flex-array with flexible-array m=
ember
      media: venus: Replace one-element arrays with flexible-array members
      media: venus: hfi_cmds: Replace one-element array with flexible-array=
 member
      media: venus: hfi_cmds: Use struct_size() helper

Hans Verkuil (9):
      media: staging: media: imx: initialize hs_settle to avoid warning
      media: atomisp: initialize settings to 0
      media: atomisp: move up sanity checks
      media: rockchip: rga: fix clock cleanup
      media: usb: as102: drop as102_dev NULL check
      media: platform: renesas-ceu: drop buf NULL check
      media: platform: mediatek: vpu: fix NULL ptr dereference
      media: mediatek: vpu: add missing clk_unprepare
      media: pci: tw686x: no need to check 'next'

Hans de Goede (78):
      media: atomisp: Remove res_overflow parameter from atomisp_try_fmt()
      media: atomisp: Remove Continuous capture and SDV run-modes
      media: atomisp: Remove isp->need_gfx_throttle field
      media: atomisp: Drop atomisp_get_css_buf_type()
      media: atomisp: Replace source-pad checks with run-mode checks
      media: atomisp: Register only 1 /dev/video# node
      media: atomisp: Drop atomisp_is_vf_pipe()
      media: atomisp: Rename video_out_preview to video_out
      media: atomisp: Remove source_pad parameter from functions and structs
      media: atomisp: Remove 1 line atomisp_flush_bufs_and_wakeup() helper
      media: atomisp: Remove atomisp_subdev_register_video_nodes() helper
      media: atomisp: Remove a bunch of unused atomisp_css_*() functions
      media: atomisp: Remove unused mipi_frame_size field from atomisp_[sub=
_]device
      media: atomisp: Remove isp_timeout flag
      media: atomisp: Remove atomisp_sensor_start_stream()
      media: atomisp: Simplify atomisp_[start|stop]_streaming()
      media: atomisp: Simplify atomisp_css_[start|stop]()
      media: atomisp: Simplify atomisp_open() and atomisp_release()
      media: atomisp: Simplify atomisp_pipe_check()
      media: atomisp: Turn asd->streaming state tracker into a bool
      media: atomisp: Remove no longer used atomisp_css_flush()
      media: atomisp: Remove atomisp_streaming_count()
      media: atomisp: Simplify atomisp_isr() and recovery_work()
      media: atomisp: Rename atomisp_destroy_pipes_stream_force() to atomis=
p_destroy_pipes_stream()
      media: atomisp: Allow system suspend to continue with open /dev/video=
# nodes
      media: atomisp: Remove atomisp_[sub]dev_users()
      media: atomisp: Remove unused css_pipe_id argument from atomisp_css_[=
start|stop]()
      media: atomisp: Remove unused atomisp_get_css_pipe_id() function
      media: atomisp: Remove in_reset argument from atomisp_css_start()
      media: atomisp: Set asd.subdev.devnode once from isp_subdev_init_enti=
ties()
      media: atomisp: gc0310: Drop XXGC0310 ACPI hardware-id
      media: atomisp: gc0310: Fix double free in gc0310_remove()
      media: atomisp: gc0310: Cleanup includes
      media: atomisp: gc0310: Remove gc0310_s_config() function
      media: atomisp: gc0310: Remove gc0310.h
      media: atomisp: Drop MRFLD_PORT_NUM define
      media: atomisp: Remove unused fields from struct atomisp_input_subdev
      media: atomisp: Remove atomisp_video_init() parametrization
      media: atomisp: Rename __get_mipi_port() to atomisp_port_to_mipi_port=
()
      media: atomisp: Store number of sensor lanes per port in struct atomi=
sp_device
      media: atomisp: Delay mapping sensors to inputs till atomisp_register=
_device_nodes()
      media: atomisp: Move pad linking to atomisp_register_device_nodes()
      media: atomisp: Allow camera_mipi_info to be NULL
      media: atomisp: Add support for v4l2-async sensor registration
      media: atomisp: ov2680: Turn into standard v4l2 sensor driver
      media: atomisp: gc0310: Turn into standard v4l2 sensor driver
      media: atomisp: Drop v4l2_get_acpi_sensor_info() function
      media: atomisp: Fix buffer overrun in gmin_get_var_int()
      media: atomisp: Update TODO
      media: atomisp: ov2680: s/ov2680_device/ov2680_dev/
      media: atomisp: ov2680: s/input_lock/lock/
      media: atomisp: ov2680: Add missing ov2680_calc_mode() call to probe()
      media: atomisp: ov2680: Add init_cfg pad-op
      media: atomisp: ov2680: Implement selection support
      media: atomisp: Remove a bunch of sensor related custom IOCTLs
      media: atomisp: Remove redundant atomisp_subdev_set_selection() calls=
 from atomisp_set_fmt()
      media: atomisp: Simplify atomisp_subdev_set_selection() calls in atom=
isp_set_fmt()
      media: atomisp: Add target validation to atomisp_subdev_set_selection=
()
      media: atomisp: Remove bogus fh use from atomisp_set_fmt*()
      media: atomisp: Add input helper variable for isp->asd->inputs[asd->i=
nput_curr]
      media: atomisp: Add ia_css_frame_pad_width() helper function
      media: atomisp: Refactor atomisp_try_fmt() / atomisp_set_fmt()
      media: atomisp: Add support for sensors which implement selection API=
 / cropping
      media: atomisp: Pass MEDIA_BUS_FMT_* code when calling enum_frame_siz=
e pad-op
      media: atomisp: Make atomisp_init_sensor() check if the sensor suppor=
ts binning
      media: atomisp: Use selection API info to determine sensor padding
      media: atomisp: Set crop before setting fmt
      media: atomisp: Add enum_framesizes function for sensors with selecti=
on / crop support
      media: atomisp: csi2-bridge: Set PMC clk-rate for sensors to 19.2 MHz
      media: atomisp: Take minimum padding requirement on BYT/ISP2400 into =
account
      media: atomisp: Make atomisp_enum_framesizes_crop() check resolution =
fits with padding
      media: atomisp: Fix binning check in atomisp_set_crop()
      media: atomisp: Stop resetting selected input to 0 between /dev/video=
# opens
      media: atomisp: ov2680: Stop using half pixelclock for binned modes
      media: atomisp: ov2680: Remove unnecessary registers from ov2680_glob=
al_setting[]
      media: atomisp: ov2680: Rename unknown/0x370a to sensor_ctrl_0a
      media: atomisp: Add testing instructions to TODO file
      media: atomisp: csi2-bridge: Add support for setting "clock-" and "li=
nk-frequencies" props

Jack Zhu (1):
      media: admin-guide: Update rkisp1.rst

Jacopo Mondi (2):
      media: ov5640: Remove unused 'framerate' parameter
      media: ov5640: Drop dead code using frame_interval

Jiapeng Chong (1):
      media: nxp: remove unneeded semicolon

Kate Hsuan (5):
      media: atomisp: sh_css: Remove #ifdef ISP2401
      media: atomisp: runtime: frame: remove #ifdef ISP2401
      media: atomisp: sh_css_sp: Remove #ifdef ISP2401
      media: atomisp: sh_css_firmware: determine firmware version at runtime
      media: atomisp: sh_css_mipi: Remove #ifdef ISP2401

Krzysztof Kozlowski (2):
      media: dt-bindings: qcom: camss: correct unit address
      media: i2c: video: constify pointers to hwmon_channel_info

Lad Prabhakar (1):
      media: platform: rzg2l-cru: rzg2l-csi2: Enclose the macro in parenthe=
ses

Laurent Pinchart (8):
      media: imx: imx7-media-csi: Init default format with __imx7_csi_video=
_try_fmt()
      media: uvcvideo: Rename uvc_streaming 'format' field to 'formats'
      media: uvcvideo: Rename uvc_format 'frame' field to 'frames'
      media: uvcvideo: Use clamp() to replace manual implementation
      media: uvcvideo: Reorganize format descriptor parsing
      media: uvcvideo: Increment intervals pointer at end of parsing
      media: uvcvideo: Constify formats, frames and intervals
      media: uvcvideo: Constify descriptor buffers

Liu Shixin (1):
      media: venus: simplify the return expression of venus_sys_set_* funct=
ion

Luca Ceresoli (20):
      dt-bindings: display: tegra: add Tegra20 VIP
      dt-bindings: display: tegra: vi: add 'vip' property and example
      staging: media: tegra-video: improve documentation of tegra_video_for=
mat fields
      staging: media: tegra-video: document tegra_channel_get_remote_source=
_subdev
      staging: media: tegra-video: fix typos in comment
      staging: media: tegra-video: improve error messages
      staging: media: tegra-video: slightly simplify cleanup on errors
      staging: media: tegra-video: move private struct declaration to C file
      staging: media: tegra-video: move tegra210_csi_soc to C file
      staging: media: tegra-video: remove unneeded include
      staging: media: tegra-video: Kconfig: allow TPG only on Tegra210
      staging: media: tegra-video: move tegra_channel_fmt_align to a per-so=
c op
      staging: media: tegra-video: move default format to soc-specific data
      staging: media: tegra-video: move MIPI calibration calls from VI to C=
SI
      staging: media: tegra-video: add a per-soc enable/disable op
      staging: media: tegra-video: move syncpt init/free to a per-soc op
      staging: media: tegra-video: add syncpts for Tegra20 to struct tegra_=
vi
      staging: media: tegra-video: add hooks for planar YUV and H/V flip
      staging: media: tegra-video: add H/V flip controls
      staging: media: tegra-video: add support for Tegra20 parallel input

Lukas Bulwahn (1):
      media: stk1160: Simplify the build config definition

Marek Vasut (1):
      media: videodev2.h: Fix struct v4l2_input tuner index comment

Martin Kepplinger (1):
      media: hi846: fix usage of pm_runtime_get_if_in_use()

Mauro Carvalho Chehab (8):
      media: dvbdev: fix most coding style issues
      media: dvbdev.h: do some kernel-doc cleanups
      media: dw2102: return -EIO instead of -1 for mac address read errors
      Merge tag 'v6.4-rc2' into media_stage
      docs: uapi: media: ignore new DVB-S2X FEC values
      Merge tag 'v6.4-rc5' into media_stage
      media: dvb: mb86a20s: get rid of a clang-15 warning
      media: wl128x: fix a clang warning

Max Staudt (1):
      media: vivid: Extend FPS rates offered by simulated webcam

Michael Tretter (1):
      media: rockchip: rga: use v4l2_m2m_buf_copy_metadata

Ming Qian (3):
      media: amphion: drop repeated codec data for vc1l format
      media: amphion: drop repeated codec data for vc1g format
      media: amphion: initiate a drain of the capture queue in dynamic reso=
lution change

Nicolas Dufresne (1):
      media: v4l2-common: Add support for fractional bpp

Niklas Schnelle (1):
      media: add HAS_IOPORT dependencies

Niklas S=C3=B6derlund (6):
      dt-bindings: i2c: maxim,max96712: Require setting bus-type property
      media: rcar-csi2: Prepare for Gen4 support
      media: rcar-csi2: Prepare for C-PHY support
      media: staging: max96712: Add support for 3-lane C-PHY
      media: rcar-isp: Add support for R-Car V4H
      media: rcar-vin: Add support for R-Car V4H

N=C3=ADcolas F. R. A. Prado (1):
      Revert "media: mediatek: vcodec: Fix bitstream crop information error"

Philipp Zabel (2):
      media: video-mux: fix error paths
      media: video-mux: update driver to active state

Qinglang Miao (1):
      media: venus: simplify the return expression of session_process_buf()

Randy Dunlap (2):
      media: mtk-jpeg: move data/code inside CONFIG_OF blocks
      media: cec: i2c: ch7322: also select REGMAP

Rikard Falkeborn (1):
      media: venus: helpers: Fix ALIGN() of non power of two

Sakari Ailus (9):
      Documentation: v4l: Document rotation and orientation for sensor driv=
ers
      media: mc: Make media_entity_get_fwnode_pad() fwnode argument const
      media: pci: ipu3-cio2: Obtain remote pad from endpoint
      media: mc: Make media_get_pad_index() use pad type flag
      media: Documentation: Rename meta format files
      media: uapi: Use unsigned int values for assigning bits in u32 fields
      media: uapi: Fix [GS]_ROUTING ACTIVE flag value
      media: ipu3-cio2: Fix container_of() macro wrapper arguments
      Revert "media: uvcvideo: Limit power line control for Acer EasyCamera"

Sergey Senozhatsky (1):
      media: venus: provide ctx queue lock for ioctl synchronization

Shravan Chippa (1):
      media: i2c: imx334: update pixel, hblank and link frequency

Su Hui (3):
      media: usb: remove unnecessary (void*) conversions
      media: platform: Remove unnecessary (void*) conversions
      media: pci: remove unnecessary (void*) conversions

Uwe Kleine-K=C3=B6nig (3):
      media: Switch i2c drivers back to use .probe()
      media: staging: max96712: Switch i2c driver back to use .probe()
      media: atomisp: Switch i2c drivers back to use .probe()

Vaishnav Achath (1):
      media: v4l2-mc: Drop subdev check in v4l2_create_fwnode_links_to_pad()

Xiaoyong Lu (1):
      media: mediatek: vcodec: support stateless AV1 decoder

Yu Zhe (2):
      media: c8sectpfe: dvb: remove unnecessary (void*) conversions
      media: dvb-usb: remove unnecessary (void*) conversions

Yunfei Dong (14):
      media: v4l2-mem2mem: add lock to protect parameter num_rdy
      media: mediatek: vcodec: support stateless hevc decoder
      media: mediatek: vcodec: Avoid unneeded error logging
      media: mediatek: vcodec: using decoder status instead of core work co=
unt
      media: mediatek: vcodec: move core context from device to each instan=
ce
      media: mediatek: vcodec: using empty lat buffer as the last one
      media: mediatek: vcodec: Add debugfs interface to get debug informati=
on
      media: mediatek: vcodec: Add debug params to control different log le=
vel
      media: mediatek: vcodec: Add a debugfs file to get different useful i=
nformation
      media: mediatek: vcodec: Get each context resolution information
      media: mediatek: vcodec: Get each instance format type
      media: mediatek: vcodec: Change dbgfs interface to support encode
      media: mediatek: vcodec: Add encode to support dbgfs
      media: mediatek: vcodec: Add dbgfs help function

 Documentation/admin-guide/media/rkisp1.rst         |    4 +-
 .../bindings/display/tegra/nvidia,tegra20-vi.yaml  |   59 +
 .../bindings/display/tegra/nvidia,tegra20-vip.yaml |   41 +
 .../bindings/media/i2c/maxim,max96712.yaml         |    7 +
 .../bindings/media/qcom,msm8916-camss.yaml         |    2 +-
 .../bindings/media/qcom,msm8996-camss.yaml         |    2 +-
 .../bindings/media/qcom,sdm660-camss.yaml          |    2 +-
 .../bindings/media/qcom,sdm845-camss.yaml          |    2 +-
 .../devicetree/bindings/media/rockchip-vpu.yaml    |    1 +
 Documentation/driver-api/media/camera-sensor.rst   |   22 +
 .../userspace-api/media/frontend.h.rst.exceptions  |    4 +
 Documentation/userspace-api/media/v4l/biblio.rst   |    9 +
 .../userspace-api/media/v4l/ext-ctrls-camera.rst   |    3 +
 .../media/v4l/ext-ctrls-codec-stateless.rst        | 1216 +++++-
 .../userspace-api/media/v4l/meta-formats.rst       |   14 +-
 .../v4l/{pixfmt-meta-d4xx.rst =3D> metafmt-d4xx.rst} |   55 +-
 ...-meta-intel-ipu3.rst =3D> metafmt-intel-ipu3.rst} |    0
 .../{pixfmt-meta-rkisp1.rst =3D> metafmt-rkisp1.rst} |    0
 .../v4l/{pixfmt-meta-uvc.rst =3D> metafmt-uvc.rst}   |    0
 .../{pixfmt-meta-vivid.rst =3D> metafmt-vivid.rst}   |    0
 ...xfmt-meta-vsp1-hgo.rst =3D> metafmt-vsp1-hgo.rst} |    0
 ...xfmt-meta-vsp1-hgt.rst =3D> metafmt-vsp1-hgt.rst} |    0
 .../userspace-api/media/v4l/pixfmt-compressed.rst  |   16 +
 .../userspace-api/media/v4l/pixfmt-yuv-planar.rst  |   16 +
 .../userspace-api/media/v4l/vidioc-g-ext-ctrls.rst |   20 +-
 .../userspace-api/media/v4l/vidioc-queryctrl.rst   |   24 +
 .../media/v4l/vidioc-subdev-g-routing.rst          |    2 +-
 .../userspace-api/media/videodev2.h.rst.exceptions |    4 +
 MAINTAINERS                                        |   15 +-
 drivers/media/cec/i2c/Kconfig                      |    1 +
 drivers/media/cec/i2c/ch7322.c                     |    2 +-
 drivers/media/common/saa7146/saa7146_core.c        |    6 +-
 drivers/media/dvb-core/dvbdev.c                    |  161 +-
 drivers/media/dvb-frontends/a8293.c                |    2 +-
 drivers/media/dvb-frontends/af9013.c               |    2 +-
 drivers/media/dvb-frontends/af9033.c               |    2 +-
 drivers/media/dvb-frontends/au8522_decoder.c       |    2 +-
 drivers/media/dvb-frontends/cxd2099.c              |    2 +-
 drivers/media/dvb-frontends/cxd2820r_core.c        |    2 +-
 drivers/media/dvb-frontends/dvb-pll.c              |    2 +-
 drivers/media/dvb-frontends/helene.c               |    2 +-
 drivers/media/dvb-frontends/lgdt3306a.c            |    2 +-
 drivers/media/dvb-frontends/lgdt330x.c             |    2 +-
 drivers/media/dvb-frontends/m88ds3103.c            |    2 +-
 drivers/media/dvb-frontends/mb86a20s.c             |    5 +-
 drivers/media/dvb-frontends/mn88443x.c             |    2 +-
 drivers/media/dvb-frontends/mn88472.c              |    2 +-
 drivers/media/dvb-frontends/mn88473.c              |    2 +-
 drivers/media/dvb-frontends/mxl692.c               |    2 +-
 drivers/media/dvb-frontends/rtl2830.c              |    2 +-
 drivers/media/dvb-frontends/rtl2832.c              |    2 +-
 drivers/media/dvb-frontends/si2165.c               |    2 +-
 drivers/media/dvb-frontends/si2168.c               |    2 +-
 drivers/media/dvb-frontends/sp2.c                  |    2 +-
 drivers/media/dvb-frontends/stv090x.c              |    2 +-
 drivers/media/dvb-frontends/stv6110x.c             |    2 +-
 drivers/media/dvb-frontends/tc90522.c              |    2 +-
 drivers/media/dvb-frontends/tda10071.c             |    2 +-
 drivers/media/dvb-frontends/ts2020.c               |    2 +-
 drivers/media/i2c/Kconfig                          |   14 +
 drivers/media/i2c/Makefile                         |    1 +
 drivers/media/i2c/ad5820.c                         |    2 +-
 drivers/media/i2c/adp1653.c                        |    2 +-
 drivers/media/i2c/adv7170.c                        |    2 +-
 drivers/media/i2c/adv7175.c                        |    2 +-
 drivers/media/i2c/adv7180.c                        |    2 +-
 drivers/media/i2c/adv7183.c                        |    2 +-
 drivers/media/i2c/adv7343.c                        |    2 +-
 drivers/media/i2c/adv7393.c                        |    2 +-
 drivers/media/i2c/adv748x/adv748x-core.c           |    2 +-
 drivers/media/i2c/adv7511-v4l2.c                   |    2 +-
 drivers/media/i2c/adv7604.c                        |    2 +-
 drivers/media/i2c/adv7842.c                        |    2 +-
 drivers/media/i2c/ak7375.c                         |    2 +-
 drivers/media/i2c/ak881x.c                         |    2 +-
 drivers/media/i2c/ar0521.c                         |    2 +-
 drivers/media/i2c/bt819.c                          |    2 +-
 drivers/media/i2c/bt856.c                          |    2 +-
 drivers/media/i2c/bt866.c                          |    2 +-
 drivers/media/i2c/ccs/ccs-core.c                   |    2 +-
 drivers/media/i2c/cs3308.c                         |    2 +-
 drivers/media/i2c/cs5345.c                         |    2 +-
 drivers/media/i2c/cs53l32a.c                       |    2 +-
 drivers/media/i2c/cx25840/cx25840-core.c           |    2 +-
 drivers/media/i2c/dw9714.c                         |    2 +-
 drivers/media/i2c/dw9768.c                         |    2 +-
 drivers/media/i2c/dw9807-vcm.c                     |    2 +-
 drivers/media/i2c/et8ek8/et8ek8_driver.c           |    2 +-
 drivers/media/i2c/hi556.c                          |    2 +-
 drivers/media/i2c/hi846.c                          |    5 +-
 drivers/media/i2c/hi847.c                          |    2 +-
 drivers/media/i2c/imx208.c                         |    2 +-
 drivers/media/i2c/imx214.c                         |    2 +-
 drivers/media/i2c/imx219.c                         |    2 +-
 drivers/media/i2c/imx258.c                         |    2 +-
 drivers/media/i2c/imx274.c                         |    2 +-
 drivers/media/i2c/imx290.c                         |    4 +-
 drivers/media/i2c/imx296.c                         |    6 +-
 drivers/media/i2c/imx319.c                         |    2 +-
 drivers/media/i2c/imx334.c                         |   64 +-
 drivers/media/i2c/imx335.c                         |    2 +-
 drivers/media/i2c/imx355.c                         |    2 +-
 drivers/media/i2c/imx412.c                         |    2 +-
 drivers/media/i2c/imx415.c                         |    2 +-
 drivers/media/i2c/ir-kbd-i2c.c                     |    2 +-
 drivers/media/i2c/isl7998x.c                       |    2 +-
 drivers/media/i2c/ks0127.c                         |    2 +-
 drivers/media/i2c/lm3560.c                         |    2 +-
 drivers/media/i2c/lm3646.c                         |    2 +-
 drivers/media/i2c/m52790.c                         |    2 +-
 drivers/media/i2c/max2175.c                        |    2 +-
 drivers/media/i2c/max9286.c                        |    2 +-
 drivers/media/i2c/ml86v7667.c                      |    2 +-
 drivers/media/i2c/msp3400-driver.c                 |    2 +-
 drivers/media/i2c/mt9m001.c                        |    2 +-
 drivers/media/i2c/mt9m111.c                        |    2 +-
 drivers/media/i2c/mt9p031.c                        |    2 +-
 drivers/media/i2c/mt9t112.c                        |    2 +-
 drivers/media/i2c/mt9v011.c                        |    2 +-
 drivers/media/i2c/mt9v032.c                        |    2 +-
 drivers/media/i2c/mt9v111.c                        |    2 +-
 drivers/media/i2c/og01a1b.c                        |    2 +-
 drivers/media/i2c/ov01a10.c                        | 1004 +++++
 drivers/media/i2c/ov02a10.c                        |    4 +-
 drivers/media/i2c/ov08d10.c                        |    2 +-
 drivers/media/i2c/ov08x40.c                        |    2 +-
 drivers/media/i2c/ov13858.c                        |    2 +-
 drivers/media/i2c/ov13b10.c                        |    2 +-
 drivers/media/i2c/ov2640.c                         |    2 +-
 drivers/media/i2c/ov2659.c                         |    2 +-
 drivers/media/i2c/ov2680.c                         |    2 +-
 drivers/media/i2c/ov2685.c                         |    4 +-
 drivers/media/i2c/ov2740.c                         |    2 +-
 drivers/media/i2c/ov4689.c                         |    2 +-
 drivers/media/i2c/ov5640.c                         |   21 +-
 drivers/media/i2c/ov5645.c                         |    2 +-
 drivers/media/i2c/ov5647.c                         |    2 +-
 drivers/media/i2c/ov5648.c                         |    4 +-
 drivers/media/i2c/ov5670.c                         |    2 +-
 drivers/media/i2c/ov5675.c                         |    2 +-
 drivers/media/i2c/ov5693.c                         |    6 +-
 drivers/media/i2c/ov5695.c                         |    4 +-
 drivers/media/i2c/ov6650.c                         |    2 +-
 drivers/media/i2c/ov7251.c                         |    2 +-
 drivers/media/i2c/ov7640.c                         |    2 +-
 drivers/media/i2c/ov7670.c                         |    2 +-
 drivers/media/i2c/ov772x.c                         |    2 +-
 drivers/media/i2c/ov7740.c                         |    2 +-
 drivers/media/i2c/ov8856.c                         |    2 +-
 drivers/media/i2c/ov8858.c                         |    4 +-
 drivers/media/i2c/ov8865.c                         |    4 +-
 drivers/media/i2c/ov9282.c                         |    2 +-
 drivers/media/i2c/ov9640.c                         |    2 +-
 drivers/media/i2c/ov9650.c                         |    2 +-
 drivers/media/i2c/ov9734.c                         |    2 +-
 drivers/media/i2c/rdacm20.c                        |    2 +-
 drivers/media/i2c/rdacm21.c                        |    2 +-
 drivers/media/i2c/rj54n1cb0c.c                     |    2 +-
 drivers/media/i2c/s5c73m3/s5c73m3-core.c           |    2 +-
 drivers/media/i2c/s5k5baf.c                        |    2 +-
 drivers/media/i2c/s5k6a3.c                         |    2 +-
 drivers/media/i2c/saa6588.c                        |    2 +-
 drivers/media/i2c/saa6752hs.c                      |    2 +-
 drivers/media/i2c/saa7110.c                        |    2 +-
 drivers/media/i2c/saa7115.c                        |    2 +-
 drivers/media/i2c/saa7127.c                        |    2 +-
 drivers/media/i2c/saa717x.c                        |    2 +-
 drivers/media/i2c/saa7185.c                        |    2 +-
 drivers/media/i2c/sony-btf-mpx.c                   |    2 +-
 drivers/media/i2c/st-mipid02.c                     |   17 +-
 drivers/media/i2c/st-vgxy61.c                      |    2 +-
 drivers/media/i2c/tc358743.c                       |    2 +-
 drivers/media/i2c/tc358746.c                       |    2 +-
 drivers/media/i2c/tda1997x.c                       |    2 +-
 drivers/media/i2c/tda7432.c                        |    2 +-
 drivers/media/i2c/tda9840.c                        |    2 +-
 drivers/media/i2c/tea6415c.c                       |    2 +-
 drivers/media/i2c/tea6420.c                        |    2 +-
 drivers/media/i2c/ths7303.c                        |    2 +-
 drivers/media/i2c/ths8200.c                        |    2 +-
 drivers/media/i2c/tlv320aic23b.c                   |    2 +-
 drivers/media/i2c/tvaudio.c                        |    2 +-
 drivers/media/i2c/tvp514x.c                        |    2 +-
 drivers/media/i2c/tvp5150.c                        |    2 +-
 drivers/media/i2c/tvp7002.c                        |    2 +-
 drivers/media/i2c/tw2804.c                         |    2 +-
 drivers/media/i2c/tw9903.c                         |    2 +-
 drivers/media/i2c/tw9906.c                         |    2 +-
 drivers/media/i2c/tw9910.c                         |    2 +-
 drivers/media/i2c/uda1342.c                        |    2 +-
 drivers/media/i2c/upd64031a.c                      |    2 +-
 drivers/media/i2c/upd64083.c                       |    2 +-
 drivers/media/i2c/video-i2c.c                      |    4 +-
 drivers/media/i2c/vp27smpx.c                       |    2 +-
 drivers/media/i2c/vpx3220.c                        |    2 +-
 drivers/media/i2c/wm8739.c                         |    2 +-
 drivers/media/i2c/wm8775.c                         |    2 +-
 drivers/media/mc/mc-entity.c                       |   18 +-
 drivers/media/pci/bt8xx/dst_ca.c                   |    2 +-
 drivers/media/pci/cx18/cx18-av-vbi.c               |    2 +-
 drivers/media/pci/cx18/cx18-dvb.c                  |    4 +-
 drivers/media/pci/dm1105/Kconfig                   |    2 +-
 drivers/media/pci/intel/ipu3/ipu3-cio2-main.c      |   31 +-
 drivers/media/pci/saa7164/saa7164-dvb.c            |    4 +-
 drivers/media/pci/ttpci/budget-core.c              |    4 +-
 drivers/media/pci/tw686x/tw686x-audio.c            |    2 +-
 drivers/media/platform/amphion/vdec.c              |    7 +-
 drivers/media/platform/amphion/venc.c              |    4 +-
 drivers/media/platform/amphion/vpu_malone.c        |   12 +
 drivers/media/platform/amphion/vpu_v4l2.c          |    5 +-
 drivers/media/platform/amphion/vpu_v4l2.h          |    2 +-
 .../media/platform/mediatek/jpeg/mtk_jpeg_core.c   |  858 ++--
 .../platform/mediatek/jpeg/mtk_jpeg_dec_parse.c    |   17 +-
 .../media/platform/mediatek/mdp3/mtk-mdp3-comp.c   |   15 +-
 drivers/media/platform/mediatek/vcodec/Makefile    |    8 +
 .../platform/mediatek/vcodec/mtk_vcodec_dbgfs.c    |  215 +
 .../platform/mediatek/vcodec/mtk_vcodec_dbgfs.h    |   74 +
 .../platform/mediatek/vcodec/mtk_vcodec_dec_drv.c  |    5 +-
 .../platform/mediatek/vcodec/mtk_vcodec_dec_hw.c   |   26 +-
 .../mediatek/vcodec/mtk_vcodec_dec_stateless.c     |  106 +-
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h      |    8 +-
 .../platform/mediatek/vcodec/mtk_vcodec_enc.c      |    8 +-
 .../platform/mediatek/vcodec/mtk_vcodec_enc_drv.c  |    2 +
 .../platform/mediatek/vcodec/mtk_vcodec_util.c     |    8 +
 .../platform/mediatek/vcodec/mtk_vcodec_util.h     |   26 +-
 .../mediatek/vcodec/vdec/vdec_av1_req_lat_if.c     | 2207 ++++++++++
 .../mediatek/vcodec/vdec/vdec_h264_req_multi_if.c  |    6 +-
 .../mediatek/vcodec/vdec/vdec_hevc_req_multi_if.c  | 1097 +++++
 .../mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c     |    4 +-
 .../media/platform/mediatek/vcodec/vdec_drv_if.c   |    8 +
 .../media/platform/mediatek/vcodec/vdec_drv_if.h   |    2 +
 .../platform/mediatek/vcodec/vdec_msg_queue.c      |  132 +-
 .../platform/mediatek/vcodec/vdec_msg_queue.h      |   32 +-
 drivers/media/platform/mediatek/vpu/mtk_vpu.c      |    7 +-
 drivers/media/platform/nxp/imx7-media-csi.c        |   94 +-
 .../platform/nxp/imx8-isi/imx8-isi-crossbar.c      |    2 +-
 drivers/media/platform/qcom/camss/camss-vfe.c      |    6 +-
 drivers/media/platform/qcom/venus/core.h           |   39 +
 drivers/media/platform/qcom/venus/helpers.c        |   33 +-
 drivers/media/platform/qcom/venus/hfi_cmds.c       |   19 +-
 drivers/media/platform/qcom/venus/hfi_cmds.h       |    4 +-
 drivers/media/platform/qcom/venus/hfi_helper.h     |    2 +
 drivers/media/platform/qcom/venus/hfi_msgs.c       |   34 +-
 drivers/media/platform/qcom/venus/hfi_msgs.h       |   14 +-
 drivers/media/platform/qcom/venus/hfi_plat_bufs.h  |    3 +
 .../media/platform/qcom/venus/hfi_plat_bufs_v6.c   |   11 +-
 drivers/media/platform/qcom/venus/hfi_venus.c      |   28 +-
 drivers/media/platform/qcom/venus/vdec.c           |   94 +-
 drivers/media/platform/qcom/venus/venc.c           |   35 +-
 drivers/media/platform/renesas/rcar-isp.c          |    1 +
 .../media/platform/renesas/rcar-vin/rcar-core.c    |   13 +
 .../media/platform/renesas/rcar-vin/rcar-csi2.c    |  100 +-
 drivers/media/platform/renesas/rcar_fdp1.c         |    5 +
 drivers/media/platform/renesas/rcar_jpu.c          |   55 +-
 drivers/media/platform/renesas/renesas-ceu.c       |    9 -
 .../media/platform/renesas/rzg2l-cru/rzg2l-csi2.c  |    8 +-
 drivers/media/platform/rockchip/rga/rga.c          |    9 +-
 drivers/media/platform/samsung/exynos4-is/Kconfig  |    2 +-
 .../media/platform/samsung/exynos4-is/fimc-core.c  |    2 +-
 .../media/platform/samsung/exynos4-is/fimc-lite.c  |    2 +-
 .../media/platform/samsung/s5p-jpeg/jpeg-core.h    |   12 +-
 .../platform/st/sti/c8sectpfe/c8sectpfe-core.c     |   37 +-
 .../platform/st/sti/c8sectpfe/c8sectpfe-core.h     |    4 +-
 drivers/media/platform/st/sti/hva/hva-h264.c       |    8 +-
 drivers/media/platform/verisilicon/Makefile        |    3 +
 drivers/media/platform/verisilicon/hantro.h        |    8 +
 drivers/media/platform/verisilicon/hantro_drv.c    |   68 +-
 drivers/media/platform/verisilicon/hantro_hevc.c   |   23 +-
 drivers/media/platform/verisilicon/hantro_hw.h     |  102 +
 .../media/platform/verisilicon/hantro_postproc.c   |    9 +-
 drivers/media/platform/verisilicon/hantro_v4l2.c   |   67 +-
 drivers/media/platform/verisilicon/hantro_v4l2.h   |    8 +-
 .../verisilicon/rockchip_av1_entropymode.c         | 4424 ++++++++++++++++=
++++
 .../verisilicon/rockchip_av1_entropymode.h         |  272 ++
 .../platform/verisilicon/rockchip_av1_filmgrain.c  |  401 ++
 .../platform/verisilicon/rockchip_av1_filmgrain.h  |   36 +
 .../verisilicon/rockchip_vpu981_hw_av1_dec.c       | 2232 ++++++++++
 .../platform/verisilicon/rockchip_vpu981_regs.h    |  477 +++
 .../media/platform/verisilicon/rockchip_vpu_hw.c   |  134 +
 drivers/media/platform/video-mux.c                 |  102 +-
 drivers/media/radio/Kconfig                        |   14 +-
 drivers/media/radio/radio-tea5764.c                |    2 +-
 drivers/media/radio/saa7706h.c                     |    2 +-
 drivers/media/radio/si470x/radio-si470x-i2c.c      |    2 +-
 drivers/media/radio/si4713/si4713.c                |    2 +-
 drivers/media/radio/tef6862.c                      |    2 +-
 drivers/media/radio/wl128x/fmdrv_common.c          |    6 +-
 drivers/media/rc/Kconfig                           |    6 +
 drivers/media/test-drivers/vidtv/vidtv_demod.c     |    2 +-
 drivers/media/test-drivers/vidtv/vidtv_tuner.c     |    2 +-
 drivers/media/test-drivers/vivid/vivid-vid-cap.c   |   49 +-
 drivers/media/tuners/e4000.c                       |    2 +-
 drivers/media/tuners/fc2580.c                      |    2 +-
 drivers/media/tuners/m88rs6000t.c                  |    2 +-
 drivers/media/tuners/mt2060.c                      |    2 +-
 drivers/media/tuners/mxl301rf.c                    |    2 +-
 drivers/media/tuners/qm1d1b0004.c                  |    2 +-
 drivers/media/tuners/qm1d1c0042.c                  |    2 +-
 drivers/media/tuners/si2157.c                      |    2 +-
 drivers/media/tuners/tda18212.c                    |    2 +-
 drivers/media/tuners/tda18250.c                    |    2 +-
 drivers/media/tuners/tua9001.c                     |    2 +-
 drivers/media/usb/as102/as102_usb_drv.c            |    6 +-
 drivers/media/usb/au0828/au0828-core.c             |    2 +-
 drivers/media/usb/dvb-usb-v2/az6007.c              |   19 +-
 drivers/media/usb/dvb-usb/af9005-fe.c              |    3 +-
 drivers/media/usb/dvb-usb/az6027.c                 |   34 +-
 drivers/media/usb/dvb-usb/dtt200u-fe.c             |    2 +-
 drivers/media/usb/dvb-usb/dw2102.c                 |   26 +-
 drivers/media/usb/dvb-usb/opera1.c                 |    3 +-
 drivers/media/usb/dvb-usb/pctv452e.c               |   20 +-
 drivers/media/usb/go7007/s2250-board.c             |    2 +-
 drivers/media/usb/siano/smsusb.c                   |    3 +-
 drivers/media/usb/stk1160/Kconfig                  |   12 +-
 drivers/media/usb/ttusb-dec/ttusb_dec.c            |    2 +-
 drivers/media/usb/uvc/uvc_driver.c                 |  137 +-
 drivers/media/usb/uvc/uvc_v4l2.c                   |   79 +-
 drivers/media/usb/uvc/uvc_video.c                  |   20 +-
 drivers/media/usb/uvc/uvcvideo.h                   |   12 +-
 drivers/media/v4l2-core/tuner-core.c               |    2 +-
 drivers/media/v4l2-core/v4l2-common.c              |  162 +-
 drivers/media/v4l2-core/v4l2-ctrls-core.c          |  263 ++
 drivers/media/v4l2-core/v4l2-ctrls-defs.c          |   61 +
 drivers/media/v4l2-core/v4l2-ioctl.c               |    2 +
 drivers/media/v4l2-core/v4l2-mc.c                  |   38 +-
 drivers/phy/Kconfig                                |    1 +
 drivers/staging/media/atomisp/Makefile             |    1 +
 drivers/staging/media/atomisp/TODO                 |  238 +-
 drivers/staging/media/atomisp/i2c/atomisp-gc0310.c |  313 +-
 drivers/staging/media/atomisp/i2c/atomisp-gc2235.c |    2 +-
 drivers/staging/media/atomisp/i2c/atomisp-lm3554.c |    2 +-
 .../staging/media/atomisp/i2c/atomisp-mt9m114.c    |    2 +-
 drivers/staging/media/atomisp/i2c/atomisp-ov2680.c |  252 +-
 drivers/staging/media/atomisp/i2c/atomisp-ov2722.c |    2 +-
 drivers/staging/media/atomisp/i2c/gc0310.h         |  309 --
 drivers/staging/media/atomisp/i2c/ov2680.h         |  141 +-
 .../media/atomisp/i2c/ov5693/atomisp-ov5693.c      |   42 +-
 .../staging/media/atomisp/include/linux/atomisp.h  |  127 +-
 .../media/atomisp/include/linux/atomisp_platform.h |    1 +
 drivers/staging/media/atomisp/pci/atomisp-regs.h   |    1 -
 drivers/staging/media/atomisp/pci/atomisp_cmd.c    | 1034 ++---
 drivers/staging/media/atomisp/pci/atomisp_cmd.h    |   28 +-
 drivers/staging/media/atomisp/pci/atomisp_common.h |    4 +
 drivers/staging/media/atomisp/pci/atomisp_compat.h |   41 +-
 .../media/atomisp/pci/atomisp_compat_css20.c       |  283 +-
 .../media/atomisp/pci/atomisp_compat_ioctl32.h     |   55 -
 drivers/staging/media/atomisp/pci/atomisp_csi2.c   |   10 +-
 drivers/staging/media/atomisp/pci/atomisp_csi2.h   |   94 +-
 .../media/atomisp/pci/atomisp_csi2_bridge.c        |  874 ++++
 drivers/staging/media/atomisp/pci/atomisp_drvfs.c  |    2 +-
 drivers/staging/media/atomisp/pci/atomisp_fops.c   |  183 +-
 drivers/staging/media/atomisp/pci/atomisp_fops.h   |    3 -
 .../media/atomisp/pci/atomisp_gmin_platform.c      |  248 +-
 .../staging/media/atomisp/pci/atomisp_internal.h   |   29 +-
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c  |  398 +-
 drivers/staging/media/atomisp/pci/atomisp_ioctl.h  |    5 -
 drivers/staging/media/atomisp/pci/atomisp_subdev.c |  262 +-
 drivers/staging/media/atomisp/pci/atomisp_subdev.h |   36 +-
 drivers/staging/media/atomisp/pci/atomisp_v4l2.c   |  425 +-
 drivers/staging/media/atomisp/pci/atomisp_v4l2.h   |    4 +-
 .../pci/runtime/frame/interface/ia_css_frame.h     |    2 +
 .../media/atomisp/pci/runtime/frame/src/frame.c    |   62 +-
 drivers/staging/media/atomisp/pci/sh_css.c         |  524 ++-
 .../staging/media/atomisp/pci/sh_css_firmware.c    |   33 +-
 drivers/staging/media/atomisp/pci/sh_css_mipi.c    |   56 +-
 drivers/staging/media/atomisp/pci/sh_css_sp.c      |   10 +-
 drivers/staging/media/av7110/av7110_av.c           |    4 +-
 drivers/staging/media/imx/imx-media-utils.c        |    2 +-
 drivers/staging/media/imx/imx6-mipi-csi2.c         |   45 +
 drivers/staging/media/max96712/max96712.c          |   40 +-
 drivers/staging/media/tegra-video/Kconfig          |    1 +
 drivers/staging/media/tegra-video/Makefile         |    2 +
 drivers/staging/media/tegra-video/csi.c            |   48 +
 drivers/staging/media/tegra-video/csi.h            |    4 -
 drivers/staging/media/tegra-video/tegra20.c        |  661 +++
 drivers/staging/media/tegra-video/tegra210.c       |   90 +
 drivers/staging/media/tegra-video/vi.c             |  222 +-
 drivers/staging/media/tegra-video/vi.h             |   71 +-
 drivers/staging/media/tegra-video/video.c          |    5 +
 drivers/staging/media/tegra-video/video.h          |    2 +-
 drivers/staging/media/tegra-video/vip.c            |  287 ++
 drivers/staging/media/tegra-video/vip.h            |   68 +
 include/media/dvbdev.h                             |    6 +-
 include/media/jpeg.h                               |   20 +
 include/media/media-entity.h                       |    6 +-
 include/media/v4l2-common.h                        |    2 +
 include/media/v4l2-ctrls.h                         |    8 +
 include/media/v4l2-mem2mem.h                       |   18 +-
 include/uapi/linux/dvb/frontend.h                  |    8 +
 include/uapi/linux/dvb/version.h                   |    2 +-
 include/uapi/linux/media.h                         |   28 +-
 include/uapi/linux/v4l2-controls.h                 |  727 +++-
 include/uapi/linux/videodev2.h                     |   17 +-
 393 files changed, 21498 insertions(+), 5254 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,=
tegra20-vip.yaml
 rename Documentation/userspace-api/media/v4l/{pixfmt-meta-d4xx.rst =3D> me=
tafmt-d4xx.rst} (74%)
 rename Documentation/userspace-api/media/v4l/{pixfmt-meta-intel-ipu3.rst =
=3D> metafmt-intel-ipu3.rst} (100%)
 rename Documentation/userspace-api/media/v4l/{pixfmt-meta-rkisp1.rst =3D> =
metafmt-rkisp1.rst} (100%)
 rename Documentation/userspace-api/media/v4l/{pixfmt-meta-uvc.rst =3D> met=
afmt-uvc.rst} (100%)
 rename Documentation/userspace-api/media/v4l/{pixfmt-meta-vivid.rst =3D> m=
etafmt-vivid.rst} (100%)
 rename Documentation/userspace-api/media/v4l/{pixfmt-meta-vsp1-hgo.rst =3D=
> metafmt-vsp1-hgo.rst} (100%)
 rename Documentation/userspace-api/media/v4l/{pixfmt-meta-vsp1-hgt.rst =3D=
> metafmt-vsp1-hgt.rst} (100%)
 create mode 100644 drivers/media/i2c/ov01a10.c
 create mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs=
.c
 create mode 100644 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dbgfs=
.h
 create mode 100644 drivers/media/platform/mediatek/vcodec/vdec/vdec_av1_re=
q_lat_if.c
 create mode 100644 drivers/media/platform/mediatek/vcodec/vdec/vdec_hevc_r=
eq_multi_if.c
 create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_entropy=
mode.c
 create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_entropy=
mode.h
 create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_filmgra=
in.c
 create mode 100644 drivers/media/platform/verisilicon/rockchip_av1_filmgra=
in.h
 create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu981_hw_a=
v1_dec.c
 create mode 100644 drivers/media/platform/verisilicon/rockchip_vpu981_regs=
.h
 delete mode 100644 drivers/staging/media/atomisp/i2c/gc0310.h
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_csi2_bridge.c
 create mode 100644 drivers/staging/media/tegra-video/tegra20.c
 create mode 100644 drivers/staging/media/tegra-video/vip.c
 create mode 100644 drivers/staging/media/tegra-video/vip.h
 create mode 100644 include/media/jpeg.h

