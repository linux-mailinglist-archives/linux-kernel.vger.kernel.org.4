Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5E16323C9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiKUNfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiKUNfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:35:21 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE7A9BA35
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:35:19 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-381662c78a9so113405597b3.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AkVA2gbeFi41E2HoJZX47IA5XRYqAdo+42G6zXfvCrQ=;
        b=i9nqHc5IEDhPKfUr6eMNAh6EdyZR4XMALZr8+66IAoeOPqMfROST8/8XnGVQe0zln+
         qv53OnWiNFO23QfMIglLPbz66RSWhqn/9YQXFJg/6WYULqf0rd5Lm3DT/FLnQ9gljs16
         l4QhEYH3ZvKgtFrhZi0UPfnry7VBJ+CZ88v6mqLCFk/bFqu1dvQO4lJPQkZw2brAfdfK
         X6Q1EzIxIA5dWbqSQPBGT1ZFNIkF0i4cWPqjr+Nziau3uyXd5BMk4qn9j07yq9dH/8Qw
         wzn3R6SCxW5x0kLeyxyalVAG7jHtmENlAMKmM+yM5hVHAOTgP8YGUtFn0O11eRHV0gzY
         rGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AkVA2gbeFi41E2HoJZX47IA5XRYqAdo+42G6zXfvCrQ=;
        b=AMnGA/3TZLf9XGiClfdwOmWPFoeldFVabSyFcnJbrewn2GMe1HeFuf//wHYTIXqVsM
         OF1KC4e+a5GxVPPPNO0v/n9mYB6dP7SUWFwgD6O8dG6W7Z0NYLAvmAwUlDPMTkm3+4Fh
         i2GwozYsehE3NjijP6G+eswAMA10weJhKftK1wpqlEAudK+hBCU7IGvaEWo1gz/8Cc7N
         b4KaxCF3QjH+gocZjaiE8Bwp4PPUrCf6Il8ONGahdxubwT6+pRkYEcgZUio388fEt0iY
         exWeWtf7VVvothPUw3Q2UD6YGRmZG2/Gzsoi/EybKrAz+iqjHUNNQOcfV6Y2/xuB0Gfu
         bi5w==
X-Gm-Message-State: ANoB5pkZGTb+ecVQFf8lhaTBu3sf5czaLj4PNbPqF49MsK7lowuKY+Rw
        W0oQOn6yBjklE79tLc6eCMfwh5PdJCvGmYfFeqYWpw==
X-Google-Smtp-Source: AA0mqf6kCQEkXvgtxPXnOtB2Jg0JrJ3oxTygO5M6P+rnA9h5wQGHzpYbv2SCj1hVgEqRmMGmHzgiN1DYYtFhJDxBA/w=
X-Received: by 2002:a0d:fdc7:0:b0:37a:e8f:3cd3 with SMTP id
 n190-20020a0dfdc7000000b0037a0e8f3cd3mr17064548ywf.187.1669037719041; Mon, 21
 Nov 2022 05:35:19 -0800 (PST)
MIME-Version: 1.0
References: <20220906204922.3789922-1-dmitry.torokhov@gmail.com>
 <88VJLR.GYSEKGBPLGZC1@crapouillou.net> <Y3ernUQfdWMBtO9z@google.com>
 <Y3fF/mCUVepTfTi+@lunn.ch> <Y3fHF9b1YoVTj/jL@google.com>
In-Reply-To: <Y3fHF9b1YoVTj/jL@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Nov 2022 14:35:07 +0100
Message-ID: <CACRpkdb=O_dUn6hUrAS1yYZxBR1ZPADtTb9GbLBANHUxcm3sUg@mail.gmail.com>
Subject: Re: [PATCH 1/3] net: davicom: dm9000: switch to using gpiod API
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Paul Cercueil <paul@crapouillou.net>,
        "David S. Miller" <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 6:55 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Fri, Nov 18, 2022 at 06:50:54PM +0100, Andrew Lunn wrote:
> > > > Why is that 1 magically turned into a 0?
> > >
> > > Because gpiod uses logical states (think active/inactive), not absolute
> > > ones. Here we are deasserting the reset line.
> >
> > This is the same question/answer you had with me. Maybe it is worth
> > putting this into the commit message for other patches in your series
> > to prevent this question/answer again and again.
>
> Right... Actually I think I'll go and define that GPIO_STATE_ACTIVE/
> GPIO_STATE_INACTIVE and try to get Linus and Bart to accept it as code
> speaks louder than words ;)

What I have said about that is that it should be accompanied by some sed
or cocinelle script to change this everywhere in the kernel instead
of using 0/1 to the gpiod_set/direction etc functions. Then Torvalds
can run that toward the end of the merge window to just change this
everywhere at once and be done with it.

The reason I want it that way is that I am royally tired of changes that
begin in one tiny corner and then the change keeps confusing users
for years until it is finally fixed up 15 kernel revisions later.

Since that has created a support nightmare in the past, I am now
advocating an all-or-nothing approach with that type of change.

Yours,
Linus Walleij
