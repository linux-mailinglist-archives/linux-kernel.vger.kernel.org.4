Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DDA60FF50
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 19:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbiJ0Ra3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 13:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235840AbiJ0RaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 13:30:18 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF6F45F4C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 10:30:14 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id i3so2249714pfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 10:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i90u/Uf2jYE0+hrCgqCAgN0GAbxmncytTIkPhq3S0qI=;
        b=EI6URPO1CuEaiVYhCgdKTi96gCaG7jguowcRqg1P4rQc2aXOhQRYoviwLuauhrW/rj
         IvfRngDCHxTCiVsKVGfU8yxjZxb0ta+useELLhjLfbgD1/HxloRXBMfNVokd2n6b7Sad
         nEk9LSxHfnHkooXNe2eHo083I7ypbpTaIBbgJ8BoiZhynYGFQMcjo7hFAjToVlD1Rz0D
         jeVspwwn5FV+spWcYEbo4AMNpX4vAj7y6zldSJY1GKiV+B48TcqBMTwvlTUXnusjvPTu
         ddhsnX1lhWxk/GmTwLYaWztZ25qT60u4w2PiGxETjmwnTcrao6EmIeN6WKqHhmTsFC2J
         dH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i90u/Uf2jYE0+hrCgqCAgN0GAbxmncytTIkPhq3S0qI=;
        b=LYLZz3uproCCZpntVMtH2S51hewWz0Kk1tep8XTB5XoyfcY2P2TlTpHHol/S5kFeAS
         u5ixMhBJNXv0ggVYC8EkcUFF5XUcOqzySTCXzGHt2Nob28XgukGMyNyDOQsnYGRqghVn
         776tAHYiBHoCPniHrdt5oYxZnDj3+GzjNNVaUU1S2Z/pYh8Qq5RVwzFzdi+NT1tQSUQz
         pwzkWbJb6Ot7SYOsCB9PFN7L5lNqICg02X0cKoqRfMGoJjGMseQoUChmAWTvK/KLEsQy
         Li4H/8L87gni8oTLzb7h3jwqrhjMHigmHKD7iJHWJux0kROIhdI4QRsEeHBaIFlkyvQM
         FIwg==
X-Gm-Message-State: ACrzQf05ULwbys22yxLq+B/WZPKoTQS0lDEl8UmfXOdIEohK3XE02sAo
        DmGUXOmhzv8zODAZYAMygpI=
X-Google-Smtp-Source: AMsMyM7jC2bcEuLwv2GZWzC1z7PmlNL6h5cLDonNo2ECQ5++cNinRUGeyy5ddU/iI8MIv/Wupb/9cQ==
X-Received: by 2002:a65:4508:0:b0:43c:e3c6:d1c2 with SMTP id n8-20020a654508000000b0043ce3c6d1c2mr42555256pgq.582.1666891814045;
        Thu, 27 Oct 2022 10:30:14 -0700 (PDT)
Received: from smtpclient.apple ([66.170.99.95])
        by smtp.gmail.com with ESMTPSA id t2-20020aa79462000000b0056c063dd4cfsm1429687pfq.66.2022.10.27.10.30.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Oct 2022 10:30:13 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <Y1oy7+TnTkelR89U@hirez.programming.kicks-ass.net>
Date:   Thu, 27 Oct 2022 10:30:11 -0700
Cc:     Jann Horn <jannh@google.com>, John Hubbard <jhubbard@nvidia.com>,
        X86 ML <x86@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        jroedel@suse.de, ubizjak@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <1701B847-EE00-474A-ACF2-C4051884F8F1@gmail.com>
References: <20221022111403.531902164@infradead.org>
 <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com>
 <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
 <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
 <Y1fsYwshJ93FT21r@hirez.programming.kicks-ass.net>
 <CAG48ez3VE+3dVdUMK+Pg_942gR+h_TCcSaFxGwCbNfh3W+mfOA@mail.gmail.com>
 <Y1f7YvKuwOl1XEwU@hirez.programming.kicks-ass.net>
 <A3677D1D-3631-4E57-8C5C-6C202B47700C@gmail.com>
 <Y1oy7+TnTkelR89U@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
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

On Oct 27, 2022, at 12:27 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:

>> One alternative may be using mm_tlb_flush_pending() when setting a =
new PTE
>> to check for pending flushes and flushing the TLB if that is the =
case. This
>> is somewhat similar to what ptep_clear_flush() does. Anyhow, I guess =
this
>> might induce some overheads. As noted before, it is possible to track
>> pending TLB flushes in VMA/page-table granularity, with different =
tradeoffs
>> of overheads.
>=20
> Right; I just don't believe in VMAs for this, they're *waaay* to big.

Well, I did it for VMA in an RFC only because I was pushed. I thought =
and do
think that page-table granularity is the right one.=
