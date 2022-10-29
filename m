Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6503E612521
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 21:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJ2T2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 15:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiJ2T2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 15:28:38 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADCA371A6
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 12:28:37 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id y4so7599078plb.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 12:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5MNM9Gp83rj3UXMtx0nvDXUik0Rl01o5B2bsdQaQS4=;
        b=YLn+7prPCIUJbELDwGQBO8OgEvapON9uvMBpVWTGmVvbFDBMOqOkbeuTTx6JU62CXY
         Y1RB6U6Zw23NnkO7uWG0keEkAlKTOHQTGLuuvV7PT+9zlfXva15U+bb2at9GZtW9ZSj5
         RZ9qnRt+RGA2iFOfpQ2JI5M50wrtJF0cNpLazpaSC1nDaIm4OjWxEaNJEUAWMjW2XFcw
         I72VSzkuSOK9IjbFfZreixDAA6ErWuRMaeuw26LsTNZfVzVCU9omvsSbFmM40LoayPVb
         VinRNm49z591YDYmDsMScC8NQz6UlX5Gu9hXXmagtVrsCcxZaPWP/XdKxqTLTcmjlEWn
         kydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5MNM9Gp83rj3UXMtx0nvDXUik0Rl01o5B2bsdQaQS4=;
        b=1aiLqJrU9Hi74vVF9CSdIXyPLa4jLY6X811QpQUPC7lBa538bPeYFNYvH6Ki1cQQdB
         2U9Hp9perv+BP0qej1YRgB+3fGJbrcBOsT5IAZbEb4/hjDq2bHoUY+sVVCVclYPPSTgN
         KTzw8cOMNbqdWaZn2ViArjODLw/KTel7RkMx3+Zk0BWD0V8FyCYeqNuNrdcmvEBR82o2
         WeYYBO69ABDlqAQlqZDQZVAQaXM31Pu8L9oy2qqVX1GVl0w6P33iWmSHzc/UR6EoQsZR
         gSIclJGL/FNdR2bcCJXtwJnXPj0scU7/1G9/Qs0nTDJ7SmThg3jQIZrN5mUro/FJPFEs
         lt1Q==
X-Gm-Message-State: ACrzQf1Xfg3THa/ISUx3KOMvsbwpN4ZAYLE8Ws2GhsAiKUcio/lfdE79
        5ARAKqN13a36ZHwYQ/x615c=
X-Google-Smtp-Source: AMsMyM6k5McbIdjGmNpmU+CP4pesJ10kbkLuIkKFmYGBHYQv+ayC2wWyO+3tlkzJH3sPvxD0LaxeDA==
X-Received: by 2002:a17:902:da88:b0:187:3d6:4c6b with SMTP id j8-20020a170902da8800b0018703d64c6bmr5768876plx.85.1667071716402;
        Sat, 29 Oct 2022 12:28:36 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902680d00b00174d9bbeda4sm1627756plk.197.2022.10.29.12.28.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Oct 2022 12:28:35 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CAHk-=wgiDa9Xy5rLMR_gvC-WVvdkxABgXXADbKhwswYof7ptdg@mail.gmail.com>
Date:   Sat, 29 Oct 2022 12:28:33 -0700
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
Message-Id: <D8B7A488-E62E-4329-8FB4-5E7057F625C4@gmail.com>
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
 <CAHk-=wgiDa9Xy5rLMR_gvC-WVvdkxABgXXADbKhwswYof7ptdg@mail.gmail.com>
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

On Oct 29, 2022, at 12:14 PM, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:

> On Sat, Oct 29, 2022 at 11:58 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> Still not tested in any way, shape, or form. I decided I wanted to
>> send this one before booting into this and possibly blowing up ;^)
>=20
> Well, it boots, and I see no difference with your PoC code.
>=20
> It didn't fail for me before, it doesn't fail for me with those =
patches.
>=20
> Again, the "it doesn't fail for me" is probably because I'm running it
> incorrectly, although for all I know there can also be hardware
> differences.

Please give me some time to test it. I presume you ran it with block ram
device (not tmpfs) and not on a virtual machine (which can affect =
besides
Intel/AMD implementation differences).

But even if your patches work and the tests pass, I am not sure it means
that everything is fine. I did not try to trigger a race with
shrink_page_list(), and doing that might be harder than the race I tried =
to
create before. I need to do some tracing to understand what I was =
missing in
my understanding of the shrink_page_list() - assuming that I am mistaken
about the buffers being potentially released.

I would note that my concern about releasing the buffers is partially =
driven
by to issues that were reported before [1]. I am actually not sure how =
they
were resolved.


[1] https://lore.kernel.org/all/20180103100430.GE4911@quack2.suse.cz/

