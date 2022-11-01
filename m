Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D522261520D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiKATOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKATOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:14:16 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4558B167F6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 12:14:15 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id j14so22303492ljh.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 12:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8yWGGQy6nd75MxfeaMsUIV4s8QBs1RLTaTKHXtygWyI=;
        b=lIP+xq5Kgn9HZbrOq8qu+0sEJ7RuCOgkQQdNVNDXTgZLLMd3jQR0o6oATzIwnM2lWN
         WLEDDzpVUS1oCbA9RyDvUgBOrXQyCc6BgdQW5Ztwg7859HzkXJOnqZL0uLemhn/0Sv6d
         aLLW+Qbswkh2B0bcIHQ87tjgpvHEwgM2c+/tESXnaTUPZ3GwNlqDmLgGahfLKZb2jZun
         j+dPyWlL11KidIIxuksY7Pz7z/85HtLRxdT4iqknHgG7uNHln5VrmMm6O/o5q9wmLM5q
         BEm4OgEOys31Ni2rhI282iTZLLAqPb+5ncGH5RdAS/TbAjlZjj74y2An9qXJoukd6fap
         BxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8yWGGQy6nd75MxfeaMsUIV4s8QBs1RLTaTKHXtygWyI=;
        b=HH/H6Y+X6skmT9NYRUwnRRH/rL8esmL7eeCowcpIkNdtV9hHFY6KTXyY5ztSYaRRpI
         eVvBxfl87SBDC8/PElpr/Fs/OOKbVtSDcns5w2K3KqmOjh7x4k1ulvbzK08v1fhmuIz6
         KUMqx5emVaZA2ny5WY8F4t2kwrSptpqkaKH7i3VtwQIUhXHnbNeLZUkYbL5kEjT2Nok6
         a1QAvwQhEs7chjZq+p9ewgTtx82dk6lJGK01x2PTk5xaxe6u1sJG+Bpbv0IDaTTA1dui
         uZAMQo6WV7jXmGEqOSzy1tyPZaiz/e07MX7C+LRWtwYrjhPsjiVPTm4LIg6d+SViSIZe
         C0Eg==
X-Gm-Message-State: ACrzQf1asb7qpaIaM5whGtFJaYd/+m/Acd+D993fTYazTe7J3ckA7EPO
        oUyfgl0BEc3WTPUQOaOHTnQ75LUrZOHK410am/7H7Q==
X-Google-Smtp-Source: AMsMyM7bB7G05FEiSkW2V70Q/+5r8EyVM0JISba4cQ4DUd1oH4EQf/MZe37nP6WbThGnF0Tpc2J3whFn+nh/1S5GXaE=
X-Received: by 2002:a2e:8181:0:b0:25f:e028:a67 with SMTP id
 e1-20020a2e8181000000b0025fe0280a67mr8074104ljg.89.1667330053341; Tue, 01 Nov
 2022 12:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221031183122.470962-1-shy828301@gmail.com> <Y2BHcBCR2FIJgU4w@dhcp22.suse.cz>
 <CAAa6QmQt9Us8YpirQGXV0_AetuPS+EOqMSGqNn6KW24HXvwO_A@mail.gmail.com>
 <Y2DQr06mNzk0ITX1@dhcp22.suse.cz> <CAHbLzkonsnr4yxUOpMpoch1eCVNgR5hC9YaMkPR=fSV2Uszc6g@mail.gmail.com>
