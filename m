Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6F9612C73
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 20:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiJ3Te7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 15:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJ3Te5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 15:34:57 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44712654A
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 12:34:56 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id i3so8973000pfc.11
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 12:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rRRU1s0zqHNH3Op2fFOiDASnNIOpIdPdkq7obGplwM=;
        b=aSyq77AYkfRACdpt7kfHTPFDClwHxTPC6OSBA1JZ84Iq2F/Lr+DgvXbiivKtzikCzT
         3MJ9gjOASoSpmEjTs2YdsBaSBHPPwzjxUliBKwDidY7Wv9l1A/+0BKVzEh6Uv2rwRJF0
         TQPWOzvF6YF+4G13b8QozqjpSdHSRq+QzSztLi+z0nKrHFNTEQg08qDgTg/arYyD6Ff0
         awp/YVDIADj6tv9JuHPXfSQM6cY2hCriO3IABrmawstjrq/6zIR/4ggpu/uOvpT6QmWS
         mj4Xl6nfXEhLMIABAfqcbUj/Vz0eyMZWOu6xv2vox3tCjIhV5ZDtor6Ob1Ri1QFllqbC
         F/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rRRU1s0zqHNH3Op2fFOiDASnNIOpIdPdkq7obGplwM=;
        b=N0c0jBGlo1Fpcz3E9aWSbtjtBlYQIN9o/wNOJC6ALTFVtxjtKyN84RVPwtsxotP7jw
         L7Bv2zDYNXlFKBpmwZJcPZxPiU5bL3haDX1HaVkeXDo7yvLgy9dJCdCWZDvyc1bNi1/V
         xmcL5b5YjDX4AZJGk37FUHUMtoaQq8puWJD5+P2QKQnbhIQ9ICE3D1JsduTIl98uQbUQ
         3NMQwwAGFvkHUK245Vw1t7ADWZTAVyvkr+uMrIXDNV6KHtnn88rKSnlvfinhGQcj/yEX
         OsBO5RfvYTp9Uv93J1rBFmyW2iH0Ejn6IcSnZ4kunvHismEDzkstXtyHtG2pYhnFtmMe
         cj4A==
X-Gm-Message-State: ACrzQf16JuQPsJzKD9XlUU7vyJPY9HRBl2fstyfP/znPzU+JWcexq5f1
        ZgFWYd3uaVOJRVDsTw/aAVc=
X-Google-Smtp-Source: AMsMyM57Hi5gkRbPJ2bKlPoUgGDAFHMpWMehFFthps4Gsty5oasp0vMb8BDX3dW0FL3f7Gr4JYtUxw==
X-Received: by 2002:a63:914a:0:b0:46f:7e1c:6584 with SMTP id l71-20020a63914a000000b0046f7e1c6584mr9285280pge.562.1667158495355;
        Sun, 30 Oct 2022 12:34:55 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id o18-20020a170903009200b0018691ce1696sm2993173pld.131.2022.10.30.12.34.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Oct 2022 12:34:54 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
Date:   Sun, 30 Oct 2022 12:34:51 -0700
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
Message-Id: <44A8D373-24CA-4777-AFC8-DB48F0DC4FAE@gmail.com>
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

On Oct 30, 2022, at 11:19 AM, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:

> And page_remove_rmap() could *almost* be called later, but it does
> have code that also depends on the page table lock, although it looks
> like realistically that's just because it "knows" that means that
> preemption is disabled, so it uses non-atomic statistics update.
>=20
> I say "knows" in quotes, because that's what the comment says, but it
> turns out that __mod_node_page_state() has to deal with CONFIG_RT
> anyway and does that
>=20
>        preempt_disable_nested();
>        ...
>        preempt_enable_nested();
>=20
> thing.
>=20
> And then it wants to see the vma, although that's actually only to see
> if it's 'mlock'ed, so we could just squirrel that away.
>=20
> So we *could* move page_remove_rmap() later into the TLB flush region,
> but then we would have lost the page table lock anyway, so then
> folio_mkclean() can come in regardless.
>=20
> So that doesn't even help.

Well, if you combine it with the per-page-table stale TLB detection
mechanism that I proposed, I think this could work.

Reminder (feel free to skip): you would have per-mm =E2=80=9Ccompleted
TLB-generation=E2=80=9D in addition to the current one, which would be =
renamed to
=E2=80=9Cpending TLB-generation=E2=80=9D. Whenever you update the =
page-tables in a manner
that might require a TLB flush, you would increase the =E2=80=9Cpending
TLB-generation=E2=80=9D and save the pending TLB-generation in the =
page-table=E2=80=99s
page-struct. All of that is done once under the page-table lock. When =
you
finish a TLB-flush, you update the =E2=80=9Ccompleted TLB-generation=E2=80=
=9D.

Then on page_vma_mkclean_one(), you would check if the page-table=E2=80=99=
s
TLB-generation is greater than the completed TLB-generation, which would
indicate that TLB entries for PTEs in this table might be stale. In that
case you would just flush the TLB. [ Of course you can instead just =
flush if
mm_tlb_flush_pending(), but nobody likes this mechanism that has a very
coarse granularity, and therefore can lead to many unnecessary TLB =
flushes.
]

Indeed, there would be potentially some overhead in extreme cases, since
mm's TLB-generation since its cache is already highly-contended in =
extreme
cases. But I think it worth it to have simple logic that allows to =
reason
about correctness.

My intuition is that although you appear to be right that we can just =
mark
this case as =E2=80=9Cextreme case nobody cares about=E2=80=9D, it might =
have now or in the
future some other implications that are hard to predict and prevent.

