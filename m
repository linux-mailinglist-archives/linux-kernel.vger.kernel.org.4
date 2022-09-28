Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12305ED8AB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbiI1JPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbiI1JPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:15:04 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD5622BE4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 02:15:00 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l18so6769873wrw.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 02:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=Nps3ANTgE3seawbM5+PmTIn4OgiLjhxFHyf2GdOQ0aw=;
        b=lXtkUfmiU2FMJsUXOQ9XIdxJHNUBtovE3ktBFxkBzOg8PZznXCoQVdMUhJJVcYLP+E
         oLO6Fct/aCQrpTXIipnYA1ZrnUEPUyH0psrB3LZqwhSdjIjTOy7wXi0ZsLoKCHXlHQRa
         LKxSmQux1wf46YRXkN4/B7U/c7VGTXmFKf7pFKMWOy6lstY5rC6cbrNUAKIHCIWrGnrV
         P10sPlCeHv62tjFzAAGXlL8LGob4D3AxQY04CqX5/3tQfSb6Y0B9p1sm+6JWpkI4N9MA
         Sx0giQMbNdWfOQe6Uq0XkJUEpl6Qk2SgUGqGy+5BvJgo6nSw6BMCHZSCbTPk2cSvMiqs
         yaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Nps3ANTgE3seawbM5+PmTIn4OgiLjhxFHyf2GdOQ0aw=;
        b=L3wi+hzfAGRWACwWy1YmvXGiIKOxPDmasxKxgi7/REcacCnfAFO4Ej73LY+azzIYvN
         EEXkZ/uOPyYtWhGVSR4t6uUm+hQH1xKVLJOCffB+DXMtA89+3MI2tWWaRb9mUSrOjVCI
         NdOtUZc6uV0fVJkrXfXnGnx1yx4qgKImZy8jGLsNGDO1obMeoPy3vbR8Xq194vyg4fPR
         +ImVi0PG1jm5v7C6W26b9DUcRzTDFO9NIQsvsTTg7ZLDfF0WLy2R2+ib8OI4mKlQsVo4
         Lr5XvohGnVFAESC937TAXhe3kJPJrhezgjxzgH2WFC4tzE30FCMLxBMXrFSCtlCjG9Cm
         aY/w==
X-Gm-Message-State: ACrzQf3yH/pJjRhg9ytAsFDllRZ6z8yNDsDG4CRcbBVtoH4nsr2smngw
        MWf87dZyLjOJ/mDO3y8vyIz0fQ==
X-Google-Smtp-Source: AMsMyM5/GiiOcSG8h4Q42kXYkm+cp1fWvkF4ICXjgnEHrrmPrXmpPhk8X6qMZA4gaaAVzUStl0KkDQ==
X-Received: by 2002:adf:efc6:0:b0:22c:c6cc:87dc with SMTP id i6-20020adfefc6000000b0022cc6cc87dcmr2042704wrp.522.1664356499019;
        Wed, 28 Sep 2022 02:14:59 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id p2-20020a5d6382000000b0022a53fe201fsm2420016wru.68.2022.09.28.02.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 02:14:58 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 28 Sep 2022 09:14:57 +0000
Subject: [PATCH v1 7/7] arm: dts: qcom: mdm9615: remove useless amba subnode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220928-mdm9615-dt-schema-fixes-v1-7-b6e63a7df1e8@linaro.org>
References: <20220928-mdm9615-dt-schema-fixes-v1-0-b6e63a7df1e8@linaro.org>
In-Reply-To: <20220928-mdm9615-dt-schema-fixes-v1-0-b6e63a7df1e8@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.10.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since amba node type has been deprecated, remove this subnode and
move the mmc nodes in the main soc node.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
index d8723bd3fedb..1db822db7702 100644
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
b4 0.10.0
