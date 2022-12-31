Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C30A65A533
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 15:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbiLaO5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 09:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiLaO5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 09:57:35 -0500
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A0A558D;
        Sat, 31 Dec 2022 06:57:32 -0800 (PST)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 2BVEv9mc003442;
        Sat, 31 Dec 2022 23:57:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 2BVEv9mc003442
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1672498630;
        bh=LSGiHg65ifG+RmjaaeVV6Q4NYUPKWN/WkVFe4vplLb4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cTwr8IdXBUzAEgDwSWmjv9gvPE3l1OukBMpzW/AcWilGLdbFVZ6+XYVgAh8vDWFfm
         TK+Vc525N29Ii6c0HJ86txZeXWyS7zrUBj+g/Xe90sBK5fIPvvU2BVEJnJTpZuOsWs
         d3jaxm1a7ji0z3RZxyCH5CNetQS3UCjh0aNHu5V5n0Zyx0oO8OwW24pyEM9kCiD9WY
         ADhvrtBSD5C5HMARaz80fqcIENlnoEZzlQGjhRhapY+urC0C/ef7xLMJQj89XyMCZ4
         s5wzBAqx9KKO/EaqGZ0fAvS2Aor1kAH4YgtyUimOHpJY7U+X29JAbvLVF2yvBOn+we
         mt1sEEtV1O5uQ==
X-Nifty-SrcIP: [209.85.160.51]
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-12c8312131fso27710487fac.4;
        Sat, 31 Dec 2022 06:57:09 -0800 (PST)
X-Gm-Message-State: AFqh2kqRgcxtKjpthNuWqembr5UXn/es/ITw4Hfg+Lm9Fbih8dI13Hts
        98GoPkpG5NsCMenZzRMzyk9OS41KEQPXfPzWHbs=
X-Google-Smtp-Source: AMrXdXs0ztrHKUs6v7D4aVG8Hi0+Of/8FSGQ9UYNv1GI8nMFG2bmiAsYYhyImtgecHymbooNmPPwWWaXlGl5t3FkiB0=
X-Received: by 2002:a05:6870:cc89:b0:150:39e2:c688 with SMTP id
 ot9-20020a056870cc8900b0015039e2c688mr765921oab.287.1672498628907; Sat, 31
 Dec 2022 06:57:08 -0800 (PST)
MIME-Version: 1.0
References: <20221231083028.1635698-1-masahiroy@kernel.org> <CANiq72n3Hs3T5uFXBBCapnopp_EOwkc7n9QVtP3DguEytU9WKg@mail.gmail.com>
In-Reply-To: <CANiq72n3Hs3T5uFXBBCapnopp_EOwkc7n9QVtP3DguEytU9WKg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 31 Dec 2022 23:56:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNARkyqwEf=xte8Q2BjPkkrvO2-c5_6dmrh=MP527TocuLQ@mail.gmail.com>
Message-ID: <CAK7LNARkyqwEf=xte8Q2BjPkkrvO2-c5_6dmrh=MP527TocuLQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rust: move rust/target.json to scripts/
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kbuild@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Borislav Petkov <bp@suse.de>, David Gow <davidgow@google.com>,
        Helge Deller <deller@gmx.de>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 11:25 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sat, Dec 31, 2022 at 9:30 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > scripts/ is a better place to generate files used treewide.
>
> Agreed, and its generator is in `scripts/` already anyway.
>
> > You do not need to add target.json to no-clean-files or MRPROER_FILES.
>
> Maybe adding something like "If moved to `scripts/`, then (...)" would
> make the sentence a bit more clear.


OK, i will rephrase it in v2.


> (Also, typo: `MRPROPER`)
>
> > -$(obj)/core.o: $(RUST_LIB_SRC)/core/src/lib.rs $(obj)/target.json FORCE
> > +$(obj)/core.o: $(RUST_LIB_SRC)/core/src/lib.rs scripts/target.json FORCE
>
> Should this be `$(srctree)/scripts...` for clarity/consistency? (I see
> most instances like that elsewhere too)


No.
scripts/target.json is a generated file.
It is generated in objtree, not in srctree.





> Cheers,
> Miguel



-- 
Best Regards
Masahiro Yamada
