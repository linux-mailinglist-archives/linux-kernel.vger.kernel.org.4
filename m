Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D0272600D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239579AbjFGMuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238762AbjFGMuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:50:46 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE4C1FF0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:50:21 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-565a6837a0bso81943807b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 05:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1686142188; x=1688734188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AxgroMuIH5NoBbtLc+ad3Qph59KMeN5Cm1Y0j7Ly7E=;
        b=ZbKfKcjvgFXKqwj0h5Tewi1lK9Xd76DukZKwpNIXejMBEEIVgX1ml9V5uECiRVpV9C
         qpIGXKmcNrTBr1q1m39Ibv5tpSIkf8YqnsD3sVX2jKG2S8whdARNgj06BRqknITaqsfU
         xRKVeXzvJSMs4tI9tPs9ap5Lf66e2PkfUr6L8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686142188; x=1688734188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8AxgroMuIH5NoBbtLc+ad3Qph59KMeN5Cm1Y0j7Ly7E=;
        b=eJkRYzIrkXyzHLcPK+Ttil5ZwLOT8WbYqa0hIef7lgxiQcHywWsj5fk2dxHNFJenzq
         xZhhmVMd+um8UHAZFLHLg6n5OyIDoM2AyTKzQSnTMS/lqCLdLqW/XlnNQIYxkQx2UlC9
         W5RhilsXQWgg85SL8WUDNNHwDDKajS7XUIiurm4aofatskJr0o9VycvpGC2+PQj0ODGv
         7r9IgtESv7M6dInni8e9vB7kjXGu8bCjRMjKIzLF7c0ZNqgJghhmyuYCcd7Y2h4g1o28
         pWPOZEHgLVs4SZP/bOjpF5QKw6NsyVTNA50SysuGJHYRuprHbh92E+YXdgxV0C4nO9k2
         SLMw==
X-Gm-Message-State: AC+VfDyXLQkzgSs4DYQhTBxQNAMlqOwcNWyQTZkXgTI3ZseOEbQKLGMT
        MF4SVC1xQ7ClkbnC1lGqkzEAqU1OjhQFq4hZgP0e/w==
X-Google-Smtp-Source: ACHHUZ7hBI1yQy3hOqMs3IywMmiWVgkBaT4CmmHgTUdbu1gUndSUOaqBclPy1zulKt9pLMxC7qjpriQ1ztOABz2tp58=
X-Received: by 2002:a81:834b:0:b0:568:b6a5:9100 with SMTP id
 t72-20020a81834b000000b00568b6a59100mr6838026ywf.42.1686142188079; Wed, 07
 Jun 2023 05:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230607063139.621351-1-dario.binacchi@amarulasolutions.com>
 <20230607063139.621351-4-dario.binacchi@amarulasolutions.com> <CAMty3ZDCkQ_T+j96iXtMAhkOLFBm=hZHk=sZzSGA=MOQQUOv7g@mail.gmail.com>
In-Reply-To: <CAMty3ZDCkQ_T+j96iXtMAhkOLFBm=hZHk=sZzSGA=MOQQUOv7g@mail.gmail.com>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Wed, 7 Jun 2023 14:49:36 +0200
Message-ID: <CABGWkvq_DevgJeR+KfBy-4ME+u-iORW93BAT4FTMVRuG0KU1Zg@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 3/6] ARM: dts: stm32: support display on
 stm32f746-disco board
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        michael@amarulasolutions.com,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagan,

On Wed, Jun 7, 2023 at 8:43=E2=80=AFAM Jagan Teki <jagan@amarulasolutions.c=
om> wrote:
>
> On Wed, Jun 7, 2023 at 12:01=E2=80=AFPM Dario Binacchi
> <dario.binacchi@amarulasolutions.com> wrote:
> >
> > Add support to Rocktech RK043FN48H display on stm32f746-disco board.
> >
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > ---
> >
> > (no changes since v1)
> >
> >  arch/arm/boot/dts/stm32f746-disco.dts | 51 +++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/stm32f746-disco.dts b/arch/arm/boot/dts/=
stm32f746-disco.dts
> > index c11616ed5fc6..cda423b6a874 100644
> > --- a/arch/arm/boot/dts/stm32f746-disco.dts
> > +++ b/arch/arm/boot/dts/stm32f746-disco.dts
> > @@ -60,10 +60,41 @@ memory@c0000000 {
> >                 reg =3D <0xC0000000 0x800000>;
> >         };
> >
> > +       reserved-memory {
> > +               #address-cells =3D <1>;
> > +               #size-cells =3D <1>;
> > +               ranges;
> > +
> > +               linux,cma {
> > +                       compatible =3D "shared-dma-pool";
> > +                       no-map;
> > +                       size =3D <0x80000>;
> > +                       linux,dma-default;
> > +               };
> > +       };
>
> This looks unrelated to display enablement, isn't it?

Without the "reserved-memory" node, it is not possible to allocate
memory for the framebuffer.
I got this error:
stm32-display 40016800.display-controller: [drm] *ERROR* failed to
allocate buffer with size 139264

Thanks and regards,
Dario

>
> Jagan.



--

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
