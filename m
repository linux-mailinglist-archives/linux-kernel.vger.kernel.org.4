Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C80749E13
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjGFNn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjGFNnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:43:55 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 370C91FCA;
        Thu,  6 Jul 2023 06:43:47 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qHPGr-0001Tf-00; Thu, 06 Jul 2023 15:43:45 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 1E314C01CC; Thu,  6 Jul 2023 14:47:58 +0200 (CEST)
Date:   Thu, 6 Jul 2023 14:47:58 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        UNGLinuxDriver@microchip.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: dts: add missing space before {
Message-ID: <ZKa3/r1GtOW36aoW@alpha.franken.de>
References: <20230705145724.292793-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705145724.292793-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 04:57:24PM +0200, Krzysztof Kozlowski wrote:
> Add missing whitespace between node name/label and opening {.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/mips/boot/dts/mscc/serval_common.dtsi | 2 +-
>  arch/mips/boot/dts/pic32/pic32mzda.dtsi    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/boot/dts/mscc/serval_common.dtsi b/arch/mips/boot/dts/mscc/serval_common.dtsi
> index 0893de420e27..5dc1eac49e50 100644
> --- a/arch/mips/boot/dts/mscc/serval_common.dtsi
> +++ b/arch/mips/boot/dts/mscc/serval_common.dtsi
> @@ -20,7 +20,7 @@ chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> -	i2c0_imux: i2c0-imux{
> +	i2c0_imux: i2c0-imux {
>  		compatible = "i2c-mux-pinctrl";
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> diff --git a/arch/mips/boot/dts/pic32/pic32mzda.dtsi b/arch/mips/boot/dts/pic32/pic32mzda.dtsi
> index f1e3dad6bead..fdc721b414a8 100644
> --- a/arch/mips/boot/dts/pic32/pic32mzda.dtsi
> +++ b/arch/mips/boot/dts/pic32/pic32mzda.dtsi
> @@ -75,7 +75,7 @@ evic: interrupt-controller@1f810000 {
>  		microchip,external-irqs = <3 8 13 18 23>;
>  	};
>  
> -	pic32_pinctrl: pinctrl@1f801400{
> +	pic32_pinctrl: pinctrl@1f801400 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		compatible = "microchip,pic32mzda-pinctrl";
> -- 
> 2.34.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
