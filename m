Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642AF6BAA4F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 09:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjCOIB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 04:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjCOIBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 04:01:50 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395B06C8A5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 01:01:42 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id y5so2023243ybu.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 01:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678867301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLmw2pWkt+2UlVCNqfxLlIyJordQ48jgkm7yvgM5sos=;
        b=kfzb/qXnb2Lz2It2VeCU2JPOke00lu76iOWT0N8lzXzxgMgNVNJo8c992euigO3pOg
         2cTHApKRAs0MW4AwdKmoVT4E4lTpbiyLxDNjYykxKPYMO82GHOnWvLWC8eKRvhL3LBdX
         0GgIpT3UnwnxLJGXs830kO/zF3o+VhktcReF1q88KLkn2rG7/9fSv5hJxIEgVsOXZA+T
         V68WfMU1jJi88lfhhD2mNqlQoYp+CdcBAi2HBFu+egrPostJEcOHf4/w8AN6L9cdMRQf
         GzNRgl2nZ098e2UH8AS+5knHhmlK+uMTSlMPnkOYBJWhmuY9qF7ZIshgWM9U9lMG8YFU
         G49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678867301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLmw2pWkt+2UlVCNqfxLlIyJordQ48jgkm7yvgM5sos=;
        b=rTGx0vNPR4aCXhaATQkd6J6ir17oUNPxR37X/gJxQvj/0Q021jvr67sNx+48jnc4mk
         qKxf8hM2047GS/dwdn6DE1T5HyNfJH83i+tUOTYqstL9+ECLOzW1qWtq3Rk2KDCtzrOt
         +mKCRIczGBE4ek31umQXb6eSTtNy4u1u2tvTxwtgJZPy2J9d8puLHdDn+r8Q4dNKAVlE
         55u814Jd91W6ESk1GW5G+liCtIslzbRdB6T0XkZHLIp5fsjVVuE6Ht5WUgX6STIhMaL5
         7eTyplww6YxoOq32wy1iJicQSgiAojAT34zGPgJIr90QJ6MNwtaw1XufhXZLzRNqdWTM
         Di5g==
X-Gm-Message-State: AO0yUKW83IvJYGqsaW8z3AsN36xxr1Us+JRU44j622RuiYzBkd3RhnYx
        D68MHOnxWa1pis3zT60KU49uDKKm+FUYglPBjQ/bgQ==
X-Google-Smtp-Source: AK7set9LpeP+JeZx2ldhs9oY8bVS2Fz4YRdUKtYi/IMSTV0qIeC8WW+E425cUJjwgqA/oB9hoYpKIBLTZzuVNM14JVg=
X-Received: by 2002:a05:6902:10e:b0:98e:6280:74ca with SMTP id
 o14-20020a056902010e00b0098e628074camr23087865ybh.1.1678867301383; Wed, 15
 Mar 2023 01:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230220-display-v1-0-45cbc68e188b@baylibre.com>
 <20230220-display-v1-15-45cbc68e188b@baylibre.com> <ea8aaec1-948d-832b-ff24-b35abd3a59a2@linaro.org>
In-Reply-To: <ea8aaec1-948d-832b-ff24-b35abd3a59a2@linaro.org>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 15 Mar 2023 09:01:30 +0100
Message-ID: <CAFGrd9p0qmfypP2DDJN1vEhJYciVfgFXZWLmvQOdpE=qgSDvKQ@mail.gmail.com>
Subject: Re: [PATCH 15/21] dt-bindings: soc: mediatek: add display mutex for
 MT8365 SoC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        Guillaume La Roque <glaroque@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Fabien Parent <fparent@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le ven. 10 mars 2023 =C3=A0 09:39, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> a =C3=A9crit :
>
> On 09/03/2023 15:23, Alexandre Mergnat wrote:
> > Add compatible for the MT8365 SoC.
> >
> > Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> > ---
> >  Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml | 1=
 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mu=
tex.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.ya=
ml
> > index ca0ca549257d..931d66893dff 100644
> > --- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yam=
l
> > +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yam=
l
> > @@ -34,6 +34,7 @@ properties:
> >        - mediatek,mt8186-mdp3-mutex
> >        - mediatek,mt8192-disp-mutex
> >        - mediatek,mt8195-disp-mutex
> > +      - mediatek,mt8365-disp-mutex
>
> All these look compatible. Either make mt8635 compatible with something
> or even rework entire list and make everything compatible.

All of them use "mtk_mutec.c" but have specific data.

      .data =3D &mt8173_mutex_driver_data},
    { .compatible =3D "mediatek,mt8183-disp-mutex",
      .data =3D &mt8183_mutex_driver_data},
    { .compatible =3D "mediatek,mt8186-disp-mutex",
      .data =3D &mt8186_mutex_driver_data},
    { .compatible =3D "mediatek,mt8186-mdp3-mutex",
      .data =3D &mt8186_mdp_mutex_driver_data},
    { .compatible =3D "mediatek,mt8192-disp-mutex",
      .data =3D &mt8192_mutex_driver_data},
    { .compatible =3D "mediatek,mt8195-disp-mutex",
      .data =3D &mt8195_mutex_driver_data},
    { .compatible =3D "mediatek,mt8365-disp-mutex",
      .data =3D &mt8365_mutex_driver_data},

I don't see any SoC compatible with mt8635, and I have no idea which
rework you have in mind. Can you please point me an example ?

Thanks
Alex
