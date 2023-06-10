Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B920B72A902
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 06:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbjFJEQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 00:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbjFJEQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 00:16:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C68730F8;
        Fri,  9 Jun 2023 21:16:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE71961EED;
        Sat, 10 Jun 2023 04:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57157C433A1;
        Sat, 10 Jun 2023 04:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686370581;
        bh=1X2OMYrZ6xQ16W4+zpul0HF3stiu96+45CBEnse6yHo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Pst8WmItaIN7FwghP7AsO+C1bWWyzk3aspuYQ0B8chEZKuRz45L/3jzMf/v0SlAlT
         /2apEPlkxFgZQ65wOe7ALrZ0FMJ/sI9w8aa6Zl3m0E3YRlgNV3QUUGhlyv9axf/mUi
         mr5Nf5Y71IP/bIhWmK5nsyQkFI2LhMXdt18DNYIKfEAiVlkpluLySWVHBpRf+BNE58
         5lfLEdapLADvnkqBwesmPfjZOC+SaDS5K182y2lax91kytxtQPUAzweHm4DcRa5YvZ
         3zygk24liBk0y2QCFsQItgqisgUiq7ne0Z9kV8LKItSQWrpa2S8tBu34Taf+4pgDxq
         5tO3OEoj5FISw==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2b1fe3a1a73so26880581fa.1;
        Fri, 09 Jun 2023 21:16:21 -0700 (PDT)
X-Gm-Message-State: AC+VfDyZzQOyAq1jx0D6SIJpxmVBv3Q19KCaJ5xnFCy02cyawnGudCxC
        GWIqfbJYE5LyhsfpCQv7P6Zj7PJ/fpzOsvLK2w==
X-Google-Smtp-Source: ACHHUZ6m4vTQH/KQgpBpVUFQm8Drlh/Tj4wvV9lKMgz3FTNRC1lT5533QbJb+YatE0QmIRAOjPhquVZH6CwN24OmU3Q=
X-Received: by 2002:ac2:5b1c:0:b0:4f1:3d9f:1b53 with SMTP id
 v28-20020ac25b1c000000b004f13d9f1b53mr1629565lfn.50.1686370579139; Fri, 09
 Jun 2023 21:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220919-v4-0-687f09a06dd9@baylibre.com> <20220919-v4-1-687f09a06dd9@baylibre.com>
 <20230608210504.GA3436215-robh@kernel.org> <CABnWg9tvBLH7R2Yqd_4=AOCdcHzw7Y-rigHN1jjoHe0EUGk1Bw@mail.gmail.com>
In-Reply-To: <CABnWg9tvBLH7R2Yqd_4=AOCdcHzw7Y-rigHN1jjoHe0EUGk1Bw@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 10 Jun 2023 12:16:07 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8tTbHabG6j6h+FgLJ60VczF1ewEZYHgGe536LsKRm8_w@mail.gmail.com>
Message-ID: <CAAOTY_8tTbHabG6j6h+FgLJ60VczF1ewEZYHgGe536LsKRm8_w@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] dt-bindings: display: mediatek: add MT8195 hdmi bindings
To:     Guillaume Ranquet <granquet@baylibre.com>
Cc:     Rob Herring <robh@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Jitao shi <jitao.shi@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mac.shen@mediatek.com,
        stuart.lee@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Guillaume:

Guillaume Ranquet <granquet@baylibre.com> =E6=96=BC 2023=E5=B9=B46=E6=9C=88=
9=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8811:50=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Thu, 08 Jun 2023 23:05, Rob Herring <robh@kernel.org> wrote:
> >On Mon, May 29, 2023 at 04:30:58PM +0200, Guillaume Ranquet wrote:
> >> Add mt8195 SoC bindings for hdmi and hdmi-ddc
> >>
> >> On mt8195 the ddc i2c controller is part of the hdmi IP block and thus=
 has no
