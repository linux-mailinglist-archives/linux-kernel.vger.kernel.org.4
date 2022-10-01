Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78305F2085
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 01:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiJAXBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 19:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiJAXBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 19:01:13 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99036A47B
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 16:01:11 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id r134so5809963iod.8
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 16:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=/bebbmbrUZ5PCMyTpqQn7bxSkhNwLXxVw8m0uEuZJzc=;
        b=Q2tHOWt6iRAfZ13NvrEHmW/Agp6tBAoncpfCXaFAM4xQbI6KUp2FPd30ZM+VCWmzFW
         tsbnqcL/Yp1SnhndWNir1ip9XWZSDbSzOGmM3vFJ1O2POn61PYxr/B3YJiiZRDWltOsm
         riNOArkMT9wyBTtI8Wy7bMiKslKmAM+dQ/CpxGLxctQvVdJ/quHvXcKIxHsqpvtZDuJG
         dlPirCI+6Uh8aWkpSenEwPnpo1K8SMvPTiDVfQL8xpgkb6Xr6ZTGs0a6Ajz0z0iy11qN
         h9MPFXhqub1ziSictQpkZyA07KqXpJpQRAfDVTNb073FqF2jWrqckhbe7c3Mdy1qEvb8
         SgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=/bebbmbrUZ5PCMyTpqQn7bxSkhNwLXxVw8m0uEuZJzc=;
        b=dzq6Wjueue5v5w+iYcVZ3AepsQFk8IjrcQjBX73gnpU9vXngDgpVtMPvrc/hKUICDU
         U6rLT9w0xpc2Axs0lES007mqGJVR2dtV5HbPrqL09tWCpt0hMgRkk3AQ0CwPRPs11qlL
         gguL9p8VwzajL5uYhA0M1ug15pDCOPn8nTwolLn8RrFQVI3bynGlOVb0tREKv9PSPFNi
         +4IOfz86TUzdTEiJq3cgfNYOkY4voObRcazkHOdH9vl803OX32w7dHdXy2dh1RfoQdLY
         Y6pqlElz8EDAeCIOaRwI8LZecd70zXBP/HHwtYHka1HLHMJDxGrLqubcG2Y9j47XlYWO
         HyIA==
X-Gm-Message-State: ACrzQf1CwRy7zAREwQO2vqBIK94zW2DYKrJ0azZ8WBHXDelwlzBcXBOs
        eki3OwAdvYZUbjciE1QaTbK4x/YwtvZ6cXXTij8=
X-Google-Smtp-Source: AMsMyM6+rIlxJhlGVqQqwws7dKXScz9hhqT1yPWiXVAQs01Kue9fch+ZGI1P5VRVhfHeiTlU6fpuAjT0NeJ8mBZ2r7k=
X-Received: by 2002:a05:6638:144f:b0:35a:68ad:ea0e with SMTP id
 l15-20020a056638144f00b0035a68adea0emr7613876jad.199.1664665271026; Sat, 01
 Oct 2022 16:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <202210010816.1317F2C@keescook> <CAK7LNAQ2xBLG_aSDm64SSYRBOBKwhJnZ6UDg8ycAezATVToFLg@mail.gmail.com>
 <202210011547.A456D4679@keescook>
In-Reply-To: <202210011547.A456D4679@keescook>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 2 Oct 2022 01:01:00 +0200
Message-ID: <CANiq72k6j+xuUOGQMSEdJ2SyVYM0dAo+vfqSbX-xapqWQxYgNw@mail.gmail.com>
Subject: Re: [GIT PULL] Rust introduction for v6.1-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 2, 2022 at 12:50 AM Kees Cook <keescook@chromium.org> wrote:
>
> Ah, yes. Apologies; I missed this while checking the list. The latest
> I found are from 9/28:
> https://lore.kernel.org/linux-next/20220927181647.487727-1-broonie@kernel.org/
> Miguel verified the conflict resolution at the time.

Yeah, the `obj-$(CONFIG_RUST)` line in `Kbuild` is in that resolution,
but I don't see it on linux-next 20220930.

Cheers,
Miguel
