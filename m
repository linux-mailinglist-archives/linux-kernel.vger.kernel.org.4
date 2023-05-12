Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0607009B4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 15:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241415AbjELN7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 09:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241351AbjELN7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 09:59:05 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2134213C3E
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:58:58 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-965ddb2093bso1444984166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 06:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1683899936; x=1686491936;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uD3Ipvt0NExfmILEv8OKGxIPIOoFOtued5pY1YUMvaA=;
        b=ZPbUlqd510c1ym+w8AeWysEGsU8WE4AvhtiRwFFFnqVDALOh+khbiSvxLg23oSyqZb
         m23j7QATGuiB4u5f77wUiSITvARRigOD9JS+B/tkoTq68F3Xv8HSx5C+8gufqCGb2jjJ
         vfVjzyKT6UxdFfWKSp5p+ftUI4XHKVG3wf6dHJVycvhQkMEdGfMDVCKE6Q9hO5a7wwr4
         faAyGH3z4UyfAob0fREEEbsUpcUmp5EOxCWdfKQsqY0Pp9kfi8jdZs0uKlY7pUej7IV6
         GEgNxH+Bh2Ib7LWsorTTtcuvaEnZz+D04+udrmhsU1TW+sJBVVAmAn82d6dQyBoArZ56
         biYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683899936; x=1686491936;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uD3Ipvt0NExfmILEv8OKGxIPIOoFOtued5pY1YUMvaA=;
        b=fiC6MHHESZdZh20FvcTgDJjlTejSdz9ZtD0JWZ0J0IZ7eA4UaKmb5nlYPpp8fr+WV2
         DwfsroJThwmhl1UG78mnIkFMtffMff5DkNYJmFctNDbt1vZCmSdOLfE5xuUcKx07yCmU
         ev5t1OsUtukPDZiNIQF4+FwOjZ5IyL3t446sftAa40Iz/t8rcMjtsolOrST7PS7qO9VB
         GkM++XTAcCBxEa7kk2lfKkvLl4F0jr/N/sqd90G+lQfb/LIv7hPmDgwGWHN7t0nBAUVi
         tPytFjDeruho7q4DJ7ULX4mDZCtJXWjF7yqvYxIhy7BiRVMzgI7tRcvt7GHfKtwD4n2T
         p4FQ==
X-Gm-Message-State: AC+VfDxTt968i/KEEISXDbNgI8HMY4A9mL1lA+IawngLDxO8siBd75/S
        9Un2Hpv5ElIDZ5/rZUAgHU8BXw==
X-Google-Smtp-Source: ACHHUZ5NT+vNCm97DRq7kbKwyyr5lRuNUHvWe9eNLgCczj2xQoRRAEPi7wrQRonSYKHmEGpAR8uEog==
X-Received: by 2002:a17:907:9347:b0:933:3814:e0f4 with SMTP id bv7-20020a170907934700b009333814e0f4mr23139917ejc.16.1683899936411;
        Fri, 12 May 2023 06:58:56 -0700 (PDT)
