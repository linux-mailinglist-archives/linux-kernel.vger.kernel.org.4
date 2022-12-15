Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6CD64E3E5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 23:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiLOWqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 17:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiLOWp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 17:45:58 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B367413F90
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 14:45:56 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id x11so405716ilo.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 14:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7CZ2EBCo0xYEovV/05sNJzYR16hADn5kVh9KkAARs/k=;
        b=x1EKv81x/3zfu9V6uyYNl/SQqVouSk+UJpdqo3Oq1nq3+bYK4y1/cxelf/Kygm1YQM
         9mUISnkvpzlPP2jHWr/JbUFwGIiQzrWj0te+1QJGcRBHAcL+E96WXrdcLsaU0XJzCFcq
         pEFYru7/Mj4udz19j+rqNNr227dIhKqVc2GYmQb4zpyCwJ02ndVRKsNGtRuSe8OZLkA+
         VRpeJ4piCQltm11Af9MyWpuLz43Tyluo4SNHDqwmQJSJzBMTQUCQU44m6znTkqTLBAoL
         i7kInRCknVs/jR2KpQWtDsdk2PLHY/rNc1cBL1VnacMPxzn7IkL/3euVByfLp6/kLJsk
         5aSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7CZ2EBCo0xYEovV/05sNJzYR16hADn5kVh9KkAARs/k=;
        b=3ig1uPLE6a8PBDq3qFx9AP80t/y9fCzOzGMyjX7iqsojGLAVsUv944SuBlcl9UQTj6
         xq1OSGNzV5kTM/OJKcDM8hyG/LkSqvUST01JFkoAwwM/H+yfGdF+AYZlKG9oB4NlxLux
         wBD+U4g0bo2wN+4b2OJo93t/2905gKcefUiLtTQnKmdyWpvF0WH3mTQdspK2cq9q3gOT
         UtkhmXJsYl2Uw4F6LUeRymA4JnvaYTUdi0UxsFlpAvC1bJg8ip7nAOz9sdpyidALyxLB
         4fv5myBtGg3XPI0xjvFdF78eMciSNj/Rt+32iWN+sm+qJRgkJ3d6cpOP1OdfAcSGxlRz
         cXpg==
X-Gm-Message-State: ANoB5pkol/SAYCrrBRkz8OVSMlMIS3KdgNyBOiGzjLowp4qu8+UXWA/2
        ln+d4Hi1KG0xMEubNGrNFLl8ng==
X-Google-Smtp-Source: AA0mqf52xsULVw+BOtQr6mDp3WEcaTpKZBi3MtA79cAMrji1R+o2I9qDZw2jiCUHTxpMxOcd8gYPnA==
X-Received: by 2002:a05:6e02:1d96:b0:303:85e0:1ff6 with SMTP id h22-20020a056e021d9600b0030385e01ff6mr26237258ila.6.1671144355916;
        Thu, 15 Dec 2022 14:45:55 -0800 (PST)
Received: from localhost.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id e24-20020a02a798000000b00374cd28d842sm186101jaj.104.2022.12.15.14.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 14:45:55 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, agross@kernel.org
Cc:     quic_sibis@quicinc.com, elder@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: qcom: sc7280: enable IPA in sc7280-herobrine-lte-sku.dtsi
Date:   Thu, 15 Dec 2022 16:45:52 -0600
Message-Id: <20221215224552.1232449-1-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPA is only needed on a platform if it includes a modem, and not all
SC7280 SoC variants do.  The file "sc7280-herobrine-lte-sku.dtsi" is
used to encapsulate definitions related to Chrome OS SC7280 devices
where a modem is present, and that's the proper place for the IPA
node to be enabled.

Currently IPA is enabled in "sc7280-idp.dtsi", which is included by
DTS files for Qualcomm reference platforms (all of which include the
modem).  That also includes "sc7280-herobrine-lte-sku.dtsi", so
enabling IPA there would make it unnecessary for "sc7280-idp.dtsi"
to enable it.

The only other place IPA is enabled is "sc7280-qcard.dtsi".
That file is included only by "sc7280-herobrine.dtsi", which
is (eventually) included only by these top-level DTS files:
  sc7280-herobrine-crd.dts
  sc7280-herobrine-herobrine-r1.dts
  sc7280-herobrine-evoker.dts
  sc7280-herobrine-evoker-lte.dts
  sc7280-herobrine-villager-r0.dts
  sc7280-herobrine-villager-r1.dts
  sc7280-herobrine-villager-r1-lte.dts
All of but two of these include "sc7280-herobrine-lte-sku.dtsi", and
for those cases, enabling IPA there means there is no need for it to
be enabled in "sc7280-qcard.dtsi".

The two remaining cases will no longer enable IPA as a result of
this change:
  sc7280-herobrine-evoker.dts
  sc7280-herobrine-villager-r1.dts
Both of these have "lte" counterparts, and are meant to represent
board variants that do *not* have a modem.

This is exactly the desired configuration.

Signed-off-by: Alex Elder <elder@linaro.org>
Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>
Tested-by: Sibi Sankar <quic_sibis@quicinc.com>
---
v2:  Moved &ipa node update earlier, and status property to end

 arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi | 5 +++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi               | 5 -----
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi             | 5 -----
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
index ad66e5e9db4ed..c5309b25d0860 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
@@ -20,6 +20,11 @@ mba_mem: memory@9c700000 {
 	};
 };
 
+&ipa {
+	modem-init;
+	status = "okay";
+};
+
 &remoteproc_mpss {
 	compatible = "qcom,sc7280-mss-pil";
 	iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index f7efb9966afd1..0ddbe7f732bd9 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -376,11 +376,6 @@ &gpi_dma1 {
 	status = "okay";
 };
 
-&ipa {
-	status = "okay";
-	modem-init;
-};
-
 &lpass_cpu {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index df49564ae6dc1..cd6ee84b36fd4 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -336,11 +336,6 @@ vreg_bob: bob {
 
 /* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
 
-&ipa {
-	status = "okay";
-	modem-init;
-};
-
 &lpass_va_macro {
 	vdd-micb-supply = <&vreg_bob>;
 };
-- 
2.34.1

