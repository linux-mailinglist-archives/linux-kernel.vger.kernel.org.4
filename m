Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781E55FB872
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 18:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiJKQny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 12:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJKQnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 12:43:51 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80A6A2235
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 09:43:50 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id h13so12595733pfr.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 09:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4cQLsLHBibKCXET80IomNLXe7aKtZBxMhsEFPZH1Ilw=;
        b=NbElJqk8KLlSeynJnSBpTuSUqK+dlJYSfjhESozbJipfngxmf7ra2Ycw3zm/u4nHA6
         6vCmS1QuGcgLscl9XWSAOOAwqpHu/sLmhW/XVhKgvzGBGCZ/qhUBgWEvOkoBPtK0lkaY
         TMu10prmH3kqlnb2mx2V7ssj2qI05plyUVofdlecVN79yA09z/4j3zgJcZzp6D9Hr0dI
         rUsUQb27ndeQNA1LLQbIerUw2VZwNwoNuYbuV0t3igIjp6CvQF3wICa0zY+8b3t2v294
         7w9WckZyZtFM/7TCDHn64q6XmEv9WMw7LtNZaQjYoBUCG2PPyTAhNC8AgCrhRQWhI1Ok
         U1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4cQLsLHBibKCXET80IomNLXe7aKtZBxMhsEFPZH1Ilw=;
        b=CJEg1iZ3axcZl8pBZ6TLPMMTN3siMurL2UUTh3Fz0/NUKU9Ay90A7vBv9RkTYmoyvE
         VknY9lajBaxkVMPVLd9aNywoSP64K3k7TWJPzkwZRO4Ce1YR+pucvqf53XDjqoCwRniY
         AZ1NpMPt/z/muca/1PLxv3HNbNM8adY9gWmWZlvhtE9TRZAMDUXLvhib3PHxaAPEvBBH
         3JeFMgFqs41tFg1VlhyDPS5M0t7w+Bu2x20XBlsHkJwGdeJ8LHpU03Cqt5hRHDNJZ7NF
         VbF74wLIKISqOseXDvFK0pxNCEoJ2g7W4tBjuPR4KPFVQTbnpaJxab8ySYlCFvjyl1yM
         3+7g==
X-Gm-Message-State: ACrzQf3m13iyeZ6pZVSv2FIB9BU0jkLzAI4VW+JDWIwRcq+j6xGpv3lv
        iBk8dqKdNTd3zexhBCySUStbIgEyEY+jZNOZl/9P4A==
X-Google-Smtp-Source: AMsMyM4rvA/2n5H3Zcyx4WXYAkabqtuxLr5z5RO3dT1uqSNjwxQckRtR8KJxEieT2UD4Lcinf1i3GQzKzRSuDjeW99o=
X-Received: by 2002:a05:6a00:1748:b0:563:8346:12ea with SMTP id
 j8-20020a056a00174800b00563834612eamr8498810pfc.23.1665506629981; Tue, 11 Oct
 2022 09:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221011031843.960217-1-masahiroy@kernel.org> <08db7754-ecd8-4425-875b-4f2b44497f6b@app.fastmail.com>
In-Reply-To: <08db7754-ecd8-4425-875b-4f2b44497f6b@app.fastmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 11 Oct 2022 09:43:38 -0700
Message-ID: <CAKwvOdm3z2MWzxTuK9e=eZXWLEBgnkT3NC-ALKNB8z7L9PnfQw@mail.gmail.com>
Subject: Re: [RFC PATCH] Remove Intel compiler support
To:     Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ia64@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Tom Rix <trix@redhat.com>, devel@acpica.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
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

On Tue, Oct 11, 2022 at 8:18 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Oct 11, 2022, at 5:18 AM, Masahiro Yamada wrote:
> > include/linux/compiler-intel.h had no update in the past 3 years.
> >
> > We often forget about the third C compiler to build the kernel.
> >
> > For example, commit a0a12c3ed057 ("asm goto: eradicate CC_HAS_ASM_GOTO")
> > only mentioned GCC and Clang.
> >
> > init/Kconfig defines CC_IS_GCC and CC_IS_CLANG but not CC_IS_ICC,
> > and nobody has reported any issue.
> >
> > I guess the Intel Compiler support is broken, and nobody is caring
> > about it.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> > I am sending this to Linus and the x86 maintainers with RFC.
> > If somebody is still using ICC, please speak up!
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
>
> I had the same thought a while back and tried to show that it as
> already broken, but I never managed to actually download the compiler
> at the time.
>
> It appears that in the meantime, Intel have completely dropped their
> old codebase and moved to using LLVM[1], so my guess is that with the
> current releases it will behave the same as clang. It might help
> to verify that this is indeed the case if you want to add that
> to the changelog text.

This is my thought, too.  I'm happy to help folks working on icx to
get icx up and running for kernel builds, if there's interest.

Change LGTM; there's probably some refactoring we might be able to do
as a result of this; we might be able to move more common definitions
out of include/linux/compiler-gcc.h and include/linux/compiler-clang.h
into include/linux/compiler_types.h, but that can wait until after
this change.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
>      Arnd
>
> [1] https://www.intel.com/content/www/us/en/developer/articles/technical/adoption-of-llvm-complete-icx.html



-- 
Thanks,
~Nick Desaulniers