Received: from [172.16.240.113] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id mc27-20020a170906eb5b00b00966330021e9sm5399061ejb.47.2023.05.12.06.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 06:58:55 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 12 May 2023 15:58:26 +0200
Subject: [PATCH v2 4/4] arm64: dts: qcom: sm7225-fairphone-fp4: Add
 Bluetooth
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230421-fp4-bluetooth-v2-4-3de840d5483e@fairphone.com>
References: <20230421-fp4-bluetooth-v2-0-3de840d5483e@fairphone.com>
In-Reply-To: <20230421-fp4-bluetooth-v2-0-3de840d5483e@fairphone.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device has a WCN3988 chip for WiFi and Bluetooth. Configure the
Bluetooth node and enable the UART it is connected to, plus the
necessary pinctrl that has been borrowed with comments from
sc7280-idp.dtsi.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 103 ++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index 7ae6aba5d2ec..e3dc49951523 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -31,6 +31,7 @@ / {
 
 	aliases {
 		serial0 = &uart9;
+		serial1 = &uart1;
 	};
 
 	chosen {
@@ -524,6 +525,39 @@ adc-chan@644 {
 	};
 };
 
+&qup_uart1_cts {
+	/*
+	 * Configure a bias-bus-hold on CTS to lower power
+	 * usage when Bluetooth is turned off. Bus hold will
+	 * maintain a low power state regardless of whether
+	 * the Bluetooth module drives the pin in either
+	 * direction or leaves the pin fully unpowered.
+	 */
+	bias-bus-hold;
+};
+
+&qup_uart1_rts {
+	/* We'll drive RTS, so no pull */
+	drive-strength = <2>;
+	bias-disable;
+};
+
+&qup_uart1_rx {
+	/*
+	 * Configure a pull-up on RX. This is needed to avoid
+	 * garbage data when the TX pin of the Bluetooth module is
+	 * in tri-state (module powered off or not driving the
+	 * signal yet).
+	 */
+	bias-pull-up;
+};
+
+&qup_uart1_tx {
+	/* We'll drive TX, so no pull */
+	drive-strength = <2>;
+	bias-disable;
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -561,6 +595,75 @@ &sdhc_2 {
 
 &tlmm {
 	gpio-reserved-ranges = <13 4>, <56 2>;
+
+	qup_uart1_sleep_cts: qup-uart1-sleep-cts-state {
+		pins = "gpio61";
+		function = "gpio";
+		/*
+		 * Configure a bias-bus-hold on CTS to lower power
+		 * usage when Bluetooth is turned off. Bus hold will
+		 * maintain a low power state regardless of whether
+		 * the Bluetooth module drives the pin in either
+		 * direction or leaves the pin fully unpowered.
+		 */
+		bias-bus-hold;
+	};
+
+	qup_uart1_sleep_rts: qup-uart1-sleep-rts-state {
+		pins = "gpio62";
+		function = "gpio";
+		/*
+		 * Configure pull-down on RTS. As RTS is active low
+		 * signal, pull it low to indicate the BT SoC that it
+		 * can wakeup the system anytime from suspend state by
+		 * pulling RX low (by sending wakeup bytes).
+		 */
+		bias-pull-down;
+	};
+
+	qup_uart1_sleep_rx: qup-uart1-sleep-rx-state {
+		pins = "gpio64";
+		function = "gpio";
+		/*
+		 * Configure a pull-up on RX. This is needed to avoid
+		 * garbage data when the TX pin of the Bluetooth module
+		 * is floating which may cause spurious wakeups.
+		 */
+		bias-pull-up;
+	};
+
+	qup_uart1_sleep_tx: qup-uart1-sleep-tx-state {
+		pins = "gpio63";
+		function = "gpio";
+		/*
+		 * Configure pull-up on TX when it isn't actively driven
+		 * to prevent BT SoC from receiving garbage during sleep.
+		 */
+		bias-pull-up;
+	};
+};
+
+&uart1 {
+	/delete-property/ interrupts;
+	interrupts-extended = <&intc GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>,
+			      <&tlmm 64 IRQ_TYPE_EDGE_FALLING>;
+
+	pinctrl-names = "default", "sleep";
+	pinctrl-1 = <&qup_uart1_sleep_cts>, <&qup_uart1_sleep_rts>, <&qup_uart1_sleep_tx>, <&qup_uart1_sleep_rx>;
+
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn3988-bt";
+
+		vddio-supply = <&vreg_l11a>;
+		vddxo-supply = <&vreg_l7a>;
+		vddrf-supply = <&vreg_l2e>;
+		vddch0-supply = <&vreg_l10e>;
+		swctrl-gpios = <&tlmm 69 GPIO_ACTIVE_HIGH>;
+
+		max-speed = <3200000>;
+	};
 };
 
 &uart9 {

-- 
2.40.1

