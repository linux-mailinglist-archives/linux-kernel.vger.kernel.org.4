Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1D865314F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 14:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiLUNHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 08:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiLUNGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 08:06:55 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BE8F2339D;
        Wed, 21 Dec 2022 05:06:49 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1p7yo2-0008Uq-00; Wed, 21 Dec 2022 14:06:46 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id EA81FC24F7; Wed, 21 Dec 2022 14:06:26 +0100 (CET)
Date:   Wed, 21 Dec 2022 14:06:26 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mips@vger.kernel.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: dts: bcm63268: Add missing properties to the TWD
 node
Message-ID: <20221221130626.GA6643@alpha.franken.de>
References: <20221220190947.2681192-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220190947.2681192-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 11:09:46AM -0800, Florian Fainelli wrote:
> We currently have a DTC warning with the current DTS due to the lack of
> a suitable #address-cells and #size-cells property:
> 
>   DTC     arch/mips/boot/dts/brcm/bcm63268-comtrend-vr-3032u.dtb
> arch/mips/boot/dts/brcm/bcm63268.dtsi:115.5-22: Warning (reg_format): /ubus/timer-mfd@10000080/timer@0:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
> arch/mips/boot/dts/brcm/bcm63268.dtsi:120.5-22: Warning (reg_format): /ubus/timer-mfd@10000080/watchdog@1c:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
> arch/mips/boot/dts/brcm/bcm63268.dtsi:111.4-35: Warning (ranges_format): /ubus/timer-mfd@10000080:ranges: "ranges" property has invalid length (12 bytes) (parent #address-cells == 1, child #address-cells == 2, #size-cells == 1)
> 
> Fixes: d3db4b96ab7f ("mips: dts: bcm63268: add TWD block timer")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/mips/boot/dts/brcm/bcm63268.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/mips/boot/dts/brcm/bcm63268.dtsi b/arch/mips/boot/dts/brcm/bcm63268.dtsi
> index c663efce91cf..7b788757cb1e 100644
> --- a/arch/mips/boot/dts/brcm/bcm63268.dtsi
> +++ b/arch/mips/boot/dts/brcm/bcm63268.dtsi
> @@ -109,6 +109,8 @@ timer-mfd@10000080 {
>  			compatible = "brcm,bcm7038-twd", "simple-mfd", "syscon";
>  			reg = <0x10000080 0x30>;
>  			ranges = <0x0 0x10000080 0x30>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
>  
>  			timer@0 {
>  				compatible = "brcm,bcm6345-timer";
> -- 
> 2.34.1

applied.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
