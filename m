Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EBA68D28B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjBGJUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjBGJUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:20:09 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7371F491;
        Tue,  7 Feb 2023 01:20:07 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id d6-20020a17090ae28600b00230aa72904fso5999203pjz.5;
        Tue, 07 Feb 2023 01:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sACnErhtrCsWw74xwaNwuygQbaOdtgbjKjTOtxPcekQ=;
        b=kaf2yqSVeOvUWMU9XXznG8AUmjNCOvebNTky2BXBFRrsvTsZsq1Zqm2r2UvHnOZeEJ
         nFnZJ69CSctP7Flb+JG5RIXJyJRLP1A56vHhLAn/yVLILmmBQOfGrOAQhlKaGElOXpid
         pfu1YOAEPSVXqwJDcm8YxX30/LAaHV00CbQlA/LUXohN9jEyJg2cRM4DrIzJtzm3G9p3
         aVd//9k00dtzdkQW50px2t/Eu5C0asR/ZTFk46iDcTNM56yjmAHe84uYHywDEQEq0932
         eKRPK8DGbNAeRnL+cO3JmSaLGbSwGicglwyaGvO+kE4QOT/xjqXrovMadA2ABg6QYmTs
         uOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sACnErhtrCsWw74xwaNwuygQbaOdtgbjKjTOtxPcekQ=;
        b=oxclEHMCx5F8qKH0WV3MjpTyUoZFgUZEaohfk5+QedM5FqTjhMMGbAF7IWlWhEQliv
         +q8l8axuI+Q5BfMxAM3iG30Be6uYiGmGBJ41JjooIO8hu5PPkAvgw80s8o1gWjIizoMy
         bqXuRH2X4r08v35IENuG/rgqu77qJrxi0l84JPdV+hJqBfxBR3PxDuykMaNmV7S8M84A
         4jzyW/auJ5CzHJckrkSpaXLgSFGyVtAbdqeUq4MGf40Q5BMM6sT0Q9nUkGOR4D+qgIQC
         FeEQHvbYmX6WQxG4mv4bjFez8MDU4BtzkgdsOios666qhT94iCVmJMrPaGyK4ULYqnR3
         Fqdw==
X-Gm-Message-State: AO0yUKXIa3UvBzh9ethmh1LF95nwkfJD3Tlp3Alc4ldakIQMalIJ5V6G
        aJRmK0Tl+ZCgcfJ2QVULl1o=
X-Google-Smtp-Source: AK7set8i+FKwnEdgGx/shM69oqU+XicAXabWykjK/gQeIDVIoyEvrOeVykCZg5lkl6WzJyM1Pm1UlA==
X-Received: by 2002:a17:903:1107:b0:196:8d48:8744 with SMTP id n7-20020a170903110700b001968d488744mr2645647plh.40.1675761606909;
        Tue, 07 Feb 2023 01:20:06 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id io20-20020a17090312d400b0019934030f46sm545327plb.132.2023.02.07.01.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 01:20:06 -0800 (PST)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrzej.p@collabora.com
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com,
        Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v11 0/7] Support Nuvoton NPCM Video Capture/Encode Engine
Date:   Tue,  7 Feb 2023 17:18:55 +0800
Message-Id: <20230207091902.2512905-1-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add DTS node, dt-bindings document and drivers for Video
Capture/Differentiation Engine (VCD) and Encoding Compression Engine (ECE)
present on Nuvoton NPCM SoCs.

As described in the datasheet NPCM750D_DS_Rev_1.0, the VCD can capture a
frame from digital video input and compare two frames in memory, then the
ECE will compress the frame data into HEXTITLE format which is defined in
Remote Framebuffer Protocol (RFC 6143, chapter 7.7.4. Hextile Encoding).

The output of v4l2-compliance:
v4l2-compliance 1.23.0-4965, 64 bits, 64-bit time_t
v4l2-compliance SHA: d0964d133053 2022-11-06 14:46:45

