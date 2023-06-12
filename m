Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C3F72C9D9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbjFLPXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239558AbjFLPXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:23:02 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9582E62
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:23:00 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f611ac39c5so5460110e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686583379; x=1689175379;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EhLfMSXbxmp9qPPD3GeAKDBquiRljuGLX+U4KtK6EsU=;
        b=YYk+sHkqZLrUAqkjPzOTTU/vQvt6iIh0XGNtwBnGTrSwlkkQj6AEhrL4SjFb3emcbc
         U31C3k3naWKXXj03AH0y9XWT1U/QNX2LQJT59IqTmT1ST/g3uHyKE6DEBN0oubj/CaiA
         P6cfufUT09EI4V5v8UoqWY3Ys2QoHkCfVMnfz8PZGd1mFFjoGGEgYImhDMLFAVcT6Ug7
         qFu3qJ/p/PpZOnq5S615OgIhprPxz/lRAOdBSXkTBqxNi7BcD910XVktiaog/Q+Ju5JY
         hy9PbMpJJBCQFbBqUkDBSNMomHc8WbtRSFL+hX/+HTzoy9zF5zSRZRDMZVfnd3ZhBgeq
         vcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686583379; x=1689175379;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhLfMSXbxmp9qPPD3GeAKDBquiRljuGLX+U4KtK6EsU=;
        b=TxNnE/PVcR58MLDy9fWIO6YXnqU0Yd+7KQIKrs/BrXtj/DaE03F87oaYELn6GJu0/O
         XRPd2YXniLC+KHRLBujrOMGTAA56c6x/hrsrw7oacNZUj+tPbtjuq+fXCrf9dSARixJ4
         VNfeekd7qUReyWrIUeeHSVOK8C/kIc4LY8vHOapLVnajjubpMGfNLpvqh5nnkyhmKjqW
         IejQtTwTQCBsedBqXtr0RRlSubs9cVQINtF3LvAajfLG6WU6L8ZJJwMWUFGdPvT1pgjH
         hW1Y3m496NKXA0zT3yqVjJhezLtVP3ArWBkLHXv6iYnY1r2LTcaXYAmerkl9bCrYT56U
         uuZA==
X-Gm-Message-State: AC+VfDwg6uTeCUDUwDTG//MWZDrUbkMtj4v27MVnY9LvSJj/cmxK0DB8
        uKyDed//aoyLb0UhcVxmWI3AGQ==
X-Google-Smtp-Source: ACHHUZ5Vhvj8DgKg4Nbd9TBfptQm+tNTykB+GYGGsbuhTzZn4t6o/OOuHLNe8x/a5KcrkUK1ZLCsMg==
X-Received: by 2002:a19:6d1c:0:b0:4ef:fb4b:eb2d with SMTP id i28-20020a196d1c000000b004effb4beb2dmr3905314lfc.33.1686583378816;
        Mon, 12 Jun 2023 08:22:58 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l7-20020a7bc347000000b003f4248dcfcbsm11876512wmj.30.2023.06.12.08.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:22:58 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 12 Jun 2023 17:22:50 +0200
Subject: [PATCH v4 2/4] arm64: dts: qcom: sm8550-qrd: add notification RGB
 LED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v4-2-a288f24af81b@linaro.org>
References: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v4-0-a288f24af81b@linaro.org>
In-Reply-To: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v4-0-a288f24af81b@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=jI2H0I/73ntY355iZoJ/p4DoFxC9y+9WLIkumJL3rCc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkhzhNMcLxPhr9R4/++ZdERjmaOgBXRNl+YcLjLt5s
 gidDZCuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIc4TQAKCRB33NvayMhJ0fH9D/
 9rxfLGUlYnBKHcaeTakEME2VFBAl8reC1s9JkIBzrKAtKBOsKlMPJ2KDQ/53OpGUSO0WFsKtqhfG0w
 0rhqC5G1LzButFVrf4nCxZB9BgZiW/oWZ4ZM5wlxOtFpuL5wm+XWznkSX8p++GbSaZyinLq+OJ0/9v
 Sw9YSeT6FLZW4hPurMuOnoe1+NkViuveoOdBY40fu3X3zVkHMh7uXUsHUNd6c2inDGgtW0D87Afh2e
 omVWhuYHUNPVxKDlI2Zamu26c2Q7SmuR7GxIWuB8+JYreB+n8angsiX2cNz9k2FmsZOtz/+qVHK17T
 W9Eak5HKeUzdPM5vA3gkBQgJMc6vjZbDiWfCENH4GbKBRi96JislUSvh3Fe6lcAUk+p0lMoLypreyc
 FlMJTAZ59vzKMITIQ/ZvoFJDKO0FME1MmEkIucfNVArAT4A9ZzsWAdEm6vJGuA0m0XqnzBJYRofRdp
 8AWUnKNZIUEJmdIMpDgDJ2NJj1qrHgwCW41FB6ydCMynBXsrUpSj/Rfno9yN8c0HPpIYUTQ+CINIpA
 5sKQ/RPkt7tA/ril+6Pry1jwRp5FR1fQTdYZoskvX+fZNZDoPKNETOCf+qzEfxm2ilCXJV60iTWk67
 KxTNOuS5F9ZMdjUE3ycfF4zNXFc4KkZNOmf+NJ24VfkoUXoLyg3IfOooRWmQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QRD features a notification LED connected to the pm8550.
Configure the RGB led controlled by the PMIC PWM controller.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index 8669d29144bb..efff15225e67 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -516,6 +516,33 @@ led-1 {
 	};
 };
 
+&pm8550_pwm {
+	status = "okay";
+
+	multi-led {
+		color = <LED_COLOR_ID_RGB>;
+		function = LED_FUNCTION_STATUS;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@1 {
+			reg = <1>;
+			color = <LED_COLOR_ID_RED>;
+		};
+
+		led@2 {
+			reg = <2>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		led@3 {
+			reg = <3>;
+			color = <LED_COLOR_ID_BLUE>;
+		};
+	};
+};
+
 &pm8550b_eusb2_repeater {
 	vdd18-supply = <&vreg_l15b_1p8>;
 	vdd3-supply = <&vreg_l5b_3p1>;

-- 
2.34.1

