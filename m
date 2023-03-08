Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C846B0575
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjCHLIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCHLIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:08:39 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575D3231D8;
        Wed,  8 Mar 2023 03:08:32 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id t39so14214604ybi.3;
        Wed, 08 Mar 2023 03:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678273711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXJLchZ3CLsje5+7ZZBBlhl0+d94Zoo7kNdmX7dqbOs=;
        b=RrtOdI+D6/WHBOKSaRpibafbT7TPzJGrD272U3Xzl7psc6VHTgxi9qf0eOGrBogbaL
         IdSBRZynrqzZ/LpDDf1Ixs82XkZGpYjSyDk5kk/NTHMUk6NyLNMjcVyDC0UlS2QTxJ3R
         345MTxXwvB5ZeWpMuVopHDH68Hif8wGZK4B+LSKa9blEM/2bEkgnuf7uIN0MYFgOA/Co
         gSMCSGHUZfcxmuhgjAdcfrQ8DQ0ETehVzzFh3nmc6KZ/icSCfwsY88UPIEV547OBM6U0
         FF8iT2SmrmJYtz7Gm/d6tpqVN6gOg5WWoJoF8xJS3EjCbSbhB1DA0wS4hsR7kSS0JvfQ
         p5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678273711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXJLchZ3CLsje5+7ZZBBlhl0+d94Zoo7kNdmX7dqbOs=;
        b=a7Ucpz6sHRQCSho68CtxCisZyHgBfCZbX6gDVtlmrcIeG0+a/Rhava5OxOjf8Ox/vD
         zq14cMvnm+nmf/96cmwo4pTsgxGDSbhYGMGW71iyEb+MX3tliXne1VAZta7vuxYgFLGz
         /FqVVDkrqZ9t4wHZpBEgHVsOq8XbUF5fjM8zC3Y/3DtCNXAuum5SXeNs2CIBYmOo8VlM
         Gyd2No+7t3ujAtHT9Y6F2c+fVFhdqspp7VPwI3S/UbZBsXYR91u9KFSkXO3vLxCdvmwM
         aUdnfE+wZeSF8oODaF57wdz8yerdc5dVS0qi5avWWjqYEF1v20qzdPFvIoUFx1zV+/Q1
         /mdw==
X-Gm-Message-State: AO0yUKX0tWIty3G7fDqlQRbBnBBS7okSzpIn8vECUfXKAOyY3NVdr0qj
        7UKtARdB6KiTO09R+Ha2SVcTJR7/Bqic87b0/F8=
X-Google-Smtp-Source: AK7set/5RjequTJCQUjg69IGow+Wa/vlxBCrjoX91l2mwEs7aGXw74L2lQQNX9IAZJIp5MNnkHGM7yEphxMeLLphXso=
X-Received: by 2002:a5b:88c:0:b0:ad7:b81e:69be with SMTP id
 e12-20020a5b088c000000b00ad7b81e69bemr8507234ybq.6.1678273711353; Wed, 08 Mar
 2023 03:08:31 -0800 (PST)
MIME-Version: 1.0
References: <20230216175347.99778-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230216175347.99778-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXNrBCdLvMKK6kPbMLhSmuxXtd5A+Lt4J0ddVorODqCvw@mail.gmail.com>
In-Reply-To: <CAMuHMdXNrBCdLvMKK6kPbMLhSmuxXtd5A+Lt4J0ddVorODqCvw@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 8 Mar 2023 11:08:04 +0000
Message-ID: <CA+V-a8up5tnNt==6nUcpK44o+eN0VVMLdtLD5NyZzd37Rx=GgA@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: renesas: rzg2l-smarc: Add OV5645 node
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
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

Hi Geert.

Thank you for the review.

On Mon, Mar 6, 2023 at 7:27=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68k=
.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, Feb 16, 2023 at 6:57=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail=
.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > OV5645 sensor can be connected to the CN1 connector on the
> > carrier board. This patch adds the ov5645 node under i2c0 node.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
> > +++ b/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
> > @@ -6,6 +6,10 @@
> >   */
> >
> >  /dts-v1/;
> > +
> > +/* comment the #define statement if OV5645 is not connected to CN1  */
> > +#define CAM_INTERFACE_OV5645   1
>
> I believe the camera is optional ("can be connector" above).
> So shouldn't this be commented out by default?
>
Yep, that makes sense.

Shall I send this change or will you be generous to do this while applying =
;)

Cheers,
Prabhakar


> The rest LGTM, so with the above sorted out:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
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
