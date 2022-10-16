Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B016002BC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 20:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJPSLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 14:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiJPSLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 14:11:08 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F28B1EC50;
        Sun, 16 Oct 2022 11:11:07 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id v40-20020a056830092800b00661e37421c2so2473586ott.3;
        Sun, 16 Oct 2022 11:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2r3mUxfW6g3CVFgzjeCUIRcSV3xp7RfjjaFTPG8jsCg=;
        b=JSWA1iLSFjvHguwGixnihIpyNxhdHQ+UN7cw6UWkT8QK4B90gfR4uIuSq61pLMoNMk
         FKfs++L+jBcHWtEVDep5WC3nw9+LCCfwhl4H/218v0hYI6+QdmykEPybCxCmD067Xmdp
         kiQbVvM4hFddrXI6+hK85nkSRrLMU+hcH09HYdksbVXFKJiBLVwFHzfkBIl4fQ1+gw93
         y42UBycUjH8rNwg5Efk3ghMrj/5h/rc6qrSFbnTu/XK/tVC2YCusu84MKLdNiU0sW16Q
         Fgdd4ggrU6jz1qnxNIHCG0vsZ4RAoh5gLmzE5n8dZKjXE/xhrItrjjerlXHJNWAKJo0Z
         /sVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2r3mUxfW6g3CVFgzjeCUIRcSV3xp7RfjjaFTPG8jsCg=;
        b=z4Azjt+53aMw2VIPdDBxEPAUzqx8SAuHbjiDRr/O+XtQcXfvbZnJvrj/JxWk3dQycT
         DNnNkWxs0GWJ8da/TVqiNoes0VGQKK0fw8c987f3RgZdvD8RtBYiEFwnSibAowSqb+1q
         k3Xve2jOrEcR6PGfLvweVwL8o1VnCwBlclaiqCBQjD4vwaqOLYKwhiBd5r5Sstkbgw1J
         pW3YWFuh67YWxrTEzxBm7t3qoi8tg+QfArWyh4OSgSnhfhFzki6HsFA9EahT8uagzlnO
         zcXhIeIsDmMJjI/H1SJUGczlXNP4dBsO2uTRsT7rrDrZhS5sbwrewxpBt780+aqxmiBQ
         CBrg==
X-Gm-Message-State: ACrzQf239s+JwbYADTLSYf+FwOD2VkPhcD6AMYZ2H3V5Ov7/zMa5xWUb
        89zUNDDb5viEUjgr/OE8WguKyth+ZFxXRJZ+mhg=
X-Google-Smtp-Source: AMsMyM7lm61H+zH9W8dFPLna5u3lsmOviHgfgOMaxA41Ju/lRifw405aHfPjQIfMl1EmlvX6/Uf5LQxlDuQaWhNSZEQ=
X-Received: by 2002:a05:6830:141:b0:661:acd7:de with SMTP id
 j1-20020a056830014100b00661acd700demr3638490otp.367.1665943866596; Sun, 16
 Oct 2022 11:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221014204210.383380-1-nathan@kernel.org> <CAKwvOdmvqoO1220ac7RVbVzvmbJB0wYq5WOfuz=T8hd+CkijBg@mail.gmail.com>
 <CAK7LNAQvpSFUiX9=92UnoZpJs=uzaZqpGG-r1dyeWsRXpS5fmw@mail.gmail.com>
In-Reply-To: <CAK7LNAQvpSFUiX9=92UnoZpJs=uzaZqpGG-r1dyeWsRXpS5fmw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 16 Oct 2022 20:10:30 +0200
Message-ID: <CA+icZUWfB1pxTFc2VX4_J2dqZZkZ=raC=EVKuPDP0EdBy777OQ@mail.gmail.com>
Subject: Re: [PATCH v2] lib/Kconfig.debug: Add check for non-constant
 .{s,u}leb128 support to DWARF5
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Rix <trix@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, llvm@lists.linux.dev
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

