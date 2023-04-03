Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754246D41A8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjDCKQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjDCKQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:16:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D0765BC;
        Mon,  3 Apr 2023 03:16:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FB526179B;
        Mon,  3 Apr 2023 10:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DF2C433AA;
        Mon,  3 Apr 2023 10:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680516967;
        bh=5HFO1/RS3+GfhEvCCUbP0dlLKdHoh/rzuLr+Hm1DWRc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tMVrA1iW3mfBUp6m3x9ahp3O1uvEXmZ9qoCzeBdhKRrSuSckrkcHK7B/1I1PkoGVD
         +E3Sws/4kGXbZ538hkiZNnOotQCG+6anbV9ddH9+t/M6NxcpqqaI4d223UEi0SbMlh
         AWTRy4fd6QbC3U57sc7+Z6GNt55f6+x0N9lm+rqiEAyyOLXW5YF2XeHdXdfDppoYwi
         RV2+6qyixo0Kda0KRZhWzoTc08QMwCetagk3Uc549pMPEBlzr62nyO3LpnFVvOmFD7
         y3eFCiFPP+hyo8pSgorw8RLLaSX5wWH+W7HkIyGqat9JQTpzSj8iVRw59ih/IyO4Q0
         7i29cV5h5HBCA==
Received: by mail-lf1-f45.google.com with SMTP id q16so37331653lfe.10;
        Mon, 03 Apr 2023 03:16:07 -0700 (PDT)
X-Gm-Message-State: AAQBX9eMohcz1ONMzRQIOu9IfboZ3YNMfsTjw6MSPag+/Q7ylKI9ksiL
        H1qY/blQDUv3Q9mxitdRHm8YEl0g9Zbqz2Rh6w==
X-Google-Smtp-Source: AKy350a6AWS0wXlKuF5pe+AmTsaAEGr6dp/NJrmnFPufQQTE7JlMBuNWDF4zk2dhoeM1A4qjskgjTlKotAgPQvIU9cg=
X-Received: by 2002:ac2:43ce:0:b0:4eb:2643:d5cf with SMTP id
 u14-20020ac243ce000000b004eb2643d5cfmr4522340lfl.7.1680516965357; Mon, 03 Apr
 2023 03:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230403071929.360911-1-jstephan@baylibre.com> <20230403071929.360911-3-jstephan@baylibre.com>
In-Reply-To: <20230403071929.360911-3-jstephan@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 3 Apr 2023 18:15:53 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8h0gROVKOVNrTpJGKgZhJbQ1A6EaZT+vpb5bJaYqYaFg@mail.gmail.com>
Message-ID: <CAAOTY_8h0gROVKOVNrTpJGKgZhJbQ1A6EaZT+vpb5bJaYqYaFg@mail.gmail.com>
Subject: Re: [PATCH 2/2] phy: mtk-mipi-csi: add driver for CSI phy
To:     Julien Stephan <jstephan@baylibre.com>
Cc:     Phi-bang Nguyen <pnguyen@baylibre.com>,
        Louis Kuo <louis.kuo@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "moderated list:ARM/Mediatek USB3 PHY DRIVER" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek USB3 PHY DRIVER" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS FOR MEDIATEK" 
        <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,UPPERCASE_50_75 autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Julien:

Julien Stephan <jstephan@baylibre.com> =E6=96=BC 2023=E5=B9=B44=E6=9C=883=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:20=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> From: Phi-bang Nguyen <pnguyen@baylibre.com>
>
> This is a new driver that supports the MIPI CSI CD-PHY for mediatek
> mt8365 soc
>
> Signed-off-by: Louis Kuo <louis.kuo@mediatek.com>
> Signed-off-by: Phi-bang Nguyen <pnguyen@baylibre.com>
> [Julien Stephan: use regmap]
> [Julien Stephan: use GENMASK]
> Co-developed-by: Julien Stephan <jstephan@baylibre.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  .../bindings/phy/mediatek,csi-phy.yaml        |   9 +-
>  MAINTAINERS                                   |   1 +
>  drivers/phy/mediatek/Kconfig                  |   8 +
>  drivers/phy/mediatek/Makefile                 |   2 +
>  .../phy/mediatek/phy-mtk-mipi-csi-rx-reg.h    | 435 ++++++++++++++++++
>  drivers/phy/mediatek/phy-mtk-mipi-csi.c       | 392 ++++++++++++++++
>  6 files changed, 845 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/phy/mediatek/phy-mtk-mipi-csi-rx-reg.h
>  create mode 100644 drivers/phy/mediatek/phy-mtk-mipi-csi.c
>

