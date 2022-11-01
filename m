Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CB5615041
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiKARNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiKARNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:13:05 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6DD1DDC9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 10:13:02 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id b185so14037616pfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 10:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZeCWm44Qsu4BEsJWoI0iqlW+Uat+vdy0Jy/tod3ruo=;
        b=QRqIgXZawY6u72XktvfN+JoAbxNi5KjSOOf4sM0DYoX287Nx9Xk75rEMp3pPyVHg2c
         xWQVA+4M+Sf42MOuxrsx6gX7adJKqzLGyyQsyghWZ8H67emYzJ+Yk2NJ84E8wTAgx9Q/
         WBGUCdHGCaTvvfS57Xy7720noYSqMYNx/LkLLrdXgLBV5UvPBr/RVRfV21Ws2flJ/+IH
         9kqdNBsQvihumo9DBZzZ8YeFSQ3JabMORwKqM6U8E2PX92XSjrTxXKAh+KlCMtZ5HzkE
         sXU5v/X3F7mNKepsApp98KyOaHBPS9aSSjcvwS8EsbfixHeoS7dkhi1cqtNnLDJDxCVL
         qdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ZeCWm44Qsu4BEsJWoI0iqlW+Uat+vdy0Jy/tod3ruo=;
        b=cMYJTrzj0dpchGwzsT2q41lI0HppUU9Heq7b6ncOZSgSsjp5GcSAtroZYC3LZQkxYi
         yNTYPT6bUH5h2Wpw6WnEOZGcFqtJpYrfJpcfmGyaFBHZ8E9peGO3pF1OqNiy627POe6K
         s9exPxHRFhAFRqjvWOxJGhs8brItsHbWXG2A+kngFw2445aj15J1zs5JwsLK9c/JF3Mi
         Kcz3YNiuO4KDml4NuAmMdyACJu92mDQZwDm77PP3uFaoaCdjtxRYBHvTD6RFXaKv/73i
         warFP7dDfQrUaVbi4UOdSimIa4ulip4hut1uUQEQJYf0MkTC9Mv1p1vgkd5PA2pUlriM
         sNJQ==
X-Gm-Message-State: ACrzQf2wwdomLZJe/0aXHcKdoRM9q3TM1d8RYtwPGTz0isNPR6fEw8De
        em+2kty/GT1zPA9DNV3INkA1leiEhiSb7EgEsORXuo9rUYs=
X-Google-Smtp-Source: AMsMyM62eEOHZiuJhrGGicQxTZts+7ifbl/6GPaLzGg8Qkdah0MPbXeGNAnZ9b9Ibk5hokpavTuiUtHLdwjN4ZdUcBI=
X-Received: by 2002:a05:6a00:24c2:b0:52e:7181:a8a0 with SMTP id
 d2-20020a056a0024c200b0052e7181a8a0mr20803558pfv.57.1667322781843; Tue, 01
 Nov 2022 10:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <20221031183122.470962-1-shy828301@gmail.com> <Y2BHcBCR2FIJgU4w@dhcp22.suse.cz>
 <CAAa6QmQt9Us8YpirQGXV0_AetuPS+EOqMSGqNn6KW24HXvwO_A@mail.gmail.com> <Y2DQr06mNzk0ITX1@dhcp22.suse.cz>
In-Reply-To: <Y2DQr06mNzk0ITX1@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 1 Nov 2022 10:12:49 -0700
Message-ID: <CAHbLzkonsnr4yxUOpMpoch1eCVNgR5hC9YaMkPR=fSV2Uszc6g@mail.gmail.com>
Subject: Re: [PATCH] mm: don't warn if the node is offlined
To:     Michal Hocko <mhocko@suse.com>
Cc:     "Zach O'Keefe" <zokeefe@google.com>, akpm@linux-foundation.org,
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

