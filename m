Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CE25B6EE0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 16:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbiIMOGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 10:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbiIMOFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 10:05:52 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473B1520BD;
        Tue, 13 Sep 2022 07:05:49 -0700 (PDT)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 28DE5PTr015435;
        Tue, 13 Sep 2022 23:05:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 28DE5PTr015435
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1663077926;
        bh=YeFfqsD1cMM/56dIANPgCUVk9QsCcNwlQvvcGl88Bmo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VurfrffIXsKJXT+A/JCESLYaC4y9WFiO+2KX08ME9nBrFNhS85XRR/29gfjw+Fa0E
         T/e34Jcm+NRe+MM9Bi0jawXBJtqstBy84T4HEuz09mwAuA34v75xBKl4f2FmmJOJFV
         NH/waIUG3T//0JR3+xjgo9BOoEQzLgbN99Rh7MRNBom/Tl+C9aZfy/v5Nh4S1po4b/
         AH6cIWMCr2Pb1mbNn/ZC14PaXGP3fHVDWbrM38UnoeH9yqMRFUDDlGdDLKxBTmXdK/
         KT6p9dX9AluJTH+WBEU7g72rCgxw7FZb87Z0piw7TJ8EPxp8X7Medgw8AR7CtZq4EH
         5zp3NvS+6iwFw==
X-Nifty-SrcIP: [209.85.160.44]
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1278624b7c4so32409941fac.5;
        Tue, 13 Sep 2022 07:05:25 -0700 (PDT)
X-Gm-Message-State: ACgBeo1ued3phsRpXgC2QZ/vz9/bAr66gOaC5UyMvTrKqoJJV6qSQfRZ
        y7SNjNLRq+3AA9J64+j4FpyYxRkkEfvJr6Unk70=
X-Google-Smtp-Source: AA6agR7R++hgoWo7WThcQ9iOPJ7P8NZbGLYTq2wQTuFqtkVYuxGvVglcwUqDg2OyQ11iWrlgREEwz+LOorWIH3dklO8=
X-Received: by 2002:a05:6870:c58b:b0:10b:d21d:ad5e with SMTP id
 ba11-20020a056870c58b00b0010bd21dad5emr1869267oab.287.1663077924765; Tue, 13
 Sep 2022 07:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220913040753.2198-1-xingwu.yang@gmail.com> <YyBSgNbJGRBNIL5I@dev-arch.thelio-3990X>
In-Reply-To: <YyBSgNbJGRBNIL5I@dev-arch.thelio-3990X>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 13 Sep 2022 23:04:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNASNTxtNCjjUEr+oDPLhPgqQet_iWzG0i2-dFBLo8nO+8g@mail.gmail.com>
Message-ID: <CAK7LNASNTxtNCjjUEr+oDPLhPgqQet_iWzG0i2-dFBLo8nO+8g@mail.gmail.com>
Subject: Re: [PATCH] scripts/clang-tools: remove unused module
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     yangxingwu <xingwu.yang@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        clang-built-linux <llvm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 6:50 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Tue, Sep 13, 2022 at 04:07:52AM +0000, yangxingwu wrote:
> > remove unused imported 'os' module
> >
> > Signed-off-by: yangxingwu <xingwu.yang@gmail.com>
>
> Sure.
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> Masahiro, are you able to pick this up? The original was not cc'd to
> linux-kbuild but it is on lore:
>
> https://lore.kernel.org/20220913040753.2198-1-xingwu.yang@gmail.com/


Sure, applied to linux-kbuild. Thanks.


> > ---
> >  scripts/clang-tools/run-clang-tools.py | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-tools/run-clang-tools.py
> > index 1337cedca..bb78c9bde 100755
> > --- a/scripts/clang-tools/run-clang-tools.py
> > +++ b/scripts/clang-tools/run-clang-tools.py
> > @@ -12,7 +12,6 @@ compile_commands.json.
> >  import argparse
> >  import json
> >  import multiprocessing
> > -import os
> >  import subprocess
> >  import sys
> >
> > --
> > 2.37.2
> >



-- 
Best Regards
Masahiro Yamada
