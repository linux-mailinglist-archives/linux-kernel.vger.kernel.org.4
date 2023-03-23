Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C796C5B9B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 01:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCWA7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 20:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCWA7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 20:59:34 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015C01BEC;
        Wed, 22 Mar 2023 17:59:33 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id fb38so7303585pfb.7;
        Wed, 22 Mar 2023 17:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679533173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NRTtWZFrjGQyyLUPV9FPoANYfARHF+AlCJvVnplhgaI=;
        b=UIrTpiMXpPPaeGHanlAu5dDEuOb8Ll5M1YOka8oncWDzTr00HjtWBNK7UKwbzf0dJY
         f1DqAO6Iu/Sp2YlfHLZ3KKIFEuxfnXbzOgIgnZ7Ydr5HaaOo8fB8Cyv/8gDb8azemRgo
         wAf3c2c1A8QX98n4KrhQQ3G+7fxwQZ8DhvZldCqzrK+8j/iR859+sGxRlxwFhTmGPI1j
         LvlAogLnX6G6pLhcTcftg+MFYO9/wUcgedWB453+VtE07yNqyGshuaSMJAcs6LPgfIAP
         N1MYvp/lre7zmUx00S2UCJTOiDhxO//xy0NcCYNC/kO5Psj0i3VPAHE5z9rpuRD9Krn9
         EelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679533173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NRTtWZFrjGQyyLUPV9FPoANYfARHF+AlCJvVnplhgaI=;
        b=YM/d9cFy3nMbvKMSyFj26Vq6ZgPD5AJL6yivG85MTjLOfH4SdD9mRYmNNLV3DTRhTC
         eJ8C1B5f8G21DlQjz8onMG4xmKYBjp0K8HcILYmwjIvRORCXG6PP/sQ2tJxqmWmacBW0
         gROHuboQT87dvZCr5sSDFaBujsA0peoq8Z96fr8fTTxBiAgT1VNQclNkvZGLDhFGyyRA
         51dmbjp2dn0rclgvgNMgU89LyrqlS5IcXcN4O+W1Qk57gW+waE1IrCLVYgTn28xFfO7K
         bFuLdmNSrupFx61bzw6TIwlipBc4xBcCs6oabGKUaqvE5IFLUcy9jE9Upkb0nUGYlRQo
         Hlfg==
X-Gm-Message-State: AO0yUKUnxnanRq3s031x5UzN3Eh0JYfyVBJWg3LFouU4fDoPDm2ARmTA
        Ibn9zEUqJGiIuJaYrnLUvLI=
X-Google-Smtp-Source: AK7set8CwGKE/m/+SMKPy1UTcYb+CEvnPMoB7bcV6D51Q4XPBhpPKQ6B3Keebx1q72qYDu50N2cqMw==
X-Received: by 2002:aa7:9dc1:0:b0:627:e69c:847c with SMTP id g1-20020aa79dc1000000b00627e69c847cmr5115259pfq.16.1679533173445;
        Wed, 22 Mar 2023 17:59:33 -0700 (PDT)
Received: from localhost.localdomain (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id s10-20020aa7828a000000b006288ca3cadfsm2114579pfm.35.2023.03.22.17.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 17:59:32 -0700 (PDT)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH v3 1/3] arm64: dts: qcom: Split elish dts into common dtsi and elish-boe dts
Date:   Thu, 23 Mar 2023 08:59:23 +0800
Message-Id: <20230323005925.23179-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two panel variants of xiaomi-elish, BOE and CSOT panels.
In order to support both panels, so split elish dts into common dtsi
and elish-boe dts.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
Changes in v2:
  - Remove sm8250-xiaomi-elish.dtb to avoid build failure.

Changes in v3:
  - squash patch[3/4]

 arch/arm64/boot/dts/qcom/Makefile                   |  2 +-
 .../arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts | 13 +++++++++++++
 ...mi-elish.dts => sm8250-xiaomi-elish-common.dtsi} |  4 ----
 3 files changed, 14 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts
 rename arch/arm64/boot/dts/qcom/{sm8250-xiaomi-elish.dts => sm8250-xiaomi-elish-common.dtsi} (99%)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 1a29403400b7..808f46947661 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -183,7 +183,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-sony-xperia-edo-pdx203.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-sony-xperia-edo-pdx206.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-xiaomi-elish.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-xiaomi-elish-boe.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-microsoft-surface-duo2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-mtp.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts
new file mode 100644
index 000000000000..bd9ad109daf9
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-boe.dts
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023 Jianhua Lu <lujianhua000@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "sm8250-xiaomi-elish-common.dtsi"
+
+/ {
+	model = "Xiaomi Mi Pad 5 Pro (BOE)";
+	compatible = "xiaomi,elish", "qcom,sm8250";
+};
diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
similarity index 99%
rename from arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts
rename to arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
index dd79671f5614..a43d4b73ffca 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
@@ -3,8 +3,6 @@
  * Copyright (c) 2022, 2023 Jianhua Lu <lujianhua000@gmail.com>
  */
 
-/dts-v1/;
-
 #include <dt-bindings/arm/qcom,ids.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sm8250.dtsi"
@@ -24,8 +22,6 @@
 /delete-node/ &xbl_aop_mem;
 
 / {
-	model = "Xiaomi Mi Pad 5 Pro";
-	compatible = "xiaomi,elish", "qcom,sm8250";
 	classis-type = "tablet";
 
 	/* required for bootloader to select correct board */
-- 
2.39.2

