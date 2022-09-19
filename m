Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90625BD481
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 20:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiISSHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 14:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiISSHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 14:07:21 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F218446600;
        Mon, 19 Sep 2022 11:06:54 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id h130-20020a1c2188000000b003b4cadadce7so3935872wmh.3;
        Mon, 19 Sep 2022 11:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=uv5yxjHWeGx+AJdbwQSqj4Y1uDvP+yaBUQDlqTuyNZA=;
        b=I6BAx6U2zm10wBKyL1BFpAb6OfD8y61z8c69Dy4dFPGkE9msxcZMlFNkHFm+TlqfAS
         9UKkny8dogVNIPzQP9R9mq9YlLrkyhDVCgskyb0sPjjsMkkfbPUxpouWapsKj937uwHp
         nbM9h2vFRexOGw0b7JP3AgFakOt77MJag4CSJ60yguVGfDQavJd9O76xPTjgbrcq+QUw
         RKhyxAHLLY4WV35qnvEKHbyOmuiMG3id8SWJiocgZLMKhm1xlgw+Bw7HbYrqbAjQTGMR
         C47zDo+vN0MwEirmUX5z6XUOANOhRZ0VJHKxmZMy77w4BK7MfBUlAWdxTdPY1BqJf3m9
         F5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=uv5yxjHWeGx+AJdbwQSqj4Y1uDvP+yaBUQDlqTuyNZA=;
        b=rwMwyta+VpYBtHqM0MZ2zTN6mrUbzLr1SXqIIdtiVaB9BEbJqOLnYDB0VX2xyAVvo9
         zb8rDUHiT8en2PQoXTRhHxjIcUCIVtZKUxKLliScUggJ96DWbfHPVNPSYmg0amG7zhep
         UQY92phI6GCZwQLfGQNzrLJ7gEjqcZVNDgg2eTeti8KSEuCSl4nXvvGCissrqDahocKF
         n10JUIdUEwL8Ux4Ntpr64igKIiYnfi3YFPju9RJU5BZZjRvyxZTef3rbC0eMdXc6NC7o
         kTh96dGeSMCBlXv8yUgG2PE2Ea2ob5QdxfdyLF5F65tbADV0+HHXruosFQz/Y+xkSppX
         bIVg==
X-Gm-Message-State: ACrzQf0YbGP+XZVxXMg19Sp6Uv3sq4p5yjGcXI9fAnC0ktnJzoGBz2LG
        rgaHeU1vOwKMo8BHCe4doGA=
X-Google-Smtp-Source: AMsMyM4PReTywtWunIeOFMI0KmAyMIImk1H2iypB4z+I83MZ7JOfRcAVjQvzJtBZvb2floc0Os6sPg==
X-Received: by 2002:a05:600c:3506:b0:3b4:c086:fa37 with SMTP id h6-20020a05600c350600b003b4c086fa37mr10735538wmq.165.1663610813348;
        Mon, 19 Sep 2022 11:06:53 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id m2-20020a5d6242000000b00228df23bd51sm14487524wrv.82.2022.09.19.11.06.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 11:06:52 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 8/8] arm64: dts: qcom: sm4250: Add support for oneplus-billie2
Date:   Mon, 19 Sep 2022 21:06:18 +0300
Message-Id: <20220919180618.1840194-9-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220919180618.1840194-1-iskren.chernev@gmail.com>
References: <20220919180618.1840194-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support for OnePlus Nord N100, based on SM4250. Currently
working:
- boots
- usb
- built-in flash storage (UFS)
- SD card reader

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/sm4250-oneplus-billie2.dts  | 241 ++++++++++++++++++
 2 files changed, 242 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index d7669a7cee9f..2656ef21b943 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -139,6 +139,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-polaris.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-shift-axolotl.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-lenovo-yoga-c630.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm850-samsung-w737.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm4250-oneplus-billie2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6125-sony-xperia-seine-pdx201.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm6350-sony-xperia-lena-pdx213.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm7225-fairphone-fp4.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
