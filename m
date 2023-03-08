Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CF66B132F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 21:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjCHUgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 15:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCHUgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:36:11 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B23CC315
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 12:35:44 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so56332pjp.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 12:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678307744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xb3oXL/582pA/8xkedQpp0d04qUqIawwKO53Qn/8m1w=;
        b=gJ5rbHxi/B0bqOQnKay63aFibmzKUa8nEOG2XWBQHh6lfedaEagtMEoAUPZv79vl6j
         NRKcYQxlEiORecnQphxZm2xyKWhWqtQf/8aD3GP5aK6A6ZeQhgTptGySneyJAoDGfmnA
         TGOh6oDNo52qqH0f1xGDnh0LSXe+7KCLgLqAevu+IQE90QRfjiO6q6WHa1oDQeBbbjJy
         ZGP7FIBTu+ZC1eWCjAAt8nAirvElhq4RZbIHxi+i5JD1aRFi6FDRpg/sV0tT83cLYyGD
         D3mA+exSObhnhXeqDlia3plR6HgIwECtlzrKOdsTp3wvvjj4Vns32exzmUmqqmqwneeY
         Ol2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678307744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xb3oXL/582pA/8xkedQpp0d04qUqIawwKO53Qn/8m1w=;
        b=zoP8HR1P1xJkS+ochGder8YIgB6NsFV2QSOCRuxv+Z9JjLOfr2RM5iLMNb+ez96XcM
         /WMjg04t0eXLqq1i+5A5rQIXRyzzEcKGW+JuV1PSfPFl+BuQqJx0VQdRVtK+JDG6g9pL
         1M9UPq4zRDkpEd8qUlj01ZUvVBmg0CPhnjODuqB4/pC7f+y70Or+p+VLQHhSOj6VUlQx
         LPJLFLpk9OguxDo2F7D0e2q/rcfOayU7mUMAp8dcjw8ZuqEfDg+HU/6MqR9ogaoq4vSm
         LAwOYl8ROPsBDhnJuCySObM8Fn5M03uI9H0IeIGmcxJtm5naS8yg4m6AbtMjps2YDvlX
         2EFA==
X-Gm-Message-State: AO0yUKVj/jPhxGk/YLPU5ASBPEFDd3+Nu0H+5+vQUCYzn2IfYgXCopFK
        xtmlVYvqTWsE6EOxKztIbpyHtLCgCCQ2Hl/78KEdrQ==
X-Google-Smtp-Source: AK7set9I/RIVkOIbZ4hE7+iXxtoC2iLTaQTWzwpVeG4RLK48BT44yU4/UX6KNxuISfGHjZ+wetbJ3bcAMqgnEaZakl4=
X-Received: by 2002:a17:903:48b:b0:19a:fdca:e405 with SMTP id
 jj11-20020a170903048b00b0019afdcae405mr7856731plb.10.1678307743998; Wed, 08
 Mar 2023 12:35:43 -0800 (PST)
MIME-Version: 1.0
References: <20230302014639.297514-1-saravanak@google.com> <CACRpkdacG4yxtZqwG5hKRY_8nY9qWeNPb-ZttMCnFH7ojZ3kCA@mail.gmail.com>
 <CAGETcx-W3o=rQoVLnKkvk=oTAMiwEcqAZ_trcMPBuune-7Hoiw@mail.gmail.com>
 <32edd2dd9557b7e3debbd8f1bccccd8d.sboyd@kernel.org> <20230308160140.GA2347814@dev-arch.thelio-3990X>
