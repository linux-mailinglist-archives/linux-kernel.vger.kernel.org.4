Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247CF65BC3C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbjACI3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjACI3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:29:34 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2F9DF72;
        Tue,  3 Jan 2023 00:29:33 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id v14so21283351qtq.3;
        Tue, 03 Jan 2023 00:29:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wqnt5jb7LUMCbm7+oOTpWLIPFgOcnGyLYItooGklte4=;
        b=kWHJWhxc/EznciNc4y+aYaTOZ6JlhJFuU/Ty8V9+bvch89IIwp0kuGMLvqW3N/OR0t
         boukk2AY8l/QuF73CkZm4CmZG8vDoz4vjINX8B91oKOzmBAQzEEo2zANnPuN5JzQi7Bk
         Ma1syxy26pOZiS9MTXxn6hy9S2KYsMuZLjMnQZFfp4THR+3DhLJpLfUmL75FuAwrWKbH
         cgS9sra+u9GXKs2eze5eDg2+yK9FKX3j9WyexixJuBMq3ATkNV+vhr8+jFwo1TWuOcsW
         iE4NznTf8VvREN3SmduIrDowzL4rnnt72ZvVztspCl45iK8UZu8SjHwD2nL2KBBHl9Op
         GuAA==
X-Gm-Message-State: AFqh2krwDwi8Rc7SVA11EB4q1SZp0QkEfwn9wO+BacZGaHupsQaLAKo5
        aDKsyiLuVWwza4ywdoV+2pdPvVDi0vnRdA==
X-Google-Smtp-Source: AMrXdXsmPQ59b5t00pt4H0fRF/QvL/D6CvX89z38+RucVgGq/UykubrdhIhSTjHh7oChp6RAP7kavg==
X-Received: by 2002:a05:622a:4d47:b0:3a7:f183:7f66 with SMTP id fe7-20020a05622a4d4700b003a7f1837f66mr65841102qtb.22.1672734571898;
        Tue, 03 Jan 2023 00:29:31 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id bp33-20020a05620a45a100b006e99290e83fsm13454936qkb.107.2023.01.03.00.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 00:29:31 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-482363a1232so272500187b3.3;
        Tue, 03 Jan 2023 00:29:31 -0800 (PST)
X-Received: by 2002:a81:4fcf:0:b0:488:724d:4413 with SMTP id
 d198-20020a814fcf000000b00488724d4413mr1732163ywb.502.1672734571012; Tue, 03
 Jan 2023 00:29:31 -0800 (PST)
MIME-Version: 1.0
References: <20221221210917.458537-1-fabrizio.castro.jz@renesas.com> <20221221210917.458537-2-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20221221210917.458537-2-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Jan 2023 09:29:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW=+0JU5-d6tSKPsvO7ZxWQzNVf0LvSTfimYoBgg4RrHg@mail.gmail.com>
Message-ID: <CAMuHMdW=+0JU5-d6tSKPsvO7ZxWQzNVf0LvSTfimYoBgg4RrHg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: mfd: Add RZ/V2M PWC
To:     fabrizio.castro.jz@renesas.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

On Wed, Dec 21, 2022 at 10:09 PM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> The Renesas RZ/V2M External Power Sequence Controller (PWC)
> IP is a multi-function device, and it's capable of:
> * external power supply on/off sequence generation
> * on/off signal generation for the LPDDR4 core power supply (LPVDD)
> * key input signals processing
> * general-purpose output pins
>
> Add the corresponding dt-bindings.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> ---
>
> v1->v2: I have dropped syscon, simple-mfd, regmap, offset, and the child nodes.

Thanks for the update!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/renesas,rzv2m-pwc.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/renesas,rzv2m-pwc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas RZ/V2M External Power Sequence Controller (PWC)
> +
> +description: |+
> +  The PWC IP found in the RZ/V2M family of chips comes with the below
> +  capabilities
> +    - external power supply on/off sequence generation
> +    - on/off signal generation for the LPDDR4 core power supply (LPVDD)
> +    - key input signals processing
> +    - general-purpose output pins
> +
> +maintainers:
> +  - Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - renesas,r9a09g011-pwc # RZ/V2M
> +          - renesas,r9a09g055-pwc # RZ/V2MA
> +      - const: renesas,rzv2m-pwc
> +
> +  reg:
> +    maxItems: 1
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +
> +  renesas,rzv2m-pwc-power:
> +    description: The PWC is used to control the system power supplies.
> +    type: boolean

I'm wondering if there is some other way to represent this, e.g.
using DT topology? Some regulator relation?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
