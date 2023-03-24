Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878CE6C7D7F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 12:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjCXLwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 07:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjCXLwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 07:52:09 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7776B22A1E;
        Fri, 24 Mar 2023 04:52:08 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id o14so674376ioa.3;
        Fri, 24 Mar 2023 04:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679658728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWww7KIOZBCmIAHeZv67n8Ky5bkkqCoK79aVsIAZNBI=;
        b=TZIv8T/N6JJPGZzyhEafVekIQ23TQTiv0q+86h2sLILA6iYzEfF+u25kxtdHp0VNRq
         oxZ78xFZORp0fy9rKmZZbV739hSARgPOxdeaHK8u5HVOOZ+XoTsb4e+8OIlwjfdD+Ql7
         zhqN1Parx4H/ypNye6pC5LYEcdA2aVqEf5Pj85VQJCszYYHd3qwp7Z6vgH8A4g2J4iDq
         Jvyj/nX9Kxxs1RNcEyCI4VxU8gCULSV9V72g3/PWK4V27yBgt7JRix0tewp8vbtVw3wM
         S62jCU5Rp3Pf1rHR89/Ps52hFSuInfYfA0/v6QVaVOAAszzLLvwm1fE5xWI5yg91LgDW
         n8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679658728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWww7KIOZBCmIAHeZv67n8Ky5bkkqCoK79aVsIAZNBI=;
        b=K1KOHApxjnV3NaWp+LomxoU+QAfwLSQUTgqzW2SD3iwqQEpCg13gElLdprOGPJhCA/
         sCdzMarjTJ3+D91U9JYQIfkYn2zjigY1AOWW4uV5InCsiJGCDFQayGJXC+MHM5sO87in
         bJ37sfKgzKqme2zFyJMUBwjz5rw7nWDZVFEEwaut4DqFhv2uh4vwq+LbYHEbphR2LcCL
         ox1MMpJ3nivSUzxoAbfO6R2zpk0w8DYbp48ZEG+uL6j5632zMaCX6PDZb0OpDuRyVDE1
         r5vhhppe8XYydPt7aj8m6Ne82e0/VrfKu58YQ+hpRU5ZeWRcaTYfVxK6s+G+FL+zffeE
         7K1w==
X-Gm-Message-State: AO0yUKU5b2Xz8YYjUSTTDM3W99bnMvervQVCvk6jBWPwzc1HCjFlod6o
        REyecNVAAt9LUsX/JJumY+iJ5FhbBEtnVy10kvu28wmhtAs=
X-Google-Smtp-Source: AK7set8+H6cwLxu738lkTCKCs6nwLDvrDpz/EBmL2ZmHT3i13MKkp+14knPu99WuRsmhLBPnfRJcdLzJTAFzgFo9qX0=
X-Received: by 2002:a05:6638:22a1:b0:3ae:e73b:ff26 with SMTP id
 z1-20020a05663822a100b003aee73bff26mr831353jas.1.1679658727838; Fri, 24 Mar
 2023 04:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230323185112.13855-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdVKRS1N5s-cvxrgSj9ev-Hh+gxfa-Hp2+z1zt+r7fEUWg@mail.gmail.com>
In-Reply-To: <CAMuHMdVKRS1N5s-cvxrgSj9ev-Hh+gxfa-Hp2+z1zt+r7fEUWg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 24 Mar 2023 11:51:41 +0000
Message-ID: <CA+V-a8u5ttTsG9fn4ePKi-0=2NXzhk1seBwnzBn_X6VQDwWKpw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: timer: renesas: ostm: Document RZ/Five SoC
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Thank you for the review.

On Fri, Mar 24, 2023 at 9:35=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> Thanks for your patch!
>
> On Thu, Mar 23, 2023 at 7:56=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail=
.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > The OSTM block on the RZ/Five SoC is identical to one found on the RZ/G=
2UL
> > SoC. "renesas,r9a07g043-ostm" compatible string will be used on the
> > RZ/Five SoC so to make this clear, update the comment to include RZ/Fiv=
e
> > SoC.
> >
> > No driver changes are required as generic compatible string
> > "renesas,ostm" will be used as a fallback on RZ/Five SoC.
>
> While this paragraph is true, it doesn't really matter, as you're not
> adding a new SoC-specific compatible value.
>
Agreed, I will keep that in mind for future patches.

Cheers,
Prabhakar

> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> > --- a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
> > +++ b/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
> > @@ -23,7 +23,7 @@ properties:
> >        - enum:
> >            - renesas,r7s72100-ostm  # RZ/A1H
> >            - renesas,r7s9210-ostm   # RZ/A2M
> > -          - renesas,r9a07g043-ostm # RZ/G2UL
> > +          - renesas,r9a07g043-ostm # RZ/G2UL and RZ/Five
> >            - renesas,r9a07g044-ostm # RZ/G2{L,LC}
> >            - renesas,r9a07g054-ostm # RZ/V2L
> >        - const: renesas,ostm        # Generic
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
