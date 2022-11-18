Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F404462F9E6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 17:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241597AbiKRQHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 11:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbiKRQHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 11:07:07 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AA271F0F;
        Fri, 18 Nov 2022 08:07:06 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id m22so14071662eji.10;
        Fri, 18 Nov 2022 08:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J0kystyM6Xmke4J1occxz1aZQPjNKmRbbhXHmAXvtTA=;
        b=SIGIrrwipYo1B++fyHaXszISvOf2AkQF/YxiKHxExI05/x3A8m6gbiRsIpNviVlLoT
         nwxA031e1VPgp3/flVsvwNB3T4fNbuzuH1TCLD9Dt+pfFM6w8DjwzwVuf+OTkYDyN0LI
         Of8d8fdDLRS5W3wIm2KM5pX0IvZEITSRR19q4PfZ7ExDmUXycYw29nSHbUuCMdDpnV0s
         4xVMl3qqEv2GgwL0coEzKXZe/L6nqFdOX+QNLgebuPST3tDG1jkcVb+wrgNGGpC3Knmw
         rLIBycaj60mFz83xXGWhIhnwae/tZjDUGJrOu0VSzqoNo8JaDZ34Lpsq+6NtrXqmj9gK
         /YGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J0kystyM6Xmke4J1occxz1aZQPjNKmRbbhXHmAXvtTA=;
        b=ZU2RiYcl5IAx7pksOsxRRJzITjC9HUBnNiIYukGHr6hOJEaAReq/mBynyxaFt/KART
         502cEuxTOceCGqpY4qlO011Svgfrv8oz8MTrRAytKMPl94Mmy+Nn1tg+QHMhqv40jgdG
         xGDrRHSicDCjvHU39+662ouu9dpjs3YXhoYq+QBcYezK8Dd8YVxa+Rd0rL0SxVlZmTtN
         cN113Wx+0mOXva5q4xqNqy1CiKtP3FXIk83hOcYX5iw4Y/T8jpIvvZz/2K9s/3SSvOlM
         YN6JiKX6ealuB9hbuBdYXYrISHcvhKhzEbOs7Bvlz1NB7Ai7utM0mLU4zUjJ5RZU+nxb
         rRKQ==
X-Gm-Message-State: ANoB5pmGqW4x6TtbIcRxrrvs6xVtPEvqI+Q6mLrmb1E8x9p5uJnvE79r
        6HfQMK/Ge2dFcEcL+4tPfeTrulQKelv97d5BqE25f51ptTSFKw==
X-Google-Smtp-Source: AA0mqf4cquvfMNCWYul+A7uGbSo7bh14oJDTs6ahhTV6jp0Pw0sJyaUU2aZcUbdOywwa2Zxo8/Jkj17BpuMhy3RQppc=
X-Received: by 2002:a17:906:79c4:b0:778:e3e2:8311 with SMTP id
 m4-20020a17090679c400b00778e3e28311mr6784211ejo.342.1668787624748; Fri, 18
 Nov 2022 08:07:04 -0800 (PST)
