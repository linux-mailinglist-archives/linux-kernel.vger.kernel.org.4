Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767335EEBB8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 04:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbiI2Cad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 22:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiI2Cab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 22:30:31 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49B310E5F9;
        Wed, 28 Sep 2022 19:30:30 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id r193so4536480vke.13;
        Wed, 28 Sep 2022 19:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=kfhHvPkJrYvpjcx9wrG7I5US83ZBRovptePYpc0nVPs=;
        b=HblNEBMnM00VhREXEt5aynr7ML1dy+pc0MwCyrcDsYJOiY33+pheof43cBtr3PNfxK
         gYBkI/9gdo1iUZwI1DKK3PChefb4XwIAH266v6cK7JuKuoOGlRTbdqL1tBn8CiHAKGeE
         cqJIG1YCGr+AlJ82f8eyEkShp3TQfpwmUlEUkLe4ftWuYb7aVyaieMffXWOuDxeijE5q
         Y7DasNsm0zLv6ZIikWzQaUOov+7Vwa+CuDQLEf6nrmOX2cEp9E0PV/mYVGKBVBUuW5bW
         4GD04eJ2rUSzXcnuPCMJxbBF3AYZCUqNTSBaa545FI8Bf5CVWiRgoQNYt3tsVw5805Ho
         zyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=kfhHvPkJrYvpjcx9wrG7I5US83ZBRovptePYpc0nVPs=;
        b=LAR0mpwLgaGmRcm4Qu3EetLddfl3xGrfs174jC0Z55/BgKDIREftzmhYOQmV/JN6e5
         LhDX6X1TdiJPuD9UTPCbUadhlPopNgGAw1dbNMpKgCwtygxIK+Uo+7/pmnx4WccWNrYR
         xOKbAz1sbm6/jvcR6VHVCToNqA0A2mJKk9CaMU6Z/xJBzC575ireopYEij+clBeHxLa0
         P72XhRJFs93lpSaeRXm3vsrxNmDeDV1qri0RI3chUogAKtsASpkocdD1qmJthfdH5Boi
         +LODheH+cziHtiVqVxyfHxrurQq3sK60BVDR5AHTHFVZV8Fra5T9CctMBXcND1llhY/Q
         /Gqg==
X-Gm-Message-State: ACrzQf2gXehX7ZzaNW3a5NBUnold6qMGlCR7yvFOeP5C4a5hdteTf4L1
        0Aqr21LCtZTwwr4Bk/qCuLganS2/lLTJyARLmhKWBk2WtHp+IA==
X-Google-Smtp-Source: AMsMyM6iyWsZaj4HsA0BsyqLCbhjxvp0u2xNOR3hLf6sYblldoJgTlo6MznK1QRfxmEF5wJ6izFJRQj20U304euHz6k=
X-Received: by 2002:a1f:2596:0:b0:3a2:5864:697c with SMTP id
 l144-20020a1f2596000000b003a25864697cmr361084vkl.37.1664418630041; Wed, 28
 Sep 2022 19:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220928092937.27120-1-zhang.lyra@gmail.com> <fca2b97c-9d4f-d372-ef2a-aae8b367bbe5@linaro.org>
In-Reply-To: <fca2b97c-9d4f-d372-ef2a-aae8b367bbe5@linaro.org>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 29 Sep 2022 10:29:53 +0800
Message-ID: <CAAfSe-t=-pZAcrY0o-ct1uJaNhtkCMQKNW5gOrJfE6DEOhSZDw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: gpio: Conver Unisoc GPIO controller
 binding to yaml
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
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

Hi Krzysztof,

On Wed, 28 Sept 2022 at 19:31, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 28/09/2022 11:29, Chunyan Zhang wrote:
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > Convert the Unisoc gpio controller binding to DT schema format.
> >
>
>
> Thank you for your patch. There is something to discuss/improve.
>
> > diff --git a/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml b/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml
> > new file mode 100644
> > index 000000000000..c0cd1ed9809b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml
> > @@ -0,0 +1,70 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright 2022 Unisoc Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/gpio/sprd,gpio.yaml#
>
> Use compatible as filename, so sprd,sc9860-gpio.yaml

Humm... This is not only for SC9860, also for other IPs, UMS512 as an
example which added in this patchset.

Thanks for the review,
Chunyan

>
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Unisoc GPIO controller
> > +
>
> Best regards,
> Krzysztof
>
