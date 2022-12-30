Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE51659C98
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 22:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbiL3V7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 16:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiL3V7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 16:59:46 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322611CFE1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 13:59:45 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id d185so22509733vsd.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 13:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ojCvjpUwmQcpqlhAqAXahIQg5LmJzJtnHdnov88yJMs=;
        b=ZlXVJI2uLZhNL3WGmXGzQbeJ+Y9BZcsePf40pR3SW0CbR6qoB+Ce9wZvSMjvacx3TK
         VR5gqxU9e5BtU360p9T8tGR3aNMt1abiiG2Jos2ghZFmXEx9eNiH0NPr7FFwacW5i3f8
         xhBbOGNegv3yvGegSG6BZ3za7+mvKWD4+06557JEYa7qjgszntkNt+84dhY/IVM6mvU2
         r40JZJrBvzdHysFXwtHNOfp6D6MKTqhP9bdDEegX21uONIX6QXjLNSuMXlchC/xHRCkK
         6EgsbOyze+/xSUh7Wz7F+op/f7aIKl09JEg1qD5+llHkHvYUHWTQYEJe/OjXIbaQ1ynR
         sjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojCvjpUwmQcpqlhAqAXahIQg5LmJzJtnHdnov88yJMs=;
        b=OXe9D5qicTrMh2US4+UAmi5r/zcWUQWHP1Rwk5BQmjWeMm/BsfIUwxSpzUHlNaU0cK
         uBQxZ6Gq4sKF/+6XmrEz8uAS+2fgKkd9HWi7iKhnDPT0BBakIo02Y2Er1qS0qOyeOEYz
         HcE5/G/VJm5IBnRPjAOS9RphroBQ6IS3Gfz67AkJI+8QNP2kmT9j5ltnhIblApIGgARt
         owrYFUzUplBJkaSl37HZ1q16tmVVQJ54mLZ4p9+M6YBSCfkT4dL++K8y62fCSlJSAI4e
         hBHzzO4ywNnSx+3aHzlfD4PNn8OgOdACIql2YoyrT7ztjd2ZJDJR7yqygWQLbq2GD/hR
         II/g==
X-Gm-Message-State: AFqh2kpto/rH9Q6Yzv362P+3leUIqp35ecocf+TjtxqfUej617kGlsp0
        oc5qsjytxDK8SnlasBYMQb37h1QxMw6OsYnAjJ4zAw==
X-Google-Smtp-Source: AMrXdXsMbDKNYMIrLNNEHL37FFgKk2+piZDk5e8JDw1OEPqIetTy7RlBmJ1yAcxxST6OWGS2se4bKXJHEFqLA2nsLdU=
X-Received: by 2002:a05:6102:3d9f:b0:3c4:4918:80c with SMTP id
 h31-20020a0561023d9f00b003c44918080cmr2914595vsv.9.1672437584212; Fri, 30 Dec
 2022 13:59:44 -0800 (PST)
MIME-Version: 1.0
References: <20221222061341.381903-1-yuanchu@google.com> <20221222104937.795d2a134ac59c8244d9912c@linux-foundation.org>
 <CAOUHufZpbfTCeqteEZt5k-kFZh3-++Gm0Wnc0-O=RFT-K9kzkw@mail.gmail.com> <20221222122937.06b9e9f3765e287b91b14954@linux-foundation.org>
In-Reply-To: <20221222122937.06b9e9f3765e287b91b14954@linux-foundation.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 30 Dec 2022 14:59:08 -0700
Message-ID: <CAOUHufYYoJJmDE3Y0r8p_BqGG5Cgig=Ntuz9ThEnfvkxqL_ZLw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: add vma_has_locality()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yuanchu Xie <yuanchu@google.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Steven Barrett <steven@liquorix.net>,
        Brian Geffon <bgeffon@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Peter Xu <peterx@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
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

On Thu, Dec 22, 2022 at 1:29 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 22 Dec 2022 12:44:35 -0700 Yu Zhao <yuzhao@google.com> wrote:
>
> > On Thu, Dec 22, 2022 at 11:49 AM Andrew Morton
> > <akpm@linux-foundation.org> wrote:
> > >
> > > On Wed, 21 Dec 2022 22:13:40 -0800 Yuanchu Xie <yuanchu@google.com> wrote:
> > >
> > > > From: Yu Zhao <yuzhao@google.com>
> >
> > This works; suggested-by probably works even better, since I didn't do
> > the follow-up work.
> >
> > > > Currently in vm_flags in vm_area_struct, both VM_SEQ_READ and
> > > > VM_RAND_READ indicate a lack of locality in accesses to the vma. Some
> > > > places that check for locality are missing one of them. We add
> > > > vma_has_locality to replace the existing locality checks for clarity.
> > >
> > > I'm all confused.  Surely VM_SEQ_READ implies locality and VM_RAND_READ
> > > indicates no-locality?
> >
> > Spatially, yes. But we focus more on the temporal criteria here, i.e.,
> > the reuse of an area within a relatively small duration. Both the
> > active/inactive LRU and MGLRU rely on this.
>
> Oh.  Why didn't it say that ;)
>
> How about s/locality/recency/g?

Thanks. I've done this, and posted the v2 which includes much better
commit messages.
