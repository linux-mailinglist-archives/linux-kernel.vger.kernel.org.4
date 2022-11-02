Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AC2616D46
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbiKBS7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbiKBS7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:59:14 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B69F1F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:59:05 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id j14so26221011ljh.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 11:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t75DvuVjvU8ErKkB8sfDwtGNgCI+Z6sqJYaVzvmVK/A=;
        b=MUP/AG+NNiZBTgmNQ6OfMmSid3DDYp7HtQco7foq508VnUZGteDOI+eFJ14oaHh0kV
         zy5pxl4sKYUklIfLktqU4bfR3vTxjchIkJZCU+8SnbaLYpmjAAfnl+D7T507mSmJGUDP
         W4sLJeyFJbgStOpJ0ZewD6MNe7V036GCuC0ctZbubE9g3url7E6yH3rpCGF2fwcOu/v9
         uQrqpV2jjd+sYeXxVUcrnLfoV4/QdnuPNaVf9/QZgNAIRJPGygLTuwin+mm0CrDJ9yMl
         TEzTwBrKzWwqeXds+YBIeHyfOFyvjP9ZgggNMUJtiNgSuj4A8y61GD1gqp+lP6Ks8ljI
         7P1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t75DvuVjvU8ErKkB8sfDwtGNgCI+Z6sqJYaVzvmVK/A=;
        b=43V6YitVEwCE09gLrMbGKwdpJB/65jasofcmX/Ugened+n1Xaz7KsBnx/WRiuyFzJj
         PSSbrDIOiQKeW3XAcHjxvt6b0Nyv0IPgdXEy5h8rnDSrr0uLEfbJ9Rg322DTyR26oORz
         1sU0GTvhBqiRbHUO9P+nhPmZ85FnQyOQub7Er8hhoo6KwBrmjo6ysicmI5Tj90cd+z/p
         HK4TqBgGb7Xn/w9DLHoYPuvdq7qAV+IbPBfcQOqIyHIS93GYqeiMpW62bhtkkvTNh3G/
         0DEqUJePkp3Fde/i9VDs3vIxzy7vdQflIR/zw8vSwmV99/ZqsJVXtuiV4ZRlgx8iDZje
         Xtmw==
X-Gm-Message-State: ACrzQf2b25KS4i25TEGq7mCJ55TM4mNQh0zaC0zHKjgoOoGMFW27UOmq
        629qrG/XtRdf+FIyBrzGfWxm4zNUpC6sjX4GfDD8oA==
X-Google-Smtp-Source: AMsMyM7BJbGl07H3PmzfwOoksLa52lkbMBKu2vdfiDt6LeVz6JfHt+wc3jYY53SxUNF0LsDH0MlDeXt7k/2BrK6oRhI=
X-Received: by 2002:a2e:98ce:0:b0:277:4887:944d with SMTP id
 s14-20020a2e98ce000000b002774887944dmr7585040ljj.426.1667415543120; Wed, 02
 Nov 2022 11:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221031183122.470962-1-shy828301@gmail.com> <Y2BHcBCR2FIJgU4w@dhcp22.suse.cz>
 <CAAa6QmQt9Us8YpirQGXV0_AetuPS+EOqMSGqNn6KW24HXvwO_A@mail.gmail.com>
 <Y2DQr06mNzk0ITX1@dhcp22.suse.cz> <CAHbLzkonsnr4yxUOpMpoch1eCVNgR5hC9YaMkPR=fSV2Uszc6g@mail.gmail.com>
 <CAAa6QmRe1zMp8P-gZjR63Fg6KhOw+fP-v7SQWLNKuc2Y9ZxvyA@mail.gmail.com>
 <Y2IerOXJ+ZoRTHcs@dhcp22.suse.cz> <CAHbLzkrBNzsorc9oCq1=ri0uq1xbQ+m+u2gQX5GYrb=Z7n4siA@mail.gmail.com>
 <Y2KXkVmRWOpPT/MI@dhcp22.suse.cz> <CAHbLzkosQf8OoL+u+gkfO5-fvCNUuDxEa08FUfks1M4AS7tmjw@mail.gmail.com>
 <Y2KtKVpR69P+E0xT@dhcp22.suse.cz> <CAHbLzkpirnzJSu0SHGRbhFMsH7ZzHtL5ZMXjrBoy8r=UywVhMg@mail.gmail.com>
