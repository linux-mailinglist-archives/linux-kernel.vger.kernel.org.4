Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7679C61A2B8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiKDUxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKDUxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:53:06 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD4D49B51
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 13:53:04 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so9306599pji.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 13:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dT53fcIb/e9PoLshhWJTyrDPvuuSKTjXYFWON0fSCp4=;
        b=VGk2BfsPPxk6pOhXuOvOy+3gNLTyiNSav+p0N+RgNaTszdYExYk9Rv81HJKjt9lTGt
         YWjnTO5m3SK7tYhPS1kw9vsq8kqn49g7ounMn5TU5ljHoGFGK71tb6O5Lgvc23NbEzXb
         LVQ0CwAT9/JVHZfu7S/KiKE0qyzRrMHECoNfhMgNO9xk9qC8OHgQ/NxxHx3cRQn2y12G
         aPoi5Bz8Qfavdyh3kQgISoo0T5XEDK8LVEJU43xe8vRzNDOpLmVpeWrg9HkbYlhXicgO
         TGJr1E8w2YwfhQUZrPDR9NOCGcJhc/W0TQ8oaPUo8jYAhG8ftmOVtY3owApLCDi3LwkO
         dmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dT53fcIb/e9PoLshhWJTyrDPvuuSKTjXYFWON0fSCp4=;
        b=a943Zz6TCOkH/Cy4XxAZwAx07rjnC2SBvzHwlovMW2qCA9/A8rgd2f1BFIHvvT/A7Q
         5HSwqrN/tt15i8iSW1QOgO1V/bFoDKfZaHzspBCNFyYvg344nhHkyKFMz3b/4Q5nEnQU
         +AAbeaR6sLEOniWnxvVbPlnV3ir+thqcf4nzsGnxvTjuvMz53gqQQW4k1Fq4yJfFcvZA
         2uZ/4I+BD9lnA6lCCsDxKD4nWjg2jq23uV7wuxZyWQL7NThkYOHVhL4lj8+LBjYP33Hv
         lv1rAyopBt3nAW2BAFbzviFV4UewSxwJeG1LtNKho5ewRU0Xnsf27py1bfA5+G3c6gQS
         IgTw==
X-Gm-Message-State: ACrzQf1tWdJUAzkTdGQO8U2ceqzETcRKzfBjNy5FNJXrcNpQ6ga6vade
        qB9Qa3rY7ypPvmw4bWJdXWECQ8fPtpzQyyiEq7M=
X-Google-Smtp-Source: AMsMyM7+zkbn82MBrNvYdD3ZdPXuPww5rOwg74bhtmffE7T48sLmiBgbQZ7zXDJ09ArWrdhHnlXkDn4C7LE0UGAWWks=
X-Received: by 2002:a17:903:3291:b0:179:c436:4528 with SMTP id
 jh17-20020a170903329100b00179c4364528mr387000plb.102.1667595184532; Fri, 04
 Nov 2022 13:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20221103213641.7296-1-shy828301@gmail.com> <20221103213641.7296-2-shy828301@gmail.com>
 <Y2Tc2JNeFWXmZbQ1@dhcp22.suse.cz> <Y2ThtYKSxoP9S44i@dhcp22.suse.cz>
 <CAHbLzkpvZ05+xSGWLCYKJntsLGzdda449XpjCH7sRE-3S8h+0g@mail.gmail.com> <Y2VtNfkwciJ5hHF6@dhcp22.suse.cz>
In-Reply-To: <Y2VtNfkwciJ5hHF6@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 4 Nov 2022 13:52:52 -0700
Message-ID: <CAHbLzkrcqc4rcH4iq3tU81=AsFi6MMpkwAFbdJf2vVPDy5HoXA@mail.gmail.com>
Subject: Re: [v2 PATCH 2/2] mm: don't warn if the node is offlined
To:     Michal Hocko <mhocko@suse.com>
Cc:     zokeefe@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 4, 2022 at 12:51 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 04-11-22 10:42:45, Yang Shi wrote:
> > On Fri, Nov 4, 2022 at 2:56 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Fri 04-11-22 10:35:21, Michal Hocko wrote:
> > > [...]
> > > > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > > > index ef4aea3b356e..308daafc4871 100644
> > > > --- a/include/linux/gfp.h
> > > > +++ b/include/linux/gfp.h
> > > > @@ -227,7 +227,10 @@ static inline
> > > >  struct folio *__folio_alloc_node(gfp_t gfp, unsigned int order, int nid)
> > > >  {
> > > >       VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
> > > > -     VM_WARN_ON((gfp & __GFP_THISNODE) && !node_online(nid));
> > > > +     if((gfp & __GFP_THISNODE) && !node_online(nid)) {
> > >
> > > or maybe even better
> > >         if ((gfp & (__GFP_THISNODE|__GFP_NOWARN) == __GFP_THISNODE|__GFP_NOWARN) && !node_online(nid))
> > >
> > > because it doesn't really make much sense to dump this information if
> > > the allocation failure is going to provide sufficient (and even more
> > > comprehensive) context for the failure. It looks more hairy but this can
> > > be hidden in a nice little helper shared between the two callers.
> >
> > Thanks a lot for the suggestion, printing warning if the gfp flag
> > allows sounds like a good idea to me. Will adopt it. But the check
> > should look like:
> >
> > if ((gfp & __GFP_THISNODE) && !(gfp & __GFP_NOWARN) && !node_online(nid))
>
> The idea was to warn if __GFP_NOWARN _was_ specified. Otherwise we will
> get an allocation failure splat from the page allocator and there it
> will be clear that the node doesn't have any memory associated. It is
> exactly __GFP_NOWARN case that would be a silent failure and potentially
> a buggy code (like this THP collapse path). See my point?

Aha, yeah, see your point now. I didn't see the splat from the
allocator from the bug report, then I realized it had not called into
allocator yet before the warning was triggered.

> --
> Michal Hocko
> SUSE Labs
