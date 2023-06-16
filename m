Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BB17331A0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344254AbjFPMxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjFPMxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:53:05 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDC53581
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:53:04 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bb3a77abd7bso582099276.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686919983; x=1689511983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CC4+pWhIZunTVuA2ymJql5DGmR0KK8KjL/YmD5fofdc=;
        b=B/4ka6ITmEzsxEMx0GQ36klxPa8Yjb8CE6pScPqKHNm86oYRv6skCJmKi6R+LJtVSn
         pTCokeNSdBgjNoOCerTGRxbVGXxwT18On2/GXpTeAVpmxOuRNjzJ5cc+wTdcZh/xERUP
         rOh9FyvZ/sOJTtcpSsYF0kli9RzeIAVoEMuJwPIibPFOj784G2d8WoEX+UZhnAj5GYnY
         GQdxCG1JO/HhFrHWfT8Rfoogcd71cIAWPVQ0szkiQLLlFURVodk7CQ89dJUHQbmT2Cp5
         khYxpjIOm6gZK9PD9i73ZSCekZZaX7yRv+6i//c7F5ydsM4+cVVyToy29h7beuoTcVPK
         Iuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686919983; x=1689511983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CC4+pWhIZunTVuA2ymJql5DGmR0KK8KjL/YmD5fofdc=;
        b=KTs7MB4sA2qvR/rNt6Gr8yMuLpPnHCg7Dm67j2P/5um8DTFc/zvcHcQZV+XI4ejeKw
         PaAinENiTrbE2UAHUb227dF/pVIOt8+TDMhxj34qRB9HoVf2D36dp1S43v5EzRBq9BXh
         pHiqDk1C2qI59nhN2vGo8D+UP8lCQ0HCVeSQL6mvLOQkrOT4RdjwKsUGBTzLkfCoMuUZ
         oEmRdxMZ/NVSXnvvrIZqBXiL68HPG+Uogdjbi80s4cgfdyuYeoAgBe8E5ymozH4LVsDY
         rjEJQRGqmHEwySBzdt7bMOB2QSLM8afvGrV2/ODjST8P6SMR3YMUs2wNuX3fPCRCu9rT
         sLBA==
X-Gm-Message-State: AC+VfDzarcyPVaTl9lH0LHYpdm/Cz8/FU+M1fQ9/zf0+YxCkpKe5szyn
        Q95v0ayEBf0pB1GpLptFolZM9OQN5iOdXSphVIQw1g==
X-Google-Smtp-Source: ACHHUZ5tzgmAO6NTdW16MM2p4xBolNh5C55obixHUitKfGfBPwj9jOy2ZwWteenp3/N1cvoaMpUp1DjEkRQSwMOnIRg=
X-Received: by 2002:a25:40c3:0:b0:bcd:3379:11b2 with SMTP id
 n186-20020a2540c3000000b00bcd337911b2mr1615849yba.52.1686919983691; Fri, 16
 Jun 2023 05:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230607151127.1542024-1-pavacic.p@gmail.com> <20230607151127.1542024-4-pavacic.p@gmail.com>
 <CACRpkdbrEA54qmfTKSsFRG9ZS4u8hM6P5TXtOjRAiW+TD_v-fQ@mail.gmail.com>
 <CAO9szn00vRFm+iM1m7KgkW0WRuKyJEgVU4tVx4f5tF6KPnE=2w@mail.gmail.com>
 <CACRpkdaw8M3dSkmiV5QDOt3BBB7Jo6NxT0Og=zvA4REMA_7y9g@mail.gmail.com> <CAO9szn29A0qCABG0ACni42UGpsGKLwG7OT1y_ho3DgQ0WLvfmw@mail.gmail.com>
In-Reply-To: <CAO9szn29A0qCABG0ACni42UGpsGKLwG7OT1y_ho3DgQ0WLvfmw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Jun 2023 14:52:52 +0200
Message-ID: <CACRpkdYXtQwmZR1u-1fwmyC_8Yq4bMkjDBcUCfuGqSz_UhXWJQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] drm/panel-fannal-c3004: Add fannal c3004 DSI panel
To:     Paulo Pavacic <pavacic.p@gmail.com>
Cc:     neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 2:31=E2=80=AFPM Paulo Pavacic <pavacic.p@gmail.com>=
 wrote:
> pet, 16. lip 2023. u 13:44 Linus Walleij <linus.walleij@linaro.org> napis=
ao je:
> >
> > On Fri, Jun 16, 2023 at 11:57=E2=80=AFAM Paulo Pavacic <pavacic.p@gmail=
.com> wrote:
> > > =C4=8Det, 15. lip 2023. u 21:55 Linus Walleij <linus.walleij@linaro.o=
rg> napisao je:
> > > >
> > > > I doubt that the display controller is actually by Fannal, but I gu=
ess
> > > > you tried to find out? We usually try to identify the underlying di=
splay
> > > > controller so the driver can be named after it and reused for more
> > > > display panels.
> > >
> > > Yes, of course, the controller is ST7701S.
> >
> > Hm did you try to just refactor
> > drivers/gpu/drm/panel/panel-sitronix-st7701.c
> > to support your new panel?
>
> Yes I have tried, but there are too many changes needed and I wasn't
> sure whether I would be breaking compatibility with st7701 based
> panels.

For the community it creates a problem that now two drivers for similar
hardware need to be maintained, and that burden will land on the DRM
maintainers. For this reason it would be better if a joint driver could
be created.

I am sure the users of the old driver will be willing to test patches to
make sure their devices keep working.

Yours,
Linus Walleij
