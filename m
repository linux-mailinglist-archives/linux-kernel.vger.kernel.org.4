Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9386B6AEB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjCLUIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjCLUIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:08:17 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50ABBDC8;
        Sun, 12 Mar 2023 13:08:06 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id d84so2300621ybb.4;
        Sun, 12 Mar 2023 13:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678651683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0D8Q79LE+zI+2x2/UQZCmY1ABwWSU3mlPEpDA3kZDY=;
        b=q4rSgQ2NqImGyxjNJqFbuzwWyf+6ny96Y9Rc7CoNUP8ez5DION7afMQRJeECSuHwTB
         Y2m9WEveB16B3qSnaqW4VQghEu3+POaPq8EXTcKkxB9g4xdSBuTfEmT3Ir4nqX58P2iF
         +1Kfk7yiTmS8+QjQqJ7t/2udUBNirhKDAqWSFjrm/fYBXJa5HyafPox+q6m0RULZZ8sp
         BslWLxbgPiZiKiABYS/KagUIpvMIVFeDxy8mDMsWG18x7ij0X2iI1Mu2bMvo8LBg8ede
         ZGb6+iBgCLcXeCP8Y2LNjIWUzc8l1XTys1xdW/Ugppb0G/7nvhvuo/HGdfeNoG5G+fvA
         gcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678651683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0D8Q79LE+zI+2x2/UQZCmY1ABwWSU3mlPEpDA3kZDY=;
        b=nj0UlGB7D+NzHHPMRafkFyOUeeTZkxxpQt8ZnDBew5CaY7YUZNMUoykz5dRVGLLe6b
         EMa7DuvtpelWDkLhZIwwzb0XncUwb5+D1R6+C8Xka1LkaeJjv8aO5KykY1qG5dHYI8wV
         ETsQqbIo91OrxwJ68HjS10vOR1jegLkJAKzDdUiR4sfcYoMbqMmKMvbTwiAs0oshYgXm
         lA5+WbERyisGlwTMrxS5IQEAMn7uzwuOFG1IH15c2eMt2PDmjsgW2JsmSktC3+THZOBF
         V3H9nR9izmtVhuTy39XeE7cRZ4UYX2N7BTXPzuG31ru4WztnerNHAe9lO8nU8+xcmwTd
         8koQ==
X-Gm-Message-State: AO0yUKXbdOgkxgZRq2bm3R8cLDy+JKw3+TgRoDq1Keiq9DoZtdYS4/9f
        YFAL4p4R8I02nZq2WJXmln10SQgWF3Z5ukqkkSo=
X-Google-Smtp-Source: AK7set9hjVeWyxaghirql8wC2P71Rr2FYABhQyDlzEKH0w51KMyh9H9UGbBWrkDIe4YCfe2XOW9wCXro9yfiKgKoHQA=
X-Received: by 2002:a25:f210:0:b0:b30:e597:fee6 with SMTP id
 i16-20020a25f210000000b00b30e597fee6mr3823570ybe.6.1678651683446; Sun, 12 Mar
 2023 13:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230131223529.11905-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdX3OHuq15m=g56faaU6EySYeKmRvbmJdty1xZ6JOu-yzg@mail.gmail.com> <CAMuHMdVB13VX32Qi3Y5pTWA1j6yODFohrNArhRvdVUQX085sWw@mail.gmail.com>
In-Reply-To: <CAMuHMdVB13VX32Qi3Y5pTWA1j6yODFohrNArhRvdVUQX085sWw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sun, 12 Mar 2023 20:07:37 +0000
Message-ID: <CA+V-a8sSm3_bWg_XOm=DB9G-Kb_LQ99_-t12bmLumjTZiinMcA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Share RZ/G2L SoC DTSI with RZ/V2L SoC
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
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

Hi Geert,

On Fri, Mar 10, 2023 at 10:41=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Feb 13, 2023 at 3:16=E2=80=AFPM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> > On Tue, Jan 31, 2023 at 11:42 PM Prabhakar <prabhakar.csengg@gmail.com>=
 wrote:
> > > This series aims to reuse RZ/G2L SoC DTSI with RZ/V2L as both the SoC=
s are
> > > almost identical.
> > >
> > > v1 -> v2
> > > * Patch 1/2 unchanged, for patch 2/2 sorted the nodes based on the na=
mes.
> > >
> > > v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/2023=
0127133909.144774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> > >
> > > Cheers,
> > > Prabhakar
> > >
> > > Lad Prabhakar (2):
> > >   arm64: dts: renesas: r9a07g044: Use SoC specific macro for CPG and
> > >     RESET
> > >   arm64: dts: renesas: r9a07g054: Reuse RZ/G2L SoC DTSI
> > >
> > >  arch/arm64/boot/dts/renesas/r9a07g044.dtsi |  254 ++---
> > >  arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 1149 +++---------------=
--
> > >  2 files changed, 256 insertions(+), 1147 deletions(-)
> >
> > Do you have an opinion on this series?
> > Is this acceptable for you?
> > The final generated DTBs are identical to before.
>
> Given the feedback from Krzysztof and Rob on patch 1, and on IRC,
> I'm rejecting this series.
>
Ok, I'll rebase CRU work by dropping this series.

Cheers,
Prabhakar
