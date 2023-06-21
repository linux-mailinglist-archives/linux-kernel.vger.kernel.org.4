Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E42737D8E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjFUIV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjFUIV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:21:56 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C133EDD;
        Wed, 21 Jun 2023 01:21:55 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5149aafef44so6674589a12.0;
        Wed, 21 Jun 2023 01:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687335714; x=1689927714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jBRz0LRg2B0m25eW+Tt+1nFooZyySe4sAZwfGusRF0=;
        b=WkOBwnyhVMeHdjv01ZldJEa+yVR6LiekbLDbZLW1R5TvMV0n+6h68f19tE2f9nILs1
         fKcMH0bPB91NbFjdrpNvQYwgTzVriIR6TXjPS80e3nbpeWKzhxdeoC5uIbZIATwvieW8
         fPhTjy8tKuy7sLPj99+c1ne1Hm5tfm2nO/Oj6nQnT5cgwy6XWg3TV3Ji5lMkJYOE4p0B
         BCIZ04JUBr3Ut+VLcUIYqBmElziueUczruSOONBFcvEcucoSkH/wWVE1hDQcKSnfP7cW
         YDD5sp91grBQU/yVEwo5KtCMeA8d6oWgkCWak1Mgp0+tB5taBmmOFVHbHxBiNWN0BFJO
         etPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687335714; x=1689927714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jBRz0LRg2B0m25eW+Tt+1nFooZyySe4sAZwfGusRF0=;
        b=M6vkdVGKqnKxI2GgPdvnaMHKlqWrBdGehdmNt9gEp5rjY/f+U7pPiAdWXZrG6i/rFe
         5wIk3u0EmdkB2HxTBl3O+RAwE4OcNgUyQros5HAuaohsO+OfZBQbWQ1lvytKR/+FRu8C
         Hefl4VldLkW5Ua/f9B0cPr41+uiI7NTlbrYfyj/c9X+o72JWbDuYDE2fhwg6lba3Gko7
         3BVfOofc2aUjCmF6XDKFSZWNeUFfv7UxshrDlR8ekKkyspH//Ddjaq1WUpxYUm9PX0Y9
         +hy49whFUcb0TcYxlfr4BkLOvYbeOzicJKi2fIKUwVciL7/JtQHEXSNyhyFSFOsAqV4i
         ZHBA==
X-Gm-Message-State: AC+VfDw/XHm6r1VekkdqjWTmM9UNQ7P2GYzx72EiJwm2lbloepKlHe1Z
        ps5ajoV+5zg3E1NvFBMiqCPM9rUKxPeeKDIoSx0=
X-Google-Smtp-Source: ACHHUZ57t7Yr5k8V208laObFC0kVfmXzVnMgP9PjggD4m6CY94CSVh+22oA8xQEToATqRdx59+GVTM5H79dCBLVzBIE=
X-Received: by 2002:aa7:c1d9:0:b0:51b:c714:a296 with SMTP id
 d25-20020aa7c1d9000000b0051bc714a296mr3604912edp.13.1687335713981; Wed, 21
 Jun 2023 01:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230620132641.256307-1-kimseer.paller@analog.com>
 <20230620132641.256307-2-kimseer.paller@analog.com> <CAHp75VdR9W8U9VmP5WZntzB9qW3fM6qy1Q2-yeBSAG5PJimkaw@mail.gmail.com>
 <e92f919e59974bb2ae32a8d961e07538@analog.com>
In-Reply-To: <e92f919e59974bb2ae32a8d961e07538@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 21 Jun 2023 11:21:17 +0300
Message-ID: <CAHp75Vf4kXi9TAvEW=JvA9SLRYuTtwwBvzH4vGoP2CRrk9vX8g@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] iio: adc: max14001: New driver
To:     "Paller, Kim Seer" <KimSeer.Paller@analog.com>
Cc:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 3:38=E2=80=AFAM Paller, Kim Seer
<KimSeer.Paller@analog.com> wrote:
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Tuesday, June 20, 2023 11:15 PM
> > On Tue, Jun 20, 2023 at 4:27=E2=80=AFPM Kim Seer Paller
> > <kimseer.paller@analog.com> wrote:

...

> > > +       /*
> > > +        * Align received data from the receive buffer, reversing and=
 reordering
> > > +        * it to match the expected MSB-first format.
> > > +        */
> > > +       *data =3D (__force u16)(be16_to_cpu(bitrev16(st->spi_rx_buffe=
r))) &
> > > +                                                       MAX14001_DATA=
_MASK;
> >
> > Using __force in the C files is somehow stinky.

...

> > > +       /*
> > > +        * Convert transmit buffer to big-endian format and reverse t=
ransmit
> > > +        * buffer to align with the LSB-first input on SDI port.
> > > +        */
> > > +       st->spi_tx_buffer =3D (__force u16)(cpu_to_be16(bitrev16(
> >
> > You have a different type of spi_tx_buffer than u16, don't you?
>
> I have the same type of spi_tx_buffer as u16.

And you should have __be16.

> Other than using force cast, is there any way to resolve the endian warni=
ng? I have
> actually swapped the order of bitrev16() and cpu_to_be16/be16_to_cpu() fu=
nctions.
> I have tested and they also work fine.

You really have to get it correct on both LE and BE architectures.

--=20
With Best Regards,
Andy Shevchenko
