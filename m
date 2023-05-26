Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88884712D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243941AbjEZTZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242258AbjEZTZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:25:00 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF24EA3;
        Fri, 26 May 2023 12:24:35 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b011cffef2so9259055ad.3;
        Fri, 26 May 2023 12:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685129074; x=1687721074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8F+V6OXXzxlqAeAQ2S6nVyckBmSNTRDJrN1SofTqjrw=;
        b=l0fvbyeOvzjhchm1f7BpPbYg1pvfRRBID8i4AaBQVgNK/2dgA3qoG7g5mCHUhLU8+v
         Naau0mLrjmenMYJxaZXr9pxWiulhsH0h/63lg+sJHR9cVIQ793td2LmKq5Y9GxWyEUkb
         LipYNGnex7vUfFUlCG9h9zXip6tqGL8zUof1xss0MPjoWgdEd656+rI+60EOrC93/LBm
         odro18Sd0VWRrX/F2R7sfy4eaeJytZX8W1viq7FYKsATiKrMT7sHi7R222JYVsuTy6oV
         7aV2Q4WMxUTa1mHVof2Z5f7YF9slphVcUIEtTn/FUKXJz7xhu4YxHErPPvxpwj5DQvwH
         3Dyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685129074; x=1687721074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8F+V6OXXzxlqAeAQ2S6nVyckBmSNTRDJrN1SofTqjrw=;
        b=T2KRzfpfdXoV0aUpOODZFz5YORtcqlvOnMccnq7+xXvTi7IBmecwI3fRRslYNE4Kpt
         9U8RrAknKHr+C+a28LLRY39CT3kDXSkMd2JXZr4CaDPuaVkY2h5GQ++AMyAobYMA7sJv
         sq2IygOp64JRfoY5g+2BVVPFJd11M9+1zkTesGt9aWwUnplAUk/bR/ioX9yTPlVeRhJ/
         Hftfs44RyyVZ2EQ6ObxC9An7LTKiL0DeFskrJVvm+BO641a/5wT81rxr4gWV8gqDO4p+
         dTkCI2+L1KpM1elmYj6+YSQvKgRqpZw5pS/lHxZcVMIyK63wL2CT4F1yZ98YuXJeeffQ
         Xj6Q==
X-Gm-Message-State: AC+VfDxg3B9KkGwzqAjdLrGyXnaS/PnT4mafy9/iiCJrmDckz4Q99cwa
        sWrb02nFFmgbXV+vjhv/kFfaCnf/aSGiiekOQfY=
X-Google-Smtp-Source: ACHHUZ5Aq9OT6SrKipriSxgDG/MKDVlnUMLqDL/khDIN89awyhwqpZYdgZodTSy7yiHuDKfAL/ibrOQy5o71MeAlngM=
X-Received: by 2002:a17:902:f550:b0:1ac:4a41:d38d with SMTP id
 h16-20020a170902f55000b001ac4a41d38dmr3398196plf.51.1685129073567; Fri, 26
 May 2023 12:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230526030559.326566-1-aford173@gmail.com> <20230526030559.326566-8-aford173@gmail.com>
 <20230526-cabana-humble-81e44944e378@spud>
In-Reply-To: <20230526-cabana-humble-81e44944e378@spud>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 26 May 2023 14:24:21 -0500
Message-ID: <CAHCN7xJdfO4+q071sur7wpVg+gU_Fzw9zfXvM9NDBFCN=Axiog@mail.gmail.com>
Subject: Re: [PATCH V8 7/7] dt-bindings: bridge: samsung-dsim: Make some flags optional
To:     Conor Dooley <conor@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, aford@beaconembedded.com,
        Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 1:19=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> Adam, Neil,
>
> I meant to get to this earlier today, but broken CI got in the way...
>
> On Thu, May 25, 2023 at 10:05:59PM -0500, Adam Ford wrote:
> > In the event a device is connected to the samsung-dsim
> > controller that doesn't support the burst-clock, the
> > driver is able to get the requested pixel clock from the
> > attached device or bridge.  In these instances, the
> > samsung,burst-clock-frequency isn't needed, so remove
> > it from the required list.
> >
> > The pll-clock frequency can be set by the device tree entry
> > for samsung,pll-clock-frequency, but in some cases, the
> > pll-clock may have the same clock rate as sclk_mipi clock.
> > If they are equal, this flag is not needed since the driver
> > will use the sclk_mipi rate as a fallback.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> >  .../bindings/display/bridge/samsung,mipi-dsim.yaml       | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/samsung,m=
ipi-dsim.yaml b/Documentation/devicetree/bindings/display/bridge/samsung,mi=
pi-dsim.yaml
> > index 9f61ebdfefa8..360fea81f4b6 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/samsung,mipi-dsi=
m.yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/samsung,mipi-dsi=
m.yaml
> > @@ -70,7 +70,9 @@ properties:
> >    samsung,burst-clock-frequency:
> >      $ref: /schemas/types.yaml#/definitions/uint32
> >      description:
> > -      DSIM high speed burst mode frequency.
> > +      DSIM high speed burst mode frequency when connected to devices
> > +      that support burst mode. If absent, the driver will use the pixe=
l
> > +      clock from the attached device or bridge.
>
> I'd rather this description did not say anything about drivers.
> How about:
>         If absent, the pixel clock from the attached device or bridge
>         will be used instead.

That makes sense.  I can do that.

"DSIM high speed burst mode frequency (optional). If absent, the pixel
clock from the attached device or bridge will be used instead."

> Or perhaps "must be used"? Ditto below.

"Must be" implies to me that the user needs to set something.  Are you
ok with the proposed suggestion above?
>
> Description aside, the removal seems to be backwards compatible - but
> can every device that this binding supports work using an "attached
> device or bridge", or are these properties going to be required for
> certain compatibles?

From what I can tell, the assumption is that the DSIM driver was
expecting it to attach to panels in the past.  With the additional
patch series, the DSIM can attach to bridge parts without a hard-coded
set of clocks.  I don't expect the existing Exynos devices to change,
but I also don't know what would preclude those SoC's from attaching
to a bridge should someone want to design a new product around them.

I'll wait a couple days for more feedback and send patch V2 with just
this patch since the rest of the series has been applied to the drm
branch.

adam

>
> Thanks,
> Conor.
>
> >
> >    samsung,esc-clock-frequency:
> >      $ref: /schemas/types.yaml#/definitions/uint32
> > @@ -80,7 +82,8 @@ properties:
> >    samsung,pll-clock-frequency:
> >      $ref: /schemas/types.yaml#/definitions/uint32
> >      description:
> > -      DSIM oscillator clock frequency.
> > +      DSIM oscillator clock frequency. If absent, the driver will
> > +      use the clock frequency of sclk_mipi.
> >
> >    phys:
> >      maxItems: 1
> > @@ -134,9 +137,7 @@ required:
> >    - compatible
> >    - interrupts
> >    - reg
> > -  - samsung,burst-clock-frequency
> >    - samsung,esc-clock-frequency
> > -  - samsung,pll-clock-frequency
> >
> >  allOf:
> >    - $ref: ../dsi-controller.yaml#
> > --
> > 2.39.2
> >
