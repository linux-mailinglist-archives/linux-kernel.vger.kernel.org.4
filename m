Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517D768A10A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 18:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjBCR64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 12:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjBCR6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 12:58:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F75D903E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 09:58:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8027B82B65
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 17:58:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B326C433D2;
        Fri,  3 Feb 2023 17:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675447129;
        bh=h0FX8njn5v6dhV2AUGOJNYLtMQEKPbwS8wqqRVOBFXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YccVIaj7oaIBJXC0g+3yS+sil13YXsVVAYIp9f2Bd0HIyWQHX8pkeeGpE5yqISmpQ
         NWyJWS3MfXIHCRUP7hmOBWXl4yGXJ1XQ3tbtpljGE90J7SeLIH0T+A9gnLj8Dvy7ID
         QeOIrs1upGpfj1NDWWvM+SAJdlsTtMmSNb4rEdnVKy9aPjTEvGKwZFOk5zQfpzJcLP
         uCZ2RaQ522dlqarGF87ZXl0KEpxyJusSK3SG9DZRRUGCk7Ce/tU6sWdahxYzt+/oAq
         z983AnRaVXjiOhOF8Zn2cWO+x/IX6Hum3xScZdy8wtSLqtmb/VsG62YKforEDlbKt5
         k91fom1q1q9ew==
Received: by pali.im (Postfix)
        id 4F160723; Fri,  3 Feb 2023 18:58:46 +0100 (CET)
Date:   Fri, 3 Feb 2023 18:58:46 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "anders.roxell@linaro.org" <anders.roxell@linaro.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "nathan@kernel.org" <nathan@kernel.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        qiongsiwu@gmail.com, nemanja.i.ibm@gmail.com
Subject: Re: [PATCH 1/2] powerpc/64: Set default CPU in Kconfig
Message-ID: <20230203175846.oczctwfr2jq7usze@pali>
References: <76c11197b058193dcb8e8b26adffba09cfbdab11.1674632329.git.christophe.leroy@csgroup.eu>
 <20230201113155.18113-1-naresh.kamboju@linaro.org>
 <04b55866-aa17-f500-855a-7d4fb4bbaacf@csgroup.eu>
 <CAKwvOdnc_ggT_2FQQwq71PiDE_D1xxXXnB5iSWvvoa3pu7kMdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdnc_ggT_2FQQwq71PiDE_D1xxXXnB5iSWvvoa3pu7kMdQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 February 2023 09:29:45 Nick Desaulniers wrote:
> On Wed, Feb 1, 2023 at 3:41 AM Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
> >
> >
> >
> > Le 01/02/2023 à 12:31, Naresh Kamboju a écrit :
> > > Following build regression started from next-20230131.
> > >
> > > Regressions found on powerpc:
> > >
> > >    build/clang-nightly-tqm8xx_defconfig
> > >    build/clang-nightly-ppc64e_defconfig
> > >
> > >
> > > make --silent --keep-going --jobs=8 O=/home/tuxbuild/.cache/tuxmake/builds/1/build ARCH=powerpc CROSS_COMPILE=powerpc64le-linux-gnu- HOSTCC=clang CC=clang LLVM=1 LLVM_IAS=0 tqm8xx_defconfig
> > > make --silent --keep-going --jobs=8 O=/home/tuxbuild/.cache/tuxmake/builds/1/build ARCH=powerpc CROSS_COMPILE=powerpc64le-linux-gnu- HOSTCC=clang CC=clang LLVM=1 LLVM_IAS=0
> > >
> > > error: unknown target CPU '860'
> > > note: valid target CPU values are: generic, 440, 450, 601, 602, 603, 603e, 603ev, 604, 604e, 620, 630, g3, 7400, g4, 7450, g4+, 750, 8548, 970, g5, a2, e500, e500mc, e5500, power3, pwr3, power4, pwr4, power5, pwr5, power5x, pwr5x, power6, pwr6, power6x, pwr6x, power7, pwr7, power8, pwr8, power9, pwr9, power10, pwr10, powerpc, ppc, ppc32, powerpc64, ppc64, powerpc64le, ppc64le, future
> > > make[2]: *** [/builds/linux/scripts/Makefile.build:114: scripts/mod/devicetable-offsets.s] Error 1
> > > error: unknown target CPU '860'
> > > note: valid target CPU values are: generic, 440, 450, 601, 602, 603, 603e, 603ev, 604, 604e, 620, 630, g3, 7400, g4, 7450, g4+, 750, 8548, 970, g5, a2, e500, e500mc, e5500, power3, pwr3, power4, pwr4, power5, pwr5, power5x, pwr5x, power6, pwr6, power6x, pwr6x, power7, pwr7, power8, pwr8, power9, pwr9, power10, pwr10, powerpc, ppc, ppc32, powerpc64, ppc64, powerpc64le, ppc64le, future
> > > make[2]: *** [/builds/linux/scripts/Makefile.build:252: scripts/mod/empty.o] Error 1
> >
> >
> > On GCC, the possible values are:
> >
> > ppc-linux-gcc: note : valid arguments to ‘-mcpu=’ are: 401 403 405 405fp
> > 440 440fp 464 464fp 476 476fp 505 601 602 603 603e 604 604e 620 630 740
> > 7400 7450 750 801 821 823 8540 8548 860 970 G3 G4 G5 a2 cell e300c2
> > e300c3 e500mc e500mc64 e5500 e6500 ec603e native power3 power4 power5
> > power5+ power6 power6x power7 power8 powerpc powerpc64 powerpc64le rs64
> > titan
> >
> > How do you tell CLANG that you are building for powerpc 8xx ?

Maybe llvm does not have support for this old CPU core at all? Because
from 'note: valid target CPU values are:' message it looks like that.

> + Nemanjai, Qiongsi,
> 
> 
> >
> > >
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
> > > https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230201/testrun/14479384/suite/build/test/clang-nightly-tqm8xx_defconfig/history/
> > >
> > > The bisection pointed to this commit,
> > >    45f7091aac35 ("powerpc/64: Set default CPU in Kconfig")
> > >
> > > --
> > > Linaro LKFT
> > > https://lkft.linaro.org
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