On Sun, Oct 16, 2022 at 8:04 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Sat, Oct 15, 2022 at 6:52 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Fri, Oct 14, 2022 at 1:48 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > When building with a RISC-V kernel with DWARF5 debug info using clang
> > > and the GNU assembler, several instances of the following error appear:
> > >
> > >   /tmp/vgettimeofday-48aa35.s:2963: Error: non-constant .uleb128 is not supported
> > >
> > > Dumping the .s file reveals these .uleb128 directives come from
> > > .debug_loc and .debug_ranges:
> > >
> > >   .Ldebug_loc0:
> > >           .byte   4                               # DW_LLE_offset_pair
> > >           .uleb128 .Lfunc_begin0-.Lfunc_begin0    #   starting offset
> > >           .uleb128 .Ltmp1-.Lfunc_begin0           #   ending offset
> > >           .byte   1                               # Loc expr size
> > >           .byte   90                              # DW_OP_reg10
> > >           .byte   0                               # DW_LLE_end_of_list
> > >
> > >   .Ldebug_ranges0:
> > >           .byte   4                               # DW_RLE_offset_pair
> > >           .uleb128 .Ltmp6-.Lfunc_begin0           #   starting offset
> > >           .uleb128 .Ltmp27-.Lfunc_begin0          #   ending offset
> > >           .byte   4                               # DW_RLE_offset_pair
> > >           .uleb128 .Ltmp28-.Lfunc_begin0          #   starting offset
> > >           .uleb128 .Ltmp30-.Lfunc_begin0          #   ending offset
> > >           .byte   0                               # DW_RLE_end_of_list
> > >
> > > There is an outstanding binutils issue to support a non-constant operand
> > > to .sleb128 and .uleb128 in GAS for RISC-V but there does not appear to
> > > be any movement on it, due to concerns over how it would work with
> > > linker relaxation.
> > >
> > > To avoid these build errors, prevent DWARF5 from being selected when
> > > using clang and an assembler that does not have support for these symbol
> > > deltas, which can be easily checked in Kconfig with as-instr plus the
> > > small test program from the dwz test suite from the binutils issue.
> > >
> > > Link: https://sourceware.org/bugzilla/show_bug.cgi?id=27215
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/1719
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> >
> > Thanks for keeping these LLVM_IAS=0 builds alive a little longer.  My
> > hope is the GNU binutils can relax their requirement for debug info
> > sections to improve support for DWARF v5.
> >
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
>
> Applied to linux-kbuild.
> Thanks.
>

[1] says:

"This looks good to me! Feel free to submit with a:
Tested-by: Conor Dooley <conor.dooley@microchip.com>"

-sed@-

[1] https://github.com/ClangBuiltLinux/linux/issues/1719#issuecomment-1261158627

>
>
> > > ---
> > >
> > > v2:
> > >     - Rebase on commit bb1435f3f575 ("Kconfig.debug: add toolchain
> > >       checks for DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT") from the kbuild
> > >       tree.
> > >     - Limit CONFIG_AS_HAS_NON_CONST_LEB128 dependency to GNU as. There
> > >       is no point to applying this dependency to the integrated
> > >       assembler because it will always pass.
> > >     - Apply the CONFIG_AS_HAS_NON_CONST_LEB128 dependency to
> > >       CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT as well, due to the
> > >       aforementioned kbuild change.
> > >     - Move comment block to above CONFIG_AS_HAS_NON_CONST_LEB128, as the
> > >       configuration is now used in two places.
> > >     - Drop Conor's tested by, as the patch is different enough to
> > >       potentially require new testing.
> > >
> > > v1: https://lore.kernel.org/20220928182523.3105953-1-nathan@kernel.org/
> > >
> > >  lib/Kconfig.debug | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > index db8d9271cabf..5c1c63575895 100644
> > > --- a/lib/Kconfig.debug
> > > +++ b/lib/Kconfig.debug
> > > @@ -231,6 +231,11 @@ config DEBUG_INFO
> > >           in the "Debug information" choice below, indicating that debug
> > >           information will be generated for build targets.
> > >
> > > +# Clang is known to generate .{s,u}leb128 with symbol deltas with DWARF5, which
> > > +# some targets may not support: https://sourceware.org/bugzilla/show_bug.cgi?id=27215
> > > +config AS_HAS_NON_CONST_LEB128
> > > +       def_bool $(as-instr,.uleb128 .Lexpr_end4 - .Lexpr_start3\n.Lexpr_start3:\n.Lexpr_end4:)
> > > +
> > >  choice
> > >         prompt "Debug information"
> > >         depends on DEBUG_KERNEL
> > > @@ -253,7 +258,7 @@ config DEBUG_INFO_NONE
> > >  config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
> > >         bool "Rely on the toolchain's implicit default DWARF version"
> > >         select DEBUG_INFO
> > > -       depends on !CC_IS_CLANG || AS_IS_LLVM || CLANG_VERSION < 140000 || (AS_IS_GNU && AS_VERSION >= 23502)
> > > +       depends on !CC_IS_CLANG || AS_IS_LLVM || CLANG_VERSION < 140000 || (AS_IS_GNU && AS_VERSION >= 23502 && AS_HAS_NON_CONST_LEB128)
> > >         help
> > >           The implicit default version of DWARF debug info produced by a
> > >           toolchain changes over time.
> > > @@ -277,7 +282,7 @@ config DEBUG_INFO_DWARF4
> > >  config DEBUG_INFO_DWARF5
> > >         bool "Generate DWARF Version 5 debuginfo"
> > >         select DEBUG_INFO
> > > -       depends on !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)
> > > +       depends on !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502 && AS_HAS_NON_CONST_LEB128)
> > >         help
> > >           Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
> > >           5.0+ accepts the -gdwarf-5 flag but only had partial support for some
> > >
> > > base-commit: bb1435f3f575b5213eaf27434efa3971f51c01de
> > > --
> > > 2.38.0
> > >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
>
>
>
> --
> Best Regards
> Masahiro Yamada
