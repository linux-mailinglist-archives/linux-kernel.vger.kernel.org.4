Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AD561FDDF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbiKGSsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiKGSsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:48:15 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E2825EB9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 10:48:14 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so15531881pjk.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 10:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b/mVKZ1bFQdlUizThgCTbRg+MO3jqWhYkRQgvO7dqeM=;
        b=fbMozeF4n5EHDWPz6r5hCdFs1Bw1rdu0oQVjqsl+Qtfjf2SBsbFrydgpV9aYcY7hw7
         eEl/lyTd6zndxz13T3BNqFJ4Si79bxop0+YmvZixx/35134bxD289Aesbj5IRswQbFgP
         s/GFOweacw+IvYKfxGxXRvlMsjnQJyOrvWgKEaI3bbHXD7TTENZYLhcd/T/K/D6kk26+
         MoGFfkA7851lcbQ9599QOEdb5TiKdf+x1ewjjxh9PwcKY24HevULCHg8FNxGsvSpSbJB
         J5pssEP0VFlfKIrgKAMMo9mAB+okQByv5z0LyhvDOX/lqTg3uupRuKaepEax/haUCpAi
         +MHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/mVKZ1bFQdlUizThgCTbRg+MO3jqWhYkRQgvO7dqeM=;
        b=FYw8wA5h38ubOFKfrvJejeXB5yf9Mu0WJ6L540A8IWQvEiSGkrSrRjg2jd4LOyIphp
         r28zh+c/PnQQEXtO6G9uGfZ6A6Hw9tjMKJ2cUdY1XLc+g7Zq93DS1WDwAdXf7fG/LJiA
         4+eq1ltG6yuqxlgASV35jEcKCxHjJUvfazx5OsWwl4OYr1YcLqM1LaGN81L11q3YaZwI
         UtLGvNu7dUNh9rfihpcvRm/ycFLpngmR0yeIvXxXvxb2fBsi0WRWfraxVNlKZ3QcKS4F
         PHq/AODabkSj4i3UxCNhcvpzGxmjaJimEZNBT0dcU5kCMuoc0jaaYtLbZ/iFSuMmugWT
         a8Rg==
X-Gm-Message-State: ACrzQf08rRvoR6JHWyABnRTjiq5EVxs+GBVGelejhAr7ik3/J/4YnZ3H
        17gOce87HCahXfyMalD17ifWW7gf+u70xvC9Z/Wm17sD
X-Google-Smtp-Source: AMsMyM4dPJ3isgIMQ6jokDPwcgATqWzPQOBNqxwDuM3Aa+5cHXNFOYaixG4Bl+NGMMejBk4Is4TRZZNYRHj8PAze8LE=
X-Received: by 2002:a17:903:3291:b0:179:c436:4528 with SMTP id
 jh17-20020a170903329100b00179c4364528mr871743plb.102.1667846894287; Mon, 07
 Nov 2022 10:48:14 -0800 (PST)
MIME-Version: 1.0
References: <20221103213641.7296-1-shy828301@gmail.com> <20221103213641.7296-2-shy828301@gmail.com>
 <Y2Tc2JNeFWXmZbQ1@dhcp22.suse.cz> <Y2ThtYKSxoP9S44i@dhcp22.suse.cz>
 <CAHbLzkpvZ05+xSGWLCYKJntsLGzdda449XpjCH7sRE-3S8h+0g@mail.gmail.com>
 <Y2VtNfkwciJ5hHF6@dhcp22.suse.cz> <CAHbLzkrcqc4rcH4iq3tU81=AsFi6MMpkwAFbdJf2vVPDy5HoXA@mail.gmail.com>
 <Y2i6Bway4H/tKkuf@dhcp22.suse.cz>
In-Reply-To: <Y2i6Bway4H/tKkuf@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 7 Nov 2022 10:48:01 -0800
Message-ID: <CAHbLzkp=fq5qeuMBxiN14Y1F945N4DiNmArgi4nEACse5b9dWQ@mail.gmail.com>
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

On Sun, Nov 6, 2022 at 11:55 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 04-11-22 13:52:52, Yang Shi wrote:
> > On Fri, Nov 4, 2022 at 12:51 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Fri 04-11-22 10:42:45, Yang Shi wrote:
> > > > On Fri, Nov 4, 2022 at 2:56 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Fri 04-11-22 10:35:21, Michal Hocko wrote:
> > > > > [...]
> > > > > > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > > > > > index ef4aea3b356e..308daafc4871 100644
> > > > > > --- a/include/linux/gfp.h
> > > > > > +++ b/include/linux/gfp.h
> > > > > > @@ -227,7 +227,10 @@ static inline
> > > > > >  struct folio *__folio_alloc_node(gfp_t gfp, unsigned int order, int nid)
> > > > > >  {
> > > > > >       VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
> > > > > > -     VM_WARN_ON((gfp & __GFP_THISNODE) && !node_online(nid));
> > > > > > +     if((gfp & __GFP_THISNODE) && !node_online(nid)) {
> > > > >
> > > > > or maybe even better
> > > > >         if ((gfp & (__GFP_THISNODE|__GFP_NOWARN) == __GFP_THISNODE|__GFP_NOWARN) && !node_online(nid))
> > > > >
> > > > > because it doesn't really make much sense to dump this information if
> > > > > the allocation failure is going to provide sufficient (and even more
> > > > > comprehensive) context for the failure. It looks more hairy but this can
> > > > > be hidden in a nice little helper shared between the two callers.
> > > >
> > > > Thanks a lot for the suggestion, printing warning if the gfp flag
> > > > allows sounds like a good idea to me. Will adopt it. But the check
> > > > should look like:
> > > >
> > > > if ((gfp & __GFP_THISNODE) && !(gfp & __GFP_NOWARN) && !node_online(nid))
> > >
> > > The idea was to warn if __GFP_NOWARN _was_ specified. Otherwise we will
> > > get an allocation failure splat from the page allocator and there it
> > > will be clear that the node doesn't have any memory associated. It is
> > > exactly __GFP_NOWARN case that would be a silent failure and potentially
> > > a buggy code (like this THP collapse path). See my point?
> >
> > Aha, yeah, see your point now. I didn't see the splat from the
> > allocator from the bug report, then I realized it had not called into
> > allocator yet before the warning was triggered.
>
> And it would trigger even if it did because GFP_TRANSHUGE has
> __GFP_NOWARN

Yeah, the syzbot has panic on warn set, so kernel just panicked before
entering the allocator.

> --
> Michal Hocko
> SUSE Labs
