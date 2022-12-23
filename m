Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53A1654F3F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 11:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbiLWKjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 05:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiLWKjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 05:39:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E5A64F2;
        Fri, 23 Dec 2022 02:39:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D896261F0D;
        Fri, 23 Dec 2022 10:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3911DC433D2;
        Fri, 23 Dec 2022 10:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671791944;
        bh=s6qRPXwQzEgfyS6IxjcUK5ThQGqqJZl9J/0fvlAQn4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HclwobKldECH8GnXaXBwYwVA9BZMh8Jjbh0SOGfUPIkLcSZioevrBsUZp8y6n5Lv7
         nwpvD4GTppWuNTlvkaZ9J3WnUkygRQUxZONxiFk79hF5oVs4IAZbG5XQ48vXeJnFTk
         2IUT0aIvm2Y3FHhWJGZtQQqzjhg8wq7pGeJz5CYtdejMRWwxj5UoRqTfHvbAmUEqpZ
         8HtGwzKonttFDQjokKmXiMxrVRm3qTCXaWgInQg9n1vyphI8E9vyTkPOgb9p9Ufndx
         EpIesrggkQ/1x4svge6Fq8HAwYT5IZiJuQIFTSu9iltzabftkMtoRFyly62CsmCPiq
         tBQHP4/6SyOYA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p8fT3-0004Zy-H0; Fri, 23 Dec 2022 11:39:57 +0100
Date:   Fri, 23 Dec 2022 11:39:57 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Brian Masney <bmasney@redhat.com>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        quic_shazhuss@quicinc.com, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com
Subject: Re: [PATCH v3 5/7] arm64: dts: qcom: sc8280xp: add missing spi nodes
Message-ID: <Y6WFfSedn7hvEeAA@hovoldconsulting.com>
References: <20221220192854.521647-1-bmasney@redhat.com>
 <20221220192854.521647-6-bmasney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220192854.521647-6-bmasney@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 02:28:52PM -0500, Brian Masney wrote:
> Add the missing nodes for the spi buses that's present on this SoC.
> 
> This work was derived from various patches that Qualcomm delivered
> to Red Hat in a downstream kernel.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
> Changes from v2 to v3
> - None
> 
> Changes from v1 to v2
> - Dropped qupX_ prefix from labels. (Johan)
> - Dropped spi-max-frequency property from spi nodes. (Shazad)
> 
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 360 +++++++++++++++++++++++++
>  1 file changed, 360 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index a502d4e19d98..4591d411f5fb 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -829,6 +829,21 @@ i2c16: i2c@880000 {
>  				status = "disabled";
>  			};
>  
> +			spi16: spi@880000 {
> +				compatible = "qcom,geni-spi";
> +				reg = <0 0x00880000 0 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_WRAP2_S0_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;

So please move this two after 'reg' as well.

> +				interconnects = <&clk_virt MASTER_QUP_CORE_2 0 &clk_virt SLAVE_QUP_CORE_2 0>,
> +				                <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_2 0>,
> +				                <&aggre1_noc MASTER_QUP_2 0 &mc_virt SLAVE_EBI1 0>;
> +				interconnect-names = "qup-core", "qup-config", "qup-memory";

Shouldn't the spi version of these nodes also have a power-domain
property?

> +				status = "disabled";
> +			};

Johan
