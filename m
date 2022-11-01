Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DABC615244
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiKAT3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiKAT3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:29:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C987E26E8
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 12:29:17 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k8so21551731wrh.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 12:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VhBI6yptdF6gqpfOjVVir+FFhIUKilBxNVcu4ZDmhcg=;
        b=jCu8faErN6IDLoHFWj//lG5/wu98i8DKrZ+v84UsrFRgNLS7RgtGLJ7zOb55Z3+5Ed
         rtBoBZ5B/mNlPZdFobJ8WOKB8mh1LlSMq8J49NkZFRDLK0BMHFxPTGzcjL1BdbhQr9g7
         jTbWzrYyTiVcEdvgKWTdLKviQjNKIngw9I43FvlfoSMO+3pf99eMHxRU2EEBaCp61F91
         GA8NDLsaF5KT5U0BjIeGh2rltBfXx6MiNUIBymeYwyvqPJbpmO6VO8YYd+YPpsKqpDhX
         WIQKoHZY4k79E/vme2SKxKhG/ya5T9QYy1j4Is7CMLxXcLsMjmIDNbeNJo6d1bAq+vaK
         w1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VhBI6yptdF6gqpfOjVVir+FFhIUKilBxNVcu4ZDmhcg=;
        b=ZYcw1/DqqsGP+V98IUh1jcoh5c8FcsNZ6dpgfvSAs8JOA4/4GnlT1SSUc7pmkPlzDu
         faIHXU7NuI1ClVmJqdEGE6lq22xR0K0vO5l56FSVLydaDcrzph4YmBaSfRO1FQ0i5AMH
         XMIDvNUKmz7FvSnf5Qy+A7cwBVbqfTOokrM1o3rlWcGk8qyjyJMjFBgTwBNRsdWovjgQ
         b4URfU/1SjZqLqWmPJAiHTRiys7K26SNC2ytdUlVV2bT/IYpnCIZNWIlzFO5j4LHorv/
         dI+tVMx9bO/meC5d1h/ObiQldsKNfLQfVg8P4k6OxH0uwge2YJBeJS3PT7FCCmypTaW6
         Z7zg==
X-Gm-Message-State: ACrzQf1RqD/ClbWGF6HzRYUP4tRBt8ur1znC6ZwdVN3g/+YLa1KNYrnr
        vH4o/z0xnC75+R8d+3kgEVGd3joTvfXtSeNKMrySyQ==
X-Google-Smtp-Source: AMsMyM4Gx4L1M043hs8e78+ecrn23MtZRjHxkMXoIWtpwIhlG9X9imLGBfatkEf+DC+Fiea1/gL6mrecdgNGrf3oH+w=
X-Received: by 2002:a5d:47a1:0:b0:236:6f4d:1db3 with SMTP id
 1-20020a5d47a1000000b002366f4d1db3mr12450738wrb.383.1667330956212; Tue, 01
 Nov 2022 12:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221031173819.1035684-1-vipinsh@google.com> <20221031173819.1035684-5-vipinsh@google.com>
 <Y2AmgObslx57+uYt@google.com> <CAHVum0fhangxMp5ysYdyoKVY+CKWeBAadMFX1V8MgqryRGHQrw@mail.gmail.com>
 <Y2FxgNCw11tA7yDz@google.com>
In-Reply-To: <Y2FxgNCw11tA7yDz@google.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Tue, 1 Nov 2022 12:28:40 -0700
Message-ID: <CAHVum0ddq3dwm_fzdj5PUYq=jyNs5bSnhACiS3RrBqLpg8QaYg@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] KVM: selftests: Add atoi_positive() and
 atoi_non_negative() for input validation
To:     Sean Christopherson <seanjc@google.com>
Cc:     pbonzini@redhat.com, dmatlack@google.com, andrew.jones@linux.dev,
        wei.w.wang@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, Nov 1, 2022 at 12:20 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Tue, Nov 01, 2022, Vipin Sharma wrote:
> > On Mon, Oct 31, 2022 at 12:48 PM Sean Christopherson <seanjc@google.com> wrote:
> > >
> > > On Mon, Oct 31, 2022, Vipin Sharma wrote:
> > > > diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
> > > > index ec0f070a6f21..210e98a49a83 100644
> > > > --- a/tools/testing/selftests/kvm/lib/test_util.c
> > > > +++ b/tools/testing/selftests/kvm/lib/test_util.c
> > > > @@ -353,3 +353,19 @@ int atoi_paranoid(const char *num_str)
> > > >
> > > >       return num;
> > > >  }
> > > > +
> > > > +uint32_t atoi_positive(const char *num_str)
> > >
> > > I think it makes sense to inline atoi_positive() and atoi_non_negative() in
> > > test_util.h.  Depending on developer's setups, it might be one less layer to jump
> > > through to look at the implementation.
> > >
> >
> > I am not sure if this makes life much easier for developers, as
> > "inline" can totally be ignored by the compiler. Also, not sure how
> > much qualitative improvement it will add in the developer's code
> > browsing journey. Anyways, I will add "inline" in the next version.
>
> To be clear, it's not about adding "inline", it's about not having separate
> declarations and definitions.  E.g. I've yet to achieve a setup that has 100%
> accuracy when it comes to navigating to a definition versus a declaration.  And
> when poking around code, seeing a "static inline" function provides a hint that
> a function is likely a simple wrapper without even having to look at the
> implementation.
>
> These are all small things, but I can't think of a reason _not_ to inline these
> trivial wrappers.
>

Note to myself: Read the whole sentence!

I skipped "in test_util.h". Got it.

> > > Last thought: my vote would be to ignore the 80 char soft limit when adding the
> > > "name" to these calls, in every case except nr_memslot_modifications the overrun
> > > is relatively minor and not worth wrapping.  See below for my thougts on that one.
> > >
> > > >                       break;
> > > >               case 'm':
> > > > -                     max_mem = atoi_paranoid(optarg) * size_1gb;
> > > > +                     max_mem = atoi_positive(optarg) * size_1gb;
> > > >                       TEST_ASSERT(max_mem > 0, "memory size must be >0");
> > >
> > > This assert can be dropped, max_mem is a uint64_t so wrapping to '0' is impossible.
> > >
> >
> > I intentionally kept it, as it is also protecting against having
> > accidently making size_1gb to 0.
>
> Heh, the test has far, far bigger problems if it screws up size_1gb.  And that's
> an orthogonal concern as the test would be horrifically broken regardless of
> whether or not the user specified '-m' and/or '-s'.
>
> A better approach is to replace the homebrewed size_1gb with SZ_1G from
> tools/include/linux/sizes.h.  I, and many others, completely overlooked size.h.

I will replace it.
