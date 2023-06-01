Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFA171982F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjFAKDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbjFAKCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:02:00 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F1F1700
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:01:01 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-3094910b150so697351f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 03:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685613660; x=1688205660;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WAx+jFDzq0c5ILkKouxlY9shq9bl0OVhOAIn/RBAyfY=;
        b=B8yhsJymQokCcMGsEIBPJ7ys9b5gK8OMUImx5g+OR1leKfOF29HgN7KHgO/dPnCa/c
         sYI0GDWJX/UnWnw3GeWang4R+34dlUCYQkNLpqnB511XkElne2Wa6WOPdObF07xQejWc
         b7eiBwoPxlFcQNVXGyN1AwrtZixGk+NR3i9iZm1apcyNCjUfIVId4s4/5Z+AmQDxiNpd
         +nexR2w4mie/uT5MSZUmneHHRsika6Pu6VH2zkDKCL/I4g0YcVtdP2pWFDGIGPlTvsaG
         vi/TLhkSJsX1jZI4ZN6+ntI+wUIbLr5ScYu1MW4FgsB7AdT8MCuoyZyREwemFSYHuCW6
         QRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685613660; x=1688205660;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAx+jFDzq0c5ILkKouxlY9shq9bl0OVhOAIn/RBAyfY=;
        b=Qalce25E1Qh/DSx0pXFN5Ad8Pm6209WDUpoh4CMvQYbRRYxnTAEAhavWNVOf2MhIk/
         WRjFouj7vMS72EwpFt8E+F3S0hjfW2m403lyJ5Dv7A8eFih23/mr08aelgpz9hND6NR9
         agdhTebXvO1MsaeQ1oHR0M9xQmv62x8fki8RVn7ZO2LpQH+O+Pg61MqBvvnss6oZcWqG
         zXdFIupX5MnltiIAjn4X3LYKQM+HAg6JCj3fNLRehxnU9dFI6evcE58FdOgrABBRDj7L
         Iggb341vKmp7RbkicKP1iN9ToSEYakIXRgoTHP4Z20RQNbMfx6TbSKVwqaP59LKkRay3
         Tjag==
X-Gm-Message-State: AC+VfDzuJeO7PkWqGOZLORTkCMiJv71s08RkXzpkBc9SB31i+d8Tup8g
        9YHEYT5AGUNELiH7JK9V9UQu7w==
X-Google-Smtp-Source: ACHHUZ6UladVjoxCSV/LuWMdKqFDJSnP9zD3rQvW9KQ2gMIYMIbxP+Jap0gSzsKL+cHCmknC/gyyJQ==
X-Received: by 2002:adf:efd1:0:b0:30a:f2a0:64fa with SMTP id i17-20020adfefd1000000b0030af2a064famr1352671wrp.10.1685613660397;
        Thu, 01 Jun 2023 03:01:00 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id l13-20020adff48d000000b003064088a94fsm9708543wro.16.2023.06.01.03.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 03:01:00 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 01 Jun 2023 12:00:55 +0200
Subject: [PATCH v3 4/4] arm64: dts: qcom: sm8550-qrd: enable PMIC Volume
 and Power buttons
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v3-4-8823ee43f3fc@linaro.org>
References: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v3-0-8823ee43f3fc@linaro.org>
In-Reply-To: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v3-0-8823ee43f3fc@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1743;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=P0dwYrh6jEzryV5sgUM7LEUfeUVDi8DDxU6r07M1UvI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkeGxXgKZcuoQctaVxpxCDkCGLakl/acAXBZ4WmFHE
 S7k22+eJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZHhsVwAKCRB33NvayMhJ0R1REA
 C+4e6Gh4ZzFbqUPPSlMNTwZHp/cTa74/JKQJ4gFffEeaeLaA5IEzs8qMvg2jT+Ed1KpIJhaOELzUcq
 iyNGb8B0JOnw1DuSC5gCLfrbo246t+MV2Xo7HLwq1xG2WGSPYjVywgNz952/Ug1v8Aat4nsoibnh7/
 cFxhPL1B5XgXO0w/aZ59k3cqWfUj+dKQBmWrnG0A2Ra3BEgirj8RJpYqWX+T83BYL8BISJ3X1GwLeH
 7lP29he7gZ7xhZEmhIBNwofNxkdEGPvr7q5Y9m9N0atmFJHd3S/0UvRyxXsO1CXTiC1xtZkYtnhmJ3
 x8El6FUEMnxh0OpzaLTTA6xSRdLG6RaEGhaPL9I7VQhBWuK4OHHgg6xrTpsHkxPfpUnrBXvQLfzuDf
 +eOeBs3mGGm4lVjxzQuktaniaY8+svYUzmjPN/MJTzplmxZFL8vTqYyZzTww3MmZRdmd7gjrQyYDp7
 mMdxFbNL0Nvpu7mYyeEtIPZfVKZDLymhdqS7gUtX3+Ys/AIJVOdhu2IoKYiykRUeb/TalOFo+Tl7n4
 inDX6eCnlsDdbqVLFLqJF7ESEQawyK7XnsJ1gGDVLivH302itOnIIbUs2S2xd0+DZmdFMnKWvMKSf2
 Gbr1ZVcZGvrT4EHhkXkpwS75fLhtkpCIRco385bgxhWpeWyKTxqFYZ7BfAYA==
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

The Volume Down & Power buttons are controlled by the PMIC via
the PON hardware, and the Volume Up is connected to a PMIC gpio.

Enable the necessary hardware and setup the GPIO state for the
Volume Up gpio key.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 36 +++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index efff15225e67..cde2ab8b18a4 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -54,6 +54,22 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-0 = <&volume_up_n>;
+		pinctrl-names = "default";
+
+		key-volume-up {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&pm8550_gpios 6 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
+	};
+
 	pmic-glink {
 		compatible = "qcom,sm8550-pmic-glink", "qcom,pmic-glink";
 		#address-cells = <1>;
@@ -516,6 +532,16 @@ led-1 {
 	};
 };
 
+&pm8550_gpios {
+	volume_up_n: volume-up-n-state {
+		pins = "gpio6";
+		function = "normal";
+		power-source = <1>;
+		bias-pull-up;
+		input-enable;
+	};
+};
+
 &pm8550_pwm {
 	status = "okay";
 
@@ -548,6 +574,16 @@ &pm8550b_eusb2_repeater {
 	vdd3-supply = <&vreg_l5b_3p1>;
 };
 
+&pon_pwrkey {
+	status = "okay";
+};
+
+&pon_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+
+	status = "okay";
+};
+
 &pcie_1_phy_aux_clk {
 	clock-frequency = <1000>;
 };

-- 
2.34.1

