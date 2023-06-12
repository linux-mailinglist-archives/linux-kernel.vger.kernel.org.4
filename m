Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700C172C9DB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbjFLPXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239591AbjFLPXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:23:03 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A376E47
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:23:02 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f61530506aso46525575e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 08:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686583380; x=1689175380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WAx+jFDzq0c5ILkKouxlY9shq9bl0OVhOAIn/RBAyfY=;
        b=bHb7Symg0rQIegprCdL9hClajqxkyCLVkO8yd6YMl544HVuJDm9FkzvlSqZwE2DTE7
         FdfqDwSbVFl35AU+Fp9Ek8uKuv0spygR6J2J3wyyW/y3Dmde9ydc7SGF7F2lOmJq+oWB
         U1P9Wa+F5CufwolDDg7CAcFuICDc9wYubIcmqMGmhzAVUX7x2okKbb+u1P8OA4i3p+x4
         uZzC+RQSng9Vpa20JGnFobHNda3QWbIv7jnj7ss9jakTjhUettvJ4oS4X3PUPyrj9hhu
         jPehVAbAdK27yBnCU4Vua1YQsOHAr12JyveHu3mgnA+Nt+QevbLKVNN9avla4nu3jXmb
         uABg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686583380; x=1689175380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAx+jFDzq0c5ILkKouxlY9shq9bl0OVhOAIn/RBAyfY=;
        b=XdxrNmGPvcnAoukG5iIOrMWRLxmjI2bbMD8JjLW1s3EIhKF8JLq9OGv4Lj6/lQ2ITu
         AEx7f2fKDt80IDT0d54c48148/g2s/NtqHDUGUF0dxvKZmT5t5OmEs2b7CfkN90tFmAT
         IHvhhqjJzGGi8ZOEJ+e/TOSZxmHoJ5qdC+vzzWmYqE9Lg49Kb63Y37jglBT6anUtLh2N
         idoON33zKzzIt9DCIkn0XtFKXy1wl0SbhqffbLOtVe+R4VSMR9EnNZBh3kIHIIPIrwO/
         aNEviiNsYDh0gXA0DVrmyyPwfyJawJlxIYmHg4IRhMr67K3ZkmQTvka7M4abnEuAdew4
         Dgaw==
X-Gm-Message-State: AC+VfDw9PKeFQ1/EDtFa0yFgmCbEoghhbLD+FAinXtuRvgAzufdArO4u
        5TsPuoioZbjx8bI/G0rcR2Gr2w==
X-Google-Smtp-Source: ACHHUZ5NZh8m+HZUAL5ezDwKqtfXid7/K6BTGtz51tVmUwpdcc7Yi5FLdgqlcs8kh3M6Xx7/VcgfeA==
X-Received: by 2002:a05:600c:255:b0:3f6:53a:6665 with SMTP id 21-20020a05600c025500b003f6053a6665mr8009706wmj.19.1686583380568;
        Mon, 12 Jun 2023 08:23:00 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l7-20020a7bc347000000b003f4248dcfcbsm11876512wmj.30.2023.06.12.08.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:23:00 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 12 Jun 2023 17:22:52 +0200
Subject: [PATCH v4 4/4] arm64: dts: qcom: sm8550-qrd: enable PMIC Volume
 and Power buttons
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v4-4-a288f24af81b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1743;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=P0dwYrh6jEzryV5sgUM7LEUfeUVDi8DDxU6r07M1UvI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkhzhPuakSM42Wy6Ev4n9uOUrag+FYZH4hwvJQfaSX
 oIlYOvCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIc4TwAKCRB33NvayMhJ0VxUEA
 DPUf/S0BF8srWj+h4SJdYUGoonic4CoOeuPWG9guNxVOhzmBIK1DT/+SDW9TbMPGqrAhWKLBFx1RoQ
 kLj2W3JozIkFtdBUemFcyoGxtubOL+7q+o6T6Jht7ifnr1LtNFu6BFrzvzOwqEKY7pU8+tN0NtQV/+
 rjaPbY9VIzCXWbnggefgUBzEy/P18zAVYlI9MeBIlsSjBe9dQcDb0eQIJHQRfEBLYmP6Yp4diEuiXd
 LoepsMzHScwpRVlAzngkNWYuIeYaoWKM8cw1hvIUZI5+8msTOi4l9k09z38PkJTgPaSqDjapiUER6N
 sYZ9TK0TeZw5lnVuEfrmzujxNnkksMIBz2SiHjrDFmTPe9r7E2ilSn94YoKpjkjlK/jC19/7y65D3W
 EkPa0fb+KlBo0n0EzF9BgPlFMwFAdWdLMgnc7TT8nAO4AJL5CBUqiYM1WfWYhbwctW88UZpI1Jr/r9
 qe0JULUiWJbWp24ImQ3i46M8A2z8tN7UjlZnf3sm4H2l6OMoynhRSfDL5wgXYR9gbbU+mURsTfqEjJ
 YwYqUdSypbUo+1RUvfMeEPMf+DmTbUXNQCbXGasEdDOg1is8huV8Q0pUFMUzFA+fUnnovDK4iN0NkP
 x32AVH2KHqoXCIgGDPwgGFKtRKR133rr6/4hISnq5kGsQZl1J6Z+zcCzeYJA==
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

