Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BE060E953
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbiJZTo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbiJZTn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:43:29 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A8FD03A6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 12:43:26 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j15so17686603wrq.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 12:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaQg4HnVfQQh2mYdE59PhhkkYlSdwKzsH9fh8OFcl80=;
        b=PRu7uBQeiTNcFGjkqeZ74eaq3R/EF+NH31oAX8cDpG/wYGxfFmt9Z5x0qMz5ioIfa4
         153FPA33eWFb2S/npkwFrQjXvj7WXncaKXnXwaCG2yMjUflNCYdQ7dMFPmPWER9/lRH7
         O9JDY+aLcohMLijh09Yj1dqdZ5k7J7tQoAJLBUi7QncRx0IwsyQnovUOvmIAK6HzOVl/
         2RYybC1Es4lI7h71AV+gZvdKPv6D+2l7aVV9FdfSaq3vHAESJPh/nEuD1ZE0wQAdrni8
         okhtlFkvuD/iRcxg5R7JhVqA5+zLJ6BTe74rMPrEv9vkXeopiM6wgS04rGqIwH1OxVEj
         orgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SaQg4HnVfQQh2mYdE59PhhkkYlSdwKzsH9fh8OFcl80=;
        b=TCgKzPeVC8kEsN/7ZM4E41P1GokQqkvZKOpNayCTRJQUwnoIsgZ6pXmmejWvgfxnaI
         /MyxRyCNYf3HgTO6sfxjYBsLOg7b6G6hn6Nk6Rx6ah6U/WTr7PRj1L6EYcLYYlta9I7z
         NPlZcF7jRoI0JWUk/EgbCWVJpOQkbx6NE6aFyajjl0QS0OqXBeirzR0KctOE4FRbaQaw
         JMiHHJ00lQB9BXE06eXfLypMTxCudL0T0Od68JQl1c9qPx17f3s3tcnIToRNRaxw3SRH
         5TPHur2SWgGqWaqCib5plnUilSG7dWp4Y5uIWHQxF5fjlwGsU3Ek9+8OCq2yietBMdte
         2epA==
X-Gm-Message-State: ACrzQf1ut+EBhLeGDrtWZp1xnsNRBbxAKmLpzyojAiRzWrlBoZf9qvjv
        58H9uBFysyVaYZDy4WmW68w=
X-Google-Smtp-Source: AMsMyM6BPG7SlDsxRW1Ok7p20nZcfL53Tm74WRUCkErTJ1YVUZ7vOVYk2P+Q5k8P2FtFsbGUBM4YyA==
X-Received: by 2002:a5d:4b90:0:b0:236:702f:2093 with SMTP id b16-20020a5d4b90000000b00236702f2093mr12611103wrt.577.1666813404745;
        Wed, 26 Oct 2022 12:43:24 -0700 (PDT)
Received: from smtpclient.apple (bzq-84-110-50-27.cablep.bezeqint.net. [84.110.50.27])
        by smtp.gmail.com with ESMTPSA id o1-20020a05600c338100b003a3170a7af9sm2601374wmp.4.2022.10.26.12.43.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Oct 2022 12:43:23 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <Y1f7YvKuwOl1XEwU@hirez.programming.kicks-ass.net>
Date:   Wed, 26 Oct 2022 22:43:21 +0300
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
Message-Id: <A3677D1D-3631-4E57-8C5C-6C202B47700C@gmail.com>
References: <20221022111403.531902164@infradead.org>
 <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com>
 <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
 <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
 <Y1fsYwshJ93FT21r@hirez.programming.kicks-ass.net>
 <CAG48ez3VE+3dVdUMK+Pg_942gR+h_TCcSaFxGwCbNfh3W+mfOA@mail.gmail.com>
 <Y1f7YvKuwOl1XEwU@hirez.programming.kicks-ass.net>
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

On Oct 25, 2022, at 6:06 PM, Peter Zijlstra <peterz@infradead.org> =
wrote:

> 			if (!force_flush && !tlb->fullmm && details &&
> +			    details->zap_flags & ZAP_FLAG_FORCE_FLUSH)
> +				force_flush =3D 1;

Isn=E2=80=99t it too big of a hammer?

At the same time, the whole reasoning about TLB flushes is not getting =
any
simpler. We had cases in which MADV_DONTNEED and another concurrent
operation that effectively zapped PTEs (e.g., another MADV_DONTNEED) =
caused
the zap_pte_range() to skip entries since pte_none() was true. To =
resolve
these cases we relied on tlb_finish_mmu() to flush the range when needed
(i.e., flush the whole range when mm_tlb_flush_nested()).

Now, I do not have a specific broken scenario in mind following this =
change,
but it is all sounds to me a bit dangerous and at same time can =
potentially
introduce new overheads.

One alternative may be using mm_tlb_flush_pending() when setting a new =
PTE
to check for pending flushes and flushing the TLB if that is the case. =
This
is somewhat similar to what ptep_clear_flush() does. Anyhow, I guess =
this
might induce some overheads. As noted before, it is possible to track
pending TLB flushes in VMA/page-table granularity, with different =
tradeoffs
of overheads.

