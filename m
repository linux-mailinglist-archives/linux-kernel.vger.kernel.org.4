Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BC0616E84
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiKBUWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiKBUWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:22:39 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31A72BDB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 13:22:37 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f37so30035046lfv.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 13:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PPB66kwiDNs/UxqRj5JhPqFs26A6pEGmxTVPyfSHvsM=;
        b=G6XktqWaNlyQqJJ1NqL5qcXxlGUSL9HURxZP56umhlR3uEfLInhH4EBb486V7CjAOi
         ZM1xHNzYclAExsdzpL8lxK48pzuEptaXQlBSHfmKzRUYZOEtMdzodIeu9y5J1ikNO1Xm
         9GQhfkwTPk8EwST3CFH1vOWeb2iEaYlG02Qg3tewhKvJV6U0VHky50yk5RTPvxzQ74xE
         6xKsuJepT2LVaetFz6V/uHGdKB8up/uCiZo/L2ouuLWNprvWkjTEr1Ik+TmtoiasbwuS
         FwTkm1axXl1m02EKN9iKfxWkW1Oy9BE9natYXbxdAJrTNTsLAZkEknNyVkBQ3xBVH85g
         TYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PPB66kwiDNs/UxqRj5JhPqFs26A6pEGmxTVPyfSHvsM=;
        b=K5TEvdvcCSmc86HWbI1GqUAba3GXxx9M6CkaY+IGkL0kv/mqXQ/zlckQ4a7B6dmJxW
         4kahFRBukJSh/VO1R0P8E1cgoFAHWQf8eMtS+7uWapSaalK0tx7bscciSuIEyIkkCGuT
         vz3H4skACWMjoraC4GxhVWKpybp+cbRPRymbYFlSA4FGNbx2eGG394QQ34Hxudtq5LUV
         vJrhx8mqLtsaiKf5CQjW0SrlYR8zpMwi7fPVZnwUYv2gEhZVa6ceVljOTTL8SfjNsKY0
         owiriFYeyIJHHQZi69RxNEbtZu19Wv3tI3ABjGh/V9wSN+WyPWrd1x9kbL+gp/kL0MLi
         jFng==
X-Gm-Message-State: ACrzQf1Qk1VWwSFDNcuCiYAczaZUJzqcU80B4dMquK/JRrM6U//rUzSj
        UMLpvssUv2pNVORuvD/nDVmhq15cfa+Pmkd1Vv+w8g==
X-Google-Smtp-Source: AMsMyM5yEgIfL+O/L6kscCKpY/fUDilawZlzmLU1Jd8yJlrqFDc0gdUB/TXJVl5/QW2M+3MTVee38uRfjekiSqLuO+o=
X-Received: by 2002:a05:6512:224e:b0:4a2:5060:55ef with SMTP id
 i14-20020a056512224e00b004a2506055efmr9811442lfu.412.1667420555687; Wed, 02
 Nov 2022 13:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221031183122.470962-1-shy828301@gmail.com> <Y2BHcBCR2FIJgU4w@dhcp22.suse.cz>
 <CAAa6QmQt9Us8YpirQGXV0_AetuPS+EOqMSGqNn6KW24HXvwO_A@mail.gmail.com>
 <Y2DQr06mNzk0ITX1@dhcp22.suse.cz> <CAHbLzkonsnr4yxUOpMpoch1eCVNgR5hC9YaMkPR=fSV2Uszc6g@mail.gmail.com>
 <CAAa6QmRe1zMp8P-gZjR63Fg6KhOw+fP-v7SQWLNKuc2Y9ZxvyA@mail.gmail.com>
 <Y2IerOXJ+ZoRTHcs@dhcp22.suse.cz> <CAHbLzkrBNzsorc9oCq1=ri0uq1xbQ+m+u2gQX5GYrb=Z7n4siA@mail.gmail.com>
 <Y2KXkVmRWOpPT/MI@dhcp22.suse.cz> <CAHbLzkosQf8OoL+u+gkfO5-fvCNUuDxEa08FUfks1M4AS7tmjw@mail.gmail.com>
 <Y2KtKVpR69P+E0xT@dhcp22.suse.cz> <CAHbLzkpirnzJSu0SHGRbhFMsH7ZzHtL5ZMXjrBoy8r=UywVhMg@mail.gmail.com>
 <CAAa6QmQ+4XndbtE_=mcaC5OaeK4g42dKYfY5FmYoRDTKGO-3nA@mail.gmail.com> <CAHbLzkouJkixT0X_uGTrFj_qCyYikpr2j3LOo50rsY_P9OS8Xw@mail.gmail.com>
In-Reply-To: <CAHbLzkouJkixT0X_uGTrFj_qCyYikpr2j3LOo50rsY_P9OS8Xw@mail.gmail.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Wed, 2 Nov 2022 13:21:58 -0700
Message-ID: <CAAa6QmQRNGiHPzCtGem9HuCqUBbzUDYDibrw=-iZ=MeEWtOnCw@mail.gmail.com>
Subject: Re: [PATCH] mm: don't warn if the node is offlined
To:     Yang Shi <shy828301@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Davidoff <davidoff@qedmf.net>,
        Bob Liu <lliubbo@gmail.com>
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

