Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925B86A6250
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjB1WTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjB1WTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:19:16 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B858E1F5C0;
        Tue, 28 Feb 2023 14:19:10 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pX8JQ-000338-02; Tue, 28 Feb 2023 23:19:08 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id A020FC1149; Tue, 28 Feb 2023 23:15:57 +0100 (CET)
Date:   Tue, 28 Feb 2023 23:15:57 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        arinc.unal@arinc9.com, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v7 3/5] mips: dts: ralink: mt7621: add phandle to system
 controller node for watchdog
Message-ID: <20230228221557.GC15457@alpha.franken.de>
References: <20230214103936.1061078-1-sergio.paracuellos@gmail.com>
 <20230214103936.1061078-4-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230214103936.1061078-4-sergio.paracuellos@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 11:39:34AM +0100, Sergio Paracuellos wrote:
> To allow to access system controller registers from watchdog driver code
> add a phandle in the watchdog 'wdt' node. This avoid using arch dependent
> operations in driver code.
> 
> Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  arch/mips/boot/dts/ralink/mt7621.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
> index ac818fd721ae..3d16beb77440 100644
> --- a/arch/mips/boot/dts/ralink/mt7621.dtsi
> +++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
> @@ -73,6 +73,7 @@ sysc: syscon@0 {
>  		wdt: watchdog@100 {
>  			compatible = "mediatek,mt7621-wdt";
>  			reg = <0x100 0x100>;
> +			mediatek,sysctl = <&sysc>;
>  		};
>  
>  		gpio: gpio@600 {
> -- 
> 2.25.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
