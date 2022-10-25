Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D286560C0B9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiJYBPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiJYBOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:14:34 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DB23A8;
        Mon, 24 Oct 2022 17:30:54 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id y16so8017979wrt.12;
        Mon, 24 Oct 2022 17:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUI2EETvDOjbIumJEb3ZJvshccQCHKXMjETbOCjz3XE=;
        b=MfcJBXM0cjRRekdrMeVr88Xc0f7GYhqi2MGWq/OaPf/dwBtc5OlFqGtqsx1PWX7Huo
         bIOa+xruB4K1VklHkW8w3+/aEPHFdLbddOTQR1xjI4WwWlkC7K0M7TFMo8Pz8lRHUT5O
         tj/QnUpcEnkC36yHCiZQRgo4cok3AQY6RF4Iuam9IQDRT2acNnIZK6qzkO0ZNOjOCiwa
         gsQRB148PzrpKscQ93YIZUt4kMyH9CTp5aJynDi/ncilClNosY9/XpmTVt67XFhHhzMy
         Qy5tolUu0v4hS/ttEWPC2GN+XaAG7Eq24aLyPsICdP1h1vfqMccBHTRMgj+spAlHRv2J
         cavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUI2EETvDOjbIumJEb3ZJvshccQCHKXMjETbOCjz3XE=;
        b=Socrj2Q+tzeY2ODVjrFi4v7XyKBU3CL+kuKV0ZU8pwmO2hsDwQAu9TsGN6PxsMoHv8
         JHN0al+bWAo2kfBejxubzvPEhkbNkXANLatJUqGuzLGHQ2rxFSpGBrlsfV3rg46vBynM
         gs32qTAhdKjE0Ov/EBKtPdIh25AzCvlvGpvjdxuTeOxX9fC7TpC1K74J3UFDGT/S83g6
         tdcAlenI2DaNglqlIcupZVcfDvQPQi2d4spcW3jXbG5VnJ7wxvAaT+FSX+WMzbfsF61F
         O8+y+0o+yVg53plToweOcL8BHg4rebezlFbgm8uvGfvEO3N90UPIWkUfFWU82o9x1F+f
         IbLg==
X-Gm-Message-State: ACrzQf0r4B+Lp5ADPunwVgUkQrfabXTBNc6bYGa3o2vwNQzRTb0f6Jqc
        94zLkZlvPD7XH4KOD4HZyELG+FtVgOFNhac3hB8fVxI4ic0=
X-Google-Smtp-Source: AMsMyM5KIuE+B94jMjL0eVPuIA0S3+KapYXPBJJ44aaEiFHADqVzOME9w659GojHoDkgerVIFoMCMFNfdQrCRgA2cb4=
X-Received: by 2002:a5d:58d9:0:b0:236:5b81:2c99 with SMTP id
 o25-20020a5d58d9000000b002365b812c99mr10790750wrf.494.1666657852522; Mon, 24
 Oct 2022 17:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <1666320059-17544-1-git-send-email-u0084500@gmail.com>
 <1666320059-17544-2-git-send-email-u0084500@gmail.com> <20221024164251.GA1890861-robh@kernel.org>
In-Reply-To: <20221024164251.GA1890861-robh@kernel.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Tue, 25 Oct 2022 08:30:40 +0800
Message-ID: <CADiBU3_WUeyYdnmnG0Ff2pH+b3u1zOtP1z44LcA53Ba5c9nrEw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: regulator: Add bindings for Richtek
 RT6190 regulator
To:     Rob Herring <robh@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, broonie@kernel.org,
        lgirdwood@gmail.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> =E6=96=BC 2022=E5=B9=B410=E6=9C=8825=E6=97=A5=
 =E9=80=B1=E4=BA=8C =E5=87=8C=E6=99=A812:42=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, Oct 21, 2022 at 10:40:58AM +0800, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add devicetree binding for Richtek RT6190 4-Switch buckboost controller=
.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> > Since v2:
> > - Rename binding filename to 'richtek,rt6190.yaml'
> >
> > ---
> >  .../bindings/regulator/richtek,rt6190.yaml         | 77 ++++++++++++++=
++++++++
> >  1 file changed, 77 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/regulator/richtek=
,rt6190.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt6190=
.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt6190.yaml
> > new file mode 100644
> > index 00000000..dced404
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/regulator/richtek,rt6190.yaml
> > @@ -0,0 +1,77 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/regulator/richtek,rt6190.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Richtek RT6190 4-Switch BuckBoost controller
> > +
> > +maintainers:
> > +  - ChiYuan Huang <cy_huang@richtek.com>
> > +
> > +description: |
> > +  The RT6190 is 4-Switch BuckBoost controller designed for converting =
input
> > +  voltage to output voltage that can be equal to, higher or lower than=
 input
> > +  voltage. It operates with wide input voltage range from 4.5V to 36V,=
 and
> > +  the output voltage can be set from 3V to 36V by external FB pin. It'=
s commonly
> > +  used for the application like as BuckBoost bus upply, docking statio=
n and USB
>
> typo: upply
>
> > +  power delivery product.
> > +
> > +  Datasheet is available at
> > +  https://www.richtek.com/assets/product_file/RT6190/DS6190-02.pdf
> > +
> > +allOf:
> > +  - $ref: regulator.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - richtek,rt6190
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  enable-gpios: true
>
>        maxItems: 1
>
It's coming from gpio-consumer-common.yaml.
If so, does it still need to declare the 'maxItems'?
> > +
> > +  wakeup-source: true
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  regulator-allowed-modes:
> > +    description: |
> > +      buck allowed operating mode
> > +        0: PSM mode (light load Power Saving Mode)
> > +        1: FCCM mode (Forced-CCM mode)
>
>        maxItems: 2
>
> > +    items:
> > +      enum: [0, 1]
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    i2c {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +
> > +      regulator@2c {
> > +        compatible =3D "richtek,rt6190";
> > +        reg =3D <0x2c>;
> > +        wakeup-source;
> > +        interrupts-extended =3D <&gpio26 0 IRQ_TYPE_LEVEL_LOW>;
> > +        enable-gpios =3D <&gpio26 1 GPIO_ACTIVE_HIGH>;
> > +        regulator-name =3D "richtek,rt6190-buckboost";
> > +        regulator-min-microvolt =3D <3000000>;
> > +        regulator-max-microvolt =3D <32000000>;
> > +        regulator-min-microamp =3D <306000>;
> > +        regulator-max-microamp =3D <12114000>;
> > +        regulator-allowed-modes =3D <0 1>;
> > +      };
> > +    };
> > --
> > 2.7.4
> >
> >
