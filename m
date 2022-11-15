Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0BB629D77
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiKOP3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238214AbiKOP2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:28:10 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C042DAB1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:27:51 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ud5so36949750ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vg8NC6M8db0CO7+c1/ONSYumm0SUtSfLgSyiNkD+2X8=;
        b=KMv9NkjCZaMovl0v85MLOAMCKNnmtqMrpiIeNHOoLfEf0HeCc223B+vmdN+0r29d5u
         SpKG5X4hvF5LjCbd1ck6S6glJPJzaAJ5qijH2WO2ZC/4zXuJml9SSc3V1FJD8Y2NkDHv
         /z0YUvakxTNipvi6Vn0i39mRGLuGVgeH1CcQmLS8UjB8A9x4rFANdjiSXp9lGHaReUPh
         02u67QxhlJfDvzi83MJ87beJ9fIGFskSCq5R3dekH3IdmqKslqupxlUZ1NKl4k1kIjQ0
         0HZdHUlu/4n2PnbjFxtnWjE3HymsAsr96xCBiwFwG+MbjAzoQ0CKaglGR1azocJky/Q0
         9X8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vg8NC6M8db0CO7+c1/ONSYumm0SUtSfLgSyiNkD+2X8=;
        b=nprQYQgUpaZzc1/SKEVpqVPjSVBn2r2YvdBx/etsq6XJgfkzcV+S63w4x2IM70eopk
         9nX7aV6dOmJkPYz7CcDumBrxjpJ6migCZgsWw/LYW+1H5Q+DkskkiXtEV+t8MdpuvJ8j
         Lq4FEc+7cNZolVNUYI0KrsfmEoc5a/Cxmy8VNM4wwczJO4U9+BX8S4YKdX2zoG6TEugP
         x7bqQkiHlg6lrhTZ3rzlo2R8OL/8IHJ9jGTGOQO1NtDBOfxJdgEa9LhAWpCsXjdoACkf
         JtjVyutfRoK/IQoShTZ23qTejG4ebVQXeS4y8q1R7BYztbdQNmEhoHGkCCv38PmZnSul
         2nqw==
X-Gm-Message-State: ANoB5pkTCdh9UwXgyKjtJQtHEhFIoJJfNb8RI5ENPG2qWFES4gce4ZGz
        nZ/GhSshDgqsGIflNcW/sfwba2qgJBrvOMhn
X-Google-Smtp-Source: AA0mqf4NvmLzHSD1ba0I4817Mame5s4HpOlUb7W2psN02aQ6LkrQW0I0YeOlY4yRLNH+W+BUPIjnAw==
X-Received: by 2002:a17:906:c1cc:b0:781:f54c:1947 with SMTP id bw12-20020a170906c1cc00b00781f54c1947mr14712594ejb.69.1668526070647;
        Tue, 15 Nov 2022 07:27:50 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id ku21-20020a170907789500b007ae1ab8f887sm5750679ejc.14.2022.11.15.07.27.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Nov 2022 07:27:50 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/9] arm64: dts: qcom: sm6375-pdx225: Configure SMD RPM regulators
Date:   Tue, 15 Nov 2022 16:27:26 +0100
Message-Id: <20221115152727.9736-9-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221115152727.9736-1-konrad.dybcio@linaro.org>
References: <20221115152727.9736-1-konrad.dybcio@linaro.org>
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

Configure regulators present on the Xperia 10 IV that are reachable
via SMD RPM.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../qcom/sm6375-sony-xperia-murray-pdx225.dts | 182 ++++++++++++++++++
 1 file changed, 182 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
index c830124cb483..0f1ddfa28c89 100644
--- a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
+++ b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
@@ -106,6 +106,188 @@ &qupv3_id_1 {
 	status = "okay";
 };
 
