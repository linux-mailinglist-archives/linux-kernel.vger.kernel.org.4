Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A216152BE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 21:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiKAUJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 16:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKAUJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 16:09:22 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9993C1BEAC
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 13:09:20 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c2so14575255plz.11
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 13:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kDQSAuNqqJty1qHOYmC4UJfWiv1afN/k+rqOxq1ZLhc=;
        b=GGH9cDpPZqJGTDzeSUCsVIL/5fkX40TMgsyl4ia1w9P1fkW+XbcInJgGvMk8dYC7kG
         Rs1t18M9nOzNO63JqmQ9ytr0D3WHIqWDwH/7SqYuTxoaLlxoglm4fXhscM+fOQ8F8CeI
         5MqX0ejN2NqPC02jHUlWPgoZD9t0/Sh4smYrxn7QT0fyB2h2SYNG4POX1UA57L64iWvN
         Be1DMd3WoskVWg2qxfhwsomukNZXnwSgrrBL1KepUPPI3y0xQ5mqZwj1EXT9yJPA5YtM
         kW4r2IslmwmF68ncAE2yNWwOeHAT8CiaegUirOk+bEyAuk/P1o17G6Zk785DGmQwYXH7
         riPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kDQSAuNqqJty1qHOYmC4UJfWiv1afN/k+rqOxq1ZLhc=;
        b=sjeVDLwEghKHfXt32vjA2OxrqPi52JHX6a4OZdPMPUBY6Vr7A3LZOuhDldCK1oyL0P
         uTyL9Ul7OPgpO/Il21salbJ+xPPLGzj3c9JYjHW/H0m7XAIynQqGXFw1h+62qgzoDmoI
         2eJ1gdVhJk9g1/jTiy9KWT/bwkPpdkvvMDu3IR7hK9vEWuswrLfSQmROjOKd/ZcTJnwI
         Q6P23THy0HfFrz28p0dh9r8nAJemvdwUUE5PoNJbWg+UHnuPL3L3D5X+9a7xQc2cwZzx
         GEdFH4wzvx07ZeAUXK9J6cGAst3qcVh9yYE+lMCTBVjAsnKifZDMoHHKZEIRWjxG8Apj
         QlSg==
X-Gm-Message-State: ACrzQf0QoapufQeU11tfNb54ETN3DALYgOCLB0N4SB5S/yw/iZibiMlD
        iaQs/+xf2uztxCXPTnV6pbFZ+U0mf4QDKwzYfs59ABML
X-Google-Smtp-Source: AMsMyM54w8CkSImuyWYXfRguSMXxoJEIuO8a+KpQ6oWp8VuA45lEqdowVb0cO0bxXeBsEvd0i1Zlc4bOdQRmAFWyBms=
X-Received: by 2002:a17:902:d512:b0:181:f1f4:fcb4 with SMTP id
 b18-20020a170902d51200b00181f1f4fcb4mr21452715plg.102.1667333360084; Tue, 01
 Nov 2022 13:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221031183122.470962-1-shy828301@gmail.com> <Y2BHcBCR2FIJgU4w@dhcp22.suse.cz>
 <CAAa6QmQt9Us8YpirQGXV0_AetuPS+EOqMSGqNn6KW24HXvwO_A@mail.gmail.com>
 <Y2DQr06mNzk0ITX1@dhcp22.suse.cz> <CAHbLzkonsnr4yxUOpMpoch1eCVNgR5hC9YaMkPR=fSV2Uszc6g@mail.gmail.com>
 <CAAa6QmRe1zMp8P-gZjR63Fg6KhOw+fP-v7SQWLNKuc2Y9ZxvyA@mail.gmail.com>
