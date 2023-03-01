Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBD66A6A0E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjCAJue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCAJuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:50:32 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F2925B8C;
        Wed,  1 Mar 2023 01:50:28 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id cq23so51519097edb.1;
        Wed, 01 Mar 2023 01:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qA5ZFeLE/hhjzy4kqiXBkHpSYNDEtXNEiCoxkQ8GIE=;
        b=pTF9D0MQn3mmpu9pJ5FXzNm4p5KcIqLVfIWv4wB+m5QZu8tMyVdkm2OpYEspiGmjx5
         U1Ahqjsg2Oh9DMKimZ8JAnVoPGk6CxyDyRAu0SDK3RCryD+MxCKULCioq/JfE5HciOHv
         np1+QkGGGoeLOlncFW3QOlik6qnCjItl6rIjki3yBeLExPeruxvSs/gxGwRUvhnCuBlY
         4Bb2RRpNF3uBIyREoXUgMzAEojd+s2IuoJMg9IKffZTQxnaAc0hKn4Yjb9jLXjPb+WmA
         IIHQUGxRwcJcJV97/gdILakqjgLoeL7X/EdPx+cskP2SzD91AsT6gbsBZUq2D8vkXh7q
         D8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qA5ZFeLE/hhjzy4kqiXBkHpSYNDEtXNEiCoxkQ8GIE=;
        b=2xhTJEvb/xdKW3KLuQrzn745W5dv0P54eLvDpyIP5KA20Lwi7hWHS6y4AAkTOHWrMs
         ah4F2hNvvv4b2UQyhREwM2YY5a1sOGds1QdGjcLajEHmhHaGewW9Bjxc+oePKOCwx3O6
         i9OHyTYvXt84cOsSm+6DhX9h/at+Dz1qX7UxJ9hpcHR3dr+Jv4q7tgJBx+Nt4Yu7fUHK
         mt8qFXHfAk8h74hEXfX5xP4uyPr7/udeeO/V4zp+ySNg3zU5exqx6lCOHkuza4sFhDo6
         AO4CHTWiGUBzv6pdmUjTQcLTQbp1a5TfAOK5wNRf1HLxSISh9ZChpI1wQlpgjtsng9qg
         IBLA==
X-Gm-Message-State: AO0yUKUjNpXM+ZnRMbPLMEqu5jx8BfYtMi8Jh7LMzm5jHExcOVvEu4z4
        9HxuXlnx1ccqj+u0zdEs+5NyIMNBmBZiHTiy1qcJt1Dj7H0=
X-Google-Smtp-Source: AK7set8Y0j2oUGKL6afGBF88DWXfyo/9L2sEQMoOqwHMjnBv0LEDByGQxw35zwIwVsdWmtF/I/qRg/P5RfUEKF3D/jE=
X-Received: by 2002:a50:f695:0:b0:4bb:e549:a2ad with SMTP id
 d21-20020a50f695000000b004bbe549a2admr872671edn.4.1677664226668; Wed, 01 Mar
 2023 01:50:26 -0800 (PST)
MIME-Version: 1.0
References: <20230222111213.2241633-1-keguang.zhang@gmail.com>
 <20230222111213.2241633-5-keguang.zhang@gmail.com> <18d1048e-c66b-fea8-2755-6c1c6e23fde9@linaro.org>
In-Reply-To: <18d1048e-c66b-fea8-2755-6c1c6e23fde9@linaro.org>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
Date:   Wed, 1 Mar 2023 17:50:10 +0800
Message-ID: <CAJhJPsUOYJ6B=YSiZxDe3_h5+Rix_uuFvUDbo9wO084N71Q+jQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] dt-bindings: gpio: Add Loongson-1 GPIO
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 8:35=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 22/02/2023 12:12, Keguang Zhang wrote:
> > Add devicetree binding document for Loongson-1 GPIO.
> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> >  .../bindings/gpio/loongson,ls1x-gpio.yaml     | 60 +++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/gpio/loongson,ls1=
x-gpio.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/gpio/loongson,ls1x-gpio.=
yaml b/Documentation/devicetree/bindings/gpio/loongson,ls1x-gpio.yaml
> > new file mode 100644
> > index 000000000000..e4ab49d48fae
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpio/loongson,ls1x-gpio.yaml
> > @@ -0,0 +1,60 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/gpio/loongson,ls1x-gpio.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Loongson-1 GPIO controller
> > +
> > +maintainers:
> > +  - Keguang Zhang <keguang.zhang@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: loongson,ls1x-gpio
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  gpio-controller: true
> > +
> > +  "#gpio-cells":
> > +    const: 2
> > +
> > +  ngpios:
> > +    minimum: 1
> > +    maximum: 32
>
> Isn't this fixed at 32? Do you have hardware with different number of GPI=
Os?
>
Yes. The GPIO number of some groups is less than 32.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - gpio-controller
> > +  - '#gpio-cells'
>
> Use consistent quotes - either " or '
>
Will do.

> > +  - ngpios
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    gpio0: gpio@1fd010c0 {
> > +        compatible =3D "loongson,ls1x-gpio";
> > +        reg =3D <0x1fd010c0 0x4>;
> > +
> > +        gpio-controller;
> > +        #gpio-cells =3D <2>;
> > +
> > +        ngpios =3D <32>;
> > +    };
> > +
> > +  - |
> > +    gpio1: gpio@1fd010c4 {
> > +        compatible =3D "loongson,ls1x-gpio";
> > +        reg =3D <0x1fd010c4 0x4>;
> > +
> > +        gpio-controller;
> > +        #gpio-cells =3D <2>;
> > +
> > +        ngpios =3D <32>;
> > +    };
>
> These are two the same examples, keep only one.
>
Will do.

> Best regards,
> Krzysztof
>


--=20
Best regards,

Kelvin Cheung
