Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A11664DE8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbjAJVPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjAJVPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:15:13 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3465F4BB;
        Tue, 10 Jan 2023 13:15:12 -0800 (PST)
Received: from darkstar.musicnaut.iki.fi (85-76-134-241-nat.elisa-mobile.fi [85.76.134.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: aaro.koskinen)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 5312D1B0018D;
        Tue, 10 Jan 2023 23:15:10 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1673385311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Koy05PWaiX6fKdi3Lmh0FSqnne78zkEyacW22GlTJF0=;
        b=O4kk41yiavlc2rz8Y6xZwDF1oy25rafNPRhr0Hd1vskyuM908ANij2KYwZ4zUkZcZQxhW6
        L/gglD8L8sfxJenoqqfCvcyIuUKoTAolby0IIN4lD9/CKy7P0iKtzMrBwAsSIxjL4eB7ji
        SN1H0wAgtLex+XD5gjkap2VBFjGizXF0WaR71d6tRqhofc90MNMOPGilluE6fAivq7KjIX
        s6+P6dxOLm4I/91itGag9DXi3N0zqFySqc6FdJXwm4seAlEBuUROnLCPzdbzBot/x/im5M
        8UIzwTYh4xzdQEGYJbO7vWBmcz9xvKWgmvP87GtKUQaQjKgzeTXf4n2UithVNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1673385311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Koy05PWaiX6fKdi3Lmh0FSqnne78zkEyacW22GlTJF0=;
        b=W0yWOYZ1p0RJrgHcsA8rOMBaT1NTwJS+T4SEz6pXY1kZl32j0rnjoayyazUT59Q4EY6OFM
        mQk6Rtcx7siME/R5QlL94o7a9nMvszDZray7b2du81Z/W+FAG7tMAw44/c6vJ5/WsBRhhA
        ZEdAS4EJ+ryEXKJmcOrYxj1k9oDm3vjMzAl+UzT0Sl/J1zfmV0yZFR3uNqtjvLKgPK+ChO
        UHD8uMKczG6AoJIgEL+jrdV3qp8WOYRN/SJcSwNWLaGrxDZNLH2PxvsJn9wDwxGHiN1/fk
        7mweemS8K47P+3cALIQqFJip9pAPM0vusHa7FfcGE6Dnn2Jfoo/SEaJ1FzVopQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1673385311; a=rsa-sha256;
        cv=none;
        b=AHHzNxLkX+f4spGWD450OGuYBY8RD9NaEODLedut8Jo4V1xQ8B0P6YgGf+ZGvS1+O5IAne
        Z1CuxJb+COyNHBgwzcLggzkn/AEbESeVeiIl2f7gsezmJH2QyNV4fnWXp4Lv0/+puVQJG8
        EPTnxXYKRF98LAhUJ+sejsgDqxBa1FuwFB7GWbIgo8kgZ9OJdcU94Vsp92Ykbc4q6XNRm3
        j7K6Cs/vnh4G2jVpNN0B8Ebf0bFbveHH7pc+XxIW/BsrtFGkbday0y1w0jiMWhoUodds3G
        roO9SvspzBS8daqoE0ZpdRnlgnOQZpCcjDUJ0ynYmBPM8H9cqUYCrgLog9xbug==
Date:   Tue, 10 Jan 2023 23:15:08 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] ARM: omap1: fix building gpio15xx
Message-ID: <20230110211508.GH730856@darkstar.musicnaut.iki.fi>
References: <20230109161636.512203-1-arnd@kernel.org>
 <20230109161636.512203-4-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109161636.512203-4-arnd@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 09, 2023 at 05:16:36PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> In some randconfig builds, the asm/irq.h header is not included
> in gpio15xx.c, so add an explicit include to avoid a build fialure:
> 
> In file included from arch/arm/mach-omap1/gpio15xx.c:15:
> arch/arm/mach-omap1/irqs.h:99:34: error: 'NR_IRQS_LEGACY' undeclared here (not in a function)
>    99 | #define IH2_BASE                (NR_IRQS_LEGACY + 32)
>       |                                  ^~~~~~~~~~~~~~
> arch/arm/mach-omap1/irqs.h:105:38: note: in expansion of macro 'IH2_BASE'
>   105 | #define INT_MPUIO               (5 + IH2_BASE)
>       |                                      ^~~~~~~~
> arch/arm/mach-omap1/gpio15xx.c:28:27: note: in expansion of macro 'INT_MPUIO'
>    28 |                 .start  = INT_MPUIO,
>       |                           ^~~~~~~~~
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.

> ---
>  arch/arm/mach-omap1/gpio15xx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
> index c675f11de99d..61fa26efd865 100644
> --- a/arch/arm/mach-omap1/gpio15xx.c
> +++ b/arch/arm/mach-omap1/gpio15xx.c
> @@ -11,6 +11,7 @@
>  #include <linux/gpio.h>
>  #include <linux/platform_data/gpio-omap.h>
>  #include <linux/soc/ti/omap1-soc.h>
> +#include <asm/irq.h>
>  
>  #include "irqs.h"
>  
> -- 
> 2.39.0
> 