new file mode 100644
index 000000000000..a3f1c7c41fd7
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (c) 2021, Iskren Chernev <iskren.chernev@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "sm4250.dtsi"
+
+/ {
+	model = "OnePlus Nord N100";
+	compatible = "oneplus,billie2", "qcom,sm4250";
+
+	/* required for bootloader to select correct board */
+	qcom,msm-id = <0x1a1 0x10000 0x1bc 0x10000>;
+	qcom,board-id = <0x1000b 0x00>;
+
+	aliases {
+	};
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		stdout-path = "framebuffer0";
+
+		framebuffer0: framebuffer@9d400000 {
+			compatible = "simple-framebuffer";
+			reg = <0 0x5c000000 0 (1600 * 720 * 4)>;
+			width = <720>;
+			height = <1600>;
+			stride = <(720 * 4)>;
+			format = "a8r8g8b8";
+		};
+	};
+};
+
+&reserved_memory {
+	bootloader_log_mem: memory@5fff7000 {
+		reg = <0x0 0x5fff7000 0x0 0x8000>;
+		no-map;
+	};
+
+	ramoops@cbe00000 {
+		compatible = "ramoops";
+		reg = <0x0 0xcbe00000 0x0 0x400000>;
+		record-size = <0x40000>;
+		pmsg-size = <0x200000>;
+		console-size = <0x40000>;
+		ftrace-size = <0x40000>;
+	};
+
+	param_mem: memory@cc200000 {
+		reg = <0x0 0xcc200000 0x0 0x100000>;
+		no-map;
+	};
+
+	mtp_mem: memory@cc300000 {
+		reg = <0x00 0xcc300000 0x00 0xb00000>;
+		no-map;
+	};
+};
+
+&rpm_requests {
+	regulators-0 {
+		compatible = "qcom,rpm-pm6125-regulators";
+
+		vreg_s6a: s6 {
+			regulator-min-microvolt = <320000>;
+			regulator-max-microvolt = <1456000>;
+		};
+
+		vreg_s7a: s7 {
+			regulator-min-microvolt = <1280000>;
+			regulator-max-microvolt = <2040000>;
+		};
+
+		vreg_s8a: s8 {
+			regulator-min-microvolt = <1064000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		vreg_l1a: l1 {
+			regulator-min-microvolt = <952000>;
+			regulator-max-microvolt = <1152000>;
+		};
+
+		vreg_l4a: l4 {
+			regulator-min-microvolt = <488000>;
+			regulator-max-microvolt = <1000000>;
+		};
+
+		vreg_l5a: l5 {
+			regulator-min-microvolt = <1648000>;
+			regulator-max-microvolt = <3056000>;
+		};
+
+		vreg_l6a: l6 {
+			regulator-min-microvolt = <576000>;
+			regulator-max-microvolt = <656000>;
+		};
+
+		vreg_l7a: l7 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		vreg_l8a: l8 {
+			regulator-min-microvolt = <400000>;
+			regulator-max-microvolt = <728000>;
+		};
+
+		vreg_l9a: l9 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2000000>;
+		};
+
+		vreg_l10a: l10 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1904000>;
+		};
+
+		vreg_l11a: l11 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1952000>;
+		};
+
+		vreg_l12a: l12 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <1984000>;
+		};
+
+		vreg_l13a: l13 {
+			regulator-min-microvolt = <1504000>;
+			regulator-max-microvolt = <1952000>;
+		};
+
+		vreg_l14a: l14 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1904000>;
+		};
+
+		vreg_l15a: l15 {
+			regulator-min-microvolt = <2920000>;
+			regulator-max-microvolt = <3232000>;
+		};
+
+		vreg_l16a: l16 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1904000>;
+		};
+
+		vreg_l17a: l17 {
+			regulator-min-microvolt = <1152000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		vreg_l18a: l18 {
+			regulator-min-microvolt = <1104000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		vreg_l19a: l19 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		vreg_l20a: l20 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		vreg_l21a: l21 {
+			regulator-min-microvolt = <2400000>;
+			regulator-max-microvolt = <3544000>;
+		};
+
+		vreg_l22a: l22 {
+			regulator-min-microvolt = <2952000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		vreg_l23a: l23 {
+			regulator-min-microvolt = <3296000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		vreg_l24a: l24 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <3544000>;
+		};
+	};
+};
+
+&sleep_clk {
+	clock-frequency = <32764>;
+};
+
+&sdhc_2 {
+	vmmc-supply = <&vreg_l22a>;
+	vqmmc-supply = <&vreg_l5a>;
+
+	cd-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
+
+	status = "okay";
+};
+
+&tlmm {
+	gpio-reserved-ranges = <14 4>;
+};
+
+&ufs_mem_hc {
+	vcc-supply = <&vreg_l24a>;
+	vcc-max-microamp = <600000>;
+	vccq2-supply = <&vreg_l11a>;
+	vccq2-max-microamp = <600000>;
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&vreg_l4a>;
+	vdda-pll-supply = <&vreg_l12a>;
+	vddp-ref-clk-supply = <&vreg_l18a>;
+	status = "okay";
+};
+
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_hsphy {
+	vdd-supply = <&vreg_l4a>;
+	vdda-pll-supply = <&vreg_l12a>;
+	vdda-phy-dpdm-supply = <&vreg_l15a>;
+	status = "okay";
+};
+
+&xo_board {
+	clock-frequency = <19200000>;
+};
-- 
2.37.3