In-Reply-To: <20230308160140.GA2347814@dev-arch.thelio-3990X>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 8 Mar 2023 12:35:07 -0800
Message-ID: <CAGETcx-mHPrBamtX7=+3wHjXprrngnsVoMnBAp_jehByZO64pw@mail.gmail.com>
Subject: Re: [PATCH v2] clk: Mark a fwnode as initialized when using
 CLK_OF_DECLARE() macro
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@android.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 8:01=E2=80=AFAM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> On Mon, Mar 06, 2023 at 11:15:54AM -0800, Stephen Boyd wrote:
> > Quoting Saravana Kannan (2023-03-03 13:24:00)
> > > On Thu, Mar 2, 2023 at 5:14=E2=80=AFAM Linus Walleij <linus.walleij@l=
inaro.org> wrote:
> > > >
> > > > Works like a charm on U8500!
> > > > Tested-by: Linus Walleij <linus.walleij@linaro.org>
> > > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > >
> > > Stephen, Does this look good? Can we have Greg pull this in?
> > >
> >
> > I picked it up for fixes. Will send it off later this week.
>
> This change causes a build regression:
>
>   drivers/clk/mvebu/kirkwood.c:358:1: error: expected identifier or '('
>   CLK_OF_DECLARE(98dx1135_clk, "marvell,mv98dx1135-core-clock",
>   ^
>   include/linux/clk-provider.h:1367:21: note: expanded from macro 'CLK_OF=
_DECLARE'
>           static void __init name##_of_clk_init_declare(struct device_nod=
e *np) \
>                              ^
>   <scratch space>:124:1: note: expanded from here
>   98dx1135_clk_of_clk_init_declare
>   ^
>   drivers/clk/mvebu/kirkwood.c:358:1: error: invalid digit 'd' in decimal=
 constant
>   include/linux/clk-provider.h:1372:34: note: expanded from macro 'CLK_OF=
_DECLARE'
>           OF_DECLARE_1(clk, name, compat, name##_of_clk_init_declare)
>                                           ^
>   <scratch space>:125:3: note: expanded from here
>   98dx1135_clk_of_clk_init_declare
>     ^
>   drivers/clk/mvebu/kirkwood.c:358:1: error: invalid digit 'd' in decimal=
 constant
>   include/linux/clk-provider.h:1372:34: note: expanded from macro 'CLK_OF=
_DECLARE'
>           OF_DECLARE_1(clk, name, compat, name##_of_clk_init_declare)
>                                           ^
>   <scratch space>:125:3: note: expanded from here
>   98dx1135_clk_of_clk_init_declare
>     ^
>   drivers/clk/mvebu/kirkwood.c:358:1: error: invalid digit 'd' in decimal=
 constant
>   include/linux/clk-provider.h:1372:34: note: expanded from macro 'CLK_OF=
_DECLARE'
>           OF_DECLARE_1(clk, name, compat, name##_of_clk_init_declare)
>                                           ^
>   <scratch space>:125:3: note: expanded from here
>   98dx1135_clk_of_clk_init_declare
>     ^
>   4 errors generated.
>
> The clock's name starts with a number, resulting in an invalid C
> function name. Are clock names ABI? Should this be fixed by adjusting
> the name like so or adjusting where the name appears in the function
> defined by CLK_OF_DECLARE()?
>

Not sure if the name matters, but it's just simpler to fix the macro
than add churn to all those drivers. Can you send a patch that just
adds __ in the front of the function name in the macro please?

Thanks,
Saravana

> diff --git a/drivers/clk/mvebu/kirkwood.c b/drivers/clk/mvebu/kirkwood.c
> index 8bc893df4736..5d0a7e3bfde5 100644
> --- a/drivers/clk/mvebu/kirkwood.c
> +++ b/drivers/clk/mvebu/kirkwood.c
> @@ -355,5 +355,5 @@ CLK_OF_DECLARE(kirkwood_clk, "marvell,kirkwood-core-c=
lock",
>                kirkwood_clk_init);
>  CLK_OF_DECLARE(mv88f6180_clk, "marvell,mv88f6180-core-clock",
>                kirkwood_clk_init);
> -CLK_OF_DECLARE(98dx1135_clk, "marvell,mv98dx1135-core-clock",
> +CLK_OF_DECLARE(mv98dx1135_clk, "marvell,mv98dx1135-core-clock",
>                kirkwood_clk_init);
>
> Cheers,
> Nathan
