Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E408E5EAEF9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiIZSCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiIZSCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:02:34 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CE29E890
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:43:11 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id l65so7411755pfl.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=dS2HoVEP/IautLBa+8qjMYG0nRQ2M4jtBQk6ChJqH7I=;
        b=bAPW/KQifoIiaAr7aTQb7E1W+gHBX4gkyOf0mhug6/5qSA5e6+RT1utLKF1Grf/yrI
         lRxDJamz19OWlOLaYDtNyBhGyOMXBHitneyFKKPaEL4WF13U9NV0zOIhK5y9/VYoRz0W
         t4um/JMxQaFZTn55cMHGCOxy8EdIemWo6x/Y46X+lUC5pbXRgV5AB4NOkU2k8muDc8j6
         fpxUnY1EPQnuTbAiBYG1JZjUANUFyV6GRNvXKeK1CmD/eNylgphstLqV1dLfr/0vd/6Q
         ENH1X0i7W9uoRtB4dS4vtPhvaez3BtB/RZycDtQIOFJ4wR5Ssq5ikstYqnAlw91X7sVY
         WHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dS2HoVEP/IautLBa+8qjMYG0nRQ2M4jtBQk6ChJqH7I=;
        b=BzRplX9TXnoocct/z/KcgK+5J33cO5K9aWpuSaCsDfIcgAjEW+snUoWxTii3KusggY
         fB0BEuwrg1zt+PT4NhKt5m13Ap400l3fXXxDvu4h/7kk8MtmSof9F65/u44sqE4HkukX
         MDNRTf9KU4ezp36D5YoUmUz/xN1lWLMJyatFCAI+JfTrzIlmxBS1xfkAH+70mthj1Gbz
         5pBGMalYIAGkLO5M38N3ch3VwpTHmVp/MmoZcRuBbA8Dhv1PiOZGFepJ3vjjvnp5Bj2W
         PZ/RijWdqHSnP3uU7/znbW4XoFEqcXsr2iDaEICC1QyVYQ2/0j9aA9bbRMiHouhksHkc
         1mNw==
X-Gm-Message-State: ACrzQf3bGoDNJ20os+DZIMKXkfH2SFhYGrWIbv7okCs646nM7f/H9z5S
        w6niBWSjgRoCO732VqaGlBlIKDJumtwrPFyiBP5Jzg==
X-Google-Smtp-Source: AMsMyM6Vv2uNa7xefX210Pq1S8XTsUHUD60VHmcuHWAngAccJ8DimC1Tre7VFweksZ/drlsLy3ksJ1fFhBUn768E7WQ=
X-Received: by 2002:a05:6a00:4c11:b0:53e:4f07:fce9 with SMTP id
 ea17-20020a056a004c1100b0053e4f07fce9mr25491371pfb.66.1664214177034; Mon, 26
 Sep 2022 10:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvyD9OWF53ua2EZmyf+=YTx4f1mezDNkVLMxf3BKXW=_w@mail.gmail.com>
 <YzHIwvzhM9DSW9cF@dev-arch.thelio-3990X> <YzHJRH9hO1lfjSPp@dev-arch.thelio-3990X>
In-Reply-To: <YzHJRH9hO1lfjSPp@dev-arch.thelio-3990X>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 26 Sep 2022 10:42:45 -0700
Message-ID: <CAKwvOdkYr-Nv6PowyJ10DuP-uFLcvH1oGWSeQH3Dz_JM8vwp2w@mail.gmail.com>
Subject: Re: arch/arm/probes/kprobes/core.c:409:30: error: .fnstart must
 precede .save or .vsave directives
To:     Nathan Chancellor <nathan@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
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

On Mon, Sep 26, 2022 at 8:46 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> + our mailing list, I should have added it with that message.
>
> On Mon, Sep 26, 2022 at 08:44:05AM -0700, Nathan Chancellor wrote:
> > Hi Naresh,
> >
> > On Mon, Sep 26, 2022 at 06:57:00PM +0530, Naresh Kamboju wrote:
> > > Following build warnings / errors noticed on arm with clang-13 / 14
> > > on Linux next-20220923.
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
> > > Regressions found on arm:
> > >
> > >    - build-clang-13-bcm2835_defconfig
> > >    - build-clang-nightly-imx_v6_v7_defconfig
> > >    - build-clang-nightly-orion5x_defconfig
> > >    - build-clang-13-keystone_defconfig
> > >    - build-clang-13-omap2plus_defconfig
> > >    - build-clang-14-imx_v6_v7_defconfig
> > >    - build-clang-nightly-omap2plus_defconfig
> > >    - build-clang-nightly-multi_v5_defconfig
> > >    - build-clang-nightly-bcm2835_defconfig
> > >    - build-clang-13-imx_v6_v7_defconfig
> > >    - build-clang-13-imx_v4_v5_defconfig
> > >    - build-clang-14-imx_v4_v5_defconfig
> > >    - build-clang-13-orion5x_defconfig
> > >    - build-clang-14-multi_v5_defconfig-65236a87
> > >    - build-clang-14-lkftconfig
> > >    - build-clang-nightly-imx_v4_v5_defconfig
> > >    - build-clang-13-multi_v5_defconfig
> > >    - build-clang-13-lkftconfig
> > >    - build-clang-nightly-keystone_defconfig
> > >    - build-clang-14-multi_v5_defconfig
> > >    - build-clang-14-orion5x_defconfig
> > >    - build-clang-14-omap2plus_defconfig
> > >    - build-clang-nightly-multi_v5_defconfig-65236a87
> > >    - build-clang-14-bcm2835_defconfig
> > >    - build-clang-14-keystone_defconfig
> > >    - build-clang-nightly-lkftconfig
> > >
> > > arch/arm/probes/kprobes/core.c:409:30: error: .fnstart must precede
> > > .save or .vsave directives
> > >                 "stmdb  sp, {sp, lr, pc}        \n\t"
> > >                                                   ^
> > > <inline asm>:3:2: note: instantiated into assembly here
> > >         .save   {sp, lr, pc}
> > >         ^
> > > /builds/linux/arch/arm/probes/kprobes/core.c:412:29: error: .fnstart
> > > must precede .pad directive
> > >                 "stmdb  sp!, {r0 - r11}         \n\t"
> > >                                                   ^
> > > <inline asm>:6:2: note: instantiated into assembly here
> > >         .pad    #52
> > >         ^
> > > 2 errors generated.
> > > make[5]: *** [/builds/linux/scripts/Makefile.build:250:
> > > arch/arm/probes/kprobes/core.o] Error 1
> > >
> > > build log:
> > > https://builds.tuxbuild.com/2FAyD1qcTlzjIYE7mjrugjCsxu1/
> >
> > Thank you for the testing and report! I brought this up on GitHub on
> > Friday as I noticed this as well:
> >
> > https://github.com/ClangBuiltLinux/linux/issues/1718

Thanks for the reports. I'll take a look at filing additional bug
reports against clang, then moving the definition of
__kretprobe_trampoline to out of line assembler.

> >
> > It sounds like we can avoid this by rewriting __kretprobe_trampoline()
> > in out of line assembly but I have not had a chance to sit down and try
> > it.
> >
> > Cheers,
> > Nathan
>


-- 
Thanks,
~Nick Desaulniers
