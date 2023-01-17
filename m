Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C941366E21A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjAQP0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjAQP0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:26:25 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1054655BA;
        Tue, 17 Jan 2023 07:26:24 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9F3F610C;
        Tue, 17 Jan 2023 16:26:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1673969181;
        bh=tSDcjAh6bFmwIhxqPp/jq7QIdOqP7tA6ejjlekmgFZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BVlO2NPSanLnnpZ9sV70KYrrQe9hv2XFk89MRzJJ55jCEXhtEy0oWi7C3t5UzIqsr
         pq9GIkxGnIyLgvxDX1ajQ777N9AA2NfaRG1WJVmsPC/oEXti4UF4QHn96Ae6cKXVTL
         QEnC9WZFMQMXpfkUfgATNOUrxNC/JDtxvoTpnsY8=
Date:   Tue, 17 Jan 2023 17:26:22 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mark Brown <broonie@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/6] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface bindings
Message-ID: <Y8a+Hk2jFOjbkIvZ@pendragon.ideasonboard.com>
References: <20230111022433.25950-1-yuji2.ishikawa@toshiba.co.jp>
 <20230111022433.25950-2-yuji2.ishikawa@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230111022433.25950-2-yuji2.ishikawa@toshiba.co.jp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuji,

Thank you for the patch.

On Wed, Jan 11, 2023 at 11:24:28AM +0900, Yuji Ishikawa wrote:
> Adds the Device Tree binding documentation that allows to describe
> the Video Input Interface found in Toshiba Visconti SoCs.
> 
> Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
> Changelog v2:
> - no change
> 
> Changelog v3:
> - no change
> 
> Changelog v4:
> - fix style problems at the v3 patch
> - remove "index" member
> - update example
> 
> Changelog v5:
> - no change
> ---
>  .../bindings/media/toshiba,visconti-viif.yaml | 98 +++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml b/Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
> new file mode 100644
> index 00000000000..71442724d1a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/toshiba,visconti-viif.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/toshiba,visconti-viif.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Toshiba Visconti5 SoC Video Input Interface Device Tree Bindings
> +
> +maintainers:
> +  - Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> +
> +description:
> +  Toshiba Visconti5 SoC Video Input Interface (VIIF)
> +  receives MIPI CSI2 video stream,
> +  processes the stream with embedded image signal processor (L1ISP, L2ISP),
> +  then stores pictures to main memory.
> +
> +properties:
> +  compatible:
> +    const: toshiba,visconti-viif
> +
> +  reg:
> +    items:
> +      - description: registers for capture control
> +      - description: registers for CSI2 receiver control

Nitpicking, s/registers/Registers/ in the two lines above as you
capitalize the descriptions below.

> +
> +  interrupts:
> +    items:
> +      - description: Sync Interrupt
> +      - description: Status (Error) Interrupt
> +      - description: CSI2 Receiver Interrupt
> +      - description: L1ISP Interrupt
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    unevaluatedProperties: false
> +    description: Input port, single endpoint describing the CSI-2 transmitter.

I would write

    description:
      CSI-2 input port, with a single endpoint connected to the CSI-2
      transmitter.

> +
> +    properties:
> +      endpoint:
> +        $ref: video-interfaces.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          data-lanes:
> +            description: VIIF supports 2 or 4 data lines

s/lines/lanes/

> +            $ref: /schemas/types.yaml#/definitions/uint32-array

You can drop this line, it's already handled by video-interfaces.yaml.

> +            minItems: 1
> +            maxItems: 4

If only 2 or 4 data lanes are supported, shouldn't minItems be 2 ?

> +            items:
> +              minimum: 1
> +              maximum: 4

Can the CSI-2 receiver reorder the data lanes ? If not, I think you can
write

            items:
              - const: 1
              - const: 2
              - const: 3
              - const: 4

> +
> +          clock-lanes:
> +            description: VIIF supports 1 clock line

s/line/lane/

> +            const: 0

I would also add

          clock-noncontinuous: true
          link-frequencies: true

to indicate that the above two properties are used by this device.

Also, mark the properties that are required:

        required:
          - data-lanes
          - clock-lanes

I'm wondering, though, if clock-lanes shouldn't be simply omitted. If
the hardware doesn't support any other option than using lane 0 for the
clock lane (as in, no lane remapping), then you can drop the clock-lanes
property completely.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        viif@1c000000 {
> +            compatible = "toshiba,visconti-viif";
> +            reg = <0 0x1c000000 0 0x6000>,
> +                  <0 0x1c008000 0 0x400>;
> +            interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
> +
> +            port {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                csi_in0: endpoint {
> +                    remote-endpoint = <&imx219_out0>;
> +                    bus-type = <4>;

Does the hardware support any other bus type ? If not, you can drop the
bus-type. If it does, bus-type should be added to the binding, with the
value set to "const: 4".

> +                    data-lanes = <1 2>;
> +                    clock-lanes = <0>;
> +                    clock-noncontinuous;
> +                    link-frequencies = /bits/ 64 <456000000>;
> +                };
> +            };
> +        };
> +    };

-- 
Regards,

Laurent Pinchart
