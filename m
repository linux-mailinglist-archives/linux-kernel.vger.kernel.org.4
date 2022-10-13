Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79A45FE257
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 21:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiJMTDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 15:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJMTDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 15:03:00 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDFDD2E0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 12:02:57 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id o65so2157471iof.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 12:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MP3T/XHtvB7T2dvq2BFDW4i0+SNmM+iMnWNu4Hti2BA=;
        b=ZMTofWbJPh9OXpNDn+89bEexPttxGkSAoMgTKgcO7a58oNNx9ffMYPcw0jPVik8bNf
         /OdbkHy01qlffZiisapq3bbG4+XMS09MNjZl1h/9ALwM8RGjlmHPsvgrdPX9IVmEJ2JB
         EKKjB5RiaxA9mNnPMfFShHlMbHQOtBYCMrVMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MP3T/XHtvB7T2dvq2BFDW4i0+SNmM+iMnWNu4Hti2BA=;
        b=mQgbYyLKmSoMtGvKbKa7U0GmPu8pcXc+uke3YrDcCV3vsCcQ36+s4D28B1pGmUMQfB
         PL9ijRHO23uKFl9AsUVNJne8DQa9d3lHwVigCJZIm8Er4CJ6siinfsj76GW3z4ksUqrH
         5FeuHu91U0W7TyaUZ/SWe0A+XHV/QFBtgTG6nM08nosjiOMEMAuHllyUC910EVVzhzar
         bP4hlxGDWpyzYxx3rV9r6ucXz34JfjN1uApARckdnT88HaZd8AHUJsiVsHZHA1LMGlpZ
         5prGdL7QVswbarUhc8A8NqgYc2VyvM5AEyEQvjdq8HyoYxVvanuNHs6sHuMEU4sLFjeh
         WOHQ==
X-Gm-Message-State: ACrzQf1ID58iqcITOHIwKmf8KkpTjmQMv7zVm0ziDH0Iwn17gsjAlsai
        jRw4F/dmOjJp888sxR2FgRnkaNbsMA2v2zV8qeoAZQ==
X-Google-Smtp-Source: AMsMyM4RzYGiidFH0NDYt44AzYf9H4jcVkGDqcI3RF9uszlKftMcbPM4u6lpy8mLxwLYCdzS763ghbAVi0/zMgolec8=
X-Received: by 2002:a02:290e:0:b0:35a:d680:7aad with SMTP id
 p14-20020a02290e000000b0035ad6807aadmr807425jap.62.1665687777109; Thu, 13 Oct
 2022 12:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220920082005.2459826-1-denik@chromium.org> <20220922053145.944786-1-denik@chromium.org>
 <87h70zk83g.wl-maz@kernel.org> <CADDJ8CW0QgHtp1rwk=ZqrcuWZ4_L8KQh26VaEfcBQS0Tx9+ZYg@mail.gmail.com>
 <CAH=Qcsi3aQ51AsAE0WmAH9VmpqjOaQQt=ru5Nav4+d8F3fMPwQ@mail.gmail.com>
 <CADDJ8CXObkhMvOx+L29awjtt7tiaTWxFrRxOmhUqvzku1wswHw@mail.gmail.com>
 <CADDJ8CV83d4tYeLnQH-hHjzBfED6EBo4Z70q5A=9cwO+Lp1sNQ@mail.gmail.com>
 <87sfjxhh4k.wl-maz@kernel.org> <CADDJ8CVX5tZU9jL4FvTnvQxxVohhS76TVOoZAyy3k_Uit1efmA@mail.gmail.com>
 <86fsfsf0ab.wl-maz@kernel.org>
In-Reply-To: <86fsfsf0ab.wl-maz@kernel.org>
From:   Denis Nikitin <denik@chromium.org>
Date:   Thu, 13 Oct 2022 12:02:46 -0700
Message-ID: <CADDJ8CVP0f99e6v0F==5Qo6LePb0DCkF1KatTEHx24W8aWcXWw@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: arm64: nvhe: Fix build with profile optimization
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Brazdil <dbrazdil@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Manoj Gupta <manojgupta@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Marc for figuring out the filtering-out solution!
It fixed the build on ChromeOS.

I will update the patch and also filter out `-fprofile-use` which will avoid
a similar problem with the instrumented PGO in the future.

Thanks,
Denis

On Thu, Oct 13, 2022 at 4:09 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 11 Oct 2022 03:15:36 +0100,
> Denis Nikitin <denik@chromium.org> wrote:
> >
> > On Sat, Oct 8, 2022 at 7:22 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Thu, 06 Oct 2022 17:28:17 +0100,
> > > Denis Nikitin <denik@chromium.org> wrote:
> > > >
> > > > Hi Mark,
> > >
> > > s/k/c/
> > >
> > > >
> > > > This problem currently blocks the PGO roll on the ChromeOS kernel and
> > > > we need some kind of a solution.
> > >
> > > I'm sorry, but I don't feel constrained by your internal deadlines. I
> > > have my own...
> > >
> > > > Could you please take a look?
> > >
> > > I have asked for a reproducer. All I got for an answer is "this is
> > > hard". Providing a profiling file would help, for example.
> >
> > Could you please try the following profile on the 5.15 branch?
> >
> > $ cat <<EOF > prof.txt
> > kvm_pgtable_walk:100:10
> >  2: 5
> >  3: 5
> >  5: 5
> >  6: 5
> >  10: 5
> >  10: _kvm_pgtable_walk:50
> >   5: 5
> >   7: 5
> >   10: 5
> >   13.2: 5
> >   14: 5
> >   16: 5 __kvm_pgtable_walk:5
> >   13: kvm_pgd_page_idx:30
> >    2: __kvm_pgd_page_idx:30
> >     2: 5
> >     3: 5
> >     5: 5
> >     2: kvm_granule_shift:5
> >      3: 5
> > EOF
> >
> > $ make LLVM=1 ARCH=arm64 KCFLAGS=-fprofile-sample-use=prof.txt -j8 vmlinux
>
> Thanks, this was helpful, as I was able to reproduce the build failure.
>
> FWIW, it seems pretty easy to work around by filtering out the
> offending option, making it consistent with the mechanism we already
> use for tracing and the like.
>
> I came up with the hack below, which does the trick and is IMHO better
> than dropping the section (extra work) or adding the negation of this
> option (which depends on the compiler option evaluation order).
>
>         M.
>
> diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
> index 48f6ae7cc6e6..7df1b6afca7f 100644
> --- a/arch/arm64/kvm/hyp/nvhe/Makefile
> +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
> @@ -91,7 +91,7 @@ quiet_cmd_hypcopy = HYPCOPY $@
>
>  # Remove ftrace, Shadow Call Stack, and CFI CFLAGS.
>  # This is equivalent to the 'notrace', '__noscs', and '__nocfi' annotations.
> -KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_CFI), $(KBUILD_CFLAGS))
> +KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS) $(CC_FLAGS_CFI) -fprofile-sample-use=%, $(KBUILD_CFLAGS))
>
>  # KVM nVHE code is run at a different exception code with a different map, so
>  # compiler instrumentation that inserts callbacks or checks into the code may
>
>
> --
> Without deviation from the norm, progress is not possible.
