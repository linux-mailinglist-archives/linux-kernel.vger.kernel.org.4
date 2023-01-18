Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE7B672AD5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjARVsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjARVs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:48:26 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39715D7C2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:48:25 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-4a263c4ddbaso940517b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uzT4Y+nMi8LDe2iEcfC4M3fZx7ZCs1usjL+yZe3S9Zg=;
        b=RhZ9zpDQ2tbO3UOHyEZ6OxL8Q7pdjhMsOsRzcBfXmJ1imO6bs0aWmPetPNnitsYH+4
         yQWRmYHt2rKWbnkEeTpp25/fOxiz+AGY7oBG31Xmes7A5Qp0wmVarh3YODCj2ag0d8fg
         tgiL3bgnzTnuW3HtHK2HGsWiA6sXHkspotz9jEzegBpQjXvCzUYviYMY7Btlwb64jgpZ
         1CfmWkYqIsrPfulP9bqiXjA9LRrqDcL4EL8jfUvE4QVAIsAUVHfRqoUyDl7UgAYSUQZr
         VHSCaH4Nwq0dwyL5OOw0Y1tLnRNlqc0xAhHDD3tgXrprsFOPPJspfcHjrNSfyj05EOod
         zvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uzT4Y+nMi8LDe2iEcfC4M3fZx7ZCs1usjL+yZe3S9Zg=;
        b=V71glxTtNhBdFR4wtZ9UWU2qS/aws3ZSColpUJWqeyMFz8MXycs92Bd0zLK7ecWqSQ
         AdsoeXTp/X3D2uO1p+qVEaNpMkec7/7jhtcsUr1/RKK53EstJHpcz+QmqcyINqHy1AaZ
         Wh9MMN9fQcGN/k7aplf1w648Cbf6NhoSyiJ/wq0fQAKZTgjKNHFS1z9GtqCsS0DEq4jm
         nHyxXccTbyqaQlKOd+AJ9dABO4/PH/XVB9WpiV7QG2F7v8fCZ0KZVlQhT9s4MEZ77RIw
         x6AA+zWpvlJZR8uozBHgU4PhzUiV/JaYro1dfmkC/colaKyz1mXQLuTjMfv7xPm5dJd/
         bW/g==
X-Gm-Message-State: AFqh2kr5FwLwU21hpN/Dk/HycBOJUu3rviaIK/JAb46tqO4sTY2T9tWn
        Tr+jTZHlIUe/qvYF/BLov5SHmJ/b9PPWfsZgY85/5A==
X-Google-Smtp-Source: AMrXdXvjDsaTscQe0ZYEXddn6BYHX+/MM+QlKzksu62WfW6oaplhyuT1n5g7GuUEaFRAGRMX9y3muPFlrpfKM7HD/Po=
X-Received: by 2002:a81:6d8d:0:b0:490:89c3:21b0 with SMTP id
 i135-20020a816d8d000000b0049089c321b0mr1111410ywc.132.1674078504732; Wed, 18
 Jan 2023 13:48:24 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-18-surenb@google.com>
 <Y8a734ufLZjPHgtT@dhcp22.suse.cz> <CAJuCfpGoYaF2-z7FCiN4X8gEGD6nAwnQC+=n3tUHuMWZa7zx8Q@mail.gmail.com>
 <Y8e6lm76fIoT0603@dhcp22.suse.cz> <CAJuCfpHtV5xEo97X62uR=LXjK6wQMJXhhV2OxXexTfyudGOptw@mail.gmail.com>
 <Y8hls4MH353ZnlQu@dhcp22.suse.cz>
In-Reply-To: <Y8hls4MH353ZnlQu@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 18 Jan 2023 13:48:13 -0800
Message-ID: <CAJuCfpF3j5Sx+D5p5QPCHP4jcWZUiYm=FfUNYhc6QyHZQvDgpw@mail.gmail.com>
Subject: Re: [PATCH 17/41] mm/mmap: move VMA locking before
 anon_vma_lock_write call
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
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

On Wed, Jan 18, 2023 at 1:33 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 18-01-23 10:09:29, Suren Baghdasaryan wrote:
> > On Wed, Jan 18, 2023 at 1:23 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Tue 17-01-23 18:01:01, Suren Baghdasaryan wrote:
> > > > On Tue, Jan 17, 2023 at 7:16 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Mon 09-01-23 12:53:12, Suren Baghdasaryan wrote:
> > > > > > Move VMA flag modification (which now implies VMA locking) before
> > > > > > anon_vma_lock_write to match the locking order of page fault handler.
> > > > >
> > > > > Does this changelog assumes per vma locking in the #PF?
> > > >
> > > > Hmm, you are right. Page fault handlers do not use per-vma locks yet
> > > > but the changelog already talks about that. Maybe I should change it
> > > > to simply:
> > > > ```
> > > > Move VMA flag modification (which now implies VMA locking) before
> > > > vma_adjust_trans_huge() to ensure the modifications are done after VMA
> > > > has been locked.
> > >
> > > Because ....
> >
> > because vma_adjust_trans_huge() modifies the VMA and such
> > modifications should be done under VMA write-lock protection.
>
> So it will become:
> Move VMA flag modification (which now implies VMA locking) before
> vma_adjust_trans_huge() to ensure the modifications are done after VMA
> has been locked. Because vma_adjust_trans_huge() modifies the VMA and such
> modifications should be done under VMA write-lock protection.
>
> which is effectivelly saying
> vma_adjust_trans_huge() modifies the VMA and such modifications should
> be done under VMA write-lock protection so move VMA flag modifications
> before so all of them are covered by the same write protection.
>
> right?

Yes, and the wording in the latter version is simpler to understand
IMO, so I would like to adopt it. Do you agree?

> --
> Michal Hocko
> SUSE Labs
