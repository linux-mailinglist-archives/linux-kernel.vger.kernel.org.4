Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE7E600C57
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 12:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiJQKXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 06:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiJQKXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:23:16 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E83C5FDE8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:23:14 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j7so17746365wrr.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 03:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DpV/qCEWf/oxdA4ww51qfQjnCUWo3HbkpcM9BvV5fno=;
        b=os1RfSXZtHCkU6GI6uXXkcEXJfLtaPZhkfLfPfmPyIMNVxXNjQy5ta95vojoukfmsC
         G7KsJEO7XAv1guEoNs582HHYPf5Axn2VB/Nj1ktY5ocPtwwDs35xQfvPw6WoV2Jx1KgC
         /BKr1Q322PFVBS8X0NgOW3ck8bPt6L5GGiBhpoI2hAIt3vW1g93q+RB3J10ZvK0vALLE
         cDri5ua3+X1UaRh+Bwvuy/wMRnsfUU9UJAiy9ZUb25ATHLH1aqyYFXv3RFep96rbq6nt
         TLg9v6E5D00RsriKmySXPT/sR7KWEke9DDTpcBoE59b0eEq8ZRUfQEGsYhD/SX3PgURU
         Bo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpV/qCEWf/oxdA4ww51qfQjnCUWo3HbkpcM9BvV5fno=;
        b=SUEb9QJM/iCRjq2SFgm3J9Xy3KyhN28sCrKZDD9+8zWDRFXowmQEfabzHpKy2Bqf3p
         xm7MEFnZfEsDoFTHMKdOEhliZ+i/Q+sAkEFgXRAd0dXsmAt5usdhYv8w8oSRMX9YcSde
         7QAxKuyN5eoaGuG/FyYbT3bjDYEYT10f5k9UfemhWLrs1BllH5Y8OWkfufa+YxxGZbL7
         kn3swOheOeZvypytoziAPACY2GJasmx/36rA0/9Fu/yCAzlqaAVQrxtsln2AN0YDNdRr
         oYXZ8iJu/r4BvTzSa18rtBhJU7RWZlsjBoZje7MOnxcg7T8+loSab5/dtqKS1dFrgDFw
         Ig9g==
X-Gm-Message-State: ACrzQf2ZqtMaw3L/BdIwzoVYRetR9Bti3En9QZLrLrzhz5D2snudQ5DU
        Xc6fuU0nZq+10SujeaEK/8Cj4g==
X-Google-Smtp-Source: AMsMyM6b39tiyV1LOE66pb8hnBuR0GHG0bwPbwGUkCiaGC+vdy4rgkQZqGJMiEQF479pvYc1CmgSxw==
X-Received: by 2002:a5d:584a:0:b0:231:636c:de28 with SMTP id i10-20020a5d584a000000b00231636cde28mr5875835wrf.175.1666002193007;
        Mon, 17 Oct 2022 03:23:13 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003b4fe03c881sm15590707wmq.48.2022.10.17.03.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 03:23:12 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 17 Oct 2022 12:23:07 +0200
Subject: [PATCH v2 3/5] arm: dts: qcom: mdm9615: wp8548-mangoh-green: fix sx150xq
 node names and probe-reset property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mdm9615-pinctrl-yaml-v2-3-639fe67a04be@linaro.org>
References: <20221005-mdm9615-pinctrl-yaml-v2-0-639fe67a04be@linaro.org>
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v2-0-639fe67a04be@linaro.org>
To:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        devicetree@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the sx150xq node names to pinctrl and use the right probe-reset property.

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts b/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
index 30a110984597..a8304769b509 100644
--- a/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
+++ b/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
@@ -116,7 +116,7 @@ i2c@4 {
 			#size-cells = <0>;
 			reg = <4>;
 
-			gpioext0: gpio@3e {
+			gpioext0: pinctrl@3e {
 				/* GPIO Expander 0 Mapping :
 				 * - 0: ARDUINO_RESET_Level shift
 				 * - 1: BattChrgr_PG_N
@@ -142,7 +142,7 @@ gpioext0: gpio@3e {
 				interrupt-parent = <&gpioext1>;
 				interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
 
-				probe-reset;
+				semtech,probe-reset;
 
 				gpio-controller;
 				interrupt-controller;
@@ -154,7 +154,7 @@ i2c@5 {
 			#size-cells = <0>;
 			reg = <5>;
 
-			gpioext1: gpio@3f {
+			gpioext1: pinctrl@3f {
 				/* GPIO Expander 1 Mapping :
 				 * - 0: GPIOEXP_INT1
 				 * - 1: Battery detect
@@ -183,7 +183,7 @@ gpioext1: gpio@3f {
 				interrupt-parent = <&msmgpio>;
 				interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
 
-				probe-reset;
+				semtech,probe-reset;
 
 				gpio-controller;
 				interrupt-controller;
@@ -195,7 +195,7 @@ i2c@6 {
 			#size-cells = <0>;
 			reg = <6>;
 
-			gpioext2: gpio@70 {
+			gpioext2: pinctrl@70 {
 				/* GPIO Expander 2 Mapping :
 				 * - 0: USB_HUB_INTn
 				 * - 1: HUB_CONNECT
@@ -221,7 +221,7 @@ gpioext2: gpio@70 {
 				interrupt-parent = <&gpioext1>;
 				interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
 
-				probe-reset;
+				semtech,probe-reset;
 
 				gpio-controller;
 				interrupt-controller;

-- 
b4 0.10.1
