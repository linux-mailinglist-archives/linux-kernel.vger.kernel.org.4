Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38A36F8150
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 13:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjEELPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 07:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjEELPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 07:15:11 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609581A106;
        Fri,  5 May 2023 04:15:10 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-b8f34bca001so2164656276.3;
        Fri, 05 May 2023 04:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683285309; x=1685877309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SE+qv0o9CzjT0R4rTBjOmorChLvlhth7MGJbnlcgSwQ=;
        b=eMR3po0RiRr+nrRy6nO/nNYl+JqczyQs//Qc9E1MD3S2FjUYZZZsp3Dc7AgpVnnw4e
         LzOw02qRMj9ZECjAWBZumELr20uBsb2EiZcQuohA//fgPUmdUrrZcrVS0RXT8+veMw1y
         5qIMIFcdvx+jCwezz65m+nGFO/GWFbMCNZLXCNtryubqu94aSVqq2zvPVuyNOQaz9F/A
         6PL7HVtFLxwmQVRuO7hM1wBA1KmDh0JNADX4pn4vsiq4q2RkRuVN3jVTTjv641ZsOYfS
         cL2PYjQvaLhM2UIJNN+7hWkSk8n0k27Wiu8Hfaxh8nlqTAZW6WLSwmilsEhqnmEcJUSc
         IaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683285309; x=1685877309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SE+qv0o9CzjT0R4rTBjOmorChLvlhth7MGJbnlcgSwQ=;
        b=RVXBcxoHqFjlvD/gNfsRrqJ2jqVky3GRSrBzeqG48g129s5nAOCRNIURAcz9dMQaRx
         ZI7iRg1wtFbJ0MekYnLelGberZoPRPm+UJZ0La7bSPFl//JO6WFQL+C0nxHawSzekIpE
         SJtsydS5qQUcmXc12I+bCrKEYGc2S8ChWv3e4wn3noJfcsuNzy75Zc/lDEgoVpbxM7Sc
         i1T2eS2hpifLupBPP9MvA+cB+bCz5SPRVMyVpLdUHoZ52u8f13IscOm8HkqcieogWuoS
         TrUwV+Osg/vjK1MFsKqvGlvgL+lXLyRZ/CymSn70B/z5QbvHSjabHhBUx3w3vn+RIQX9
         Qn0A==
X-Gm-Message-State: AC+VfDzJRXJakTtUi0QTVUiHYIr77eQ8KlYSknsTka2HZ+hOmzeCuYi4
        nMz2W/3wv/EfJdH/GqdhJ4gwQFRXN9E8JV/JVYI=
X-Google-Smtp-Source: ACHHUZ6vOWVCGAppBd0mNOHAB1wACPSBO2VVyxYoYY9Fd6AKvbHqpYlz7XhTOySIwAm5d0rPnskGC1olvvQxuHxvpFM=
X-Received: by 2002:a25:ac1a:0:b0:b9d:95f1:ce42 with SMTP id
 w26-20020a25ac1a000000b00b9d95f1ce42mr1161183ybi.56.1683285309436; Fri, 05
 May 2023 04:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230503090708.2524310-1-nmi@metaspace.dk> <da7b815d-3da8-38e5-9b25-b9cfb6878293@acm.org>
 <87jzxot0jk.fsf@metaspace.dk> <b9a1c1b2-3baa-2cad-31ae-8b14e4ee5709@acm.org>
 <ZFP+8apHunCCMmOZ@kbusch-mbp.dhcp.thefacebook.com> <e7bc2155-613b-8904-9942-2e9615b0dc63@kernel.dk>
 <875y97u92z.fsf@metaspace.dk> <0adf4086-c624-1587-d490-9e6bb517afe0@kernel.dk>
In-Reply-To: <0adf4086-c624-1587-d490-9e6bb517afe0@kernel.dk>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 5 May 2023 13:14:58 +0200
Message-ID: <CANiq72nAmoO7NdTfcpSa-RDTR5Q8-x3sbKzYUUemOQWYfeW9Dg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] Rust null block driver
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Andreas Hindborg <nmi@metaspace.dk>,
        Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023 at 10:55=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> That potentially works for null_blk, but it would not work for anything
> that people actually depend on. In other words, anything that isn't
> null_blk. And I don't believe we'd be actively discussing these bindings
> if just doing null_blk is the end goal, because that isn't useful by
> itself, and at that point we'd all just be wasting our time. In the real
> world, once we have just one actual driver using it, then we'd be
> looking at "this driver regressed because of change X/Y/Z and that needs
> to get sorted before the next release". And THAT is the real issue for
> me. So a "rust keeps up or it breaks" model is a bit naive in my
> opinion, it's just not a viable approach. In fact, even for null_blk,
> this doesn't really fly as we rely on blktests to continually vet the
> sanity of the IO stack, and null_blk is an integral part of that.

But `null_blk` shouldn't be affected, no? The Rust abstractions can be
behind an explicit "experimental" / "broken" / "compile-test only"
gate (or similar) in the beginning, as a way to test how much
maintenance it actually requires.

In such a setup, Andreas could be the one responsible to keep them up
to date in the beginning. That is, in the worst case, a kernel release
could happen with the Rust side broken -- that way `null_blk` is not
impacted.

That is why a separate `MAINTAINERS` entry may be interesting if you
want to keep e.g. the `S:` level separate (though Andreas, I think,
may be able to do "Supported" at this time).

When the first real driver comes, a similar approach could be
repeated, to buy some more time too.

Cheers,
Miguel
