Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEDA627ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236505AbiKNKnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236298AbiKNKmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:42:46 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148381F61F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:42:45 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id u11so12550630ljk.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8ClIYh0V6nqYf4lc4Knu97ZlNglR4NFcQeCr/Q4wUQ=;
        b=Yb1Qo1ybWlZmUEuvg51cE7IrqDhXp5/wvziMcZleADkk54+jb68lAX4qKVbwmij7Yw
         AgxmTdQDG2Lojo7xCW/sU2fM6fQXOXB1OOEKmMuEh53iOsEey04Q5tQ3QlaYn0Ee7gj7
         zJX9Rkc7JTQliJs7gQT0uDi0yPvQxrpTry4b9GLkr0lsVzTTgR3J7e/eWypVQri18sDF
         pTFsJkEOLypGnLeTI5J3L7OEJwNxatzvL/n9qQiA8mOc4p57N359lVogrwPIYz0P2WEO
         2v1QqqY8I93yTWcDWOJrC5gkGDRMPUxsYF4AfhKfgltHGta2xyOPqxQ2j3VzdmTgWZ7G
         kYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8ClIYh0V6nqYf4lc4Knu97ZlNglR4NFcQeCr/Q4wUQ=;
        b=BYcOHLFajypICnxAZcAK6ZQNiSd9m7qx+cW8pHJe+328xjCtJTJIwfCBYtKPpugJ4m
         cFiEnl6QT3mQUEq5x/chGWm7Mc3oEfHgQeV6g090SNavHX8Eo+O1A/03QErBwIeyW0a1
         pAUjF8V9jjvKElgw72f1ZU1fwgGVXlyzhtYUqnxHFvwpbuv5383jybT82nGENCcjt36g
         mhYr2u0+L2k9LHrNtYVuysJY4yzZKXY5zvgpdABvBHJNMOVBRSUYWEy3ljviImEbAzzi
         +ZYk1I6zJjYNObbaBMgDe1JAuXezkVTDsJmvrw+9c7rfSPCkFlGZS2ULLUyf/7eLZVik
         K57w==
X-Gm-Message-State: ANoB5pkXQIDBqzeSJUKalTen6u0ZSGxB+OJHmZo7E7Rz4c2OgKy94nzu
        PSErcm8wgC0Org4JQIBCkJjZ+g==
X-Google-Smtp-Source: AA0mqf51PYor2dnF+qLJRKtOIT69OYNs9hf0nUlQqPIaMdsFDMjpfcscefIQEuZY7nxWlIezpWB1/Q==
X-Received: by 2002:a2e:a602:0:b0:277:8a07:521c with SMTP id v2-20020a2ea602000000b002778a07521cmr3660235ljp.335.1668422564668;
        Mon, 14 Nov 2022 02:42:44 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id bs21-20020a05651c195500b0026c4e922fb2sm1946486ljb.48.2022.11.14.02.42.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Nov 2022 02:42:44 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/9] arm64: dts: qcom: sm6375-pdx225: Configure SMD RPM regulators
Date:   Mon, 14 Nov 2022 11:42:21 +0100
Message-Id: <20221114104222.36329-9-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221114104222.36329-1-konrad.dybcio@linaro.org>
References: <20221114104222.36329-1-konrad.dybcio@linaro.org>
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

Configure regulators present on the Xperia 10 IV that are reachable
via SMD RPM.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes since v1:
- sort the node properly (alphabet is hard, I know..)

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

