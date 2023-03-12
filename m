Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2BE6B6ADA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjCLUG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCLUGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:06:23 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9AE2B2AC;
        Sun, 12 Mar 2023 13:06:22 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-536af432ee5so205773127b3.0;
        Sun, 12 Mar 2023 13:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678651581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmBQlYtJTT9yUe/2oh983si+MyvnMuzO10CtC8+Beo0=;
        b=FrWUBxyH5eVdR4HwqvV/N1lzACL/UdRop2U9Z6LY0FjFSqEOnU+DSy7m4+bxQc+n0O
         cAild+3sIA0YLaCRsYWN3YLVcVgxKK2M8ZWhgmMcQiswSLKJ2qGv9w1SdcDZPSbh7tYA
         mRYFbcuO9yqpjyoqaPLkX1sI/R0A3ekLVXwNaowt4lofm96iBBDReTzTYrpAxbfW9rkq
         ec9zqC5NqBeC+sj0xC6p+Ka9jhI+38Fo9Xxcn7UXDytOUvgVBfN/H8SnA4omjJ2Xg3rk
         +H2B5oFirKCFLo+1zW2zDE8lZyeLQ5Se7ccVljT4tEENTfo1eAf8fkjjoGGS4T7GH2F0
         Q/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678651581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmBQlYtJTT9yUe/2oh983si+MyvnMuzO10CtC8+Beo0=;
        b=Ouix7koRLQ+4LMDBscILe5Kz4OnBBP6SK5ZGvpOZb0DoozAXzAdtg1Hnnmed5gvGAi
         2J7/DlFZOWwDG3ek/KZ0wR+N/f3xtvsHshUHnMT2kRcOaFFN+rkTudVPsLwOjuhRSyEZ
         ROm/KXuTSwJOp+dcXzQ1STg6bEeZi8Ev/4OPqQHKMx6+l0UP9JElkQmDanuS7wVLXsFh
         JQS4Kc4vEqf7HC5svuKT6SwP+rGu61+T0BE3ESZD6EUTTUqruapi4HOvqpV7ilJe3suc
         5VpU2afx5wp5gAjHtoxr0lBc5SwAkVKYCTfKaV9yrRsiOESWSuMYll18dUeDybddlXvl
         wqtw==
X-Gm-Message-State: AO0yUKXS0pZoiUt64aJ8maIV1r8tlxbldvG67H1qKnrKfMykR56q6WTf
        8u0aFX2bQ4f7WYjCGZVqW/38z89xKJxrFgz0C+U=
X-Google-Smtp-Source: AK7set/2G47kzPWyEprQivW3Y1z57ekU1bu0HenD8vHy9ycwkaUDwvZwy5Bzi95Oan8wF22k4GC5tApkLbocoCBRtwA=
X-Received: by 2002:a81:b646:0:b0:541:a0cf:71c9 with SMTP id
 h6-20020a81b646000000b00541a0cf71c9mr756808ywk.7.1678651581692; Sun, 12 Mar
 2023 13:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230206001300.28937-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdV+Az_yda0nTzn5teeQ2V7brQsmtZx6RUzBQsok3LxVKw@mail.gmail.com> <CAMuHMdWw43xpmRgzGM8g2fEbpMrVp4exOCNG+4riFC9v_TU+ZA@mail.gmail.com>
In-Reply-To: <CAMuHMdWw43xpmRgzGM8g2fEbpMrVp4exOCNG+4riFC9v_TU+ZA@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sun, 12 Mar 2023 20:05:55 +0000
Message-ID: <CA+V-a8sqOp4pphbrZ4yKdgznuJ4Bc20r_QP3r=-t3JquUg0QoA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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

Hi Geert,

On Fri, Mar 10, 2023 at 12:11=E2=80=AFPM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Fri, Feb 10, 2023 at 11:49=E2=80=AFAM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Mon, Feb 6, 2023 at 1:13 AM Prabhakar <prabhakar.csengg@gmail.com> w=
rote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Enable the performance monitor unit for the Cortex-A55 cores on the
> > > RZ/G2L (r9a07g044) SoC.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>
> > > ---
> > > v1->v2
> > > * Fixed interrupt type
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > i.e. will queue in renesas-devel for v6.4.
>
> And cloning for RZ/V2L...
>
Thank you for taking care of this.

Cheers,
Prabhakar
