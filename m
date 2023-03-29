Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E23F6CF35F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjC2Tma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjC2TmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:42:06 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DE776B2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:41:36 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id j11so21619722lfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 12:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680118892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7iLEkHApJGbp23LbrxSixT19rUC0QKE7QOR8WpLqmE=;
        b=IrxsTPR2t5wCfSvUD1iIOeZOucxY5MBCHz9W2GZXyGKw4eVgbBrQCOuwqiOuWiKDsY
         KWd2u22ldXmS5EP3AQb/+koqpdFrlaUPmi51jWDKi4bhfJCGdNcb08Sl9iH2tAswgE36
         XxCjPRJQ9QtoOqnCgo0GnspgfLsWNBSXb12GzV0C7ptVgImjFl9hz+76mnSqXi6FgSp/
         JKyT2WMx+vp8XpV40yOT2tp8yqmSpcGDVhKkbYIL1avjxYUEMFOz+4K+p8jeA6/jPNla
         GspaSG4c1ssXyxgkToERh/KDWG8O88SFcimpNsk8gp0+o8yvaRCKSEO0iki6laMDn8tj
         4wbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680118892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7iLEkHApJGbp23LbrxSixT19rUC0QKE7QOR8WpLqmE=;
        b=wijaR95mQ/kMgJ+6A68fTBbAUq7Lq9m4oDcbeYFBPoZp0e9m8CiRufTUME5A+n5Ngf
         dtOE8/2NePM1+1wDebP3usDEwo4Jxk55eQBAezXd/YCkHDvUDpZZJGxyPUvU1SLrSpE8
         6fLrUnaLFhL2nym9BCNkqpZG+FHzO38ZUox5Skh001aFHBhv++RUBWdvCWR0sPwbYwnr
         30paSPl1GsUD4j3OdA5aB8quOUvYjN1GhDc3hXmYmU+uLu+TLH9BnpINVRm7HCKlHdxK
         85+lz7xl2rTN8vd+1Y8uiPMotOFEKmmdW4Mj0eNcTn3CszZ6zavxmOtf+7AxX1mpR0/9
         1d9Q==
X-Gm-Message-State: AAQBX9fAxNcSCImY+qmMRhB8jOXNx/3rNdE6/G42ssBOE/YckbQJd5T3
        geTiMG1oYYCBEvzshdm6X2T6Cw==
X-Google-Smtp-Source: AKy350YVAupcMidIfhsvgKiNRv0lUOrQcyjZU1T/w0hcKTObeGv9AqUPM2FYg/qc0QtrsOJbXn9WnA==
X-Received: by 2002:ac2:43ca:0:b0:4e8:50e8:b96d with SMTP id u10-20020ac243ca000000b004e850e8b96dmr5105613lfl.39.1680118892036;
        Wed, 29 Mar 2023 12:41:32 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id q22-20020ac25296000000b004eae672e96bsm3955048lfm.255.2023.03.29.12.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 12:41:31 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 29 Mar 2023 21:41:19 +0200
Subject: [PATCH RFC v3 2/6] arm64: dts: qcom: sdm845-tama: Add Synaptics
 Touchscreen
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230313-topic-tama_disp-v3-2-2b1567c039d7@linaro.org>
References: <20230313-topic-tama_disp-v3-0-2b1567c039d7@linaro.org>
In-Reply-To: <20230313-topic-tama_disp-v3-0-2b1567c039d7@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680118888; l=3223;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=GaXhndjMG1180DXQnEAIf904gKxrsrZH1ayrtNlR+LA=;
 b=hHyRtyx7dLEzO4GnNSjexKmbgpgsIq48blw5+wK1ZDE4R+kfpr2QLrNXEVst034b4bFCxnlG5mtM
 7y7xhoQNBlKDPFqzmQHaIXFKb/EpCBG9XrYIpeXU10p2VirMMtUZ
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@somainline.org>

Add required pins and RMI4 node to the common DT and remove it
from Akatsuki, as it uses a different touch.

Since the panels are super high tech proprietary incell, they
need to be handled with very precise timings. As such the panel
driver sets up the power rails and GPIOs and the touchscreen
driver *has to* probe afterwards.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts  |  3 +
 .../boot/dts/qcom/sdm845-sony-xperia-tama.dtsi     | 68 +++++++++++++++++++++-
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
index 81cbf535cb76..5d2052a0ff69 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
@@ -7,6 +7,9 @@
 
 #include "sdm845-sony-xperia-tama.dtsi"
 
+/* XZ3 uses an Atmel touchscreen instead. */
+/delete-node/ &touchscreen;
+
 / {
 	model = "Sony Xperia XZ3";
 	compatible = "sony,akatsuki-row", "qcom,sdm845";
diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
index 3c7d129d9d8e..8172d0c9c1a3 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
@@ -402,10 +402,42 @@ &gcc {
 };
 
 &i2c5 {
-	status = "okay";
 	clock-frequency = <400000>;
+	status = "okay";
+
+	touchscreen: touchscreen@2c {
+		compatible = "syna,rmi4-i2c";
+		reg = <0x2c>;
+
+		interrupts-extended = <&tlmm 125 IRQ_TYPE_EDGE_FALLING>;
+		vdd-supply = <&vreg_l14a_1p8>;
+		/*
+		 * This is a blatant abuse of OF, but the panel driver *needs*
+		 * to probe first, as the power/gpio switching needs to be precisely
+		 * timed in order for both the display and touch panel to function properly.
+		 */
+		incell-supply = <&panel>;
+
+		syna,reset-delay-ms = <220>;
+		syna,startup-delay-ms = <1000>;
+
+		pinctrl-0 = <&ts_default>;
+		pinctrl-1 = <&ts_sleep>;
+		pinctrl-names = "default", "sleep";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rmi4-f01@1 {
+			reg = <0x01>;
+			syna,nosleep-mode = <1>;
+		};
 
-	/* Synaptics touchscreen @ 2c, 3c */
+		rmi4-f12@12 {
+			reg = <0x12>;
+			syna,sensor-type = <1>;
+		};
+	};
 };
 
 &i2c10 {
@@ -558,6 +590,38 @@ sde_te_active_sleep: sde-te-active-sleep-state {
 		drive-strength = <2>;
 		bias-pull-down;
 	};
+
+	ts_default: ts-default-state {
+		reset-pins {
+			pins = "gpio99";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		int-pins {
+			pins = "gpio125";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	ts_sleep: ts-sleep-state {
+		reset-pins {
+			pins = "gpio99";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+
+		int-pins {
+			pins = "gpio125";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-down;
+		};
+	};
 };
 
 &uart6 {

-- 
2.40.0

