Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112066104A8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbiJ0Vo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236117AbiJ0Vow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:44:52 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C503D5AB
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 14:44:49 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id 4so3055503pli.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 14:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SmucxEaYv462cDhUuWHbqENmtRj5EFJFsejZah/7ns=;
        b=g0FRESr+JzZQ6RWf4EVze5xqLA4Ba57sN9s5bYeQSEcmq1ESoV0OgMbslUIXTLlK9Z
         IwgDww9Z2P7g5HJ+UMcQAJtr8IVUt0fb2vcldKTrzRligsUdszod3BwgYyofJNRCJX16
         mJkFiuJCGN4rzu9umDOaSxr1of/fTbFBVYeTcPXMeNxPjstpECua4fLrW79NYNiNnDPC
         zvs8PkY6UzdGsdP7BlhdPPOyHvpB/Fa41GSAyNo1vkqKEaZOiv1whR4HprvLg1ILwv8i
         sD3U+OGImOH6Hd8qDJv235BmKjoGCHnO6w+rAhGeu08bo8Bwd1yRhRz3m8NWZoPgBfsP
         5BJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SmucxEaYv462cDhUuWHbqENmtRj5EFJFsejZah/7ns=;
        b=y/csqn4TVRPRygb+YQVToTOLxIpCdzaGEhKTrIsel/6yZFOwbrchdIy9Nz/3RiwLEu
         FJYfe3M91ONUFLm7TrUaZNALYLVa2/bvZfYuFS4TDDnJtYw2218JX4ZJwN4gFlmz6eXE
         8N87f/0ZMgWkNINn99TP/xbxps390L1oKUIH0QagnDNHFRHB/xhpuB8oZtqYtaYH6ccz
         /WAajNHib+v+gWN1j+e3rLwNVDYufuXcDF3+2cTrXYonjkcbfQ99gALgbcwGDDY1YLTz
         BEKCEqopwjpd/uGD922HnT+jF2rVFWYdM/1RdEY0xSB+u2Ihgtv7ymhZprt8neRYC+iJ
         7uPg==
X-Gm-Message-State: ACrzQf16uPFBoMtSiTDVLDTXM86ssgSr4xIdq8U8FFDAv2JtwCoeqZNi
        6uKgrVnVjvGIbnvo64pNm0A=
X-Google-Smtp-Source: AMsMyM502ZgWe6Y6XrEInBuJr5eDwisEYkmj7MqpseG0x7O/1U4H5ODiVYJYXzTs4G/s1zfaBkwvwQ==
X-Received: by 2002:a17:902:d2c1:b0:186:9e90:6ad with SMTP id n1-20020a170902d2c100b001869e9006admr25862913plc.2.1666907089086;
        Thu, 27 Oct 2022 14:44:49 -0700 (PDT)
Received: from smtpclient.apple ([66.170.99.95])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090a840600b001fb1de10a4dsm1394712pjn.33.2022.10.27.14.44.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Oct 2022 14:44:48 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CAHk-=wh8oi0qQtYDFTfm7d1s5C8mG7ig=NfzGWt4zbjXMzcdqQ@mail.gmail.com>
Date:   Thu, 27 Oct 2022 14:44:46 -0700
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>, x86@kernel.org,
        willy@infradead.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        kirill.shutemov@linux.intel.com, jroedel@suse.de, ubizjak@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F9E42822-DA1D-4192-8410-3BAE42E9E4A9@gmail.com>
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

On Oct 27, 2022, at 1:31 PM, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:

> So there are two levels of tlb flush optimizations
>=20
> (a) avoiding them entirely in the first place
>=20
> (b) the whole "once you have to flush, keep track of lazy modes and
> TLB generations, and flush ranges"
>=20
> And honestly, I think you ignored (a), and that's where we do exactly
> those kinds of "this case doesn't need to flush AT ALL" things.

I did try to avoid TLB flushes by introducing pte_needs_flush() and =
avoiding
flushes based on the architectural PTE changes. There are even more x86
arch-based opportunities to further avoid TLB flushes (and then only =
flush
the TLB if spurious #PF occurs).

Personally, I still think that making decisions on flushes based on =
(mostly)
only the arch state makes the code more robust against misuse (e.g., see
various confusions between mmu_gather=E2=80=99s fullmm and =
need_flush_all).

Having said that, I will follow your feedback that the extra complexity
worth the extra performance.

Anyhow, admittedly, I need to give it more thought. For instance, in =
respect
to the code that you mentioned (in zap_pte_range), after reading it =
again,
it seems strange: how is ok to defer the TLB flush after the rmap was
removed, even if it is done while the PTL is held.
folio_clear_dirty_for_io() would not sync on the PTL afterwards, so the =
page
might be later re-dirtied using a stale cached PTE. Oh well.