> >> specific register range, power domain or interrupt, making it simpler
> >> than the legacy "mediatek,hdmi-ddc" binding.
> >>
> >> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> >> ---
> >>  .../bindings/display/mediatek/mediatek,hdmi.yaml   | 59 +++++++++++++=
+++++----
> >>  .../display/mediatek/mediatek,mt8195-hdmi-ddc.yaml | 45 +++++++++++++=
++++
> >>  2 files changed, 93 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediat=
ek,hdmi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,=
hdmi.yaml
> >> index b90b6d18a828..4f62e6b94048 100644
> >> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi=
.yaml
> >> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi=
.yaml
> >> @@ -21,6 +21,7 @@ properties:
> >>        - mediatek,mt7623-hdmi
> >>        - mediatek,mt8167-hdmi
> >>        - mediatek,mt8173-hdmi
> >> +      - mediatek,mt8195-hdmi
> >>
> >>    reg:
> >>      maxItems: 1
> >> @@ -29,18 +30,10 @@ properties:
> >>      maxItems: 1
> >>
> >>    clocks:
> >> -    items:
> >> -      - description: Pixel Clock
> >> -      - description: HDMI PLL
> >> -      - description: Bit Clock
> >> -      - description: S/PDIF Clock
> >> +    maxItems: 4
> >>
> >>    clock-names:
> >> -    items:
> >> -      - const: pixel
> >> -      - const: pll
> >> -      - const: bclk
> >> -      - const: spdif
> >> +    maxItems: 4
> >>
> >>    phys:
> >>      maxItems: 1
> >> @@ -58,6 +51,9 @@ properties:
> >>      description: |
> >>        phandle link and register offset to the system configuration re=
gisters.
> >>
> >> +  power-domains:
> >> +    maxItems: 1
> >> +
> >>    ports:
> >>      $ref: /schemas/graph.yaml#/properties/ports
> >>
> >> @@ -86,9 +82,50 @@ required:
> >>    - clock-names
> >>    - phys
> >>    - phy-names
> >> -  - mediatek,syscon-hdmi
> >>    - ports
> >>
> >> +allOf:
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            const: mediatek,mt8195-hdmi
> >> +    then:
> >> +      properties:
> >> +        clocks:
> >> +          items:
> >> +            - description: APB
> >> +            - description: HDCP
> >> +            - description: HDCP 24M
> >> +            - description: Split HDMI
> >> +        clock-names:
> >> +          items:
> >> +            - const: hdmi_apb_sel
> >> +            - const: hdcp_sel
> >> +            - const: hdcp24_sel
> >> +            - const: split_hdmi
> >> +
> >> +      required:
> >> +        - power-domains
> >> +    else:
> >> +      properties:
> >> +        clocks:
> >> +          items:
> >> +            - description: Pixel Clock
> >> +            - description: HDMI PLL
> >> +            - description: Bit Clock
> >> +            - description: S/PDIF Clock
> >> +
> >> +        clock-names:
> >> +          items:
> >> +            - const: pixel
> >> +            - const: pll
> >> +            - const: bclk
> >> +            - const: spdif
> >
> >I don't understand how the same h/w block can have completely different
> >clocks. If not the same h/w or evolution of the same h/w, then do a
> >separate schema.
> >
>
> Hi Rob,
>
> I'm not entirely sure what's the best approach here.
> The IPs are different enough to warrant a separate schema IMHO.
> Though CK asked me to merge both IPs together (for both schema and code).
>
> CK might want to chime in and advocate his point of view?

For all the mediatek hdmi device, input mediatek internal video
signal, and output hdmi signal, so I'm curious about how mt8195-hdmi
device is different with other mediatek hdmi device. I think pixel
clock is an important clock which is related to resolution and fps. So
I think every hdmi device should have a clock which related to pixel
clock. I does not find it in mt8195 device. Is one of the clock the
parent clock of pixel clock or one of the clock is pixel clock but you
give it another naming? Please conduct with mediatek stuff and give us
these information, so we have information to judge mt8195-hdmi is
different with other mediatek hdmi device or similar to. For other
three clocks, I still need these information.

Regards,
Chun-Kuang.

>
> >> +
> >> +      required:
> >> +        - mediatek,syscon-hdmi
> >> +
> >>  additionalProperties: false
> >>
> >>  examples:
> >> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediat=
ek,mt8195-hdmi-ddc.yaml b/Documentation/devicetree/bindings/display/mediate=
k/mediatek,mt8195-hdmi-ddc.yaml
> >> new file mode 100644
> >> index 000000000000..84c096835b47
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,mt81=
95-hdmi-ddc.yaml
> >> @@ -0,0 +1,45 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/display/mediatek/mediatek,mt8195-h=
dmi-ddc.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Mediatek HDMI DDC for mt8195
> >> +
> >> +maintainers:
> >> +  - CK Hu <ck.hu@mediatek.com>
> >> +  - Jitao shi <jitao.shi@mediatek.com>
> >> +
> >> +description: |
> >> +  The HDMI DDC i2c controller is used to interface with the HDMI DDC =
pins.
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - mediatek,mt8195-hdmi-ddc
> >> +
> >> +  clocks:
> >> +    maxItems: 1
> >> +
> >> +  mediatek,hdmi:
> >> +    $ref: /schemas/types.yaml#/definitions/phandle
> >> +    description:
> >> +      A phandle to the mt8195 hdmi controller
> >> +
> >> +required:
> >> +  - compatible
> >> +  - clocks
> >> +
> >> +additionalProperties: false
> >> +
> >> +examples:
> >> +  - |
> >> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> >> +    #include <dt-bindings/interrupt-controller/irq.h>
> >> +    hdmiddc0: i2c {
> >> +      compatible =3D "mediatek,mt8195-hdmi-ddc";
> >> +      mediatek,hdmi =3D <&hdmi0>;
> >> +      clocks =3D <&clk26m>;
> >
> >How does one access this h/w device? There is nothing described to
> >access it.
> >
>
> The device is embedded into the HDMI block and thus uses the
> mediatek,hdmi phandle to access its sets of registers in the middle of
> the mediatek,hdmi register range.
>
> Hope this clarifies things,
> Guillaume.
>
> >Rob
