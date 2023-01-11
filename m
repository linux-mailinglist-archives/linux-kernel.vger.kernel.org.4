Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A69366615E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 18:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239541AbjAKRHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 12:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239078AbjAKRGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 12:06:40 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A884321B9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:04:53 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id c82so8412232ybf.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LTJYmIxK7HXmivC0K3EGms7i6vie+YSU0ogRPhLAOWY=;
        b=mNAGtaf8jUOcbLC2GpY2IoOKVHZsaeSbuTMqB0BfbfYLRyVOF36Ix55jRi6VXABc2C
         TxHjeefcMzNJWY/YYv6W5ahFqaQmr9lvf1jGIqiEx8ySeybJFbSXh7kyg0REyOpFJ3nH
         qgVT4D8lYYrgosLusEdUk6v9fL81IeduQoDY1CoEHY7D6fZ1FTpu9HfIbpxV9/ZgBpjb
         lhCOVJRxYZXXqUPheviOgPqcc0ccJ7ZE+SCJKJc9myn5grFAs5xj6zbeWKyRGyMjbouQ
         FlOSd3pY+1imiSyJ1udW76G4nfJkk9sYWezx9f2BI+FYnk36Etq0x095sJRpXZCAhe9E
         wTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LTJYmIxK7HXmivC0K3EGms7i6vie+YSU0ogRPhLAOWY=;
        b=LA1YIVwsiGtkxg4j8M1vkg+/L7BfT0TSfP8FRS42K2nxNAKOem2YdLiyNTNT+oQkV9
         DPNH003oceTl5QG+wdDmqU6a2Q/qlsNeSJCTBZP33t/71yvMnBaGWhrgZD78aLuaL47K
         75QZ5CPmU1dWHCGky4V49K1PTRzDbu1yGtKFzlJ70pXmm8cqYsZeEDFwNtctMcjXwqVk
         C5YgIuAOe8xsoVLytOnIm5K8lKqCQyYVlmpCSAJgFI3WfeydtGW3jLHckzmJEjxpVNJi
         EMVgdkc3p75+idje7KnHjNVvMzEZfVWgA9UiYKZQWLm9YnQgpj0sBkOHbQ3HkJ/huBMG
         7BOw==
X-Gm-Message-State: AFqh2kpaiJoKw9cmQ336oX+cdyeBV+kzaBN2/YTIHNETJSF7IEt6GETv
        XwpvpeNx1Cl+1WU08qTXgK7lp3GU+uGCmyW/ShCCGQ==
X-Google-Smtp-Source: AMrXdXuT2tWUr2Hd/aaxX3TJlatyg89hpnEY3Qn0fpRBzhAdGcwVITlGCP7wKe7gcAbYlKYD+1hcbSYSMwXYBplkZ8k=
X-Received: by 2002:a25:1388:0:b0:7b8:6d00:ef23 with SMTP id
 130-20020a251388000000b007b86d00ef23mr2129455ybt.119.1673456692551; Wed, 11
 Jan 2023 09:04:52 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-9-surenb@google.com>
 <20230111001331.cxdeh52vvta6ok2p@offworld> <CAJuCfpEv--awCY0=R3h5Fez8x74U1EZCzNkq4_7deCYqej5sSA@mail.gmail.com>
 <Y75x5fGPcJ63pBIp@dhcp22.suse.cz> <Y76HTfIeEt8ZOIH3@gmail.com>
 <6be809f5554a4faaa22c287ba4224bd0@AcuMS.aculab.com> <CAJuCfpH_VZq99=vGQGJ+evVg5wMPKGsjyawgHnOeoKhtEiAi6w@mail.gmail.com>
 <Y77ndimzUsVZwjTk@dhcp22.suse.cz>
In-Reply-To: <Y77ndimzUsVZwjTk@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 11 Jan 2023 09:04:41 -0800
Message-ID: <CAJuCfpEEiFNAgb6TNwibUyTJ1J3b-rEGCSw63TiK6FSA=HCdtw@mail.gmail.com>
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

On Wed, Jan 11, 2023 at 8:44 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 11-01-23 08:28:49, Suren Baghdasaryan wrote:
> [...]
> > Anyhow. Sounds like the overhead of the current design is small enough
> > to remove CONFIG_PER_VMA_LOCK and let it depend only on architecture
> > support?
>
> Yes. Further optimizations can be done on top. Let's not over optimize
> at this stage.

Sure, I won't optimize any further.
Just to expand on your question. Original design would be problematic
for embedded systems like Android. It notoriously has a high number of
VMAs due to anonymous VMAs being named, which prevents them from
merging. 2M per process increase would raise questions, therefore I
felt the need for optimizing the memory overhead which is done in the
last patch.
Thanks for the feedback!

> --
> Michal Hocko
> SUSE Labs
