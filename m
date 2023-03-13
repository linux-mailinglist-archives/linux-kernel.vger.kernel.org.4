Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59BB6B7B91
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjCMPJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjCMPJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:09:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6376F49F;
        Mon, 13 Mar 2023 08:09:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFC1D6133F;
        Mon, 13 Mar 2023 15:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202E5C433AA;
        Mon, 13 Mar 2023 15:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678720164;
        bh=ABGxWlMLqbyavyMKxfAJ8Yv5/bIE4zdXAaxBqDMvysU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UOK8+pPJnG1oG72RthJEFWUXiwBteXj9z7goUmZjJyuoFCrla1DIG+1l38K+v+H2C
         ZLWLbIx+PyRlzubEWGyr9Ebmo8yjjbnNRL0RvToc+qH/zjQvesaeLam1r3juwHdYR6
         thokqpK3Sk9e43sXmeOi3zbKTNwz5CxQ4guel8dojAC+6PmvpihPTqSSSmrsu0Bu/+
         bhu7gsGexK949o6DN5v4cWzQZWE7mEndUFGWjgesPyhLS7GfpETnNBfQs1Ucv2tZft
         aYUaFPdHLdT8xWfI2Ex2YSTxIUbmt3BTjvonCoM+omnx87EyJSGKZUCIcDLrE8di4N
         xGNeS1cDCcv3w==
Received: by mail-lj1-f170.google.com with SMTP id g18so12983962ljl.3;
        Mon, 13 Mar 2023 08:09:24 -0700 (PDT)
X-Gm-Message-State: AO0yUKX8vo3ATECEX4En4Ky2VHck6jEFklGL7slRM/vBNbkP0TlgQ60K
        hL5s7misekW4aNxveY0VBMdKYZXU9TYbsbE46w==
X-Google-Smtp-Source: AK7set87aBjxPKP90yGcSHiuYgmixt1jWtk6mNAEmALcrl1Kxtk5Rvp1SIvV36Rvbv2XbdaMPVz/gU4SP9I5l+DwFNU=
X-Received: by 2002:a2e:aa1c:0:b0:298:7998:4e36 with SMTP id
 bf28-20020a2eaa1c000000b0029879984e36mr4244033ljb.10.1678720162162; Mon, 13
 Mar 2023 08:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230220-display-v1-0-45cbc68e188b@baylibre.com> <20230220-display-v1-10-45cbc68e188b@baylibre.com>
In-Reply-To: <20230220-display-v1-10-45cbc68e188b@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 13 Mar 2023 23:09:10 +0800
X-Gmail-Original-Message-ID: <CAAOTY__oYGD4KwK8enhy4WGiyJ_aoAPm2yTVY4vZodkAkaVdDQ@mail.gmail.com>
Message-ID: <CAAOTY__oYGD4KwK8enhy4WGiyJ_aoAPm2yTVY4vZodkAkaVdDQ@mail.gmail.com>
Subject: Re: [PATCH 10/21] dt-bindings: display: mediatek: rdma: add binding
 for MT8365 SoC
To:     Alexandre Mergnat <amergnat@baylibre.com>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alexandre:

Alexandre Mergnat <amergnat@baylibre.com> =E6=96=BC 2023=E5=B9=B43=E6=9C=88=
9=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8810:23=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Display Data Path Read DMA for MT8365 is compatible with another SoC.
> Then, add MT8365 binding along with MT8183 SoC.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml | =
1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
rdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdm=
a.yaml
> index 0882ae86e6c4..3bc914785976 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.ya=
ml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.ya=
ml
> @@ -40,6 +40,7 @@ properties:
>            - enum:
>                - mediatek,mt8186-disp-rdma
>                - mediatek,mt8192-disp-rdma
> +              - mediatek,mt8365-disp-rdma
>            - const: mediatek,mt8183-disp-rdma
>
>    reg:
>
> --
> b4 0.10.1
