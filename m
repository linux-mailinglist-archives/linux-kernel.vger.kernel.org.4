Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA06651DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiLTJmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbiLTJln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:41:43 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0177FCED;
        Tue, 20 Dec 2022 01:41:39 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 21so8133180pfw.4;
        Tue, 20 Dec 2022 01:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xtcni4zL9udO1S1uEK/8gX1ILHpQ+oX/DJS82ogAcMk=;
        b=DILbQ6+16hFsfPucdcVvbtcfBhfIp47i1kxtUV0hLfbFftuT1/eWSndEsYSFsqlBdI
         EdFhL6KMkiQwd1qQzk1ti6tV2nf8dkxVlxyx06sPUoPP9VqMez3npAQrZwuAIcrpwTvz
         3IOGV9Qak9y6xgqxysatKxDGTEeFeYsT4R7snv7zKie9npB90+RoIsehsfs8xv4mfny4
         eo24p78pRRplZhm2A26esNmIwiDhtPAC9B/NraqbHQ6FEmyRtIG5A1Ic5Brjv3oO5Wkr
         nV305X15e7GKCWDE4uFXgDHCjy8cQ9lSOV7o5qkCQvkzO0O3lzPvW1g9XCk7O3+AAA8A
         pkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xtcni4zL9udO1S1uEK/8gX1ILHpQ+oX/DJS82ogAcMk=;
        b=V/y3CuYpfctL7FXlq+f9AgAEgwP3PtGb0tdD2UJDolSjryLCru24tawQPH0VFnN3rl
         wWexdD0iCmBXnr7UgyKQiAdsBNNYdGihDG2qew5JbUcZFw/QnPnhJJXXte4VhaEAdCCr
         PLYpZ3+PdG1czYT3N9/f+VRc2hIRTEO4HstvmKUUy3J9TINhaMrgfMcgxXYjGLcOuKFz
         s6fDGk7r4ZXmu3TjePVtvoov6KYc0aEUVkpvYU393mUorjZ1LWbwGDYpAgGGNN1A7NHN
         X2O/50BXWXjDRcyXYwYWO9k6HCnlCpSvyvdfW45pcXN6ryR3SyAImiIMkgCjJcL2jo2A
         POJw==
X-Gm-Message-State: ANoB5pkMJAmJetIpsilefbDHFeYt9ta8ICCk4cgw2ZbpULcs5NI5P797
        Z3D0qYA+lyfm2ancpfuGNQo=
X-Google-Smtp-Source: AA0mqf7fhGEKPc1SjL3fdWIX57OF9R+OVXg8ihR6K3lSQmGYmUQQXXiIerVVkHBlizzLa408gr/VVg==
X-Received: by 2002:a62:1b95:0:b0:577:b42:85a4 with SMTP id b143-20020a621b95000000b005770b4285a4mr44948233pfb.25.1671529299215;
        Tue, 20 Dec 2022 01:41:39 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id b17-20020a621b11000000b00576a89978e5sm8210230pfb.63.2022.12.20.01.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 01:41:38 -0800 (PST)
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
Subject: [PATCH v9 0/7] Support Nuvoton NPCM Video Capture/Encode Engine
Date:   Tue, 20 Dec 2022 17:40:48 +0800
Message-Id: <20221220094055.3011916-1-milkfafa@gmail.com>
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

VCD can capture/differentiate video data from digital or analog sources,
then the ECE will compress the data into HEXTILE format which is defined in
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
  media: dt-binding: nuvoton: Add NPCM VCD and ECE engine
  dt-bindings: arm: nuvoton: Add bindings for NPCM GFXI
  media: v4l: Add HEXTILE compressed format
  media: v4l2-ctrls: Reserve user control base for NPCM video controls
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
 drivers/media/platform/nuvoton/npcm-video.c   | 1924 +++++++++++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c          |    1 +
 include/uapi/linux/npcm-video.h               |   41 +
 include/uapi/linux/v4l2-controls.h            |    6 +
 include/uapi/linux/videodev2.h                |    1 +
 18 files changed, 2427 insertions(+)
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

