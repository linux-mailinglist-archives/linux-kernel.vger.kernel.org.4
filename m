Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA96D6B71DD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjCMI71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjCMI7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:59:04 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF865A1B5;
        Mon, 13 Mar 2023 01:54:56 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5419d4c340aso42933137b3.11;
        Mon, 13 Mar 2023 01:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678697695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NCgd6tuaHBDOiTZW9CVlzEgxDA28IvutIsaMd7oX50=;
        b=HZgoB6aKIVi2nBeKfCTqBHjzBjiVkFPw5ki1bB37dD9InxqJ2Wf1ljZ53CDnCz674u
         KLeAyOlbc1n6TPqS8uxO2KO3WQGhk1BgjPnm2obNoZh5FzrE+h7Ad5am5H/hlTPqciUs
         G52Y3TnO1JVKgnXaKqHgkKAeQe6+2lnSelFQ2Moffvd5zoRP6MLDd3TnESJKP89vu98r
         BRsc3dMEejIIByXEJNgK4hRDTfqbV53oWhVs7MyzVeiIlL5J0W+nCTZ/0AlKi9hk+PM0
         TB8YbtjqtMKY+gkvMwbsfh5ZSBhcepzXKf5jhTMU/mOYL+tO0WJ7KA3rxq6NvO+jUNOe
         Tcog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678697695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NCgd6tuaHBDOiTZW9CVlzEgxDA28IvutIsaMd7oX50=;
        b=vpUnz3AxXd1psCoEuqdgbW+npbZzIeDixinU8fJ4KXON29sg2V+fFe4O/Dr1y69rWg
         6fsLPOTO41WGLAN1FkkDhMoZsLobx6AgCWRvEVb4SsKF4Rp6NHw7MErIb7JbceVJnoPO
         jaeVXlSOVBzTjb/G2BhGm28ad2JJcIBXkzIRYt7xPuWwIZy46ssJ7moPsZFjhtdge1Hp
         A/Hr8HCzMw/wXg4j693s35+nRFxw3Csqsf9+gFpWbzWt1KaWfEIj4FR+BQKAJAJ2IqSt
         sP9Va+T5vPf5YXht+hOkAq/TUNByCIjXC8bxyPsGZBplSqH6otmZo743yamvwYhEewta
         ZEOw==
X-Gm-Message-State: AO0yUKXck0q1UQqAPrBBKZ3XwHhN0MPrKOKKhstGDQhvkvRU3v2Uz/Jw
        0h8kGoIQ64YpZiB6Yeb8038UiupaFENF98H/0y8=
X-Google-Smtp-Source: AK7set+5EDJAAXdVYJQM5llasnCzJsaOc111qwF6lT7P251dy0Wjo2jefcmVtKCPdNGGpLx6eJXc0kR+yXyN59PqpmU=
X-Received: by 2002:a81:b10a:0:b0:53d:2772:65d with SMTP id
 p10-20020a81b10a000000b0053d2772065dmr16019576ywh.9.1678697695226; Mon, 13
 Mar 2023 01:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230110083238.19230-1-jim.t90615@gmail.com> <20230110083238.19230-4-jim.t90615@gmail.com>
 <167335661623.1967925.9927691364268671668.robh@kernel.org>
In-Reply-To: <167335661623.1967925.9927691364268671668.robh@kernel.org>
From:   Jim Liu <jim.t90615@gmail.com>
Date:   Mon, 13 Mar 2023 16:54:44 +0800
Message-ID: <CAKUZ0+HQYiwp0pGLhQUckk9zOYg42MSWucYss6iP68YRmHyAxA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] dt-bindings: gpio: add NPCM sgpio driver bindings
To:     Rob Herring <robh@kernel.org>
Cc:     linux-gpio@vger.kernel.org, JJLIU0@nuvoton.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, KWLIU@nuvoton.com,
        openbmc@lists.ozlabs.org, brgl@bgdev.pl,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        krzysztof.kozlowski+dt@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof

sorry for reply late.
I think I need to explain more details about the clock.

The NPCM7xx / NPCM8xx  SGPIO feature have 4 pins.
picture is as below:
https://drive.google.com/file/d/1E9i_Avh-AZV9IEZO1HLMT4EtgCBe46OV/view?usp=
=3Dsharing

The clock is generated from npcm7xx APB.
The bus frequency is derived from npcm7xx APB not HC595/HC165.
Users can connect  1~8 HC595 on DOUT pin to decode the serial data for
HC595 A~H pin
and can connect  1~8 HC165 on DIN pin to encode the serial data to
send to NPCM7xx.

