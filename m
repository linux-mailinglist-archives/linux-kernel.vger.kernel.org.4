Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCB372D607
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 02:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbjFMAPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 20:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239092AbjFMAOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 20:14:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FDC1FC4;
        Mon, 12 Jun 2023 17:12:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 092356305B;
        Tue, 13 Jun 2023 00:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A60C433AC;
        Tue, 13 Jun 2023 00:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686615156;
        bh=fgQezU9Uhtd/cvT8fMXHuHFSkNX/SBX6F17ynk+Li7c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qpA4jI42/zyo7xTLzS4PdiFvs6Shs4bsvDP7FZ95DpUGkl5Mjs6Z7Qg28S75n5pS6
         RR6Me5RUfUoCZTeWuhzve2bSQiYsVRHO35Oim0DLaEalBT9u71eJ+fPNkYqcn4uBeM
         SE/Y+sgyd/s3KddBGvibVr9EPqrMspPYGWom/RzVYoQEauETXMjb6JWUu2rFVwdpg4
         XjssPWBFj+pFXbXSB11GOincfTGTzmma7Rb5hnii5wg0JtTyHZBdrGY+wZRiGpSchj
         FHTYgcWt7T0DGpx+svuZ+z9y1s+A8cef1LzLrzyC3cC4CMvW+RYRVep3SScEUodCym
         48ZVwvYB5SHWA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4f611ac39c5so6132978e87.2;
        Mon, 12 Jun 2023 17:12:36 -0700 (PDT)
X-Gm-Message-State: AC+VfDw1Z5vunOMqExez1R/6rXbsJpRKVZsScB0TFLmEGFAcsnaZze5n
        slO4uHNrQayDY4B3M8AT34VNDeOlnhnslRZTjw==
X-Google-Smtp-Source: ACHHUZ5DoNUKSvAIXqJyVR/dJqHjMXAJmhqi/nRReR8o6lChwcUCm3nF+VoA8dUPGUnBoXAPQ8cGXyQokNL17p9GqwE=
X-Received: by 2002:a2e:9012:0:b0:2af:30d8:527f with SMTP id
 h18-20020a2e9012000000b002af30d8527fmr3553372ljg.19.1686615154438; Mon, 12
 Jun 2023 17:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-4-angelogioacchino.delregno@collabora.com> <02a588ca-680f-ab45-1005-768d5b5db252@gmail.com>
In-Reply-To: <02a588ca-680f-ab45-1005-768d5b5db252@gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 13 Jun 2023 08:12:22 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9Heu3yzwbJgEpOwqabwpyTXMByFgcpoBojaM7MaRTUnQ@mail.gmail.com>
Message-ID: <CAAOTY_9Heu3yzwbJgEpOwqabwpyTXMByFgcpoBojaM7MaRTUnQ@mail.gmail.com>
Subject: Re: [PATCH 03/27] dt-bindings: display: mediatek: dpi: Add compatible
 for MediaTek MT6795
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, ck.hu@mediatek.com,
        jitao.shi@mediatek.com, xinlei.lee@mediatek.com,
        houlong.wei@mediatek.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@collabora.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matthias:

Matthias Brugger <matthias.bgg@gmail.com> =E6=96=BC 2023=E5=B9=B45=E6=9C=88=
29=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8810:07=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi Chun-Kuang Hu,
>
> Can you help to merge the missing DT-binding patches in this series?

Apply display binding of this series to  mediatek-drm-next [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Thanks a lot,
> Matthias
>
> On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
> > Add a compatible string for the MediaTek Helio X10 MT6795 SoC, using
> > the same parameters as MT8183.
> >
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@co=
llabora.com>
> > ---
> >   .../display/mediatek/mediatek,dpi.yaml        | 23 +++++++++++-------=
-
> >   1 file changed, 14 insertions(+), 9 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/display/mediatek/mediate=
k,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp=
i.yaml
> > index d976380801e3..803c00f26206 100644
> > --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.y=
aml
> > +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.y=
aml
> > @@ -17,15 +17,20 @@ description: |
> >
> >   properties:
> >     compatible:
> > -    enum:
> > -      - mediatek,mt2701-dpi
> > -      - mediatek,mt7623-dpi
> > -      - mediatek,mt8173-dpi
> > -      - mediatek,mt8183-dpi
> > -      - mediatek,mt8186-dpi
> > -      - mediatek,mt8188-dp-intf
> > -      - mediatek,mt8192-dpi
> > -      - mediatek,mt8195-dp-intf
> > +    oneOf:
> > +      - enum:
> > +          - mediatek,mt2701-dpi
> > +          - mediatek,mt7623-dpi
> > +          - mediatek,mt8173-dpi
> > +          - mediatek,mt8183-dpi
> > +          - mediatek,mt8186-dpi
> > +          - mediatek,mt8188-dp-intf
> > +          - mediatek,mt8192-dpi
> > +          - mediatek,mt8195-dp-intf
> > +      - items:
> > +          - enum:
> > +              - mediatek,mt6795-dpi
> > +          - const: mediatek,mt8183-dpi
> >
> >     reg:
> >       maxItems: 1
