Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DFC6D3C1D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 05:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjDCD0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 23:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDCD0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 23:26:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BD56EB7;
        Sun,  2 Apr 2023 20:26:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF423611E4;
        Mon,  3 Apr 2023 03:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57913C433A4;
        Mon,  3 Apr 2023 03:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680492373;
        bh=hrX4wjuNXtUa4it9dS1gD+x/opOelCsgKzVa5rmkya8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lNZ2cNh5LZpMSXs0x/GvA01FLXnCCZrRUi8x0zt9XdLbswQFhwKt1GrMX6DdqCKrV
         +XIeXxupFEE3HyaVh2Uv9dqBn2fEooSbgytsHRqpxQ557IYsvYpAc1vqR8whoL6iDY
         179fpo8Q1SlLLItRyriF6rwe+bFJ6BgokR/EvdNeDhMDCoLuunJ5CyTN8xdCDBjIpI
         fWyn4lUm9XJWSYwnn0eowVtdsr2Nm9CKQ7k+Mosa301wJSbOG3hNwEjAnZXkPfbyDy
         5YmtOs6xWfmvr5qr50umrnSvWNJ9LnmeowmgVHghW+7yKc55frTA+kLUhP3AJWty7i
         dXMuJIQC5TbVA==
Received: by mail-lf1-f53.google.com with SMTP id q16so36199496lfe.10;
        Sun, 02 Apr 2023 20:26:13 -0700 (PDT)
X-Gm-Message-State: AAQBX9fBO0Lnjejao9Q6HfXWW371IAFDPwwYTR9qAEe+Dk2qEnYktgnw
        5iKnd+stkTV5zf4wEeBxwAOmGrugdRlQHuF3Wg==
X-Google-Smtp-Source: AKy350YF5//fW3gKfi6NnVQPdCCMScWgB0PgA7jqaFFkilLrWcB2n9ijboh/wvLC2SKCsSxOdK5aX4P6/95BuMo1yus=
X-Received: by 2002:ac2:596a:0:b0:4e8:6261:58c2 with SMTP id
 h10-20020ac2596a000000b004e8626158c2mr9881249lfp.7.1680492371303; Sun, 02 Apr
 2023 20:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230220-display-v1-0-45cbc68e188b@baylibre.com>
 <20230220-display-v1-1-45cbc68e188b@baylibre.com> <CAAOTY_8G03TpY88hMmUgbq5E6P2Y8h5a4DB5T72qfNG6CA+NQA@mail.gmail.com>
 <c8861fda-63c6-7951-29a7-9d29a73e8f3e@gmail.com>
In-Reply-To: <c8861fda-63c6-7951-29a7-9d29a73e8f3e@gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 3 Apr 2023 11:25:59 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-2eba2JYZdLPutCkLEWgEgOBrXQ4pqpasxu=d1QMWvUg@mail.gmail.com>
Message-ID: <CAAOTY_-2eba2JYZdLPutCkLEWgEgOBrXQ4pqpasxu=d1QMWvUg@mail.gmail.com>
Subject: Re: [PATCH 01/21] dt-bindings: display: mediatek: aal: add binding
 for MT8365 SoC
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, David Airlie <airlied@gmail.com>,
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
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matthias:

Matthias Brugger <matthias.bgg@gmail.com> =E6=96=BC 2023=E5=B9=B43=E6=9C=88=
31=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8810:55=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi Chun-Kuang Hu,
>
> On 13/03/2023 16:02, Chun-Kuang Hu wrote:
> > Hi, Alexandre:
> >
> > Alexandre Mergnat <amergnat@baylibre.com> =E6=96=BC 2023=E5=B9=B43=E6=
=9C=889=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8810:23=E5=AF=AB=E9=81=
=93=EF=BC=9A
> >>
> >> Display Adaptive Ambient Light for MT8365 is compatible with another S=
oC.
> >> Then, add MT8365 binding along with MT8183 SoC.
> >
> > Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> >
>
> I'm a bit puzzled that you give your reviewed by while I would have expec=
ted
> that you will take the display binding patches. Will you take these or do=
 you
> want someone else to take them?

I usually apply whole series together, and I've question about
"[07/21] dt-bindings: display: mediatek: dpi: add binding for MT8365"
in this series. This is just the first version, so maybe I would apply
partial patches in later version.

Regards,
Chun-Kuang.


>
> Regards,
> Matthias
>
> >>
> >> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> >> ---
> >>   Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml=
 | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediat=
ek,aal.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,a=
al.yaml
> >> index d4d585485e7b..d47bc72f09c0 100644
> >> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.=
yaml
> >> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.=
yaml
> >> @@ -33,6 +33,7 @@ properties:
> >>                 - mediatek,mt8186-disp-aal
> >>                 - mediatek,mt8192-disp-aal
> >>                 - mediatek,mt8195-disp-aal
> >> +              - mediatek,mt8365-disp-aal
> >>             - const: mediatek,mt8183-disp-aal
> >>
> >>     reg:
> >>
> >> --
> >> b4 0.10.1
