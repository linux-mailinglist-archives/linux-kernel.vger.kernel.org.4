Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742BE6E0B04
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjDMKHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjDMKG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:06:58 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3131C7285;
        Thu, 13 Apr 2023 03:06:54 -0700 (PDT)
Received: (Authenticated sender: kamel.bouhara@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2955EE000B;
        Thu, 13 Apr 2023 10:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1681380413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=st4qOHiye8rh9wqwQDVyg+uFBmH5X7ITDgsye87N3g4=;
        b=Qb00LY/g3Bucveqz/5gM1XOjLEV9wlcJTs/BegrboLcmNrmf+/QW5X+4ugFFt/cQjkGowt
        wHxIZiFqH9CDYX/Cm3/Oqz4Vqhb4aZWAC60b18nKtAo8W4EX+sbSsRMfa6CWkWnGEYR8a2
        Oe1/iwkudW/uIQPRdaIJrnX97MTXTPJUQ/8JjvM0+sn9dQP50tPLhr3uHz0aDytteV8su1
        mOHOVoNXyKfjPgx52zmz8W9aKk0tSbHKYBApGORN8br3zrK3S3Y4BqtJFTGnDa/ilIskIP
        ZD+HQXZQL+8GH84PuX2ouC3lPjxaSN4/8GL3wv2snqBy3uo8PhHMNaakK/wJEQ==
Date:   Thu, 13 Apr 2023 12:06:50 +0200
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        metux IT consult <lkml@metux.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        stratos-dev@op-lists.linaro.org
Subject: Re: [PATCH] gpio: aggregator: Add interrupt support
Message-ID: <20230413100650.GC16381@kb-xps>
References: <c987d0bf744150ca05bd952f5f9e5fb3244d27b0.1633350340.git.geert+renesas@glider.be>
 <58f91e983ac95b7f252606ecac12f016@bootlin.com>
 <CAMuHMdVqyY=tg6iU4feRwQhPt9c7ZZK9ifBCYf5AAgkxWjYOBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVqyY=tg6iU4feRwQhPt9c7ZZK9ifBCYf5AAgkxWjYOBA@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Thu, Apr 13, 2023 at 10:54:34AM +0200, Geert Uytterhoeven a écrit :
> Hi Kamel,
>

Hello Geert,

> On Thu, Apr 13, 2023 at 9:48 AM <kamel.bouhara@bootlin.com> wrote:
> > Le 2021-10-04 14:44, Geert Uytterhoeven a écrit :
> > What is the status for this patch, is there any remaining
> > changes to be made ?
>
> You mean commit a00128dfc8fc0cc8 ("gpio: aggregator: Add interrupt
> support") in v5.17?
>

Sorry, I was checking on a v5.15 :) and based on the thread, I tough it
was still not applied !

Thanks.

Cheers,

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

--
Kamel Bouhara, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
