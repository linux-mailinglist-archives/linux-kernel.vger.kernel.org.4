Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8847A6002D8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 20:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJPSXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 14:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiJPSXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 14:23:05 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0941A45F78;
        Sun, 16 Oct 2022 11:23:02 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 101-20020a9d0bee000000b00661b54d945fso4662761oth.13;
        Sun, 16 Oct 2022 11:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wW7XFUIrfwAYj9V0BgTRJZPYfpuX+5gjcsBRlqmRR3c=;
        b=JU3t4HRNM+9S9D0rHT+rK3o8ST81UnTQgBfh8fVYH3zJRD9lc2nScx9TUwfInn/Y8i
         rnwHf6LF7QiRhuKpEdiq2XMqHTQzkvUVNdQKsje4bUd1cvetdei5A8y8Avo9o3m6I9Je
         BVYCV8JMV62C1iAIhA0KspdlrHtyJW7XZwfkKCsnnY7KVg5AZKfBKd1ihwpDc/bCa7Nv
         wujlkxtEdHTXvFTIpi66WVhuwukKYgdonQuNuDsbwxcL5MYZVrbsBH78EOpx/mdO2lhS
         PWZFiuBx25QPV+ICluSljA3OV1Rbk9qkr43mjUusVk64uX6LlDq0As0Hoz6yguuboBfm
         TJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wW7XFUIrfwAYj9V0BgTRJZPYfpuX+5gjcsBRlqmRR3c=;
        b=WmxkUxlnwHMra+5eRg09eSr2yhv3+u5PVmqoZYy4QX/EJxRsMq7fNLmNgum8lQgY3E
         OEnsKKftFlTQQtV8HC9XRts24j4Zj6GvmoA/O8IRW9d5oI3dmGP4PxA1gTomwpgwcJ7R
         rm1/IC8SLlfzd15cxSbqoYvSp31eAZYFcYiF+hiO+XA0N7YE/F/Ku5uq/lA9XEUx/WiI
         jZvQ7KpYG7wCN1ozy+rs7wOULyJ3YP7qFmH1Luf0WnrTLtZHPc6aHeaJ9FqRuyood5GB
         8UO/Uvt9GwICJm6B6Q5mwCIosiZzHmGmDc1vPplhIMWkXwkVTuW7TUpSk4Vg2l9QmPfF
         a+Og==
X-Gm-Message-State: ACrzQf1WjqUITwTYmTl5iXRDiYQbetnBubol0PjbejEbBkS2LXzI8/tl
        K+rmfCNwNpHfh6BkAGjZ/Dz3/8zF6EsjldJZbo4=
X-Google-Smtp-Source: AMsMyM4nQJlVhF5jmHJN1j7Nm7J+AvU6gMopIMylRr6DV6jrnlnjX8VOMlWRdql4oP0xaM689bT/msJw+xzE7e0xOuk=
X-Received: by 2002:a05:6830:141:b0:661:acd7:de with SMTP id
 j1-20020a056830014100b00661acd700demr3651892otp.367.1665944581210; Sun, 16
 Oct 2022 11:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20221014204210.383380-1-nathan@kernel.org> <CAKwvOdmvqoO1220ac7RVbVzvmbJB0wYq5WOfuz=T8hd+CkijBg@mail.gmail.com>
 <CAK7LNAQvpSFUiX9=92UnoZpJs=uzaZqpGG-r1dyeWsRXpS5fmw@mail.gmail.com>
 <CA+icZUWfB1pxTFc2VX4_J2dqZZkZ=raC=EVKuPDP0EdBy777OQ@mail.gmail.com> <Y0xLdOM0TAbcJHop@spud>
In-Reply-To: <Y0xLdOM0TAbcJHop@spud>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 16 Oct 2022 20:22:24 +0200
Message-ID: <CA+icZUWj52mQcQeSqCiD_DXrrj9YCLYfdNqvDpPMAF3s_6TMcw@mail.gmail.com>
Subject: Re: [PATCH v2] lib/Kconfig.debug: Add check for non-constant
 .{s,u}leb128 support to DWARF5
