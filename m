Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02008666245
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 18:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjAKRtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 12:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjAKRtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 12:49:21 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3231262D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:49:21 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-4b718cab0e4so205128107b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ePKFgxTY+N2/lJawjZfA8T7NwNNbVvAEDKDS+DodhcA=;
        b=oGppCfJz0FFp5Y7cMmyBjVC+6IJyztjkXrGbuY9sKKHCI8eMmhM/7O2McEjp6gADmb
         +V0NeF2kWF2Nwx3q9gWsm+nYAZhClko9G/+1YL3Na6XbuL8eK6Mt2K1h5TrUYNL0gjZj
         EdKTPpbii1X0xYEnTvCQabouks/frlB8HMIKJNjssTNM0vareCnqE5qN+nZhpNCV2op3
         vHTLk1IVN7BpUvGL+T4ErN0fFl3kMEblGRpIp40HU1gf3C0N2si3drvDv1CfDZFLItf8
         1vJX689W9VLjkDAY6yF+wPxZNPjwU2oyoT1WYSGmqbPzVRb6IwqfBJ9W1QC0Fo04OXv2
         /HDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ePKFgxTY+N2/lJawjZfA8T7NwNNbVvAEDKDS+DodhcA=;
        b=25K39Y+NPtPZnfyyHyePm1Y31ZCQOekllwQAUTjCbc8EAJAehYO+9d1cwLmfL/GoKP
         SrZnSdSPJklN09ggUdVAQc7Fj6s0yHYTy95FSCi0UbdIDZ8RfwuYQ362gLDOqlzp2BlZ
         TQ0C/Yt3O7PfggROcEXjp6R+8ZZaYhwVh9rPyXnChgQpsOoq/UfWMZHmm0kuPDq6gnJQ
         C3e1FDOjma7gdYLpebj7R6HDsJVwCW3Q6aFcC3QPhql3yU15NZoYPIevCMOO4k7CCQqJ
         xoISyUAt9sZzCaEHLvYJFT98wFKdzSLkQTHNeEy9aop2a7jiNM9SKcfGI98yfCtVJmfz
         XVhg==
X-Gm-Message-State: AFqh2krP1GJyozUD0CBd+O25cmG9QhKmTyFdwMRghfs2EJPUG3AVS5pq
        9yONZ8jMjHx2VgFBhnFLfCS/qMDyzNSaQgCM4Yx9WQ==
X-Google-Smtp-Source: AMrXdXuOq+0O+cDiW8MM05elg260zh8GUOYQodmwyx/lttE2iOJ2vqd6ut8RJ3mh7qgQEhbfljGWdCv4611jx4QWNMI=
X-Received: by 2002:a0d:c2c5:0:b0:433:f1c0:3f1c with SMTP id
 e188-20020a0dc2c5000000b00433f1c03f1cmr1980213ywd.438.1673459360046; Wed, 11
 Jan 2023 09:49:20 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-9-surenb@google.com>
 <20230111001331.cxdeh52vvta6ok2p@offworld> <CAJuCfpEv--awCY0=R3h5Fez8x74U1EZCzNkq4_7deCYqej5sSA@mail.gmail.com>
 <Y75x5fGPcJ63pBIp@dhcp22.suse.cz> <Y76HTfIeEt8ZOIH3@gmail.com>
 <6be809f5554a4faaa22c287ba4224bd0@AcuMS.aculab.com> <CAJuCfpH_VZq99=vGQGJ+evVg5wMPKGsjyawgHnOeoKhtEiAi6w@mail.gmail.com>
 <Y77ndimzUsVZwjTk@dhcp22.suse.cz> <CAJuCfpEEiFNAgb6TNwibUyTJ1J3b-rEGCSw63TiK6FSA=HCdtw@mail.gmail.com>
 <Y77zwYHMfjOL+9EK@dhcp22.suse.cz>
In-Reply-To: <Y77zwYHMfjOL+9EK@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 11 Jan 2023 09:49:08 -0800
Message-ID: <CAJuCfpHCRL5B7SxqTgNbpJqhFwzROX4HAOH5KArO1iXNs_3Kcg@mail.gmail.com>
Subject: Re: [PATCH 08/41] mm: introduce CONFIG_PER_VMA_LOCK
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Ingo Molnar <mingo@kernel.org>,
        "michel@lespinasse.org" <michel@lespinasse.org>,
        "joelaf@google.com" <joelaf@google.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "leewalsh@google.com" <leewalsh@google.com>,
        "david@redhat.com" <david@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "jglisse@google.com" <jglisse@google.com>,
        "punit.agrawal@bytedance.com" <punit.agrawal@bytedance.com>,
        "arjunroy@google.com" <arjunroy@google.com>,
        "minchan@google.com" <minchan@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "gurua@google.com" <gurua@google.com>,
        "laurent.dufour@fr.ibm.com" <laurent.dufour@fr.ibm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "axelrasmussen@google.com" <axelrasmussen@google.com>,
        "kernel-team@android.com" <kernel-team@android.com>,
        "soheil@google.com" <soheil@google.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "liam.howlett@oracle.com" <liam.howlett@oracle.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "gthelen@google.com" <gthelen@google.com>,
        "ldufour@linux.ibm.com" <ldufour@linux.ibm.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "posk@google.com" <posk@google.com>,
        "lstoakes@gmail.com" <lstoakes@gmail.com>,
        "peterjung1337@gmail.com" <peterjung1337@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kent.overstreet@linux.dev" <kent.overstreet@linux.dev>,
        "hughlynch@google.com" <hughlynch@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tatashin@google.com" <tatashin@google.com>
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

On Wed, Jan 11, 2023 at 9:37 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 11-01-23 09:04:41, Suren Baghdasaryan wrote:
> > On Wed, Jan 11, 2023 at 8:44 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Wed 11-01-23 08:28:49, Suren Baghdasaryan wrote:
> > > [...]
> > > > Anyhow. Sounds like the overhead of the current design is small enough
> > > > to remove CONFIG_PER_VMA_LOCK and let it depend only on architecture
> > > > support?
> > >
> > > Yes. Further optimizations can be done on top. Let's not over optimize
> > > at this stage.
> >
> > Sure, I won't optimize any further.
> > Just to expand on your question. Original design would be problematic
> > for embedded systems like Android. It notoriously has a high number of
> > VMAs due to anonymous VMAs being named, which prevents them from
> > merging.
>
> What is the usual number of VMAs in that environment?

I've seen some games which had over 4000 VMAs but that's on the upper
side. In my calculations I used 40000 VMAs as a ballpark number and
rough calculations before size optimization would increase memory
consumption by ~2M (depending on the lock placement in vm_area_struct
it would vary a bit). In Android, the performance team flags any
change that exceeds 500KB, so it would raise questions.

>
> --
> Michal Hocko
> SUSE Labs
