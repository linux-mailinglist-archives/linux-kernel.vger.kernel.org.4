Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7B4748746
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbjGEPBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjGEPBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:01:14 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C90019B4
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:00:52 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-992b27e1c55so792024566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 08:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688569250; x=1691161250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=te7ZTqU2IoT9XIGw2EbziQaj/YYC283/vVSu4b+CNek=;
        b=r9JsIleXpo2dWTzL+ZV+elyskuAaCF2taVw0f9phsK3GrYUAdyMvnbpijv17Yp645q
         p+UCXuQuPc16Zap1SixmI7olsVTQeoAabhZlAidjBSouHnx/Nl6FNo5tmLYAnWywEghl
         Y2FC8owneMBgeV57TlrUC+yWNYt8KWUlSOGrHFvi71piz743harK9sMZhIrhueNASMUs
         8sQrKE4zH/MBasgUYigiiENS73ocu1AtgIlj1HG8GngzawR6gYk+p1lEPUFyRlxj4whE
         KGU5N1h7Xik4FUB+576fhgiOfrQPA6LDt5ODTd/ggAfw9ns7k/6ZSAJLOP8SYu+r/Wp5
         bYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688569250; x=1691161250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=te7ZTqU2IoT9XIGw2EbziQaj/YYC283/vVSu4b+CNek=;
        b=FHcrOH/90zyF7wfBffyfEl+lviMJtrOglEoK5EqzSKrm090/T1wQMTzUK+jxwvMmxR
         1EyjGtLoQd+hB9VzxVg5wdhEs3GO8kBTQIMBTttHw0lpaI7xiLKNHZtb3p2xuJ3ZSuA1
         MaDYBCUfvYcbeKJCChHfMWmjo9iPRT04hQhexHpfP9+lrMaqj8E8XKQgRaVdBUMkPa7Q
         tAIIaNspR967bvadJqx8ZzIOaetxbrWJf6bfKQKXNh3WDL45NMuYgG+6lY4rTJ6pQN72
         yrqMo/syQHAW7sJv3UvRajvIkQ084qPHski0le5u/aK7g89XzP70YsDaQ2zID/+SzoPP
         YpBQ==
X-Gm-Message-State: ABy/qLYb74IAEvSGcyIGvBEOU4hUspOCjKcNDAPuBS6c3RBvqcx3g0Wx
        MMg0DNveNgWnPDhvk+Wp//T4qg==
X-Google-Smtp-Source: APBJJlEfu0+hNLil8BYNwvy1vxVpDCvcO7TuZ5KjCpyK+0ZFuRA0oWqVFrhsGuBCMUH/lTHLFFO5ag==
X-Received: by 2002:a17:906:148c:b0:988:6e75:6b3d with SMTP id x12-20020a170906148c00b009886e756b3dmr10798805ejc.33.1688569250027;
        Wed, 05 Jul 2023 08:00:50 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id k17-20020a1709063e1100b009875a6d28b0sm4865670eji.51.2023.07.05.08.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 08:00:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: nuvoton: add missing space before {
Date:   Wed,  5 Jul 2023 17:00:45 +0200
Message-Id: <20230705150045.293879-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing whitespace between node name/label and opening {.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gsj.dts            | 4 ++--
 arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dts           | 2 +-
 arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dts | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gsj.dts b/arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gsj.dts
index 2a394cc15284..ef0669b2f4dc 100644
--- a/arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gsj.dts
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gsj.dts
@@ -146,7 +146,7 @@ partitions {
 			compatible = "fixed-partitions";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			bmc@0{
+			bmc@0 {
 				label = "bmc";
 				reg = <0x000000 0x2000000>;
 			};
@@ -155,7 +155,7 @@ u-boot@0 {
 				reg = <0x0000000 0x80000>;
 				read-only;
 			};
-			u-boot-env@100000{
+			u-boot-env@100000 {
 				label = "u-boot-env";
 				reg = <0x00100000 0x40000>;
 			};
diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dts b/arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dts
index f7b38bee039b..568da1caf84b 100644
--- a/arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dts
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-npcm730-kudo.dts
@@ -397,7 +397,7 @@ u-boot@0 {
 				reg = <0x0000000 0xC0000>;
 				read-only;
 			};
-			u-boot-env@100000{
+			u-boot-env@100000 {
 				label = "u-boot-env";
 				reg = <0x00100000 0x40000>;
 			};
diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dts b/arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dts
index 87359ab05db3..d6a9b97d183a 100644
--- a/arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dts
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dts
@@ -111,7 +111,7 @@ partitions {
 			compatible = "fixed-partitions";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			bmc@0{
+			bmc@0 {
 				label = "bmc";
 				reg = <0x000000 0x2000000>;
 			};
@@ -120,7 +120,7 @@ u-boot@0 {
 				reg = <0x0000000 0x80000>;
 				read-only;
 			};
-			u-boot-env@100000{
+			u-boot-env@100000 {
 				label = "u-boot-env";
 				reg = <0x00100000 0x40000>;
 			};
-- 
2.34.1