On Tue, Nov 1, 2022 at 12:54 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 31-10-22 17:05:06, Zach O'Keefe wrote:
> > On Mon, Oct 31, 2022 at 3:08 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 31-10-22 11:31:22, Yang Shi wrote:
> > > > Syzbot reported the below splat:
> > > >
> > > > WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 __alloc_pages_node include/linux/gfp.h:221 [inline]
> > > > WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 hpage_collapse_alloc_page mm/khugepaged.c:807 [inline]
> > > > WARNING: CPU: 1 PID: 3646 at include/linux/gfp.h:221 alloc_charge_hpage+0x802/0xaa0 mm/khugepaged.c:963
> > > > Modules linked in:
> > > > CPU: 1 PID: 3646 Comm: syz-executor210 Not tainted 6.1.0-rc1-syzkaller-00454-ga70385240892 #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
> > > > RIP: 0010:__alloc_pages_node include/linux/gfp.h:221 [inline]
> > > > RIP: 0010:hpage_collapse_alloc_page mm/khugepaged.c:807 [inline]
> > > > RIP: 0010:alloc_charge_hpage+0x802/0xaa0 mm/khugepaged.c:963
> > > > Code: e5 01 4c 89 ee e8 6e f9 ae ff 4d 85 ed 0f 84 28 fc ff ff e8 70 fc ae ff 48 8d 6b ff 4c 8d 63 07 e9 16 fc ff ff e8 5e fc ae ff <0f> 0b e9 96 fa ff ff 41 bc 1a 00 00 00 e9 86 fd ff ff e8 47 fc ae
> > > > RSP: 0018:ffffc90003fdf7d8 EFLAGS: 00010293
> > > > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > > > RDX: ffff888077f457c0 RSI: ffffffff81cd8f42 RDI: 0000000000000001
> > > > RBP: ffff888079388c0c R08: 0000000000000001 R09: 0000000000000000
> > > > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> > > > R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000000
> > > > FS:  00007f6b48ccf700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 00007f6b48a819f0 CR3: 00000000171e7000 CR4: 00000000003506e0
> > > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > Call Trace:
> > > >  <TASK>
> > > >  collapse_file+0x1ca/0x5780 mm/khugepaged.c:1715
> > >
> > > This is quite weird, isn't it? alloc_charge_hpage is selecting the most
> > > busy node (as per collapse_control). How come this can be an offline
> > > node? Is a parallel memory hotplug happening?
> >
> > TBH -- I did not look closely at the syzbot reproducer (let alone
> > attempt to run it) and assumed this was the case. Taking a quick look,
> > at least memory hot remove is enabled:
> >
> > CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> > CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
> > CONFIG_MEMORY_HOTPLUG=y
> > CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
> > CONFIG_MEMORY_HOTREMOVE=y
> >
> > But looking at the C reproducer, I don't immediately see anywhere
> > where we offline nodes. I'll try to run this tomorrow to make sure I'm
> > not missing something real here.
>
> Looking slightly closer at hpage_collapse_scan_file I think that it is
> possible that xas_for_each simply doesn't find any entries in the page
> cache and with khugepaged_max_ptes_none == HPAGE_PMD_NR we can fall back
> to collapse_file even without any real entries.

The khugepaged_max_ptes_none can't be HPAGE_PMD_NR, it must be <=
(HPAGE_PMD_NR - 1), but MADV_COLLAPSE does ignore it.

But a closer look at the code about how to pick up the preferred node,
there seems to be a corner case for MADV_COLLAPSE.

The code tried to do some balance if several nodes have the same hit
record. Basically it does conceptually:
    * If the target_node <= last_target_node, then iterate from
last_target_node + 1 to MAX_NUMNODES (1024 on default config)
    * If the max_value == node_load[nid], then target_node = nid

So assuming the system has 2 nodes, the target_node is 0 and the
last_target_node is 1, if MADV_COLLAPSE path is hit, then it may
return 2 for target_node, but it is actually not existing (offline),
so the warn is triggered.

The below patch should be able to fix it:

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index ea0d186bc9d4..d24405e6736b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -787,7 +787,8 @@ static int hpage_collapse_find_target_node(struct
collapse_control *cc)
        if (target_node <= cc->last_target_node)
                for (nid = cc->last_target_node + 1; nid < MAX_NUMNODES;
                     nid++)
-                       if (max_value == cc->node_load[nid]) {
+                       if (node_online(nid) &&
+                           max_value == cc->node_load[nid]) {
                                target_node = nid;
                                break;
                        }

> But the mere possibility of the hotplug race should be a sufficient
> ground to remove those WARN_ONs

The warn_on did help to catch this bug. But the reasons for removing
it still stand TBH, so we may consider to move this warn_on to the
callers which care about it?

>
>
> Thanks!
> --
> Michal Hocko
> SUSE Labs
