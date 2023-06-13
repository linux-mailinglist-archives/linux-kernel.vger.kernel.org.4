Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C2872D8A0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239790AbjFMEbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239712AbjFMEbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:31:20 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5564692
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 21:28:12 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-463992996d2so1507479e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 21:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686630489; x=1689222489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtvRhJQcBdvD2ySCrR+TDi7rLdn+h5BLqKIPCbTJ4Gg=;
        b=TxUTyplO+8yHlypDm+yZQ5KBsNgWYPhgKx80eDkfMTZ9T0BBSiJrPvfXVn/aHCHWPt
         Ny3RJFahwaziSLZJDhyKiDa0vQVSgPbv3eJeay4Qq9bpaYurRBnhwzRbkNRUWZysb1nN
         aiKTOSj64Imf7vAIvWAaL6sUoUfZa8Arzw2Ft+6ULI+BgmHT7sFR9gLhP51enI4jX6RU
         eZIftV7dquaD+hk5hzku0T+Mc5wEBai3uLiit7Z6TahDYNfT4FS2Fg4duxG5/BTcrZW0
         4TR+NppD/tgBnY885wDTap/vrDwWEjCOmxC+prOcu+eVxznj/0/2F/02tsveSnWJNyWn
         LOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686630489; x=1689222489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtvRhJQcBdvD2ySCrR+TDi7rLdn+h5BLqKIPCbTJ4Gg=;
        b=FpK3GxSpG2fCdlRVPkb/sQf8orUAtv8D9f9I7tRf282/hO68SsSUyuuCthgEBBUyr5
         ph1QrMhxZCsu9+nA+88kKhAIqhUSC1AAsg7pvgecIMOpOPZS8da6+6DhiIK20H0OKTmT
         1OVEZL0OuSzoh8/wCpvFHmfDUm+BwVeRTPkyWana3/Zzto3zI3j3AYomJaGLJJCgHMY5
         Yhi7UlFamRR4/ZJADnz7+cPSb8ghP8BZepOdB6ubdV/P8sHIreiqaZX9kiFyjvv9As2C
         rCmAjX5MTIyjKYhlHeCT0VBLMRxph9mgVBBMmMUFnXnEs59mxdMZAj6D7DseOLQvPJOI
         1ZWA==
X-Gm-Message-State: AC+VfDz+sa0Q8AxGY3OPFmcmSxYU7+FBwfLJrMVL9jHzDwqNrBY/eisF
        7XikGWrSv21+gn2lF9rfUgmprPwlMJyyjpuGaHSNGw==
X-Google-Smtp-Source: ACHHUZ7jNzvzbiJyVqeySaH59vczaM9uJTK1noO4BXwTe2X6N7G9XCCuLCohZ8Z1fjLRrnX9YVnHrZ2Pzb80HwgVz4U=
X-Received: by 2002:a1f:604c:0:b0:453:4cf2:780f with SMTP id
 u73-20020a1f604c000000b004534cf2780fmr4713918vkb.3.1686630488821; Mon, 12 Jun
 2023 21:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsJq0sPC+q6vLNKUgBqCGmmjDrfeP4R1-95Eu28FJRY_A@mail.gmail.com>
 <20230612185424.GA2891387@dev-arch.thelio-3990X>
