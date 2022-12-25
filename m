Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438BE655E6E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 23:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiLYWQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 17:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiLYWQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 17:16:15 -0500
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E1FFF1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 14:16:12 -0800 (PST)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 8E50C3ED3E;
        Sun, 25 Dec 2022 23:16:09 +0100 (CET)
Date:   Sun, 25 Dec 2022 23:16:08 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] arm64: dts: qcom: sm6125: re-order USB2 phy clocks
Message-ID: <20221225221608.hwxwxxnpp3udfoak@SoMainline.org>
References: <20221224154255.43499-1-krzysztof.kozlowski@linaro.org>
 <20221224154255.43499-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221224154255.43499-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-24 16:42:52, Krzysztof Kozlowski wrote:
> Bindings expect USB2 phy clocks in other order:
> 
>   sm6125-sony-xperia-seine-pdx201.dtb: phy@1613000: clock-names:1: 'ref' was expected
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

This was already sent last week as:

https://lore.kernel.org/linux-arm-msm/20221216213343.1140143-1-marijn.suijten@somainline.org/

- Marijn

> ---
>  arch/arm64/boot/dts/qcom/sm6125.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index 7e25a4f85594..bf9e8d45ee44 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> @@ -442,9 +442,9 @@ hsusb_phy1: phy@1613000 {
>  			reg = <0x01613000 0x180>;
>  			#phy-cells = <0>;
>  
> -			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
> -				 <&gcc GCC_AHB2PHY_USB_CLK>;
> -			clock-names = "ref", "cfg_ahb";
> +			clocks = <&gcc GCC_AHB2PHY_USB_CLK>,
> +				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
> +			clock-names = "cfg_ahb", "ref";
>  
>  			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
>  			status = "disabled";
> -- 
> 2.34.1
> 