To:     Conor Dooley <conor@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Rix <trix@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        linux-kbuild@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022 at 8:20 PM Conor Dooley <conor@kernel.org> wrote:
>
> On Sun, Oct 16, 2022 at 08:10:30PM +0200, Sedat Dilek wrote:
> > On Sun, Oct 16, 2022 at 8:04 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > On Sat, Oct 15, 2022 at 6:52 AM Nick Desaulniers
> > > <ndesaulniers@google.com> wrote:
> > > >
> > > > On Fri, Oct 14, 2022 at 1:48 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > > > >
> > > > > When building with a RISC-V kernel with DWARF5 debug info using clang
> > > > > and the GNU assembler, several instances of the following error appear:
> > > > >
> > > > >   /tmp/vgettimeofday-48aa35.s:2963: Error: non-constant .uleb128 is not supported
> > > > >
> > > > > Dumping the .s file reveals these .uleb128 directives come from
> > > > > .debug_loc and .debug_ranges:
> > > > >
> > > > >   .Ldebug_loc0:
> > > > >           .byte   4                               # DW_LLE_offset_pair
> > > > >           .uleb128 .Lfunc_begin0-.Lfunc_begin0    #   starting offset
> > > > >           .uleb128 .Ltmp1-.Lfunc_begin0           #   ending offset
> > > > >           .byte   1                               # Loc expr size
> > > > >           .byte   90                              # DW_OP_reg10
> > > > >           .byte   0                               # DW_LLE_end_of_list
> > > > >
> > > > >   .Ldebug_ranges0:
> > > > >           .byte   4                               # DW_RLE_offset_pair
> > > > >           .uleb128 .Ltmp6-.Lfunc_begin0           #   starting offset
> > > > >           .uleb128 .Ltmp27-.Lfunc_begin0          #   ending offset
> > > > >           .byte   4                               # DW_RLE_offset_pair
> > > > >           .uleb128 .Ltmp28-.Lfunc_begin0          #   starting offset
> > > > >           .uleb128 .Ltmp30-.Lfunc_begin0          #   ending offset
> > > > >           .byte   0                               # DW_RLE_end_of_list
> > > > >
> > > > > There is an outstanding binutils issue to support a non-constant operand
> > > > > to .sleb128 and .uleb128 in GAS for RISC-V but there does not appear to
> > > > > be any movement on it, due to concerns over how it would work with
> > > > > linker relaxation.
> > > > >
> > > > > To avoid these build errors, prevent DWARF5 from being selected when
> > > > > using clang and an assembler that does not have support for these symbol
> > > > > deltas, which can be easily checked in Kconfig with as-instr plus the
> > > > > small test program from the dwz test suite from the binutils issue.
> > > > >
> > > > > Link: https://sourceware.org/bugzilla/show_bug.cgi?id=27215
> > > > > Link: https://github.com/ClangBuiltLinux/linux/issues/1719
> > > > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > > >
> > > > Thanks for keeping these LLVM_IAS=0 builds alive a little longer.  My
> > > > hope is the GNU binutils can relax their requirement for debug info
> > > > sections to improve support for DWARF v5.
> > > >
> > > > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > >
> > >
> > > Applied to linux-kbuild.
> > > Thanks.
> > >
> >
> > [1] says:
> >
> > "This looks good to me! Feel free to submit with a:
> > Tested-by: Conor Dooley <conor.dooley@microchip.com>"
>
> Hey Sedat,
>
> I actually didn't take a proper look at the v2 at all... I didn't realise
> that Nathan dropped by T-b for v2 since he'd changed the patch enough to
> feel that he should.
>
> I'm not too worried about the removed T-b (espcially since Linus has
> just merged Masahiro's PR containing this change).
>
> Thanks though!
> Conor.
>

Yes, just saw the update on
https://github.com/torvalds/linux/commits/master first.

