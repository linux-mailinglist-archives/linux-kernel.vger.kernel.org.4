Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B83174A244
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjGFQfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 12:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjGFQfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:35:41 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E68D183
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 09:35:40 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fb7769f15aso1393434e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 09:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688661339; x=1691253339;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YP6pMbBAQx82d9LFHalrVI6LUynmYyQZ/H6dn44Djmk=;
        b=BRy5pDTiQ2zs/gl9rX2cTtf9ekYsoXL7EahS7K1nGfivSrjwAjkIe4dPTqpvbG7lDb
         4nKpuNoFKhpBJsXXL4qbx8M/4mF+DBQFxPkCDe0oYB2aRBhLURa3FPyXiBBngGPONotW
         C/I0PbPQw3FZSGL/3vxbdCU5rp48BaX8wSRjMoJbcoyOnkCOUWpLqCIh1N0tifRO4ObZ
         wGqqXcvBElmth43cwxuGsVtl2wHtwMIjMoTIPNIS/ZVEEVfRChtT7IsCCPL6Qp9gj0/K
         3oRZC0jS6IN9zIAU1/84pzNN0PwH5s+CXRcIzF7oHOfJGhwZOTnZhNiQsPviJ1W3l51p
         aXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688661339; x=1691253339;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YP6pMbBAQx82d9LFHalrVI6LUynmYyQZ/H6dn44Djmk=;
        b=SCJR5LsKR9rwwdISJER0jGAz+yQ9QYjnIFEqwoEHDtSi+PItLmKTnpQIxL0wvZgqfV
         wcFi5bie5LPfe1OFzRXasrM2L0uenb+FB1rqTTGq4GrijPPuzkj+2nJxOLa0d/BrCOeG
         F6v3ZNBZR+ssvzJ8Di+oPpxN1z4Q37cDN5Za+ywQoPpwgRWsSnAznwCvUUIePGyHXrsU
         9gm08QEYR6BjB+SbuLCM+IsQDf09wPh+7DzDJ0ngF8nxp/QeVB9xqMn7kCBRM61J8iuY
         oAdQeSM+OTONLwhLb+Muzyezgvzf/y6MEsbUzyZ8RS+0aMr8ofLpfvDGbNDDjLk/kb8u
         3Q5g==
X-Gm-Message-State: ABy/qLb15O482bvtoK+vlzh6B+Scz2GY5mCC4gpUrrgLemjyn02uMNLJ
        iQuNOO3Y1UdhI+lvApWv80yhYg==
X-Google-Smtp-Source: APBJJlGDp3vceUiFr1kPMxrcDTNPVvpzmiLLKKKO5itkcEey7tHf8gT/kcZeP3gLYzEukAdcCQfL1A==
X-Received: by 2002:a19:6508:0:b0:4f9:69b8:1e7c with SMTP id z8-20020a196508000000b004f969b81e7cmr1743769lfb.46.1688661338703;
        Thu, 06 Jul 2023 09:35:38 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id e7-20020ac25467000000b004fb763b5171sm325784lfn.86.2023.07.06.09.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 09:35:38 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 06 Jul 2023 18:35:37 +0200
Subject: [PATCH] arm64: dts: qcom: sm8350: Use proper CPU compatibles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230706-topic-sm8350-cpu-compat-v1-1-f8d6a1869781@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFjtpmQC/x2NQQrCMBAAv1L27EJMrAa/Ih6SzWoX2iRkWxFK/
 27wOAPD7KDchBXuww6NP6JScofzaQCaQn4zSuoM1lhnbuaKa6lCqIt3o0GqG1JZaljRXqI3nse
 UrINex6CMsYVMU+/zNs9d1sYv+f53j+dx/AALzp1hfgAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688661337; l=2791;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=GNy5G2e4ewtEYejU2/KqSKUdoornsUfW/gbpWdaEdvs=;
 b=t11FWiz+JUHLRsWMF8TySNmsOWb3ZgqOKOEpei+brzyI9S/luyVr32TK3svlrh/TMIHnKyoZL
 YitrBxZtn/mBV8lEuj/mO7s5wCOc8nb8vfiFBEtSN+IhCGXDRT92mOX
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kryo names (once again) turned out to be fake. The CPUs report:

0x412fd050 (CA55 r2p0) (0 - 3)
0x411fd410 (CA78 r1p1) (4 - 6)
0x411fd440 (CX1  r1p1) (7)

Use the compatibles that reflect that.

Fixes: b7e8f433a673 ("arm64: dts: qcom: Add basic devicetree support for SM8350 SoC")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index ec451c616f3e..8ecfe84ba1b6 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -48,7 +48,7 @@ cpus {
 
 		CPU0: cpu@0 {
 			device_type = "cpu";
-			compatible = "qcom,kryo685";
+			compatible = "arm,cortex-a55";
 			reg = <0x0 0x0>;
 			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
@@ -72,7 +72,7 @@ L3_0: l3-cache {
 
 		CPU1: cpu@100 {
 			device_type = "cpu";
-			compatible = "qcom,kryo685";
+			compatible = "arm,cortex-a55";
 			reg = <0x0 0x100>;
 			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
@@ -91,7 +91,7 @@ L2_100: l2-cache {
 
 		CPU2: cpu@200 {
 			device_type = "cpu";
-			compatible = "qcom,kryo685";
+			compatible = "arm,cortex-a55";
 			reg = <0x0 0x200>;
 			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
@@ -110,7 +110,7 @@ L2_200: l2-cache {
 
 		CPU3: cpu@300 {
 			device_type = "cpu";
-			compatible = "qcom,kryo685";
+			compatible = "arm,cortex-a55";
 			reg = <0x0 0x300>;
 			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
@@ -129,7 +129,7 @@ L2_300: l2-cache {
 
 		CPU4: cpu@400 {
 			device_type = "cpu";
-			compatible = "qcom,kryo685";
+			compatible = "arm,cortex-a78";
 			reg = <0x0 0x400>;
 			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
@@ -148,7 +148,7 @@ L2_400: l2-cache {
 
 		CPU5: cpu@500 {
 			device_type = "cpu";
-			compatible = "qcom,kryo685";
+			compatible = "arm,cortex-a78";
 			reg = <0x0 0x500>;
 			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
@@ -167,7 +167,7 @@ L2_500: l2-cache {
 
 		CPU6: cpu@600 {
 			device_type = "cpu";
-			compatible = "qcom,kryo685";
+			compatible = "arm,cortex-a78";
 			reg = <0x0 0x600>;
 			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
@@ -186,7 +186,7 @@ L2_600: l2-cache {
 
 		CPU7: cpu@700 {
 			device_type = "cpu";
-			compatible = "qcom,kryo685";
+			compatible = "arm,cortex-x1";
 			reg = <0x0 0x700>;
 			clocks = <&cpufreq_hw 2>;
 			enable-method = "psci";

---
base-commit: c36ac601a98fb148147640bae219108ee81566f8
change-id: 20230706-topic-sm8350-cpu-compat-24b808e5dd23

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