Compliance test for npcm-video device /dev/video0:

Driver Info:
        Driver name      : npcm-video
        Card type        : NPCM Video Engine
        Bus info         : platform:npcm-video
        Driver version   : 5.15.50
        Capabilities     : 0x85200001
                Video Capture
                Read/Write
                Streaming
                Extended Pix Format
                Device Capabilities
        Device Caps      : 0x05200001
                Video Capture
                Read/Write
                Streaming
                Extended Pix Format

Required ioctls:
        test VIDIOC_QUERYCAP: OK
        test invalid ioctls: OK

Allow for multiple opens:
        test second /dev/video0 open: OK
        test VIDIOC_QUERYCAP: OK
        test VIDIOC_G/S_PRIORITY: OK
        test for unlimited opens: OK

Debug ioctls:
        test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
        test VIDIOC_LOG_STATUS: OK (Not Supported)

Input ioctls:
        test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
        test VIDIOC_ENUMAUDIO: OK (Not Supported)
        test VIDIOC_G/S/ENUMINPUT: OK
        test VIDIOC_G/S_AUDIO: OK (Not Supported)
        Inputs: 1 Audio Inputs: 0 Tuners: 0

Output ioctls:
        test VIDIOC_G/S_MODULATOR: OK (Not Supported)
        test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
        test VIDIOC_ENUMAUDOUT: OK (Not Supported)
        test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
        test VIDIOC_G/S_AUDOUT: OK (Not Supported)
        Outputs: 0 Audio Outputs: 0 Modulators: 0

Input/Output configuration ioctls:
        test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
        test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK
        test VIDIOC_DV_TIMINGS_CAP: OK
        test VIDIOC_G/S_EDID: OK (Not Supported)

Control ioctls (Input 0):
        test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
        test VIDIOC_QUERYCTRL: OK
        test VIDIOC_G/S_CTRL: OK
        test VIDIOC_G/S/TRY_EXT_CTRLS: OK
                warn: /usr/src/debug/v4l-utils/1.22.1-r0/utils/v4l2-compliance/v4l2-test-controls.cpp(1070): V4L2_CID_DV_RX_POWER_PRESENT not found for input 0
        test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
        test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
        Standard Controls: 1 Private Controls: 2

Format ioctls (Input 0):
        test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
                warn: /usr/src/debug/v4l-utils/1.22.1-r0/utils/v4l2-compliance/v4l2-test-formats.cpp(1411): S_PARM is supported for buftype 1, but not for ENUM_FRAMEINTERVALS
        test VIDIOC_G/S_PARM: OK
        test VIDIOC_G_FBUF: OK (Not Supported)
        test VIDIOC_G_FMT: OK
        test VIDIOC_TRY_FMT: OK
        test VIDIOC_S_FMT: OK
        test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
        test Cropping: OK (Not Supported)
        test Composing: OK (Not Supported)
        test Scaling: OK (Not Supported)

Codec ioctls (Input 0):
        test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
        test VIDIOC_G_ENC_INDEX: OK (Not Supported)
        test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)

Buffer ioctls (Input 0):
        test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
        test VIDIOC_EXPBUF: OK
        test Requests: OK (Not Supported)

Total for npcm-video device /dev/video0: 45, Succeeded: 45, Failed: 0, Warnings: 2

Changes in v11:
  - Replace "u8/u16/u32" with "unsigned int" for generic local variables.
  - Correct subsystem prefixes, drop redundant words in commit subject, and
    add more information in commit message.

Changes in v10:
  - drivers/media/platform/nuvoton/npcm-video.c
    * Let short functions to be inline function.
    * Correct return type of some functions, and properly handle return
      value by callers.
    * Correct the timing of removing rect_list and the flow of FIFO overrun
      case in irq.
    * Adjust line breaks, indentations, and style of variable declarations.

Changes in v9:
  - Change ECE node name to "video-codec".
  - Drop redundant "bindings for" in commit subject of patch 2/7.
  - Refine the format of VCD/ECE dt-binding document.

