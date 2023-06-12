Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077AD72CEC4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbjFLSya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFLSy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:54:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53744189;
        Mon, 12 Jun 2023 11:54:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC54E620E6;
        Mon, 12 Jun 2023 18:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B808DC433EF;
        Mon, 12 Jun 2023 18:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686596066;
        bh=/Ri1xyOerdimybY5WnwGgxuj7fv7VGFmjAE4nT3rS6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SJSh/vuWkOaDMgV+aJhtgMUtUkZlKSJ207YLgw2MMqinW9+Ax7JBbNJB0TEh3zpKQ
         TPtoFVa4YCcif6L2dfpF8lWIVtT4JVDS9sP5m9y4sdnDpGSPC2IqzSNy4EZ7wTGjlO
         gMz9V6BXA1aAuXg9irzuu2u1SmvTjFOTTEKEkUhUDynk5cB2V0h9hIeq2L7RV9heDN
         9ZKg5RjNKH1YsoxU0OUdMnELVNDidzZurCRd4lxYXC0yfhZP3WXOPRFVd9yK5eUWCV
         01Fq4dfxwyi6SHbneeufQNKJ5CHfd8IlA73levP3Pxwyyi3zcTZ4y85VyVWR0dvDtl
         xkO5n2Izn2kDA==
Date:   Mon, 12 Jun 2023 11:54:24 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     clang-built-linux <llvm@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: clang: Powerpc: =?utf-8?Q?clang-nightl?=
 =?utf-8?B?eS1tYXBsZV9kZWZjb25maWcg4oCU?= FAIL
Message-ID: <20230612185424.GA2891387@dev-arch.thelio-3990X>
References: <CA+G9fYsJq0sPC+q6vLNKUgBqCGmmjDrfeP4R1-95Eu28FJRY_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYsJq0sPC+q6vLNKUgBqCGmmjDrfeP4R1-95Eu28FJRY_A@mail.gmail.com>
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

On Tue, Jun 13, 2023 at 12:10:30AM +0530, Naresh Kamboju wrote:
> [Please ignore if it is already reported]
> 
> Following two builds failed on stable-rc 6.1.34-rc1.
> 
>   - Powerpc: clang-nightly-maple_defconfig — FAIL
>   - Powerpc: clang-nightly-cell_defconfig — FAIL
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> make --silent --keep-going --jobs=8
> O=/home/tuxbuild/.cache/tuxmake/builds/1/build ARCH=powerpc
> CROSS_COMPILE=powerpc64le-linux-gnu- HOSTCC=clang CC=clang LLVM=1
> LLVM_IAS=0 LD=powerpc64le-linux-gnu-ld
> 
> arch/powerpc/lib/copypage_power7.S: Assembler messages:
> arch/powerpc/lib/copypage_power7.S:34: Error: junk at end of line: `0b01000'
> arch/powerpc/lib/copypage_power7.S:35: Error: junk at end of line: `0b01010'
> arch/powerpc/lib/copypage_power7.S:37: Error: junk at end of line: `0b01000'
> arch/powerpc/lib/copypage_power7.S:38: Error: junk at end of line: `0b01010'
> arch/powerpc/lib/copypage_power7.S:40: Error: junk at end of line: `0b01010'
> clang: error: assembler command failed with exit code 1 (use -v to see
> invocation)
> make[4]: *** [scripts/Makefile.build:382:
> arch/powerpc/lib/copypage_power7.o] Error 1
> make[4]: Target 'arch/powerpc/lib/' not remade because of errors.
> make[3]: *** [scripts/Makefile.build:500: arch/powerpc/lib] Error 2
> arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
> arch/powerpc/kernel/exceptions-64s.S:2959: Error: junk at end of line: `0b01010'
> arch/powerpc/kernel/exceptions-64s.S:2979: Error: junk at end of line: `0b01010'
> arch/powerpc/kernel/exceptions-64s.S:2994: Error: junk at end of line: `0b01010'
> arch/powerpc/kernel/exceptions-64s.S:3012: Error: junk at end of line: `0b01010'
> arch/powerpc/kernel/exceptions-64s.S:3032: Error: junk at end of line: `0b01010'
> arch/powerpc/kernel/exceptions-64s.S:3079: Error: junk at end of line: `0b01010'
> clang: error: assembler command failed with exit code 1 (use -v to see
> invocation)
> make[4]: *** [scripts/Makefile.build:382: arch/powerpc/kernel/head_64.o] Error 1
> arch/powerpc/kernel/entry_64.S: Assembler messages:
> arch/powerpc/kernel/entry_64.S:172: Error: junk at end of line: `0b01010'
> clang: error: assembler command failed with exit code 1 (use -v to see
> invocation)
> make[4]: *** [scripts/Makefile.build:382:
> arch/powerpc/kernel/entry_64.o] Error 1
> make[4]: Target 'arch/powerpc/kernel/' not remade because of errors.
> make[3]: *** [scripts/Makefile.build:500: arch/powerpc/kernel] Error 2
> make[3]: Target 'arch/powerpc/' not remade because of errors.
> make[2]: *** [scripts/Makefile.build:500: arch/powerpc] Error 2
> make[2]: Target './' not remade because of errors.
> make[1]: *** [Makefile:2012: .] Error 2
> make[1]: Target '__all' not remade because of errors.
> make: *** [Makefile:238: __sub-make] Error 2
> make: Target '__all' not remade because of errors.

As always, thanks for the report. This is an LLVM regression/change in
behavior caused by [1], which can break as-option and as-instr on
releases prior to commit d5c8d6e0fa61 ("kbuild: Update assembler calls
to use proper flags and language target"), as unsupported flags for the
current target ('-x') may be present (KBUILD_CFLAGS is used for these
tests instead of KBUILD_AFLAGS). Inside try-run, the macro behind
as-instr and as-option, I see

  clang-17: error: unsupported option '-mno-prefixed' for target 'powerpc64le-linux-gnu'
  clang-17: error: unsupported option '-mno-pcrel' for target 'powerpc64le-linux-gnu'
  clang-17: error: unsupported option '-mno-altivec' for target 'powerpc64le-linux-gnu'
  clang-17: error: unsupported option '-mno-vsx' for target 'powerpc64le-linux-gnu'
  clang-17: error: unsupported option '-mno-mma' for target 'powerpc64le-linux-gnu'
  clang-17: error: unsupported option '-mno-spe' for target 'powerpc64le-linux-gnu'

This has come up recently elsewhere in PowerPC, see
commit 2b694fc96fe3 ("powerpc/boot: Disable power10 features after
BOOTAFLAGS assignment"). While I think it is dubious that clang errors
on these flags for the assembler target, this is already fixed on the
Linux side by using KBUILD_AFLAGS for these make macros.

I am preparing a series of d5c8d6e0fa61 and its dependencies for 6.1 but
I want to do sufficient build testing first, which is currently running
for me. Would you be able to point your matrix to [2] to make sure
everything works properly with both GCC and LLVM? It is a work in
progress as the second patch in the stack needs a proper commit message
but it is the diff I expect to ship so that it all that matters.

[1]: https://github.com/llvm/llvm-project/commit/5548843d692a92a7840f14002debc3cebcb3cdc3
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/nathan/linux.git/log/?h=wip/b4/6-1-asssembler-target-llvm-17

Cheers,
Nathan
