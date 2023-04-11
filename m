Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD576DD421
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 09:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjDKH3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 03:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjDKH3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 03:29:04 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DA710DE
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 00:29:02 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id kh6so5443442plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 00:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681198141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaWjB1OFkYfTEHZyX0Qp1PEjyb5l7Vgp/2G5VFo8kWA=;
        b=H9ldWAgQCNm1jw5Y8V9tLSdcXNP+C1QYSKRpk3QT5gH9k8bgdJuygoPsW+7jlySckX
         b+1Q7HzNT7OcDILvVzCSjVBYzxWwajgfQ25PcIYFhEjFE1Bp3010Fl086r2MurBHyiTj
         mfcIWx9p4V/pvN7ui5gVaVo/wODmxxoULU5ABhpsXD+gnW+B9Q2h99f71lJJGnDfAQJn
         4vYVfNOVIO18w7WX9Ia0BdcivgBbdP8hf2nd5HixIuiQqzXIONGBD78qlWpPUW4G/hv9
         Zw1yJeaNC0C2Xn9s73FUxUjuBvjP6RWHeRdyzSnEoOVP5r/ijT76RAHZ6sCLwbjpc0zL
         XCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681198141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaWjB1OFkYfTEHZyX0Qp1PEjyb5l7Vgp/2G5VFo8kWA=;
        b=pLKITZ1fXY4cFpP29j/STQMBP79CSUmAmpSzPkWXIZDDG8SHmpZRQZi0WX2c1N0xqU
         jFfWgjmR6lOIzuSO6LCPsaGZ+J53genuflRNgdZ3j+7phOew7Jdp3BXbDqlBSfv/IPhR
         +Mn7/JuzAwW7NAk+pTHcTQZtJmGkI7fQXCTHPjjYt5veuiMO0p/JhPuLStLlDlTMMAMP
         2Vhmvu7XgZ1CYUJ6hxyNqZfQ2QtFwW538IrIZAIu12fd5BbkehHsrDsqqQcN2l00FZO9
         7Kl2cYKjtxQSarPjU2/klcKaouzlTSpx/LEtzeMu3Q9QedZ5/Zfyceax8eW9pc3OEQkW
         yLTQ==
X-Gm-Message-State: AAQBX9fICgZ39OMxRFGLxAslJNkvmmFjQMVESVu2PBDOijBxO+ZLJyvV
        8OgYhgWXQVdKpttYnglAjbGE5w==
X-Google-Smtp-Source: AKy350YvPqLaQqI2R0n5uZ8d7E1DWo0kp6RG9sINbiq2wp3NpGVK6U7rFCnAd8GRDucbackWZ2YM4w==
X-Received: by 2002:a17:902:cecb:b0:1a2:a904:c438 with SMTP id d11-20020a170902cecb00b001a2a904c438mr20045713plg.58.1681198141493;
        Tue, 11 Apr 2023 00:29:01 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:6a11:8ba1:beba:def7:a4ae])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b001a043e84bf0sm8946612plp.209.2023.04.11.00.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 00:29:01 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org
Subject: [PATCH v3 2/3] arm64: dts: qcom: Add base qrb4210-rb2 board dts
Date:   Tue, 11 Apr 2023 12:58:39 +0530
Message-Id: <20230411072840.2751813-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230411072840.2751813-1-bhupesh.sharma@linaro.org>
References: <20230411072840.2751813-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DTS for Qualcomm qrb4210-rb2 board which uses SM4250 SoC.

This adds debug uart, emmc, uSD and tlmm support along with
regulators found on this board.

Also defines the 'xo_board' and 'sleep_clk' frequencies for
this board.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile        |   1 +
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 223 +++++++++++++++++++++++
 2 files changed, 224 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index e0e2def48470..d42c59572ace 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -74,6 +74,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb2210-rb1.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= qrb4210-rb2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5-vision-mezzanine.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qru1000-idp.dtb
diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
new file mode 100644
index 000000000000..c9c6e3787462
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+/dts-v1/;
+
+#include "sm4250.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. QRB4210 RB2";
+	compatible = "qcom,qrb4210-rb2", "qcom,qrb4210", "qcom,sm4250";
+
+	aliases {
+		serial0 = &uart4;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&qupv3_id_0 {
+	status = "okay";
+};
+
+&rpm_requests {
+	regulators {
+		compatible = "qcom,rpm-pm6125-regulators";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+		vdd-s9-supply = <&vph_pwr>;
+		vdd-s10-supply = <&vph_pwr>;
+
+		vdd-l1-l7-l17-l18-supply = <&vreg_s6a_1p352>;
+		vdd-l2-l3-l4-supply = <&vreg_s6a_1p352>;
+		vdd-l5-l15-l19-l20-l21-l22-supply = <&vph_pwr>;
+		vdd-l6-l8-supply = <&vreg_s5a_0p848>;
+		vdd-l9-l11-supply = <&vreg_s7a_2p04>;
+		vdd-l10-l13-l14-supply = <&vreg_s7a_2p04>;
+		vdd-l12-l16-supply = <&vreg_s7a_2p04>;
+		vdd-l23-l24-supply = <&vph_pwr>;
+
+		vreg_s5a_0p848: s5 {
+			regulator-min-microvolt = <920000>;
+			regulator-max-microvolt = <1128000>;
+		};
+
+		vreg_s6a_1p352: s6 {
+			regulator-min-microvolt = <304000>;
+			regulator-max-microvolt = <1456000>;
+		};
+
+		vreg_s7a_2p04: s7 {
+			regulator-min-microvolt = <1280000>;
+			regulator-max-microvolt = <2080000>;
+		};
+
+		vreg_l1a_1p0: l1 {
+			regulator-min-microvolt = <952000>;
+			regulator-max-microvolt = <1152000>;
+		};
+
+		vreg_l4a_0p9: l4 {
+			regulator-min-microvolt = <488000>;
+			regulator-max-microvolt = <1000000>;
+		};
+
+		vreg_l5a_2p96: l5 {
+			regulator-min-microvolt = <1648000>;
+			regulator-max-microvolt = <3056000>;
+		};
+
+		vreg_l6a_0p6: l6 {
+			regulator-min-microvolt = <576000>;
+			regulator-max-microvolt = <656000>;
+		};
+
+		vreg_l7a_1p256: l7 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		vreg_l8a_0p664: l8 {
+			regulator-min-microvolt = <400000>;
+			regulator-max-microvolt = <728000>;
+		};
+
+		vreg_l9a_1p8: l9 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2000000>;
+		};
+
+		vreg_l10a_1p8: l10 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1904000>;
+		};
+
+		vreg_l11a_1p8: l11 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1952000>;
+		};
+
+		vreg_l12a_1p8: l12 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <1984000>;
+		};
+
+		vreg_l13a_1p8: l13 {
+			regulator-min-microvolt = <1504000>;
+			regulator-max-microvolt = <1952000>;
+		};
+
+		vreg_l14a_1p8: l14 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1904000>;
+		};
+
+		vreg_l15a_3p128: l15 {
+			regulator-min-microvolt = <2920000>;
+			regulator-max-microvolt = <3232000>;
+		};
+
+		vreg_l16a_1p3: l16 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1904000>;
+		};
+
+		vreg_l17a_1p3: l17 {
+			regulator-min-microvolt = <1152000>;
+			regulator-max-microvolt = <1384000>;
+		};
+
+		vreg_l18a_1p232: l18 {
+			regulator-min-microvolt = <1104000>;
+			regulator-max-microvolt = <1312000>;
+		};
+
+		vreg_l19a_1p8: l19 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		vreg_l20a_1p8: l20 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		vreg_l21a_2p704: l21 {
+			regulator-min-microvolt = <2400000>;
+			regulator-max-microvolt = <3600000>;
+		};
+
+		vreg_l22a_2p96: l22 {
+			regulator-min-microvolt = <2952000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		vreg_l23a_3p3: l23 {
+			regulator-min-microvolt = <3200000>;
+			regulator-max-microvolt = <3400000>;
+		};
+
+		vreg_l24a_2p96: l24 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <3600000>;
+		};
+	};
+};
+
+&sdhc_1 {
+	vmmc-supply = <&vreg_l24a_2p96>;
+	vqmmc-supply = <&vreg_l11a_1p8>;
+	no-sdio;
+	non-removable;
+
+	status = "okay";
+};
+
+&sdhc_2 {
+	cd-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>; /* card detect gpio */
+	vmmc-supply = <&vreg_l22a_2p96>;
+	vqmmc-supply = <&vreg_l5a_2p96>;
+	no-sdio;
+
+	status = "okay";
+};
+
+&sleep_clk {
+	clock-frequency = <32000>;
+};
+
+&tlmm {
+	gpio-reserved-ranges = <37 5>, <43 2>, <47 1>,
+			       <49 1>, <52 1>, <54 1>,
+			       <56 3>, <61 2>, <64 1>,
+			       <68 1>, <72 8>, <96 1>;
+};
+
+&uart4 {
+	status = "okay";
+};
+
+&xo_board {
+	clock-frequency = <19200000>;
+};
-- 
2.38.1

