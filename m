Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B70D7052E0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbjEPPxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbjEPPws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:52:48 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE95FD040;
        Tue, 16 May 2023 08:51:59 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-510b6a249a8so76977a12.0;
        Tue, 16 May 2023 08:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684252308; x=1686844308;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=68srKCHs7MOmD8qVy7azG1dB7pPSq7b9dHnxIkISzTs=;
        b=iTUS/wUE8BKyDA6qSZodOkI0rEqV0M7K5I7xfvEnet54BGQGXGOSGhMhhOUfZSb563
         +uJB+sgkak0HtNnKxCw8ptox//DCDjhU1VLd0XDlfv9DyFVTGIKqopHIss5WaXkZJIeW
         DSwAX7CTsn5tcFbWaxjfGL29lo2sp/j9d2tYjOMPmzqgboK/m61tUvq7uJnBt8ZMSRmn
         tldueC/cmvmx6uFV/ZsuEt4w58KFEcPDyjHTa4bjGWbVyRUF68jMpoeWBAa682Jjw05T
         jWQQ9Z8dBSDUqE8HBlfFox9CUab+Ibq+PVFQ3delRVxLrxogy2nj8atfQfnlZvHpx31L
         gRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684252308; x=1686844308;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=68srKCHs7MOmD8qVy7azG1dB7pPSq7b9dHnxIkISzTs=;
        b=SuCeOQS3S6fdJMmCuDhUAwKU7Fots5wbkpqUUp6LlRAjzVyNGXHw3AdIkO2pNnm93p
         QLXXR5VtUOJAe5Z+orcQVVQ5mmbb1lWvJfig+azX/S/Mi3nrsSn7xVLOVVkflnR/BFHf
         PWUQXQP/Rj4ayYzC/5tckTv40EEz9wFcSgjtDWIWgQTAnPWLBw3YFgqzQvcIRBmTOI+V
         4qO+CbO8AChwFQc4wGbHquINe7zy2hUfbHvOVnb4iJUiu4F1EGreG+OmAA+bopB4ljSL
         Xnkw8KREgLIKwDxoqTddKr9h7JD3uWZ/slZISV/CZyXngVG8Tj16McrREOE4uBV649rm
         NyGg==
X-Gm-Message-State: AC+VfDw1zpJeESJxsWPD0RoRS+xdBxxwR0mKT88WTxAMurrwa8vEd0PJ
        qSVelYAxhlzWzdg4P/z/UGk=
X-Google-Smtp-Source: ACHHUZ6UUBhE2/l4rk0+SCxoMU9t9VVFuC5HUku4gkgS9VHvi0TfYlJHNkXhMHDuH1xgAyrCeRm11A==
X-Received: by 2002:aa7:dd0f:0:b0:50c:4b1:8912 with SMTP id i15-20020aa7dd0f000000b0050c04b18912mr31793925edv.15.1684252308282;
        Tue, 16 May 2023 08:51:48 -0700 (PDT)
Received: from giga-mm.home ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id t5-20020a05640203c500b0050d82f96860sm8527921edw.59.2023.05.16.08.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 08:51:47 -0700 (PDT)
Message-ID: <2abeb4d11e8274bc337e504c6b0b42e86899150a.camel@gmail.com>
Subject: Re: [PATCH 02/13] ARM: ep93xx: fix missing-prototype warnings
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>, soc@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
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
Date:   Tue, 16 May 2023 17:51:46 +0200
In-Reply-To: <20230516153109.514251-3-arnd@kernel.org>
References: <20230516153109.514251-1-arnd@kernel.org>
         <20230516153109.514251-3-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd!

On Tue, 2023-05-16 at 17:30 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> ep93xx_clocksource_read() is only called from the file it is declared in,
> while ep93xx_timer_init() is declared in a header that is not included he=
re.
>=20
> arch/arm/mach-ep93xx/timer-ep93xx.c:120:13: error: no previous prototype =
for 'ep93xx_timer_init'
> arch/arm/mach-ep93xx/timer-ep93xx.c:63:5: error: no previous prototype fo=
r 'ep93xx_clocksource_read'
>=20
> Fixes: 000bc17817bf ("ARM: ep93xx: switch to GENERIC_CLOCKEVENTS")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
> =C2=A0arch/arm/mach-ep93xx/timer-ep93xx.c | 3 ++-
> =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-ep93xx/timer-ep93xx.c b/arch/arm/mach-ep93xx/t=
imer-ep93xx.c
> index dd4b164d1831..a9efa7bc2fa1 100644
> --- a/arch/arm/mach-ep93xx/timer-ep93xx.c
> +++ b/arch/arm/mach-ep93xx/timer-ep93xx.c
> @@ -9,6 +9,7 @@
> =C2=A0#include <linux/io.h>
> =C2=A0#include <asm/mach/time.h>
> =C2=A0#include "soc.h"
> +#include "platform.h"
> =C2=A0
> =C2=A0/******************************************************************=
*******
> =C2=A0 * Timer handling for EP93xx
> @@ -60,7 +61,7 @@ static u64 notrace ep93xx_read_sched_clock(void)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> =C2=A0}
> =C2=A0
> -u64 ep93xx_clocksource_read(struct clocksource *c)
> +static u64 ep93xx_clocksource_read(struct clocksource *c)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 ret;

--=20
Alexander Sverdlin.