The test device is as below:
https://pdf1.alldatasheet.com/datasheet-pdf/view/345467/TI/SN74HC595N.html
https://pdf1.alldatasheet.com/datasheet-pdf/view/27899/TI/SN74HC165N.html

NPCM7xx/NPCM8xx have two sgpio modules;
each module can support up to 64 output pins,and up to 64 input pins.
If the user needs 64 output pins , user needs to connect 8 HC595.
If the user needs 64 input pins , user needs to connect 8 HC165.

the HC595 and HC165 connect is as below:
NPCM7xx_DOUT    ->   HC595  SER pin
NPCM7xx_SCLK     ->   HC595  SRCLK pin
NPCM7xx_LDSH    ->    HC595  RCLK pin

NPCM7xx_SCLK     ->   HC165  CLK pin
NPCM7xx_LDSH     ->   HC165  SH/LD pin
NPCM7xx_DIN        ->    HC165  QH pin

The frequency is not derived from the input clock. so i think maybe
the yaml needs to describe it.
if yaml file still didn't need please let me know.

And if you have any confusion about the sgpio feature or the connect
test please let me know.


Best regards,
Jim

On Tue, Jan 10, 2023 at 9:29=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
>
> On Tue, 10 Jan 2023 16:32:38 +0800, Jim Liu wrote:
> > Add dt-bindings document for the Nuvoton NPCM7xx and NPCM8xx sgpio driv=
er
> >
> > Signed-off-by: Jim Liu <jim.t90615@gmail.com>
> > ---
> > Changes for v4:
> >    - modify in/out property
> >    - modify bus-frequency property
> > Changes for v3:
> >    - modify description
> >    - modify in/out property name
> > Changes for v2:
> >    - modify description
> > ---
> >  .../bindings/gpio/nuvoton,sgpio.yaml          | 92 +++++++++++++++++++
> >  1 file changed, 92 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/gpio/nuvoton,sgpi=
o.yaml
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/g=
pio/nuvoton,sgpio.yaml: properties:nuvoton,input-ngpios: 'oneOf' conditiona=
l failed, one must be fixed:
>         'type' is a required property
>                 hint: A vendor boolean property can use "type: boolean"
>         Additional properties are not allowed ('maximum', 'minimum' were =
unexpected)
>                 hint: A vendor boolean property can use "type: boolean"
>         /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bi=
ndings/gpio/nuvoton,sgpio.yaml: properties:nuvoton,input-ngpios: 'oneOf' co=
nditional failed, one must be fixed:
>                 'enum' is a required property
>                 'const' is a required property
>                 hint: A vendor string property with exact values has an i=
mplicit type
>                 from schema $id: http://devicetree.org/meta-schemas/vendo=
r-props.yaml#
>         /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bi=
ndings/gpio/nuvoton,sgpio.yaml: properties:nuvoton,input-ngpios: 'oneOf' co=
nditional failed, one must be fixed:
>                 '$ref' is a required property
>                 'allOf' is a required property
>                 hint: A vendor property needs a $ref to types.yaml
>                 from schema $id: http://devicetree.org/meta-schemas/vendo=
r-props.yaml#
>         hint: Vendor specific properties must have a type and description=
 unless they have a defined, common suffix.
>         from schema $id: http://devicetree.org/meta-schemas/vendor-props.=
yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/g=
pio/nuvoton,sgpio.yaml: properties:nuvoton,output-ngpios: 'oneOf' condition=
al failed, one must be fixed:
>         'type' is a required property
>                 hint: A vendor boolean property can use "type: boolean"
>         Additional properties are not allowed ('maximum', 'minimum' were =
unexpected)
>                 hint: A vendor boolean property can use "type: boolean"
>         /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bi=
ndings/gpio/nuvoton,sgpio.yaml: properties:nuvoton,output-ngpios: 'oneOf' c=
onditional failed, one must be fixed:
>                 'enum' is a required property
>                 'const' is a required property
>                 hint: A vendor string property with exact values has an i=
mplicit type
>                 from schema $id: http://devicetree.org/meta-schemas/vendo=
r-props.yaml#
>         /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bi=
ndings/gpio/nuvoton,sgpio.yaml: properties:nuvoton,output-ngpios: 'oneOf' c=
onditional failed, one must be fixed:
>                 '$ref' is a required property
>                 'allOf' is a required property
>                 hint: A vendor property needs a $ref to types.yaml
>                 from schema $id: http://devicetree.org/meta-schemas/vendo=
r-props.yaml#
>         hint: Vendor specific properties must have a type and description=
 unless they have a defined, common suffix.
>         from schema $id: http://devicetree.org/meta-schemas/vendor-props.=
yaml#
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202301=
10083238.19230-4-jim.t90615@gmail.com
>
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.
>
