Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F77613A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbiJaPnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiJaPnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:43:43 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F3110FED
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:43:42 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y13so11003755pfp.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tUXpWC1H7P0Jns6tHF58gKyo4qTrk4UrpN1+5tdF18=;
        b=cv1mx2nJdWzm9o2OtXlRHPxnB0CspofcOk6YtVCzD1O8YQxZk2Eil3lQyAj0B3zY6D
         PZ+8w4oCpZMIRfyKiPSJVqeTc5BTuOxPzKEuoCwbXemkHBhXU5d4Ootfw0RvPBak9Bel
         BDW6NUcC6nJc0CQhbr+u2WfVGqo2h/ttJlkCnQO3gkuY/GWnZrtwCBhe5fLnbqyujT+t
         awU1AlLcu00lfXZNRWTw1A0G4VwrmzTE0zvOSCjNRMqMnxJvFIMy3SudGy3gNLiKX0bv
         YJX82S079L2yXFtKNpwgg8w8HNcq9Vg0sTBHWuE3BQhYJ0EqpTNWx5fiDNY2BSiIrKoQ
         0uQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5tUXpWC1H7P0Jns6tHF58gKyo4qTrk4UrpN1+5tdF18=;
        b=LeMoUvRQTvvBfx4P3VDXm8wwjjK0NkWPj3txn1KbUEYBrpHzhRdWQlXFKPUTc2oJVR
         vel6z8K6n8khJfjobJ/pt2eAGE1CuVvIKIfJjhO9eolASLUZhehAdxqxts9oOb2TxibW
         lRMNmWk9w3O9LvYODKRLWYx5jiZanDFKGeAri53TMt5HioXVRghRZcgeYxASMF7w6aGg
         dN9CQqk/F5D+l1aKIzxHAnlgqOCzYW4zOGBJ4AH5R53JDAQx3F9vP/au7xD0jwRetUHw
         Uwf4Q3ue8VmzcIauTYFv6PP1fSA0ugpsf+RHGc+e5vlWPrBGJgS9KLaC3VA1LMNUP4zI
         Lvbg==
X-Gm-Message-State: ACrzQf18mNIFYw7FEH3zhInJRxFt90GlqNK7jt1uZDldLzMeJbBBT2oi
        ThNCgY1o3AgU+mYArOYS4jPG7ApesvW1TRXBPw8=
X-Google-Smtp-Source: AMsMyM7LqDY9bi2DWvg4h01dPwTkDsm6fOPR3gR58jN/HTZlEu2YwniA3Zv19zGfcT2E8eNdOOqTqQ==
X-Received: by 2002:a63:e511:0:b0:46f:98cf:13d3 with SMTP id r17-20020a63e511000000b0046f98cf13d3mr9385789pgh.363.1667231021972;
        Mon, 31 Oct 2022 08:43:41 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id 4-20020a621404000000b0056c704abca7sm4754063pfu.220.2022.10.31.08.43.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Oct 2022 08:43:41 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CAHk-=wjZnVURfhWMmWiDX3D0kuqnJ0PLM_Na-U7ufzqPMxucjw@mail.gmail.com>
Date:   Mon, 31 Oct 2022 08:43:37 -0700
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>, X86 ML <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        jroedel@suse.de, ubizjak@gmail.com,
        Alistair Popple <apopple@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0E3DDDE4-FD20-40ED-A418-222AAA546596@gmail.com>
References: <20221022111403.531902164@infradead.org>
 <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com>
 <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
 <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
 <Y1fsYwshJ93FT21r@hirez.programming.kicks-ass.net>
 <CAG48ez3VE+3dVdUMK+Pg_942gR+h_TCcSaFxGwCbNfh3W+mfOA@mail.gmail.com>
 <Y1f7YvKuwOl1XEwU@hirez.programming.kicks-ass.net>
 <CAG48ez05gBiB2w7bL_3O_OUoBWazmHnRwMiuni_wQyXBUcaxbQ@mail.gmail.com>
 <Y1oub9MvqwGBlHkq@hirez.programming.kicks-ass.net>
 <CAHk-=wihPdOtXgJ32pLB6Xd-UvnaZW9YvOOjM24JGYRjNHeykA@mail.gmail.com>
 <6C548A9A-3AF3-4EC1-B1E5-47A7FFBEB761@gmail.com>
 <CAHk-=wh8oi0qQtYDFTfm7d1s5C8mG7ig=NfzGWt4zbjXMzcdqQ@mail.gmail.com>
 <F9E42822-DA1D-4192-8410-3BAE42E9E4A9@gmail.com>
 <B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com>
 <CAHk-=wgzT1QsSCF-zN+eS06WGVTBg4sf=6oTMg95+AEq7QrSCQ@mail.gmail.com>
 <47678198-C502-47E1-B7C8-8A12352CDA95@gmail.com>
 <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
 <CAHk-=wijU_YHSZq5N7vYK+qHPX0aPkaePaGOyWk4aqMvvSXxJA@mail.gmail.com>
 <140B437E-B994-45B7-8DAC-E9B66885BEEF@gmail.com>
 <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
 <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com>
 <CAHk-=wgz0QQd6KaRYQ8viwkZBt4xDGuZTFiTB8ifg7E3F2FxHg@mail.gmail.com>
 <CAHk-=wiwt4LC-VmqvYrphraF0=yQV=CQimDCb0XhtXwk8oKCCA@mail.gmail.com>
 <A48A5CEB-2C02-4101-B315-6792D042C605@gmail.com>
 <CAHk-=wjZnVURfhWMmWiDX3D0kuqnJ0PLM_Na-U7ufzqPMxucjw@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 30, 2022, at 10:00 PM, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:

> So the current ordering rules are basically that we need to do
> set_page_dirty() *and* we need to flush the TLB's before dropping the
> page table lock. That's what gets us serialized with "mkclean=E2=80=9D.

I understand. I am still not sure whether ordering the set_page_dirty() =
and
dropping the mapcount reference cannot suffice for the reclaim logic not =
to
free the buffers if the page is dirtied.

According to the code, shrink_page_list() first checks for =
folio_mapped()
and then for folio_test_dirty() to check whether pageout() is necessary.
IIUC, the buffers are not dropped up to this point and set_page_dirty()
would always set the page-struct dirty bit.

IOW: In shrink_page_list(), when we decide on whether to pageout(), we
should see whether the page is dirty (give or take smp_rmb()).

But this is an optimization and I do not know all the cases in which =
buffers
might be dropped. My intuition says that they cannot be dropped while
mapcount !=3D 0, but I need to further explore it.

