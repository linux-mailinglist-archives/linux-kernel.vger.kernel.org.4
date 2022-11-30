Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EB963E1D0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 21:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiK3UX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 15:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiK3UW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 15:22:57 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AB82AFA;
        Wed, 30 Nov 2022 12:21:29 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-3a7081e3b95so183342147b3.1;
        Wed, 30 Nov 2022 12:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/E33WRItmkoiLgpHDHd24EmIcJsNGQPAC7NQMjlLAgo=;
        b=evY1rXJKVKWb3sgc1Zd+kNKUwFZR8XT+XEsQIFIOsi+1jnzs47YHmQRW6OzLy4Xay1
         KI2cGjwBHegJJuzuaROFf0+mpgTCEx2oKA+GjgbvG8t4C/TJ+0ZbLFNPahJdwarIf8od
         Wtk+Yvq2pEaTqp8NBvXzV3bWj781yLKxNft/aooRBgBR5ChEvcFDIFn+5nYLWQrp1W1Y
         iCkH7WB0mBgSQvkyuyVeBQkZRar9F0w8wq0y1OWrkF1rP0XPgSQRoJwGGmjoeSS/p+/D
         PzS4+Uo6oicJ3lGsZMTYFbIbX3Y2kMjOn4CUFnNS6VjGoqAg31p92NJRT1RNpxPPfMbC
         2cGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/E33WRItmkoiLgpHDHd24EmIcJsNGQPAC7NQMjlLAgo=;
        b=iD5giEzTq3MvfTNWKiHClvXfEws1pOwy7wFd9SY/QZbNpAjKnIZSwhbFj0QFxLOuB+
         m3YQEGxJghire0mI/wb5L5lz8CP4KFvq3O7cIMsCjEt02tQoeOTH2iVMSwOo57IB3L0m
         PPyQJVd10saFVacp8egIm3j9PiJHr0b8Ovz8kPnyQEyo0sSEKSRfxBkZDrMLTR0zz/sN
         2A191sh0RseK3ljTzyGqPeghGGrr5cHivjovZWaqtYP6cs4IhbuntD9T15Qk3YPXeBwT
         hdCpgQITtO/Y0LDwv2US4wrzy2DPQIOx/aOY7iVpl1h2SnRQrBocWmy3RvDIXV316ObU
         F5YQ==
X-Gm-Message-State: ANoB5pmAXkFhcrHueIRS8yDjrbWijUu4wFHGja00ymGBVrVGQMu3v8nZ
        hhSmMjHmj/9wQEfpG4MVCu3Tp7k5yWMy837q0oU=
X-Google-Smtp-Source: AA0mqf4QYVeo8noGqZEeUSQP0QhYgoUL9V5zvLRwNvCg7F5rTZturd/1+QWGiFv5o3YnBp/PokoRl9Q0AlpS0hzTsWY=
X-Received: by 2002:a0d:ea8c:0:b0:3c3:5477:68c1 with SMTP id
 t134-20020a0dea8c000000b003c3547768c1mr19055436ywe.464.1669839688853; Wed, 30
 Nov 2022 12:21:28 -0800 (PST)
MIME-Version: 1.0
References: <20221107105657.19002-1-lukas.bulwahn@gmail.com> <CAJZ5v0jFO=6WLNZUe4vqUXxxWuhZuaq1Sifk7+094YFXUWp2wA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jFO=6WLNZUe4vqUXxxWuhZuaq1Sifk7+094YFXUWp2wA@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 30 Nov 2022 21:21:18 +0100
Message-ID: <CAKXUXMz_M5z00yZiBkYWxBmuQGFwMD4JwMH11qs4EHfPOawUvQ@mail.gmail.com>
Subject: Re: [PATCH] notifier: repair slips in kernel-doc comments
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 7:34 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Nov 7, 2022 at 11:57 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >
> > Invoking ./scripts/kernel-doc -none kernel/notifier.c warns:
> >
> >   kernel/notifier.c:71: warning: Excess function parameter 'returns' description in 'notifier_call_chain'
> >   kernel/notifier.c:119: warning: Function parameter or member 'v' not described in 'notifier_call_chain_robust'
> >
> > These two warning are easy to fix, as they are just due to some minor slips
> > that makes the comment not follow kernel-doc's syntactic expectation.
> >
> > Fix those minor slips in kernel-doc comments for make W=1 happiness.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > Rafael, please pick this minor non-urgent patch for your pm tree. Thanks.
>
> Applied as 6.2 material, but I'm kind of wondering why you decided to
> send this to me.
>

Well, kernel/notifier.c is one of those files, with no specific
maintainer and no specific obvious subsystem... so the next patch goes
to the last one touching it ;)

More seriously:

get_maintainer.pl -f kernel/notifier.c does state:

"Rafael J. Wysocki" <rafael.j.wysocki@intel.com> (commit_signer:2/3=67%)

Rafael, you took the only two patches in 2022 and carried them forward
to Linus. So, that was my thinking for this minor patch as well; no
deeper thought than that.

If you would not have accepted them, I might have tried Andrew Morton
in a few weeks for the next merge window (v6.3) as a last resort.

Rafael, thanks for picking up this patch.

Lukas

> >
> >  kernel/notifier.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/notifier.c b/kernel/notifier.c
> > index 0d5bd62c480e..ab75637fd904 100644
> > --- a/kernel/notifier.c
> > +++ b/kernel/notifier.c
> > @@ -62,7 +62,7 @@ static int notifier_chain_unregister(struct notifier_block **nl,
> >   *                     value of this parameter is -1.
> >   *     @nr_calls:      Records the number of notifications sent. Don't care
> >   *                     value of this field is NULL.
> > - *     @returns:       notifier_call_chain returns the value returned by the
> > + *     Return:         notifier_call_chain returns the value returned by the
> >   *                     last notifier function called.
> >   */
> >  static int notifier_call_chain(struct notifier_block **nl,
> > @@ -105,13 +105,13 @@ NOKPROBE_SYMBOL(notifier_call_chain);
> >   * @val_up:    Value passed unmodified to the notifier function
> >   * @val_down:  Value passed unmodified to the notifier function when recovering
> >   *              from an error on @val_up
> > - * @v          Pointer passed unmodified to the notifier function
> > + * @v:         Pointer passed unmodified to the notifier function
> >   *
> >   * NOTE:       It is important the @nl chain doesn't change between the two
> >   *             invocations of notifier_call_chain() such that we visit the
> >   *             exact same notifier callbacks; this rules out any RCU usage.
> >   *
> > - * Returns:    the return value of the @val_up call.
> > + * Return:     the return value of the @val_up call.
> >   */
> >  static int notifier_call_chain_robust(struct notifier_block **nl,
> >                                      unsigned long val_up, unsigned long val_down,
> > --
> > 2.17.1
> >
