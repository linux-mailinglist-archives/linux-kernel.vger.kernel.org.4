Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25453612F6F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 05:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiJaEJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 00:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJaEJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 00:09:42 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67CA7667
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 21:09:41 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id k5so1798473pjo.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 21:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWemLfOzUXoCZKBHkTng8WZ7m1m/5k1ivUxEwj3raDw=;
        b=kvSxwDiwRGtPcK0NvGldR3n/cJLI4rtvSls8Y803ZIffDcgpYmFUOennVFrjSR+u3J
         uJeN5tgdUCtIIJ11lP3/GP4gRAK4dNRmkdETwsmYn3VoyNW/P7YY0EZPhN5xyVoEjE5t
         zG6/qbX5r+jcWdOHtC240eNA3eO3L3IU/ZweGSDSOjK2B+caDTZDZ1HQaV51M8A2xmuF
         d9BLmI776UBq/oRku58KtL+xBAyU2Sa3QSTsRykHT31hPBtEJAgmIWX1wkkh2HJmCNgQ
         EDLoiKJjrsecu7gchvSewwI8c7Bry14rJGyRyWutxthPncElEUFRse5fSKCQ2zDHHKFz
         vnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWemLfOzUXoCZKBHkTng8WZ7m1m/5k1ivUxEwj3raDw=;
        b=j48NfvSsTBbSmLE2YOc9EpKtRQGbI13Qh6bTqEahblSGewZOovjUatRkB/lhfTFdsO
         P0HUAr+9pYkl0Lao2/s0f4w7pai0dt4BJ0Vridx4k9U0eGoA/mYjdZYl5cn7nfZ3FRgM
         29rJs3y0hMdTKVYGHDKkGXvZjViike6uI4O/slTCb+2Lk0txxBc2vC+L/UEAU9IRxuzP
         f7z9RWI4QTB8PwYAFOE2gWRhqNbBfu1jMHpDIAIn0gUAzGTvkbL/E1ulQ/Isty2kzHjM
         fwpu+DpA0bGZl9VbJIv/8HlgGwsyt8nhqA396L7BzB+WdtYmq+xUlDSwXF16+esgPyIH
         P0Jg==
X-Gm-Message-State: ACrzQf2GsEqp5kU4j0a8yzuG/wHLjgolUOmJFI94N7umrZzCRu9vmhHr
        RCsumc7cqUg2iCIIVp81pIuS03Mb7tTOiZzAKas=
X-Google-Smtp-Source: AMsMyM5jseukbTyVylHrJNbqU0HdAtiHSIZ8m19EEAkcCpum8DbSE3wMN8kEYJ13x8Tpu2js0sjO2Q==
X-Received: by 2002:a17:903:11c7:b0:178:af17:e93e with SMTP id q7-20020a17090311c700b00178af17e93emr12238156plh.78.1667189380816;
        Sun, 30 Oct 2022 21:09:40 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902e54100b00177ff4019d9sm3356279plf.274.2022.10.30.21.09.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Oct 2022 21:09:39 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CAHk-=wiwt4LC-VmqvYrphraF0=yQV=CQimDCb0XhtXwk8oKCCA@mail.gmail.com>
Date:   Sun, 30 Oct 2022 21:09:37 -0700
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
Message-Id: <A48A5CEB-2C02-4101-B315-6792D042C605@gmail.com>
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

On Oct 30, 2022, at 6:47 PM, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:

> The reason I haven't actually tested it is partly because I never
> recreated the original problem Navav reported, and partly because the
> meat of patch 4/4 is just the same "encode an extra flag bit in the
> low bit of the page pointer" that I _did_ test, just doing the "remove
> rmap" instead of "set dirty".
>=20
> In other words, I *think* this should make Nadav's test-case happy,
> and avoid the warning he saw.

I am sorry for not managing to make it reproducible on your system. The =
fact
that you did not get the warning that I got means that it is not a
hardware-TLB differences issue (at least not only that), but the race =
does
not happen on your system (assuming you used ext4 on the BRD).

Anyhow, I ran the tests with the patches and there are no failures.
Thanks for addressing this issue.

I understand from the code that you decided to drop the deferring of
set_page_dirty(), which could - at least for the munmap case (where
mmap_lock is taken for write) - prevent the need for =E2=80=9Cforce_flush=E2=
=80=9D and
potentially save TLB flushes.

I was just wondering whether the reason for that is that you wanted
to have small backportable and conservative patches, or whether you
changed your mind about it.

