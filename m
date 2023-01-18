Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5408E67265E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 19:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjARSK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 13:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjARSJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:09:55 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA3D5926D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:09:41 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-4e4a6af2d99so160514787b3.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 10:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N/4EcSnYgCt7dm1vNWuzZoT1Acf95uMzMIRPStS3MFc=;
        b=RdMZLq/QQKbxmGqQjXr2SeQws/2SpJNVIc1YXEDJY02ia+icN35A9Qz9jYm2yUdvEd
         Xr+WWARyr0zV20f7yWYlcOhGvzWd8O8v81a9FJglG8qskf5nz0R7uGPjkiKhwo2NA/0H
         W2V5YnwNjP9h+XiZgS9gFvIcACLINv66ZmymmN6T0zNrurs7rcDth7z1bX/qCvlkRrTg
         cqrOYqdgFn4Ze7NJzTVZt7+ZIh80R64qt1dfA87Xrn1ABHiwTzck+/URo7+EwgLdO6vg
         /jhlLK73LBaFi/fbg7bG9ean2FWK1dwMJBf962UEC2hTydBhcydgnQY6B2wgHquKYb0d
         IBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/4EcSnYgCt7dm1vNWuzZoT1Acf95uMzMIRPStS3MFc=;
        b=uBXOwD5iPquBRzONihPaB+kjYvJI2MYlxlmTkE/AU2DCw3MvhIUysN+ZGuEZKLYnAf
         tdHLI7t9rugHtdHUTaIfOlY0c1jE5blJp2cREi4FRZ+BOmLkl1kTZf1t7ZdUsw7s/6RX
         QqovhWTH3MNXICn8qXVsVTBvIB2cF4790S2b3dCh/0zJB3m/+OG7UM6JrdkXuoH1O++W
         TE4O3Fnh1jvvWOHCMarDlnyTKNUR7dkHTKrZdbMr0BcFthf5QBjl3Se276bg5t8XJtlh
         yDG8clrVX7ZPT9ZIoXP7/IbjQ2kZmDezkojgFDrS8CVwe4xA/pHXDw4D/JnTUT1JMT2Z
         7TwQ==
X-Gm-Message-State: AFqh2kp5uRYuAtz3Fjwm5htZypXDbkAXd1xAnLDVH1dEIgIF/SX3lisC
        cGyIaXwsI5mBQx0ljcD2bfYOgq7hh48L0VlJFTVABQ==
X-Google-Smtp-Source: AMrXdXuWCJrbgxuKUwMr0EieyUKi+tebQWoa61PUevsrL055U9RwXQHwmG3dI3jim2t9TghOc/KsUXPKuAsyvHfLBDM=
X-Received: by 2002:a81:9105:0:b0:3dc:fd91:ef89 with SMTP id
 i5-20020a819105000000b003dcfd91ef89mr872169ywg.347.1674065380386; Wed, 18 Jan
 2023 10:09:40 -0800 (PST)
MIME-Version: 1.0
References: <20230109205336.3665937-1-surenb@google.com> <20230109205336.3665937-18-surenb@google.com>
 <Y8a734ufLZjPHgtT@dhcp22.suse.cz> <CAJuCfpGoYaF2-z7FCiN4X8gEGD6nAwnQC+=n3tUHuMWZa7zx8Q@mail.gmail.com>
 <Y8e6lm76fIoT0603@dhcp22.suse.cz>
In-Reply-To: <Y8e6lm76fIoT0603@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 18 Jan 2023 10:09:29 -0800
Message-ID: <CAJuCfpHtV5xEo97X62uR=LXjK6wQMJXhhV2OxXexTfyudGOptw@mail.gmail.com>
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

On Wed, Jan 18, 2023 at 1:23 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 17-01-23 18:01:01, Suren Baghdasaryan wrote:
> > On Tue, Jan 17, 2023 at 7:16 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 09-01-23 12:53:12, Suren Baghdasaryan wrote:
> > > > Move VMA flag modification (which now implies VMA locking) before
> > > > anon_vma_lock_write to match the locking order of page fault handler.
> > >
> > > Does this changelog assumes per vma locking in the #PF?
> >
> > Hmm, you are right. Page fault handlers do not use per-vma locks yet
> > but the changelog already talks about that. Maybe I should change it
> > to simply:
> > ```
> > Move VMA flag modification (which now implies VMA locking) before
> > vma_adjust_trans_huge() to ensure the modifications are done after VMA
> > has been locked.
>
> Because ....

because vma_adjust_trans_huge() modifies the VMA and such
modifications should be done under VMA write-lock protection.

>
> Withtout that additional reasonaning it is not really clear why that is
> needed and seems arbitrary.

Would the above be a good reasoning?

>
> --
> Michal Hocko
> SUSE Labs
