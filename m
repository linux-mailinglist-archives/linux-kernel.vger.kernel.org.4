Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5645EAF63
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbiIZSOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiIZSNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:13:44 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1499175AD
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 11:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Rv2UtBG5y0DEuGbKnbkoUprYaAGKufIBHk49ouUQfp8=; b=s1Kvm7Uctn+YZWVFofI9Lwwkh4
        +rLoYJ89Rks2OYCiiYBBjAtu4BygPlMZmLyWQaYffbA3H7SWEv2cW8WvYQyq37AsGbeGaAmsUUhvY
        MCbb0xuwX0WMXeTWBzreV1HNnqo3igsYptDYFi3+zgnrJS9DedkGgi0KT7yTvE8nx1e5xW03vIhTb
        Pn3S9xocE1fNC5nmVo+DrL7YkkVZIao447/1Y9h5VhZQhZ/Zai+sSyL9yJx0LFvpBD6iFkIcWuNMh
        jAVkOgwfOF4+2CpaDAINOeI0jNYXKjl1Fxv4F1yieSacjD/g6idLX/7gIjJIueqwy1YyMH465o4Kk
        r26Rn+5Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34506)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ocsRV-0000n7-C5; Mon, 26 Sep 2022 19:02:57 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ocsRT-0005KR-Ju; Mon, 26 Sep 2022 19:02:55 +0100
Date:   Mon, 26 Sep 2022 19:02:55 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        regressions@lists.linux.dev, lkft-triage@lists.linaro.org,
        llvm@lists.linux.dev
Subject: Re: arch/arm/probes/kprobes/core.c:409:30: error: .fnstart must
 precede .save or .vsave directives
Message-ID: <YzHpT7t+9uSIYm0k@shell.armlinux.org.uk>
References: <CA+G9fYvyD9OWF53ua2EZmyf+=YTx4f1mezDNkVLMxf3BKXW=_w@mail.gmail.com>
 <YzHIwvzhM9DSW9cF@dev-arch.thelio-3990X>
 <YzHJRH9hO1lfjSPp@dev-arch.thelio-3990X>
 <CAKwvOdkYr-Nv6PowyJ10DuP-uFLcvH1oGWSeQH3Dz_JM8vwp2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkYr-Nv6PowyJ10DuP-uFLcvH1oGWSeQH3Dz_JM8vwp2w@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 10:42:45AM -0700, Nick Desaulniers wrote:
> On Mon, Sep 26, 2022 at 8:46 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > + our mailing list, I should have added it with that message.
> >
> > On Mon, Sep 26, 2022 at 08:44:05AM -0700, Nathan Chancellor wrote:
> > > Hi Naresh,
> > >
> > > On Mon, Sep 26, 2022 at 06:57:00PM +0530, Naresh Kamboju wrote:
> > > > Following build warnings / errors noticed on arm with clang-13 / 14
> > > > on Linux next-20220923.
> > > >
> > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > >
> > > > Regressions found on arm:
> > > >
> > > >    - build-clang-13-bcm2835_defconfig
> > > >    - build-clang-nightly-imx_v6_v7_defconfig
> > > >    - build-clang-nightly-orion5x_defconfig
> > > >    - build-clang-13-keystone_defconfig
> > > >    - build-clang-13-omap2plus_defconfig
> > > >    - build-clang-14-imx_v6_v7_defconfig
> > > >    - build-clang-nightly-omap2plus_defconfig
> > > >    - build-clang-nightly-multi_v5_defconfig
> > > >    - build-clang-nightly-bcm2835_defconfig
> > > >    - build-clang-13-imx_v6_v7_defconfig
> > > >    - build-clang-13-imx_v4_v5_defconfig
> > > >    - build-clang-14-imx_v4_v5_defconfig
> > > >    - build-clang-13-orion5x_defconfig
> > > >    - build-clang-14-multi_v5_defconfig-65236a87
> > > >    - build-clang-14-lkftconfig
> > > >    - build-clang-nightly-imx_v4_v5_defconfig
> > > >    - build-clang-13-multi_v5_defconfig
> > > >    - build-clang-13-lkftconfig
> > > >    - build-clang-nightly-keystone_defconfig
> > > >    - build-clang-14-multi_v5_defconfig
> > > >    - build-clang-14-orion5x_defconfig
> > > >    - build-clang-14-omap2plus_defconfig
> > > >    - build-clang-nightly-multi_v5_defconfig-65236a87
> > > >    - build-clang-14-bcm2835_defconfig
> > > >    - build-clang-14-keystone_defconfig
> > > >    - build-clang-nightly-lkftconfig
> > > >
> > > > arch/arm/probes/kprobes/core.c:409:30: error: .fnstart must precede
> > > > .save or .vsave directives
> > > >                 "stmdb  sp, {sp, lr, pc}        \n\t"
> > > >                                                   ^
> > > > <inline asm>:3:2: note: instantiated into assembly here
> > > >         .save   {sp, lr, pc}
> > > >         ^
> > > > /builds/linux/arch/arm/probes/kprobes/core.c:412:29: error: .fnstart
> > > > must precede .pad directive
> > > >                 "stmdb  sp!, {r0 - r11}         \n\t"
> > > >                                                   ^
> > > > <inline asm>:6:2: note: instantiated into assembly here
> > > >         .pad    #52
> > > >         ^
> > > > 2 errors generated.
> > > > make[5]: *** [/builds/linux/scripts/Makefile.build:250:
> > > > arch/arm/probes/kprobes/core.o] Error 1
> > > >
> > > > build log:
> > > > https://builds.tuxbuild.com/2FAyD1qcTlzjIYE7mjrugjCsxu1/
> > >
> > > Thank you for the testing and report! I brought this up on GitHub on
> > > Friday as I noticed this as well:
> > >
> > > https://github.com/ClangBuiltLinux/linux/issues/1718
> 
> Thanks for the reports. I'll take a look at filing additional bug
> reports against clang, then moving the definition of
> __kretprobe_trampoline to out of line assembler.

Are you saying that .save should be accepted without a .fnstart?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
