Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D529469A792
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjBQI5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBQI5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:57:14 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEFB5A3A6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:57:13 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id c25so282519vko.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AdXhA+rr7rT3nbRAWr9dOcvlGGpbLeHVjZKaiCCs0e4=;
        b=Gh6VjHO7lAs9Cny9IFZl9+mTCRsMn7dVKBMoDOQTN4pIdh3cgyQ4RKD+5PH7zlCh3x
         qs4rnGzKX5wjuWBfSoNPpKGWUmUgvP8TtNr+UVAEQ4HqQNyHBjpjlN+je8Thu8fcbZjV
         3yC8qNuhgj6lTurm0MJSf0tLKxyZaRC1Gs/82KF3wZ9iXRUty9HAwgtwMRkB+KHdW9rm
         v7dfdhgH/tp4IKQeYqfIcpHvFH26gmXcWPWQ2gE6jJNNTZmjaqWm6A6+P7/1VrkGuKpc
         RF+hvgjgBA8LTfXzeA1Hr3+Ylz2ZmJGCAzFKlr2qN4f8iZ780TtDWS/52qhH/WJKzlhH
         J4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AdXhA+rr7rT3nbRAWr9dOcvlGGpbLeHVjZKaiCCs0e4=;
        b=o7BYaymKdEfkUIH9uS3oQwyIeutXMs0HSKZ8Glh7IcAbJIZGnRx8L7sd6qMkczYeGg
         +7xwIOZB5AYzq23yelKCvoOaxcZXDueoy4h0RvOOgEkdZ9gCf6mrE2trPPrnDF2wcHR0
         te2yc/a8ZZuTMImzeos1ZDfGN62MpmvH3qahxmAybDqXNPAS0CM307a7/oFBS9y4gZp2
         yXUjVFesVoiWTcVFcCbFhSfnkUqCm8RdsQLIPKiJHTkMuNlJbo/ppf76wgS60SYtGj2H
         lkeCJVXlG83uPvT4WbknU59NEbxQSjdLNUBOOX469RG2nRZdqqQ3e/aHhIEmMRIjrUQk
         r/2Q==
X-Gm-Message-State: AO0yUKXbbkNBjsWGbjlIQN51raBcdQS6FEIRDSPj0zjKpBp6jw7hDJRE
        9lVH6XE09PrePVgnXl5xtuboUkLh0gVPskYdKArwNw==
X-Google-Smtp-Source: AK7set/kIbRMV2UZDPYFGpCJd/Db7bz1XuoSfleq30AQbkrQBIHWFx4fxz8wQpsLxeszBr+1n2Vv216XeXPKUoZ1Ivg=
X-Received: by 2002:a1f:13d4:0:b0:3ea:78fc:6dd8 with SMTP id
 203-20020a1f13d4000000b003ea78fc6dd8mr1602508vkt.21.1676624232103; Fri, 17
 Feb 2023 00:57:12 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYvZqytp3gMnC4-no9EB=Jnzqmu44i8JQo6apiZat-xxPg@mail.gmail.com>
 <CAG_fn=V3a-kLkjE252V4ncHWDR0YhMby7nd1P6RNQA4aPf+fRw@mail.gmail.com>
 <CAG_fn=VuD+8GL_3-aSa9Y=zLqmroK11bqk48GBuPgTCpZMe-jw@mail.gmail.com>
 <CANpmjNOciiDNkWDrkQ+BEgAj=rSYGQAuHVS1DTDfvPHSbAndoA@mail.gmail.com> <CA+G9fYvLmhfw7dk_rhXBHd7YESGtAndmhdcW2=VGANfk0ho9Uw@mail.gmail.com>
In-Reply-To: <CA+G9fYvLmhfw7dk_rhXBHd7YESGtAndmhdcW2=VGANfk0ho9Uw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 17 Feb 2023 09:56:34 +0100
Message-ID: <CANpmjNPLX-1JzSiFzxCyk=Y-zOupMjezeeEGa_wa7+-B5dtc5Q@mail.gmail.com>
Subject: Re: next: x86_64: kunit test crashed and kernel panic
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Feb 2023 at 08:30, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Hi Marco,
>
> On Fri, 17 Feb 2023 at 05:22, Marco Elver <elver@google.com> wrote:
> >
> > On Thu, 16 Feb 2023 at 19:59, Alexander Potapenko <glider@google.com> wrote:
> > >
> > > >
> > > > > <4>[   38.796558]  ? kmalloc_memmove_negative_size+0xeb/0x1f0
> > > > > <4>[   38.797376]  ? __pfx_kmalloc_memmove_negative_size+0x10/0x10
> > > >
> > > > Most certainly kmalloc_memmove_negative_size() is related.
> > > > Looks like we fail to intercept the call to memmove() in this test,
> > > > passing -2 to the actual __memmove().
> > >
> > > This was introduced by 69d4c0d321869 ("entry, kasan, x86: Disallow
> > > overriding mem*() functions")
> >
> > Ah, thanks!
> >
> > > There's Marco's "kasan: Emit different calls for instrumentable
> > > memintrinsics", but it doesn't fix the problem for me (looking
> > > closer...), and GCC support is still not there, right?
> >
> > Only Clang 15 supports it at this point. Some future GCC will support it.
> >
> > > Failing to intercept memcpy/memset/memmove should normally result in
> > > false negatives, but kmalloc_memmove_negative_size() makes a strong
> > > assumption that KASAN will catch and prevent memmove(dst, src, -2).
> >
> > Ouch - ok, so we need to skip these tests if we know memintrinsics
> > aren't instrumented.
> >
> > I've sent a series here:
> > https://lore.kernel.org/all/20230216234522.3757369-1-elver@google.com/
>
> Thanks for sending this patch series.
>
> I request you to share your Linux tree / branch / sha.
> I will rebuild it with clang-16 and run kunit tests and get back to
> you soon with results.

The series should apply against -next, where you observed the failure.

Otherwise I have them here:
https://git.kernel.org/pub/scm/linux/kernel/git/melver/linux.git/log/?h=kasan/dev

Thanks,
-- Marco