+&rpm_requests {
+	regulators-0 {
+		compatible = "qcom,rpm-pm6125-regulators";
+
+		pm6125_s5: s5 {
+			regulator-min-microvolt = <382000>;
+			regulator-max-microvolt = <1120000>;
+		};
+
+		pm6125_s6: s6 {
+			regulator-min-microvolt = <320000>;
+			regulator-max-microvolt = <1374000>;
+		};
+
+		pm6125_s7: s7 {
+			regulator-min-microvolt = <1574000>;
+			regulator-max-microvolt = <2040000>;
+		};
+
+		/*
+		 * S8 is VDD_GFX
+		 * L1 is VDD_LPI_CX
+		 */
+
+		pm6125_l2: l2 {
+			regulator-min-microvolt = <1170000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		pm6125_l3: l3 {
+			regulator-min-microvolt = <1100000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		pm6125_l4: l4 {
+			regulator-min-microvolt = <1100000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		pm6125_l5: l5 {
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <3050000>;
+		};
+
+		pm6125_l6: l6 {
+			regulator-min-microvolt = <1080000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		pm6125_l7: l7 {
+			regulator-min-microvolt = <720000>;
+			regulator-max-microvolt = <1050000>;
+		};
+
+		pm6125_l8: l8 {
+			regulator-min-microvolt = <1100000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		pm6125_l9: l9 {
+			regulator-min-microvolt = <1504000>;
+			regulator-max-microvolt = <2000000>;
+		};
+
+		pm6125_l10: l10 {
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <1980000>;
+		};
+
+		pm6125_l11: l11 {
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <1980000>;
+		};
+
+		pm6125_l12: l12 {
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <2000000>;
+		};
+
+		pm6125_l13: l13 {
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <1980000>;
+		};
+
+		pm6125_l14: l14 {
+			regulator-min-microvolt = <1700000>;
+			regulator-max-microvolt = <1900000>;
+		};
+
+		pm6125_l15: l15 {
+			regulator-min-microvolt = <1650000>;
+			regulator-max-microvolt = <3544000>;
+		};
+
+		pm6125_l16: l16 {
+			regulator-min-microvolt = <1620000>;
+			regulator-max-microvolt = <1980000>;
+		};
+
+		/* L17 is VDD_LPI_MX */
+
+		pm6125_l18: l18 {
+			regulator-min-microvolt = <830000>;
+			regulator-max-microvolt = <920000>;
+		};
+
+		pm6125_l19: l19 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		pm6125_l20: l20 {
+			regulator-min-microvolt = <1624000>;
+			regulator-max-microvolt = <3304000>;
+		};
+
+		pm6125_l21: l21 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3400000>;
+		};
+
+		pm6125_l22: l22 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <3544000>;
+		};
+
+		pm6125_l23: l23 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3400000>;
+		};
+
+		pm6125_l24: l24 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <3544000>;
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,rpm-pmr735a-regulators";
+
+		/*
+		 * S1 is VDD_MX
+		 * S2 is VDD_CX
+		 */
+
+		pmr735a_l1: l1 {
+			regulator-min-microvolt = <570000>;
+			regulator-max-microvolt = <650000>;
+		};
+
+		pmr735a_l2: l2 {
+			regulator-min-microvolt = <352000>;
+			regulator-max-microvolt = <796000>;
+		};
+
+		pmr735a_l3: l3 {
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pmr735a_l4: l4 {
+			regulator-min-microvolt = <1504000>;
+			regulator-max-microvolt = <2000000>;
+		};
+
+		pmr735a_l5: l5 {
+			regulator-min-microvolt = <751000>;
+			regulator-max-microvolt = <824000>;
+		};
+
+		pmr735a_l6: l6 {
+			regulator-min-microvolt = <504000>;
+			regulator-max-microvolt = <868000>;
+		};
+
+		pmr735a_l7: l7 {
+			regulator-min-microvolt = <2700000>;
+			regulator-max-microvolt = <3544000>;
+		};
+	};
+};
+
 &tlmm {
 	gpio-reserved-ranges = <13 4>;
 };
-- 
2.38.1

