Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B6F616BD7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiKBSSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiKBSSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:18:46 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF302F00D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:18:45 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id b21so1485520plc.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 11:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CdYKm5wdZipIcutmvlbbV3SRLDzTmAvD0R5AITtaDwQ=;
        b=WKGMtqnGUFEZ/CNX5AzbQ/FhR7nrJMzCa5zkAFrTr6uyWYNFdTVdCm7p8oanZs4h2V
         cbBie+UH1s35PXHnnh/5B9FKvIH6Ah0ODn8oaPKlf00e/BUkZLuDLiueRs1hAuKgK923
         eBo9QDZVPIrbndZ2aJlLt3eTeks1sVGhf/FgZqWKs857vJL7vplOjWr2YdDowVg3N/xx
         B3A2/Jsm62mwW/kuk2Dg55G9Gi4RfQMVcnVZ8WokzYtNr0JYKFMUyQi1EKfNmV3e/l9N
         8Vfobi2LoqvjATM2bKvEpQ5KF1vWPM2LIYl0zLqwT+CbaJga6uqLYzQlmbMBFPloCCwj
         qe4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CdYKm5wdZipIcutmvlbbV3SRLDzTmAvD0R5AITtaDwQ=;
        b=thJUmKNP1idPVG8uWMXBlX+PZe3U97QmjBzMQ3hukAWTZm2JfJbRH55QqigSDBr8dM
         SUkoBf9MbeB1+GgU3XNxGIVcVr1DL68IB+d2fBoBe94Cjymtu4/ALOK2BdDYmZniMS7n
         hGGrmoUoQBGc1ynJAMGFSdTyI1u9i5Fyf2HQHSXlP+egvBh6pfJ+UMRlLLBXJE41Nxyu
         k1K0T1cbUCqHcmWC8mVcLvveG7Rckr/cJqYJ9TH9R99FP0p1TuuDvfNzaqpms07Ry1kx
         k0hSnZgGaEpDye043KFDxRr9HDsR4YD3jzHeEJN1egQ1Lh8fTU74YdZV3/UP6sXpqHbQ
         5D2w==
X-Gm-Message-State: ACrzQf24W5u9nHVc/Yo/3ff20A3lKXQyd35u280o9ZCootgSy5H3R+To
        vBrr1SeOkb4/JTSAyB0f4oZD35MgPC1K94ysq2hmLLiO1ZA=
X-Google-Smtp-Source: AMsMyM54X1Zpmkji1PfXTjwCNdQgHbqXfhZ13VKDHjuaxGhd0A4pd8WcqUOGEwJL2kX4PI/gWSshiLMErRJVJOz2Byw=
X-Received: by 2002:a17:902:d512:b0:181:f1f4:fcb4 with SMTP id
 b18-20020a170902d51200b00181f1f4fcb4mr26418445plg.102.1667413125322; Wed, 02
 Nov 2022 11:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221031183122.470962-1-shy828301@gmail.com> <Y2BHcBCR2FIJgU4w@dhcp22.suse.cz>
 <CAAa6QmQt9Us8YpirQGXV0_AetuPS+EOqMSGqNn6KW24HXvwO_A@mail.gmail.com>
 <Y2DQr06mNzk0ITX1@dhcp22.suse.cz> <CAHbLzkonsnr4yxUOpMpoch1eCVNgR5hC9YaMkPR=fSV2Uszc6g@mail.gmail.com>
 <CAAa6QmRe1zMp8P-gZjR63Fg6KhOw+fP-v7SQWLNKuc2Y9ZxvyA@mail.gmail.com>
 <Y2IerOXJ+ZoRTHcs@dhcp22.suse.cz> <CAHbLzkrBNzsorc9oCq1=ri0uq1xbQ+m+u2gQX5GYrb=Z7n4siA@mail.gmail.com>
 <Y2KXkVmRWOpPT/MI@dhcp22.suse.cz> <CAHbLzkosQf8OoL+u+gkfO5-fvCNUuDxEa08FUfks1M4AS7tmjw@mail.gmail.com>
 <Y2KtKVpR69P+E0xT@dhcp22.suse.cz>
In-Reply-To: <Y2KtKVpR69P+E0xT@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 2 Nov 2022 11:18:32 -0700
Message-ID: <CAHbLzkpirnzJSu0SHGRbhFMsH7ZzHtL5ZMXjrBoy8r=UywVhMg@mail.gmail.com>
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

On Wed, Nov 2, 2022 at 10:47 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 02-11-22 10:36:07, Yang Shi wrote:
> > On Wed, Nov 2, 2022 at 9:15 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Wed 02-11-22 09:03:57, Yang Shi wrote:
> > > > On Wed, Nov 2, 2022 at 12:39 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Tue 01-11-22 12:13:35, Zach O'Keefe wrote:
> > > > > [...]
> > > > > > This is slightly tangential - but I don't want to send a new mail
> > > > > > about it -- but I wonder if we should be doing __GFP_THISNODE +
> > > > > > explicit node vs having hpage_collapse_find_target_node() set a
> > > > > > nodemask. We could then provide fallback nodes for ties, or if some
> > > > > > node contained > some threshold number of pages.
> > > > >
> > > > > I would simply go with something like this (not even compile tested):
> > > >
> > > > Thanks, Michal. It is definitely an option. As I talked with Zach, I'm
> > > > not sure whether it is worth making the code more complicated for such
> > > > micro optimization or not. Removing __GFP_THISNODE or even removing
> > > > the node balance code should be fine too IMHO. TBH I doubt there would
> > > > be any noticeable difference.
> > >
> > > I do agree that an explicit nodes (quasi)round robin sounds over
> > > engineered. It makes some sense to try to target the prevalent node
> > > though because this code can be executed from khugepaged and therefore
> > > allocating with a completely different affinity than the original fault.
> >
> > Yeah, the corner case comes from the node balance code, it just tries
> > to balance between multiple prevalent nodes, so you agree to remove it
> > IIRC?
>
> Yeah, let's just collect all good nodes into a nodemask and keep
> __GFP_THISNODE in place. You can consider having the nodemask per collapse_control
> so that you allocate it only once in the struct lifetime.

Actually my intention is more aggressive, just remove that node balance code.

>
> And as mentioned in other reply it would be really nice to hide this
> under CONFIG_NUMA (in a standalong follow up of course).

The hpage_collapse_find_target_node() function itself is defined under
CONFIG_NUMA.

>
> --
> Michal Hocko
> SUSE Labs
