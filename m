Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67B56BBE76
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbjCOVDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjCOVDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:03:21 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2A81A657
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 14:02:58 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so3576368pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 14:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678914122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S14JZW/mvZHlpfHEi1OqjqpgTyEM748UnmZyTclyoNY=;
        b=uqPiBy2HFzWo59DAokxhSRQupAoiIZu30to9CxpCXlS7pxpQ1Kz+5j52eO6wrQPDlh
         zB1dVoDVGlZtetCiwIf9A07nJKiVKUNFML4hUvIfWSeOpj5C3uzrYBsBule1dMEfoHWb
         RfOGwDCDfeJsMkgeE3L/NqClNP4tbAyj5NTcbfdZ+VDIoky7hysVqHLblAZzuPpwUTwh
         LxsmH+BW9YkhUcH0jDmuYEez8uuqdDB1zubMx0USpkGdKKKqvUgaD9DvLJPN2NccWSRt
         QXokwNTDfyuonO3DEk+xWEiaF0oIgCiielPtjxppn8fWPgBdupdgM/NfpNzIpBdT0E7a
         sZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678914122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S14JZW/mvZHlpfHEi1OqjqpgTyEM748UnmZyTclyoNY=;
        b=A3c7i5K7x6FDJC2GlK0qDTPsMUXs9RgCwiAfoNgggLx5zXKsU0ymQehSuFPOmafWLC
         +9U57Y1vqnpHmHqgsXJw3VWlRFpPGiDDetVUdiuLgqIa0E+AFNb09UMnGEXyDSCYq7az
         9OuJpqqva9DzUSD7dAKf1kdik2iP1TWpl0KHYagaMQAVb9g2mZlxcVaTd5lWegBe0Jd1
         ec06huNYBJjT6AKAVXeVNLgRgsLiNGJPaKaaYFkf0LQ3jM0L/M2/122FoOwiXZm/J0y3
         APBbix7bS2J9VIDjWAktR9NG4PHH17/gIa8oQMBZthAuEJH+qBPmtyWk5o+tUMJBRCe2
         ySrA==
X-Gm-Message-State: AO0yUKWrekVkAKmB78zOO1juBfdza0Zzkr1GY2Sq/M4dU20rgL38jCLe
        g+HTHV5BC29onujZumC0MyZTew==
X-Google-Smtp-Source: AK7set/e8wcFyRdBr0RdzDOi8yXqKAO/9jeArtAh1FWjx+bVIB2ezzvLJB1XnpL0rQl0NmSN9cZ2Lg==
X-Received: by 2002:a17:903:124d:b0:19e:7a2c:78a7 with SMTP id u13-20020a170903124d00b0019e7a2c78a7mr898343plh.57.1678914122325;
        Wed, 15 Mar 2023 14:02:02 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c61:1acb:9af6:bd7f:78e7:7ae6])
        by smtp.gmail.com with ESMTPSA id 10-20020a170902c14a00b0019a91895cdfsm4066498plj.50.2023.03.15.14.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 14:02:02 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org
Subject: [PATCH v2 2/2] arm64: dts: qcom: Add base qrb4210-rb2 board dts
Date:   Thu, 16 Mar 2023 02:31:45 +0530
Message-Id: <20230315210145.2221116-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230315210145.2221116-1-bhupesh.sharma@linaro.org>
References: <20230315210145.2221116-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 224 +++++++++++++++++++++++
 2 files changed, 225 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 89e23a74bc7f..101ac733422c 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -69,6 +69,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-xiaomi-sagit.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qdu1000-idp.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= qrb4210-rb2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5-vision-mezzanine.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qru1000-idp.dtb
diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
new file mode 100644
index 000000000000..c70c532ba721
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -0,0 +1,224 @@
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
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2960000>;
+		};
+
+		vreg_l21a_2p704: l21 {
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2960000>;
+		};
+
+		vreg_l22a_2p96: l22 {
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2960000>;
+		};
+
+		vreg_l23a_3p3: l23 {
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2960000>;
+		};
+
+		vreg_l24a_2p96: l24 {
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2960000>;
+		};
+	};
+};
+
+&sdhc_1 {
+	status = "okay";
+
+	vmmc-supply = <&vreg_l24a_2p96>;
+	vqmmc-supply = <&vreg_l11a_1p8>;
+	no-sdio;
+	non-removable;
+};
+
+&sdhc_2 {
+	status = "okay";
+
+	cd-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>; /* card detect gpio */
+	vmmc-supply = <&vreg_l22a_2p96>;
+	vqmmc-supply = <&vreg_l5a_2p96>;
+	no-sdio;
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

