Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA8D5EC33B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiI0MsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiI0Mr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:47:58 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BA2167068;
        Tue, 27 Sep 2022 05:47:52 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id y141so7624663iof.5;
        Tue, 27 Sep 2022 05:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ZOpfUMvVhcyBHNrUr64CmlDZh4mQ1iNQ3dLRR/9l76M=;
        b=YfoU3Fjrx6xm1yzLCoCUIiLmPC+C6i3x4snKFAU61gwPGCN3Oa7yN/FqLjfFZzqKiU
         +rXFvdA8Df/3lI/O+Y8EmJ81zDWu1bwiiQmHo+GahiF5spCeknao7qEBiz1ohFqaIIFL
         KXVJkLsbukIa4UKAJRiQQTKOvx5zCaa2HbjWADoeDOVhFk4Ua83XmQjQ+BnPWJXLEOn/
         DJ00LchLr1I+SCUDVo1uNM2LW/XL/YQrmBrlhfTDB7QSWV6L4jd5Eujm3y8HYyGDAeyk
         SMjqAattWpdzYpimdN3exzdsfKyntfgSKW4EOV/xVaolZYf7MTrvNNL9dT5DK35zPzVA
         XjFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ZOpfUMvVhcyBHNrUr64CmlDZh4mQ1iNQ3dLRR/9l76M=;
        b=bE0cm+YVf5WR4J3nbrh81llaYexMRhFtbg4ZJp96pFCqjyDJJMTjdVcDdyWmeOghaz
         saeIsCGdZBlj6VzrWU3gS9kQOwTlHWq/u6diCT5/uzm1kctdgeqxa+J7ZPuliulDn+I+
         IHsbYpRaAFeQmI+J5TkPEymuzciKsnkJF9CK+r4eIEnrNeqEkJyJ7bseHyCUXkrkv/Sp
         v7q2rND61A+XsDmyjbTCko50w/Ze+eZ7DhmVjLFSAscdHAc/Ek5duIanb9RhK0nmXgYm
         bHgE12K/Qw9+97k7CwdSHHEKqS2mFriYbz6yDArPtLU24OKhJCxiq0AM4jYdbhK7SnJw
         hFOg==
X-Gm-Message-State: ACrzQf26XT/7aDFJS1QWEe2lPH+DQrQ8tytlohq+77NxMhfuDFj7Ayz4
        JHXR7IAhuEwXgvX8OfDCqZY1YURnDVTRBpApKGA=
X-Google-Smtp-Source: AMsMyM4wKsiWXwsHJ2OSLepNsJbcyJl+mJpcdI1axv8pAKISE6b3ySTDhA/ue95IoinVri8NRUK8pHWAxQda+6/sy8Q=
X-Received: by 2002:a05:6638:25c6:b0:35a:128d:70d2 with SMTP id
 u6-20020a05663825c600b0035a128d70d2mr14245202jat.308.1664282872294; Tue, 27
 Sep 2022 05:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220926231246.1140133-1-broonie@kernel.org>
In-Reply-To: <20220926231246.1140133-1-broonie@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 27 Sep 2022 14:47:41 +0200
Message-ID: <CANiq72mv7DGGgefPm3h4_PdW6QiFDVJ5gRuWD3gNSM79pacnOw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rust tree with the kbuild tree
To:     broonie@kernel.org
Cc:     Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Daniel Xu <dxu@dxuuu.xyz>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Douglas Su <d0u9.su@outlook.com>, Finn Behrens <me@kloenk.de>,
        Gary Guo <gary@garyguo.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
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

On Tue, Sep 27, 2022 at 1:12 AM <broonie@kernel.org> wrote:
>
> I fixed it up (see below) and can carry the fix as necessary. This

Thanks Mark, it looks good.

This should be gone in v10 which I have just pushed.

Cheers,
Miguel
