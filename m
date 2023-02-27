Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BEA6A4893
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjB0RuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjB0RuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:50:14 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4504A83E8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:50:13 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-536bbe5f888so197834597b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 09:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NoJU+P+wk0oP4uOQVAulVzE7C+CLPILBxmnJLRQCZ04=;
        b=PiMWHRJUpVelTbxf7LJVGiZYvQnIU3y8Qacrg9vzNxq2j3lwg+vo/OZkyZllDmIpIh
         KIwD10qtsZtlacmxcJAvI+IOxTl2OMd78qzCYpADGpGkbHYgF8JTH1OAJS2gxfaqbva1
         Ampsmh7LW/cdt1IMF583Yq0R8mDIK3gD4fFaN5xq9N/CYkmKy57ydA+dWMrW9VQ4K9Vi
         twbl3C44EY4+K2+vd38kHJQvyew+ugfDirLXryujzn+4EUbS4pNPZQFTd80oBNSB1eOD
         EhoiujTNyy6Q63JD98dL4xAXk89mwbViAXrxemw1QVXvzvpjnFD0DQZTJ//sW7PGky6h
         KG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NoJU+P+wk0oP4uOQVAulVzE7C+CLPILBxmnJLRQCZ04=;
        b=X6VrVGXUKB9hw/0vrE7H5Ng4/Hr5ZnSFYU4RGXQXdUlxFrCLj0eKliSfjro7bxK34A
         1QOIPnD91QMiSKvX5DLMrEiL6PuNHQqJQ8YT6/UbjvCWjCiZOqa+kSxFH6t6u56GpSzP
         QWVeSFb6slxLjDULb2pUQAwUwSWcjv110NsfL03pPp/qrWajvkr/MK0V0F7DlorOESHP
         q8g1YxsILZxhlOlEHOAAsLfxh5B9Hg/R3suLqoUA3b7V2Aqt0gWsIn1ArvjuBcY/Pt62
         VjmbOcDPO08IhTF29A/wdyG0nmdFpVd8ZjkQK5LKMhj3TI568MEDykyJcxU4rrO5LY1y
         Vx3g==
X-Gm-Message-State: AO0yUKX7kh8///JaPwNihegSWjhdD2k3y7ihpM9AczUDwLzjDW0f/ifC
        FzUkK3u66mDotAltW21ZIDEY0kdy9mwdXCZMy9Cgjg==
X-Google-Smtp-Source: AK7set+AuUEVky3TlKUD481gMrdm00yhbolbqC6ZjtveZ4fmE3p+G7HBX+5fhoi8eN6gwoWKepOXmPldg78dfHdQaV4=
X-Received: by 2002:a81:ad27:0:b0:533:9d49:f9c9 with SMTP id
 l39-20020a81ad27000000b005339d49f9c9mr11022028ywh.0.1677520212213; Mon, 27
 Feb 2023 09:50:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676067791.git.quic_sudaraja@quicinc.com>
 <CAJuCfpHWQ8NV=iR3BN+pt1c8FynCnRqyyriHb1gLxFgiNVrwjA@mail.gmail.com>
 <e944536f-a04c-5528-601e-d7f505a761e8@quicinc.com> <CAJuCfpGLkkS2yx0d9+2nYtEtxANSH5H3EgCmWZax4N-ieEBG7g@mail.gmail.com>
 <15cd8816-b474-0535-d854-41982d3bbe5c@quicinc.com> <CAJuCfpHihLgHCcsAqMJ_o2u7Ux9B5HFGsV2y_L2_5GXYAGYLnw@mail.gmail.com>
 <82406da2-799e-f0b4-bce0-7d47486030d4@quicinc.com> <CAJuCfpHrhO7_fMwNuu2hdQob=MPjZTW8eaJpNhEhPmDMqz2qTA@mail.gmail.com>
 <Y/ix53x8i/ViuBXf@dhcp22.suse.cz> <CAJuCfpG1c5v6qOotPV6t-o1T1p7EbOLs90eFnoEBjts+gafovA@mail.gmail.com>
 <Y/yxSqhpQh9yR7L4@dhcp22.suse.cz>
In-Reply-To: <Y/yxSqhpQh9yR7L4@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 27 Feb 2023 09:49:59 -0800
Message-ID: <CAJuCfpHXwbtjdhH_K9r28-LUYtzC6+NaZ+RrKCtiNBk8PfXhLw@mail.gmail.com>
Subject: Re: [PATCH] psi: reduce min window size to 50ms
To:     Michal Hocko <mhocko@suse.com>
Cc:     Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        mark.rutland@arm.com, will@kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Sukadev Bhattiprolu <quic_sukadev@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Patrick Daly <quic_pdaly@quicinc.com>, johunt@akamai.com
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

On Mon, Feb 27, 2023 at 5:34 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 24-02-23 13:07:57, Suren Baghdasaryan wrote:
> > On Fri, Feb 24, 2023 at 4:47 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Tue 14-02-23 11:34:30, Suren Baghdasaryan wrote:
> > > [...]
> > > > Your suggestion to have this limit configurable sounds like obvious
> > > > solution. I would like to get some opinions from other maintainers.
> > > > Johannes, WDYT? CC'ing Michal to chime in as well since this is mostly
> > > > related to memory stalls.
> > >
> > > I do not think that making this configurable helps much. Many users will
> > > be bound to distribution config and also it would be hard to experiment
> > > with a recompile cycle every time. This seems just too impractical.
> > >
> > > Is there any reason why we shouldn't allow any timeout? Shorter
> > > timeouts could be restricted to a priviledged context to avoid an easy
> > > way to swamp system by too frequent polling.
> >
> > Hmm, ok. Maybe then we just ensure that only privileged users can set
> > triggers and remove the min limit (use a >0 check)?
>
> This could break existing userspace which is not privileged. I would
> just go with CAP_SYS_NICE or similar with small (sub min) timeouts.

Yeah, that's what I meant. /proc/pressure/* files already check for
CAP_SYS_RESOURCE
(https://elixir.bootlin.com/linux/latest/source/kernel/sched/psi.c#L1440)
but per-cgroup pressure files do not have this check. I think the
original patch which added this check
(https://lore.kernel.org/all/20210402025833.27599-1-johunt@akamai.com/)
missed the cgroup ones. This should be easy to add but I wonder if
that was left that way intentionally.

CC'ing the author. Josh, Johannes is that inconsistency between system
pressure files and cgroup-specific ones intentional? Can we change
them all to check for CAP_SYS_RESOURCE?

>
> > > Btw. it seems that there is is only a limit on a single trigger per fd
> > > but no limits per user so it doesn't sound too hard to end up with too
> > > much polling even with a larger timeouts. To me it seems like we need to
> > > contain the polling thread to be bound by the cpu controller.
> >
> > Hmm. We have one "psimon" thread per cgroup (+1 system-level one) and
> > poll_min_period for each thread is chosen as the min() of polling
> > periods between triggers created in that group. So, a bad trigger that
> > causes overly aggressive polling and polling thread being throttled,
> > might affect other triggers in that cgroup.
>
> Yes, and why that would be a problem?

If unprivileged processes are allowed to add new triggers then a
malicious process can add a bad trigger and affect other legit
processes. That sounds like a problem to me.
Thanks,
Suren.

> --
> Michal Hocko
> SUSE Labs
