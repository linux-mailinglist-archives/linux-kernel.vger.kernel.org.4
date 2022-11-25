Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F39C639134
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 22:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiKYVoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 16:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiKYVoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 16:44:06 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05944532C7;
        Fri, 25 Nov 2022 13:44:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 451282B;
        Fri, 25 Nov 2022 13:44:12 -0800 (PST)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 235363F587;
        Fri, 25 Nov 2022 13:44:04 -0800 (PST)
Date:   Fri, 25 Nov 2022 21:42:38 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, Karl Palsson <karlp@tweak.net.au>,
        Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH 2/2] ARM: dts: sun8i: nanopi-duo2: Fix regulator GPIO
 reference
Message-ID: <20221125214238.66cd51f4@slackpad.lan>
In-Reply-To: <20221125195401.61642-2-samuel@sholland.org>
References: <20221125195401.61642-1-samuel@sholland.org>
        <20221125195401.61642-2-samuel@sholland.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2022 13:54:01 -0600
Samuel Holland <samuel@sholland.org> wrote:

> The property named in the schema is 'enable-gpios', not 'enable-gpio'.
> This makes no difference at runtime, because the regulator is marked as
> always-on, but it breaks validation.
> 
> Fixes: 4701fc6e5dd9 ("ARM: dts: sun8i: add FriendlyARM NanoPi Duo2")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
> 
>  arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts
> index 43641cb82398..343b02b97155 100644
> --- a/arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts
> @@ -57,7 +57,7 @@ reg_vdd_cpux: vdd-cpux-regulator {
>  		regulator-ramp-delay = <50>; /* 4ms */
>  
>  		enable-active-high;
> -		enable-gpio = <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
> +		enable-gpios = <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
>  		gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
>  		gpios-states = <0x1>;
>  		states = <1100000 0>, <1300000 1>;

