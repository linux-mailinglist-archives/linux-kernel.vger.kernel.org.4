Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65212616E50
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiKBUIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiKBUIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:08:22 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF803AB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 13:08:21 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id p3so17624451pld.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 13:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sx8QQTJJYra6kPHU+WuCPovUOVIpybSKQpNWIIcdQyY=;
        b=gipJh4+ecnNSjOXg15dlwdnBvGur3Ce221IgYBrjjjbuCGBjtllb9Y0I+ZJvNjmhcL
         ROL0AaxVaT1/X2uLT6iXEYzv/I1mefhS/1Fqvs8ausq2aBP8O0ENDFnUA84lddy6sk9e
         9MZuCa85bsgCl3UDNiqWpkLOdxEJerp68su9/1H13IsZAWxGyM4mV5GHq/I0LWJhN6P+
         zwyJ3pPbUA4KsoG3pWjt7FIBjLg5WNXQ2ZSc/0BdK6ySG2Dsz7jJldb+S6V0NYExyvZH
         bO1a+tGiQBAWZXJhI2XsDGkwumZb0zFfHhmYD4jA73EIp9siL3VEZwgbjv/EuwSjEKgp
         NDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sx8QQTJJYra6kPHU+WuCPovUOVIpybSKQpNWIIcdQyY=;
        b=LzfG2781Mugit/vkMihAS2+NYXxe45cec0HCen+tLJReNVNFLM0c/Ay1fWkTfAJylU
         gm9foHejmuGu/nrozESR3FUQcrwYKa6MiCPnYxmjBROwQFFWum5ZhVhT3XuiaO3byryn
         IwXfuf5SJI/6W0brLFtsVMQUVroyzpbZ55vSznFseNnoCaxvFMhToY9ZCbdzPeV39nMt
         oG8f72N7D6OnjBnicwtRX0ZE4Le51SYbn/kD0kxezxzYnrzGvlv0Xv3sdynmJIgZYpr1
         QD2tJhja9pfzRrDWjn5F/o4/gm02Me0KUlv4gu33knWWozayJ5LwXvWgP0jZYyf2ejKv
         50tw==
X-Gm-Message-State: ACrzQf0FdJypA3oKbuXVYKFIe5Y3oL9sPF/MTaPAJ7J5oNQut+iP2atu
        FZsnG+Ah18wH+8yCj6vjDyQfQogwVf/QI85EJSA=
X-Google-Smtp-Source: AMsMyM7hEbZCwnUgPz7QHBOb3xUr3DndqBtAzXZpbxygDTqPVKcyYPnqAL1t2ViWEnlKNFNjLywFkYoQlgJ2+UW+f8k=
X-Received: by 2002:a17:902:e88e:b0:187:27a7:c8a9 with SMTP id
 w14-20020a170902e88e00b0018727a7c8a9mr15520603plg.169.1667419700704; Wed, 02
 Nov 2022 13:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221031183122.470962-1-shy828301@gmail.com> <Y2BHcBCR2FIJgU4w@dhcp22.suse.cz>
 <CAAa6QmQt9Us8YpirQGXV0_AetuPS+EOqMSGqNn6KW24HXvwO_A@mail.gmail.com>
 <Y2DQr06mNzk0ITX1@dhcp22.suse.cz> <CAHbLzkonsnr4yxUOpMpoch1eCVNgR5hC9YaMkPR=fSV2Uszc6g@mail.gmail.com>
 <CAAa6QmRe1zMp8P-gZjR63Fg6KhOw+fP-v7SQWLNKuc2Y9ZxvyA@mail.gmail.com>
 <Y2IerOXJ+ZoRTHcs@dhcp22.suse.cz> <CAHbLzkrBNzsorc9oCq1=ri0uq1xbQ+m+u2gQX5GYrb=Z7n4siA@mail.gmail.com>
 <Y2KXkVmRWOpPT/MI@dhcp22.suse.cz> <CAHbLzkosQf8OoL+u+gkfO5-fvCNUuDxEa08FUfks1M4AS7tmjw@mail.gmail.com>
 <Y2KtKVpR69P+E0xT@dhcp22.suse.cz> <CAHbLzkpirnzJSu0SHGRbhFMsH7ZzHtL5ZMXjrBoy8r=UywVhMg@mail.gmail.com>
 <CAAa6QmQ+4XndbtE_=mcaC5OaeK4g42dKYfY5FmYoRDTKGO-3nA@mail.gmail.com>