Changes in v8:
  - Let VCD/ECE to be 2 separate nodes and update dt-binding documents.
  - Move register definitions out to a local header file.
  - Driver refinements (add error handling for memory allocation, remove
    unnecessary condition check and introduce "goto"s to handle similar
    error recovery paths).
  - Correct properties and typo in GFXI dt-binding document.

Changes in v7:
  - Add uapi documents for driver-specific controls.
  - Implement driver-specific controls for switching capture mode and
    getting the count of compressed HEXTILE rectangles.
  - Drop unnecessary "enum_framesizes" and "enum_frameintervals" functions.
  - Include the output of v4l2-compliance in cover letter.

Changes in v6:
  - Support NPCM845 and add compatible "nuvoton,npcm845-video".
  - Correct pixel format to V4L2_PIX_FMT_HEXTILE which is newly added in
    this patch series.

Changes in v5:
  - Simplify function prefix "nuvoton_" to "npcm_".
  - Increase VCD_BUSY_TIMEOUT_US and ECE_POLL_TIMEOUT_US to 300ms to
    prevent polling timeout when ECC is enabled or system is busy.

Changes in v4:
  - Fix compile warning reported by kernel test robot.

Changes in v3:
  - Add video driver entry in MAINTAINERS.
  - Change config name to CONFIG_VIDEO_NPCM_VCD_ECE.
  - Reduce the waiting time after resetting the VCD/ECE module.
  - Correct data types of some variables.

Changes in v2:
  - Add Hextile document and locate with vendor formats.

Marvin Lin (7):
  ARM: dts: nuvoton: Add node for NPCM VCD and ECE engine
  media: dt-bindings: nuvoton: Add NPCM VCD and ECE engine
  dt-bindings: arm: nuvoton: Add NPCM GFXI
  media: v4l: Add HEXTILE compressed format
  media: v4l2-ctrls: Add user control base for Nuvoton NPCM controls
  media: uapi: Add controls for NPCM video driver
  media: nuvoton: Add driver for NPCM video capture and encode engine

 .../bindings/arm/npcm/nuvoton,gfxi.yaml       |   39 +
 .../bindings/media/nuvoton,npcm-ece.yaml      |   43 +
 .../bindings/media/nuvoton,npcm-vcd.yaml      |   72 +
 .../userspace-api/media/drivers/index.rst     |    1 +
 .../media/drivers/npcm-video.rst              |   67 +
 .../media/v4l/pixfmt-reserved.rst             |    7 +
 MAINTAINERS                                   |   12 +
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi |   23 +
 drivers/media/platform/Kconfig                |    1 +
 drivers/media/platform/Makefile               |    1 +
 drivers/media/platform/nuvoton/Kconfig        |   15 +
 drivers/media/platform/nuvoton/Makefile       |    2 +
 drivers/media/platform/nuvoton/npcm-regs.h    |  171 ++
 drivers/media/platform/nuvoton/npcm-video.c   | 1816 +++++++++++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c          |    1 +
 include/uapi/linux/npcm-video.h               |   41 +
 include/uapi/linux/v4l2-controls.h            |    6 +
 include/uapi/linux/videodev2.h                |    1 +
 18 files changed, 2319 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml
 create mode 100644 Documentation/devicetree/bindings/media/nuvoton,npcm-ece.yaml
 create mode 100644 Documentation/devicetree/bindings/media/nuvoton,npcm-vcd.yaml
 create mode 100644 Documentation/userspace-api/media/drivers/npcm-video.rst
 create mode 100644 drivers/media/platform/nuvoton/Kconfig
 create mode 100644 drivers/media/platform/nuvoton/Makefile
 create mode 100644 drivers/media/platform/nuvoton/npcm-regs.h
 create mode 100644 drivers/media/platform/nuvoton/npcm-video.c
 create mode 100644 include/uapi/linux/npcm-video.h

-- 
2.34.1

