Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C946B7B8B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjCMPJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjCMPJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:09:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4443018B;
        Mon, 13 Mar 2023 08:08:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9477F61336;
        Mon, 13 Mar 2023 15:08:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2710C433AA;
        Mon, 13 Mar 2023 15:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678720124;
        bh=S10P55qoSefp3tquh9o+ql/D/gx54XqqWmAW+yYAqF4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZPqVyGE2rEFwb0iHgg420twm9Dv7NRBiGQ0+Ox+4Ui+3iyrMJoysFuAZIWLGy0Hlr
         uCYfcncRpvwGXEHi2COdJUUvoNDgzmsoKWqf4hwYmtE9d9kLmE7gj/eOMwUlqIBlwm
         SsDaeS22cahCQEAOog5GXItXnKG6ofQmdIRU3keKjC1NSfpW7+7cM04e44BAzH35PE
         imHwLw4OigRkMMFaNyB7Efoco4TXppwpFntnjrJ3mL9GN0tHNOLtUcDd5VreZM9OeO
         W1F03kIYoSb3MEUSs89kzw3Sm72e9HniNftcNoFSkrFKZhDsFm0bLL9wd5F1g1Czsk
         l2dKUNHcFrqrw==
Received: by mail-lf1-f51.google.com with SMTP id s22so16114707lfi.9;
        Mon, 13 Mar 2023 08:08:43 -0700 (PDT)
X-Gm-Message-State: AO0yUKU6j5tlEBUSBqE0zdJkMLQ5qQmykFveiXVqLNY/hqo9pAnWCisV
        J8Ao3kTVOqGxBbZ/NggyWR0EcwJCH4P4pANgew==
X-Google-Smtp-Source: AK7set8O8oG4SXhOvRL6HCMEQolVFDwrGrQP5nswTrxrSjexg5YyYijOPMKZuhjj2e7ORk3z38TIJ8Y5USlb96Za1fE=
X-Received: by 2002:ac2:5923:0:b0:4d5:ca42:e43e with SMTP id
 v3-20020ac25923000000b004d5ca42e43emr11026612lfi.7.1678720122020; Mon, 13 Mar
 2023 08:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230220-display-v1-0-45cbc68e188b@baylibre.com> <20230220-display-v1-9-45cbc68e188b@baylibre.com>
In-Reply-To: <20230220-display-v1-9-45cbc68e188b@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 13 Mar 2023 23:08:30 +0800
X-Gmail-Original-Message-ID: <CAAOTY_--qP-PBBt9zZwcMewiWB-ow_n2XZSHFAz7FeU=v1Hj7g@mail.gmail.com>
Message-ID: <CAAOTY_--qP-PBBt9zZwcMewiWB-ow_n2XZSHFAz7FeU=v1Hj7g@mail.gmail.com>
Subject: Re: [PATCH 09/21] dt-bindings: display: mediatek: ovl: add binding
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
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-pwm@vger.kernel.org, Fabien Parent <fparent@baylibre.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Guillaume La Roque <glaroque@baylibre.com>,
        linux-arm-kernel@lists.infradead.org
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
> Display Overlay for MT8365 is compatible with another SoC.
> Then, add MT8365 binding along with MT8192 SoC.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml | 1=
 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
ovl.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.=
yaml
> index a2a27d0ca038..20e4ca4fc915 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yam=
l
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yam=
l
> @@ -41,6 +41,7 @@ properties:
>        - items:
>            - enum:
>                - mediatek,mt8186-disp-ovl
> +              - mediatek,mt8365-disp-ovl
>            - const: mediatek,mt8192-disp-ovl
>
>    reg:
>
> --
> b4 0.10.1
