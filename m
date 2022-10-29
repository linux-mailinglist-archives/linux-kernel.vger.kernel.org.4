Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0970612564
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 23:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiJ2VDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 17:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiJ2VDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 17:03:50 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B207A356C0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 14:03:49 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c2so7675472plz.11
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 14:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0XCKXWN9AOEQpnItiZWYYfOLH2B1OdimWu6qHPiTXU=;
        b=MykEozAVop9FYqjq/UBLWRl1qcpsM0d97FhuGVh4xlzm7nH9BAbge84ihX82QqvP2R
         wjrT4jl7eNWsxi0mb2whRhQd6e3ZSYQda3P0Zd6mq6aIFCjuBy/m1VDk4q6YJMHfIH0Z
         wsP+ECqSbxacXUS8s8FEltlOlpVtLHVHUvfl0ytUz1URqU6w0CWWJ0HUuBX8VpLrjwoT
         ROgSlmGTJJqj+xBYBn7tgm25aOJx7iC+ZPEv+rOK0WNf9KPRFRazZ+hxjiQxnOx7dwKK
         zHq6aC6XU9MScoTulis/1npK1cHvh10GL//s3oAGR/R0X5hihH/k87EhaesLVRIVXHSu
         AZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0XCKXWN9AOEQpnItiZWYYfOLH2B1OdimWu6qHPiTXU=;
        b=nfKZs0GN9Oll0GqLSoq+6k8RNoDHedX3AFIcQxdoHa8qsgqtIG4sUIVbAqQB+0M4oU
         xh/9YG+n87+SgL+01QDHMDkNMm8byoMw0NKP5Bj1HL6qWPm8+NEEnej9VQA20XkGOK0M
         QkWMqBhr9SBYfMAAQkROP0vnAeUV7Cwc4tk9WXnjv87R0+FqClx96g4u6YGP5r8Bsgsg
         0aXM11SEt3Bsm6Te0hMB8kDBP+n9B1rDBOUbAZGvdw/aYBcCk484JYbbwYX5rEE5vQCW
         u8FMkiArv7bwdBOVHNVjJietI/RVDyA7GQlqYtQAF/45AYJOY+MZMH6Angs/rt6mppda
         80qg==
X-Gm-Message-State: ACrzQf2R/JsKg04GNEFYjc0Qc4CUEyseeobxFFmK7TjbQTMKClk5P+8Q
        rd150mrrlpirZ8nKkYEKbHw=
X-Google-Smtp-Source: AMsMyM5fDQWwHZHOs8s2TFyQHhBJxKPtuLb2CJtfNHhL98e6pM1POFUn5M4K4TP/ltPW+rGTHkVpcw==
X-Received: by 2002:a17:903:cd:b0:186:878e:3b08 with SMTP id x13-20020a17090300cd00b00186878e3b08mr5999887plc.93.1667077429009;
        Sat, 29 Oct 2022 14:03:49 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id 79-20020a621452000000b0056b9df2a15esm1590688pfu.62.2022.10.29.14.03.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Oct 2022 14:03:48 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <B39368D9-7E5D-4864-819C-CDEEAB4BD92D@gmail.com>
Date:   Sat, 29 Oct 2022 14:03:46 -0700
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Message-Id: <9880C4F0-FF13-46BA-9044-30949D155158@gmail.com>
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
 <B39368D9-7E5D-4864-819C-CDEEAB4BD92D@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>
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

On Oct 29, 2022, at 1:56 PM, Nadav Amit <nadav.amit@gmail.com> wrote:

> On Oct 29, 2022, at 1:15 PM, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>=20
>> (b) we could move the "page_remove_rmap()" into the "flush-and-free" =
path too
>>=20
>> And (b) would be fairly easy - same model as that dirty bit patch,
>> just a 'do page_remove_rmap too' - except page_remove_rmap() wants =
the
>> vma as well (and we delay the TLB flush over multiple vma's, so it's
>> not just a "save vma in mmu_gather=E2=80=9D).
>=20
> (b) sounds reasonable and may potentially allow future performance
> improvements (batching, doing stuff without locks).
>=20
> It does appear to break a potential hidden assumption that rmap is =
removed
> while the ptl is acquired (at least in the several instances I =
samples).
> Yet, anyhow page_vma_mapped_walk() checks the PTE before calling the
> function, so it should be fine.
>=20
> I=E2=80=99ll give it a try.

I have just seen John=E2=80=99s and your emails. It seems (b) fell off. =
(a) is out
of my =E2=80=9Czone=E2=80=9D, and anyhow assuming it would not be solved =
soon, deferring
page_remove_rmap() might cause regressions.

(c) might be more intrusive and potentially induce overheads. If we need =
a
small backportable solution, I think the approach that I proposed =
(marking
the page dirty after the invalidation, before the PTL is released) is =
the
simplest one.

Please advise how to proceed.