In-Reply-To: <CAAa6QmRe1zMp8P-gZjR63Fg6KhOw+fP-v7SQWLNKuc2Y9ZxvyA@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 1 Nov 2022 13:09:06 -0700
Message-ID: <CAHbLzkoavA7b11UWF6DLhsK_SLcje4n3S=MQ71R287nX=2gR+Q@mail.gmail.com>
Subject: Re: [PATCH] mm: don't warn if the node is offlined
To:     "Zach O'Keefe" <zokeefe@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Tue, Nov 1, 2022 at 12:14 PM Zach O'Keefe <zokeefe@google.com> wrote:
>
> On Tue, Nov 1, 2022 at 10:13 AM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Tue, Nov 1, 2022 at 12:54 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 31-10-22 17:05:06, Zach O'Keefe wrote:
> > > > On Mon, Oct 31, 2022 at 3:08 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Mon 31-10-22 11:31:22, Yang Shi wrote:
> > > > > > Syzbot reported the below splat:
> > > > > >
> > > > > > WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 __alloc_pages_node include/linux/gfp.h:221 [inline]
> > > > > > WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 hpage_collapse_alloc_page mm/khugepaged.c:807 [inline]
> > > > > > WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 alloc_charge_hpage+0x802/0xaa0 mm/khugepaged.c:963
> > > > > > Modules linked in:
> > > > > > CPU: 1 PID: 3646 Comm: syz-executor210 Not tainted 6.1.0-rc1-syzkaller-00454-ga70385240892 #0
> > > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
> > > > > > RIP: 0010:__alloc_pages_node include/linux/gfp.h:221 [inline]
> > > > > > RIP: 0010:hpage_collapse_alloc_page mm/khugepaged.c:807 [inline]
> > > > > > RIP: 0010:alloc_charge_hpage+0x802/0xaa0 mm/khugepaged.c:963
> > > > > > Code: e5 01 4c 89 ee e8 6e f9 ae ff 4d 85 ed 0f 84 28 fc ff ff e8 70 fc ae ff 48 8d 6b ff 4c 8d 63 07 e9 16 fc ff ff e8 5e fc ae ff <0f> 0b e9 96 fa ff ff 41 bc 1a 00 00 00 e9 86 fd ff ff e8 47 fc ae
> > > > > > RSP: 0018:ffffc90003fdf7d8 EFLAGS: 00010293
> > > > > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > > > > > RDX: ffff888077f457c0 RSI: ffffffff81cd8f42 RDI: 0000000000000001
> > > > > > RBP: ffff888079388c0c R08: 0000000000000001 R09: 0000000000000000
> > > > > > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> > > > > > R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
> > > > > > FS:  00007f6b48ccf700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> > > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > > CR2: 00007f6b48a819f0 CR3: 00000000171e7000 CR4: 00000000003506e0
> > > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > > > Call Trace:
> > > > > >  <TASK>
> > > > > >  collapse_file+0x1ca/0x5780 mm/khugepaged.c:1715
> > > > >
> > > > > This is quite weird, isn't it? alloc_charge_hpage is selecting the most
> > > > > busy node (as per collapse_control). How come this can be an offline
> > > > > node? Is a parallel memory hotplug happening?
> > > >
> > > > TBH -- I did not look closely at the syzbot reproducer (let alone
> > > > attempt to run it) and assumed this was the case. Taking a quick look,
> > > > at least memory hot remove is enabled:
> > > >
> > > > CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> > > > CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
> > > > CONFIG_MEMORY_HOTPLUG=y
> > > > CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
> > > > CONFIG_MEMORY_HOTREMOVE=y
> > > >
> > > > But looking at the C reproducer, I don't immediately see anywhere
> > > > where we offline nodes. I'll try to run this tomorrow to make sure I'm
> > > > not missing something real here.
> > >
> > > Looking slightly closer at hpage_collapse_scan_file I think that it is
> > > possible that xas_for_each simply doesn't find any entries in the page
> > > cache and with khugepaged_max_ptes_none == HPAGE_PMD_NR we can fall back
> > > to collapse_file even without any real entries.
> >
> > The khugepaged_max_ptes_none can't be HPAGE_PMD_NR, it must be <=
> > (HPAGE_PMD_NR - 1), but MADV_COLLAPSE does ignore it.
> >
> > But a closer look at the code about how to pick up the preferred node,
> > there seems to be a corner case for MADV_COLLAPSE.
> >
> > The code tried to do some balance if several nodes have the same hit
> > record. Basically it does conceptually:
> >     * If the target_node <= last_target_node, then iterate from
> > last_target_node + 1 to MAX_NUMNODES (1024 on default config)
> >     * If the max_value == node_load[nid], then target_node = nid
> >
> > So assuming the system has 2 nodes, the target_node is 0 and the
> > last_target_node is 1, if MADV_COLLAPSE path is hit, then it may
> > return 2 for target_node, but it is actually not existing (offline),
> > so the warn is triggered.
> >
>
> You're one step ahead of me, Yang. I was just debugging the syzbot C
> reproducer, and this seems to be exactly the case that is happening.
>
> > The below patch should be able to fix it:
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index ea0d186bc9d4..d24405e6736b 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -787,7 +787,8 @@ static int hpage_collapse_find_target_node(struct
> > collapse_control *cc)
> >         if (target_node <= cc->last_target_node)
> >                 for (nid = cc->last_target_node + 1; nid < MAX_NUMNODES;
> >                      nid++)
> > -                       if (max_value == cc->node_load[nid]) {
> > +                       if (node_online(nid) &&
> > +                           max_value == cc->node_load[nid]) {
> >                                 target_node = nid;
> >                                 break;
> >                         }
> >
>
> Thanks for the patch. I think this is the right place to do the check.
>
> This is slightly tangential - but I don't want to send a new mail
> about it -- but I wonder if we should be doing __GFP_THISNODE +
> explicit node vs having hpage_collapse_find_target_node() set a
> nodemask. We could then provide fallback nodes for ties, or if some
> node contained > some threshold number of pages.

We definitely could, but I'm not sure whether we should make this code
more complicated or not. TBH I think it is already overengineered. If
fallback is fine, then just removing __GFP_THISNODE may be fine too.
Actually I doubt there would be any noticeable difference for real
life workload.

>
> > > But the mere possibility of the hotplug race should be a sufficient
> > > ground to remove those WARN_ONs
> >
>
> Agreed.
>
> > The warn_on did help to catch this bug. But the reasons for removing
> > it still stand TBH, so we may consider to move this warn_on to the
> > callers which care about it?
>
> I didn't come across in a cursory search -- but if there are callers
> which try to synchronize with hot remove to ensure __GFP_THISNODE
> succeeds, then sure, the warn makes sense to them.

Yeah, we are on the same page, the specific warning could be added by
the caller instead of in the common path.

>
> > >
> > >
> > > Thanks!
> > > --
> > > Michal Hocko
> > > SUSE Labs
