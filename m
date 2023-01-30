Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9A6680B16
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbjA3Kkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235790AbjA3Kkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:40:41 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247EB31E34
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:40:40 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id mc11so7920656ejb.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 02:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fdNUPffFvmZrBuodDbaQxrLCKtYnZUu/RnBAFeTehl4=;
        b=a2NRjekX1BfZ9QTLs6Qgo7mu/qYSpCZY4kuWbHpJX4+D72h350igExn6viCpYRlecV
         /0pWnosUN9yVKUm0jdvVypK0arvG4GaSstEAinU7aaigbVStLP0fRzhcmTb9nIsU9HVb
         6uLOjsBjJzkpqRR3XDhRnb1H6E+TgUx9ctWBsVkwCB9J5S51f0myvsf0Sc4Sbw+eG1X6
         m/I3QqddCot7i5eOcL2PMn3nkrIkneB09Y606dBle5CUM5W09FrhIhZFGQcw8+NBM8Wu
         c+Q7SjByjaUg94IRP9xDkz+vAJCRocnaXZ2MXSDQonUdK9SzOeYI6kzN/3msG/ZX4u6E
         GAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fdNUPffFvmZrBuodDbaQxrLCKtYnZUu/RnBAFeTehl4=;
        b=rdP46kvRc6aRQ8qgpvJ2TOVMwQC3BjxJBH7Civ0WHdSsfMi8DPYvb7zFtQ/aStnQ24
         yNrXpR4Umc1XGEISMwW7rsBE13P25iy0sYA72SJTp1XzyTioTq6BC0AbYn+2XJdbSqXP
         Du5/5+ZVbWjXkPWIzPfSSga19RRd7jg7ClBpIq2jPk+vuDm42DuNl50ORV4uo1ZAEN1k
         bwZWQibGAwSi4IBE4N55kD2F9l4s8uoz3znQpS2RUcBMO3Cp7qLaQV8wB4Se8vegBF1a
         TGu8WaIQHkO1noxJlyfSi68azPtlZB5OdNt+Jck2dYLFvPkRkbZqeSvONFzjk0OFyidU
         o3rg==
X-Gm-Message-State: AFqh2koU+fqetwYsY3Rxqj1vRGX0ZE9GuPuzX9cKiuQ18O2+OA3IQPas
        m7yayPs7Ediiflyn3SAWnwYoJ4fI6xardk2D4auUDA==
X-Google-Smtp-Source: AMrXdXschNa1yyE4yyXfnHt7bxuX8pZDNHXkMneEpkjyfpKCpzB4G3AuW7kler2jR3lAb6d0ud+riMwnij52Z0VjIV4=
X-Received: by 2002:a17:906:30c1:b0:877:4531:b133 with SMTP id
 b1-20020a17090630c100b008774531b133mr8032986ejb.37.1675075239722; Mon, 30 Jan
 2023 02:40:39 -0800 (PST)
MIME-Version: 1.0
References: <20230124131717.128660-3-bchihi@baylibre.com> <20230126161048.94089-1-bchihi@baylibre.com>
 <5ec49108-6ad8-daf7-54ec-104f0923a31d@linaro.org>
In-Reply-To: <5ec49108-6ad8-daf7-54ec-104f0923a31d@linaro.org>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Mon, 30 Jan 2023 11:40:03 +0100
Message-ID: <CAGuA+opQboxH8qoNv4GG+raX=ZZAyRVLC9VLjVCzbT_cUQWWTA@mail.gmail.com>
Subject: Re: [PATCH v12 2/6] dt-bindings: thermal: mediatek: Add LVTS thermal
 controllers dt-binding definition
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you for the feedback.

On Sat, Jan 28, 2023 at 11:48 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 26/01/2023 17:10, bchihi@baylibre.com wrote:
> > From: Balsam CHIHI <bchihi@baylibre.com>
> >
> > Add LVTS thermal controllers dt-binding definition for mt8195.
>
> Subject: drop second/last, redundant "dt-binding definition". The
> "dt-bindings" prefix is already stating that these are bindings.

fixed.
The patch title has been fixed as you suggested :
"dt-bindings: thermal: mediatek: Add LVTS thermal controllers"

>
> Plus two comments at the end.
>
> >
> > Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> > ---
> > Changelog:
> >   v12:
> >      - Fixed subject prefix
> >      - Fixed licences GPL-2.0+ to GPL-2.0
> >      - Added dual licenses
>
>
> > +    };
> > diff --git a/include/dt-bindings/thermal/mediatek-lvts.h b/include/dt-bindings/thermal/mediatek-lvts.h
> > new file mode 100644
> > index 000000000000..902d5b1e4f43
> > --- /dev/null
> > +++ b/include/dt-bindings/thermal/mediatek-lvts.h
>
> Same filename as bindings.

fixed.
rename :
include/dt-bindings/thermal/mediatek-lvts.h =>
include/dt-bindings/thermal/mediatek-lvts-thermal.h

>
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: (GPL-2.0 or MIT) */
>
> Although this is correct, any reason why not using exactly the same
> license as bindings?

fixed.
both files are now using the same license :
"SPDX-License-Identifier: (GPL-2.0 or MIT)"

>
> > +/*
> > + * Copyright (c) 2023 MediaTek Inc.
> > + * Author: Balsam CHIHI <bchihi@baylibre.com>
> > + */
>
> Best regards,
> Krzysztof
>

I'll send the changes soon.

Best regards,
Balsam
