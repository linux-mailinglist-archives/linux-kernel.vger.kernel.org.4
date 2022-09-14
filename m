Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64935B89CF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiINODX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiINOCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:02:36 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967C76389
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 07:01:59 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3452214cec6so181545187b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 07:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Jpvw6KQrg1S/1pBzjKmf1uB7j3K3Ydzu3g9Y661w0mg=;
        b=SkZLLCuVFtvkjNpiUf9LPgljx+x3GViN3GfToJE6bAHwx8xwEol/R5nw9W/QyFzRZ7
         gXOjT5KI08bgm1JpKwaz3Sxs9Et4ZJDxyn4xb2JZFOVP13qFGJvXO1nxuXEid0AQ1WLm
         SnZaYOTTr+rUN0Te1fG7rm+RBTk2Hk2ZJu1CnqLwW0o9DPkv4gTJL3Cj/ctaMZ/zDRZH
         a/IH8DAJxjb+9Qf8wXXAKSziVHP6QPIwJBC+gjpYM9N5kzTF/BQdeNbghraGPXv/8hiU
         HQ3AooobyqGbhFAMkhOhrL+1N27n6yOZlA2cMDGzRmp9Y4e6w2kqJSHZaK+9ldoEF0Q8
         38uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Jpvw6KQrg1S/1pBzjKmf1uB7j3K3Ydzu3g9Y661w0mg=;
        b=2/CWAcmJA0k6Vxul0p66dOCqjRKJ0ZiHznBSVd3Ne6xQsfltsnYPHwgWKCKnwOg+lH
         4BANK930lgcStCyeuwtRwJRv05Bp3Fpj2IGb/c3PY7Q6oEzp14eF0heSbihZCMZ1ROej
         GeCVFt4xSGrA6oxvKG4evlBIfxlBz0Qt084XAO9sShsHY/GSr4UdwHxqccEq4r6WZX8e
         gikZ7SV4nIznCMymhh7LJy2LNp6eoJUrpWsoD1tb0PVAGpI6bEN6NzQx1sSn+DVikR4s
         sAh7N0BMIw6TYTw6lAdB65aextP68EWdH28B7wmny1zF996OEIjmcKeEN4j87wvA+ik6
         jC2g==
X-Gm-Message-State: ACgBeo37N4PDMzBwDW8xPfh9aClgFgsKrAmrFqy/MJXlTutK6GHUMqbk
        Bt8CYy7xbrOaNnMKnPYeuo8MTrQFEt6VXV31AO+s8w==
X-Google-Smtp-Source: AA6agR4nfEc6ZNsx4IMOTInLJ4GeQaYzxa2yEmi0xC39dBnNrVhTzdhx3g4hnT+XIUeaBnxCZhEg3BlhYDeiFM6ISHA=
X-Received: by 2002:a81:1604:0:b0:345:3b96:a166 with SMTP id
 4-20020a811604000000b003453b96a166mr31947771yww.30.1663164118168; Wed, 14 Sep
 2022 07:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220817080757.352021-1-bchihi@baylibre.com> <20220817080757.352021-3-bchihi@baylibre.com>
 <716d6471-f0e2-489e-5f9e-9e38e9e7953a@collabora.com>
In-Reply-To: <716d6471-f0e2-489e-5f9e-9e38e9e7953a@collabora.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Wed, 14 Sep 2022 16:01:22 +0200
Message-ID: <CAGuA+orxfcycwcUMpLe+dkjnXPQkELQsz0vBggGKTQ04XRGc+g@mail.gmail.com>
Subject: Re: [PATCH v9,2/7] dt-bindings: thermal: Add dt-binding document for
 LVTS thermal controllers
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        mka@chromium.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

I've got the following errors after implementing these changes :
[...]
  nvmem-cells:
    minItems: 1
    description: Calibration eFuse data for LVTS

  nvmem-cell-names:
    minItems: 1
    items:
      pattern: 'lvts-calib-data[0-9]+$'

  "#thermal-sensor-cells":
    const: 1

allOf:
  - $ref: thermal-sensor.yaml#

  - if:
      properties:
        compatible:
          contains:
            enum:
              - mediatek,mt8192-lvts-ap
              - mediatek,mt8192-lvts-mcu
    then:
      properties:
        nvmem-cells:
          maxItems: 1

        nvmem-cell-names:
          maxItems: 1

  - if:
      properties:
        compatible:
          contains:
            enum:
              - mediatek,mt8195-lvts-ap
              - mediatek,mt8195-lvts-mcu
    then:
      properties:
        nvmem-cells:
          maxItems: 2

        nvmem-cell-names:
          maxItems: 2
