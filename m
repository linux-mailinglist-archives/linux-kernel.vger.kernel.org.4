Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553B66336D1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbiKVIOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbiKVIOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:14:52 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C29125296
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:14:50 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id f18so34025751ejz.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jM+75qOkESHdT/LFEmzbTRIChEQ87MS6sqDcZEDZv3g=;
        b=422yluu6GBF7Zr8QFIXloUOKlAx11LZ27aEbqh7AODAtsk61284Y3nnC+EgMqu/9WL
         6jS2Z79QFgqsYOKlQWq6JPzOBQcZlx5JIrOzqgveXm47bKryMuC5Xf5vrlJvt8kY8q30
         ZUX8nrNp2bxl4EQ9SdPNsbgF4Eudy1KG6fhl6775TBIErHLldgVq7KzcdAg3Uj8jtdWj
         MEhvKmxAo3OyI4JWdAG1OyRXomAEgtfnxhUzlipXJcOBQqEFazeagbMDnKIKK7bFKrDF
         2wL5qv7dljBITPw0xbj1QyPIE7K2gSV4Sjz8AN1RbNAUqDGOD2w/C/GmHzTKvFvSPG1K
         IkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jM+75qOkESHdT/LFEmzbTRIChEQ87MS6sqDcZEDZv3g=;
        b=65cyLQIXZV2Wb7mrivcYKr+OQrHO2Y2VftIOgNsI9Mt2yx+3O6N/mVV/dn0tP9eEDR
         rSCo8Wr5SZLrjRkWplI0K38NP3T0lijBwTJ/XFn3fXIFRQUCy+A8/zTeYd1k8YeVFNXz
         RirAxOOVnCwLec1b2XFnZWgea+b6+SRT1s3JNUw82neJP6Vb5UhBP1rEoBPlciV8gcF3
         ghCMSLrJJQtk4AsL/5F6DITpKb7xK5wULifhstGY6XiteEE900A3j3kIanD4qE2KKwL7
         //irNjGIy1ylyHUTL5HsnzGcJdzrY8lxjSA430/E23eX31GTFVYgyEtFlbMz2OwDaDtm
         WLhg==
X-Gm-Message-State: ANoB5pnJCdB8LRpu2sAwzgw7lf/CuauUHgk7lCppbnlz7FlCane3Ccd3
        WIGIu9tTechw2+2EBjD+DJSGCRC1hvFC1zEHhyLbrA==
X-Google-Smtp-Source: AA0mqf714aLOvgKM5W9MtFw+gOA+gv/Zq8lXPGhFeko4gMI2aAQta5XL7+Zp40MYnqfj6bo3sT/69zgTGr4hP81odgU=
X-Received: by 2002:a17:906:4a55:b0:7ad:9ada:79c6 with SMTP id
 a21-20020a1709064a5500b007ad9ada79c6mr19023201ejv.86.1669104889006; Tue, 22
 Nov 2022 00:14:49 -0800 (PST)
MIME-Version: 1.0
References: <20221005-mt6357-support-v5-0-8210d955dd3d@baylibre.com>
 <20221005-mt6357-support-v5-6-8210d955dd3d@baylibre.com> <47ae0770-1cd4-cfea-7222-f91d1d85f133@gmail.com>
In-Reply-To: <47ae0770-1cd4-cfea-7222-f91d1d85f133@gmail.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Tue, 22 Nov 2022 09:14:38 +0100
Message-ID: <CAFGrd9rWHdwSaDv7L7XGnBiPp-HHXTqvMToeHLoQsH_9qxhTsg@mail.gmail.com>
Subject: Re: [PATCH v5 06/10] dt-bindings: soc: mediatek: convert pwrap documentation
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Flora Fu <flora.fu@mediatek.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-leds@vger.kernel.org, Fabien Parent <fparent@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-rtc@vger.kernel.org, linux-input@vger.kernel.org
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

Le jeu. 17 nov. 2022 =C3=A0 17:06, Matthias Brugger
<matthias.bgg@gmail.com> a =C3=A9crit :
> > +              - mediatek,mt8173-pwrap
> > +              - mediatek,mt8183-pwrap
>
> Missing mediatek,mt8186-pwrap

I add it

>
> > +              - mediatek,mt8188-pwrap
>
> mt8188 has mt8195 as fallback, that must be kept as otherwise the driver =
does
> not bind.

I add it

>
> > +              - mediatek,mt8365-pwrap
> > +              - mediatek,mt8516-pwrap
> > +      - items:
> > +          - enum:
> > +              - mediatek,mt8186-pwrap
> > +              - mediatek,mt8195-pwrap
> > +          - const: syscon
>
> Not in the original txt binding, maybe add that in a first patch and then=
 convert.

I think, instead of fixing a deprecated file, I should fix it directly
here. Actually, I forgot to
mention this change in the commit message, but I will add it for the
next version.

Thanks,
Alex
