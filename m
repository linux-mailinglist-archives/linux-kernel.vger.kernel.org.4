Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC5D6DAD31
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjDGNLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbjDGNLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:11:31 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96647ABC
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 06:11:29 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54184571389so795230557b3.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 06:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680873089; x=1683465089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rv0MnDhBR7RhUm2k1VltfAQGecmQlEWVWwPtQQZTHPg=;
        b=sGiUUuw1QRatxtEb/UcQOiPIoY1SZFkm69NaXnTRo60jT4ICPWsMeAtRvL98qGWe7Q
         jN4DQbWsj1/dP2Q5K2d6eHD5/C3BBT3SY4K6PuT834K85Y1+4cmuyUWup4N3K+iAT5eI
         HIMEc+3yk0sxork9e9g6HVgcuBFFzN7bJCpXdLxPF4ivGxkakgz6/BEW77QTgNNu7/mq
         WXUUwzGacCRgJJxd/fT5jIIIu74IK/wte3z6wC3MeALpaSiFj+IRXy9RJ0U1qPd1iB9n
         tmIAu0BdnFmdXeVlPm8k/XG61BqA0juulyMNfCvtnJeqFllkf2y74zxRfjTWaI4BqnPa
         wa2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680873089; x=1683465089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rv0MnDhBR7RhUm2k1VltfAQGecmQlEWVWwPtQQZTHPg=;
        b=Ab/poIUPvdBWvakfDrsgXz67H4RapOtBprSJAOIscbXqBDs1OpoBbWe97hjwTCSdLR
         LyHn7yUbi0HDJjQiS5Ki6AaAOySvcGfUVX0qBPacMKrQveQU+5zI9HQlS6jLmDe4e6wa
         0MP3SytHjfMzCk7JoB1jx5SkLFqiJ5x4uDbzHYnSFcAIOHeGEMFhr4F2EuiN85rAnB9M
         Q7OvKAh8ZVPvzdCopZjaWmgAT8ytlBBJiMyKVwUWb3paLgjvecp7mOWxRpNwa3MPabcY
         ppijHtmL8WN9vuWLk/yrWPvJF3zvpASX3GWIKZt2+mwG1X7OAm79YwrrRfpHqAGLVmOY
         valg==
X-Gm-Message-State: AAQBX9cwJ2v4KMUMu5puKzNeBHUYHqAORvOe06dMjgOe0EWKj6AQwhBT
        skpSZdkQL00kWFETUjqeFIaZR4zjqOpnUDnOnnETpQ==
X-Google-Smtp-Source: AKy350YsVPmfbqSl4Mg2xQTxsG99IXxfODcn5+1wDUxnKufIsSDPx49h6IuM/EREPmJZAy1l6VEHsqiSVeLHvbm2juA=
X-Received: by 2002:a81:b10a:0:b0:54d:d7f0:1d3b with SMTP id
 p10-20020a81b10a000000b0054dd7f01d3bmr669370ywh.3.1680873089054; Fri, 07 Apr
 2023 06:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230203-evk-board-support-v5-0-1883c1b405ad@baylibre.com> <20230203-evk-board-support-v5-3-1883c1b405ad@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v5-3-1883c1b405ad@baylibre.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 7 Apr 2023 15:11:18 +0200
Message-ID: <CAFGrd9oi0AT3L8DVs7OYq-RjzBTqD+CB5mjKOwEbgNJDdyj2=g@mail.gmail.com>
Subject: Re: [PATCH v5 03/12] dt-bindings: watchdog: mediatek,mtk-wdt: add mt8365
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        catalin.marinas@arm.com, Will Deacon <will@kernel.org>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ To: Catalin Marinas <catalin.marinas@arm.com>
+ To: Will Deacon <will@kernel.org>

Sorry for the noise.

Regards,
Alexandre

Le ven. 7 avr. 2023 =C3=A0 14:59, Alexandre Mergnat <amergnat@baylibre.com>=
 a =C3=A9crit :
>
> Add binding description for mediatek,mt8365-wdt
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.=
yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> index 55b34461df1b..66cacea8e47f 100644
> --- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> @@ -38,6 +38,7 @@ properties:
>                - mediatek,mt7623-wdt
>                - mediatek,mt7629-wdt
>                - mediatek,mt8173-wdt
> +              - mediatek,mt8365-wdt
>                - mediatek,mt8516-wdt
>            - const: mediatek,mt6589-wdt
>
>
> --
> 2.25.1
>
