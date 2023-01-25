Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD62067AE3C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 10:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbjAYJkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 04:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjAYJkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:40:21 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270A02716;
        Wed, 25 Jan 2023 01:40:20 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 035163200951;
        Wed, 25 Jan 2023 04:40:16 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 25 Jan 2023 04:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674639616; x=1674726016; bh=mVnLaWhnWq
        piceQjqtY4G7r56a9ztAu8ycJAfseC+RE=; b=FHaO0ny/uYgy9ZYtBeUQgaDfx4
        two+K4Ff6AL1mh1RKLm2/rHiqlGB4pmEGee8spf4yBIrqWRYjb0seYmIHkF1C5sQ
        aO+Ym65d5j4I/IS4bWocAa1YttMW7x+XGe0ISfFIh9PT2LAM/21JQgQZD1Z0x+Zr
        T5Hq9xOq+w2noZUizKuu1ldi0gOI/YrCmxGYdSpql0axhznmiJchgM7T9xtVeUol
        M6c3vWmrdTlJyvMShro3Wd/AmpG1bt1v3/SSlK2rK/nOJvsRPHQ8QaffmiveaQ75
        PpTAn3q7ETCnJCOKGTWUKNXsesjoUPPviG/WPiWT8+pNqMXhaLFFjy09PaLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674639616; x=1674726016; bh=mVnLaWhnWqpiceQjqtY4G7r56a9z
        tAu8ycJAfseC+RE=; b=TXXMEY0yaBKp6nhpJbq127eJSwDhHPUCt8tNJx7LCII9
        a7i/lQzlfd0mYCnbSADEYIXPWtHXEi1ySj1RjyUzDRRih6zd1vYDgWPfO6lvEnA7
        8F7K+Sn0Df+8Zk98KO9z+q/KNL7o/JN3tw9ojTElr7SmP55xh9daQU2ZuEEnwAAk
        AXbIXX0wutgd7BhoWY2XepGWT12Dk+pC+Koyi5SERIutCqAQOoiR/zNFtAvQNFaa
        sWB2k9hrDSLZbsfe7QzbgzbI44uCnSaccHM/WnA0AKZGB9FKkmpBTk5/EwhPBPzY
        5LXIBkEWrN2eO62S1iJ+aJVFDS6ncvc4n9hY03Ee9g==
X-ME-Sender: <xms:__jQYwKzyy64Q46l2fp-gaSFVtLPE9iPIUgEugqYnqsVVjDvik6oMw>
    <xme:__jQYwIgXfkuUwDrwubzQvgGUSNpf-ltT1GIzSt46LeX6J44m8LuWem4tZTDJcFO1
    5gI0e9X0TsEMw2ceU4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvvddgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:__jQYwvFoAxXo2ZJX4M7RvVBcblxiy-2uS1iGJ8qbHaeJ06QMLDymQ>
    <xmx:__jQY9Yzg0autAV8v_lTIqaomz3TCkukojyKNQueRuVbHMGod73wYA>
    <xmx:__jQY3Ya-3_W-EPE7LQHCG7YoLx9-oMgV40AlgjPCf6-4GuOLKBmCw>
    <xmx:APnQY76uNj4ajFm7QU_WjE09raXk2uoQVpUyTxfBjo1msXG7zO9yqg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BB115B60089; Wed, 25 Jan 2023 04:40:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <918952b8-6687-42ab-82af-b64c8db7e191@app.fastmail.com>
In-Reply-To: <20230125083026.5399-2-nikita.shubin@maquefel.me>
References: <20230117100845.16708-1-nikita.shubin@maquefel.me>
 <20230125083026.5399-1-nikita.shubin@maquefel.me>
 <20230125083026.5399-2-nikita.shubin@maquefel.me>
Date:   Wed, 25 Jan 2023 10:39:57 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Nikita Shubin" <nikita.shubin@maquefel.me>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Cc:     "Hartley Sweeten" <hsweeten@visionengravers.com>,
        "Alexander Sverdlin" <alexander.sverdlin@gmail.com>,
        "Russell King" <linux@armlinux.org.uk>,
        "Lukasz Majewski" <lukma@denx.de>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] gpio: ep93xx: Fix port F hwirq numbers in handler
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023, at 09:30, Nikita Shubin wrote:
> Fix wrong translation of irq numbers in port F handler, as ep93xx hwirqs
> increased by 1, we should simply decrease them by 1 in translation.
>
> Fixes: 482c27273f52 ("ARM: ep93xx: renumber interrupts")
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Cc: stable@vger.kernel.org # v5.19+
Acked-by: Arnd Bergmann <arnd@arndb.de>


> ---
>  drivers/gpio/gpio-ep93xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
> index 2e1779709113..7edcdc575080 100644
> --- a/drivers/gpio/gpio-ep93xx.c
> +++ b/drivers/gpio/gpio-ep93xx.c
> @@ -148,7 +148,7 @@ static void ep93xx_gpio_f_irq_handler(struct irq_desc *desc)
>  	 */
>  	struct irq_chip *irqchip = irq_desc_get_chip(desc);
>  	unsigned int irq = irq_desc_get_irq(desc);
> -	int port_f_idx = ((irq + 1) & 7) ^ 4; /* {19..22,47..50} -> {0..7} */
> +	int port_f_idx = (irq & 7) ^ 4; /* {20..23,48..51} -> {0..7} */
>  	int gpio_irq = EP93XX_GPIO_F_IRQ_BASE + port_f_idx;
> 
>  	chained_irq_enter(irqchip, desc);
> -- 
> 2.37.4
