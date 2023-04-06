Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CA66D97AE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjDFNMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjDFNM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:12:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F688901C;
        Thu,  6 Apr 2023 06:12:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C05E36472A;
        Thu,  6 Apr 2023 13:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADFFC4339C;
        Thu,  6 Apr 2023 13:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680786741;
        bh=h9ji6NYGYKhe8pru+plznJ5ni8zeCU3Dta5EJvRMeRo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PjG4crlQOjp5xxZmpAMnr4kZzad/soJ0KNGo0HGrmiUCC9bT0Ru9qwccDBM7xlFqv
         iCxhiA7JmfQwtz+kz7E67ZkRPZywb6mOgoPl85WBlgZv2w1gy35+9Uklt67ny/l8qD
         oSIecvVTLcOUh5ILCDpRhEPJJEOklj2rG5AkRob2iesB+MuzM7LuoedaDESuLve2na
         4ON2tIMn3I+/o3pHq0VLx/2UDJzpssBoiM1TpLCD22w3iyoc5Xo4NQWWLK1n0X2vOs
         MfrnzCYQzBSebjopvH3+FB9cC6wD8F5czhWTrHrscJWd183FfgyZjs3B5yT0zkzTFQ
         3yIiQCSEurKDg==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5491fa028adso242128537b3.10;
        Thu, 06 Apr 2023 06:12:21 -0700 (PDT)
X-Gm-Message-State: AAQBX9drupBewGHVmCut8uNDLyBmzCl5fJcA9zhDbcIkiwirLmNrh+bh
        YqmBsz2T2J1fmJOzvlwGpJMEW309l8T7xQHl4g==
X-Google-Smtp-Source: AKy350ZOxDGy7DDkguaA4F8q871wWQIN+RJcOt+kM/r0F3L1IVxOIlzJuURUtatL4qNsqf5I9ctDXNLKAui/uCpRtn8=
X-Received: by 2002:a81:b207:0:b0:545:a7d8:f278 with SMTP id
 q7-20020a81b207000000b00545a7d8f278mr5591986ywh.5.1680786740183; Thu, 06 Apr
 2023 06:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230328091831.55690-1-danascape@gmail.com>
In-Reply-To: <20230328091831.55690-1-danascape@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 6 Apr 2023 08:12:09 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJzxQb1g=yVgHduLnYOpk8-Q3jppA1qQT1Ce51_gNWjhg@mail.gmail.com>
Message-ID: <CAL_JsqJzxQb1g=yVgHduLnYOpk8-Q3jppA1qQT1Ce51_gNWjhg@mail.gmail.com>
Subject: Re: [PATCH v5] ASoC: dt-bindings: ak4458: Convert to dtschema
To:     Saalim Quadri <danascape@gmail.com>
Cc:     krzysztof.kozlowski@linaro.org, broonie@kernel.org,
        daniel.baluta@nxp.com, krzysztof.kozlowski+dt@linaro.org,
        shengjiu.wang@nxp.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Mar 28, 2023 at 4:18=E2=80=AFAM Saalim Quadri <danascape@gmail.com>=
 wrote:
>
> Convert the AK4458 audio DAC bindings to DT schema.
>
> Signed-off-by: Saalim Quadri <danascape@gmail.com>
> ---
> Changes:
> V1 -> V2: Use the correct way for dsd-path property
>           Drop ak4458 label form example
> V2 -> V3: ak4458 is the only one that does not support dsd-path, so we
>           do not require to define an array
> V3 -> V4: Add back dsd-path property description
> V4 -> V5: Fix yaml format as per example-schema
>
>  .../devicetree/bindings/sound/ak4458.txt      | 28 -------
>  .../bindings/sound/asahi-kasei,ak4458.yaml    | 73 +++++++++++++++++++
>  2 files changed, 73 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/ak4458.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/asahi-kasei,a=
k4458.yaml
>
> diff --git a/Documentation/devicetree/bindings/sound/ak4458.txt b/Documen=
tation/devicetree/bindings/sound/ak4458.txt
> deleted file mode 100644
> index 0416c14895d6..000000000000
> --- a/Documentation/devicetree/bindings/sound/ak4458.txt
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -AK4458 audio DAC
> -
> -This device supports I2C mode.
> -
> -Required properties:
> -
> -- compatible : "asahi-kasei,ak4458" or "asahi-kasei,ak4497"
> -- reg : The I2C address of the device for I2C
> -
> -Optional properties:
> -- reset-gpios: A GPIO specifier for the power down & reset pin
> -- mute-gpios: A GPIO specifier for the soft mute pin
> -- AVDD-supply: Analog power supply
> -- DVDD-supply: Digital power supply
> -- dsd-path: Select DSD input pins for ak4497
> -            0: select #16, #17, #19 pins
> -            1: select #3, #4, #5 pins
> -
> -Example:
> -
> -&i2c {
> -       ak4458: dac@10 {
> -               compatible =3D "asahi-kasei,ak4458";
> -               reg =3D <0x10>;
> -               reset-gpios =3D <&gpio1 10 GPIO_ACTIVE_LOW>
> -               mute-gpios =3D <&gpio1 11 GPIO_ACTIVE_HIGH>
> -       };
> -};
> diff --git a/Documentation/devicetree/bindings/sound/asahi-kasei,ak4458.y=
aml b/Documentation/devicetree/bindings/sound/asahi-kasei,ak4458.yaml
> new file mode 100644
> index 000000000000..0db0c8e923a0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/asahi-kasei,ak4458.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/asahi-kasei,ak4458.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AK4458 audio DAC
> +
> +maintainers:
> +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - asahi-kasei,ak4458
> +      - asahi-kasei,ak4497
> +
> +  reg:
> +    maxItems: 1
> +
> +  avdd-supply:
> +    description: Analog power supply
> +
> +  dvdd-supply:
> +    description: Digital power supply
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  mute-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO used to mute all the outputs
> +
> +  dsd-path:
> +    description: Select DSD input pins for ak4497
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    oneOf:
> +      - const: 0
> +        description: select #16, #17, #19 pins
> +      - const: 1
> +        description: select #3, #4, #5 pins

'#' (with a space or newline before) is a comment, so these need to be
quoted. I only noticed because yamllint now requires a space after as
well:

./Documentation/devicetree/bindings/sound/asahi-kasei,ak4458.yaml:40:30:
[error] missing starting space in comment (comments)
./Documentation/devicetree/bindings/sound/asahi-kasei,ak4458.yaml:42:30:
[error] missing starting space in comment (comments)

Rob