-Sedat-

> >
> > -sed@-
> >
> > [1] https://github.com/ClangBuiltLinux/linux/issues/1719#issuecomment-1261158627
> >
> > >
> > >
> > > > > ---
> > > > >
> > > > > v2:
> > > > >     - Rebase on commit bb1435f3f575 ("Kconfig.debug: add toolchain
> > > > >       checks for DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT") from the kbuild
> > > > >       tree.
> > > > >     - Limit CONFIG_AS_HAS_NON_CONST_LEB128 dependency to GNU as. There
> > > > >       is no point to applying this dependency to the integrated
> > > > >       assembler because it will always pass.
> > > > >     - Apply the CONFIG_AS_HAS_NON_CONST_LEB128 dependency to
> > > > >       CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT as well, due to the
> > > > >       aforementioned kbuild change.
> > > > >     - Move comment block to above CONFIG_AS_HAS_NON_CONST_LEB128, as the
> > > > >       configuration is now used in two places.
> > > > >     - Drop Conor's tested by, as the patch is different enough to
> > > > >       potentially require new testing.
> > > > >
> > > > > v1: https://lore.kernel.org/20220928182523.3105953-1-nathan@kernel.org/
> > > > >
> > > > >  lib/Kconfig.debug | 9 +++++++--
> > > > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > > > index db8d9271cabf..5c1c63575895 100644
> > > > > --- a/lib/Kconfig.debug
> > > > > +++ b/lib/Kconfig.debug
> > > > > @@ -231,6 +231,11 @@ config DEBUG_INFO
> > > > >           in the "Debug information" choice below, indicating that debug
> > > > >           information will be generated for build targets.
> > > > >
> > > > > +# Clang is known to generate .{s,u}leb128 with symbol deltas with DWARF5, which
> > > > > +# some targets may not support: https://sourceware.org/bugzilla/show_bug.cgi?id=27215
> > > > > +config AS_HAS_NON_CONST_LEB128
> > > > > +       def_bool $(as-instr,.uleb128 .Lexpr_end4 - .Lexpr_start3\n.Lexpr_start3:\n.Lexpr_end4:)
> > > > > +
> > > > >  choice
> > > > >         prompt "Debug information"
> > > > >         depends on DEBUG_KERNEL
> > > > > @@ -253,7 +258,7 @@ config DEBUG_INFO_NONE
> > > > >  config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
> > > > >         bool "Rely on the toolchain's implicit default DWARF version"
> > > > >         select DEBUG_INFO
> > > > > -       depends on !CC_IS_CLANG || AS_IS_LLVM || CLANG_VERSION < 140000 || (AS_IS_GNU && AS_VERSION >= 23502)
> > > > > +       depends on !CC_IS_CLANG || AS_IS_LLVM || CLANG_VERSION < 140000 || (AS_IS_GNU && AS_VERSION >= 23502 && AS_HAS_NON_CONST_LEB128)
> > > > >         help
> > > > >           The implicit default version of DWARF debug info produced by a
> > > > >           toolchain changes over time.
> > > > > @@ -277,7 +282,7 @@ config DEBUG_INFO_DWARF4
> > > > >  config DEBUG_INFO_DWARF5
> > > > >         bool "Generate DWARF Version 5 debuginfo"
> > > > >         select DEBUG_INFO
> > > > > -       depends on !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)
> > > > > +       depends on !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502 && AS_HAS_NON_CONST_LEB128)
> > > > >         help
> > > > >           Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
> > > > >           5.0+ accepts the -gdwarf-5 flag but only had partial support for some
> > > > >
> > > > > base-commit: bb1435f3f575b5213eaf27434efa3971f51c01de
> > > > > --
> > > > > 2.38.0
> > > > >
> > > >
> > > >
> > > > --
> > > > Thanks,
> > > > ~Nick Desaulniers
> > >
> > >
> > >
> > > --
> > > Best Regards
> > > Masahiro Yamada
