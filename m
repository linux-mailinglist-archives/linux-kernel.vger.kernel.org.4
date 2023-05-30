Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8574A7171CD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjE3XiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbjE3XiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:38:07 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AA41B5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:37:34 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-6262d8688baso19335576d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685489854; x=1688081854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJG7CFmU6ijgEhwk6Fs6w7FgoWmS/bd3i8qFFzECSuk=;
        b=KmyAG7iiS/sPb+Ie/zdxlzgP0zLWCHM/9BWrq4g/5N3h+aFnggcCKhCK7stsEdyiOb
         wNziz8TmiQ5Z3ZpkPZ7V/Ru+5vYLDumHAKOnP47FNs/DmZJuTUAaKHpwVRtsD8Qji+MI
         hLQt9kd3ToJ42207KboEfO8t0BHiL4soyqUp/UGdHIPmn4wq/fa4qhUF0Q1KB3pIRVuI
         GhpqUu73+9TMBvRz8q85HUpUo7d6joRG+dtvmKXBYIqebcd9jKH5Gicy6WwPgoYt72BA
         NGUOLJEYJZBNwLFHHWkiLoTN/JF8eXSXxQJ2tSDdwOc8HGPJd7PtmL0dgJ4KOe98UEwC
         a+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685489854; x=1688081854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJG7CFmU6ijgEhwk6Fs6w7FgoWmS/bd3i8qFFzECSuk=;
        b=CwdomtvbHl5+Oq5yJf4u8/SB0zh/9E1ssg/fL/e+61KMQlsN6nRZkpkSbTxTDuaGzy
         vkWdgVAvLBKvQli7G5rYV5bXvn6JmQ+zyNenB5ONFb7+fZOleMbUao9c3bSXMoHTz1nf
         rsFr8YkzgVSGXMrCB9qEHVX7sOZHv/bGoaqAR7UsBN2s6122JH9EK/0JblstJVC3VCzK
         Fd5aIyCL6RI5VN2Zzad74U71jNYgsqPvSnrRa9rJ9Stzejty/GxIHCreouuU7melCGba
         7OjG1znWUa957O/2PC0+js4AgE1Zkov3kQdlXyCgv1/X9Yl6SCAIF0EjuKtocdCa/vrd
         neJg==
X-Gm-Message-State: AC+VfDwKKiTUclbBpa9y25AvIHHCgR2qnfLmpF0cTtM2S9LfXOG8nmgp
        U1To7LJIbb8fViJjhMZbk+bnf8ZiVfFWQxCSWoE=
X-Google-Smtp-Source: ACHHUZ7AZwCt6L/qLX6XFqG0u91Bbc1QEr+KpwC2YzN5m/25f3nw21WwziJspmFZfhxjbFXdYfWGj8mbkxoS0eyWkFo=
X-Received: by 2002:a05:6214:1d0b:b0:5f7:8b31:4548 with SMTP id
 e11-20020a0562141d0b00b005f78b314548mr4679600qvd.4.1685489853907; Tue, 30 May
 2023 16:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAKEwX=PrqV+cCGmdTcFPMqP-48Y=abQTkSOUzJnOWWpc4rR4cA@mail.gmail.com>
 <20230530222440.2777700-1-nphamcs@gmail.com> <20230530153006.8b73c276b1aaf5c3275f0b3f@linux-foundation.org>
In-Reply-To: <20230530153006.8b73c276b1aaf5c3275f0b3f@linux-foundation.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 30 May 2023 16:37:23 -0700
Message-ID: <CAKEwX=OBtWfcYJkCTM0QE-P+u-AvzkSe+C9QqmLxdDMxSS_45Q@mail.gmail.com>
Subject: Re: [PATCH] zswap: do not shrink if cgroup may not zswap
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        yosryahmed@google.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 3:30=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 30 May 2023 15:24:40 -0700 Nhat Pham <nphamcs@gmail.com> wrote:
>
> > Before storing a page, zswap first checks if the number of stored pages
> > exceeds the limit specified by memory.zswap.max, for each cgroup in the
> > hierarchy. If this limit is reached or exceeded, then zswap shrinking i=
s
> > triggered and short-circuits the store attempt.
> >
> > However, since the zswap's LRU is not memcg-aware, this can create the
> > following pathological behavior: the cgroup whose zswap limit is
> > reached will evict pages from other cgroups continually, without
> > lowering its own zswap usage. This means the shrinking will continue
> > until the need for swap ceases or the pool becomes empty.
> >
> > As a result of this, we observe a disproportionate amount of zswap
> > writeback and a perpetually small zswap pool in our experiments, even
> > though the pool limit is never hit.
>
> That sounds unpleasant.  Do you think the patch should be backported
> into earlier (-stable) kernels?

I think it should be, for any kernel version after f4840ccfca25.



>
> > This patch fixes the issue by rejecting zswap store attempt without
> > shrinking the pool when obj_cgroup_may_zswap() returns false.
>
