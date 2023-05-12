Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D3E7003AB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240451AbjELJZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240446AbjELJY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:24:56 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F362ADDA6;
        Fri, 12 May 2023 02:24:51 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 336505FD6C;
        Fri, 12 May 2023 12:24:49 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1683883489;
        bh=GSEauJwVGUEtIex83oapmFFrZA/IEWwkf1cUksaKAB4=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=HwAVtUfxIBjXUmqEw6DXyfdhs3UkCGZ1U8bvRnXX3P5zY8p9PsB4ZjaxKvJp5PIz8
         hf4DvesPGAVcQ+ad8Fk5KmdBzbkPPAwp4rTOl+PPXJN2FE+Vn3gBDi8L5Ah9Nh4JpS
         PoTs+M6y6Ww+tUyGMrDi4NoSjAVzz8kdTN7YOTR64G2UGZJwo4ZGQyUnxjovlVswRB
         PEq4/5Y5SXfbswkoxgl36wArRw5TQOLotHUOYY9qCEXp7RquwLEYiAFyiYp85/jXq4
         n5R1d2jjeWbPWhjYUUrho2xTop6z/8SEYKhaEERCpEfm7RpbARdOLO0I7QywrWDNqN
         E7KhFwMxOuYtw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri, 12 May 2023 12:24:46 +0300 (MSK)
Date:   Fri, 12 May 2023 12:24:46 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>, <stable@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] pinctrl: meson-axg: add missing GPIOA_18 gpio
 group
Message-ID: <20230512092446.kxrjvk73xqpfdmjf@CAB-WSD-L081021>
References: <20230512064925.133516-1-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230512064925.133516-1-martin@geanix.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/12 06:31:00 #21267308
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 08:49:25AM +0200, Martin Hundebøll wrote:
> Without this, the gpio cannot be explicitly mux'ed to its gpio function.
> 
> Fixes: 83c566806a68a ("pinctrl: meson-axg: Add new pinctrl driver for Meson AXG SoC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Martin Hundebøll <martin@geanix.com>

Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

> ---
> Changes since first mail:
>  * Added Cc: stable to commit message
>  * Expanded To: and Cc: with full list from get_maintainers.pl
> 
>  drivers/pinctrl/meson/pinctrl-meson-axg.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg.c b/drivers/pinctrl/meson/pinctrl-meson-axg.c
> index 7bfecdfba177..d249a035c2b9 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson-axg.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson-axg.c
> @@ -400,6 +400,7 @@ static struct meson_pmx_group meson_axg_periphs_groups[] = {
>  	GPIO_GROUP(GPIOA_15),
>  	GPIO_GROUP(GPIOA_16),
>  	GPIO_GROUP(GPIOA_17),
> +	GPIO_GROUP(GPIOA_18),
>  	GPIO_GROUP(GPIOA_19),
>  	GPIO_GROUP(GPIOA_20),
>  
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

-- 
Thank you,
Dmitry