[...]

$ make DT_CHECKER_FLAGS=-m dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
/home/balsam/src/linux-mtk-lvts-newThermalOF/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml:
properties:nvmem-cell-names:items: {'pattern':
'lvts-calib-data[0-9]+$'} is not of type 'array'
from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
/home/balsam/src/linux-mtk-lvts-newThermalOF/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml:
ignoring, error in schema: properties: nvmem-cell-names: items
  DTEX    Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.example.dts
  DTC     Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.example.dtb
  CHECK   Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.example.dtb
Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.example.dtb:0:0:
/example-0/soc/thermal-sensor@1100b000: failed to match any schema
with compatible: ['mediatek,mt8192-lvts-ap']

am I missing something?

Best regards,
Balsam

On Wed, Sep 14, 2022 at 2:19 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 17/08/22 10:07, bchihi@baylibre.com ha scritto:
> > From: Alexandre Bailon <abailon@baylibre.com>
> >
> > Add dt-binding document for mt8192 and mt8195 LVTS thermal controllers.
> >
> > Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> > Co-developed-by: Balsam CHIHI <bchihi@baylibre.com>
> > Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> > ---
> >   .../thermal/mediatek,lvts-thermal.yaml        | 152 ++++++++++++++++++
> >   1 file changed, 152 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> > new file mode 100644
> > index 000000000000..31d9e220513a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> > @@ -0,0 +1,152 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/thermal/mediatek,lvts-thermal.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MediaTek SoC LVTS thermal controller
>
> title: MediaTek SoC Low Voltage Thermal Sensor (LVTS)
>
> > +
> > +maintainers:
> > +  - Yu-Chia Chang <ethan.chang@mediatek.com>
> > +  - Ben Tseng <ben.tseng@mediatek.com>
> > +
> > +description: |
>
> description:
>    LVTS is a thermal management architecture composed of three subsystems,
>    a Sensing device - Thermal Sensing Micro Circuit Unit (TSMCU),
>    a Convertor - Low Voltage Thermal Sensor convertor (LVTS), and
>    a Digital controller (LVTS_CTRL).
>
> > +  LVTS (Low Voltage Thermal Sensor).
> > +  The architecture will be first used on mt8192 and mt8195.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - mediatek,mt8192-lvts-ap
> > +      - mediatek,mt8192-lvts-mcu
> > +      - mediatek,mt8195-lvts-ap
> > +      - mediatek,mt8195-lvts-mcu
> > +
> > +  "#thermal-sensor-cells":
> > +    const: 1
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description: LVTS instance registers.
>
> This description looks obvious, as it doesn't really say anything "new"...
> I would rather drop it.
>
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +    description: LVTS instance interrupts.
>
> Same here
>
> > +
> > +  clocks:
> > +    maxItems: 1
> > +    description: LVTS instance clock.
>
> and here.
>
> > +
> > +  resets:
> > +    maxItems: 1
> > +    description: |
> > +      LVTS instance SW reset for HW AP/MCU domain to clean temporary data
> > +      on HW initialization/resume.
>
> What about something like...
>
>    resets:
>      items:
>        - description: LVTS reset for clearing temporary data on AP/MCU
>
> > +
> > +  nvmem-cells:
> > +    minItems: 1
> > +    maxItems: 2
> > +    description: Calibration efuse data for LVTS
>
>    nvmem-cells:
>      minItems: 1
>      items:
>        - description: Calibration eFuse data for LVTS
>        - description: Additional eFuse data (?)
>
>
> > +
> > +  nvmem-cell-names:
> > +    minItems: 1
> > +    maxItems: 2
> > +    description: Calibration efuse cell names for LVTS
>
> Actually, maxItems is not really two, but it depends on how many
> eFuse arrays / nvmem cells we have for each SoC, so I was thinking...
>
> ...what about doing something like
>
>    nvmem-cell-names:
>      minItems: 1
>      items:
>        pattern: 'lvts-calib-data[0-9]+$'
>
> and then,
>    if:
>      properties:
>        compatible:
>          contains:
>            enum:
>              - mediatek,blahblah-something
>    then:
>      properties:
>        nvmem-cell-names:
>          maxItems: 2 (or 3, 4, 5...)
>
> P.S.: I haven't tried any binding check on the proposed lines.
>
> Krzysztof, any opinions on that?
>
> Regards,
> Angelo
>
>
>
