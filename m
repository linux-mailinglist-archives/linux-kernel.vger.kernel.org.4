Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AFA61F6D1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbiKGO4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbiKGOz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:55:56 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AAE1DF27
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:55:41 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ud5so30844902ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 06:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IPRldRMJ1g8FWAAHM7NB3ovkvtoWvy4HlATgwoy5QE=;
        b=UXI2FYajidLaW/xb30L5jq9cy8w2/NzlFh0A95KSR5IiRVnDsMopn5lmGgKhH2WBRY
         pC6ig+BUlBOar0o+aluJKIRIFHGw4MANGHUCJuvGqo0s3fYCwaI5VCniElFSfdGVkUMz
         lgdIJJaG9AknLGdz5xE17ktM/cGFPEmiZBiKesMjJmnPNzrSGoZD0IsM8UyF5fU35NGJ
         whb3JXJRmUUO/qyWFKXMhx09g/UVxgQgtPIpVDJUQWWSilPg9ur2OTQWJomqE9t1iE+k
         LWxZSvZvu8rw50SimH862OyM2Yw2aUc134P6XuPtz5Ni0+vYZumy1I6D7ukYYgSC51kp
         zezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IPRldRMJ1g8FWAAHM7NB3ovkvtoWvy4HlATgwoy5QE=;
        b=QWvNrnoVAzI6fPhoRa+Ztp2nxuaspHjWbt0vtqON3rNeuDd7hGA6+ok0re6zAEqt/X
         3L9nS8/T6JOixCnMKKt9jWlX/XszNzLbB923AO4CwDBICZnl3QFvZXswB2epW6WPrSsi
         vG4GYUE1A77o+sztAL+Occpi7EgFbef0bP/l++sXwvKhFeSAzXCCjvSd21NqhrX416pU
         DvVnmYtEQTafbvnrigxOh/H/TT7DdycMQeO33nM8X3GKGGnyzIVEfA5OYyg+kruNb3P5
         mSFf8qA0T0TfWmPTVM4W8ofqmeeLFKzpVGoOOspC1vZcXqTmC7l2Spx4IaStFS2udDwN
         9N8A==
X-Gm-Message-State: ACrzQf2aaA2p7NtchgDb8DIdEmowycDRx9vgbKimwgXJpgFA1rbeC2nd
        GvIJxybvKO3xAcpqiDjpQsDzBw==
X-Google-Smtp-Source: AMsMyM4fX7GoRoj8iBy6jSTxgHk/D4/MazsZhRjwby99I5TOTa4PRxMPTzh5v+3ezMHOBSg4sR7wnw==
X-Received: by 2002:a17:907:a48:b0:7a7:3714:1629 with SMTP id be8-20020a1709070a4800b007a737141629mr46448320ejc.569.1667832939955;
        Mon, 07 Nov 2022 06:55:39 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id d1-20020a1709067f0100b0078907275a44sm3503049ejr.42.2022.11.07.06.55.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Nov 2022 06:55:39 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] arm64: dts: qcom: ipq8074-*: Fix up comments
Date:   Mon,  7 Nov 2022 15:55:17 +0100
Message-Id: <20221107145522.6706-8-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221107145522.6706-1-konrad.dybcio@linaro.org>
References: <20221107145522.6706-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure all multiline C-style commends begin with just '/*' with
the comment text starting on a new line.

Also, fix up some whitespace within comments.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts    |  3 ++-
 arch/arm64/boot/dts/qcom/ipq8074-hk10-c1.dts |  3 ++-
 arch/arm64/boot/dts/qcom/ipq8074-hk10-c2.dts |  3 ++-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi        | 12 ++++++------
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
index b60b2d4c2ea5..b918543f6bb4 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
+++ b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /dts-v1/;
-/* Copyright (c) 2017, The Linux Foundation. All rights reserved.
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
  */
 #include "ipq8074.dtsi"
 #include "pmp8074.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/ipq8074-hk10-c1.dts b/arch/arm64/boot/dts/qcom/ipq8074-hk10-c1.dts
index 2bfcf42aeabc..cc1992ca0519 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074-hk10-c1.dts
+++ b/arch/arm64/boot/dts/qcom/ipq8074-hk10-c1.dts
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* Copyright (c) 2020 The Linux Foundation. All rights reserved.
+/*
+ * Copyright (c) 2020 The Linux Foundation. All rights reserved.
  */
 /dts-v1/;
 
diff --git a/arch/arm64/boot/dts/qcom/ipq8074-hk10-c2.dts b/arch/arm64/boot/dts/qcom/ipq8074-hk10-c2.dts
index 7da39f1d979b..d7f0efda6b8e 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074-hk10-c2.dts
+++ b/arch/arm64/boot/dts/qcom/ipq8074-hk10-c2.dts
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /dts-v1/;
-/* Copyright (c) 2020 The Linux Foundation. All rights reserved.
+/*
+ * Copyright (c) 2020 The Linux Foundation. All rights reserved.
  */
 #include "ipq8074-hk10.dtsi"
 
diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index d3d9e7eb5837..8fd69a7b13dc 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -129,10 +129,10 @@ ssphy_1: phy@58000 {
 			status = "disabled";
 
 			usb1_ssphy: phy@58200 {
-				reg = <0x00058200 0x130>,       /* Tx */
+				reg = <0x00058200 0x130>,     /* Tx */
 				      <0x00058400 0x200>,     /* Rx */
-				      <0x00058800 0x1f8>,     /* PCS  */
-				      <0x00058600 0x044>;     /* PCS misc*/
+				      <0x00058800 0x1f8>,     /* PCS */
+				      <0x00058600 0x044>;     /* PCS misc */
 				#phy-cells = <0>;
 				#clock-cells = <0>;
 				clocks = <&gcc GCC_USB1_PIPE_CLK>;
@@ -172,10 +172,10 @@ ssphy_0: phy@78000 {
 			status = "disabled";
 
 			usb0_ssphy: phy@78200 {
-				reg = <0x00078200 0x130>,       /* Tx */
+				reg = <0x00078200 0x130>,     /* Tx */
 				      <0x00078400 0x200>,     /* Rx */
-				      <0x00078800 0x1f8>,     /* PCS  */
-				      <0x00078600 0x044>;     /* PCS misc*/
+				      <0x00078800 0x1f8>,     /* PCS */
+				      <0x00078600 0x044>;     /* PCS misc */
 				#phy-cells = <0>;
 				#clock-cells = <0>;
 				clocks = <&gcc GCC_USB0_PIPE_CLK>;
-- 
2.38.1

