Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D828697A8A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 12:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjBOLT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 06:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbjBOLTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:19:48 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0030F36FC5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 03:19:46 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-4a263c4ddbaso261066707b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 03:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+8F+e95XyJn3VRrfkZ55H7YN7SZDmK15NTGFxVooh6Y=;
        b=gHylAZTZlgrZaME8Omi9f/L7x7tUIq/551FNEX6L8VnxQy7NF1MR+aFqS2obcTcbP8
         cYuIOH2XsvQ0IS6Z5S9QdheEeTBb+1N7PuYfghIChLchi9RJvD7487p0/a742BXSe1hV
         3SSE+1odm/3BpkLKWxCV1HQiylO1HZCvuKImqlF9d/QF2PwYQ33o6QoempgitayqRjFe
         zhYOt5HSuk9fftkhiiOSoMp3C3uKJ14mNo46PzmXA45a0MuN6Hy/vpS4M8N/Ahwqle3R
         tVSABtMz4UFW+qvhTeHiGAtFNSCyCP5Zwcpn9zjfiU0aCaWWWsQeXJ7boaaE+9RwBze+
         BEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8F+e95XyJn3VRrfkZ55H7YN7SZDmK15NTGFxVooh6Y=;
        b=WLtDmHHIU+M6ntiPwk03OIs7/SzTkwgOVKTwLTsx1C6t7H5AWBSYp9iKYkppCxIz/N
         lfrOT4kD4dTtKkYZB5bf99pHTykhI8YFd+b+shXKdQiOk8pnnZuW3rFTEnLOcJ5Lulul
         4GQGvVlyDabQ2tMIIjJeyEigB5istSUgQ5e76aM+6buivj+yU7t/LuswDkQGP5mAZk1G
         yOvHou2BiFIX2QaksAH2RlcBtmBtYMCP0LkcDDL+9SmTAovK4cQe6HhiSZH6nQUCGa8V
         WXM2Bq8ExBq7d3KClFuSIZJ3gZupeOhNmrF38Zlp/kr/Mxxkw5Ap6y2XKaSm7sAfOoEC
         /34g==
X-Gm-Message-State: AO0yUKXmxW/XgsTv9QxMlSCcbIob9COODs3d0Xg1/vv0WI6LmnJyF8ne
        OLEdTp4mqOMxIHsM7yqcT0oEOpTrNLOaKUPESTGwaQ==
X-Google-Smtp-Source: AK7set9Mlkcpct+fBz8sAQ2fqvSnQn7EG5sAATr614rSakSCnuj5zsd+v6oN+cx6qtWruB3T+60/X9grWCsvuWi4VSI=
X-Received: by 2002:a0d:e802:0:b0:526:a392:c07e with SMTP id
 r2-20020a0de802000000b00526a392c07emr237308ywe.106.1676459986193; Wed, 15 Feb
 2023 03:19:46 -0800 (PST)
MIME-Version: 1.0
References: <20230214073638.571417-1-alexander.stein@ew.tq-group.com>
 <Y+tn3Y+SraIetn5X@surfacebook> <CACRpkdYHJOgO9K_H9QA1_VWgParbh+Xqh-oCmo3JAFtaMXYByg@mail.gmail.com>
 <4497001.LvFx2qVVIh@steina-w>
In-Reply-To: <4497001.LvFx2qVVIh@steina-w>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Feb 2023 12:19:33 +0100
Message-ID: <CACRpkdbh=_byRn3KcugVeqEA98RZxA42k+-5pyJ5OZ1cSMoctA@mail.gmail.com>
Subject: Re: [PATCH 1/1] gpio: vf610: make irq_chip immutable
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     andy.shevchenko@gmail.com, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 12:09 PM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
> Am Mittwoch, 15. Februar 2023, 11:18:06 CET schrieb Linus Walleij:
> > On Tue, Feb 14, 2023 at 11:52 AM <andy.shevchenko@gmail.com> wrote:
> > > Tue, Feb 14, 2023 at 08:36:38AM +0100, Alexander Stein kirjoitti:
> > > > Since recently, the kernel is nagging about mutable irq_chips:
> > > >     "not an immutable chip, please consider fixing it!"
> > > >
> > > > Drop the unneeded copy, flag it as IRQCHIP_IMMUTABLE, add the new
> > > > helper functions and call the appropriate gpiolib functions.
> > >
> > > ...
> > >
> > > > The overall changes are based on commit f1138dacb7ff
> > > > ("gpio: sch: make irq_chip immutable")
> > >
> > > Nice, but you forgot one crucial detail. You need to mark GPIO resuested
> > > whenever it's locked as IRQ and otherwise when unlocked.
> >
> > +static const struct irq_chip vf610_irqchip = {
> > (...)
> > +       GPIOCHIP_IRQ_RESOURCE_HELPERS,
> >
> > That's what this macro does ;)
>
> Does this mean the calls to gpiochip_disable_irq/gpiochip_enable_irq in v2/v3
> are not necessary?

No I guess I just misunderstood Andy's comments about "mark GPIO requested".
The callbacks to gpiolib are needed just like pointed out by Marc Z in his
answer, these callbacks are indeed needed.

Yours,
Linus Walleij
