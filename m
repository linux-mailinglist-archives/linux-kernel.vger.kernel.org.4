Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804D76D0CFB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjC3RiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjC3RiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:38:01 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656C7CDF9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 10:38:00 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-53d277c1834so367727757b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 10:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1680197879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XDB6bTe9xJuphUqwevJuf9q/6RlzAPG9D8j9n2M9eI=;
        b=OjP+fHOJg/qk/BlFRiLShClpzDz5RIhfJx4oJR+J6AEhaszRz0Q5mEaxRpZkd5ocUU
         Pydm4D7geWRHXotQWusDrJeDK239l9eTmD3nH+hbdF/E+kATlZQpMPIukTeVxq0iU8Zt
         zs7csmBHA4HWxFkMZzcYDKsCymsF4Jr3u9Og0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680197879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XDB6bTe9xJuphUqwevJuf9q/6RlzAPG9D8j9n2M9eI=;
        b=kt3xQcJIjIgYPMd2gRYwgNjrlWNwSqy45SRVXCH6Om25Oq2QQh89EWEwcyc+DFNQyG
         GcCCHAsry9VIGphGgZMvPOGoRmaNGldM94uwoQqQkaSbT2huvejGMTxD9Xi3xY6dVPIu
         jBl+3Zez3X9Bw5nLpQk4erW+Oa6y3Agrvkq/4VPb36xOiaV8g5bHgdHM3GCtDUz2CI5c
         WO5wCJ8tGaJGSgtLDStLZcTJpYwfbW8MYuTAFitX+LIjb7D4jlkfrwkxT/qBxoEbyUps
         3q4DF+Gr78vVK9Lz2oR5Jn1ZThtfuj3ZGUSBNChMJWWHWKARCBxOtEnMkeneYYfA/gyi
         3s1w==
X-Gm-Message-State: AAQBX9e65wLvaG6vZIO3+63gaqVa/ohZ9llI3qPJOpcoMjcIobvDY4qV
        Y8RYsKeD925a7OL4mUtEwvnNuZYHTptW9KnJJeTntw==
X-Google-Smtp-Source: AKy350bck9a7Ac/7Hxwga/BHJXtbB6f6e+9uTSHoWqisMz7/ZongXR2S56Glacab1PDzNjzatDBkzP3s/3oiG7MFHD4=
X-Received: by 2002:a81:ad04:0:b0:52e:e095:d840 with SMTP id
 l4-20020a81ad04000000b0052ee095d840mr800164ywh.0.1680197879519; Thu, 30 Mar
 2023 10:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230330101752.429804-1-francesco@dolcini.it> <20230330101752.429804-2-francesco@dolcini.it>
 <CAMty3ZAQPEnCgj9r+tsuqiOzRzHPnKSEXcDqE7LKHH16Zu2Wvw@mail.gmail.com> <ZCWkdc+x0LXDSohj@francesco-nb.int.toradex.com>
In-Reply-To: <ZCWkdc+x0LXDSohj@francesco-nb.int.toradex.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 30 Mar 2023 23:07:47 +0530
Message-ID: <CAMty3ZDwj5OuBzTBHrBitS0qD8QEv8=80YR2zZLDnL_nrmd3fg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: display: bridge: sn65dsi83: Add DSI
 video mode
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 8:32=E2=80=AFPM Francesco Dolcini <francesco@dolcin=
i.it> wrote:
>
> On Thu, Mar 30, 2023 at 07:56:26PM +0530, Jagan Teki wrote:
> > On Thu, Mar 30, 2023 at 3:48=E2=80=AFPM Francesco Dolcini <francesco@do=
lcini.it> wrote:
> > >
> > > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > >
> > > SN65DSI8[34] device supports burst video mode and non-burst video mod=
e
> > > with sync events or with sync pulses packet transmission as described=
 in
> > > the DSI specification.
> > >
> > > Add property to select the expected mode, this allows for example to
> > > select a mode that is compatible with the DSI host interface.
> > >
> > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > ---
> > >  .../devicetree/bindings/display/bridge/ti,sn65dsi83.yaml  | 8 ++++++=
++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65=
dsi83.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.=
yaml
> > > index 48a97bb3e2e0..ebee16726b02 100644
> > > --- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.y=
aml
> > > +++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.y=
aml
> > > @@ -35,6 +35,14 @@ properties:
> > >    vcc-supply:
> > >      description: A 1.8V power supply (see regulator/regulator.yaml).
> > >
> > > +  dsi-video-mode:
> > > +    description: |
> > > +      0 - burst-mode
> > > +      1 - non-burst with sync event
> > > +      2 - non-burst with sync pulse
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    enum: [0, 1, 2]
> >
> > I'm thinking this can go to dsi common code since the video modes are
> > common across all controllers and make the core initialize the default
> > and update if any sink devices are willing to change the modes. Sound
> > like a big move but worth useful.
>
> Not sure I understood where do you want to move this.

Yes, it can be new may be
Documentation/devicetree/bindings/display/dsi-device.yaml

>
> In any case this is something about the display side of the DSI video
> connection, with the bridge as a special case, not about the controller.
> To my understanding the controller is supposed to support all the modes.

Yes, that is what I'm saying. DSI sink will send this mode via
mode_flags and the controller act accordingly.  The point here is
these modes are generic across all DSI sink devices so having common
bindings can make it easy for all devices to use. As I said it can be
new, but worth trying - anyway let's see how others are commenting on
this.

Thanks,
Jagan.
