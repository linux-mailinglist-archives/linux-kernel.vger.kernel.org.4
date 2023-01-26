Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E93F67C8A2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 11:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236480AbjAZKee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 05:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236038AbjAZKeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 05:34:31 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E043D577DC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:34:27 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id kt14so3912212ejc.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yNKGiFVF7gZl8W9gtBpFjfAaHbcRzsNNp7MAmipi5tM=;
        b=sUSCEuKpo0FtzU8NNmxCzR/r2KwAtc7S3/o1ClFq6L9vLkC3QIXXqEZ1opixeisU2G
         iQTu9Eem/CRw6cJOSeu7z6mPcb7H/FVOfoZ44gOSFpxE8OI6Gwzrgh5AEeogGN8s+g4i
         KCHz5FZ76MAQjOHnzVRtA3LXcGWipp0RxLRwDT/QDXulGWbSn6K0iQT23A+suDeAfldL
         ZlqmQnVFVyHgdNSeaLuxDM27lWzd7rcg7/8h+i2P943Mv4R0tr4a03cqFezJDRNzYFec
         U2fF6z/pk8rZeVEQD1pEE4HvcznmUxdp79rYtx0UoQRipTTEKRNGgyHYqLf3I5Fma1c5
         r06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yNKGiFVF7gZl8W9gtBpFjfAaHbcRzsNNp7MAmipi5tM=;
        b=lv+mpXOakK790BUDnrL8v5SNxtD7H4C1VXNL3erZGSaQJ5dUmW4LKRUA1SF/W4D9wp
         NuE8qJvg5iOmWT/2ETtDreEiyeh12JL9ya2p4kpdU0ihSbCZCr1CAFOJYlpHqm3eTWDZ
         q/c6cUih22GK0HpkMNzWoWu6mSw1bG/AT6RonHoMmSFg0CIy1fDs6So+Eb85jVobirla
         o9BorYKjMcJUJG0nnXdpRb2eM2R291dK5JDCVR98p0JMx0+7ayrHGjH7zr5kWKyKDYt8
         p8Rqw/A4XXg55xcudJ6Y9t3hZ4PlEPP5XWIdj+pddUNj5EU3s/yQ31yoxiulwn9Hzcf5
         0NNQ==
X-Gm-Message-State: AFqh2krUEwkQzDaLR8o4nBrVPXEqvcc/eyuj769vsED67MIuSlV4tE0i
        Xr/HO18ulR/MDI07/2f+m6FfCyzist857VLEiNz4Mw==
X-Google-Smtp-Source: AMrXdXu0EMTejStEvfuw0MDinG//EO3AdM5XPHW4c5XWtjDfz8npqgxmZS5z1qRVIzw1wvFeVznkiNtOTi4NmJ3dBNA=
X-Received: by 2002:a17:906:80da:b0:872:618e:b01c with SMTP id
 a26-20020a17090680da00b00872618eb01cmr3636438ejx.275.1674729266315; Thu, 26
 Jan 2023 02:34:26 -0800 (PST)
MIME-Version: 1.0
References: <20230124131717.128660-1-bchihi@baylibre.com> <20230124131717.128660-3-bchihi@baylibre.com>
 <20230125203420.GA2855708-robh@kernel.org>
In-Reply-To: <20230125203420.GA2855708-robh@kernel.org>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Thu, 26 Jan 2023 11:33:50 +0100
Message-ID: <CAGuA+oq1F4UnEz+ujjtaj=+WCMZOky38B4z4go7TXhMYt1EeEw@mail.gmail.com>
Subject: Re: [PATCH v11 2/6] dt-bindings/thermal/mediatek: Add LVTS thermal
 controllers dt-binding definition
To:     Rob Herring <robh@kernel.org>
Cc:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, Jan 25, 2023 at 9:34 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Jan 24, 2023 at 02:17:13PM +0100, bchihi@baylibre.com wrote:
> > From: Balsam CHIHI <bchihi@baylibre.com>
> >
>
> dt-bindings: thermal: ... for the subject

I will fix it.

