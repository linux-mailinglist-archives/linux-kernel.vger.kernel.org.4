Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7BC65BEA4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbjACLIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237019AbjACLIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:08:20 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF485101B;
        Tue,  3 Jan 2023 03:08:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 924311516;
        Tue,  3 Jan 2023 03:09:00 -0800 (PST)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC7843F663;
        Tue,  3 Jan 2023 03:08:17 -0800 (PST)
Date:   Tue, 3 Jan 2023 11:08:15 +0000
From:   Andre Przywara <andre.przywara@foss.arm.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 1/2] ARM: dts: sunxi: Fix GPIO LED node names
Message-ID: <20230103110815.0a047540@donnerap.cambridge.arm.com>
In-Reply-To: <20221231225854.16320-1-samuel@sholland.org>
References: <20221231225854.16320-1-samuel@sholland.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
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

On Sat, 31 Dec 2022 16:58:53 -0600
Samuel Holland <samuel@sholland.org> wrote:

> These board devicetrees fail to validate because the gpio-leds schema
> requires its child nodes to have "led" in the node name.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
> 
> Changes in v2:
>  - Use the recommended enumerator pattern for LED node names
> 
>  arch/arm/boot/dts/sun5i-gr8-chip-pro.dts | 2 +-
>  arch/arm/boot/dts/sun5i-r8-chip.dts      | 2 +-
>  arch/arm/boot/dts/sun6i-a31s-sina31s.dts | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts b/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
> index a32cde3e32eb..5c3562b85a5b 100644
> --- a/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
> +++ b/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
> @@ -70,7 +70,7 @@ chosen {
>  	leds {
>  		compatible = "gpio-leds";
>  
> -		status {
> +		led-0 {
>  			label = "chip-pro:white:status";
>  			gpios = <&axp_gpio 2 GPIO_ACTIVE_HIGH>;
>  			default-state = "on";
> diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/boot/dts/sun5i-r8-chip.dts
> index 4bf4943d4eb7..fd37bd1f3920 100644
> --- a/arch/arm/boot/dts/sun5i-r8-chip.dts
> +++ b/arch/arm/boot/dts/sun5i-r8-chip.dts
> @@ -70,7 +70,7 @@ chosen {
>  	leds {
>  		compatible = "gpio-leds";
>  
> -		status {
> +		led-0 {
>  			label = "chip:white:status";
>  			gpios = <&axp_gpio 2 GPIO_ACTIVE_HIGH>;
>  			default-state = "on";
> diff --git a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
> index 0af48e143b66..56956352914d 100644
> --- a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
> +++ b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
> @@ -67,7 +67,7 @@ hdmi_con_in: endpoint {
>  	leds {
>  		compatible = "gpio-leds";
>  
> -		status {
> +		led-0 {
>  			label = "sina31s:status:usr";
>  			gpios = <&pio 7 13 GPIO_ACTIVE_HIGH>; /* PH13 */
>  		};

