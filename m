Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125C25FAEDD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 11:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJKJDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 05:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJKJDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 05:03:22 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D0976976
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 02:03:19 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id j7so15718387ybb.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 02:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcAOxa1eNezPHmJ9FrETfyniUyQ1uo7YUQ4nKmmzqaQ=;
        b=tl4+sPD+REiD6EkMCv/WFRGMoMNhfDFvCrq9TBhC1g1QrHzRnqXbFYZ65z8TmYWlDB
         CgB8GY/eJZnShEbgfxB8Qpk09fE1WzSU0BbfSiDHJssktoJE5Wt5In2FLMae9pqxMDh5
         BZV8PXin+imLlZqVFUcUQcx28BGHQ53LBd9uJSf+UuvabPhV9IkbU0aLWkrRBZOU7P1Y
         tk0ZBZAySF7M9cZkk7RtADSUNF7waL+8rl2JsCpAlaVYbuposfHn7aXR83NJwi4yDUoU
         sJxzKuaAZoCLd7hsfJELnUm0JWfX4pqsXjDfPSTa0gFZjJj4wfi2rAy6LsejfG6W+9eH
         jQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcAOxa1eNezPHmJ9FrETfyniUyQ1uo7YUQ4nKmmzqaQ=;
        b=mPXQRo6jjTVproRRe+hybovrtESi1kcvIk7ZErrXMiNFASZ26h9oYYLa3j0OheiaJr
         4eiCHssxdcVIDU235TsBmCDHN17GyGOL1qR0hPfvSNtoQITRs4o7IWXfspAHdUXUWOtA
         ysHd1JROemVO0g32lwhgStuClDRhMk5wsyK+hZ1gy0h/F/GJmF2eTQAPyFM4UG8oC7hS
         8PaI2UTquahVdXBYTliBYo9P7sGQP1MrqvXVINo17ZYFkuTkorHVc5LFObc95fh2zNW2
         Y6617DVze/kYpwBY3h45ZBav8Ex/Kg6765QpjMzlTIj3KQbqJd2b5vbdfPN/tRSWUnDa
         pbLg==
X-Gm-Message-State: ACrzQf0ujkdmKBrzDPDMx2En7n4d74H/J67LSO5oa7pE3wQlCLn6+EcH
        A2CvBIKau56yeKJ4qKyHqXwqiPbOgZBGkKCnaV9COyub3F2x8g==
X-Google-Smtp-Source: AMsMyM4Urn5vFXswQKScZ6Xnp/tV/RsptNvXWPtkoBumbwT02NnnChX1WgD70JU0gAjj3427ja4Cb9bqPm02qXzoGAU=
X-Received: by 2002:a5b:a44:0:b0:6b0:13b:c93b with SMTP id z4-20020a5b0a44000000b006b0013bc93bmr22875414ybq.398.1665478998747;
 Tue, 11 Oct 2022 02:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221008132113.919b9b894426297de78ac00f@linux-foundation.org> <CAHk-=wigZoriP8ZB+V87Jf+EQV=ka6DQe_HCAQmh3Dmus2FFhw@mail.gmail.com>
In-Reply-To: <CAHk-=wigZoriP8ZB+V87Jf+EQV=ka6DQe_HCAQmh3Dmus2FFhw@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 11 Oct 2022 11:02:42 +0200
Message-ID: <CAG_fn=WuMUKjdNwpcc7Msh6wrXFEkigYJJv9rS9+iMJO2d5Y-w@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.1-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 3:20 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Oct 8, 2022 at 1:21 PM Andrew Morton <akpm@linux-foundation.org> =
wrote:
> >
> > Alexander Potapenko (43):
> >       crypto: kmsan: disable accelerated configs under KMSAN
>
> Ok, so this conflicted pretty badly with the crypto tree having
> re-organized their Kconfig files.

Sorry about that. There was a fix for this problem:
https://lore.kernel.org/lkml/20220909095811.2166073-2-glider@google.com/,
but I am not sure where it ended up, given that crypto tree didn't
have KMSAN, and -mm didn't have the crypto changes.

> I channelled my inner Alexander the Great, and just cut the whole
> thing through by disabling all the architecture-accelerated crypto
> includes when KMSAN was enabled.

That's exactly the point. Thanks for doing that!

>  But that's very different from your tree that disabled the options
> individually, so some KMSAN person should probably look around at it
> and decide whether some more subtle approach is called for.

No, in fact it was pretty painful to disable the configs one by one.
Thankfully, the new Kconfig layout simplifies the things for us.

> The other thing I notice from just doing a build is that I now get
>
>    vmlinux.o: warning: objtool: kasan_report+0x12: call to
> stackleak_track_stack() with UACCESS enabled

Guess that's unrelated to KMSAN. Happy to take a look anyway.

> which may just be a "need to teach objtool this is ok", but I'm not
> seeing why it's now starting to happen. Maybe just code generation
> changed for some reason, or maybe it's just that config options ended
> up changing enough to expose this on my allmodconfig builds.
>
> Cc'ing people who may know better.
>
> This is just my reaction from doing the merge and test-build. There
> may or may not be more commentary once I've actually tried to boot
> into this thing.
>
>                Linus


Small nit:

     - Dmitry Vyukov introduces KMSAN: the Kernel Memory Sanitizer. It uses
       clang-generated instrumentation to detect used-unintialized bugs dow=
n
       to the single bit level.

s/Dmitry Vyukov/Alexander Potapenko/ ;)
(although contributions of Dmitry Vyukov and Marco Elver to the whole
thing cannot be underestimated!).

--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
