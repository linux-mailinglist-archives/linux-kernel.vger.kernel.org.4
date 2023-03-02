Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CDF6A84A3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjCBOuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjCBOu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:50:26 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE72580C9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:49:17 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id m22so6423492ioy.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 06:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2l3NQJUTH3/qN89xY5bS6AJLfJmHgspkf61yJ8LdA9c=;
        b=of2jhdzOcdjd7DQ6Tq21PylhQsmdLVKDDUtwGRfyti5a2grEHicj+B5+0rN5PDc5/Y
         LBw6tRMCjLlZ5ez7ZKnYjla+ELS9V0Ld2CEgNGmgaR4w82Kf3LXYHjPL8bJe8V5Jb/WR
         TRYslK1gqqOKs5Ahu4RwvElOU+k+JyqSJurGBe4/9r4Hz1kEVoU5OyT76rxrpkleI6Q8
         AnA5URzhdkZmdteg3mxnzbH3at7Nyft5++/ZMwlWqGwrRbdNnODJ4rafR59Fo0sNpK7n
         ZZqKsJa5KxyNuAFhmiUlqdV2e4NR215YdRFfqvPmsHA/wmtFOLvHUPfCEXJ0DRYcEcVp
         VSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2l3NQJUTH3/qN89xY5bS6AJLfJmHgspkf61yJ8LdA9c=;
        b=rPio6Ruf/onp9IDDmmFLHEpHntRF6A4jdk/0fIdzggZW/hCZVqWYJ/VUCG4l8b+QNC
         rHt7sq1u0Rmo4Gm4EWx5JHN48GGmKLZBPToik3gD24ux6yLgbfpP+fViuYbjv9vcIBpw
         uBWRCK8Msy6HLTOurASgsrNvcQ3c8MzdDfbSy5WsTKrvrZxS6RLMmZDoDQKcvFL0/R4k
         fFxX3Ge8bqSNcyIo8wAD+Bn0t3RayjHSyNvcLg9lWW50s1/O73k/6+N9doitGoAnzC2b
         P92FGD3mBeLvZtb3OjbEdhsTzcrJVCCYJefriRu0TnUckjVh1cQMx8VBWTvkWvX3/8wY
         yKUg==
X-Gm-Message-State: AO0yUKUF4YkiT/iVjlawlT5dGHaomm21rRdDQBUVfIa0Uh5MveeqMpBV
        mfc4QiqVf2AFgBtyxWXwPlrX04RTyoOIgQeFMDtb+Q==
X-Google-Smtp-Source: AK7set9vxIW4luvgv9ZCJRtoXbzkPMhY416bO+ZbNnqrH34wjctqll14EMcVeH8tsDabgrQ0nlI9q4fRKqF1GawM9zg=
X-Received: by 2002:a02:940a:0:b0:3ea:f622:3c7 with SMTP id
 a10-20020a02940a000000b003eaf62203c7mr4693665jai.5.1677768545351; Thu, 02 Mar
 2023 06:49:05 -0800 (PST)
MIME-Version: 1.0
References: <20230301143933.2374658-1-glider@google.com> <20230301143933.2374658-2-glider@google.com>
 <CANpmjNOG=T8R=BXO8PUX3FJQnKQfPjNyLGJ0wG5G_4_mHwJ-gA@mail.gmail.com>
In-Reply-To: <CANpmjNOG=T8R=BXO8PUX3FJQnKQfPjNyLGJ0wG5G_4_mHwJ-gA@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 2 Mar 2023 15:48:29 +0100
Message-ID: <CAG_fn=X_E7r7JnBKWTygwiTa7HWJ1=AhtJOoH7is_mz0fhgfXA@mail.gmail.com>
Subject: Re: [PATCH 2/4] kmsan: another take at fixing memcpy tests
To:     Marco Elver <elver@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        akpm@linux-foundation.org, dvyukov@google.com, nathan@kernel.org,
        ndesaulniers@google.com, kasan-dev@googlegroups.com
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

> > +#define DO_NOT_OPTIMIZE(var) asm("" ::: "memory")
>
> That's just a normal "barrier()" - use that instead?

Ok, will do (I still think I'd better hide it behind a macro so that
we can change the implementation of DO_NOT_OPTIMIZE in the future if
the compiler starts outsmarting us again.

> > +/*
> > + * Test case: ensure that memcpy() correctly copies initialized values.
> > + */
> > +static void test_init_memcpy(struct kunit *test)
> > +{
> > +       EXPECTATION_NO_REPORT(expect);
> > +       volatile int src;
> > +       volatile int dst = 0;
> > +
> > +       // Ensure DO_NOT_OPTIMIZE() does not cause extra checks.
>
> ^^ this comment seems redundant now, given DO_NOT_OPTIMIZE() has a
> comment (it's also using //-style comment).

Moved it to the test description:

/*
 * Test case: ensure that memcpy() correctly copies initialized values.
 * Also serves as a regression test to ensure DO_NOT_OPTIMIZE() does not cause
 * extra checks.
 */

I think it's still relevant here.
