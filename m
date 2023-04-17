Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860426E4F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjDQRsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjDQRsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:48:36 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C602CB46E;
        Mon, 17 Apr 2023 10:48:34 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1a66888cb89so10369745ad.3;
        Mon, 17 Apr 2023 10:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681753714; x=1684345714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mElitKZ7sVJOTw6f2WC/zkSXCNzETK2pY5VMRBVufmw=;
        b=gGXX1Z3tsyEQ9yXV6FxAqKXrU/swtTH8fC2XXCDtPINtMLZI2Qi15weLR0kQC7WJ4c
         0loRi1w73hJqt9ryrPCAGARvvap5ZEED70RY+GLV5zrLxpKLBFc4UyWIwxAVEd8waCOY
         enHkm3sQq6zWbLi4P+E6BJAk92u50FETpMdynIgvEyx+OvIggocKQSdR9iJFRe6f7dHp
         S8o9Pt9Pja5RR9HlOSzd3FzfcdJxprsgm09Lasp5okFZzJ6j8QO1nzWqxD05Q7c40D7K
         2kw7b3bSHfowMrmkSVISE5Rn2bcrtF8dWZw7+Go3mNQwGpRFt3/zNwSO+OdNZmAL97IV
         1Wyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681753714; x=1684345714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mElitKZ7sVJOTw6f2WC/zkSXCNzETK2pY5VMRBVufmw=;
        b=GFdkTxaXCu68YvO3o6pZ9MvljjuaAg0OWu92mGUD/ph/qKwR08i33cSE2Up2qyQROD
         BYzn0l4B9tbl0F26lqBtv6oT4AfMJsKvCXega2Ooh1YzYYuQeOwqvgGQWutaN3cSTvVk
         p1xS3Modi30Md9ZDJM0twHdJDobquAqCZUaBsV4TvLn2gJF2I0njKyxgl0dhFIWGcGhL
         uXGykh7iU42Zgv01n7ofMFr+DXr2GChk/COrkszbEMoiIJ5jPgyN3sbFWoh0tpRos8lr
         H82XiYe1FVJ/+GWW3CyYzfDsrtNrmubSP93bRlybNniNP+ck6o7/Y6rMm4z6zKC3Skev
         pyZw==
X-Gm-Message-State: AAQBX9fmPP0/nbHTsnxLV8OsjiPSsEKzLp/EuA3NqL5ZdhKJmJhrpKib
        Jh2rYDgg6BQNEeLC7/0wyh/YY6sdiXZn4Crh+esjcgKg2Gv+fLlpgcA=
X-Google-Smtp-Source: AKy350ZY2/SVWgCZZpNshcEjU75Gg3p0EuJFZSfpF3GMp51iDvev5JaVd2A9k5GnGj8yn466wUQCGf1vWQiSDPp1hgQ=
X-Received: by 2002:a05:6a00:228b:b0:63b:641d:76d8 with SMTP id
 f11-20020a056a00228b00b0063b641d76d8mr6279150pfe.2.1681753714033; Mon, 17 Apr
 2023 10:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230414181302.986271-1-mmyangfl@gmail.com> <20230414181302.986271-2-mmyangfl@gmail.com>
 <c1f32d73-a311-6d70-0be6-12bdb50a052f@linaro.org>
In-Reply-To: <c1f32d73-a311-6d70-0be6-12bdb50a052f@linaro.org>
From:   Yangfl <mmyangfl@gmail.com>
Date:   Tue, 18 Apr 2023 01:47:57 +0800
Message-ID: <CAAXyoMPz1ONgDvFET0dFKBktODoSY2m3ubHfmVBsJ46sRBF31w@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: Add reg-clock-controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E4=BA=8E2023=E5=B9=B4=
4=E6=9C=8815=E6=97=A5=E5=91=A8=E5=85=AD 05:08=E5=86=99=E9=81=93=EF=BC=9A
>
> On 14/04/2023 20:12, David Yang wrote:
> > Add DT bindings documentation for reg-clock-controller, collection of
> > basic clocks common to many platforms.
> >
> > Signed-off-by: David Yang <mmyangfl@gmail.com>
> > ---
> >  .../bindings/clock/reg-clock-controller.yaml  | 245 ++++++++++++++++++
> >  1 file changed, 245 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/reg-clock-c=
ontroller.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/clock/reg-clock-controll=
er.yaml b/Documentation/devicetree/bindings/clock/reg-clock-controller.yaml
> > new file mode 100644
> > index 000000000000..a6a7e0b05821
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/reg-clock-controller.yaml
> > @@ -0,0 +1,245 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/reg-clock-controller.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Simple straight-forward register-based clocks
> > +
> > +maintainers:
> > +  - David Yang <mmyangfl@gmail.com>
> > +
> > +description: |
> > +  Basic clocks common to many platforms.
> > +
> > +  If your clocks don't fit into these catagories, simply create your c=
lock
>
> typo: categories

Fixed in v2.

>
> > +  controller. This driver normally work well with other controllers as=
 long as
> > +  they operate on different registers.
> > +
> > +  See linux/clk-provider.h for details about properties for each type =
of clock.
>
> Describe here what is this device, what such simple clock controller
> represents.

Description has been rewritten in v3, to describe the device.

>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - reg-clock-controller
> > +
> > +  ranges: true
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - ranges
> > +  - '#address-cells'
> > +  - '#size-cells'
>
> required goes after patternProperties.

