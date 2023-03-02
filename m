Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1298D6A8AFF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 22:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjCBVLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 16:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjCBVL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 16:11:29 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0440756526
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 13:11:28 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so310786pjz.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 13:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91DAitSRrzFTGQbTfLZeTa2CLJ8tEC8v55hN4JyNA5I=;
        b=OG+eC6ru9Uat+HsKvll2I0SRUkQvgIe98/nAzW+XWN9hN462BCYN25vd2/ErMcEiMY
         Pmnlx5+PhiOaNmxW7aV1U7eQVhnNELAFZwqV5nYv7wxLeBnRKe2o7bka0uF4gyE3IUpA
         BuWP+4/LDvWxTK9KqXCGdfiSO6j7TOxQsAeic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91DAitSRrzFTGQbTfLZeTa2CLJ8tEC8v55hN4JyNA5I=;
        b=49Zf1og6NS7tr87lGLMDXWGMPF8S+7riM4QH74w3K4IMCJev+Y3IOKlqDEa+TdTfMY
         0Cbs/aic+kwsk1zjIHx/pvLr/k2dhDsZ0vmyqRTqDkAnW0NO6/OAGX7yRhjDQ1TGa27k
         nSH4Li+yEHujzF9P9VaE53pfne/YcsHRObmDsr8PaebH72qFgYqE3l3m/M5PhDgYD2GM
         45PC+DerDPaJC/btybn0Z0ecKap94yMKO6HJiDN1+KVVRf1hoWqkBXe6uKHgJWs1EXKJ
         AlD8cQ+wEztiXmlShATovETMjvMB52FZvRV7iu27msPCzrVvEmjhEoGg+z8V1S6qaOr/
         emCw==
X-Gm-Message-State: AO0yUKXZBqNLaj3ByoWxAXJoXDgFfGfSFgSDbMpNm4m7kzQL1RdXucE6
        1GntYssMo5Kh8BEXquoIh4w/dA==
X-Google-Smtp-Source: AK7set8yzxPzJuVDTySrO4TmQoheVuqLSgrMMl3Mqu2TZWdC0jZ2ukMm6ECqGk2mHfx8Ypq8jLosmQ==
X-Received: by 2002:a17:902:e881:b0:19c:df17:7c8e with SMTP id w1-20020a170902e88100b0019cdf177c8emr11382828plg.68.1677791487494;
        Thu, 02 Mar 2023 13:11:27 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:a558:99c0:81e9:a93c])
        by smtp.gmail.com with ESMTPSA id a16-20020a170902b59000b00195f242d0a0sm114497pls.194.2023.03.02.13.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 13:11:27 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>, mka@chromium.org,
        swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] arm64: dts: qcom: sc7180: Delete wormdingler-rev0
Date:   Thu,  2 Mar 2023 13:11:04 -0800
Message-Id: <20230302131031.v2.1.Id0cd5120469eb200118c0c7b8ee8209f877767b4@changeid>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
In-Reply-To: <20230302211108.2129598-1-dianders@chromium.org>
References: <20230302211108.2129598-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The earliest wormdingler I could find in my pile of hardware is
-rev1. I believe that -rev0 boards were just distributed as a pile of
components with no case. At this point I can't imagine anyone needing
to make wormdingler-rev0 work, so let's delete support for it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Also delete "sc7180-trogdor-wormdingler-rev0.dtsi" (Konrad)

 arch/arm64/boot/dts/qcom/Makefile             |  2 --
 .../sc7180-trogdor-wormdingler-rev0-boe.dts   | 22 ------------
 .../sc7180-trogdor-wormdingler-rev0-inx.dts   | 22 ------------
 .../qcom/sc7180-trogdor-wormdingler-rev0.dtsi | 36 -------------------
 4 files changed, 82 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dts
 delete mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dts
 delete mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 31aa54f0428c..a51060378ddc 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -118,8 +118,6 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r3.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r3-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-quackingstick-r0.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-quackingstick-r0-lte.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev0-boe.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev0-inx.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-boe.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-inx.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dts
deleted file mode 100644
index d6ed7d0afe4a..000000000000
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dts
+++ /dev/null
@@ -1,22 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Google Wormdingler board device tree source
- *
- * Copyright 2021 Google LLC.
- *
- * SKU: 0x10 => 16
- *  - bits 7..4: Panel ID: 0x1 (BOE)
- */
-
-/dts-v1/;
-
-#include "sc7180-trogdor-wormdingler-rev0.dtsi"
-
-/ {
-	model = "Google Wormdingler rev0 BOE panel board";
-	compatible = "google,wormdingler-rev0-sku16", "qcom,sc7180";
-};
-
-&panel {
-	compatible = "boe,tv110c9m-ll3";
-};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dts
deleted file mode 100644
index c03525ea64ca..000000000000
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dts
+++ /dev/null
@@ -1,22 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Google Wormdingler board device tree source
- *
- * Copyright 2021 Google LLC.
- *
- * SKU: 0x0 => 0
- *  - bits 7..4: Panel ID: 0x0 (INX)
- */
-
-/dts-v1/;
-
-#include "sc7180-trogdor-wormdingler-rev0.dtsi"
-
-/ {
-	model = "Google Wormdingler rev0 INX panel board";
-	compatible = "google,wormdingler-rev0-sku0", "qcom,sc7180";
-};
-
-&panel {
-	compatible = "innolux,hj110iz-01a";
-};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0.dtsi
deleted file mode 100644
index 7f272c6e95f6..000000000000
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0.dtsi
+++ /dev/null
@@ -1,36 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Google Wormdingler board device tree source
- *
- * Copyright 2021 Google LLC.
- *
- */
-
-/dts-v1/;
-
-#include "sc7180-trogdor-wormdingler.dtsi"
-
-&avdd_lcd {
-	gpio = <&tlmm 80 GPIO_ACTIVE_HIGH>;
-};
-
-&panel {
-	enable-gpios = <&tlmm 76 GPIO_ACTIVE_HIGH>;
-};
-
-&v1p8_mipi {
-	gpio = <&tlmm 81 GPIO_ACTIVE_HIGH>;
-};
-
-/* PINCTRL - modifications to sc7180-trogdor-wormdingler.dtsi */
-&avdd_lcd_en {
-	pins = "gpio80";
-};
-
-&mipi_1800_en {
-	pins = "gpio81";
-};
-
-&vdd_reset_1800 {
-	pins = "gpio76";
-};
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

