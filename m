Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E9A66D086
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 21:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjAPUtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 15:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbjAPUsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 15:48:09 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBF12B0A7;
        Mon, 16 Jan 2023 12:48:03 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r30so4204023wrr.10;
        Mon, 16 Jan 2023 12:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gHYbEHk7x0AQF5tWEHmiPPkrwDt5VCVfTOA5gUxyCog=;
        b=pJ+NrAECI3mgnYgLTuDMXHzOSiPXhsCOldaEUxtnPYnbcXjNjdBsBxvIMlUi9dnAKv
         OTVzTNNzc/udP3siydFYFz5ockc4JiSAuWLGUhGp0lua0Cc0iX5nVBahHeg8Bhc58+kI
         1bY3qaXKSaWxdyhHFcLyhzV9of2XRyYeS7q7rzT660dp9l1bCO2WmLPA0uhtfy+RxkRn
         gXXePa6sf1SWskWZkuqvBpzEExeTKJoHWsGszO1XiPpwZH600WAISHAYprGknm+dSNeh
         fkBROYeFBpQ38j1JppWZ1NddNB6X5bd33mF5bmuKwcZwQwpGJLW4F235bfQrgtuTDNkH
         5WTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHYbEHk7x0AQF5tWEHmiPPkrwDt5VCVfTOA5gUxyCog=;
        b=LcOJWDmZzxrYx1kyBc6ZJyOmIQZUkLC2fv4Ef8bbzIrQt9i0V1qoxDiAZ/A8D8fkLx
         voYha4g5F3RV/Uxt6L40f/mZEskH8dBjGX3Ou/YIx/JGoVN/CLUebRFosz0L5j0qkqq3
         vty50sdM2G06RzujpBMRimhnkH96tP9ZwqMGagJVZpiSKaOHPl/NETkOTmY0rS1nF4wa
         OwyTKY3uAQwHiqZ7CuHj/4DHgznccMx7Oe8Q5BOm2emaMMC8/04SGzub6dVJ0ZtfnRcB
         mFDxTbcuaPEJcVbxKA59HpcQChQbMmy6CaxAqy2RbTflTGELwKRv+ZT2XExoOmsigRRi
         6DMw==
X-Gm-Message-State: AFqh2kq6EWBDFtjABWoM8N5tM+W2Jn/+upIgZQXAVXvgMHuXP7MAvSsh
        Cwv0czZ+EcyRaVk5o14tzZk=
X-Google-Smtp-Source: AMrXdXs3EIWIMChxb8Voiqphze6JchVgMgGnukzDx96rXbRQq/CVNgEIzGj0DKhFvEH9fcNkXKuOPA==
X-Received: by 2002:a5d:4309:0:b0:2bd:d7e5:82fd with SMTP id h9-20020a5d4309000000b002bdd7e582fdmr8128393wrq.15.1673902082178;
        Mon, 16 Jan 2023 12:48:02 -0800 (PST)
Received: from localhost.localdomain (93-34-92-88.ip49.fastwebnet.it. [93.34.92.88])
        by smtp.googlemail.com with ESMTPSA id k18-20020adfb352000000b00241fab5a296sm27785372wrd.40.2023.01.16.12.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 12:48:01 -0800 (PST)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v7 4/7] ARM: dts: qcom: add per SoC compatible for qcom,kpss-gcc nodes
Date:   Mon, 16 Jan 2023 21:47:48 +0100
Message-Id: <20230116204751.23045-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230116204751.23045-1-ansuelsmth@gmail.com>
References: <20230116204751.23045-1-ansuelsmth@gmail.com>
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

Add per Soc compatible for qcom,kpss-gcc nodes. While currently not used
by the kpss driver they can serve further customization and they are
required to be defined per Documentation schema.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 2 +-
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 2 +-
 arch/arm/boot/dts/qcom-mdm9615.dtsi | 2 +-
 arch/arm/boot/dts/qcom-msm8660.dtsi | 2 +-
 arch/arm/boot/dts/qcom-msm8960.dtsi | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 1f3e0aa9ab0c..7065f6e88dcf 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -880,7 +880,7 @@ mmcc: clock-controller@4000000 {
 		};
 
 		l2cc: clock-controller@2011000 {
-			compatible = "qcom,kpss-gcc", "syscon";
+			compatible = "qcom,kpss-gcc-apq8064", "qcom,kpss-gcc", "syscon";
 			reg = <0x2011000 0x1000>;
 		};
 
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 7e784b0995da..bd0728c57eab 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -570,7 +570,7 @@ IRQ_TYPE_EDGE_RISING)>,
 		};
 
 		l2cc: clock-controller@2011000 {
-			compatible = "qcom,kpss-gcc", "syscon";
+			compatible = "qcom,kpss-gcc-ipq8064", "qcom,kpss-gcc", "syscon";
 			reg = <0x02011000 0x1000>;
 			clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
 			clock-names = "pll8_vote", "pxo";
diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
index b0fe1d95d88f..61dfec3b9037 100644
--- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
@@ -116,7 +116,7 @@ lcc: clock-controller@28000000 {
 		};
 
 		l2cc: clock-controller@2011000 {
-			compatible = "qcom,kpss-gcc", "syscon";
+			compatible = "qcom,kpss-gcc-mdm9615", "qcom,kpss-gcc", "syscon";
 			reg = <0x02011000 0x1000>;
 		};
 
diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index 86f76d0feff4..f601b40ebcf4 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -473,7 +473,7 @@ pm8058_led133: led@133 {
 		};
 
 		l2cc: clock-controller@2082000 {
-			compatible = "qcom,kpss-gcc", "syscon";
+			compatible = "qcom,kpss-gcc-msm8660", "qcom,kpss-gcc", "syscon";
 			reg = <0x02082000 0x1000>;
 		};
 
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 7debf9db7cb1..2dd90e57929a 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -183,7 +183,7 @@ clock-controller@4000000 {
 		};
 
 		l2cc: clock-controller@2011000 {
-			compatible = "qcom,kpss-gcc", "syscon";
+			compatible = "qcom,kpss-gcc-msm8960", "qcom,kpss-gcc", "syscon";
 			reg = <0x2011000 0x1000>;
 		};
 
-- 
2.37.2

