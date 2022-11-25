Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890366390DF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 21:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiKYUxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 15:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiKYUxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 15:53:31 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9705D303E3;
        Fri, 25 Nov 2022 12:53:30 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ha10so12733136ejb.3;
        Fri, 25 Nov 2022 12:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sD/Opg2kMqx/4KzDzQ2UqRnrUwBi1wf4XCjq+pkybA=;
        b=bm45a8aZ6R6jyfumNKlTQyyX9hJCa0YY6TrulwUgivh5dhWtAX1bCCMmZ08MHPJr5C
         mPuiZLrNlD35kkTOdRQX3P6vmYKq6k88AiAyxUNTeiLX5kZfS2FIb8F4LVRwMRwLyoBR
         sBJarFQgNJ2Rw5J5CTM0fKSLfGS+AMheq8vm7Gh+7GgYzxeLXtgK4Grq9hEMOJ1Puc+p
         BhPbWAPaKANSNaWrUuHQ9wofHHU5krRiyj+W/YRKUPUtL115CxeSSL4kRBpZIiJV7n9M
         fmP1eSAOAmUa2Tl6bgoTtzluUzFDlRbkjk3BeOHi8tPpqN9oxOyHgn7udlOJIrpMhNwW
         Ngag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6sD/Opg2kMqx/4KzDzQ2UqRnrUwBi1wf4XCjq+pkybA=;
        b=bh759STP+WSgrq54vDkTqE6+ZoPPYyjugetKYgJmtH59MD7kiVOgPpMOgM703qrG9s
         3Innw+TZc7msS8bPH3gnkoqxl9ydEQjgvSZSLgmNWahqlj6LPPS9wEhMXq2wzK25ACF6
         y3N/agkU7iHFbwv/Zhi0CS6+b+sVtKIR/mFTOwMPTovVyng7Ekb6nxMgPx9g3OPj+QU8
         R8T5zNW29j9+mntoHsAZXx2kbFtEnVoIJljbYAehA5oe1NhTuAxUesdrWkjK9a3gWN2m
         BCyGtGx8P/ZzgZz0suhwEecqDX+B199nciY4XJUCO27QobR4ohmUVuY0mBvriQnheXpO
         92+w==
X-Gm-Message-State: ANoB5plvxvDKT3EYQ7auhjTYM/7qjhgAOyhMV8rWbAatf1dHPucgxKfo
        HYKmSuhDKH0L8BJlW4RNSVeBVkGuLuzwdVj3b70=
X-Google-Smtp-Source: AA0mqf6ZqeXlwkzzwv31EFgGaPOJIe9a20QRlRigNwZ5FuDhorinVjP2uOsFChpXkysNFQeb3b9Pc4fGT34f1ILc/Ro=
X-Received: by 2002:a17:906:8a57:b0:7ad:a030:4915 with SMTP id
 gx23-20020a1709068a5700b007ada0304915mr34077097ejc.267.1669409609046; Fri, 25
 Nov 2022 12:53:29 -0800 (PST)
MIME-Version: 1.0
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <3689906.Lt9SDvczpP@diego> <CA+V-a8uQh=q8ksTe8ttHkJThcoYtggSU-AXUqPGYnam0CiqZWw@mail.gmail.com>
 <3b5e52c5-7a1c-8bdd-b076-0c5e13463274@sholland.org>
In-Reply-To: <3b5e52c5-7a1c-8bdd-b076-0c5e13463274@sholland.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 25 Nov 2022 20:53:02 +0000
Message-ID: <CA+V-a8tZgswanaN2gbmWzswO4pLLQ884aQa+KVNLwjDS9YqS=A@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] riscv: mm: dma-noncoherent: Pass direction and
 operation to ALT_CMO_OP()
To:     Samuel Holland <samuel@sholland.org>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

Thank you for the review.

On Fri, Nov 25, 2022 at 6:49 PM Samuel Holland <samuel@sholland.org> wrote:
>
> On 11/24/22 13:18, Lad, Prabhakar wrote:
> > Hi Heiko,
> >
> > Thank you for the review.
> >
> > On Thu, Nov 24, 2022 at 6:29 PM Heiko St=C3=BCbner <heiko@sntech.de> wr=
ote:
> >>
> >> Am Donnerstag, 24. November 2022, 18:22:05 CET schrieb Prabhakar:
> >>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>>
> >>> Pass direction and operation to ALT_CMO_OP() macro.
> >>>
> >>> This is in preparation for adding errata for the Andes CPU core.
> >>
> >> can you provide more explanation why that is necessary please?
> >> I guess you want to use different cache operations for some cases?
> >>
> > Yes basically to call different cache operations based on the dir and
> > operations (and also this allows to export just one function to handle
> > the errata). I'll update the commit message in the next version.
>
> This makes things less efficient, because it requires more instructions
> and registers inside the alternative section, and your function
> duplicates the logic from arch_sync_dma_for_device(). The alternative is
> already passed the operation (clean/flush/invalidate) as a token, so you
> can construct the function name with token pasting.
>
I did think about it but that didn't help for example in the
arch_dma_prep_coherent() we are calling flush token, but on RZ/Five
for arch_dma_prep_coherent() we have to do nothing.

Cheers,
Prabhakar