>
> > Add LVTS thermal controllers dt-binding definition for mt8195.
> >
> > Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> > ---
> >  .../thermal/mediatek,lvts-thermal.yaml        | 107 ++++++++++++++++++
> >  include/dt-bindings/thermal/mediatek-lvts.h   |  19 ++++
> >  2 files changed, 126 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> >  create mode 100644 include/dt-bindings/thermal/mediatek-lvts.h
> >
> > diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> > new file mode 100644
> > index 000000000000..12bfbdd8ff89
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> > @@ -0,0 +1,107 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/thermal/mediatek,lvts-thermal.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MediaTek SoC Low Voltage Thermal Sensor (LVTS)
> > +
> > +maintainers:
> > +  - Balsam CHIHI <bchihi@baylibre.com>
> > +
> > +description: |
> > +  LVTS is a thermal management architecture composed of three subsystems,
> > +  a Sensing device - Thermal Sensing Micro Circuit Unit (TSMCU),
> > +  a Converter - Low Voltage Thermal Sensor converter (LVTS), and
> > +  a Digital controller (LVTS_CTRL).
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - mediatek,mt8195-lvts-ap
> > +      - mediatek,mt8195-lvts-mcu
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +    description: LVTS reset for clearing temporary data on AP/MCU.
> > +
> > +  nvmem-cells:
> > +    minItems: 1
> > +    items:
> > +      - description: Calibration eFuse data 1 for LVTS
> > +      - description: Calibration eFuse data 2 for LVTS
> > +
> > +  nvmem-cell-names:
> > +    minItems: 1
> > +    items:
> > +      - const: lvts-calib-data-1
> > +      - const: lvts-calib-data-2
> > +
> > +  "#thermal-sensor-cells":
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - resets
> > +  - nvmem-cells
> > +  - nvmem-cell-names
> > +  - "#thermal-sensor-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/clock/mt8195-clk.h>
> > +    #include <dt-bindings/reset/mt8195-resets.h>
> > +    #include <dt-bindings/thermal/mediatek-lvts.h>
> > +
> > +    soc {
> > +      #address-cells = <2>;
> > +      #size-cells = <2>;
> > +
> > +      lvts_mcu: thermal-sensor@11278000 {
> > +        compatible = "mediatek,mt8195-lvts-mcu";
> > +        reg = <0 0x11278000 0 0x1000>;
> > +        interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>;
> > +        clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
> > +        resets = <&infracfg_ao MT8195_INFRA_RST4_THERM_CTRL_MCU_SWRST>;
> > +        nvmem-cells = <&lvts_efuse_data1 &lvts_efuse_data2>;
> > +        nvmem-cell-names = "lvts-calib-data-1", "lvts-calib-data-2";
> > +        #thermal-sensor-cells = <1>;
> > +      };
> > +    };
> > +
> > +    thermal_zones: thermal-zones {
> > +      cpu0-thermal {
> > +        polling-delay = <1000>;
> > +        polling-delay-passive = <250>;
> > +        thermal-sensors = <&lvts_mcu MT8195_MCU_LITTLE_CPU0>;
> > +
> > +        trips {
> > +          cpu0_alert: trip-alert {
> > +            temperature = <85000>;
> > +            hysteresis = <2000>;
> > +            type = "passive";
> > +          };
> > +
> > +          cpu0_crit: trip-crit {
> > +            temperature = <100000>;
> > +            hysteresis = <2000>;
> > +            type = "critical";
> > +          };
> > +        };
> > +      };
> > +    };
> > diff --git a/include/dt-bindings/thermal/mediatek-lvts.h b/include/dt-bindings/thermal/mediatek-lvts.h
> > new file mode 100644
> > index 000000000000..428a95c18509
> > --- /dev/null
> > +++ b/include/dt-bindings/thermal/mediatek-lvts.h
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
>
> Okay with GPL 4? GPL-2.0-only
>
> Dual license please. Consistent with your .dts files.

I will fix this too.

>
> > +/*
> > + * Copyright (c) 2023 MediaTek Inc.
> > + * Author: Balsam CHIHI <bchihi@baylibre.com>
> > + */
> > +
> > +#ifndef __MEDIATEK_LVTS_DT_H
> > +#define __MEDIATEK_LVTS_DT_H
> > +
> > +#define MT8195_MCU_BIG_CPU0  0
> > +#define MT8195_MCU_BIG_CPU1  1
> > +#define MT8195_MCU_BIG_CPU2  2
> > +#define MT8195_MCU_BIG_CPU3  3
> > +#define MT8195_MCU_LITTLE_CPU0       4
> > +#define MT8195_MCU_LITTLE_CPU1       5
> > +#define MT8195_MCU_LITTLE_CPU2       6
> > +#define MT8195_MCU_LITTLE_CPU3       7
> > +
> > +#endif /* __MEDIATEK_LVTS_DT_H */
> > --
> > 2.34.1
> >

Thank you for the review.

Best regards,
Balsam
