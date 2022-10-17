Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A013A600B78
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiJQJqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiJQJps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:45:48 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCCE580B4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:45:41 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l16-20020a05600c4f1000b003c6c0d2a445so9569237wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z8zoiO3HcCMOhvwnFbJarwF7HI12ZyCQT2wJzcSF7bw=;
        b=GR4c68TFIOTAZIvU08PAVG4mtAT+VuNoAuABm7Au91I+lHasYucr4NVEvo7NOvgx/P
         W7NxAGL2fkmY7+TAhhP/A3ZVFaQ4V+RSYhK03M4PWrO3+gOhEExsC+IW3RG7U7QUTqG2
         0n9N6Vc7GAEBPvMjnw6/w2SSfvrFh5BJFqlk+DKpUKv7De+8usdS7fjLmlyROkdVSWAf
         6QICvtqpGdS6JbRxqaAkK2ZffVrUSg8/UeRFdmvOU3vaR8ivh7P/KG4NJ2RW7rdKrysx
         9K2fVTGhKcoL41qIq6bmxC884RptBzdRmnUxdMrVXIG0BavLFa5b82MmqGF1zPgNZYI6
         /PtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8zoiO3HcCMOhvwnFbJarwF7HI12ZyCQT2wJzcSF7bw=;
        b=Og34bVODGKLNkcNpuTHM766BE0Iq2bUmwQmjbMplY4+3qoNvW0bVmJhbYqVQ70/YXa
         4t45nh/CZfYR/3eUTboZUgUhxT+k05J243GD6ATfDcIo+nRmNmX93v+FKqiUj1cXCBBc
         jLy2bW/MzorzZ7I4rUWJw4l/oDPJbdzLxwgMMtvUUAmKQKXu+xoJgQYBDTJZtRdHttub
         fkDVay3WFXn7MggtS0R/3uSbwjEm2Wrwo64Og9NjlTQijV3IGvmBoGpi1xf82n/Xd5d9
         yBOrwV7HN3keE5BSfDa/vAMKOf8UllS0WXMZpFd/qaqKRuqgEJnNjrbjjGGFdVI6WeLu
         CrhA==
X-Gm-Message-State: ACrzQf2bj38SVVlZErHUsQ7vn/4Casxxt2fBlngvU79mj7/DJz/vba9J
        KVN8wOC7cxyk4iraelWdQUxWVA==
X-Google-Smtp-Source: AMsMyM7miHaeiw3gyM4DJ6PGKX8iiVKBSM+zRGn8fwoBsQ53nGa5TdISBJmFgARL0G+Y3e694y72WA==
X-Received: by 2002:a05:600c:1d0f:b0:3c6:bfa9:9ef6 with SMTP id l15-20020a05600c1d0f00b003c6bfa99ef6mr18773703wms.136.1665999939629;
        Mon, 17 Oct 2022 02:45:39 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id d12-20020adfa40c000000b0022ca921dc67sm7824305wra.88.2022.10.17.02.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 02:45:39 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 17 Oct 2022 11:45:36 +0200
Subject: [PATCH v3 11/11] arm: dts: qcom: mdm9615: remove useless amba subnode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220928-mdm9615-dt-schema-fixes-v3-11-531da552c354@linaro.org>
References: <20220928-mdm9615-dt-schema-fixes-v3-0-531da552c354@linaro.org>
In-Reply-To: <20220928-mdm9615-dt-schema-fixes-v3-0-531da552c354@linaro.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-rtc@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-input@vger.kernel.org
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

The separate amba device node doesn't add anything significant to the
DT. The OF parsing code already creates amba_device or platform_device
depending on the compatibility lists.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/boot/dts/qcom-mdm9615.dtsi | 78 +++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 42 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
index 9d950f96280d..482fd246321c 100644
--- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
@@ -314,49 +314,43 @@ sdcc2bam: dma-controller@12142000{
 			qcom,ee = <0>;
 		};
 
-		amba {
-			compatible = "simple-bus";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-			sdcc1: mmc@12180000 {
-				status = "disabled";
-				compatible = "arm,pl18x", "arm,primecell";
-				arm,primecell-periphid = <0x00051180>;
-				reg = <0x12180000 0x2000>;
-				interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&gcc SDC1_CLK>, <&gcc SDC1_H_CLK>;
-				clock-names = "mclk", "apb_pclk";
-				bus-width = <8>;
-				max-frequency = <48000000>;
-				cap-sd-highspeed;
-				cap-mmc-highspeed;
-				vmmc-supply = <&vsdcc_fixed>;
-				dmas = <&sdcc1bam 2>, <&sdcc1bam 1>;
-				dma-names = "tx", "rx";
-				assigned-clocks = <&gcc SDC1_CLK>;
-				assigned-clock-rates = <400000>;
-			};
+		sdcc1: mmc@12180000 {
+			status = "disabled";
+			compatible = "arm,pl18x", "arm,primecell";
+			arm,primecell-periphid = <0x00051180>;
+			reg = <0x12180000 0x2000>;
+			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc SDC1_CLK>, <&gcc SDC1_H_CLK>;
+			clock-names = "mclk", "apb_pclk";
+			bus-width = <8>;
+			max-frequency = <48000000>;
+			cap-sd-highspeed;
+			cap-mmc-highspeed;
+			vmmc-supply = <&vsdcc_fixed>;
+			dmas = <&sdcc1bam 2>, <&sdcc1bam 1>;
+			dma-names = "tx", "rx";
+			assigned-clocks = <&gcc SDC1_CLK>;
+			assigned-clock-rates = <400000>;
+		};
 
-			sdcc2: mmc@12140000 {
-				compatible = "arm,pl18x", "arm,primecell";
-				arm,primecell-periphid = <0x00051180>;
-				status = "disabled";
-				reg = <0x12140000 0x2000>;
-				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&gcc SDC2_CLK>, <&gcc SDC2_H_CLK>;
-				clock-names = "mclk", "apb_pclk";
-				bus-width = <4>;
-				cap-sd-highspeed;
-				cap-mmc-highspeed;
-				max-frequency = <48000000>;
-				no-1-8-v;
-				vmmc-supply = <&vsdcc_fixed>;
-				dmas = <&sdcc2bam 2>, <&sdcc2bam 1>;
-				dma-names = "tx", "rx";
-				assigned-clocks = <&gcc SDC2_CLK>;
-				assigned-clock-rates = <400000>;
-			};
+		sdcc2: mmc@12140000 {
+			compatible = "arm,pl18x", "arm,primecell";
+			arm,primecell-periphid = <0x00051180>;
+			status = "disabled";
+			reg = <0x12140000 0x2000>;
+			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc SDC2_CLK>, <&gcc SDC2_H_CLK>;
+			clock-names = "mclk", "apb_pclk";
+			bus-width = <4>;
+			cap-sd-highspeed;
+			cap-mmc-highspeed;
+			max-frequency = <48000000>;
+			no-1-8-v;
+			vmmc-supply = <&vsdcc_fixed>;
+			dmas = <&sdcc2bam 2>, <&sdcc2bam 1>;
+			dma-names = "tx", "rx";
+			assigned-clocks = <&gcc SDC2_CLK>;
+			assigned-clock-rates = <400000>;
 		};
 
 		tcsr: syscon@1a400000 {

-- 
b4 0.10.1
