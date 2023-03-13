Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F8B6B7B51
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjCMO7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjCMO7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:59:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BAB28EB9;
        Mon, 13 Mar 2023 07:58:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 435EF6131F;
        Mon, 13 Mar 2023 14:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1851C4339C;
        Mon, 13 Mar 2023 14:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678719506;
        bh=jxq03yf7Xaet9VvXtMUxebKs/p10RnENOfVyO8UP0Lk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DLFsLjwo+BuHJT1ZiIB6bTBvN4gZMT25idQ6lmBXeqJaNIAChRP+0fDpi3hUr6C9Q
         oOMKZXCBRRoUSXHlmcEnePsR06R6o2cr+/GSXH6tE2nKh6nXZpVl/MG4QLbquyNKDC
         LWITduQsZqaKKdGI/crSA/t0VYnNvkz9V/TCHY02eLUFMgJiBvsQX/Za52pNDiF2l+
         uGQscnQyTocAPZSec3mVWpRxME/rEL9V9SOwumrPhDYcmxmBkGsMAK6D2D7u9WFagf
         YKdUJqMkT7E7eBtKI8izB8gWyG14cYQuPpUZxwUtX8q7ul4S8AchypF2U6knDo8Uhr
         76rn2PJNZ11Iw==
Received: by mail-lj1-f177.google.com with SMTP id h3so12902267lja.12;
        Mon, 13 Mar 2023 07:58:26 -0700 (PDT)
X-Gm-Message-State: AO0yUKXdnikVg6UzXb9csP59hiyl1YpZRU9OU9LhkXwgFG8QKW+r0ivZ
        e6yp4cPV++bKW3er3CjkcaEyRNH7XD0g0QB2mA==
X-Google-Smtp-Source: AK7set93ppgf/8A7GowcaF9AMzop4M7RVXL14Ayxlc7lTWoPuXT4WNBru8d2Tw5m+TfhTYQd+XOp94bBcFBQulE38wc=
X-Received: by 2002:a2e:a36a:0:b0:295:9040:fb0b with SMTP id
 i10-20020a2ea36a000000b002959040fb0bmr10850100ljn.10.1678719504691; Mon, 13
 Mar 2023 07:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230220-display-v1-0-45cbc68e188b@baylibre.com> <20230220-display-v1-3-45cbc68e188b@baylibre.com>
In-Reply-To: <20230220-display-v1-3-45cbc68e188b@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 13 Mar 2023 22:58:12 +0800
X-Gmail-Original-Message-ID: <CAAOTY__Qam0O+VhU1st20O=srxggPXNyrCE2T76E+E8hd3Q7qQ@mail.gmail.com>
Message-ID: <CAAOTY__Qam0O+VhU1st20O=srxggPXNyrCE2T76E+E8hd3Q7qQ@mail.gmail.com>
Subject: Re: [PATCH 03/21] dt-bindings: display: mediatek: color: add binding
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
> Display Color for MT8365 is compatible with another SoC.
> Then, add MT8365 binding along with MT8183 SoC.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml |=
 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
color.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,co=
lor.yaml
> index d2f89ee7996f..9d081da433e8 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.y=
aml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.y=
aml
> @@ -39,6 +39,7 @@ properties:
>                - mediatek,mt8186-disp-color
>                - mediatek,mt8192-disp-color
>                - mediatek,mt8195-disp-color
> +              - mediatek,mt8365-disp-color
>            - const: mediatek,mt8173-disp-color
>    reg:
>      maxItems: 1
>
> --
> b4 0.10.1
