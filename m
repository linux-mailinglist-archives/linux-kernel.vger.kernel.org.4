Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBEF6B7B57
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjCMPA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjCMPAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:00:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E9C44BB;
        Mon, 13 Mar 2023 07:59:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F8D6612AE;
        Mon, 13 Mar 2023 14:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91587C433A8;
        Mon, 13 Mar 2023 14:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678719577;
        bh=aor2P1UgUGdPxdi86bjLDcwfFhylwJzACimW7kInbvY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ohdN82SqGXRPJX3cyxSWQf7frIUq0JfGIXjdIMSBt+ODshEooBncUrzBJMWUejGvQ
         TVqEgCw1SAcdZhShx4HKRmVC6L/jo1TumrNmv9IYzJ6uGQqseaqe+WDQkSiz1X6EAA
         /v2Uuj4zRaNcWKEeeQdjMhl7OasG/jyZN5TFKVR4cik9TUFUl2im4NPDP/nvqosyZ9
         OnKo0gCMIuvWcubKsDfYYfBa4CNZXMhXxEVIByMn1gEzK3ALcplzpXbjE6JbtKl2Ak
         5PhETfpa+eNm/MkD9yBHkR6T8DYaHd2I9LoPQzTIzri9QWBAOSnJEhPGQ4ysBPrxma
         8TkJR2PgPrcUA==
Received: by mail-lj1-f181.google.com with SMTP id f16so12900362ljq.10;
        Mon, 13 Mar 2023 07:59:37 -0700 (PDT)
X-Gm-Message-State: AO0yUKV3XDVTalK/WgUTcAspfiOvNncUW33cBdgLnI1zAsTAYg5rrGxb
        EY0jyQLzuP5NRbxFBCm4bNqAZt8eb0nYrokbmA==
X-Google-Smtp-Source: AK7set9FaEtus4V62k/yFd+Xl5REF0wUiIoL+llixgQGs2HHbtV1FOqc3QoH58tm6Az3ceEjZOG27aSTKnhUcRUDXCY=
X-Received: by 2002:a2e:a36a:0:b0:295:9040:fb0b with SMTP id
 i10-20020a2ea36a000000b002959040fb0bmr10851484ljn.10.1678719575627; Mon, 13
 Mar 2023 07:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230220-display-v1-0-45cbc68e188b@baylibre.com> <20230220-display-v1-4-45cbc68e188b@baylibre.com>
In-Reply-To: <20230220-display-v1-4-45cbc68e188b@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 13 Mar 2023 22:59:23 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9zsX1CF6xf3TRm6+ZWkMNuXijYC_ErOHdgUi=O2kVVzA@mail.gmail.com>
Message-ID: <CAAOTY_9zsX1CF6xf3TRm6+ZWkMNuXijYC_ErOHdgUi=O2kVVzA@mail.gmail.com>
Subject: Re: [PATCH 04/21] dt-bindings: display: mediatek: dither: add binding
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
> Display Dither for MT8365 is compatible with another SoC.
> Then, add MT8365 binding along with MT8183 SoC.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml =
| 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
dither.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,d=
ither.yaml
> index 8ad8187c02d1..a7706cd65675 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.=
yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.=
yaml
> @@ -29,6 +29,7 @@ properties:
>                - mediatek,mt8186-disp-dither
>                - mediatek,mt8192-disp-dither
>                - mediatek,mt8195-disp-dither
> +              - mediatek,mt8365-disp-dither
>            - const: mediatek,mt8183-disp-dither
>
>    reg:
>
> --
> b4 0.10.1
