Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7394460C9FA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbiJYK0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiJYKZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:25:18 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E8B18811C;
        Tue, 25 Oct 2022 03:22:58 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bu30so20011222wrb.8;
        Tue, 25 Oct 2022 03:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0y7iDQCensAtux3dcwN/gwY7QUae/GZDIlFm3Ei8Y2A=;
        b=gb01ow7fMtdcOsSJMFf9yQwB6aEFE1KHQuLXR4On+crZ/Tnwk6TxtFOtbAwtEuccmS
         NRR6lVnd6dPIHWBC6GU+1J64OO4PijHPGb1jULxScHraNbhMjsxvpM7YVB7zf3jgCnpN
         hz6VeoQY6Uz9AzSCXhNRZ1zoUKbAKAK7Iwieh0vWJhwiinEiFMZB3pxkRJjtjHkauFer
         fF3SReeIXGhF7y9+axeIvKsEVrFVx2Ojp5JNHQWPAJLCqGK9hrB73YzeLb3J8d+ih5Uw
         N7RRvmLFd3kjascKk080k8/bUjmQliXyeG63zH0t5ijr3mEzUYjQerQRzo3hMa8KGsH6
         8mQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0y7iDQCensAtux3dcwN/gwY7QUae/GZDIlFm3Ei8Y2A=;
        b=ruPA9MDms9qOnSM1JfdaJftiqYlPTxKsWi9/xThD/zCR9QOJ5Euzhy65gQugIBdiOF
         JWj3rcRVXdlWmpdFKZ0yT9/JaiW8yMClhY8W4XV/kNmiES3qLVDhBR+S1vcAJ1XJi/bg
         A687E4amaJXhPpTF4IeG1MowO7eL1aF3Gnje/nK6pu1ACOyE25w81IIgtrQEm1ftSJ4U
         8cJ/qG11nvHxj1cU2ibv9g7dg7inrCk7SOkf3ec6cX9OYguRlZFrg6hct+pBP0HG7Lih
         Zsa9QvWP0SJpApBLYeH0APlQ8Oisa0sGs359fpwKrtMLUwumN8IZ9SxsertWQpwiMgq1
         n5rQ==
X-Gm-Message-State: ACrzQf36iWtb9Rh+DPGi6pe4Ph1FWJQGdvFWYalXNM41m8DX3vjWCEYk
        osjgbn2HFLr/DE8zoHgykTDaN/0rgwpNLQVEJzA=
X-Google-Smtp-Source: AMsMyM6qWwwHEiDFs/RyxbmrHvG4DfXAV4EqSzWHktBtr9+zi38/uUyCJD98wpW3g7aV0Ck3czdOKlfDMNWoyOu4MyY=
X-Received: by 2002:a05:6000:22f:b0:236:4f8e:a913 with SMTP id
 l15-20020a056000022f00b002364f8ea913mr15877728wrz.240.1666693376743; Tue, 25
 Oct 2022 03:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220811161331.37055-1-peterx@redhat.com> <20220811161331.37055-5-peterx@redhat.com>
 <20221021160603.GA23307@u164.east.ru> <Y1Wbi4yyVvDtg4zN@x1n>
In-Reply-To: <Y1Wbi4yyVvDtg4zN@x1n>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Tue, 25 Oct 2022 13:22:45 +0300
Message-ID: <CADxRZqy+cMHN4FjtDr7-LOyVf0y+G8MPiBoGiTEsSj48jBfVnw@mail.gmail.com>
Subject: Re: dpkg fails on sparc64 (was: [PATCH v4 4/7] mm/thp: Carry over
 dirty bit when thp splits on pmd)
To:     Peter Xu <peterx@redhat.com>
Cc:     David Miller <davem@davemloft.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Alistair Popple <apopple@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 10:53 PM Peter Xu <peterx@redhat.com> wrote:
> On Fri, Oct 21, 2022 at 07:06:03PM +0300, Anatoly Pugachev wrote:
> >
> >     Link: https://lkml.kernel.org/r/20220811161331.37055-5-peterx@redha=
t.com
> >
> > So, v6.0-rc3-176-g0d206b5d2e0d) does not segfault dpkg,
> > v6.0-rc3-177-g0ccf7f168e17 segfaults it on package install.
> >
> > dpkg test was (apt) install/remove some packages, segfaults only on ins=
tall
> > (not remove).
> >
> > Reverted 0ccf7f168e17bb7eb5a322397ba5a841f4fbaccb from top of v6.1-rc1 =
and
> > tried to compile kernel, but got error
> >
> > mm/huge_memory.c: In function =E2=80=98__split_huge_pmd_locked=E2=80=99=
:
> > mm/huge_memory.c:2129:17: error: =E2=80=98dirty=E2=80=99 undeclared (fi=
rst use in this function)
> >  2129 |                 dirty =3D is_migration_entry_dirty(entry);
> >       |                 ^~~~~
> > mm/huge_memory.c:2129:17: note: each undeclared identifier is reported =
only once for each function it appears in
> > make[2]: *** [scripts/Makefile.build:250: mm/huge_memory.o] Error 1
> >
> > So can't test v6.1-rc1 with patch reverted...
>
> Sorry to know this, and thanks for the report and debugging.  The revert
> won't work because dirty variable is used in later patch for the swap pat=
h
> too.  I've attached a partial (and minimum) revert, feel free to try.

Peter,

tested again with 6.1.0-rc2 already, non patched kernel segfaulting
dpkg, using your patch makes dpkg
(or kernel) to behave properly.
Thanks!

> I had a feeling that it's somehow related to the special impl of sparc64
> pte_mkdirty() where a kernel patching mechanism is used to share code
> between sun4[uv].  I'd assume your machine is sun4v?  As that's the one
> that needs the patching, iiuc.

kernel boot log reports
ARCH: SUN4V
