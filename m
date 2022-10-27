Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B84A610276
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 22:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbiJ0UPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 16:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236007AbiJ0UPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 16:15:25 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEBC58170
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:15:24 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id b29so2751581pfp.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7LaqFW6corIRO3XUNY2tm6XyzywliIkqOeicYcLPwU=;
        b=EtGLqAsrZBujejbp7Q++OuP58NpeNYIWlM3H+9eLJhYSS9IAXx5rtZGoA7RUdQY+Bs
         amndNceTD08Uql5/ps1yOAjVZA1MiHZlXVGAOZ5iTIpdwWnUrRbh5BmjM9At8WnMHqJM
         6Bk8ghKciKOWW40SUonD2lnOWdW56oJUrOE3oEL0alwqa22h8gW/+qKWEv0flfLF9+hN
         m6MEsWhjPrDv5LpnCz8s2phwqGgkMtlM+DxdIXP5E9XWopvDKtxBZ2AZeRwnh5VJyktv
         AMFFUG884QlAoRm/uAVfRtjXHfQ5ZngonXWVDVMwmZC9Ez+F7Lu3WnxudT2o2WxI8U4w
         eqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7LaqFW6corIRO3XUNY2tm6XyzywliIkqOeicYcLPwU=;
        b=3GSIedFDzTnU1BjWbXh928wxXkWPMEG1jCO5rq3VQ1knVbxKA6xJ7Ndkqlci0P2I1c
         Q3sSC/LcgS1ekgil5XEJUdV5hKoqjpzeufw2sfJh4PtiYeN5thn/oSO0Q1cLtqwXfiie
         +rEclSM3C4BppLEtc1xsAJ2pOkdoduomy+qLHvpojM3dloY4k0vyFhdk5O68t0L6EqSG
         /EwW9V/GiYFt2UsJYDO1xJRI2O4kESxnsW9xDhRrMaAqW9VHvu0Imbtn2Xi0sPQ+6+56
         SMbZIzE6p8u7zCsrrFMeTEPjsNqN5txuUNZqHgIcrO5NR8mU2NMpcjXXTCxsUqlIYVPa
         szfQ==
X-Gm-Message-State: ACrzQf2lKgKhGs63Zfdh5uAEcMCIABBCX0Jvq/mswEEFpdArQly9G/0X
        mE4sOgC4hR2AostZDw4tbyEOUH5hAWwceK0l
X-Google-Smtp-Source: AMsMyM6RuZwBn9rEoy4zRYd/aRoX60A0k5/QYrsT7f2BIBbrLDC9CCTYHjxPpzflfEssSt4IbtGV8w==
X-Received: by 2002:a63:2253:0:b0:43c:c924:e56a with SMTP id t19-20020a632253000000b0043cc924e56amr42160495pgm.122.1666901723974;
        Thu, 27 Oct 2022 13:15:23 -0700 (PDT)
Received: from smtpclient.apple ([66.170.99.95])
        by smtp.gmail.com with ESMTPSA id x15-20020aa79a4f000000b0056bc67f9da8sm1547358pfj.63.2022.10.27.13.15.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Oct 2022 13:15:23 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CAHk-=wihPdOtXgJ32pLB6Xd-UvnaZW9YvOOjM24JGYRjNHeykA@mail.gmail.com>
Date:   Thu, 27 Oct 2022 13:15:22 -0700
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>, x86@kernel.org,
        willy@infradead.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        kirill.shutemov@linux.intel.com, jroedel@suse.de, ubizjak@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <6C548A9A-3AF3-4EC1-B1E5-47A7FFBEB761@gmail.com>
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

On Oct 27, 2022, at 11:13 AM, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:

> Anybody willing to try to write up the rules (and have each rule
> document *why* it's a rule - not just "by fiat", but an actual "these
> are the rules and this is *why* they are the rules").
>=20
> Because right now I think all of our rules are almost entirely just
> encoded in the code, with a couple of comments, and a few people who
> just remember why we do what we do.

I think it might be easier to come up with new rules instead of phrasing =
the
existing ones.

The approach I suggested before [1] is something like:

1. Turn x86=E2=80=99s TLB-generation mechanism to be generic. Turn the
   TLB-generation into =E2=80=9Cpending TLB-generation=E2=80=9D.

2. For each mm track =E2=80=9Ccompleted TLB-generation=E2=80=9D, =
whenever an actual flush
   takes place.

3. When you defer a TLB-flush, while holding the PTL:
  a. Increase the TLB-generation.
  b. Save the updated =E2=80=9Ctable generation" in a new field in the
     page-table=E2=80=99s page-struct.

4. When you are about to rely on a PTE value that is read from a =
page-table,
   first check if a TLB flush is needed. The check is performed by =
comparing
   the =E2=80=9Ctable generation=E2=80=9D with the =E2=80=9Ccompleted =
generation=E2=80=9D. If the =E2=80=9Ctable
   generation=E2=80=9D is behind, a TLB flush is needed.

   [ You rely on the PTE value when you install new PTEs or change them =
]

That=E2=80=99s about it. I might have not covered some issues with =
fast-GUP. But in
general I think it is a simple scheme. The thing I like about this =
scheme
the most is that it avoids relying on almost all the OS data-structures
(e.g., PageAnon()), making it much easier to grasp.

I can revive the patch-set if the overall approach is agreeable.


[1] =
https://lore.kernel.org/lkml/20210131001132.3368247-1-namit@vmware.com/=
