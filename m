Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4065F1F4D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 22:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJAUWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 16:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiJAUWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 16:22:19 -0400
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6617E3C8C4
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 13:22:18 -0700 (PDT)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 291KLtXX002201
        for <linux-kernel@vger.kernel.org>; Sun, 2 Oct 2022 05:21:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 291KLtXX002201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664655716;
        bh=SW+i6ReFutQDlgRP9JKA8Gsb2IS5t084fIgU24oFml4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Th2agiNE+wdEqrKKJYqgbLDn/X20MSgdokvCmKVQ0+IbLgcfOKJ/HasN4GGzP+nyE
         x25HEHyaNqiYu7a2Fb6moatip7PIuoMI6Pr++ArvY1BSt/g1z3OM0g+bLSv6ErvSAK
         pNyyYKnUrCknnfgwMlmoY60Gt5xjrkGoC8kQq5ie9RAS6xE7G+XOKCtDHmlWxOS/pn
         nXoyhv8ziGEZhMy2gDvbh4uEC5rJzZVyDDW5OKepz0SeGJ33jXE7zAFEvZNynL0NH+
         UBRc2tTSg7+iGeL0Ig+EM/t1sqRts8Z7uMIwT2E5tis9r1kiRNbMHcP86/M7Oh6Efr
         hyNIA9Qt9Qa5A==
X-Nifty-SrcIP: [209.85.160.52]
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1321a1e94b3so3375803fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 13:21:56 -0700 (PDT)
X-Gm-Message-State: ACrzQf2+IaI0ilPSgY5Kq+7UpLxhdmpiTxsGvhTldbeD5Y6HiaTmFgLR
        BeC1LAA7yWwnSGrEmt2jhzMV0UBgwPb2MWjx750=
X-Google-Smtp-Source: AMsMyM4EWmnQBJWNRiDKBHsC95Ev1Y1PHVWeYTE36/yYco3SawdtwJhTzFjybJN2VIdsD/uIrM7I7XAY11gDPBp2JUk=
X-Received: by 2002:a05:6870:c58b:b0:10b:d21d:ad5e with SMTP id
 ba11-20020a056870c58b00b0010bd21dad5emr1885984oab.287.1664655715097; Sat, 01
 Oct 2022 13:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <202210010816.1317F2C@keescook>
In-Reply-To: <202210010816.1317F2C@keescook>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 2 Oct 2022 05:21:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ2xBLG_aSDm64SSYRBOBKwhJnZ6UDg8ycAezATVToFLg@mail.gmail.com>
Message-ID: <CAK7LNAQ2xBLG_aSDm64SSYRBOBKwhJnZ6UDg8ycAezATVToFLg@mail.gmail.com>
Subject: Re: [GIT PULL] Rust introduction for v6.1-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Daniel Xu <dxu@dxuuu.xyz>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        David Gow <davidgow@google.com>,
        Douglas Su <d0u9.su@outlook.com>, Finn Behrens <me@kloenk.de>,
        Fox Chen <foxhlchen@gmail.com>, Gary Guo <gary@garyguo.net>,
        Geert Stappers <stappers@stappers.nl>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Joe Perches <joe@perches.com>,
        John Baublitz <john.m.baublitz@gmail.com>,
        Julian Merkle <me@jvmerkle.de>,
        =?UTF-8?Q?L=C3=A9o_Lanteri_Thauvin?= <leseulartichaut@gmail.com>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Matthew Bakhtiari <dev@mtbk.me>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Cano <macanroj@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Milan Landaverde <milan@mdaverde.com>,
        Morgan Bartlett <mjmouse9999@gmail.com>,
        =?UTF-8?B?TsOhbmRvciBJc3R2w6FuIEtyw6Fjc2Vy?= <bonifaido@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Niklas Mohrin <dev@niklasmohrin.de>,
        Petr Mladek <pmladek@suse.com>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Tiago Lam <tiagolam@gmail.com>,
        Viktor Garske <viktor@v-gar.de>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Wei Liu <wei.liu@kernel.org>, Wu XiangCheng <bobwxc@email.cn>,
        Yuki Okushi <jtitor@2k36.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 2, 2022 at 12:59 AM Kees Cook <keescook@chromium.org> wrote:
>
> Hi Linus,
>
> Please pull the initial Rust support for v6.1-rc1. The tree has a recent
> base, but has fundamentally been in linux-next for a year and a half[1].
> It's been updated based on feedback from the Kernel Maintainer's Summit,
> and to gain recent Reviewed-by: tags. Miguel is the primary maintainer,
> with me helping where needed/wanted. Our plan is for the tree to switch to
> the standard non-rebasing practice once this initial infrastructure series
> lands. The contents are the absolute minimum to get Rust code building
> in the kernel, with many more interfaces[2] (and drivers[3]) on the way.
>
> Expected conflicts are minimal:
> - docs-next: https://lore.kernel.org/lkml/87czbegets.fsf@meer.lwn.net/


Also, conflicts against the Kbuild tree.

linux-next 20220930 fails to build with CONFIG_RUST=y because the merge
conflicts between Kbuild and Rust trees were not correctly resolved.

I will try my best to address merge conflicts when I send my pull request.





--
Best Regards
Masahiro Yamada
