Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F200639E63
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 01:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiK1AJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 19:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiK1AJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 19:09:55 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2577B1006F;
        Sun, 27 Nov 2022 16:09:51 -0800 (PST)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 37AF8240003;
        Mon, 28 Nov 2022 00:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669594190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ybv7gENJyTR/kPaS82sTWfCOIaSg+Tq6OBZhSLuHKXA=;
        b=llmc7EBnLW8lgY9XCNhvhM0+Pl61OQNJmuJkiTvIU/1fAK4M6Rdcu62Hcom6lmpQSTkwpN
        ugdvWtf/XgKM4CZUjiXnOfqNu6SQJFohqnP2mYSXiA8gJNZwbsY9aISVf+D8AqU4vPS0SU
        XsWVMycjXX/owT7ckT7kTfXAUGWWasJbOASke6qaok1uHzPHqNegJ5icIa3aeoRIyRhzX1
        A8lVPFuh+WeaSCiNU7C3MNjAG2Rk2XehcZsKfGZ2I3nd8O8SGn3gyYOAAr/hc+gsgXmF07
        ojAu9cwke8iDOT1q9IkmWDDDAW+iapV2AyI+zYPjqOFiVniXb4Am/pfwmoI5AQ==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     pierre.gondois@arm.com, Rob.Herring@arm.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 10/20] arm64: dts: Update cache properties for marvell
In-Reply-To: <20221031092020.532456-1-pierre.gondois@arm.com>
References: <20221031092020.532456-1-pierre.gondois@arm.com>
Date:   Mon, 28 Nov 2022 01:09:48 +0100
Message-ID: <87r0xo7xdf.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Gondois <pierre.gondois@arm.com> writes:

> The DeviceTree Specification v0.3 specifies that the cache node
> 'compatible' and 'cache-level' properties are 'required'. Cf.
> s3.8 Multi-level and Shared Cache Nodes
>
> The recently added init_of_cache_level() function checks
> these properties. Add them if missing.
>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

Applied on mvebu/dt64

Thanks,

Gregory
> ---
>  arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi      | 1 +
>  arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi | 1 +
>  arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi | 2 ++
>  arch/arm64/boot/dts/marvell/armada-ap807-quad.dtsi | 2 ++
>  4 files changed, 6 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
> index 80b44c7df56a..d4770acec6ac 100644
> --- a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
> @@ -49,6 +49,7 @@ cpu1: cpu@1 {
>  
>  		l2: l2-cache {
>  			compatible = "cache";
> +			cache-level = <2>;
>  		};
>  	};
>  
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
> index fcab5173fe67..990f70303fe6 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
> @@ -51,6 +51,7 @@ l2: l2-cache {
>  			cache-size = <0x80000>;
>  			cache-line-size = <64>;
>  			cache-sets = <512>;
> +			cache-level = <2>;
>  		};
>  	};
>  
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
> index 3db427122f9e..a7b8e001cc9c 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi
> @@ -81,6 +81,7 @@ l2_0: l2-cache0 {
>  			cache-size = <0x80000>;
>  			cache-line-size = <64>;
>  			cache-sets = <512>;
> +			cache-level = <2>;
>  		};
>  
>  		l2_1: l2-cache1 {
> @@ -88,6 +89,7 @@ l2_1: l2-cache1 {
>  			cache-size = <0x80000>;
>  			cache-line-size = <64>;
>  			cache-sets = <512>;
> +			cache-level = <2>;
>  		};
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap807-quad.dtsi b/arch/arm64/boot/dts/marvell/armada-ap807-quad.dtsi
> index 68782f161f12..7740098fd108 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap807-quad.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap807-quad.dtsi
> @@ -81,6 +81,7 @@ l2_0: l2-cache0 {
>  			cache-size = <0x80000>;
>  			cache-line-size = <64>;
>  			cache-sets = <512>;
> +			cache-level = <2>;
>  		};
>  
>  		l2_1: l2-cache1 {
> @@ -88,6 +89,7 @@ l2_1: l2-cache1 {
>  			cache-size = <0x80000>;
>  			cache-line-size = <64>;
>  			cache-sets = <512>;
> +			cache-level = <2>;
>  		};
>  	};
>  };
> -- 
> 2.25.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