On Wed, Nov 2, 2022 at 1:08 PM Yang Shi <shy828301@gmail.com> wrote:
>
> On Wed, Nov 2, 2022 at 11:59 AM Zach O'Keefe <zokeefe@google.com> wrote:
> >
> > On Wed, Nov 2, 2022 at 11:18 AM Yang Shi <shy828301@gmail.com> wrote:
> > >
> > > On Wed, Nov 2, 2022 at 10:47 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Wed 02-11-22 10:36:07, Yang Shi wrote:
> > > > > On Wed, Nov 2, 2022 at 9:15 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > >
> > > > > > On Wed 02-11-22 09:03:57, Yang Shi wrote:
> > > > > > > On Wed, Nov 2, 2022 at 12:39 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > > >
> > > > > > > > On Tue 01-11-22 12:13:35, Zach O'Keefe wrote:
> > > > > > > > [...]
> > > > > > > > > This is slightly tangential - but I don't want to send a new mail
> > > > > > > > > about it -- but I wonder if we should be doing __GFP_THISNODE +
> > > > > > > > > explicit node vs having hpage_collapse_find_target_node() set a
> > > > > > > > > nodemask. We could then provide fallback nodes for ties, or if some
> > > > > > > > > node contained > some threshold number of pages.
> > > > > > > >
> > > > > > > > I would simply go with something like this (not even compile tested):
> > > > > > >
> > > > > > > Thanks, Michal. It is definitely an option. As I talked with Zach, I'm
> > > > > > > not sure whether it is worth making the code more complicated for such
> > > > > > > micro optimization or not. Removing __GFP_THISNODE or even removing
> > > > > > > the node balance code should be fine too IMHO. TBH I doubt there would
> > > > > > > be any noticeable difference.
> > > > > >
> > > > > > I do agree that an explicit nodes (quasi)round robin sounds over
> > > > > > engineered. It makes some sense to try to target the prevalent node
> > > > > > though because this code can be executed from khugepaged and therefore
> > > > > > allocating with a completely different affinity than the original fault.
> > > > >
> > > > > Yeah, the corner case comes from the node balance code, it just tries
> > > > > to balance between multiple prevalent nodes, so you agree to remove it
> > > > > IIRC?
> > > >
> > > > Yeah, let's just collect all good nodes into a nodemask and keep
> > > > __GFP_THISNODE in place. You can consider having the nodemask per collapse_control
> > > > so that you allocate it only once in the struct lifetime.
> > >
> > > Actually my intention is more aggressive, just remove that node balance code.
> > >
> >
> > The balancing code dates back to 2013 commit 9f1b868a13ac ("mm: thp:
> > khugepaged: add policy for finding target node") where it was made to
> > satisfy "numactl --interleave=all". I don't know why any real
> > workloads would want this -- but there very well could be a valid use
> > case. If not, I think it could be removed independent of what we do
> > with __GFP_THISNODE and nodemask.
>
> Hmm... if the code is used for interleave, I don't think nodemask
> could preserve the behavior IIUC. The nodemask also tries to allocate
> memory from the preferred node, and fallback to the allowed nodes from
> nodemask when the allocation fails on the preferred node. But the
> round robin style node balance tries to distribute the THP on the
> nodes evenly.

Ya, I don't think this has anything to do with nodemask -- I think I
inadvertently started a discussion about it and we now have 2 threads
merged into one :)

> And I just thought of __GFP_THISNODE + nodemask should not be the
> right combination IIUC, right? __GFP_THISNODE does disallow any
> fallback, so nodemask is actually useless.

Ya I was confused when I read this the first time -- thanks for
clarifying my understanding.

> So I think we narrowed down to two options:
> 1. Preserve the interleave behavior but bail out if the target node is
> not online (it is also racy, but doesn't hurt)
> 2. Remove the node balance code entirely
>

Agreed. Really comes down to if we care about that "numactl
--interleave" use case. My inclination would be to just remove it --
if we didn't have that code today, and someone raised this use case
and asked for the code to be added, I'm not sure it'd be approved.

> >
> > Balancing aside -- I haven't fully thought through what an ideal (and
> > further overengineered) solution would be for numa, but one (perceived
> > - not measured) issue that khugepaged might have (MADV_COLLAPSE
> > doesn't have the choice) is on systems with many, many nodes with
> > source pages sprinkled across all of them. Should we collapse these
> > pages into a single THP from the node with the most (but could still
> > be a small %) pages? Probably there are better candidates. So, maybe a
> > khugepaged-only check for max_value > (HPAGE_PMD_NR >> 1) or something
> > makes sense.
>
> Anyway you have to allocate a THP on one node, I don't think of a
> better idea to make the node selection fairer. But I'd prefer to wait
> for real life usecase surfaces.

So, the thought here is that we don't _have_ to allocate a THP. We can
bail-out, just as we do with max_ptes_*, when we think allocating a
THP isn't beneficial. As mentioned, MADV_COLLAPSE still has to
allocate a THP -- but khugepaged need not. I'm fine waiting on this
until needed, however.

> >
> > > >
> > > > And as mentioned in other reply it would be really nice to hide this
> > > > under CONFIG_NUMA (in a standalong follow up of course).
> > >
> > > The hpage_collapse_find_target_node() function itself is defined under
> > > CONFIG_NUMA.
> > >
> > > >
> > > > --
> > > > Michal Hocko
> > > > SUSE Labs
