Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07097625132
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 03:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiKKC4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 21:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiKKC4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 21:56:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1A2205C7;
        Thu, 10 Nov 2022 18:56:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02322B822ED;
        Fri, 11 Nov 2022 02:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EF5C433D6;
        Fri, 11 Nov 2022 02:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668135361;
        bh=PnVF2jbu5Vi4C6B/3+qaYjq7wicZtUJxbK4ohcpyQys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NPjoPPdY1bhnj1FMtZt5Bmzjvx3ViTblibo485m0wngFE/SZu+W+yrmCKvzqKeFYv
         1VWH6gcqygqKNcgMOk99XmTNn9uy9Iflfj5mY58zdNetQjIbUBD8G9K0716rXnRNSg
         2uxLlVt/clQqf/vp+jyHrfiRZwXD73Aex6af54TRe4xv8H6/CneKPR0+sUyktc9P3l
         zJY3XH36Ieg1hHs182gEifcP+lR8o+ndxBdV12gqLVDJYcVwEw7VGFQHDO2EMm9O0q
         9j/sEUJu2lXOF1BW8W47sM+rVQJQ31jtzj1s27J1c2iO59WexR40VVnempwV2lfu1Z
         d8UJ5om7E1uzA==
Date:   Fri, 11 Nov 2022 10:55:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Rob.Herring@arm.com,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Chester Lin <clin@suse.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        NXP S32 Linux Team <s32@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 07/20] arm64: dts: Update cache properties for freescale
Message-ID: <20221111025553.GJ125525@dragon>
References: <20221031091956.531935-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031091956.531935-1-pierre.gondois@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 10:19:51AM +0100, Pierre Gondois wrote:
> The DeviceTree Specification v0.3 specifies that the cache node
> 'compatible' and 'cache-level' properties are 'required'. Cf.
> s3.8 Multi-level and Shared Cache Nodes
> 
> The recently added init_of_cache_level() function checks
> these properties. Add them if missing.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

Looks good to me.  Should I pick it up on IMX tree, or it needs to go as
part of the series (via other tree)?

Shawn

> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 1 +
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 +
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 1 +
>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi | 4 ++++
>  arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi | 4 ++++
>  arch/arm64/boot/dts/freescale/imx8ulp.dtsi     | 1 +
>  arch/arm64/boot/dts/freescale/s32g2.dtsi       | 2 ++
>  arch/arm64/boot/dts/freescale/s32v234.dtsi     | 2 ++
>  8 files changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 5627dd7734f3..ed0cc1a5d17e 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -46,6 +46,7 @@ cpu1: cpu@1 {
>  
>  		l2: l2-cache {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  	};
>  
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> index ca3d5a90d6d4..c8b1202d2584 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> @@ -83,6 +83,7 @@ cpu3: cpu@3 {
>  
>  		l2: l2-cache {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  	};
>  
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index feab604322cf..4590bdc076b7 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -78,6 +78,7 @@ cpu3: cpu@3 {
>  
>  		l2: l2-cache {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  	};
>  
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> index 6f6667b70028..2a7e13b6ef8a 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> @@ -95,18 +95,22 @@ cpu7: cpu@301 {
>  
>  	cluster0_l2: l2-cache0 {
>  		compatible = "cache";
> +		cache-level = <2>;
>  	};
>  
>  	cluster1_l2: l2-cache1 {
>  		compatible = "cache";
> +		cache-level = <2>;
>  	};
>  
>  	cluster2_l2: l2-cache2 {
>  		compatible = "cache";
> +		cache-level = <2>;
>  	};
>  
>  	cluster3_l2: l2-cache3 {
>  		compatible = "cache";
> +		cache-level = <2>;
>  	};
>  
>  	CPU_PW20: cpu-pw20 {
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
> index c3dc38188c17..c12c86915ec8 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
> @@ -95,18 +95,22 @@ cpu7: cpu@301 {
>  
>  	cluster0_l2: l2-cache0 {
>  		compatible = "cache";
> +		cache-level = <2>;
>  	};
>  
>  	cluster1_l2: l2-cache1 {
>  		compatible = "cache";
> +		cache-level = <2>;
>  	};
>  
>  	cluster2_l2: l2-cache2 {
>  		compatible = "cache";
> +		cache-level = <2>;
>  	};
>  
>  	cluster3_l2: l2-cache3 {
>  		compatible = "cache";
> +		cache-level = <2>;
>  	};
>  
>  	CPU_PW20: cpu-pw20 {
> diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> index 60c1b018bf03..187353458673 100644
> --- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
> @@ -50,6 +50,7 @@ A35_1: cpu@1 {
>  
>  		A35_L2: l2-cache0 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  	};
>  
> diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> index 824d401e7a2c..d8c82da88ca0 100644
> --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
> +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> @@ -52,10 +52,12 @@ cpu3: cpu@101 {
>  
>  		cluster0_l2: l2-cache0 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  
>  		cluster1_l2: l2-cache1 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  	};
>  
> diff --git a/arch/arm64/boot/dts/freescale/s32v234.dtsi b/arch/arm64/boot/dts/freescale/s32v234.dtsi
> index ba0b5305d481..3e306218d533 100644
> --- a/arch/arm64/boot/dts/freescale/s32v234.dtsi
> +++ b/arch/arm64/boot/dts/freescale/s32v234.dtsi
> @@ -61,10 +61,12 @@ cpu3: cpu@101 {
>  
>  		cluster0_l2_cache: l2-cache0 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  
>  		cluster1_l2_cache: l2-cache1 {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  	};
>  
> -- 
> 2.25.1
> 
