Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA3F713B7F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 20:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjE1SOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 14:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjE1SOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 14:14:23 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7382DA7;
        Sun, 28 May 2023 11:14:22 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so2265936a12.1;
        Sun, 28 May 2023 11:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685297662; x=1687889662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KylLFO78aG85tFCA5dfgDJk9LDpZhsbsPaumEd9VTYQ=;
        b=dljeEtgXM7OWMKJz5q2ffWr4AzsROAeTGEpXJFO5tmLPoipmiKFrsu52RpFHS17llJ
         trraqNJOi0jewEQMzjIKlOS4ZMhc3DHUk2LaWMAEE605RJu0vamfp+OX6UwGYZerHQRH
         SSbadMRH5N5GOVwgUCeUYBiU0a+VMcoA3JmTYQcdg/UPsbVS8R8+qRjk7jf+Xxrihn/a
         6pKEb4cAlxKCKIlPUp3M1pyLSTeo5F+8DVu9N/uFHHoAu8Bx+GlNZ7LoAhq1XaMxvq1d
         AJJjmpg/m7eRUgr67TYmKGbBDG7BgxT8EXyOPltqTeEd24rwitHW6dAPIOX9aggZhsTf
         0l/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685297662; x=1687889662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KylLFO78aG85tFCA5dfgDJk9LDpZhsbsPaumEd9VTYQ=;
        b=LyLASB/ZzJiBxCG5E2QdCStTqXuBKZo8hJf9MZfACwusQFGTm56HdkXcCVdOdR28bh
         6bFURazgNCvYff83e/Usf6dB/lhcwJi0UZCSekeLx61x79rdQBZbPHHJTzlcVUGDRZQN
         2hTcwCMJSkSOcmAJ+9nNszbSB8FdyyD2K20PvQdnRsXc05Kgtgey0oIHgrTF6isU537/
         27u/hA84edVlwGIf+SbCcT+iytfyM47y+VoBFf4jDDlYvEI1YLdJxK5UiudZNdLcjXVz
         gzhuDrwEq0xVF6+ux8fA+EE+2eiZTxDuSEudK230+jiUeJD7c16Q+hmPKB9J5oHdxi+B
         hvIg==
X-Gm-Message-State: AC+VfDxdISJDXs3K9QVK5fNThsODsJ1mh5nDJKgTjfAHe+rg3TEre4MJ
        mUi+l0EZv8KX78ljiB3Xz+scd7sBdI++MEbXUoo=
X-Google-Smtp-Source: ACHHUZ5rZHZVsQ7sM0uVNgsj9/lGptUCRRcH11dVAV7DRFVkW0y7/XGyIu5h1rC5D3P0L69OKDYf7jIgLbHzPjDpTqI=
X-Received: by 2002:a17:902:9b84:b0:1ae:5914:cbec with SMTP id
 y4-20020a1709029b8400b001ae5914cbecmr9237690plp.10.1685297661614; Sun, 28 May
 2023 11:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230528132727.3933-1-aford173@gmail.com> <CAMty3ZB=XfMr7k31yHzZ+YHFxT0ifCbmR4+s5yw+YgTSJE0Jxg@mail.gmail.com>
In-Reply-To: <CAMty3ZB=XfMr7k31yHzZ+YHFxT0ifCbmR4+s5yw+YgTSJE0Jxg@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 28 May 2023 13:14:10 -0500
Message-ID: <CAHCN7xLUEYY0ZWVCO8SZSkPj8um7hj3uOtyyt+iWGLkc_XXdxw@mail.gmail.com>
Subject: Re: [PATCH V2] dt-bindings: bridge: samsung-dsim: Make some flags optional
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     dri-devel@lists.freedesktop.org, aford@beaconembedded.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Inki Dae <inki.dae@samsung.com>,
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
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sun, May 28, 2023 at 8:34=E2=80=AFAM Jagan Teki <jagan@amarulasolutions.=
com> wrote:
>
> On Sun, May 28, 2023 at 6:57=E2=80=AFPM Adam Ford <aford173@gmail.com> wr=
ote:
> >
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
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> > V2:  Split from driver series.  Re-word updates for burst
> > and pll-clock frequency.
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/samsung,m=
ipi-dsim.yaml b/Documentation/devicetree/bindings/display/bridge/samsung,mi=
pi-dsim.yaml
> > index 9f61ebdfefa8..06b6c44d4641 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/samsung,mipi-dsi=
m.yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/samsung,mipi-dsi=
m.yaml
> > @@ -70,7 +70,9 @@ properties:
> >    samsung,burst-clock-frequency:
> >      $ref: /schemas/types.yaml#/definitions/uint32
> >      description:
> > -      DSIM high speed burst mode frequency.
> > +      DSIM high speed burst mode frequency.  If absent,
> > +      the pixel clock from the attached device or bridge
> > +      will be used instead.
> >
> >    samsung,esc-clock-frequency:
> >      $ref: /schemas/types.yaml#/definitions/uint32
> > @@ -80,7 +82,8 @@ properties:
> >    samsung,pll-clock-frequency:
> >      $ref: /schemas/types.yaml#/definitions/uint32
> >      description:
> > -      DSIM oscillator clock frequency.
> > +      DSIM oscillator clock frequency. If absent, the clock frequency
> > +      of sclk_mipi will be used instead.
>
> Maybe this explicit comment won't require as it is not listed in "require=
d"

I mostly listed it here to explain why it's being removed from the
required list and what happens if it's missing.
>
> Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
