Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2285A742265
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 10:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjF2ImU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 04:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjF2IlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 04:41:12 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372EA3C39
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 01:37:37 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3141316b253so415016f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 01:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1688027855; x=1690619855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eHpE4uTWiAqdi7U0f3J575mib/zD7YmmgRLR1ViHO+A=;
        b=frEbSknS3v438cdIlYKHwjwtwgqkU3mgD/rVMxfM9D/7fjJlbTWQsTlixjZa855t3+
         ZkPMIV/L2XKqU6jFbBBevvmNbKXEujiwIdNIfmd0XkbHhYoT7BU6S6GcY8PYNnLVmVMS
         R8vwKSnMBLxrLXRPzl01uyZzIgNsKMGVCENtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688027855; x=1690619855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eHpE4uTWiAqdi7U0f3J575mib/zD7YmmgRLR1ViHO+A=;
        b=FIhX7MBdOzrGFp8toQo9H1SLO1oIAlv/X5Ot4bbxMv3xmPEBogIJs9hf3j62jgufa4
         YMVYntVsANW9LWPcmK/LDBIVLnfGcwDTfj6G2iN2tvF4L6StT3qcH/qTEx+qbvKNcKSv
         oo+aLllu+wQtjaWAK6NVChfnG/EOPOj+j4PoNJxlNQ3Sbt0dTsw9mG/xoOlrrhp5SiYB
         kMJu6VuGgAONOqNlMntgJAZ2z8YjOaxbqCvfaS0m33x9aszNxq9mxzGeoFjSUwIi5oMR
         C5OaWIqqgo88bw0qL4G7DmZN06LTo3KQIxQlLAi96lv1ZwEYYIEhg0zKJRJxKIrujrVR
         N4Og==
X-Gm-Message-State: ABy/qLb7AppXsrxPSBhsVG2aVKvpZrSWVSHTuZFdWxRhTI9g62sYVa2Q
        xqloHddrO3rQn3/8P01i8wUh2JCT5hav4ybWrphhSA==
X-Google-Smtp-Source: APBJJlESkpal0RtTCw62QNAS9feUilaK2gVhUlIYl4Pq7aGF2xLVJApz8huaJEbVLYdmsI0FDdDPtA==
X-Received: by 2002:adf:f88f:0:b0:314:13e2:2f46 with SMTP id u15-20020adff88f000000b0031413e22f46mr1223503wrp.27.1688027855157;
        Thu, 29 Jun 2023 01:37:35 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.praguecc.cz (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id cw13-20020a056000090d00b003112f836d4esm15266322wrb.85.2023.06.29.01.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 01:37:34 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v5 0/3] Add display support on the stm32f746-disco board
Date:   Thu, 29 Jun 2023 10:37:23 +0200
Message-Id: <20230629083726.84910-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series adds support for the display on the stm32f746-disco board.

Changes in v5:
I am confident that framebuffer sizing is a real requirement for STM32 boards,
but I need some time to understand if and how to introduce this functionality.
Therefore, I drop the following patches to allow the series to be fully merged:
 - [4/6] dt-bindings: display: stm32-ltdc: add optional st,fb-bpp property
 - [5/6] ARM: dts: stm32: set framebuffer bit depth on stm32f746-disco
 - [6/6] drm/stm: set framebuffer bit depth through DTS property

Changes in v4:
- Use DTS property instead of module parameter to set the framebuffer bit depth.

Changes in v3:
- rename ltdc-pins-a-0 to ltdc-0.
- drop [4/6] dt-bindings: display: simple: add Rocktech RK043FN48H
  Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next):
  https://cgit.freedesktop.org/drm/drm-misc/commit/?id=c42a37a27c777d63961dd634a30f7c887949491a
- drop [5/6] drm/panel: simple: add support for Rocktech RK043FN48H panel
  Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)
  https://cgit.freedesktop.org/drm/drm-misc/commit/?id=13cdd12a9f934158f4ec817cf048fcb4384aa9dc

Dario Binacchi (3):
  ARM: dts: stm32: add ltdc support on stm32f746 MCU
  ARM: dts: stm32: add pin map for LTDC on stm32f7
  ARM: dts: stm32: support display on stm32f746-disco board

 arch/arm/boot/dts/stm32f7-pinctrl.dtsi | 35 ++++++++++++++++++
 arch/arm/boot/dts/stm32f746-disco.dts  | 51 ++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32f746.dtsi       | 10 +++++
 3 files changed, 96 insertions(+)

-- 
2.32.0

