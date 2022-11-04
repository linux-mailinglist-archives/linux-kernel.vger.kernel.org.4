Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE890618F2A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 04:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiKDDiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 23:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKDDil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 23:38:41 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A599EC0D;
        Thu,  3 Nov 2022 20:38:39 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d20so2707744plr.10;
        Thu, 03 Nov 2022 20:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BIBSO8ZhfoOnCIqBf4JIjxIbJSOo930x/QG6CRhZqZw=;
        b=p7qzc0fD4Y9LXR0L1FApcK7vnnes03yi+J8oM4Enu/2md0/3wJtUp55hjpuLK6CbWg
         oH0GZQVJ10AUo9q5xBBvnb/SLv0+YhbFlopNIgBrF3wTBo2fw8LqNfNmO62NETWA54m3
         0rRPhAkU1Sfi5NSehJs9j3UV6InyBY/422hBRgmMh/y0CQUQLBZ2MEHMjmsecrM588x3
         Gc1sV3sC0+Nc/SQR78IULghPWV5e/dAJRKHTKO/JCjxTS6Ule9WtyvAxTM2chbERyuW4
         Imd80Bbrzd1aboX5F2k8dER9mRyHzDjpFzHbpcpXk3PkscPdbTAhiVhedyl1DMWErONx
         yfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BIBSO8ZhfoOnCIqBf4JIjxIbJSOo930x/QG6CRhZqZw=;
        b=pxh+TEIIbkMDWAze97CNS5McFiFX1FsGYvBTLMUKJQQKL/2dH16VFtSgRFzfZ9XwAD
         znOfYoMEHGaSzCb37N6y0g7OZyX19adGFNAGX0ubwHWE9mtzSXvM/D5btCmVF16AHFd0
         9DFUbSQNZqtSD0Wa4mUFQbwSqckVeavraI9YqZfyoPILwCEpRAiea3F2DajEHKslYZtb
         AR+Hnyox2Kyu8/tw/VSHhztOggA9sX2gmtcjd7QzGJSv7neR4wEOM2WV6nWY/di8M3hr
         VWorzVty2fPp8L6l3j5ql/VTXqo3wr4ewX42yheNCGPac/YmH2l9ad8gRn43M9wsNqU6
         2oiA==
X-Gm-Message-State: ACrzQf3SpWsZNLA+iCNgLqMPQKkzTRUCUSiNo2IimgcaDqi6LtcluqjP
        XSrmj97hWMg1EKmjc9T8ouSL39Wk+jI=
X-Google-Smtp-Source: AMsMyM6QvfRsAwE/H7kQmKWFTjew7xtuhLq7ti65AZx5tJU+VmBSUdG/vxpZCn+cFki5lCJUPiK16A==
X-Received: by 2002:a17:902:f647:b0:183:cb8d:40a0 with SMTP id m7-20020a170902f64700b00183cb8d40a0mr33220333plg.18.1667533119049;
        Thu, 03 Nov 2022 20:38:39 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id f17-20020aa79d91000000b0056bb06ce1cfsm1545759pfq.97.2022.11.03.20.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 20:38:38 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v6 0/5] Support Nuvoton NPCM Video Capture/Encode Engine
Date:   Fri,  4 Nov 2022 11:38:05 +0800
Message-Id: <20221104033810.1324686-1-milkfafa@gmail.com>
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
then the ECE will compress the data into HEXTILE format.

HEXTILE compressed format is defined in Remote Framebuffer Protocol (RFC
6143) and is used by VNC features, so we also add a patch to support it.

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

Marvin Lin (5):
  arm: dts: Add node for NPCM Video Capture/Encode Engine
  dt-bindings: media: Add dt-bindings for NPCM Video Capture/Encode
    Engine
  dt-bindings: arm/npcm: Add dt-bindings for Graphics Core Information
  media: Add HEXTILE compressed format
  drivers: media: platform: Add NPCM Video Capture/Encode Engine driver

 .../bindings/arm/npcm/nuvoton,gfxi.yaml       |   41 +
 .../bindings/media/nuvoton,npcm-video.yaml    |   87 +
 .../media/v4l/pixfmt-reserved.rst             |    7 +
 MAINTAINERS                                   |    9 +
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi |   19 +
 drivers/media/platform/Kconfig                |    1 +
 drivers/media/platform/Makefile               |    1 +
 drivers/media/platform/nuvoton/Kconfig        |   12 +
 drivers/media/platform/nuvoton/Makefile       |    2 +
 drivers/media/platform/nuvoton/npcm-video.c   | 2093 +++++++++++++++++
 drivers/media/v4l2-core/v4l2-ioctl.c          |    1 +
 include/uapi/linux/videodev2.h                |    1 +
 12 files changed, 2274 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/npcm/nuvoton,gfxi.yaml
 create mode 100644 Documentation/devicetree/bindings/media/nuvoton,npcm-video.yaml
 create mode 100644 drivers/media/platform/nuvoton/Kconfig
 create mode 100644 drivers/media/platform/nuvoton/Makefile
 create mode 100644 drivers/media/platform/nuvoton/npcm-video.c

-- 
2.34.1

