Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AAF732BE0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344574AbjFPJdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344563AbjFPJcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:32:39 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAD32721;
        Fri, 16 Jun 2023 02:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1686907926; x=1718443926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pMlSGOdl8IvS4LImlgrl3MIkfMf7pCHaKnwUSkpFQ1o=;
  b=YEWxWmPpbP3E+yqsp9tfqMOGRkvR2GmoMvSnDDUwMtappEgJv6EnX3ye
   iDHmYuLC3+TAT7r4O2aty5ZVP15k/vNNTZCfRHKFHTFD7peDJJGVRI0RD
   AoTAVr35yHp7ilZjp6acddBmxbZ5r5yi7vMYQLebPeesEJky2fVxA4QUe
   /Rpn7SyKjy8LRXu01OmFWewctJNlsHQ1CP2g1M+hqvkyLMiaJnMucBly7
   SoGzfuYy0NkqAVIxEsNg6r1clkwlaffrM9ZCZfu3942dj6zJUaP+U0E6m
   pG2tJP7kKU653WS1nhJHniNMfl6YqPn4JcwbpqtqH1MMq6sK2D+ng2Ytw
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,247,1681164000"; 
   d="scan'208";a="31462623"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 16 Jun 2023 11:31:42 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 3A7A9280082;
        Fri, 16 Jun 2023 11:31:42 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, vkoul@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     oliver.brown@nxp.com, Sandor.yu@nxp.com, linux-imx@nxp.com,
        kernel@pengutronix.de, Sandor Yu <Sandor.yu@nxp.com>
Subject: Re: [PATCH v6 2/8] dt-bindings: display: bridge: Add Cadence MHDP8501 HDMI and DP
Date:   Fri, 16 Jun 2023 11:31:43 +0200
Message-ID: <3439354.PYKUYFuaPT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <8687f2221299b120e12f29fdccf264e120227bd7.1686729444.git.Sandor.yu@nxp.com>
References: <cover.1686729444.git.Sandor.yu@nxp.com> <8687f2221299b120e12f29fdccf264e120227bd7.1686729444.git.Sandor.yu@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandor,

Am Donnerstag, 15. Juni 2023, 03:38:12 CEST schrieb Sandor Yu:
> Add bindings for Cadence MHDP8501 DisplayPort and HDMI driver.
>=20
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> ---
>  .../display/bridge/cdns,mhdp8501.yaml         | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml
>=20
> diff --git
> a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml
> b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml new
> file mode 100644
> index 000000000000..a54756815e6f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8501.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/cdns,mhdp8501.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence MHDP8501 Displayport bridge
> +
> +maintainers:
> +  - Sandor Yu <Sandor.yu@nxp.com>
> +
> +description:
> +  The Cadence MHDP8501 Displayport/HDMI TX interface.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cdns,mhdp8501-dp
> +      - cdns,mhdp8501-hdmi
> +      - fsl,imx8mq-mhdp8501-dp
> +      - fsl,imx8mq-mhdp8501-hdmi
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: MHDP8501 DP/HDMI APB clock.
> +
> +  phys:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: Hotplug cable plugin.
> +      - description: Hotplug cable plugout.
> +
> +  interrupt-names:
> +    items:
> +      - const: plug_in
> +      - const: plug_out
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Input port from display controller output.
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Output port to DP/HDMI connector.
> +
> +    required:
> +      - port@0
> +      - port@1

You mark these ports as required, but apparently the drivers do not use the=
m,=20
AFAICT. E.g. missing port@1 is not resulting in an error, at lease for HDMI=
=20
one.

Best regards,
Alexander

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +  - interrupt-names
> +  - phys
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8mq-clock.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    mhdp_dp: dp-bridge@32c00000 {
> +        compatible =3D "fsl,imx8mq-mhdp8501-dp";
> +        reg =3D <0x32c00000 0x100000>;
> +        interrupts =3D <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names =3D "plug_in", "plug_out";
> +        clocks =3D <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
> +        phys =3D <&dp_phy>;
> +
> +        ports {
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            port@0 {
> +                reg =3D <0>;
> +
> +                mhdp_in: endpoint {
> +                    remote-endpoint =3D <&dcss_out>;
> +                };
> +            };
> +
> +            port@1 {
> +                reg =3D <1>;
> +
> +                mhdp_out: endpoint {
> +                    remote-endpoint =3D <&dp_con>;
> +                };
> +            };
> +        };
> +    };


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