In-Reply-To: <CAHbLzkpirnzJSu0SHGRbhFMsH7ZzHtL5ZMXjrBoy8r=UywVhMg@mail.gmail.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Wed, 2 Nov 2022 11:58:26 -0700
Message-ID: <CAAa6QmQ+4XndbtE_=mcaC5OaeK4g42dKYfY5FmYoRDTKGO-3nA@mail.gmail.com>
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

On Wed, Nov 2, 2022 at 11:18 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Wed, Nov 2, 2022 at 10:47 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 02-11-22 10:36:07, Yang Shi wrote:
> > > On Wed, Nov 2, 2022 at 9:15 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Wed 02-11-22 09:03:57, Yang Shi wrote:
> > > > > On Wed, Nov 2, 2022 at 12:39 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > >
> > > > > > On Tue 01-11-22 12:13:35, Zach O'Keefe wrote:
> > > > > > [...]
> > > > > > > This is slightly tangential - but I don't want to send a new mail
> > > > > > > about it -- but I wonder if we should be doing __GFP_THISNODE +
> > > > > > > explicit node vs having hpage_collapse_find_target_node() set a
> > > > > > > nodemask. We could then provide fallback nodes for ties, or if some
> > > > > > > node contained > some threshold number of pages.
> > > > > >
> > > > > > I would simply go with something like this (not even compile tested):
> > > > >
> > > > > Thanks, Michal. It is definitely an option. As I talked with Zach, I'm
> > > > > not sure whether it is worth making the code more complicated for such
> > > > > micro optimization or not. Removing __GFP_THISNODE or even removing
> > > > > the node balance code should be fine too IMHO. TBH I doubt there would
> > > > > be any noticeable difference.
> > > >
> > > > I do agree that an explicit nodes (quasi)round robin sounds over
> > > > engineered. It makes some sense to try to target the prevalent node
> > > > though because this code can be executed from khugepaged and therefore
> > > > allocating with a completely different affinity than the original fault.
> > >
> > > Yeah, the corner case comes from the node balance code, it just tries
> > > to balance between multiple prevalent nodes, so you agree to remove it
> > > IIRC?
> >
> > Yeah, let's just collect all good nodes into a nodemask and keep
> > __GFP_THISNODE in place. You can consider having the nodemask per collapse_control
> > so that you allocate it only once in the struct lifetime.
>
> Actually my intention is more aggressive, just remove that node balance code.
>

The balancing code dates back to 2013 commit 9f1b868a13ac ("mm: thp:
khugepaged: add policy for finding target node") where it was made to
satisfy "numactl --interleave=all". I don't know why any real
workloads would want this -- but there very well could be a valid use
case. If not, I think it could be removed independent of what we do
with __GFP_THISNODE and nodemask.

Balancing aside -- I haven't fully thought through what an ideal (and
further overengineered) solution would be for numa, but one (perceived
- not measured) issue that khugepaged might have (MADV_COLLAPSE
doesn't have the choice) is on systems with many, many nodes with
source pages sprinkled across all of them. Should we collapse these
pages into a single THP from the node with the most (but could still
be a small %) pages? Probably there are better candidates. So, maybe a
khugepaged-only check for max_value > (HPAGE_PMD_NR >> 1) or something
makes sense.

> >
> > And as mentioned in other reply it would be really nice to hide this
> > under CONFIG_NUMA (in a standalong follow up of course).
>
> The hpage_collapse_find_target_node() function itself is defined under
> CONFIG_NUMA.
>
> >
> > --
> > Michal Hocko
> > SUSE Labs
