Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0E166DB3D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 11:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbjAQKeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 05:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236865AbjAQKd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 05:33:59 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2219227987;
        Tue, 17 Jan 2023 02:31:48 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id vm8so74244711ejc.2;
        Tue, 17 Jan 2023 02:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5q3UBZchnoCVIUVt8XmN98+cN/A2hPLkmxGQjqFfZQ=;
        b=NE2ZkxgTnhWO1aCyeY7Y7nSrEPNWZKKlP+B26kOR8+9Ogq8MK8HMHetk+bEOfThVP3
         vtFesPg4e6pckbaG+IT94VBsTCvsAN1pcwurzfKYane6VWM1r5YXg+/1Ud03boJ3xBLb
         vquIqGv0pO8Vq+wDd93+Ux1V7vNBVePW8DQwkyvQzfL5Q/yoKQBA8u7bz4NWq5G7Db3s
         Zyxh6ZpmntKHQwAYVhYcjrxRuT/ezkb4j2y0yS5b/fYo2rxk/2DuhnpvqyZ+7v7P0VjF
         luMeQEJAVpm+0adKsx4QYHa6DS8Cvm+LYZQjVL7sdC7Iwl5F6+32kJPlbPV0f/FATz6X
         /4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5q3UBZchnoCVIUVt8XmN98+cN/A2hPLkmxGQjqFfZQ=;
        b=xiSIuFdP2c+T1lvOD8MczS0IYxXzzSYnoRllqjcW6Ssu5w6uQ9/3EYE6shPUSImKmv
         +J1aKV8ZrUmBPMKmh/6qizwPb/TTch+SeZTatQFx/6uCGXZpLN7w5IBpEt3GEEQaSZgE
         NML+Kn/iLMs26+G1LaGE+vvZ6Mhy+Y6XGIwUmNVK/KVF67Cj9vtSr5lEQN7V0gy26rqV
         B3rYf4AnbgJbTh8qfbGaBE8eJmVYbtTJIVxXEj9J2ITmLrdgU3tGvY9oArl69JyTo/Q8
         bhfYm6YxBeCGPCk8LSCLg8y1msbymtAA+iLNaBboBJKHfsEJEpDEidk/oKulT2nnmCj+
         iaBQ==
X-Gm-Message-State: AFqh2kos+WVmF+OfhT0SMLj2ZQZDyjN+ACeWGilgJOPFoW5Q+MpD5zZE
        eQZUNoQsBKqSQR54kdJjhAAuNBdwU9IVm+QFG/AvmJBzPtDo/w==
X-Google-Smtp-Source: AMrXdXt3Hiip4kLM0j6pOfDN05d1mi6mjmyXuep0BnopZ9LrsWf7BwM/W7wytIRcixuoMy1/D/yHarRFEIPFeCfMumM=
X-Received: by 2002:a17:906:5a68:b0:86f:e36f:73ac with SMTP id
 my40-20020a1709065a6800b0086fe36f73acmr269341ejc.655.1673951506583; Tue, 17
 Jan 2023 02:31:46 -0800 (PST)
MIME-Version: 1.0
References: <20230113110738.1505973-1-keguang.zhang@gmail.com>
 <20230113110738.1505973-2-keguang.zhang@gmail.com> <63fdd223-c5e1-302d-ffef-9e582874e938@linaro.org>
In-Reply-To: <63fdd223-c5e1-302d-ffef-9e582874e938@linaro.org>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
Date:   Tue, 17 Jan 2023 18:31:29 +0800
Message-ID: <CAJhJPsV5wC_fNgP9iSi1bUp+HFY=dgyh4-x0OueZ8fQO=p7r8w@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: Add binding for Loongson-1 clock driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
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

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E4=BA=8E2023=E5=B9=B4=
1=E6=9C=8813=E6=97=A5=E5=91=A8=E4=BA=94 19:17=E5=86=99=E9=81=93=EF=BC=9A
>
> On 13/01/2023 12:07, Keguang Zhang wrote:
> > Add devicetree binding document for the Loongson-1 clock driver.
>
> Subject: drop second/last, redundant "bindings". The "dt-bindings"
> prefix is already stating that these are bindings.
>
> Subject: Drop driver, not related to hardware.

Wil do.
>
> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> >  .../bindings/clock/loongson,ls1x-clk.yaml     | 81 +++++++++++++++++++
> >  1 file changed, 81 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/loongson,ls=
1x-clk.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/clock/loongson,ls1x-clk.=
yaml b/Documentation/devicetree/bindings/clock/loongson,ls1x-clk.yaml
> > new file mode 100644
> > index 000000000000..4709c6757f1e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/loongson,ls1x-clk.yaml
> > @@ -0,0 +1,81 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/loongson,ls1x-clk.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Loongson-1 Clock Controller
>
> Wasn't this already sent?
> https://lore.kernel.org/all/20190130194731.GA25716@bogus/
> Then this is a v4? Aren't you duplicating efforts (and reviewers efforts)=
?

Sorry. I didn't notice that patch.
This binding is totally different from that, which goes with the
following driver re-implementation.
>
> > +
> > +maintainers:
> > +  - Keguang Zhang <keguang.zhang@gmail.com>
> > +
> > +properties:
>
> compatible is a first property.

Will do.
>
> > +  "#clock-cells":
> > +    const: 0
> > +
> > +  compatible:
> > +    enum:
> > +      - loongson,ls1b-clk-pll
> > +      - loongson,ls1b-clk-cpu
> > +      - loongson,ls1b-clk-ahb
> > +      - loongson,ls1c-clk-pll
> > +      - loongson,ls1c-clk-cpu
> > +      - loongson,ls1c-clk-ahb
>
> Are you registering single clocks? It looks like. No, make a proper
> clock controller.

This binding contains two types of clock, pll-clk and div-clk.
Should I split the binding to two bindings files?
>
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +required:
> > +  - "#clock-cells"
> > +  - compatible
> > +  - clocks
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    clocks {
>
> No, not really related to the binding.

Should I remove the "clocks" section?
>
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <1>;
> > +        ranges;
> > +
> > +        xtal: xtal {
>
> Incorrect in this context. Missing unit address.

XTAL doesn't have reg property.
>
> > +            compatible =3D "fixed-clock";
> > +            #clock-cells =3D <0>;
> > +            clock-frequency =3D <33000000>;
> > +        };
> > +
> > +        pll: pll@1fe78030 {
>
> Node names should be generic, so "clock-controller"
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-device=
tree-basics.html#generic-names-recommendation

Will change the node name.
>
> > +            compatible =3D "loongson,ls1b-clk-pll";
> > +            #clock-cells =3D <0>;
> > +            clocks =3D <&xtal>;
> > +            reg =3D <0x1fe78030 0x4>;
>
> compatible is first property, then reg, then the rest.

Will do.
>
> > +        };
> > +
> > +        cpu_clk: cpu_clk@1fe78034 {
>
> No underscores in node names. Anyway this should be gone - make a proper
> clock controller.

Will change the node name.
>
>
> Best regards,
> Krzysztof
>


--=20
Best regards,

Kelvin Cheung
