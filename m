Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E8C6CC17F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjC1NzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjC1NzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:55:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27411AB;
        Tue, 28 Mar 2023 06:55:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36327B81D57;
        Tue, 28 Mar 2023 13:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AECC4339C;
        Tue, 28 Mar 2023 13:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680011708;
        bh=vWPCC8VIAiLmllWAWxkbIh73YUZMedg8b7K2aPik8tU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eMwHxD0O7qXg7BVFwxkwzXPh/z/lddceA+pTDCR4vijn6sIZyBTmH96EWwUHHrFV3
         cNyO30yKoU3dnN74Z/xR8F7VrrF4/P9BD00xoqzYppLhO+/cs+nQYRH3OiROwuhwDf
         twmittX/wMDze3cX0Mc3g4OBB8dAB7O1ordpOfPfOHVBrumEt0zFDFwu7mTbyUGVlf
         MQCD6h3CuEqZ7wZNd8N2luKWsXsqF+wL5d4uVvaiXKeVKXtnBSgCEP4vYKjeaaB1is
         ToQe8hi3edmnsI/mSC/4AV1/JyuDQSHBtLnjAmW25Jwi5BxUkm7BTerfDoKynIuj+T
         buzyhzgUIvBMw==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5456249756bso231074817b3.5;
        Tue, 28 Mar 2023 06:55:08 -0700 (PDT)
X-Gm-Message-State: AAQBX9cob+ieXPrbQJrb3Go4PyNqtWUYO65CFocWmqeOkgnHpOFLCWws
        dxcNhGGuybVmpTrqJ6S+wtU2UVGZ1oExeID9TA==
X-Google-Smtp-Source: AKy350amHwuEhXFg2F8D3n/WuI47BFty9DUkRRbsVRdvL/trAteUVJ8fKx95OaESPKOBM94pIJNNQGvOXBcN+2GyKyY=
X-Received: by 2002:a81:b50f:0:b0:544:b8d8:339e with SMTP id
 t15-20020a81b50f000000b00544b8d8339emr7405889ywh.5.1680011707733; Tue, 28 Mar
 2023 06:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230328054833.1974942-1-peng.fan@oss.nxp.com>
In-Reply-To: <20230328054833.1974942-1-peng.fan@oss.nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 28 Mar 2023 08:54:56 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKbOSQAZhA+Xapgwpqzuoo44ZF13+MziNHm5ye5Js8kfA@mail.gmail.com>
Message-ID: <CAL_JsqKbOSQAZhA+Xapgwpqzuoo44ZF13+MziNHm5ye5Js8kfA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: input: pwm-beeper: convert to dt schema
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     dmitry.torokhov@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 12:43=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Convert the binding doc to dt schema, and also fixed the
> example from fixed-regulator to regulator-fixed.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/input/pwm-beeper.txt  | 24 ----------
>  .../devicetree/bindings/input/pwm-beeper.yaml | 48 +++++++++++++++++++
>  2 files changed, 48 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.tx=
t
>  create mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.ya=
ml
>
> diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.txt b/Doc=
umentation/devicetree/bindings/input/pwm-beeper.txt
> deleted file mode 100644
> index 8fc0e48c20db..000000000000
> --- a/Documentation/devicetree/bindings/input/pwm-beeper.txt
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -* PWM beeper device tree bindings
> -
> -Registers a PWM device as beeper.
> -
> -Required properties:
> -- compatible: should be "pwm-beeper"
> -- pwms: phandle to the physical PWM device
> -
> -Optional properties:
> -- amp-supply: phandle to a regulator that acts as an amplifier for the b=
eeper
> -- beeper-hz:  bell frequency in Hz
> -
> -Example:
> -
> -beeper_amp: amplifier {
> -       compatible =3D "fixed-regulator";
> -       gpios =3D <&gpio0 1 GPIO_ACTIVE_HIGH>;
> -};
> -
> -beeper {
> -       compatible =3D "pwm-beeper";
> -       pwms =3D <&pwm0>;
> -       amp-supply =3D <&beeper_amp>;
> -};
> diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.yaml b/Do=
cumentation/devicetree/bindings/input/pwm-beeper.yaml
> new file mode 100644
> index 000000000000..1d7cd58d2a8f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)

'or-later' is wrong.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/input/pwm-beeper.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PWM beeper
> +
> +maintainers:
> +  - Sascha Hauer <s.hauer@pengutronix.de>
> +
> +properties:
> +  compatible:
> +    items:

Drop 'items' as there is only 1.

> +      - const: pwm-beeper
> +
> +  pwms:
> +    description: Phandle to the physical PWM device
> +    $ref: /schemas/types.yaml#/definitions/phandle

Standard property which already has a type.

> +
> +  amp-supply:
> +    description: Phandle to a regulator that acts as an amplifier for th=
e beeper
> +
> +  beeper-hz:
> +    description: bell frequency in Hz
> +    minimum: 1
> +    maximum: 255

doubtful a beeper can generate frequencies of 1-255Hz...

> +
> +required:
> +  - compatible
> +  - pwms
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    beeper_amp: amplifier {

Don't need to show providers in examples for the consumer.

> +       compatible =3D "regulator-fixed";
> +       gpios =3D <&gpio0 1 GPIO_ACTIVE_HIGH>;
> +       regulator-name =3D "beeper_amp";
> +    };
> +
> +    beeper {
> +        compatible =3D "pwm-beeper";
> +        pwms =3D <&pwm0>;
> +        amp-supply =3D <&beeper_amp>;

Make the example complete and add beeper-hz.

> +    };
> --
> 2.37.1
>
