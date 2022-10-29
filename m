Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E499C612557
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 22:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiJ2U4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 16:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ2U4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 16:56:36 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5493386D
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 13:56:34 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso7300472pjc.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 13:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7WlHZh5vviFw19hFMjNhkQcVi4vYscxdo+Dmp4kQDE=;
        b=a0r/sqmpVZKrQmdX/tjCjRpusi7X4kOzYq7aR4CZ51eLiEiSiOl1qLvb+b//Zcmiru
         tRRjAxontQrZy9OIspkF+EmV0RTLc+WpNIWdgRITir+0k+aWWnv1Ir7g9jmvZVkZDfUm
         4bcve7zgHvRfoi0BLKG+bnoRZXBP6l7QkGaCfaTvaV5AwjsNuOrV8YSS+pQNKqZKEhwu
         Kk9OITp6NxOx2MviVtiOt25GQqtBneF+1UMPd4R06mcQAnK2McGDvKD9rwZu9IN8m1Dh
         HqKHM9pZX7rodEl5h5SyurxHKKgwyzQ8+wISqy8kW2jsTsOpbAQY8sGLXnVogYpTG51B
         S7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7WlHZh5vviFw19hFMjNhkQcVi4vYscxdo+Dmp4kQDE=;
        b=TwBfdkCvie2E6zIQRXwwKHq/BW0vhlu32hnmTrW84SK8Hjlk4y/v/GqvarGeBMaNdG
         L1ctBw20bTZLj8Grlvrb29OZnaxIk+7KbtuurRasyR+1YCFbudZHRi233g+Aud/97f0O
         BqbbpsINUXe7d9lucAF6FUIHpPC3IFdaGmCOU2FyBAsN2r/BYh3ubRJ3BoNtXEqxsFFj
         fpE2s2zjRbmKfrr7yilsFA7IP6dCIaJEM+izOXAQQjGdIMF6ofeVsmLABsmr5XEe8r+z
         2ZYPETkBAQLf+b7GG5g8qxLDkyEmtCTZKWJpGMy/kpwmn1PiduIHD4IaXrRwTW9SSCtC
         ZG7Q==
X-Gm-Message-State: ACrzQf1QDf8EhrY153JQjCViZ4Plg3XJwQLAaXks7j1X+I80bPeweHJK
        1aZ+RIOKBA1hHar1clJYhPo=
X-Google-Smtp-Source: AMsMyM6Uw1CMB8fYcH0B611g3gtnZ8g9phs24PmmB+jsGfyCD0cxdmt6CgN71dyyn/45jCvnM+FeQw==
X-Received: by 2002:a17:902:eb8a:b0:186:949e:8eb6 with SMTP id q10-20020a170902eb8a00b00186949e8eb6mr6078475plg.63.1667076994274;
        Sat, 29 Oct 2022 13:56:34 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id q18-20020a63f952000000b00434760ee36asm1378342pgk.16.2022.10.29.13.56.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Oct 2022 13:56:33 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CAHk-=wj6EJvTtTeYQvkX3aOw6Q1SRYRV6xJP1+uHNvfAocO1hw@mail.gmail.com>
Date:   Sat, 29 Oct 2022 13:56:31 -0700
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>, X86 ML <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        jroedel@suse.de, ubizjak@gmail.com,
        Alistair Popple <apopple@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B39368D9-7E5D-4864-819C-CDEEAB4BD92D@gmail.com>
References: <20221022111403.531902164@infradead.org>
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
 <3a57cfc5-5db4-bdc9-1ddf-5305a37ffa62@nvidia.com>
 <CAHk-=wj6EJvTtTeYQvkX3aOw6Q1SRYRV6xJP1+uHNvfAocO1hw@mail.gmail.com>
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

On Oct 29, 2022, at 1:15 PM, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:

> (b) we could move the "page_remove_rmap()" into the "flush-and-free" =
path too
>=20
> And (b) would be fairly easy - same model as that dirty bit patch,
> just a 'do page_remove_rmap too' - except page_remove_rmap() wants the
> vma as well (and we delay the TLB flush over multiple vma's, so it's
> not just a "save vma in mmu_gather=E2=80=9D).

(b) sounds reasonable and may potentially allow future performance
improvements (batching, doing stuff without locks).

It does appear to break a potential hidden assumption that rmap is =
removed
while the ptl is acquired (at least in the several instances I samples).
Yet, anyhow page_vma_mapped_walk() checks the PTE before calling the
function, so it should be fine.

I=E2=80=99ll give it a try.

