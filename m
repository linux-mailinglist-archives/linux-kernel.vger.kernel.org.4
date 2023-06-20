Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65004737054
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbjFTPUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbjFTPTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:19:48 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CAC132
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:19:45 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f906d8fca3so33141845e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687274384; x=1689866384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1UGotJIVzQR71pYHANDxxn08kWq9DD0lh6dQSOfSxR4=;
        b=ixvCKRz2Bo/znJ2l8EuyDpMEVr/wYxPjGOIx2NQZycSZzpqMrBupiChAA3tmktYwEy
         wq9FHNNGthNqwHDDX0cycUquvhVpYKiSll5Ak5lnXhTiD4Ww2W1vJ8gDPhM8HwX2hy5v
         2OoGKIb5SOgZo8ZK7JGyyzyAN9h/QqCslLo80clVeGoc6AYdv5y9OIBmcd8vKDLbzGhX
         m0qBAqiFniw6y2Ha2ig/Y5BCj6zumGdEQx46ZWLT8zvS4BKHcg6FTudLZ7wtfV1TnMZk
         KOXN6jb0zvYtKpl5EpSnJAdlYFLbPEjlVzS0W3gE237x4Up4Hdo+sjPhlNgf3EHoBmm6
         8XOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687274384; x=1689866384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UGotJIVzQR71pYHANDxxn08kWq9DD0lh6dQSOfSxR4=;
        b=h2f/n29vyEMTG/5F5Qn9/fPKYtw9v1t6u7xg/1kPBFQL+89hwKWbDy8UQgRKgQtBzj
         j0WEmN3ekng/Jn/6rCDlmMFY4jDo7HeGJElkPYkOQeGNpzbil8S9/i9BwjrOl+ncWCDz
         yJ2elPyS96tgERIYmQDSuosRMGk/R2COlXCASczXTFb94zE7Q6D+HDjHubGETQ4OyPaP
         lvbvh6ZYAGwj75FgXn3w0WLAM2Csf9akrTm2upq+YPEx/tuJJJuLfUWxStbsmF3CIOzG
         54kpm12+prv+fMxKy34+hprEY/2J882XsEX2Xsa2o2G3iw+qzjwbW1Bo/1OlNEQgnsA4
         /laQ==
X-Gm-Message-State: AC+VfDzFyOkLusLbofoYgLsPIXs/e156K46EaBWXl/p8GeXVwzCa1llf
        /q3xpRmhmyc++DlGoUTXPalU6A==
X-Google-Smtp-Source: ACHHUZ5BmJEEstff1vc0D0NPQlkuS7F4L+b1fyRw36X7Qb48DIsw4R36ci9s9kpm0aigrkv9r3wT3w==
X-Received: by 2002:a1c:7703:0:b0:3f9:ba03:e87c with SMTP id t3-20020a1c7703000000b003f9ba03e87cmr742519wmi.2.1687274384095;
        Tue, 20 Jun 2023 08:19:44 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id x23-20020a05600c21d700b003f427687ba7sm2518659wmj.41.2023.06.20.08.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 08:19:43 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 20 Jun 2023 17:19:38 +0200
Subject: [PATCH 3/4] arm64: dts: qcom: sm8550: add UART14 nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-topic-sm8550-upstream-bt-v1-3-4728564f8872@linaro.org>
References: <20230620-topic-sm8550-upstream-bt-v1-0-4728564f8872@linaro.org>
In-Reply-To: <20230620-topic-sm8550-upstream-bt-v1-0-4728564f8872@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1815;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Va4r27isBs25sJPIEZ38aWK90w1x70ep0+AkoTYKvbY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkkcOK4CONe1XaV099T9h5mJcekZZOlVtdrgy0r17N
 B/6lh+2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJHDigAKCRB33NvayMhJ0ULkD/
 4pVknVxFJ/LWDimxDS4wsWY2u8Jq0/u8B8C3+B+Jksc76XSQ2ZSLDdXGE2oMTJWj4XUJYnxWAJiCDw
 pYJc0Q66O73wzMMP5IR2DruD5V3hTcRkXO5evjCVQ1fHSEDNyz/iv91/sH1J0xHbZ9vXH4Xq9PbyX4
 SdqAHcEgM5fGgodDOlYnCtifNKTcjPId8IKcrxgyUfOIxesQkesW+M6Ww8HL+cPGU9kmuNgA/ZAjnC
 w/zantSk5vtiiKGBSSz6lVxQNzxM/ICiavD7nogQYVZUjoLCOi+EW9m2vd0zu7g/fob3gFcHCHqp4I
 MsCIHcs2VC2kJcacixFCVeXzD3GGC1ALg645H5mmMkSkf9EQmYVfxEq8smtB26oqDNOM+41dQ3f/rv
 KGrfHSUW7SEC4vxi7+46xra+1/YmifRag+zvyggR89S4EJs938Bh8LhVbL2/EIU3KYWRS8CRmVwlnr
 Y+VoA1n9jcdikTCXmYFvzhuKMHQE5X+17dgb2BRwJAic+NFbWyjLvgVfY7fQVZkyc0eRnPiMEYabI7
 20C6ztTUuA1pzDgYt4ar9lFxaQYlHYpOsaLk/95KUOs8/ptQH4qMqqr92bsGdIdSmZ4DTwZsye8YwD
 wqQky4nep9uHftjVZLJalG1ozxK3blwfYoDIRUN7seSMfAbJ9JUcJ3fA2liw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Geni High Speed UART QUP instance 2 element 6
node and associated default pinctrl.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 41d60af93692..25dfc5fc5580 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1053,6 +1053,20 @@ spi13: spi@894000 {
 				status = "disabled";
 			};
 
+			uart14: uart@898000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x898000 0 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP2_S6_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart14_default>, <&qup_uart14_cts_rts>;
+				interrupts = <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
 			i2c15: i2c@89c000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x0089c000 0 0x4000>;
@@ -3471,6 +3485,22 @@ qup_uart7_default: qup-uart7-default-state {
 				bias-disable;
 			};
 
+			qup_uart14_default: qup-uart14-default-state {
+				/* TX, RX */
+				pins = "gpio78", "gpio79";
+				function = "qup2_se6";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_uart14_cts_rts: qup-uart14-cts-rts-state {
+				/* CTS, RTS */
+				pins = "gpio76", "gpio77";
+				function = "qup2_se6";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
 			sdc2_sleep: sdc2-sleep-state {
 				clk-pins {
 					pins = "sdc2_clk";

-- 
2.34.1