Fixed in v2.

>
> > +
> > +patternProperties:
> > +  ".*gate-clock@.*":
>
> "gate-clock@" should be equivalent. However this should be just "clock".

Fixed in v3.

>
> > +    type: object
> > +
> > +    description: |
>
> Do not need '|' unless you need to preserve formatting.

Fixed in v2.

>
> > +      Clock which can gate its output.
> > +
> > +    properties:
> > +      compatible:
> > +        const: gate-clock
> > +
> > +      reg:
> > +        maxItems: 1
> > +
> > +      '#clock-cells':
> > +        const: 0
> > +
> > +      clocks:
> > +        maxItems: 1
> > +        description:
> > +          Parent clock.
> > +
> > +      clock-output-name:
>
> names
>
> Don't create your own properties.

Fixed in v2, "clock-output-names".

>
> > +        maxItems: 1
> > +
> > +      bit-index:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description:
> > +          Bit index which controls the output.
>
> I suggest to use same property as nvme, so bits.

Replaced with "bits" in v2.

>
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +      - '#clock-cells'
> > +      - bit-index
> > +
> > +    additionalProperties: false
> > +
> > +  ".*divider-clock@.*":
> > +    type: object
> > +
> > +    description: |
> > +      Clock with an adjustable divider affecting its output frequency.
> > +
> > +    properties:
> > +      compatible:
> > +        const: divider-clock
> > +
> > +      reg:
> > +        maxItems: 1
> > +
> > +      '#clock-cells':
> > +        const: 0
> > +
> > +      clocks:
> > +        description:
> > +          Parent clocks.
> > +
> > +      clock-output-name:
> > +        maxItems: 1
> > +
> > +      shift:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description:
> > +          Shift to the divider bit field.
> > +
> > +      width:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description:
> > +          Width of the divider bit field.
> > +
> > +      dividers:
> > +        $ref: /schemas/types.yaml#/definitions/uint32-array
> > +        description:
> > +          Array of value/divider pairs.
>
> Then it looks like matrix.

This part of bindings has been (temporarily) removed from this series
since v2, to make it simpler.

>
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +      - '#clock-cells'
> > +      - shift
> > +      - width
> > +
> > +    additionalProperties: false
> > +
> > +  ".*mux-clock@.*":
> > +    type: object
> > +
> > +    description: |
> > +      Clock with multiple selectable parents.
> > +
> > +    properties:
> > +      compatible:
> > +        const: mux-clock
> > +
> > +      reg:
> > +        maxItems: 1
> > +
> > +      '#clock-cells':
> > +        const: 0
> > +
> > +      clocks:
> > +        minItems: 1
> > +        description:
> > +          Parent clock.
> > +
> > +      clock-output-name:
> > +        maxItems: 1
> > +
> > +      shift:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description:
> > +          Shift to multiplexer bit field.
> > +
> > +      mask:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description:
> > +          Mask of mutliplexer bit field.
> > +
> > +      table:
> > +        $ref: /schemas/types.yaml#/definitions/uint32-array
> > +        description:
> > +          Array of register values corresponding to the parent index.
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +      - '#clock-cells'
> > +      - shift
> > +      - mask
> > +
> > +    additionalProperties: false
> > +
> > +  ".*fractional-divider-clock@.*":
> > +    type: object
> > +
> > +    description: |
> > +      Clock with adjustable fractional divider affecting its output fr=
equency.
> > +
> > +    properties:
> > +      compatible:
> > +        const: fractional_divider-clock
> > +
> > +      reg:
> > +        maxItems: 1
> > +
> > +      '#clock-cells':
> > +        const: 0
> > +
> > +      clocks:
> > +        maxItems: 1
> > +        description:
> > +          Parent clock.
> > +
> > +      clock-output-name:
> > +        maxItems: 1
> > +
> > +      numerator-shift:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description:
> > +          Shift to the numerator bit field.
> > +
> > +      numerator-width:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description:
> > +          Width of the numerator bit field.
> > +
> > +      denominator-shift:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description:
> > +          Shift to the denominator bit field.
> > +
> > +      denominator-width:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        description:
> > +          Width of the denominator bit field.
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +      - '#clock-cells'
> > +      - numerator-shift
> > +      - numerator-width
> > +      - denominator-shift
> > +      - denominator-width
> > +
> > +    additionalProperties: false
> > +
> > +additionalProperties: true
>
> No, come on. This must be false.

Fixed with "false" in v2.

>
> > +
> > +examples:
> > +  - |
> > +    clks: reg-clk-ctrl@ffff0000 {
>
> Names should be generic, so clock-controller
>
> Drop the label.

Dropped in v2.

>
> > +      compatible =3D "reg-clock-controller";
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <1>;
> > +      ranges =3D <0 0xffff0000 0x1000>;
> > +
> > +      my_clk: gate-clock@cc-3 {
>
> Drop label.
>
> That's a new unit address to me. Did I miss a change in DT spec?

Dropped label in v2.

>
> > +        compatible =3D "gate-clock";
> > +        #clock-cells =3D <0>;
> > +        reg =3D <0xcc 4>;
>
> reg is after compatible.
>
> > +        bit-index =3D <3>;
> > +        clock-output-name =3D "my-clk";
>
> Plus, test your patches. This fails testing...

Fix name error in v3.

>
> > +      };
> > +    };
>
> Best regards,
> Krzysztof
>