MIME-Version: 1.0
References: <20221102004329.5410-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221102004329.5410-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 18 Nov 2022 16:06:38 +0000
Message-ID: <CA+V-a8sd3KoSjOXvNUOqTPoWOjA5bxXqcEZr+D5WK6K0O6R7QA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Add driver for CSI2 and CRU modules found on
 Renesas RZ/G2L SoC
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URI_HEX autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Wed, Nov 2, 2022 at 12:43 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
>
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Hi All,
>
> This patch series aims to add driver support to CRU module found
> on Renesas RZ/G2L SoC.
>
> The Camera Data Receiving Unit (CRU) consists of a MIPI CSI-2
> block and an Image Processing block. The Image Processing block
> can receive video data received from the external Digital Parallel
> Interface or MIPI CSI-2 block, and perform appropriate image
> processing for each.
>
> More details:
> * https://renesas.info/wiki/File:CRU.png
> * https://www.renesas.com/document/mah/rzg2l-group-rzg2lc-group-users-manual-hardware-0?language=en&r=1467981
>
> Currently the driver has been tested using yavta and Gstreamer
> on RZ/G2L SMARC EVK using the ov5645 sensor on CSI2 interface
> only.
>
> root@smarc-rzg2l:~# media-ctl -p
> Media controller API version 6.0.0
>
> Media device information
> ------------------------
> driver          rzg2l_cru
> model           renesas,rzg2l-cru
> serial
> bus info        platform:10830000.video
> hw revision     0x0
> driver version  6.0.0
>
> Device topology
> - entity 1: csi-10830400.csi2 (2 pads, 2 links)
>             type V4L2 subdev subtype Unknown flags 0
>             device node name /dev/v4l-subdev0
>         pad0: Sink
>                 [fmt:UYVY8_1X16/320x240 field:none colorspace:srgb]
>                 <- "ov5645 0-003c":0 [ENABLED,IMMUTABLE]
>         pad1: Source
>                 [fmt:UYVY8_1X16/320x240 field:none colorspace:srgb]
>                 -> "cru-ip-10830000.video":0 []
>
> - entity 4: ov5645 0-003c (1 pad, 1 link)
>             type V4L2 subdev subtype Sensor flags 0
>             device node name /dev/v4l-subdev1
>         pad0: Source
>                 [fmt:unknown/0x0
>                  crop:(0,0)/1920x1080]
>                 -> "csi-10830400.csi2":0 [ENABLED,IMMUTABLE]
>
> - entity 8: cru-ip-10830000.video (2 pads, 2 links)
>             type V4L2 subdev subtype Unknown flags 0
>             device node name /dev/v4l-subdev2
>         pad0: Sink
>                 [fmt:UYVY8_1X16/320x240 field:none colorspace:srgb]
>                 <- "csi-10830400.csi2":1 []
>         pad1: Source
>                 [fmt:UYVY8_1X16/320x240 field:none colorspace:srgb]
>                 -> "CRU output":0 []
>
> - entity 17: CRU output (1 pad, 1 link)
>              type Node subtype V4L flags 0
>              device node name /dev/video0
>         pad0: Sink
>                 <- "cru-ip-10830000.video":1 []
>
> root@smarc-rzg2l:~# v4l2-compliance -s
> v4l2-compliance 1.22.1-4864, 64 bits, 64-bit time_t
> v4l2-compliance SHA: 47c8c377cf29 2021-10-23 15:12:35
>
> Compliance test for rzg2l_cru device /dev/video0:
>
> Driver Info:
>         Driver name      : rzg2l_cru
>         Card type      [  116.765448] rzg2l-cru 10830000.video: =================  START STATUS  =================
>   : RZG2L_CRU
>         [  116.775369] rzg2l-cru 10830000.video: ==================  END STATUS  ==================
> Bus info         : platform:10830000.video
>         Driver version   : 6.0.0
>         Capabilities     : 0xa4200001
>                 Video Capture
>                 Streaming
>                 Extended Pix Format
>                 Device Capabilities
>         Device Caps      : 0x24200001
>                 Video Capture
>                 Streaming
>                 Extended Pix Format
> Media Driver Info:
>         Driver name      : rzg2l_cru
>         Model            : renesas,rzg2l-cru
>         Serial           :
>         Bus info         : platform:10830000.video
>         Media version    : 6.0.0
>         Hardware revision: 0x00000000 (0)
>         Driver version   : 6.0.0
> Interface Info:
>         ID               : 0x03000013
>         Type             : V4L Video
> Entity Info:
>         ID               : 0x00000011 (17)
>         Name             : CRU output
>         Function         : V4L2 I/O
>         Pad 0x01000012   : 0: Sink
>           Link 0x02000017: from remote pad 0x100000a of entity 'cru-ip-10830000.video' (Video Pixel Formatter): Data, Enabled
>
> Required ioctls:
>         test MC information (see 'Media Driver Info' above): OK
>         test VIDIOC_QUERYCAP: OK
>         test invalid ioctls: OK
>
> Allow for multiple opens:
>         test second /dev/video0 open: OK
>         test VIDIOC_QUERYCAP: OK
>         test VIDIOC_G/S_PRIORITY: OK
>         test for unlimited opens: OK
>
> Debug ioctls:
>         test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
>         test VIDIOC_LOG_STATUS: OK
>
> Input ioctls:
>         test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
>         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>         test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
>         test VIDIOC_ENUMAUDIO: OK (Not Supported)
>         test VIDIOC_G/S/ENUMINPUT: OK
>         test VIDIOC_G/S_AUDIO: OK (Not Supported)
>         Inputs: 1 Audio Inputs: 0 Tuners: 0
>
> Output ioctls:
>         test VIDIOC_G/S_MODULATOR: OK (Not Supported)
>         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>         test VIDIOC_ENUMAUDOUT: OK (Not Supported)
>         test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
>         test VIDIOC_G/S_AUDOUT: OK (Not Supported)
>         Outputs: 0 Audio Outputs: 0 Modulators: 0
>
> Input/Output configuration ioctls:
>         test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
>         test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
>         test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
>         test VIDIOC_G/S_EDID: OK (Not Supported)
>
> Control ioctls (Input 0):
>         test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK (Not Supported)
>         test VIDIOC_QUERYCTRL: OK (Not Supported)
>         test VIDIOC_G/S_CTRL: OK (Not Supported)
>         test VIDIOC_G/S/TRY_EXT_CTRLS: OK (Not Supported)
>         test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK (Not Supported)
>         test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
>         Standard Controls: 0 Private Controls: 0
>
> Format ioctls (Input 0):
>         test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
>         test VIDIOC_G/S_PARM: OK (Not Supported)
>         test VIDIOC_G_FBUF: OK (Not Supported)
>         test VIDIOC_G_FMT: OK
>         test VIDIOC_TRY_FMT: OK
>         test VIDIOC_S_FMT: OK
>         test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
>         test Cropping: OK (Not Supported)
>         test Composing: OK (Not Supported)
>         test Scaling: OK
>
> Codec ioctls (Input 0):
>         test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
>         test VIDIOC_G_ENC_INDEX: OK (Not Supported)
>         test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
>
> Buffer ioctls (Input 0):
>         test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
>         test VIDIOC_EXPBUF: OK
>         test Requests: OK (Not Supported)
>
> Test input 0:
>
> Streaming ioctls:
>         test read/write: OK (Not Supported)
>         test blocking wait: OK
>         test MMAP (no poll): OK
>         test MMAP (select): OK
>         test MMAP (epoll): OK
>         test USERPTR (no poll): OK (Not Supported)
>         test USERPTR (select): OK (Not Supported)
>         test DMABUF: Cannot test, specify --expbuf-device
>
> Total for rzg2l_cru device /dev/video0: 53, Succeeded: 53, Failed: 0, Warnings: 0
> root@smarc-rzg2l:~#
>
> v4 -> v5
> * Fixed review comments pointed by Sakari
>
> v3 -> v4
> * Included RB tag from Rob for binding patch
> * Implemented post_streamoff callback in CSI driver
> * Undo the configuration if s_stream(1) fails
> * Made sure we call post_streamoff in the error path if s_stream(1) failed
>
> v2 -> v3:
> * Updated clock names in DT binding doc
> * Included presetn reset signal and added reset-names in CSI binding
> * Renamed csi20 -> csi in DT binding doc
> * Included RB tag from Krzysztof for patch#1
> * Switched to runtime PM for both CSI and CRU drivers
> * Implemented pre_streamon callback in CSI driver
> * Got rid of rzg2l_csi2_cmn_rstb_deassert()/
>   rzg2l_csi2_dphy_setting/rzg2l_csi2_mipi_link_setting() from CSI driver
> * Switched to for-loop instead of if block for getting CSI timings
> * Fixed rzg2l_csi2_set_format() as pointed by Laurent
> * Copied all colorspace-related fields received from userspace (colorspace,
>   xfer_func, ycbcr_enc and quantization) in rzg2l_csi2_set_format.
> * Initialised pad in rzg2l_csi2_init_config()
> * Introduced RZG2L_CSI2_DEFAULT_WIDTH/HEIGHT/FMT macros
> * Dropped RZG2L_CSI2_SOURCE_VC0-RZG2L_CSI2_SOURCE_VC3 macros
> * Modeled CRU IP block as a subdev
> * Dropped explicitly selecting VIDEO_RZG2L_CSI2 for VIDEO_RZG2L_CRU config
> * Replaced v4l2_dev_to_cru macro with inline function notifier_to_cru()
> * Dropped id parameter from rvin_mc_parse_of()
> * Renamed rzg2l_cru_csi2_init() -> rzg2l_cru_media_init()
> * Used dev_err_probe() in rzg2l_cru_probe()
> * Replaced devm_reset_control_get() -> devm_reset_control_get_exclusive()
> * Prefixed HW_BUFFER_MAX and HW_BUFFER_DEFAULT macros with RZG2L_CRU_
> * Moved asserting presetn signal from rzg2l_cru_dma_register() to rzg2l_cru_start_streaming_vq()
> * Dropped VB2_READ from VB2 io_modes
> * Used dev_dbg() in rzg2l_cru_video_register() and rzg2l_cru_video_unregister()
> * Got rid of rzg2l_cru_notify()
> * Dropped V4L2_CAP_READWRITE from device caps
> * Introduced rzg2l_cru_v4l2_init() for initialization.
> * Got rid v4l2_pipeline_pm_get() and used PM in ov5645 sensor driver. Patch posted
>   https://patchwork.linuxtv.org/project/linux-media/patch/20220927201634.750141-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>
> v1 -> v2:
> * Dropped media prefix from subject
> * Renamed node name csi20 -> csi
> * Used 4 spaces for indentation in example node
> * Dropped reset-names and interrupt-names properties
> * Dropped oneOf from compatible
> * Included RB tags from Laurent
> * Marked port0/1 as required for cru node
> * Sorted Kconfig select
> * Prefixed generic names for struct/variables with rzg2_csi2
> * Dropped unnecessary checks for remote source
> * Dropped exporting functions
> * Moved lane validation to probe
> * Split up rzg2l_csi2_dphy_setting() and rzg2l_csi2_mipi_link_setting()
> * Used rzg2l_csi2_write() wherever possible
> * Dropped stream_count/lock members from csi2 struct
> * Used active subdev state instead of manually storing format in driver
> * Implemented init_cfg/enum_frame_size/enum_mbus_code callbacks
> * Dropped check for bus_type of remote source
> * Switched to manually turning ON/OFF the clocks instead of pm_runtime so that
>   the mipi/dhpy initialization happens as per the HW manual
> * Hardcoded VC0 usage for now as streams API is under development
>
> v1:
> - https://patchwork.kernel.org/project/linux-renesas-soc/cover/20220801214718.16943-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>
> RFC v2:
> - https://patchwork.kernel.org/project/linux-renesas-soc/cover/20220121010543.31385-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>
> RFC v1:
> - https://patchwork.kernel.org/project/linux-renesas-soc/cover/20211207012351.15754-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
>
> Cheers,
> Prabhakar
>
> Lad Prabhakar (4):
>   media: dt-bindings: Document Renesas RZ/G2L CSI-2 block
>   media: dt-bindings: Document Renesas RZ/G2L CRU block
>   media: platform: Add Renesas RZ/G2L MIPI CSI-2 receiver driver
>   media: platform: Add Renesas RZ/G2L CRU driver
>
Gentle ping.

Cheers,
Prabhakar