In-Reply-To: <CAAa6QmQ+4XndbtE_=mcaC5OaeK4g42dKYfY5FmYoRDTKGO-3nA@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 2 Nov 2022 13:08:08 -0700
Message-ID: <CAHbLzkouJkixT0X_uGTrFj_qCyYikpr2j3LOo50rsY_P9OS8Xw@mail.gmail.com>
Subject: Re: [PATCH] mm: don't warn if the node is offlined
To:     "Zach O'Keefe" <zokeefe@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Davidoff <davidoff@qedmf.net>,
        Bob Liu <lliubbo@gmail.com>
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

On Wed, Nov 2, 2022 at 11:59 AM Zach O'Keefe <zokeefe@google.com> wrote:
>
> On Wed, Nov 2, 2022 at 11:18 AM Yang Shi <shy828301@gmail.com> wrote:
> >
> > On Wed, Nov 2, 2022 at 10:47 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Wed 02-11-22 10:36:07, Yang Shi wrote:
> > > > On Wed, Nov 2, 2022 at 9:15 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Wed 02-11-22 09:03:57, Yang Shi wrote:
> > > > > > On Wed, Nov 2, 2022 at 12:39 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > >
> > > > > > > On Tue 01-11-22 12:13:35, Zach O'Keefe wrote:
> > > > > > > [...]
> > > > > > > > This is slightly tangential - but I don't want to send a new mail
> > > > > > > > about it -- but I wonder if we should be doing __GFP_THISNODE +
> > > > > > > > explicit node vs having hpage_collapse_find_target_node() set a
> > > > > > > > nodemask. We could then provide fallback nodes for ties, or if some
> > > > > > > > node contained > some threshold number of pages.
> > > > > > >
> > > > > > > I would simply go with something like this (not even compile tested):
> > > > > >
> > > > > > Thanks, Michal. It is definitely an option. As I talked with Zach, I'm
> > > > > > not sure whether it is worth making the code more complicated for such
> > > > > > micro optimization or not. Removing __GFP_THISNODE or even removing
> > > > > > the node balance code should be fine too IMHO. TBH I doubt there would
> > > > > > be any noticeable difference.
> > > > >
> > > > > I do agree that an explicit nodes (quasi)round robin sounds over
> > > > > engineered. It makes some sense to try to target the prevalent node
> > > > > though because this code can be executed from khugepaged and therefore
> > > > > allocating with a completely different affinity than the original fault.
> > > >
> > > > Yeah, the corner case comes from the node balance code, it just tries
> > > > to balance between multiple prevalent nodes, so you agree to remove it
> > > > IIRC?
> > >
> > > Yeah, let's just collect all good nodes into a nodemask and keep
> > > __GFP_THISNODE in place. You can consider having the nodemask per collapse_control
> > > so that you allocate it only once in the struct lifetime.
> >
> > Actually my intention is more aggressive, just remove that node balance code.
> >
>
> The balancing code dates back to 2013 commit 9f1b868a13ac ("mm: thp:
> khugepaged: add policy for finding target node") where it was made to
> satisfy "numactl --interleave=all". I don't know why any real
> workloads would want this -- but there very well could be a valid use
> case. If not, I think it could be removed independent of what we do
> with __GFP_THISNODE and nodemask.

Hmm... if the code is used for interleave, I don't think nodemask
could preserve the behavior IIUC. The nodemask also tries to allocate
memory from the preferred node, and fallback to the allowed nodes from
nodemask when the allocation fails on the preferred node. But the
round robin style node balance tries to distribute the THP on the
nodes evenly.

And I just thought of __GFP_THISNODE + nodemask should not be the
right combination IIUC, right? __GFP_THISNODE does disallow any
fallback, so nodemask is actually useless.

So I think we narrowed down to two options:
1. Preserve the interleave behavior but bail out if the target node is
not online (it is also racy, but doesn't hurt)
2. Remove the node balance code entirely

>
> Balancing aside -- I haven't fully thought through what an ideal (and
> further overengineered) solution would be for numa, but one (perceived
> - not measured) issue that khugepaged might have (MADV_COLLAPSE
> doesn't have the choice) is on systems with many, many nodes with
> source pages sprinkled across all of them. Should we collapse these
> pages into a single THP from the node with the most (but could still
> be a small %) pages? Probably there are better candidates. So, maybe a
> khugepaged-only check for max_value > (HPAGE_PMD_NR >> 1) or something
> makes sense.

Anyway you have to allocate a THP on one node, I don't think of a
better idea to make the node selection fairer. But I'd prefer to wait
for real life usecase surfaces.

>
> > >
> > > And as mentioned in other reply it would be really nice to hide this
> > > under CONFIG_NUMA (in a standalong follow up of course).
> >
> > The hpage_collapse_find_target_node() function itself is defined under
> > CONFIG_NUMA.
> >
> > >
> > > --
> > > Michal Hocko
> > > SUSE Labs
