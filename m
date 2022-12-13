Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4029E64B0DD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbiLMIMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbiLMIMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:12:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3028175B6;
        Tue, 13 Dec 2022 00:12:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7117F612EA;
        Tue, 13 Dec 2022 08:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B9EC433EF;
        Tue, 13 Dec 2022 08:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670919147;
        bh=r6fxTGbOxB5OEKw0ORyhNh6d7z2J6me2vEr4MUZNLpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gzQrcpqb+sxzGsT5EN4QOkYE71GnNZ59mrs7L2JqLvCveLlq4yMRDpCBUxGDB5ifx
         4HPJ4J4HmhnexPjoRoedHiAmoNnAGnSaN3Gs8tBnsebhzKNYSFoFQEmPuzUz4vauBj
         vO9EY6nKUAydivBQ8jMm2a+RdYn96HCZLRvVZ5AP3scCzlZyBGKK8yqFUNPZ92JLO4
         jviOdBd4qy2AQw6rynZLt80cSFsqm4QdzdLtYI/QbUU9wdHYkdcrkZfejq1Gmc28TX
         ofuTVUenVY3pPZVIrYPVe1zQU5irjdPxJvgmOXqxWowgK1VI0FREi40Byb8Vg6dane
         qoDDjrBXxEQtg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p50PE-0004fM-0b; Tue, 13 Dec 2022 09:12:52 +0100
Date:   Tue, 13 Dec 2022 09:12:52 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sc8280xp: correct SPMI bus address
 cells
Message-ID: <Y5g0BAc1ix1+j3r3@hovoldconsulting.com>
References: <20221212133303.39610-1-krzysztof.kozlowski@linaro.org>
 <20221212133303.39610-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212133303.39610-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 02:33:01PM +0100, Krzysztof Kozlowski wrote:
> The SPMI bus uses two address cells and zero size cells (secoond reg
> entry - SPMI_USID - is not the size):
> 
>   spmi@c440000: #address-cells:0:0: 2 was expected
> 
> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 27f5c2f82338..3cb4ca6c53eb 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -1947,8 +1947,8 @@ spmi_bus: spmi@c440000 {
>  			interrupts-extended = <&pdc 1 IRQ_TYPE_LEVEL_HIGH>;
>  			qcom,ee = <0>;
>  			qcom,channel = <0>;
> -			#address-cells = <1>;
> -			#size-cells = <1>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;
>  			interrupt-controller;
>  			#interrupt-cells = <4>;
>  		};

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
