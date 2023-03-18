Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5D66BF71A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 01:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjCRA6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 20:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjCRA6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 20:58:39 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE46D64879
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 17:58:37 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id r1so7523352ybu.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 17:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679101117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjzUh8wvEqOhjDa9bqpHAUbvJHT68H6FHaSidqfbom8=;
        b=JVXYvxAJeUXHaKDbRodHwwtH7IQbXLRoiZr3q/I9SA2PCpkS1A7jED2SYMDkJTLBLv
         LBkOeMxmB5abOcyMXF5T1ALdKfk1bSw5BQEvIilpvJs77fL+HDTEDX9+gKH3RtDieSKP
         vbfLPrrOBKZOzx73nkbbXIjbsv8pRnYEwsIr+/yjETCCg+eYwK/QWp1+WAx+ALkV4MvY
         /VivS/YbrC2rsHalrhTI922KgXxyVaQsQu7kjf3zjmGU6o512Et9PEi0irT3IVbpQEcV
         Tu1TX0cyiKBZrpslrzTS6GopLi8jnKqRS6ssSqutjLuhZ4Hz7QuXjUdKltEvKgtRTueB
         NIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679101117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjzUh8wvEqOhjDa9bqpHAUbvJHT68H6FHaSidqfbom8=;
        b=pJiEEAtf9Fd/54EWkyelUVOp3XU2Ru+4uG1NXVsigQ4XZecgLNfJxdvm29HgLrDlpa
         Ozgs2lBwWEw3gEb7DbnYDHbZTMwRNE1V6z07x+JVfzv2mUOmUzNJjKoT5912S9wfhkBf
         gUK+ct1XchFoeJzAze4CeyIWpldM+7zGFB0Kmc1FRETZbz0NnTGa6cImEo5bvwJxsY8s
         wF35IgfFT20Z9pA8pLqKAOGvJ12FoWnC7A5oa8PupgZZZLxSlzL5xI5tf6augnfpX769
         JXRoRnasoOx32NfJqGZELqKE/V6lumyqw3HeLBqKTGbq7AqfuWHPjpqhIqAJ96nLSHln
         4nwg==
X-Gm-Message-State: AO0yUKVJqMoAGqGHo242CzHI2ZgcS1rP7AjwDBsF+nYkMIwn34FtOF2b
        QShQgcTTObb8I99Va7nN+PybF7ZwynOsYq0clLKkc/pJGDiDdPIQfMY=
X-Google-Smtp-Source: AK7set8rZKyofT08VT/4toGO7Bnz9V/ECQUG2scWBzJIC/cG94HLuywYF5c0qXC+TDUhfbx0tdvYog1tKPp9+MZE+U0=
X-Received: by 2002:a5b:c47:0:b0:b56:1f24:7e9f with SMTP id
 d7-20020a5b0c47000000b00b561f247e9fmr280644ybr.12.1679101117000; Fri, 17 Mar
 2023 17:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230308162555.14195-1-findns94@gmail.com> <ZAjIeTBKteZaYEEb@dhcp22.suse.cz>
In-Reply-To: <ZAjIeTBKteZaYEEb@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 17 Mar 2023 17:58:26 -0700
Message-ID: <CALvZod4UjoYasn8Z4-e4NEdv9QRWiuJuJjm8+sH_xFdPTEWEoA@mail.gmail.com>
Subject: Re: [PATCH v3, 0/4] mm, memcg: cgroup v1 and v2 tunable load/store
 tearing fixes
To:     Michal Hocko <mhocko@suse.com>
Cc:     Yue Zhao <findns94@gmail.com>, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, hannes@cmpxchg.org,
        muchun.song@linux.dev, willy@infradead.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        tangyeechou@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 9:40=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Thu 09-03-23 00:25:51, Yue Zhao wrote:
> > This patch series helps to prevent load/store tearing in
> > several cgroup knobs.
> >
> > As kindly pointed out by Michal Hocko, we should add
> > [WRITE|READ]_ONCE for all occurrences of memcg->oom_kill_disable,
> > memcg->swappiness and memcg->soft_limit.
> >
> > v3:
> > - Add [WRITE|READ]_ONCE for all occurrences of
> > memcg->oom_kill_disable, memcg->swappiness and memcg->soft_limit
> > v2:
> > - Rephrase changelog
> > - Add [WRITE|READ]_ONCE for memcg->oom_kill_disable,
> >  memcg->swappiness, vm_swappiness and memcg->soft_limit
> > v1:
> > - Add [WRITE|READ]_ONCE for memcg->oom_group
> >
> > Past patches:
> > V2: https://lore.kernel.org/linux-mm/20230306154138.3775-1-findns94@gma=
il.com/
> > V1: https://lore.kernel.org/linux-mm/20230220151638.1371-1-findns94@gma=
il.com/
> >
> > Yue Zhao (4):
> >   mm, memcg: Prevent memory.oom.group load/store tearing
> >   mm, memcg: Prevent memory.swappiness load/store tearing
> >   mm, memcg: Prevent memory.oom_control load/store tearing
> >   mm, memcg: Prevent memory.soft_limit_in_bytes load/store tearing
> >
> >  include/linux/swap.h |  8 ++++----
> >  mm/memcontrol.c      | 30 +++++++++++++++---------------
> >  2 files changed, 19 insertions(+), 19 deletions(-)
>
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> Btw. you could have preserved acks for patches you haven't changed from
> the previous version.
>

For whole series:

Acked-by: Shakeel Butt <shakeelb@google.com>
