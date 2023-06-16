Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D8B732BEB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344245AbjFPJfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344984AbjFPJfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:35:23 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E1230F1;
        Fri, 16 Jun 2023 02:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1686908097; x=1718444097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7fUinrxNf0MsjqefM35xcVOtugPMdveh6egjO57sMYk=;
  b=RHbnqvApZgTPqnk6IU8csYaP4+PJ1P/nh9dpFGIvZHikSzqJDfU0zV21
   NMdfafwnx6kfzjrUN57xATbOdqFJvmOmnB0OYsj6fL8RNSXPFCL85ARqJ
   uLuoMTxkSEUw6ZOPqIZsqVQUvzoprGLBwLahNVUjdRqrlqzcGH5oS0kCS
   tvS5ROPJRLzBfWZCKm/fpXh/A/nGST6XfVketOHD/XIAv0iQxO16+3V0x
   h/rbOdarMNovRXD+xWn7HCQspcc//mwfCS4bPL1mwpSk5aThBL4Ifv6YM
   6ApMDln/gEF9a770BHb2usJ/sMJbcRKI+OrpKBJ0EsOhaGCffwII0cMvI
   A==;
X-IronPort-AV: E=Sophos;i="6.00,247,1681164000"; 
   d="scan'208";a="31462666"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 16 Jun 2023 11:34:35 +0200
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id A19C0280082;
        Fri, 16 Jun 2023 11:34:35 +0200 (CEST)
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
Subject: Re: [PATCH v6 6/8] dt-bindings: phy: Add Freescale iMX8MQ DP and HDMI PHY
Date:   Fri, 16 Jun 2023 11:34:37 +0200
Message-ID: <5009063.iIbC2pHGDl@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <2ccb849de420ced29b3f9be38e12664e1919b631.1686729444.git.Sandor.yu@nxp.com>
References: <cover.1686729444.git.Sandor.yu@nxp.com> <2ccb849de420ced29b3f9be38e12664e1919b631.1686729444.git.Sandor.yu@nxp.com>
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

Am Donnerstag, 15. Juni 2023, 03:38:16 CEST schrieb Sandor Yu:
> Add bindings for Freescale iMX8MQ DP and HDMI PHY.
>=20
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> ---
>  .../bindings/phy/fsl,imx8mq-dp-hdmi-phy.yaml  | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/phy/fsl,imx8mq-dp-hdmi-phy.yaml
>=20
> diff --git
> a/Documentation/devicetree/bindings/phy/fsl,imx8mq-dp-hdmi-phy.yaml
> b/Documentation/devicetree/bindings/phy/fsl,imx8mq-dp-hdmi-phy.yaml new
> file mode 100644
> index 000000000000..917f113503dc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/fsl,imx8mq-dp-hdmi-phy.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/fsl,imx8mq-dp-hdmi-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence HDP-TX DP/HDMI PHY for Freescale i.MX8MQ SoC
> +
> +maintainers:
> +  - Sandor Yu <sandor.yu@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx8mq-dp-phy
> +      - fsl,imx8mq-hdmi-phy

How is it intended to select DP or HDMI? E.g. provide a single default dp-p=
hy=20
node in imx8mq.dtsi and change the compatible to HDMI on board-level?

Best regards,
Alexander

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: PHY reference clock.
> +      - description: APB clock.
> +
> +  clock-names:
> +    items:
> +      - const: ref
> +      - const: apb
> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx8mq-clock.h>
> +    #include <dt-bindings/phy/phy.h>
> +    dp_phy: phy@32c00000 {
> +        compatible =3D "fsl,imx8mq-dp-phy";
> +        reg =3D <0x32c00000 0x100000>;
> +        #phy-cells =3D <0>;
> +        clocks =3D <&hdmi_phy_27m>, <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
> +        clock-names =3D "ref", "apb";
> +    };


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


