Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DB8629D62
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238119AbiKOP1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237900AbiKOP1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:27:44 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325172D764
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:27:43 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ud5so36948677ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pye56l5tV+PFr5V02s5kVYgOc0gcJFpQaxO9onF9KkY=;
        b=rQyKdD+GzORugh864rhM3Czk2kviguv9s6CNctmtSalawYYsBoapCU90qOk1vew/7z
         dXcYLhlHfz2fpPjK12LQ+aend3qPWrrrw8UqhWjs6Y7vrc4rbGStWGQ0AZZUI4cf4YJ2
         bSIJSb7Yz63Zr49XapuNXVBqjaFMROMEj4E+VG6Qkupe91CR45uUF37mz6GOVWc6+Z44
         PRA7Xv806lz2vuxT7xYP46qoIzwDpVlvnTteSQYBdN7CA7Jh11YDrZ8IoZM4RQekCLkK
         TGLn7ue6LFeHlrmLhSeRCvMd8AgDEcutfh6tJD4NZdHqub23NB+09/eVAnWr1/9xbWsR
         ixEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pye56l5tV+PFr5V02s5kVYgOc0gcJFpQaxO9onF9KkY=;
        b=2l24t7imLFdKFit5QafkoGf7bEQASg7SSrpCgJX0i/yhRVYOte3nU4ZKwIyY2cyPZg
         NGec4WpdZwQA2bZIE4Zaowdx08Gg7nO/rE7L9bFJ+iiW2DPUZlhIm+UYXmjefOUND7Gn
         qdb+x8d5Mc6Cd1sUvF89y9B2fcGHuNg+4rlgBO6zlAz9ctgT72ieLB7ZeNIAYj7GTxft
         Mo0YhY41iJeAllPcY7A6Bwn0WdcIvuklTHwhlC7VgYetb1JLYSayL95uxTnBSkmpEk49
         J95iT4+BT591fvTJpbNrccMnJ+hyv1yrj+QY8tEr6j9mmQ0+ftYgs+Utahoqqa5aG3iW
         Fn5A==
X-Gm-Message-State: ANoB5pnZwj66cHwWOiVV4k+PQsmOY5ekXEmeVK3tFjGUbBvaGU+6WuDi
        AFI1zYPYDinwmlM947E6RWp6hQ==
X-Google-Smtp-Source: AA0mqf5g2Cvr2pqIfwGW+WUUYbfrne8p6hHBvAQ1ckrYjfZylMisJUdQeYzv8WCF6kOSilBqM22Oqw==
X-Received: by 2002:a17:906:6c8b:b0:78d:b6f7:53c0 with SMTP id s11-20020a1709066c8b00b0078db6f753c0mr14899794ejr.527.1668526061797;
        Tue, 15 Nov 2022 07:27:41 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id ku21-20020a170907789500b007ae1ab8f887sm5750679ejc.14.2022.11.15.07.27.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Nov 2022 07:27:41 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/9] arm64: dts: qcom: sm6375: Add GPI DMA nodes
Date:   Tue, 15 Nov 2022 16:27:21 +0100
Message-Id: <20221115152727.9736-4-konrad.dybcio@linaro.org>
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

Add nodes for GPI DMA hosts on SM6375.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 40 ++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 9b1a497e5ca7..62a64dd731a0 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -567,6 +567,46 @@ rpm_msg_ram: sram@45f0000 {
 			reg = <0 0x045f0000 0 0x7000>;
 		};
 
+		gpi_dma0: dma-controller@4a00000 {
+			compatible = "qcom,sm6375-gpi-dma", "qcom,sm6350-gpi-dma";
+			reg = <0 0x04a00000 0 0x60000>;
+			interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>;
+			dma-channels = <10>;
+			dma-channel-mask = <0x1f>;
+			iommus = <&apps_smmu 0x16 0x0>;
+			#dma-cells = <3>;
+			status = "disabled";
+		};
+
+		gpi_dma1: dma-controller@4c00000 {
+			compatible = "qcom,sm6375-gpi-dma", "qcom,sm6350-gpi-dma";
+			reg = <0 0x04c00000 0 0x60000>;
+			interrupts = <GIC_SPI 497 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 498 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 499 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 500 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 501 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 502 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 503 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 504 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 505 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 506 IRQ_TYPE_LEVEL_HIGH>;
+			dma-channels = <10>;
+			dma-channel-mask = <0x1f>;
+			iommus = <&apps_smmu 0xd6 0x0>;
+			#dma-cells = <3>;
+			status = "disabled";
+		};
+
 		usb_1: usb@4ef8800 {
 			compatible = "qcom,sm6375-dwc3", "qcom,dwc3";
 			reg = <0 0x04ef8800 0 0x400>;
-- 
2.38.1

