Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED2B70E687
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237922AbjEWUdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238050AbjEWUdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:33:45 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 May 2023 13:33:32 PDT
Received: from mail.mleia.com (mleia.com [178.79.152.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CFCE5B;
        Tue, 23 May 2023 13:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
        t=1684873066; bh=09CTwGtCwgqIKNSsEvY2eczqQBaTuZs3wRO9EsOKxfQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jSzJuLZGCRCwxDW0kck7iHhJkaWxzX2g50Sf4XlKqSlYzGbcX5y4Ot27bH3UnCuAy
         xXFzaH/eqQFQdM25pwGVzE77PTPjLENrEanS5Stmh1eiw72HZHu4WyASHV1X4lWRPU
         Sbvxe56qXNAbmchx3Fgp3rSZV9fdffeY/gKOF2xlaKYrXJg8QmO8ckB88R8JkXgW4p
         WOW5cah5PDX66QCW4H/t24wBmSn3Qh1jYqOmoGmD5b0yqwjohwRDoNVUqrfrE85px/
         S/m8vWUEiVua6QGU0I27doLb3zPgqLAkahg7ybRE8nOk3MFv/Gm9r/JoosmYYOqfwf
         PXgN13JbZhLMQ==
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 644274228A9;
        Tue, 23 May 2023 20:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
        t=1684873066; bh=09CTwGtCwgqIKNSsEvY2eczqQBaTuZs3wRO9EsOKxfQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jSzJuLZGCRCwxDW0kck7iHhJkaWxzX2g50Sf4XlKqSlYzGbcX5y4Ot27bH3UnCuAy
         xXFzaH/eqQFQdM25pwGVzE77PTPjLENrEanS5Stmh1eiw72HZHu4WyASHV1X4lWRPU
         Sbvxe56qXNAbmchx3Fgp3rSZV9fdffeY/gKOF2xlaKYrXJg8QmO8ckB88R8JkXgW4p
         WOW5cah5PDX66QCW4H/t24wBmSn3Qh1jYqOmoGmD5b0yqwjohwRDoNVUqrfrE85px/
         S/m8vWUEiVua6QGU0I27doLb3zPgqLAkahg7ybRE8nOk3MFv/Gm9r/JoosmYYOqfwf
         PXgN13JbZhLMQ==
Message-ID: <f39da4b5-528b-e389-c0ee-d31add169620@mleia.com>
Date:   Tue, 23 May 2023 23:17:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH 06/13] ARM: lpc32xx: add missing include
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, soc@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20230516153109.514251-1-arnd@kernel.org>
 <20230516153109.514251-7-arnd@kernel.org>
From:   Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20230516153109.514251-7-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20230523_201746_460868_EF02DC5F 
X-CRM114-Status: GOOD (  14.88  )
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/23 18:31, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> lpc32xx_loopback_set() is defined in linux/soc/nxp/lpc32xx-misc.h but
> this is not included before the function definition.
> 
> arch/arm/mach-lpc32xx/serial.c:63:6: error: no previous prototype for 'lpc32xx_loopback_set'
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/arm/mach-lpc32xx/serial.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-lpc32xx/serial.c b/arch/arm/mach-lpc32xx/serial.c
> index 3e765c4bf986..3b1203db81b2 100644
> --- a/arch/arm/mach-lpc32xx/serial.c
> +++ b/arch/arm/mach-lpc32xx/serial.c
> @@ -15,6 +15,7 @@
>   #include <linux/serial_8250.h>
>   #include <linux/clk.h>
>   #include <linux/io.h>
> +#include <linux/soc/nxp/lpc32xx-misc.h>
>   
>   #include "lpc32xx.h"
>   #include "common.h"

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

If you wish, you may consider to add one more tag:

Fixes: ffba29c9ebd0 ("serial: lpc32xx: allow compile testing")

--
Best wishes,
Vladimir
