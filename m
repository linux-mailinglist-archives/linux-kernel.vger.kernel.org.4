Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE52A69A620
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 08:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjBQHaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 02:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjBQHaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 02:30:04 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE3F2110
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 23:30:02 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id s21so697602uac.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 23:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AaFc9U9vYkJWTuUxQlSrpWrlwRWSsnO1tJS6q4VH5W4=;
        b=TSXVN4RAjB8gKl5Z1yahyFnITPfu5lqbpL7BVaeg0fH617+OmS9alOEehBuvGkN/KD
         IRsOfbMhyRi4UVwoF2DBRsMaQssAly9wUXGzaLew905wq4Nd7SvicYVzJJ3juh/669oT
         k5BPJGG8BYSZnWkMQ4IhGx5Whjdj+3+v5mllPZvRawq7o21Im/plHhYIxwXWqTszxTgY
         APeRqTn3K5HMGDsAdOvaMU7waaHMHxgjVH/1sbz9/OoY5ZIieqE9jpTRfVsjgY38S0J/
         tpH+b5bwHoKDogZeD0+tMXWVEOUbEHwtJ3Ox52tqDKaeC+QtwXg5g6ZeTQR5iBOAzXpn
         +8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AaFc9U9vYkJWTuUxQlSrpWrlwRWSsnO1tJS6q4VH5W4=;
        b=rNw7RlICByEVdNslBHMzTUVu3I2WmA+nYDMDa79FxxnheFW26jxaTrcztL99TmdRwr
         Z1Km/p9QNhNsCEaIkiRQKRBPCrTAAobDXfW/l4sZZkcPOCW0VHkKcuZjq0EcrirWbByU
         A/dnQ7btu/4SgL8RNFauSOseVDpdqpnKDsIvMAY+qAw/sdYin07P+YsoYxv/4P1icMVp
         6yT+bHYYlT1ejlwxk41CrdInl3jl6PtawEeY3sHlY0eplvyDVMEk6QbVdpaLHC/GaK0x
         I/9yRwx6AvHsONkekhodbFMDgwndResUEUJU/57OoPjlzHJv39xsjozR2akDX7f0jzpC
         sPOg==
X-Gm-Message-State: AO0yUKXL2iA/H21prF7RXaeTX4LOdrtKiOlunj/F71qRtqK88PxPJZM2
        UmZXrXAT+r24MVm9uBFwZIBUVB4l/z4a9Q6Sp5qqTqgYfLvawA==
X-Google-Smtp-Source: AK7set9DF9KeFw9LzyQH5Z6doKGd/0FaFayUaEkUBWy5Rjgx+3emgp23EIrxCij/WAG2qoon3dmfE1FIOTJQFjuGcfM=
X-Received: by 2002:a9f:305e:0:b0:68b:a181:563c with SMTP id
 i30-20020a9f305e000000b0068ba181563cmr497812uab.0.1676619001255; Thu, 16 Feb
 2023 23:30:01 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYvZqytp3gMnC4-no9EB=Jnzqmu44i8JQo6apiZat-xxPg@mail.gmail.com>
 <CAG_fn=V3a-kLkjE252V4ncHWDR0YhMby7nd1P6RNQA4aPf+fRw@mail.gmail.com>
 <CAG_fn=VuD+8GL_3-aSa9Y=zLqmroK11bqk48GBuPgTCpZMe-jw@mail.gmail.com> <CANpmjNOciiDNkWDrkQ+BEgAj=rSYGQAuHVS1DTDfvPHSbAndoA@mail.gmail.com>
In-Reply-To: <CANpmjNOciiDNkWDrkQ+BEgAj=rSYGQAuHVS1DTDfvPHSbAndoA@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 17 Feb 2023 12:59:50 +0530
Message-ID: <CA+G9fYvLmhfw7dk_rhXBHd7YESGtAndmhdcW2=VGANfk0ho9Uw@mail.gmail.com>
Subject: Re: next: x86_64: kunit test crashed and kernel panic
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Peter Collingbourne <pcc@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        open list <linux-kernel@vger.kernel.org>,
        kunit-dev@googlegroups.com, lkft-triage@lists.linaro.org,
        regressions@lists.linux.dev,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Konovalov <andreyknvl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Fri, 17 Feb 2023 at 05:22, Marco Elver <elver@google.com> wrote:
>
> On Thu, 16 Feb 2023 at 19:59, Alexander Potapenko <glider@google.com> wrote:
> >
> > >
> > > > <4>[   38.796558]  ? kmalloc_memmove_negative_size+0xeb/0x1f0
> > > > <4>[   38.797376]  ? __pfx_kmalloc_memmove_negative_size+0x10/0x10
> > >
> > > Most certainly kmalloc_memmove_negative_size() is related.
> > > Looks like we fail to intercept the call to memmove() in this test,
> > > passing -2 to the actual __memmove().
> >
> > This was introduced by 69d4c0d321869 ("entry, kasan, x86: Disallow
> > overriding mem*() functions")
>
> Ah, thanks!
>
> > There's Marco's "kasan: Emit different calls for instrumentable
> > memintrinsics", but it doesn't fix the problem for me (looking
> > closer...), and GCC support is still not there, right?
>
> Only Clang 15 supports it at this point. Some future GCC will support it.
>
> > Failing to intercept memcpy/memset/memmove should normally result in
> > false negatives, but kmalloc_memmove_negative_size() makes a strong
> > assumption that KASAN will catch and prevent memmove(dst, src, -2).
>
> Ouch - ok, so we need to skip these tests if we know memintrinsics
> aren't instrumented.
>
> I've sent a series here:
> https://lore.kernel.org/all/20230216234522.3757369-1-elver@google.com/

Thanks for sending this patch series.

I request you to share your Linux tree / branch / sha.
I will rebuild it with clang-16 and run kunit tests and get back to
you soon with results.

- Naresh