In-Reply-To: <20230612185424.GA2891387@dev-arch.thelio-3990X>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 13 Jun 2023 09:57:57 +0530
Message-ID: <CA+G9fYtX6YNqmz9vxJxa5cA5Uf2rr=RNM0nkoTzRpg79Azp2tA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_clang=3A_Powerpc=3A_clang=2Dnightly=2Dmaple=5Fdefconfig_?=
        =?UTF-8?Q?=E2=80=94_FAIL?=
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     clang-built-linux <llvm@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On Tue, 13 Jun 2023 at 00:24, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi Naresh,
>
> On Tue, Jun 13, 2023 at 12:10:30AM +0530, Naresh Kamboju wrote:
> > [Please ignore if it is already reported]
> >
> > Following two builds failed on stable-rc 6.1.34-rc1.
> >
> >   - Powerpc: clang-nightly-maple_defconfig =E2=80=94 FAIL
> >   - Powerpc: clang-nightly-cell_defconfig =E2=80=94 FAIL
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > make --silent --keep-going --jobs=3D8
> > O=3D/home/tuxbuild/.cache/tuxmake/builds/1/build ARCH=3Dpowerpc
> > CROSS_COMPILE=3Dpowerpc64le-linux-gnu- HOSTCC=3Dclang CC=3Dclang LLVM=
=3D1
> > LLVM_IAS=3D0 LD=3Dpowerpc64le-linux-gnu-ld
> >
> > arch/powerpc/lib/copypage_power7.S: Assembler messages:
> > arch/powerpc/lib/copypage_power7.S:34: Error: junk at end of line: `0b0=
1000'
> > arch/powerpc/lib/copypage_power7.S:35: Error: junk at end of line: `0b0=
1010'
> > arch/powerpc/lib/copypage_power7.S:37: Error: junk at end of line: `0b0=
1000'
> > arch/powerpc/lib/copypage_power7.S:38: Error: junk at end of line: `0b0=
1010'
> > arch/powerpc/lib/copypage_power7.S:40: Error: junk at end of line: `0b0=
1010'
> > clang: error: assembler command failed with exit code 1 (use -v to see
> > invocation)
> > make[4]: *** [scripts/Makefile.build:382:
> > arch/powerpc/lib/copypage_power7.o] Error 1
> > make[4]: Target 'arch/powerpc/lib/' not remade because of errors.
> > make[3]: *** [scripts/Makefile.build:500: arch/powerpc/lib] Error 2
> > arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
> > arch/powerpc/kernel/exceptions-64s.S:2959: Error: junk at end of line: =
`0b01010'
> > arch/powerpc/kernel/exceptions-64s.S:2979: Error: junk at end of line: =
`0b01010'
> > arch/powerpc/kernel/exceptions-64s.S:2994: Error: junk at end of line: =
`0b01010'
> > arch/powerpc/kernel/exceptions-64s.S:3012: Error: junk at end of line: =
`0b01010'
> > arch/powerpc/kernel/exceptions-64s.S:3032: Error: junk at end of line: =
`0b01010'
> > arch/powerpc/kernel/exceptions-64s.S:3079: Error: junk at end of line: =
`0b01010'
> > clang: error: assembler command failed with exit code 1 (use -v to see
> > invocation)
> > make[4]: *** [scripts/Makefile.build:382: arch/powerpc/kernel/head_64.o=
] Error 1
> > arch/powerpc/kernel/entry_64.S: Assembler messages:
> > arch/powerpc/kernel/entry_64.S:172: Error: junk at end of line: `0b0101=
0'
> > clang: error: assembler command failed with exit code 1 (use -v to see
> > invocation)
> > make[4]: *** [scripts/Makefile.build:382:
> > arch/powerpc/kernel/entry_64.o] Error 1
> > make[4]: Target 'arch/powerpc/kernel/' not remade because of errors.
> > make[3]: *** [scripts/Makefile.build:500: arch/powerpc/kernel] Error 2
> > make[3]: Target 'arch/powerpc/' not remade because of errors.
> > make[2]: *** [scripts/Makefile.build:500: arch/powerpc] Error 2
> > make[2]: Target './' not remade because of errors.
> > make[1]: *** [Makefile:2012: .] Error 2
> > make[1]: Target '__all' not remade because of errors.
> > make: *** [Makefile:238: __sub-make] Error 2
> > make: Target '__all' not remade because of errors.
>
> As always, thanks for the report. This is an LLVM regression/change in
> behavior caused by [1], which can break as-option and as-instr on
> releases prior to commit d5c8d6e0fa61 ("kbuild: Update assembler calls
> to use proper flags and language target"), as unsupported flags for the
> current target ('-x') may be present (KBUILD_CFLAGS is used for these
> tests instead of KBUILD_AFLAGS). Inside try-run, the macro behind
> as-instr and as-option, I see
>
>   clang-17: error: unsupported option '-mno-prefixed' for target 'powerpc=
64le-linux-gnu'
>   clang-17: error: unsupported option '-mno-pcrel' for target 'powerpc64l=
e-linux-gnu'
>   clang-17: error: unsupported option '-mno-altivec' for target 'powerpc6=
4le-linux-gnu'
>   clang-17: error: unsupported option '-mno-vsx' for target 'powerpc64le-=
linux-gnu'
>   clang-17: error: unsupported option '-mno-mma' for target 'powerpc64le-=
linux-gnu'
>   clang-17: error: unsupported option '-mno-spe' for target 'powerpc64le-=
linux-gnu'
>
> This has come up recently elsewhere in PowerPC, see
> commit 2b694fc96fe3 ("powerpc/boot: Disable power10 features after
> BOOTAFLAGS assignment"). While I think it is dubious that clang errors
> on these flags for the assembler target, this is already fixed on the
> Linux side by using KBUILD_AFLAGS for these make macros.
>
> I am preparing a series of d5c8d6e0fa61 and its dependencies for 6.1 but
> I want to do sufficient build testing first, which is currently running
> for me. Would you be able to point your matrix to [2] to make sure
> everything works properly with both GCC and LLVM? It is a work in
> progress as the second patch in the stack needs a proper commit message
> but it is the diff I expect to ship so that it all that matters.

We'll start building [2] with GCC and LLVM by using tuxplans and
get back to you.

>
> [1]: https://github.com/llvm/llvm-project/commit/5548843d692a92a7840f1400=
2debc3cebcb3cdc3
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/nathan/linux.git/log=
/?h=3Dwip/b4/6-1-asssembler-target-llvm-17
>
> Cheers,
> Nathan

- Naresh
