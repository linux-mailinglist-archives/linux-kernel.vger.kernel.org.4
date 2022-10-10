Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1E95F96AE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 03:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiJJBww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 21:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiJJBwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 21:52:51 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEC152447;
        Sun,  9 Oct 2022 18:52:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id qw20so21388081ejc.8;
        Sun, 09 Oct 2022 18:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hMN/0XKaehZTPiIjRfY4AUhMkMfxo7i6QjUWrNELrpw=;
        b=UAAjCxS9fzHa83gTX0criIjsQ3aBW17KID049GgaVIxAikOB6Lf3EEJvRlzwRYfNsr
         J7MScAOjQ4XuTGDFSCVPjAgrDuXebExBrmUsk1J377ZRwyQktHrhw4s75/GG32SqnW28
         lHBxZy0BlNbeZ0LYDxnr2b8OMQLO5esKoxzUqAPimC4Q+vdJtYpwxCqBtK2RxWy6sj47
         0II/nW8ZmKpXIVnv0EFE1k9M5j/39ZnqcXuE2/vc+I1lUVaDb3r1eRxzoyGAs2IMy3EE
         Fv+djMqxkUawb+IMEniVu/oZReWbHrS9TOU3Z96uCPe4pdQoWsUg4+5eu1atUFXuuDLT
         Oi8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hMN/0XKaehZTPiIjRfY4AUhMkMfxo7i6QjUWrNELrpw=;
        b=jgR1tshTgLdKMMGyJXNtXUSkX67iLRYFx9QVfW8Dfl9/YeWNMu1F7x+jcGyMqgxGxt
         FMJT7tjPdZ0TEb/6jxUs91IeLLO/TEs6xiy9fz1PhgDkNftWDaJWtpaFNLO1S8UgH2Rs
         35AHrXKJfqk7DeQ+m0kxivFHF1T9E8r0YeD/rZ/mrHfvEjPOSuAaHiNFasVNGb8OlY1V
         sN/TuSLEFmX4Jg7KRYd32c9/pKQGfI2bR1hCmmjwKaE/gNlf0am7vEST6R2ECLh4CSSd
         Q9lb9PgSPn0BssIn3WZuQx2n1aZ/giBgA3FNtg40JT5T7HuGQ4QOoUtQC6FvMMJ6MMtt
         e71g==
X-Gm-Message-State: ACrzQf3K6nrKZ0nX5hHkDtHOVHr4JDw1lT7g+DU1WdkcMgakNLtVkVyW
        6jGUz9gqjnASvtqe/E32SbZdYTSwYH+Yden+Iy5q+AsI
X-Google-Smtp-Source: AMsMyM7y9rMvCnHmx1yWMfOO6isdFJZ6dOD7ysHiut1RJAIm9J5MoP5Jhw5d39KMc+yfCrNHyE1pzT1Aj5ohPDchV04=
X-Received: by 2002:a17:906:36d1:b0:76c:a723:9445 with SMTP id
 b17-20020a17090636d100b0076ca7239445mr12477078ejc.548.1665366768709; Sun, 09
 Oct 2022 18:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220930082405.1761-1-zhang.lyra@gmail.com> <20220930082405.1761-3-zhang.lyra@gmail.com>
 <727a540d-0ca9-ade3-894d-f1774d10a681@linaro.org> <CAAfSe-u4y84kjjksv-Y7=zyosV=34M-=_wrDQC9884znvx9V4Q@mail.gmail.com>
 <e0d69843-4b37-2e0d-66c7-fc8fd09ed385@linaro.org>
In-Reply-To: <e0d69843-4b37-2e0d-66c7-fc8fd09ed385@linaro.org>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 10 Oct 2022 09:52:11 +0800
Message-ID: <CAAfSe-vQ3Vhjpp9kwRxmha1WR=kfW08BmuYEW+r1POBD1oFqnQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] dt-bindings: gpio: Convert Unisoc EIC controller
 binding to yaml
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Oct 2022 at 23:17, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 08/10/2022 04:57, Chunyan Zhang wrote:
> >>> +        eic_debounce: gpio@40210000 {
> >>> +            compatible = "sprd,sc9860-eic-debounce";
> >>> +            reg = <0 0x40210000 0 0x80>;
> >>> +            gpio-controller;
> >>> +            #gpio-cells = <2>;
> >>> +            interrupt-controller;
> >>> +            #interrupt-cells = <2>;
> >>> +            interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
> >>> +        };
> >>> +    };
> >>> +
> >>> +    sc2730_pmic {
> >>
> >> If you insisted to keep it, at least should be correct, so just pmic.
> >>
> >>> +        #address-cells = <1>;
> >>> +        #size-cells = <0>;
> >>> +
> >>> +        pmic_eic: gpio@300 {
> >>
> >> It's exactly the same example as above - all same properties. Drop it or
> >> bring some differences.
> >
> > The differences are on #address-cells and #size-cells.
> >
>
> Which don't really matter...

Alright, will drop it in the next version.

>
> Best regards,
> Krzysztof
>
