Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670A55F0BE8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiI3Mq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiI3MqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:46:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DE8123862;
        Fri, 30 Sep 2022 05:46:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E307B828A1;
        Fri, 30 Sep 2022 12:46:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E374FC433D6;
        Fri, 30 Sep 2022 12:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664541981;
        bh=u18ImHLoVFp/8I3S3KZ9GhkbNEL7l/wO9nIPOfoNZJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EJq9J8YsrXbGc+LnJGkrl7zIieCx+O7SOG9/BzfrTh6NyBBNR8aGysTzv/XMI6w6H
         SRoPyy679ukwFw2JVHPfAhXlzxjG3/PwxlhvTwhldNH3Odab554HJ9hF1+eDaZ7W53
         l2iL1D73OH1xJQnX5bmvysROPT9QHzAFmStpRh+IrFlIvlThtkWtr+sNW6TDHm7t4n
         JU76KoSTD+sSuVi7rvcMaP9zUbgOdJYC3XGomNsdxiCV0RZg1dS4MEsNC2r2kAcubJ
         mkoPwxRkBKbDYbrsPgq6Tv9YC18OZmncIphnGWo+Y1i16d5VHNKFgpy/USI9vB2Uv2
         TqADSsWp8gP0w==
Received: by pali.im (Postfix)
        id 45D5693F; Fri, 30 Sep 2022 14:46:18 +0200 (CEST)
Date:   Fri, 30 Sep 2022 14:46:18 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Josef Schlehofer <josef.schlehofer@nic.cz>
Subject: Re: [PATCH] powerpc: dts: turris1x.dts: Add channel labels for
 temperature sensor
Message-ID: <20220930124618.kyaansrl7ls5kn3i@pali>
References: <20220930123901.10251-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220930123901.10251-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ CC hwmon ML

On Friday 30 September 2022 14:39:01 Pali Rohár wrote:
> Channel 0 of SA56004ED chip refers to internal SA56004ED chip sensor (chip
> itself is located on the board) and channel 1 of SA56004ED chip refers to
> external sensor which is connected to temperature diode of the P2020 CPU.
> 
> Fixes: 54c15ec3b738 ("powerpc: dts: Add DTS file for CZ.NIC Turris 1.x routers")
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
> With this change userspace 'sensors' applications prints labels:
> 
>     $ sensors
>     sa56004-i2c-0-4c
>     Adapter: MPC adapter (i2c@3000)
>     board:        +34.2°C  (low  =  +0.0°C, high = +70.0°C)
>                            (crit = +85.0°C, hyst = +75.0°C)
>     cpu:          +58.9°C  (low  =  +0.0°C, high = +70.0°C)
>                            (crit = +85.0°C, hyst = +75.0°C)
> 
> And without this change it prints just generic tempX names:
> 
>     $ sensors
>     sa56004-i2c-0-4c
>     Adapter: MPC adapter (i2c@3000)
>     temp1:        +43.0°C  (low  =  +0.0°C, high = +70.0°C)
>                            (crit = +85.0°C, hyst = +75.0°C)
>     temp2:        +63.4°C  (low  =  +0.0°C, high = +70.0°C)
>                            (crit = +85.0°C, hyst = +75.0°C)
> ---
>  arch/powerpc/boot/dts/turris1x.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/powerpc/boot/dts/turris1x.dts b/arch/powerpc/boot/dts/turris1x.dts
> index 4033c554b06a..5b5278c32e43 100644
> --- a/arch/powerpc/boot/dts/turris1x.dts
> +++ b/arch/powerpc/boot/dts/turris1x.dts
> @@ -69,6 +69,20 @@
>  				interrupt-parent = <&gpio>;
>  				interrupts = <12 IRQ_TYPE_LEVEL_LOW>, /* GPIO12 - ALERT pin */
>  					     <13 IRQ_TYPE_LEVEL_LOW>; /* GPIO13 - CRIT pin */
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				/* Local temperature sensor (SA56004ED internal) */
> +				channel@0 {
> +					reg = <0>;
> +					label = "board";
> +				};
> +
> +				/* Remote temperature sensor (D+/D- connected to P2020 CPU Temperature Diode) */
> +				channel@1 {
> +					reg = <1>;
> +					label = "cpu";
> +				};

I'm not sure if you want UPPERCASE, lowercase, PascalCase, kebab-case
or snake_case format of labels. Or if you want also "temp" or
"temperature" keyword in the label. So please adjust label to the
preferred one, if proposed format is not the correct.

>  			};
>  
>  			/* DDR3 SPD/EEPROM */
> -- 
> 2.20.1
> 