In-Reply-To: <CAHbLzkonsnr4yxUOpMpoch1eCVNgR5hC9YaMkPR=fSV2Uszc6g@mail.gmail.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Tue, 1 Nov 2022 12:13:35 -0700
Message-ID: <CAAa6QmRe1zMp8P-gZjR63Fg6KhOw+fP-v7SQWLNKuc2Y9ZxvyA@mail.gmail.com>
Subject: Re: [PATCH] mm: don't warn if the node is offlined
To:     Yang Shi <shy828301@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 1, 2022 at 10:13 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Tue, Nov 1, 2022 at 12:54 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 31-10-22 17:05:06, Zach O'Keefe wrote:
> > > On Mon, Oct 31, 2022 at 3:08 PM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Mon 31-10-22 11:31:22, Yang Shi wrote:
> > > > > Syzbot reported the below splat:
> > > > >
> > > > > WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 __alloc_pages_node include/linux/gfp.h:221 [inline]
> > > > > WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 hpage_collapse_alloc_page mm/khugepaged.c:807 [inline]
> > > > > WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 alloc_charge_hpage+0x802/0xaa0 mm/khugepaged.c:963
> > > > > Modules linked in:
> > > > > CPU: 1 PID: 3646 Comm: syz-executor210 Not tainted 6.1.0-rc1-syzkaller-00454-ga70385240892 #0
> > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
> > > > > RIP: 0010:__alloc_pages_node include/linux/gfp.h:221 [inline]
> > > > > RIP: 0010:hpage_collapse_alloc_page mm/khugepaged.c:807 [inline]
> > > > > RIP: 0010:alloc_charge_hpage+0x802/0xaa0 mm/khugepaged.c:963
> > > > > Code: e5 01 4c 89 ee e8 6e f9 ae ff 4d 85 ed 0f 84 28 fc ff ff e8 70 fc ae ff 48 8d 6b ff 4c 8d 63 07 e9 16 fc ff ff e8 5e fc ae ff <0f> 0b e9 96 fa ff ff 41 bc 1a 00 00 00 e9 86 fd ff ff e8 47 fc ae
> > > > > RSP: 0018:ffffc90003fdf7d8 EFLAGS: 00010293
> > > > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > > > > RDX: ffff888077f457c0 RSI: ffffffff81cd8f42 RDI: 0000000000000001
> > > > > RBP: ffff888079388c0c R08: 0000000000000001 R09: 0000000000000000
> > > > > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> > > > > R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
> > > > > FS:  00007f6b48ccf700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > CR2: 00007f6b48a819f0 CR3: 00000000171e7000 CR4: 00000000003506e0
> > > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > > Call Trace:
> > > > >  <TASK>
> > > > >  collapse_file+0x1ca/0x5780 mm/khugepaged.c:1715
> > > >
> > > > This is quite weird, isn't it? alloc_charge_hpage is selecting the most
> > > > busy node (as per collapse_control). How come this can be an offline
> > > > node? Is a parallel memory hotplug happening?
> > >
> > > TBH -- I did not look closely at the syzbot reproducer (let alone
> > > attempt to run it) and assumed this was the case. Taking a quick look,
> > > at least memory hot remove is enabled:
> > >
> > > CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> > > CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
> > > CONFIG_MEMORY_HOTPLUG=y
> > > CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
> > > CONFIG_MEMORY_HOTREMOVE=y
> > >
> > > But looking at the C reproducer, I don't immediately see anywhere
> > > where we offline nodes. I'll try to run this tomorrow to make sure I'm
> > > not missing something real here.
> >
> > Looking slightly closer at hpage_collapse_scan_file I think that it is
> > possible that xas_for_each simply doesn't find any entries in the page
> > cache and with khugepaged_max_ptes_none == HPAGE_PMD_NR we can fall back
> > to collapse_file even without any real entries.
>
> The khugepaged_max_ptes_none can't be HPAGE_PMD_NR, it must be <=
> (HPAGE_PMD_NR - 1), but MADV_COLLAPSE does ignore it.
>
> But a closer look at the code about how to pick up the preferred node,
> there seems to be a corner case for MADV_COLLAPSE.
>
> The code tried to do some balance if several nodes have the same hit
> record. Basically it does conceptually:
>     * If the target_node <= last_target_node, then iterate from
> last_target_node + 1 to MAX_NUMNODES (1024 on default config)
>     * If the max_value == node_load[nid], then target_node = nid
>
> So assuming the system has 2 nodes, the target_node is 0 and the
> last_target_node is 1, if MADV_COLLAPSE path is hit, then it may
> return 2 for target_node, but it is actually not existing (offline),
> so the warn is triggered.
>

You're one step ahead of me, Yang. I was just debugging the syzbot C
reproducer, and this seems to be exactly the case that is happening.

> The below patch should be able to fix it:
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index ea0d186bc9d4..d24405e6736b 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -787,7 +787,8 @@ static int hpage_collapse_find_target_node(struct
> collapse_control *cc)
>         if (target_node <= cc->last_target_node)
>                 for (nid = cc->last_target_node + 1; nid < MAX_NUMNODES;
>                      nid++)
> -                       if (max_value == cc->node_load[nid]) {
> +                       if (node_online(nid) &&
> +                           max_value == cc->node_load[nid]) {
>                                 target_node = nid;
>                                 break;
>                         }
>

Thanks for the patch. I think this is the right place to do the check.

This is slightly tangential - but I don't want to send a new mail
about it -- but I wonder if we should be doing __GFP_THISNODE +
explicit node vs having hpage_collapse_find_target_node() set a
nodemask. We could then provide fallback nodes for ties, or if some
node contained > some threshold number of pages.

> > But the mere possibility of the hotplug race should be a sufficient
> > ground to remove those WARN_ONs
>

Agreed.

> The warn_on did help to catch this bug. But the reasons for removing
> it still stand TBH, so we may consider to move this warn_on to the
> callers which care about it?

I didn't come across in a cursory search -- but if there are callers
which try to synchronize with hot remove to ensure __GFP_THISNODE
succeeds, then sure, the warn makes sense to them.

> >
> >
> > Thanks!
> > --
> > Michal Hocko
> > SUSE Labs
