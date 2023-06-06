Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88347247C3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238391AbjFFPb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238320AbjFFPbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:31:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6385E10CB
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 08:31:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAAC663503
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 15:31:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B57C433EF;
        Tue,  6 Jun 2023 15:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686065512;
        bh=24AUyPfBFJqlvaX/w0MXpBX88SvjMMONuaYLEQpGUxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mz37zLzXPEJw+IdodP/nthr7nSGPwX4H+Tz6aijiukT7l20v7vj4a1u9D5t69btMD
         GB8BYSfCGDsFzUutfnho1KFq89x1GTygIwRGOaue15EQMHi9fhKN+SjcjMOcHjLjhn
         +RTTHPdJyQ96kiN4PpHekRvpCsZM1LFUk4ZYc5X/m7QPIrHB+s7LhiDaVyYJsxh8p8
         /SH71JXab9TSeW8OJDTDFDYRT6g9ViFo1gUw+OQv8K7yWiz5zVVepcEdso5a/dc8pd
         jMr0vTS45LlY7SEV25ixmN2FNGmS79OiLNiY7T8db/RuohixBvCRGAyvR3HCk9Wwe8
         OGHabjXV+BzwA==
Date:   Tue, 6 Jun 2023 08:31:50 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        lkft-triage@lists.linaro.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: powerpc: clang: arch/powerpc/kernel/exceptions-64s.S:2976:
 Error: junk at end of line: `0b01010'
Message-ID: <20230606153150.GA128872@dev-arch.thelio-3990X>
References: <CA+G9fYs=koW9WardsTtora+nMgLR3raHz-LSLr58tgX4T5Mxag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYs=koW9WardsTtora+nMgLR3raHz-LSLr58tgX4T5Mxag@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naresh,

On Tue, Jun 06, 2023 at 01:57:46PM +0530, Naresh Kamboju wrote:
> Linux next-20230606 powerpc build failed.
> 
> Regressions found on powerpc:
> 
>  - build/clang-16-maple_defconfig
>  - build/clang-nightly-maple_defconfig
>  - build/clang-16-defconfig
>  - build/clang-nightly-defconfig
>  - build/clang-nightly-cell_defconfig
>  - build/clang-16-cell_defconfig
> 
> Boot:
> =====
> make --silent --keep-going --jobs=8
> O=/home/tuxbuild/.cache/tuxmake/builds/1/build ARCH=powerpc
>  CROSS_COMPILE=powerpc64le-linux-gnu-
>  HOSTCC=clang
>  CC=clang
>  LLVM=1
>  LLVM_IAS=0
>  LD=powerpc64le-linux-gnu-ld
> 
> arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
> arch/powerpc/kernel/exceptions-64s.S:2976: Error: junk at end of line: `0b01010'
> arch/powerpc/kernel/exceptions-64s.S:2996: Error: junk at end of line: `0b01010'
> arch/powerpc/kernel/exceptions-64s.S:3011: Error: junk at end of line: `0b01010'
> arch/powerpc/kernel/exceptions-64s.S:3029: Error: junk at end of line: `0b01010'
> arch/powerpc/kernel/exceptions-64s.S:3049: Error: junk at end of line: `0b01010'
> arch/powerpc/kernel/exceptions-64s.S:3096: Error: junk at end of line: `0b01010'
> clang: error: assembler command failed with exit code 1 (use -v to see
> invocation)
> make[4]: *** [scripts/Makefile.build:374: arch/powerpc/kernel/head_64.o] Error 1
> arch/powerpc/kernel/entry_64.S: Assembler messages:
> arch/powerpc/kernel/entry_64.S:174: Error: junk at end of line: `0b01010'
> clang: error: assembler command failed with exit code 1 (use -v to see
> invocation)
> make[4]: *** [scripts/Makefile.build:374:
> arch/powerpc/kernel/entry_64.o] Error 1
> make[4]: Target 'arch/powerpc/kernel/' not remade because of errors.
> make[3]: *** [scripts/Makefile.build:494: arch/powerpc/kernel] Error 2
> arch/powerpc/lib/copyuser_power7.S: Assembler messages:
> arch/powerpc/lib/copyuser_power7.S:305: Error: junk at end of line: `0b01000'
> arch/powerpc/lib/copyuser_power7.S:306: Error: junk at end of line: `0b01010'
> arch/powerpc/lib/copyuser_power7.S:308: Error: junk at end of line: `0b01000'
> arch/powerpc/lib/copyuser_power7.S:309: Error: junk at end of line: `0b01010'
> arch/powerpc/lib/copyuser_power7.S:311: Error: junk at end of line: `0b01010'
> clang: error: assembler command failed with exit code 1 (use -v to see
> invocation)
> make[4]: *** [scripts/Makefile.build:374:
> arch/powerpc/lib/copyuser_power7.o] Error 1
> arch/powerpc/lib/copypage_power7.S: Assembler messages:
> arch/powerpc/lib/copypage_power7.S:34: Error: junk at end of line: `0b01000'
> arch/powerpc/lib/copypage_power7.S:35: Error: junk at end of line: `0b01010'
> arch/powerpc/lib/copypage_power7.S:37: Error: junk at end of line: `0b01000'
> arch/powerpc/lib/copypage_power7.S:38: Error: junk at end of line: `0b01010'
> arch/powerpc/lib/copypage_power7.S:40: Error: junk at end of line: `0b01010'
> clang: error: assembler command failed with exit code 1 (use -v to see
> invocation)
> make[4]: *** [scripts/Makefile.build:374:
> arch/powerpc/lib/copypage_power7.o] Error 1
> arch/powerpc/lib/memcpy_power7.S: Assembler messages:
> arch/powerpc/lib/memcpy_power7.S:250: Error: junk at end of line: `0b01000'
> arch/powerpc/lib/memcpy_power7.S:251: Error: junk at end of line: `0b01010'
> arch/powerpc/lib/memcpy_power7.S:252: Error: junk at end of line: `0b01000'
> arch/powerpc/lib/memcpy_power7.S:253: Error: junk at end of line: `0b01010'
> arch/powerpc/lib/memcpy_power7.S:255: Error: junk at end of line: `0b01010'
> clang: error: assembler command failed with exit code 1 (use -v to see
> invocation)
> make[4]: *** [scripts/Makefile.build:374:
> arch/powerpc/lib/memcpy_power7.o] Error 1
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Thank you for the report, this is caused by the move of CLANG_FLAGS from
KBUILD_{A,C}FLAGS to KBUILD_CPPFLAGS, as as-option does not contain
KBUILD_CPPFLAGS, so we fail to pass necessary flags to the assembler.
The following diff resolves this particular issue for me, can you test
it to make sure it works for you?  I will write up a changelog and sent
along a formal patch later today.

Cheers,
Nathan

diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
index 437013f8def3..e31f18625fcf 100644
--- a/scripts/Makefile.compiler
+++ b/scripts/Makefile.compiler
@@ -32,7 +32,7 @@ try-run = $(shell set -e;		\
 # Usage: aflags-y += $(call as-option,-Wa$(comma)-isa=foo,)
 
 as-option = $(call try-run,\
-	$(CC) -Werror $(KBUILD_AFLAGS) $(1) -c -x assembler-with-cpp /dev/null -o "$$TMP",$(1),$(2))
+	$(CC) -Werror $(KBUILD_CPPFLAGS) $(KBUILD_AFLAGS) $(1) -c -x assembler-with-cpp /dev/null -o "$$TMP",$(1),$(2))
 
 # as-instr
 # Usage: aflags-y += $(call as-instr,instr,option1,option2)
