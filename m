Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0E1710FEE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241830AbjEYPsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241820AbjEYPrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:47:48 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC3C195
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:47:47 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30a892c45c4so1549712f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 08:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685029665; x=1687621665;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ybWMPvjAbxDd9m2vKZKs3PZRB9H9wahkXT4YhpmdacM=;
        b=wTKV2Go+f+i+Mjt9tLkmgVbheb9bl7s5B+NU0V884RUjTJ1Peu8qCewYshoz4bLdeO
         YAH4u9vIY76b7ACHvViyhuyKafwq4km9pATlhQC7Wy/KRylXi3YTLBQFb08obpDkievz
         g4aqV5Vo4LMYp73b12lbC3rMg6SPBXuVvvPjMzMmv1cmuWP2e0Ogoe7I3s3D84Ofi7I3
         Id0/CAyu/YDljXpJLMd0JQBn5Hl1ZPOs9IXtyUORwV0Typz+eLLnQMSzupcevvB3Tljr
         CRKn/g41mGhugIuUKHXO2eut8Xq2TKij2+tXMdrZoOo/IqlRI2eZFmAuf3NpK5zsmoTj
         VyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685029665; x=1687621665;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybWMPvjAbxDd9m2vKZKs3PZRB9H9wahkXT4YhpmdacM=;
        b=Ahx87mMHYw98F/Aw7s1IuKE2Oc32JmJvWkgltq9LaiVd9tinja3zmto/3waSd9VAE3
         cZzopcEws2MGM4mUvL3XdDmzobv18FM+H2fYpiW9lolTBK93LKrhmCkwvkflGLIwJiVL
         9ULz2hfi+r/8uGu/C0shSUw9iYUsEIMY9HrqZhYyews0lXDwiHLa5MmoVF7npNg0rfEC
         6iRpZoMhYTV1/I4COXOVSZcoiGEFuXEwGyL503NJRj0s4j4BGh2gwb1qNA7AqT+L6pJq
         BreISmsVKiS7mq+Pa3jmQScYq3GBAn38ebm1q9RZPh8UWCoVw79spMI6hfpzDdsIaOB3
         7RNw==
X-Gm-Message-State: AC+VfDzZBvf8l7UA/kpqUCKsGOVMti+U4RCsetd7HPwmVdvcjCpbYAeJ
        CM4sPbHiL2bte9MMiH51rUaANA==
X-Google-Smtp-Source: ACHHUZ7ZCJwFJNGBcjmp/qsvw/hxlfVQohGvKbPq7HJoGe6uwtY9e849NyhdSHgLji0XW0cxExFJgw==
X-Received: by 2002:adf:f84c:0:b0:306:4550:f651 with SMTP id d12-20020adff84c000000b003064550f651mr2993014wrq.4.1685029665561;
        Thu, 25 May 2023 08:47:45 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id b3-20020a5d5503000000b002ca864b807csm2275873wrv.0.2023.05.25.08.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 08:47:45 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 25 May 2023 17:47:38 +0200
Subject: [PATCH 4/4] arm64: dts: qcom: sm8550-qrd: enable PMIC Volume and
 Power buttons
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v1-4-4d5d7602f290@linaro.org>
References: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v1-0-4d5d7602f290@linaro.org>
In-Reply-To: <20230525-topic-sm8550-upstream-pm8550-lpg-dt-v1-0-4d5d7602f290@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1644;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=CPwrvAAyt2H/9JeM32XZW/DCLHS5cCNgZqPt32wie4c=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkb4McVl877G51/dYVZUu5+kB0HIGxU3xcvMSUXnRk
 YVdr7ieJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZG+DHAAKCRB33NvayMhJ0b/9EA
 C5gOeMPObiEOchFROcde0PWpDIzUiz31zaz+XzjLDuNbRyKMC5GgG995WvagBO8Ecx+YVELW+MNz1l
 joEuSjUD65+dIz3NCsj7FTSjyUxSzL+k1zX2yuVmfMpwuseDwCiHgRo6w4toyYmDEdVOvKlxl39hL+
 Dt8yMpr4MIldKMcAKoEctTFfiM4fX6Sdve53AgCT9txIdbVDaIkj9ZSHmna8o1Ewq8lrMr4KyQ4RGu
 ZVVOQYLbwUyIp9t9ARVyV2I6DQhSh5N74GA/c2JtYEU1XyPeBvxSvVvmKEL2YfTar1IAodB9xJKw9C
 Q9IrJ2+8o7+hA36JDARzzVZQERFmf/dkVM3thZOGMoTLbp6P10HU/TnRbi3k+fv4c+16wcnX+hPU4S
 rLdNV2d53DJcgujXG5oiX3mdlUlxn6Z++QP9rznRjS2gdBFEl9KSTtviavYl4eMndGIEBSp++kDeyF
 RMslZcqDEVtpUAT8FrR4UAM35Oa6e5BJba2k1PdDO+0r2z7jQ5gtIKgiUOJHuwfElJe2GnJuM/vE4x
 GmTRIBcAl8b1hZmgB4sC4rDE9ZUg0RRcxA7N9YFTOVxULSr1bCWSM22q9Ect9yJ9RPxB+Elttm4NDX
 yzpXW3VVVUtljXEN/YY33HgKmkNzdKaMx016cffsINRfSlwLlsfJpXrh8VaA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Volume Down & Power buttons are controlled by the PMIC via
the PON hardware, and the Volume Up is connected to a PMIC gpio.

Enable the necessary hardware and setup the GPIO state for the
Volume Up gpio key.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 36 +++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index b08a8201ad23..c354dcc12621 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -28,6 +28,22 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&volume_up_n>;
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
@@ -426,6 +442,16 @@ &pcie0_phy {
 	status = "okay";
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
 &pm8550_flash {
 	status = "okay";
 
@@ -450,6 +476,16 @@ led-1 {
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
 

-- 
2.34.1

