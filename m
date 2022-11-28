Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E300639E65
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 01:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiK1AK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 19:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiK1AKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 19:10:54 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27352BD7;
        Sun, 27 Nov 2022 16:10:53 -0800 (PST)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 90288100005;
        Mon, 28 Nov 2022 00:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669594252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mpLlXizBvFO1isoUI3KX5JXYNy0mSJGR1QxATUr1/VA=;
        b=iKqUihgz0I723jh3Z6YgSHplx4VEc661gEgVbtX4ncH4jqnYfpSzTkPOzq1ZVfMzXpSUXv
        pEmOqw0lL5DxyNxf3ooN479Jl18d2jHQ8rnjQnHlq9FOCerYGpUz0S+B+5E2qsqocEKFE8
        MuJQQR9ipdJCbwV4l6WbXweRJrnnj4IkYrGHrwHo3qeDD2gKgGp81ZTAf8E0u04J88139T
        H5+tcZGKnaKANsMLQqrM0si6gkvrfJ7kwtc9NhnGNY/k5uXxhQsgpjYUza5ddAw6smIC8C
        aD1mRbEMlpIcRkoJULSRWzQbEp9h8qg6z8OSy9wQLYMOtqRuNeKMNrIrYiElQg==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     kostap@marvell.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stefan Chulski <stefanc@marvell.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Konstantin Porotchkin <kostap@marvell.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH] arm64: dts: marvell: add optee FW definitions
In-Reply-To: <20221109150743.1444103-1-kostap@marvell.com>
References: <20221109150743.1444103-1-kostap@marvell.com>
Date:   Mon, 28 Nov 2022 01:10:51 +0100
Message-ID: <87o7ss7xbo.fsf@BL-laptop>
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

<kostap@marvell.com> writes:

> From: Konstantin Porotchkin <kostap@marvell.com>
>
> Add reserved memory and ARM firmware definitions for optee
> memory region in Marvell Armada SoCs to avoid protected memory
> access.
>

Applied on mvebu/dt64

Thanks,

Gregory

> Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi  | 5 +++++
>  arch/arm64/boot/dts/marvell/armada-ap80x.dtsi | 5 +++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index df152c72276b..e300145ad1a6 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -35,6 +35,11 @@ psci-area@4000000 {
>  			reg = <0 0x4000000 0 0x200000>;
>  			no-map;
>  		};
> +
> +		tee@4400000 {
> +			reg = <0 0x4400000 0 0x1000000>;
> +			no-map;
> +		};
>  	};
>  
>  	cpus {
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> index a06a0a889c43..4e6d29ad32eb 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap80x.dtsi
> @@ -41,6 +41,11 @@ psci-area@4000000 {
>  			reg = <0x0 0x4000000 0x0 0x200000>;
>  			no-map;
>  		};
> +
> +		tee@4400000 {
> +			reg = <0 0x4400000 0 0x1000000>;
> +			no-map;
> +		};
>  	};
>  
>  	AP_NAME {
> -- 
> 2.25.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
