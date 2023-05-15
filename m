Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D483702D6B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242154AbjEONEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242102AbjEONEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:04:35 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DC11FDE
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:04:33 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2ac826a1572so131268111fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684155871; x=1686747871;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bHrRwJZNmR4vO/RyDtfQTesrckzCKnVFHgmO5Rc+8Yc=;
        b=TULdDFG0A6XCg1kPrRqYeAen4Sup0En+HIRYQ5hbebwHu1yf8R7/rtfpcG4CAHErU3
         aYl/HJQ/sMM8/wZhPoKAVm7bTzWOFfIOOalAlT5aFCYhwwzsrwQkuIw8NK5SAbdTpAWO
         EaQFBIPZh9i580piap/E3+oZYEmDnXQq5wmfHASe8feZ8b7dQ9q12htNNYd9PzHt4AnC
         g+JaEvIzthgz91G+JgGQt4tRSprLzbKO6x2vx699+lGSrb8hiDgnM2C8B8OsSpOAdv+E
         4BJgb5yO4M1DnCUlx/T+OZMn1P95Nd+QrR4BS4TfiEo+XR3UbKq2xocXBkGxFdbXrOSd
         VDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684155871; x=1686747871;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHrRwJZNmR4vO/RyDtfQTesrckzCKnVFHgmO5Rc+8Yc=;
        b=hpis/RzcOnT7CTfFLFk21PYGthKPcjagw8LcdovC2e7+xueEq0Fl398He89HwGHq3r
         iA+lwqMTqLSaD9daBfYdY4TkeL15UHcbwK4yUUBSFun+miNigV51n62Bd4xz56DXqABy
         J9z2A9hPXC6CTEvN/5ur3gVP5CrvwW7Hv3zSoptIMRRij5H2/4+1mGnWhnlZRloFhoAS
         5peDCty+29uIGnX3QhIpifyjJM8r14z1xSgvU1nE4nXpn4TRLWPCrDnxY+qxEyrJM6kL
         pnJUzLOhtbirAIik9SQkOQpkE3ysx6DLv/Ki3J8HlI4RWUCNj8jeVi7Sv9HlbIgBFB96
         zufg==
X-Gm-Message-State: AC+VfDze2bnWiNsQmObT92yXUMAvPAIuGU+hX3IPemdgnmmHSKnwMvHu
        6Eb3hynp/4Stwnr3kta6CgcF1Q==
X-Google-Smtp-Source: ACHHUZ4eI0PryuqQnmub3Yb1zlIRfC/ATwu3Y1K2XJZHSAPArQZmY4OyHkeO2muauqast5oLswYLbQ==
X-Received: by 2002:a05:6512:507:b0:4f1:4fe6:56c8 with SMTP id o7-20020a056512050700b004f14fe656c8mr6621241lfb.34.1684155871779;
        Mon, 15 May 2023 06:04:31 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id x27-20020ac25ddb000000b004f37a64c90asm785823lfq.303.2023.05.15.06.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 06:04:31 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 15 May 2023 15:04:16 +0200
Subject: [PATCH 5/5] arm64: dts: qcom: qrb4210-rb2: Enable CAN bus
 controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230515-topic-rb2-bits-v1-5-a52d154a639d@linaro.org>
References: <20230515-topic-rb2-bits-v1-0-a52d154a639d@linaro.org>
In-Reply-To: <20230515-topic-rb2-bits-v1-0-a52d154a639d@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684155864; l=1168;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=AZ/Op7kTNY+Rd0mmluqshowmHdxgH+CEwOfMytzuYpc=;
 b=DEY+Mv6nuwLuNQ4u5dz5EePSZ+OYPbGN8uNJUATj+7/wFqrdDqLdjyIFL4gBsQyfocto3ryMk
 Zbl9P6UpJezD3Sps80bAaZF8kALbz3Njwpj6o1ocYvgbT4rPHNwngcM
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the Microchip mcp2518fd hosted on the SPI5 bus.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index 224c96bba35f..e2e82dd83c55 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -20,6 +20,14 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	clocks {
+		clk40M: can-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <40000000>;
+			#clock-cells = <0>;
+		};
+	};
+
 	hdmi-connector {
 		compatible = "hdmi-connector";
 		type = "a";
@@ -415,6 +423,20 @@ &sdhc_2 {
 	status = "okay";
 };
 
+&spi5 {
+	status = "okay";
+
+	can@0 {
+		compatible = "microchip,mcp2518fd";
+		reg = <0>;
+		interrupts-extended = <&tlmm 39 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&clk40M>;
+		spi-max-frequency = <10000000>;
+		vdd-supply = <&vdc_5v>;
+		xceiver-supply = <&vdc_5v>;
+	};
+};
+
 &sleep_clk {
 	clock-frequency = <32000>;
 };

-- 
2.40.1

