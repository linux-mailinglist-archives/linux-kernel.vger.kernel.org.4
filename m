Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD156166B1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiKBP6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiKBP6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:58:23 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9162B623
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 08:58:22 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so2286605pjk.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 08:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j4EsJAG1TrXRZNimC+sMPr+IdV0Qvg5OrKkaMfSaj1E=;
        b=IUvndRCTGt5Xl47Ya3xVX2Bw4Ivs6Gc/j8IPRNUqoa+3ZctcL6Iug0S6iLA5qvSdOR
         YrPG13hT39AewL7ADMdtty1gRM13oK6pAFt43NRu+ZKfAp2KImldP1otUE8kckEd5hWg
         chLs8bMKss672M5E8LfZMF4fHn2cRhZdh5gtsjMch0M1nQGMNfFVcIDjGKs+rELx4qzB
         oFrjBg7Bpjod10e0ybnwfXU102jzahmLGYNax2o+ma8ghD7RmXq0jVljgkUyPudbASoA
         1nTZT8f9u4NUcFT7Fa3oX+JkYQ3g0SW6WAdQOtEtrgm1x/7r2HQ6v7dC5qd8NGKH3y8p
         z4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j4EsJAG1TrXRZNimC+sMPr+IdV0Qvg5OrKkaMfSaj1E=;
        b=CndzroXTmORJ+AOneMMhBfjWeghf33QcYleM21OksUqnrhP/oCT7SsbKki70bymNoT
         PqRpeafxhvYY68oR8nM/8eaVb6g7lOqEwCewIp/xBjGUk63n+uZCzLhbUH9nW+OZUETN
         IEki63z5VW9Uc0y07DFGw18G3N+PjRGoTNU+bmYX9fwRC50JL3yTfvr5z9e1KdmOd3+g
         1iUh+ZVwRy1tcgqGoVkGZ5HsDznv3AKYNNtIgrakj4v1Ajp4ZPdpp9Jiyv4SqRWBC6IF
         6tZQnUd6tEmzDJBExXsS1TrFH9ZuWel4k1q5pMi6v2CEIrN9vGBPSmfa1iBdRdSNsR9M
         leaA==
X-Gm-Message-State: ACrzQf2cSnXBgZbUtO0Oawun4BSUjxwwljAnniZWS8+YZwlp5nbxUUx9
        OK667YVIBRv3YfrI5XGe2AVDfatm/lwipDrObpExjsE9
X-Google-Smtp-Source: AMsMyM79ajq5j/u8rRdWFZi8p1hBzBRJSFdsN/TeyLwHrzVLSmbFkEdDyEv2R9FODKPfPqU6Fl8yMTfi7fkSi1zKMFc=
X-Received: by 2002:a17:902:e88e:b0:187:27a7:c8a9 with SMTP id
 w14-20020a170902e88e00b0018727a7c8a9mr14490752plg.169.1667404702121; Wed, 02
 Nov 2022 08:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221031183122.470962-1-shy828301@gmail.com> <Y2BHcBCR2FIJgU4w@dhcp22.suse.cz>
 <CAAa6QmQt9Us8YpirQGXV0_AetuPS+EOqMSGqNn6KW24HXvwO_A@mail.gmail.com>
 <Y2DQr06mNzk0ITX1@dhcp22.suse.cz> <CAHbLzkonsnr4yxUOpMpoch1eCVNgR5hC9YaMkPR=fSV2Uszc6g@mail.gmail.com>
 <Y2IY4odZJHCwC16t@dhcp22.suse.cz>
In-Reply-To: <Y2IY4odZJHCwC16t@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 2 Nov 2022 08:58:09 -0700
Message-ID: <CAHbLzkq0C_EDpivHK5OdCfZPVt814P5r92pnPoNfW=CiXyCeww@mail.gmail.com>
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

On Wed, Nov 2, 2022 at 12:14 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 01-11-22 10:12:49, Yang Shi wrote:
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
>
> OK, I see.
>
> > But a closer look at the code about how to pick up the preferred node,
> > there seems to be a corner case for MADV_COLLAPSE.
> >
> > The code tried to do some balance if several nodes have the same hit
> > record. Basically it does conceptually:
> >     * If the target_node <= last_target_node, then iterate from
> > last_target_node + 1 to MAX_NUMNODES (1024 on default config)
> >     * If the max_value == node_load[nid], then target_node = nid
>
> Correct
>
> > So assuming the system has 2 nodes, the target_node is 0 and the
> > last_target_node is 1, if MADV_COLLAPSE path is hit, then it may
> > return 2 for target_node, but it is actually not existing (offline),
> > so the warn is triggered.
>
> How can node_load[2] > 0 (IIUC max_value > 0 here) if the node is
> offline (other than a race with hotplug)?

The max_value may be 0 if there is no entry in page cache for that range IIUC.

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
>
> Node, this is equally racy. node_online might become false right after
> the check.

Yes, my point is this could filter out the non-existing node case, for
example, the system just has 2 nodes physically, but MAX_NUMNODES > 2.
It doesn't prevent offlining, it is still racy, just like other
__GFP_THISNODE call sites.

> --
> Michal Hocko
> SUSE Labs
