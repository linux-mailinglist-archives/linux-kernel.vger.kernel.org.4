Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FF56BAA97
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 09:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjCOIRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 04:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjCOIRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 04:17:38 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DA869233
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 01:17:37 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-536af432ee5so354131217b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 01:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678868256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cFDHkDhzKIIZdfQe731ScSWbZ+pa4Y9mnpJSsgdej0=;
        b=Cqc1RbAoAG7SPoHu55E0XZTM+z8BoLE9CzEd+0gppfbO0rvJ2HIPlImz3fPiqXHwje
         0fylYt8YoL+Gqaz/wp/yr9FDY7oRovbssk+gZAtfdzJ8JiqF/fFjweB/p7mubvXKXdvg
         TrMAIk1i5uLDH8eB1VxrwaegWVd9al7bQPhlSbOFVxdC4ByBhbQZo2BA74lasOO4aiW0
         seUHl2jWTwnySkP4StLrYKWKwEqTurfN0Skj7FyUEbPOuInFam228Kc3LyPgyEarQ1k9
         UYP++NomYQE1tVK4OpR60XKwJGPVk0d7cfVCZ+WYms8b8MdYDcddn9RTbWnl1xg8zFVI
         aWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678868256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cFDHkDhzKIIZdfQe731ScSWbZ+pa4Y9mnpJSsgdej0=;
        b=fFmQm2BpdDv3uBJAYYErpQ7bU/tfMiZHWVn3BeMnrwMGAC9WNamG2hOwVr5cnj+CJD
         R3jfmgoddXOHixy8wPHjJck0a2D1T3/SCWAHdJzx54E7qCgewqc4CCgJvsvARW8fKSAB
         H0j8cbqoDYvJj6IIpg/Folsp2KLZKqy/nl9n+iNYMcafGa4duq45f6l04tOgcTx7hUkE
         IVtzNnj3UqoIt6FlibP5ovnrlSgBhNgiciMNKYFzLZP5554Fzef2wWzLpJbeweTjrzfe
         eiZaONOn9ZZs9GVBFmxAdW6O1Fy0MY1m3r6iiakp+Zlf7D765Xg+55udI5WgCLPhOq/K
         KoHA==
X-Gm-Message-State: AO0yUKUp+72OSnjIoJtSwLBI9PGF9+iLPl9bv+xqVJOouz2f7rX/8TCK
        l1hZsWsdC8HSbWoNknatwqHiu70uablVsOr3McPuEQ==
X-Google-Smtp-Source: AK7set+vWYd9VC1u2ZYEyLnKAP2XlPt0kks70Y2AA7nxYNvRmd9OC+0WRfKFUao5ZMBw0zKT8aiEIEKpKMidYl4M3XU=
X-Received: by 2002:a81:b247:0:b0:52f:24ac:9575 with SMTP id
 q68-20020a81b247000000b0052f24ac9575mr26775509ywh.3.1678868256601; Wed, 15
 Mar 2023 01:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230220-display-v1-0-45cbc68e188b@baylibre.com>
 <20230220-display-v1-15-45cbc68e188b@baylibre.com> <ea8aaec1-948d-832b-ff24-b35abd3a59a2@linaro.org>
 <CAFGrd9p0qmfypP2DDJN1vEhJYciVfgFXZWLmvQOdpE=qgSDvKQ@mail.gmail.com>
In-Reply-To: <CAFGrd9p0qmfypP2DDJN1vEhJYciVfgFXZWLmvQOdpE=qgSDvKQ@mail.gmail.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 15 Mar 2023 09:17:25 +0100
Message-ID: <CAFGrd9pHB_ACHRHHv41cX+hCoC6ZxoJc=x52wt_=WQcDHWf29g@mail.gmail.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe "oneOf" should be added at least ?

  compatible:
    oneOf:
      - enum:

Regards,
Alex

Le mer. 15 mars 2023 =C3=A0 09:01, Alexandre Mergnat
<amergnat@baylibre.com> a =C3=A9crit :
>
> Le ven. 10 mars 2023 =C3=A0 09:39, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> a =C3=A9crit :
> >
> > On 09/03/2023 15:23, Alexandre Mergnat wrote:
> > > Add compatible for the MT8365 SoC.
> > >
> > > Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> > > ---
> > >  Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml |=
 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,=
mutex.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.=
yaml
> > > index ca0ca549257d..931d66893dff 100644
> > > --- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.y=
aml
> > > +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.y=
aml
> > > @@ -34,6 +34,7 @@ properties:
> > >        - mediatek,mt8186-mdp3-mutex
> > >        - mediatek,mt8192-disp-mutex
> > >        - mediatek,mt8195-disp-mutex
> > > +      - mediatek,mt8365-disp-mutex
> >
> > All these look compatible. Either make mt8635 compatible with something
> > or even rework entire list and make everything compatible.
>
> All of them use "mtk_mutec.c" but have specific data.
>
>       .data =3D &mt8173_mutex_driver_data},
>     { .compatible =3D "mediatek,mt8183-disp-mutex",
>       .data =3D &mt8183_mutex_driver_data},
>     { .compatible =3D "mediatek,mt8186-disp-mutex",
>       .data =3D &mt8186_mutex_driver_data},
>     { .compatible =3D "mediatek,mt8186-mdp3-mutex",
>       .data =3D &mt8186_mdp_mutex_driver_data},
>     { .compatible =3D "mediatek,mt8192-disp-mutex",
>       .data =3D &mt8192_mutex_driver_data},
>     { .compatible =3D "mediatek,mt8195-disp-mutex",
>       .data =3D &mt8195_mutex_driver_data},
>     { .compatible =3D "mediatek,mt8365-disp-mutex",
>       .data =3D &mt8365_mutex_driver_data},
>
> I don't see any SoC compatible with mt8635, and I have no idea which
> rework you have in mind. Can you please point me an example ?
>
> Thanks
> Alex