[snip]

> +static int mtk_mipi_phy_power_on(struct phy *phy)
> +{
> +       struct mtk_mipi_dphy_port *port =3D phy_get_drvdata(phy);
> +       struct mtk_mipi_dphy *priv =3D port->dev;
> +       struct regmap *regmap_base =3D port->regmap_base;
> +       struct regmap *regmap_4d1c =3D port->regmap_4d1c;
> +       int ret =3D 0;
> +
> +       mutex_lock(&priv->lock);
> +
> +       switch (port->id) {
> +       case MTK_MIPI_PHY_PORT_0:
> +               if (priv->ports[MTK_MIPI_PHY_PORT_0A].active ||
> +                   priv->ports[MTK_MIPI_PHY_PORT_0B].active)
> +                       ret =3D -EBUSY;
> +               break;
> +
> +       case MTK_MIPI_PHY_PORT_0A:
> +       case MTK_MIPI_PHY_PORT_0B:
> +               if (priv->ports[MTK_MIPI_PHY_PORT_0].active)
> +                       ret =3D -EBUSY;
> +               break;
> +       }
> +
> +       if (!ret)
> +               port->active =3D true;
> +
> +       mutex_unlock(&priv->lock);
> +
> +       if (ret < 0)
> +               return ret;
> +
> +       /* Set analog phy mode to DPHY */
> +       if (port->is_cdphy)
> +               REGMAP_BIT(regmap_base, MIPI_RX_ANA00_CSIxA,
> +                          RG_CSI0A_CPHY_EN, 0);
> +
> +       if (port->is_4d1c) {
> +               REGMAP_BIT(regmap_base, MIPI_RX_ANA00_CSIxA,
> +                          RG_CSIxA_DPHY_L0_CKMODE_EN, 0);
> +               REGMAP_BIT(regmap_base, MIPI_RX_ANA00_CSIxA,
> +                          RG_CSIxA_DPHY_L0_CKSEL, 1);
> +               REGMAP_BIT(regmap_base, MIPI_RX_ANA00_CSIxA,
> +                          RG_CSIxA_DPHY_L1_CKMODE_EN, 0);
> +               REGMAP_BIT(regmap_base, MIPI_RX_ANA00_CSIxA,
> +                          RG_CSIxA_DPHY_L1_CKSEL, 1);
> +               REGMAP_BIT(regmap_base, MIPI_RX_ANA00_CSIxA,
> +                          RG_CSIxA_DPHY_L2_CKMODE_EN, 1);
> +               REGMAP_BIT(regmap_base, MIPI_RX_ANA00_CSIxA,
> +                          RG_CSIxA_DPHY_L2_CKSEL, 1);
> +       } else {
> +               REGMAP_BIT(regmap_base, MIPI_RX_ANA00_CSIxA,
> +                          RG_CSIxA_DPHY_L0_CKMODE_EN, 0);
> +               REGMAP_BIT(regmap_base, MIPI_RX_ANA00_CSIxA,
> +                          RG_CSIxA_DPHY_L0_CKSEL, 0);
> +               REGMAP_BIT(regmap_base, MIPI_RX_ANA00_CSIxA,
> +                          RG_CSIxA_DPHY_L1_CKMODE_EN, 1);
> +               REGMAP_BIT(regmap_base, MIPI_RX_ANA00_CSIxA,
> +                          RG_CSIxA_DPHY_L1_CKSEL, 0);
> +               REGMAP_BIT(regmap_base, MIPI_RX_ANA00_CSIxA,
> +                          RG_CSIxA_DPHY_L2_CKMODE_EN, 0);
> +               REGMAP_BIT(regmap_base, MIPI_RX_ANA00_CSIxA,
> +                          RG_CSIxA_DPHY_L2_CKSEL, 0);
> +       }
> +
> +       if (port->is_4d1c) {
> +               if (port->is_cdphy)
> +                       REGMAP_BIT(regmap_4d1c, MIPI_RX_ANA00_CSIxA,
> +                                  RG_CSI0A_CPHY_EN, 0);
> +
> +               REGMAP_BIT(regmap_4d1c, MIPI_RX_ANA00_CSIxA,
> +                          RG_CSIxA_DPHY_L0_CKMODE_EN, 0);
> +               REGMAP_BIT(regmap_4d1c, MIPI_RX_ANA00_CSIxA,
> +                          RG_CSIxA_DPHY_L0_CKSEL, 1);
> +               REGMAP_BIT(regmap_4d1c, MIPI_RX_ANA00_CSIxA,
> +                          RG_CSIxA_DPHY_L1_CKMODE_EN, 0);
> +               REGMAP_BIT(regmap_4d1c, MIPI_RX_ANA00_CSIxA,
> +                          RG_CSIxA_DPHY_L1_CKSEL, 1);
> +               REGMAP_BIT(regmap_4d1c, MIPI_RX_ANA00_CSIxA,
> +                          RG_CSIxA_DPHY_L2_CKMODE_EN, 0);
> +               REGMAP_BIT(regmap_4d1c, MIPI_RX_ANA00_CSIxA,
> +                          RG_CSIxA_DPHY_L2_CKSEL, 1);
> +       }
> +
> +       /* Byte clock invert */
> +       REGMAP_BIT(regmap_base, MIPI_RX_ANAA8_CSIxA,
> +                  RG_CSIxA_CDPHY_L0_T0_BYTECK_INVERT, 1);
> +       REGMAP_BIT(regmap_base, MIPI_RX_ANAA8_CSIxA,
> +                  RG_CSIxA_DPHY_L1_BYTECK_INVERT, 1);
> +       REGMAP_BIT(regmap_base, MIPI_RX_ANAA8_CSIxA,
> +                  RG_CSIxA_CDPHY_L2_T1_BYTECK_INVERT, 1);
> +
> +       if (port->is_4d1c) {
> +               REGMAP_BIT(regmap_4d1c, MIPI_RX_ANAA8_CSIxA,
> +                          RG_CSIxA_CDPHY_L0_T0_BYTECK_INVERT, 1);
> +               REGMAP_BIT(regmap_4d1c, MIPI_RX_ANAA8_CSIxA,
> +                          RG_CSIxA_DPHY_L1_BYTECK_INVERT, 1);
> +               REGMAP_BIT(regmap_4d1c, MIPI_RX_ANAA8_CSIxA,
> +                          RG_CSIxA_CDPHY_L2_T1_BYTECK_INVERT, 1);
> +       }
> +
> +       /* Start ANA EQ tuning */
> +       if (port->is_cdphy) {
> +               REGMAP_BIT(regmap_base, MIPI_RX_ANA18_CSIxA,
> +                          RG_CSI0A_L0_T0AB_EQ_IS, 1);
> +               REGMAP_BIT(regmap_base, MIPI_RX_ANA18_CSIxA,
> +                          RG_CSI0A_L0_T0AB_EQ_BW, 1);
> +               REGMAP_BIT(regmap_base, MIPI_RX_ANA1C_CSIxA,
> +                          RG_CSI0A_L1_T1AB_EQ_IS, 1);
> +               REGMAP_BIT(regmap_base, MIPI_RX_ANA1C_CSIxA,
> +                          RG_CSI0A_L1_T1AB_EQ_BW, 1);
> +               REGMAP_BIT(regmap_base, MIPI_RX_ANA20_CSI0A,
> +                          RG_CSI0A_L2_T1BC_EQ_IS, 1);
> +               REGMAP_BIT(regmap_base, MIPI_RX_ANA20_CSI0A,
> +                          RG_CSI0A_L2_T1BC_EQ_BW, 1);
> +
> +               if (port->is_4d1c) {
> +                       REGMAP_BIT(regmap_4d1c, MIPI_RX_ANA18_CSIxA,
> +                                  RG_CSI0A_L0_T0AB_EQ_IS, 1);
> +                       REGMAP_BIT(regmap_4d1c, MIPI_RX_ANA18_CSIxA,
> +                                  RG_CSI0A_L0_T0AB_EQ_BW, 1);
> +                       REGMAP_BIT(regmap_4d1c, MIPI_RX_ANA1C_CSIxA,
> +                                  RG_CSI0A_L1_T1AB_EQ_IS, 1);
> +                       REGMAP_BIT(regmap_4d1c, MIPI_RX_ANA1C_CSIxA,
> +                                  RG_CSI0A_L1_T1AB_EQ_BW, 1);
> +                       REGMAP_BIT(regmap_4d1c, MIPI_RX_ANA20_CSI0A,
> +                                  RG_CSI0A_L2_T1BC_EQ_IS, 1);
> +                       REGMAP_BIT(regmap_4d1c, MIPI_RX_ANA20_CSI0A,
> +                                  RG_CSI0A_L2_T1BC_EQ_BW, 1);
> +               }
> +       } else {
> +               REGMAP_BIT(regmap_base, MIPI_RX_ANA18_CSIxA,
> +                          RG_CSI1A_L0_EQ_IS, 1);
> +               REGMAP_BIT(regmap_base, MIPI_RX_ANA18_CSIxA,
> +                          RG_CSI1A_L0_EQ_BW, 1);
> +               REGMAP_BIT(regmap_base, MIPI_RX_ANA18_CSIxA,
> +                          RG_CSI1A_L1_EQ_IS, 1);
> +               REGMAP_BIT(regmap_base, MIPI_RX_ANA18_CSIxA,
> +                          RG_CSI1A_L1_EQ_BW, 1);
> +               REGMAP_BIT(regmap_base, MIPI_RX_ANA1C_CSIxA,
> +                          RG_CSI1A_L2_EQ_IS, 1);
> +               REGMAP_BIT(regmap_base, MIPI_RX_ANA1C_CSIxA,
> +                          RG_CSI1A_L2_EQ_BW, 1);
> +
> +               if (port->is_4d1c) {
> +                       REGMAP_BIT(regmap_4d1c, MIPI_RX_ANA18_CSIxA,
> +                                  RG_CSI1A_L0_EQ_IS, 1);

RG_CSI1A_L0_EQ_IS is identical to RG_CSI0A_L0_T0AB_EQ_IS, and ditto
for below register. I think the function of each bitwise register is
the same. Define only one copy of the these register, don't duplicate
the same thing.

Regards,
Chun-Kuang.

> +                       REGMAP_BIT(regmap_4d1c, MIPI_RX_ANA18_CSIxA,
> +                                  RG_CSI1A_L0_EQ_BW, 1);
> +                       REGMAP_BIT(regmap_4d1c, MIPI_RX_ANA18_CSIxA,
> +                                  RG_CSI1A_L1_EQ_IS, 1);
> +                       REGMAP_BIT(regmap_4d1c, MIPI_RX_ANA18_CSIxA,
> +                                  RG_CSI1A_L1_EQ_BW, 1);
> +                       REGMAP_BIT(regmap_4d1c, MIPI_RX_ANA1C_CSIxA,
> +                                  RG_CSI1A_L2_EQ_IS, 1);
> +                       REGMAP_BIT(regmap_4d1c, MIPI_RX_ANA1C_CSIxA,
> +                                  RG_CSI1A_L2_EQ_BW, 1);
> +               }
> +       }
> +
> +       /* End ANA EQ tuning */
> +       regmap_write(regmap_base, MIPI_RX_ANA40_CSIxA, 0x90);
> +
> +       REGMAP_BIT(regmap_base, MIPI_RX_ANA24_CSIxA,
> +                  RG_CSIxA_RESERVE, 0x40);
> +       if (port->is_4d1c)
> +               REGMAP_BIT(regmap_4d1c, MIPI_RX_ANA24_CSIxA,
> +                          RG_CSIxA_RESERVE, 0x40);
> +       REGMAP_BIT(regmap_base, MIPI_RX_WRAPPER80_CSIxA,
> +                  CSR_CSI_RST_MODE, 0);
> +       if (port->is_4d1c)
> +               REGMAP_BIT(regmap_4d1c, MIPI_RX_WRAPPER80_CSIxA,
> +                          CSR_CSI_RST_MODE, 0);
> +       /* ANA power on */
> +       REGMAP_BIT(regmap_base, MIPI_RX_ANA00_CSIxA,
> +                  RG_CSIxA_BG_CORE_EN, 1);
> +       if (port->is_4d1c)
> +               REGMAP_BIT(regmap_4d1c, MIPI_RX_ANA00_CSIxA,
> +                          RG_CSIxA_BG_CORE_EN, 1);
> +       usleep_range(20, 40);
> +       REGMAP_BIT(regmap_base, MIPI_RX_ANA00_CSIxA,
> +                  RG_CSIxA_BG_LPF_EN, 1);
> +       if (port->is_4d1c)
> +               REGMAP_BIT(regmap_4d1c, MIPI_RX_ANA00_CSIxA,
> +                          RG_CSIxA_BG_LPF_EN, 1);
> +
> +       return 0;
> +}
> +
