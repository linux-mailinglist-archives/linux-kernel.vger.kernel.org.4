Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8463162A141
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiKOSVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiKOSVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:21:43 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1061740D;
        Tue, 15 Nov 2022 10:21:42 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id y14so38181957ejd.9;
        Tue, 15 Nov 2022 10:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=loW6rE2gGS02TW4sdv28/5PXvnJnn8jUaLXyFyxIBBw=;
        b=LA828D6tRnlkCLYZPkPlTBKFXEVeuzcoHeggCmhBc0leuImIicTgjH/A+lsrxXyCRm
         xggvxWALf8U2q+BIWkcePsNbOyPLCnsPSmxrl6gAkDEAueKu7pk/hNz65g8gavkoeqhi
         4VmODbsp98AehsvEizh8jJYMJVBzEj5Hc/alM4l3u114Pow4tjXx3lpnV5ZDEpT1nala
         6pvwxu7T/QPMRcmyomJJAbSt5Y7mclWTorwM0nzDHjaSKjR+9xgjICe3RULoEN/3bsLr
         MRnSGTNQ3h1fBnI4l/gCoOxwkzCMsLWDMNdmI5rLTXycIdi4bW0U5rwcaei703u8i0ME
         Jb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=loW6rE2gGS02TW4sdv28/5PXvnJnn8jUaLXyFyxIBBw=;
        b=whDaHHJ6Cqycaf2fnCdnyNhrm5jntp7zi/DR/NEi8PkL6ItDAJa4xqdbsANxxp+Q0U
         8WP6WTuhmJbJQQMYEs9RC9BGC+qgi0Bvkhf3VUKyGnKpAxMhPPEejOlrqvljXIcqGy3W
         Q69nQpgptsWVgODzxOHQXgVU5TAWvLQKGtTnKXXOXL05jKOKBayIBjuLw14C7RAjfv9X
         UZYcHQDc0yhD24eGAeD8tSpY+fAj2N0e9sKYZm15V947rasZ1ntzmf0frOKnxwkSEWsm
         0BNpT2rNb2Lw5KYS9cceIJjr1StpvqHvLJAegnSqwlM3Nk2QRe2cGo9YWuDG4l+RukAg
         wKqg==
X-Gm-Message-State: ANoB5pnXeInVY0YQkRp5kq0mJ5jerRh0VJ2hf2+nLG+FX5mzDXBZXVe8
        5Ok3+9X5Z9M8iEOMWZVwxI2LhSxfvROUNYj7guU=
X-Google-Smtp-Source: AA0mqf6JCfjVF2CWf2wVuu3vn+PsZPYxNJ572dgDVuVXioqlruUP16R3Ykd7ViMw5b+tNOY1knzEH1M29bCy/oc7+38=
X-Received: by 2002:a17:906:4e42:b0:781:e568:294f with SMTP id
 g2-20020a1709064e4200b00781e568294fmr15100953ejw.447.1668536500767; Tue, 15
 Nov 2022 10:21:40 -0800 (PST)
MIME-Version: 1.0
References: <20221115105135.1180490-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <Y3OgSAnst0qt5WSk@wendy>
In-Reply-To: <Y3OgSAnst0qt5WSk@wendy>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 15 Nov 2022 18:21:14 +0000
Message-ID: <CA+V-a8vL5r-xMeCiYRax-dM2Uo0ghgzRiyY99nNn089CjJwoBg@mail.gmail.com>
Subject: Re: [PATCH 0/3] RZ/Five: Enable ADC/CANFD/I2C/OPP/Thermal Zones/TSU
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Magnus Damm <magnus.damm@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Conor,

Thank you for the review.

On Tue, Nov 15, 2022 at 2:21 PM Conor Dooley <conor.dooley@microchip.com> wrote:
>
> On Tue, Nov 15, 2022 at 10:51:32AM +0000, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Hi All,
> >
> > This patch series aims to enable support for below blocks
> > on RZ/Five SoC/SMARC EVK:
> > - ADC
> > - CANFD
> > - I2C
> > - OPP
> > - Thermal Zones
> > - TSU
> >
> > Note, patches apply on top of [0].
> >
> > [0] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git/log/?h=renesas-riscv-dt-for-v6.2
> >
> > Cheers,
> > Prabhakar
> >
> > Lad Prabhakar (3):
> >   riscv: Kconfig: Enable cpufreq kconfig menu
> >   riscv: dts: renesas: r9a07g043f/rzfive-smarc-som: Enable
> >     ADC/OPP/Thermal Zones/TSU
> >   riscv: dts: renesas: rzfive-smarc: Enable CANFD/I2C
>
> I know ~nothing about your SoC so idk if the values are correct, but I
> did give it a go earlier to see if it did anything warning wise. Seeing
> that it didn't cause any I am curious - how come these didn't land in
> the original dts? Just waiting for driver stuff to land to support it?
>
I wanted bare minimal stuff in the initial patchset.

> Anyway, no new warnings which is what I care about - I suppose that
> makes it an acked-by?
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Can include that tag if you like. Either way, nice to see some of the
> /delete-node/s etc being removed.
>
Thanks, Geert should pick the tag while picking the DTS/I patches.

For the Kconfig patch it needs to go via the RISCV tree or can that be
picked by Geert too with the rest of the other patches?

Cheers,
Prabhakar
