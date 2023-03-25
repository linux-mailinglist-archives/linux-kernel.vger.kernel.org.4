Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F78C6C8D72
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 12:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjCYL3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 07:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjCYL3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 07:29:14 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751B912CE0;
        Sat, 25 Mar 2023 04:29:02 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id q16so5379195lfe.10;
        Sat, 25 Mar 2023 04:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679743741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ht+M9qAwDcGzy0Oi5GFIk5LGEqROnuLchd2TnwqxBxs=;
        b=AM9xNCWXg1wmyrB1RoOB6p5kioHSwyTQw41FQf2b49pvAmiOqiiEN+IZtMhlrbuHiL
         Jl7UlaTt9aL0iHYgM8NrHQXG9Va2qBpgaKAuwPf2EI50mXZQnZGQeSFwCCV4NGpxpm2N
         s3jEMv4c0qDbjGrGYSBXpaKKQXnxhWIHE4WKxX/IQogWF8FnKwye9+7gWI96vBB5bAfS
         KmtdnA1JuDwYvuL/TBRZlOXjrcJ9Xj7SrpVo+RhJE8FRU40OSptdUqc5+SkFpUMZYKyz
         3XRvzH3SEzaurmbf1ddM8DWHrcqfr830JB1j57U9lxrLeg4TNCbuSUdyugCmpjzeKDa9
         VqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679743741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ht+M9qAwDcGzy0Oi5GFIk5LGEqROnuLchd2TnwqxBxs=;
        b=yTzrc8on/kYKywpkK2TFnYBjbuizBVxctBGzBj9zYKB5UFJfQSSKH41iwELxoDSWqu
         zFPbFikr8YHJg6fnkvYzFaAGU0zE+PXQpPphMVMIUXRUk3dzXljIx2a4GtcK5Pr8B9Rs
         FcTeYnJ9gWK56vPr3/aCvpA3HacSeGq5nHwxZKHRP+nsqjnlb8XTNsPrz2poZbZ4T6mU
         AyHWsWuhVmh88FlR1iX+GDTkPpR0QvE6lZBZ19X3OltzTB8F8cVP7O1FOPtvzjJB53t5
         c6IAA7btwb0UjjV3huAXgv5IQxfPe1rUgXBSaWu/Yx9KjeSJ6NjHqd4gClqELAjx3Jwv
         dsBg==
X-Gm-Message-State: AAQBX9eo+NMRPhPm+nNVczQivWixZc2o5HKeVT6SUt/lNLb3IudxIKO8
        nQjyYqT3QkFn4qiLca2jqydDuUMCTcZ9Zg==
X-Google-Smtp-Source: AKy350bejnySz6miPOH2OcjbHvHUExS1lkKqmmyuni0RJWWNhjWKW4qG7kFT3KIWm5uKzIt8zpKALg==
X-Received: by 2002:ac2:5989:0:b0:4dd:a053:3baf with SMTP id w9-20020ac25989000000b004dda0533bafmr1727986lfn.35.1679743740443;
        Sat, 25 Mar 2023 04:29:00 -0700 (PDT)
Received: from localhost.localdomain (cdb25.neoplus.adsl.tpnet.pl. [83.30.151.25])
        by smtp.gmail.com with ESMTPSA id m30-20020ac24ade000000b004eaf55936eesm1502510lfp.233.2023.03.25.04.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 04:29:00 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] arm64: dts: msm8953: Replace xo_board with rpmcc sourced xo
Date:   Sat, 25 Mar 2023 12:28:49 +0100
Message-Id: <20230325112852.18841-1-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign RPM_SMD_XO_CLK_SRC from rpmcc in place
of fixed-clock where possible.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index da00c2f04cda..438a70eb6152 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -2,6 +2,7 @@
 /* Copyright (c) 2022, The Linux Foundation. All rights reserved. */
 
 #include <dt-bindings/clock/qcom,gcc-msm8953.h>
+#include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
@@ -637,7 +638,7 @@ gcc: clock-controller@1800000 {
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
-			clocks = <&xo_board>,
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
 				 <&sleep_clk>,
 				 <0>,
 				 <0>,
@@ -801,7 +802,7 @@ dsi0_phy: phy@1a94400 {
 				#clock-cells = <1>;
 				#phy-cells = <0>;
 
-				clocks = <&gcc GCC_MDSS_AHB_CLK>, <&xo_board>;
+				clocks = <&gcc GCC_MDSS_AHB_CLK>, <&rpmcc RPM_SMD_XO_CLK_SRC>;
 				clock-names = "iface", "ref";
 
 				status = "disabled";
@@ -868,7 +869,7 @@ dsi1_phy: phy@1a96400 {
 				#clock-cells = <1>;
 				#phy-cells = <0>;
 
-				clocks = <&gcc GCC_MDSS_AHB_CLK>, <&xo_board>;
+				clocks = <&gcc GCC_MDSS_AHB_CLK>, <&rpmcc RPM_SMD_XO_CLK_SRC>;
 				clock-names = "iface", "ref";
 
 				status = "disabled";
@@ -992,7 +993,7 @@ sdhc_1: mmc@7824900 {
 
 			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
 				 <&gcc GCC_SDCC1_APPS_CLK>,
-				 <&xo_board>;
+				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
 			clock-names = "iface", "core", "xo";
 
 			power-domains = <&rpmpd MSM8953_VDDCX>;
@@ -1052,7 +1053,7 @@ sdhc_2: mmc@7864900 {
 
 			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
 				 <&gcc GCC_SDCC2_APPS_CLK>,
-				 <&xo_board>;
+				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
 			clock-names = "iface", "core", "xo";
 
 			power-domains = <&rpmpd MSM8953_VDDCX>;
-- 
2.25.1

