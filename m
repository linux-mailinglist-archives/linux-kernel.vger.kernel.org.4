Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A07E7344FC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 07:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjFRFcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 01:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRFcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 01:32:18 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34437138
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 22:32:17 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51a2de3385fso3162205a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 22:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687066335; x=1689658335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYF7MqfL1LQ519SUxcIV2IsneWCMHgafBOLyZGglDQM=;
        b=7G5u61y1dh4osVbgspbrudZ3Sm6LpM9rHB0MWR/O2KN056XLOBcM0TEdCNUd/pdDod
         CldzzNB/USibkLL0iwRpIIHdBc4rnYhzLqIh6p/1RdM+Il9kUbgb7SR+yFqBZPOmNnUQ
         8d7SYwdJQDJ4kONJbdgYroyeqXxcpIuarxNrZWS7RwiWRefz9IMZ+6+6uRcQ3HscgXQ9
         e1pxN0V3xphEvO1/B7w4qKTjuFstRixriscoe6e5lT7RaqwKnxlkv24H7mj9sxqkE9dx
         3GPcxBD8a4jryiipynriyB14CgEf/5M3sux6JSNDKcs3aLr/LQRicQC5B3kGXZiA+U+v
         krcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687066335; x=1689658335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYF7MqfL1LQ519SUxcIV2IsneWCMHgafBOLyZGglDQM=;
        b=LLHJwbt3jgK7OOKDpnk+3OnOatRkJDSZh6x55y3vhjQeinnpMiJNPs43aJFqw02RJM
         DJ8mY4JJNhfLgAZHYRJLvZvHDJzkAXw/UIMUty1DVgcCRiHQmidRauJFSopHE3Ao3bIM
         GlEsZAaqNzgtaSlvda8HR4ohhiuhQ8pTqcMtRKzY4EwZLHiBgVTkbHV0c+Z4JTcbnXN1
         GpOfkyet5M3j2MJKMvKZHc3xM6H5z1tSNd8qGqrLGspyfGnnaU7G+xcFdpWYtvcAooy7
         gDw9zW3orw/bG9k8SZ2VxBycLu1/ht05Ok49cPxGm8pNC/okh7moWLg9FXaq6Xxjq+BN
         0UIw==
X-Gm-Message-State: AC+VfDw3Ku046/MSrskFnZLvts7IqtRidK2WD/UJi8+snH2pILD71E4h
        xk8QwNZx9n+cjyLvrdhSlnLBWbk3DfHrv1IGwJsYrA==
X-Google-Smtp-Source: ACHHUZ6OQJIViZZ8V4gsjjoublU6HPZ6gGLMx1X6HESgEFa/9Kh0/xzNUyOLTWbv2cXYGAwfSXVo+eHjfZZf1HlAna8=
X-Received: by 2002:a17:907:d0c:b0:96f:4225:9009 with SMTP id
 gn12-20020a1709070d0c00b0096f42259009mr7836082ejc.0.1687066335549; Sat, 17
 Jun 2023 22:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230612093815.133504-1-cerasuolodomenico@gmail.com>
 <20230612093815.133504-2-cerasuolodomenico@gmail.com> <20230618043857.GA2417524@google.com>
 <CAJD7tkbRn2txAt94keKTRbAA7--XF3rXSa8vsh9eGZa2CUWP8w@mail.gmail.com>
 <20230618052526.GB2417524@google.com> <CAJD7tkbcf+MEMJdGeruB7XL=J8tJNgkB7_1UQ2S4VEKjob-NQw@mail.gmail.com>
 <20230618053048.GC2417524@google.com>
In-Reply-To: <20230618053048.GC2417524@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Sat, 17 Jun 2023 22:31:39 -0700
Message-ID: <CAJD7tkZZSgHMFVWw3cnLjvCzw56BL6NW5FCzQ2dKh_sO9yoeiw@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] mm: zswap: add pool shrinking mechanism
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        vitaly.wool@konsulko.com, minchan@kernel.org, linux-mm@kvack.org,
        ddstreet@ieee.org, sjenning@redhat.com, nphamcs@gmail.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 10:30=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (23/06/17 22:28), Yosry Ahmed wrote:
> > > On (23/06/17 21:48), Yosry Ahmed wrote:
> > > > > On (23/06/12 11:38), Domenico Cerasuolo wrote:
> > > > > > +static int zswap_reclaim_entry(struct zswap_pool *pool)
> > > > > > +{
> > > > > > +     struct zswap_header *zhdr;
> > > > > > +     struct zswap_entry *entry;
> > > > > > +     struct zswap_tree *tree;
> > > > > > +     pgoff_t swpoffset;
> > > > > > +     int ret;
> > > > > > +
> > > > > > +     /* Get an entry off the LRU */
> > > > > > +     spin_lock(&pool->lru_lock);
> > > > > > +     if (list_empty(&pool->lru)) {
> > > > > > +             spin_unlock(&pool->lru_lock);
> > > > > > +             return -EINVAL;
> > > > > > +     }
> > > > > > +     entry =3D list_last_entry(&pool->lru, struct zswap_entry,=
 lru);
> > > > > > +     list_del_init(&entry->lru);
> > > > >
> > > > > A quick question: should we zswap_entry_get() here?
> > > >
> > > > We need to hold the tree lock for that, and the lock ordering is tr=
ee
> > > > lock -> lru lock. If we try to grab the tree lock here we may
> > > > deadlock.
> > >
> > > We can deadlock doing this?
> > >
> > >         lock tree_lock
> > >         lock lru_lock
> > >         list_del_init
> > >         unlock lru_lock
> > >         entry_get
> > >         unlock tree_lock
> > >         writeback
> >
> > We don't know which tree the zswap entry belongs to
>
> Oh... I must be blind. You are right. Sorry for the noise.

Don't blame yourself, it is fairly convoluted :)
