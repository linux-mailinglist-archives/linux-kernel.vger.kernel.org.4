Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FE06A2379
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 22:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjBXVIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 16:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjBXVIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 16:08:13 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF571172D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:08:09 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-536c02c9dfbso12775027b3.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r9wbtuNWxleLVb+yv1W4YJD99O7SwvhETxSj/pnC9ng=;
        b=J2qtqCA+5ZQmTHiIw8vCilrIMysrXV71zTJEb0wTKP0wM2N2WmTk9VbR3vxbfYjajU
         K/oT6b4/lND/oZwRwipH8gwwMVb9TFX8FxZ3+MzAE4r5nSaNUF6UdlAYzzvjs+I6kJtI
         oNOMHUvJjfnB5BnSlyy9eQqSX9RuVCRWcZh9fRD2a0tc4hTDXmPnB7tr81DDD+3smuH/
         lHI+NeRXzVqDvCbvtXwd2s37musw4zKP8F7e91pjhs7eyT3ha+3dUEewcUOZmDpswchE
         Ogag6IEK2YmR/ugdKYJkKe6Oqj5Xwo+CMac30zuu6jVj9kl0DKZ6XNjNPal/nF5U42pg
         Nh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r9wbtuNWxleLVb+yv1W4YJD99O7SwvhETxSj/pnC9ng=;
        b=2PhFnRoU67KDQ4hMJO5XviQvomN7JE/ovXBE4j1MfvaWwGbEcCwXPInbf0ljhEhR2b
         HvnyFtAW7QHUOvFy5yRYaIe7Lm+Lezfefo018QKnGbJrvMrch2jW2htENilPMZRo+9Tc
         /VAF3N/IVmFVOwKKmPA5ox3jVOLV3PShq9wv9K/PWtRmcU0QM4+VISY/11Xz4nzN98mO
         OifrSRUuCsNWKTloiIhNBd1Q7vJ4BMOHPFFwAdPGnOZiIB5mBLcmod5061/6OuQIeor5
         8FTVqWRUcV74PFKh2imrodLbd9ffYLqZTzXq6KTAp6NG+IdBQvMOtjHnyJRYX5rUQiDi
         0Dkg==
X-Gm-Message-State: AO0yUKUSh7ZnGVIXttGIKWnHnlWKhFB4po/zghFAuxb3OO1nTntI6u5f
        wcZ/o1iJtSbwW9E7aeXGywaU1qgUfo4FirArVFxyJQ==
X-Google-Smtp-Source: AK7set/R8z3TkKd/DLEGjmQ4A1pJVjHZYBqwBiRWEVXdVQUwRn8oZNnugQOi7mX79ntQNFM+TZ3lv4pm0awpGiW/ApU=
X-Received: by 2002:a5b:10d:0:b0:a30:38fb:a2e4 with SMTP id
 13-20020a5b010d000000b00a3038fba2e4mr3033930ybx.6.1677272888751; Fri, 24 Feb
 2023 13:08:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676067791.git.quic_sudaraja@quicinc.com>
 <CAJuCfpHWQ8NV=iR3BN+pt1c8FynCnRqyyriHb1gLxFgiNVrwjA@mail.gmail.com>
 <e944536f-a04c-5528-601e-d7f505a761e8@quicinc.com> <CAJuCfpGLkkS2yx0d9+2nYtEtxANSH5H3EgCmWZax4N-ieEBG7g@mail.gmail.com>
 <15cd8816-b474-0535-d854-41982d3bbe5c@quicinc.com> <CAJuCfpHihLgHCcsAqMJ_o2u7Ux9B5HFGsV2y_L2_5GXYAGYLnw@mail.gmail.com>
 <82406da2-799e-f0b4-bce0-7d47486030d4@quicinc.com> <CAJuCfpHrhO7_fMwNuu2hdQob=MPjZTW8eaJpNhEhPmDMqz2qTA@mail.gmail.com>
 <Y/ix53x8i/ViuBXf@dhcp22.suse.cz>
In-Reply-To: <Y/ix53x8i/ViuBXf@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 24 Feb 2023 13:07:57 -0800
Message-ID: <CAJuCfpG1c5v6qOotPV6t-o1T1p7EbOLs90eFnoEBjts+gafovA@mail.gmail.com>
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
        Patrick Daly <quic_pdaly@quicinc.com>
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

On Fri, Feb 24, 2023 at 4:47 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 14-02-23 11:34:30, Suren Baghdasaryan wrote:
> [...]
> > Your suggestion to have this limit configurable sounds like obvious
> > solution. I would like to get some opinions from other maintainers.
> > Johannes, WDYT? CC'ing Michal to chime in as well since this is mostly
> > related to memory stalls.
>
> I do not think that making this configurable helps much. Many users will
> be bound to distribution config and also it would be hard to experiment
> with a recompile cycle every time. This seems just too impractical.
>
> Is there any reason why we shouldn't allow any timeout? Shorter
> timeouts could be restricted to a priviledged context to avoid an easy
> way to swamp system by too frequent polling.

Hmm, ok. Maybe then we just ensure that only privileged users can set
triggers and remove the min limit (use a >0 check)?

>
> Btw. it seems that there is is only a limit on a single trigger per fd
> but no limits per user so it doesn't sound too hard to end up with too
> much polling even with a larger timeouts. To me it seems like we need to
> contain the polling thread to be bound by the cpu controller.

Hmm. We have one "psimon" thread per cgroup (+1 system-level one) and
poll_min_period for each thread is chosen as the min() of polling
periods between triggers created in that group. So, a bad trigger that
causes overly aggressive polling and polling thread being throttled,
might affect other triggers in that cgroup.
I would prefer to deny creation of a new trigger if it would cause too
much polling. However, that seems to be getting into the territory of
"implementing policy inside the kernel". Maybe we just limit trigger
creation to privileged processes only and let those privileged system
components worry about trigger creation policies? These system
processes can also limit cpu shares of all "psimon" threads using cpu
controller, if desired. WDYT?

> --
> Michal Hocko
> SUSE Labs
