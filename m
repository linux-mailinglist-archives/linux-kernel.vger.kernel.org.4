Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045F76CAECC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbjC0Tgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjC0Tgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:36:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7329310CC;
        Mon, 27 Mar 2023 12:36:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0781EB818D4;
        Mon, 27 Mar 2023 19:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B068C433EF;
        Mon, 27 Mar 2023 19:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679945793;
        bh=3VinL61oh1AfiLtJ/xna8xib3ysQ3OiMQrgj/aGjWKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i3lFG3GXZulHbQyv6vKwtbgDnKO5FZsdlsEMhFxcKSgyVVJAJy7SKXfsa0H4wDE/T
         9CVF7XnQAv5LRpHzNc9SsQ9WX44ZgNd8oXPdd6Aw4Zu1veDhnHi/ft62BNzdq8OEJm
         Sab9TjY4O+NeUiZjfqAzyLuXOasynDm0WOTV4D5Od/DSf415BSNLRXkZwVKHyhmTUN
         /GRcd2aiJiA2zCsAXq38AJ4vCaQSmLP5pf85YnbA4gmOTrAzkosjh3gITFXsxpolgb
         jfMLaIc6jOuAaR8O6VUbrCDyo5EfHJrN6lxckVhyNaBXrb9BSYhdUCrKXRVr4NpNiJ
         1ck3nRVlq06MA==
Date:   Mon, 27 Mar 2023 12:39:38 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm630: move DSI opp-table out of
 soc node
Message-ID: <20230327193938.42rvpttgo5p4kia6@ripper>
References: <20230326091605.18908-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230326091605.18908-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 11:16:05AM +0200, Krzysztof Kozlowski wrote:
> The soc node is supposed to have only device nodes with MMIO addresses,
> so move the DSI OPP out of it (it is used also by second DSI1 on
> SDM660):
> 

This node has been moved into the dsi node, so if we still want this,
could you please update the commit message.

Regards,
Bjorn

>   sda660-inforce-ifc6560.dtb: soc: opp-table-dsi: {'compatible': ['operating-points-v2'], ... should not be valid under {'type': 'object'}
>     From schema: dtschema/schemas/simple-bus.yaml
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Move the node out of soc. Don't add Konrad's review tag.
> ---
>  arch/arm64/boot/dts/qcom/sdm630.dtsi | 38 ++++++++++++++--------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index 72d9a12b5e9c..b91e423a3cfc 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -328,6 +328,25 @@ memory@80000000 {
>  		reg = <0x0 0x80000000 0x0 0x0>;
>  	};
>  
> +	dsi_opp_table: opp-table-dsi {
> +		compatible = "operating-points-v2";
> +
> +		opp-131250000 {
> +			opp-hz = /bits/ 64 <131250000>;
> +			required-opps = <&rpmpd_opp_svs>;
> +		};
> +
> +		opp-210000000 {
> +			opp-hz = /bits/ 64 <210000000>;
> +			required-opps = <&rpmpd_opp_svs_plus>;
> +		};
> +
> +		opp-262500000 {
> +			opp-hz = /bits/ 64 <262500000>;
> +			required-opps = <&rpmpd_opp_nom>;
> +		};
> +	};
> +
>  	pmu {
>  		compatible = "arm,armv8-pmuv3";
>  		interrupts = <GIC_PPI 6 IRQ_TYPE_LEVEL_HIGH>;
> @@ -1450,25 +1469,6 @@ mmcc: clock-controller@c8c0000 {
>  					<0>;
>  		};
>  
> -		dsi_opp_table: opp-table-dsi {
> -			compatible = "operating-points-v2";
> -
> -			opp-131250000 {
> -				opp-hz = /bits/ 64 <131250000>;
> -				required-opps = <&rpmpd_opp_svs>;
> -			};
> -
> -			opp-210000000 {
> -				opp-hz = /bits/ 64 <210000000>;
> -				required-opps = <&rpmpd_opp_svs_plus>;
> -			};
> -
> -			opp-262500000 {
> -				opp-hz = /bits/ 64 <262500000>;
> -				required-opps = <&rpmpd_opp_nom>;
> -			};
> -		};
> -
>  		mdss: display-subsystem@c900000 {
>  			compatible = "qcom,mdss";
>  			reg = <0x0c900000 0x1000>,
> -- 
> 2.34.1
> 
