Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D11606FDF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiJUGMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 02:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiJUGMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:12:03 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A60523642B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:11:54 -0700 (PDT)
X-UUID: ba820dcd34e243d89b0c47cc0cbeb014-20221021
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=BPOYEyF5tz9xReA2PR5B2itvq55j7FP2nA3ronwbhHU=;
        b=ICVOVmUXdlxsahqKc6kbftTferGzmv+KxCnKJ1oITIH/4JF69zqMpOpBnu0h1dHe4jLuO58q20d/4k7PAknts13kREmTRJSMWD6DW1AyKBkuOVpwGrTXcchQxwwo7+cfuBk5yXPnCb8o4NhoPBsIyp84w1R52ByvYdWsHqnIJe4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:77e1ed18-ebb5-4ccb-ba99-ab7ce469fbc0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:51
X-CID-INFO: VERSION:1.1.12,REQID:77e1ed18-ebb5-4ccb-ba99-ab7ce469fbc0,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:51
X-CID-META: VersionHash:62cd327,CLOUDID:67833ec8-03ab-4171-989e-341ab5339257,B
        ulkID:221021102500QR7OMYRT,BulkQuantity:5,Recheck:0,SF:38|28|17|19|48|102,
        TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,CO
        L:0
X-UUID: ba820dcd34e243d89b0c47cc0cbeb014-20221021
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 696864503; Fri, 21 Oct 2022 14:11:44 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 21 Oct 2022 14:11:43 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 21 Oct 2022 14:11:43 +0800
Message-ID: <2d9700c64d729ae802a29e0a4282e6206dd0ef33.camel@mediatek.com>
Subject: Re: [PATCH 1/2] phy: phy-mtk-tphy: Add PCIe 2 lane efuse support
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Daniel Golle <daniel@makrotopia.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, "Vinod Koul" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Fri, 21 Oct 2022 14:11:43 +0800
In-Reply-To: <df51b63add2830d91b527db64fba6ffdb7765f5d.1666193782.git.daniel@makrotopia.org>
References: <df51b63add2830d91b527db64fba6ffdb7765f5d.1666193782.git.daniel@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,RDNS_NONE,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-10-19 at 16:37 +0100, Daniel Golle wrote:
> From: Zhanyong Wang <zhanyong.wang@mediatek.com>
> 
> Add PCIe 2 lane efuse support in tphy driver.
> 
> Signed-off-by: Jie Yang <jieyy.yang@mediatek.com>
> Signed-off-by: Zhanyong Wang <zhanyong.wang@mediatek.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/phy/mediatek/phy-mtk-tphy.c | 112
> ++++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
> 
> diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c
> b/drivers/phy/mediatek/phy-mtk-tphy.c
> index e906a82791bdaa..b0c9834efec7ef 100644
> --- a/drivers/phy/mediatek/phy-mtk-tphy.c
> +++ b/drivers/phy/mediatek/phy-mtk-tphy.c
> @@ -43,6 +43,15 @@
>  #define SSUSB_SIFSLV_V2_U3PHYD		0x200
>  #define SSUSB_SIFSLV_V2_U3PHYA		0x400
>  
> +/* version V4 sub-banks offset base address */
> +/* pcie phy banks */
> +#define SSUSB_SIFSLV_V4_SPLLC		0x000
> +#define SSUSB_SIFSLV_V4_CHIP		0x100
> +#define SSUSB_SIFSLV_V4_U3PHYD		0x900
> +#define SSUSB_SIFSLV_V4_U3PHYA		0xb00
> +
> +#define SSUSB_LN1_OFFSET		0x10000
> +
>  #define U3P_MISC_REG1		0x04
>  #define MR1_EFUSE_AUTO_LOAD_DIS		BIT(6)
>  
> @@ -268,6 +277,7 @@ enum mtk_phy_version {
>  	MTK_PHY_V1 = 1,
>  	MTK_PHY_V2,
>  	MTK_PHY_V3,
> +	MTK_PHY_V4,
>  };
>  
>  struct mtk_phy_pdata {
> @@ -317,6 +327,9 @@ struct mtk_phy_instance {
>  	u32 efuse_intr;
>  	u32 efuse_tx_imp;
>  	u32 efuse_rx_imp;
> +	u32 efuse_intr_ln1;
> +	u32 efuse_tx_imp_ln1;
> +	u32 efuse_rx_imp_ln1;
>  	int eye_src;
>  	int eye_vrt;
>  	int eye_term;
> @@ -760,6 +773,36 @@ static void phy_v2_banks_init(struct mtk_tphy
> *tphy,
>  	}
>  }
>  
> +static void phy_v4_banks_init(struct mtk_tphy *tphy,
> +			      struct mtk_phy_instance *instance)
> +{
> +	struct u2phy_banks *u2_banks = &instance->u2_banks;
> +	struct u3phy_banks *u3_banks = &instance->u3_banks;
> +
> +	switch (instance->type) {
> +	case PHY_TYPE_USB2:
> +		u2_banks->misc = instance->port_base +
> SSUSB_SIFSLV_V2_MISC;
> +		u2_banks->fmreg = instance->port_base +
> SSUSB_SIFSLV_V2_U2FREQ;
> +		u2_banks->com = instance->port_base +
> SSUSB_SIFSLV_V2_U2PHY_COM;
> +		break;
> +	case PHY_TYPE_USB3:
> +		u3_banks->spllc = instance->port_base +
> SSUSB_SIFSLV_V2_SPLLC;
> +		u3_banks->chip = instance->port_base +
> SSUSB_SIFSLV_V2_CHIP;
> +		u3_banks->phyd = instance->port_base +
> SSUSB_SIFSLV_V2_U3PHYD;
> +		u3_banks->phya = instance->port_base +
> SSUSB_SIFSLV_V2_U3PHYA;
> +		break;
> +	case PHY_TYPE_PCIE:
> +		u3_banks->spllc = instance->port_base +
> SSUSB_SIFSLV_V4_SPLLC;
> +		u3_banks->chip = instance->port_base +
> SSUSB_SIFSLV_V4_CHIP;
> +		u3_banks->phyd = instance->port_base +
> SSUSB_SIFSLV_V4_U3PHYD;
> +		u3_banks->phya = instance->port_base +
> SSUSB_SIFSLV_V4_U3PHYA;
> +		break;
> +	default:
> +		dev_err(tphy->dev, "incompatible PHY type\n");
> +		return;
> +	}
> +}
> +
>  static void phy_parse_property(struct mtk_tphy *tphy,
>  				struct mtk_phy_instance *instance)
>  {
> @@ -951,6 +994,40 @@ static int phy_efuse_get(struct mtk_tphy *tphy,
> struct mtk_phy_instance *instanc
>  
>  		dev_dbg(dev, "u3 efuse - intr %x, rx_imp %x, tx_imp
> %x\n",
>  			instance->efuse_intr, instance-
> >efuse_rx_imp,instance->efuse_tx_imp);
> +
> +		if (tphy->pdata->version != MTK_PHY_V4)
> +			break;
> +
> +		ret = nvmem_cell_read_variable_le_u32(dev, "intr_ln1",
> &instance->efuse_intr_ln1);
> +		if (ret) {
> +			dev_err(dev, "fail to get u3 lane1 intr efuse,
> %d\n", ret);
> +			break;
> +		}
> +
> +		ret = nvmem_cell_read_variable_le_u32(dev,
> "rx_imp_ln1", &instance->efuse_rx_imp_ln1);
> +		if (ret) {
> +			dev_err(dev, "fail to get u3 lane1 rx_imp
> efuse, %d\n", ret);
> +			break;
> +		}
> +
> +		ret = nvmem_cell_read_variable_le_u32(dev,
> "tx_imp_ln1", &instance->efuse_tx_imp_ln1);
> +		if (ret) {
> +			dev_err(dev, "fail to get u3 lane1 tx_imp
> efuse, %d\n", ret);
> +			break;
> +		}
> +
> +		/* no efuse, ignore it */
> +		if (!instance->efuse_intr_ln1 &&
> +		    !instance->efuse_rx_imp_ln1 &&
> +		    !instance->efuse_tx_imp_ln1) {
> +			dev_warn(dev, "no u3 lane1 efuse, but dts
> enable it\n");
> +			instance->efuse_sw_en = 0;
> +			break;
> +		}
> +
> +		dev_info(dev, "u3 lane1 efuse - intr %x, rx_imp %x,
> tx_imp %x\n",
> +			 instance->efuse_intr_ln1, instance-
> >efuse_rx_imp_ln1,
> +			 instance->efuse_tx_imp_ln1);
>  		break;
>  	default:
>  		dev_err(dev, "no sw efuse for type %d\n", instance-
> >type);
> @@ -990,6 +1067,31 @@ static void phy_efuse_set(struct
> mtk_phy_instance *instance)
>  
>  		mtk_phy_update_field(u3_banks->phya + U3P_U3_PHYA_REG0,
> P3A_RG_IEXT_INTR,
>  				    instance->efuse_intr);
> +		if (instance->type == PHY_TYPE_USB3 || (
> +		    !instance->efuse_intr_ln1 &&
> +		    !instance->efuse_rx_imp_ln1 &&
> +		    !instance->efuse_tx_imp_ln1))
> +			break;
> +
> +		mtk_phy_set_bits(u3_banks->phyd + SSUSB_LN1_OFFSET +
> U3P_U3_PHYD_RSV,
> +				 P3D_RG_EFUSE_AUTO_LOAD_DIS);
> +
> +		mtk_phy_update_field(u3_banks->phyd + SSUSB_LN1_OFFSET
> + U3P_U3_PHYD_IMPCAL0,
> +				     P3D_RG_TX_IMPEL, instance-
> >efuse_tx_imp_ln1);
> +		mtk_phy_set_bits(u3_banks->phyd + SSUSB_LN1_OFFSET +
> U3P_U3_PHYD_IMPCAL0,
> +				 P3D_RG_FORCE_TX_IMPEL);
> +
> +		mtk_phy_update_field(u3_banks->phyd + SSUSB_LN1_OFFSET
> + U3P_U3_PHYD_IMPCAL1,
> +				     P3D_RG_RX_IMPEL, instance-
> >efuse_rx_imp_ln1);
> +		mtk_phy_set_bits(u3_banks->phyd + SSUSB_LN1_OFFSET +
> U3P_U3_PHYD_IMPCAL1,
> +				 P3D_RG_FORCE_RX_IMPEL);
> +
> +		mtk_phy_update_field(u3_banks->phya + SSUSB_LN1_OFFSET
> + U3P_U3_PHYA_REG0,
> +				     P3A_RG_IEXT_INTR, instance-
> >efuse_intr_ln1);
> +
> +		dev_info(dev, "%s set LN1 efuse, tx_imp %x, rx_imp %x
> intr %x\n",
> +			 __func__, instance->efuse_tx_imp_ln1,
> +			 instance->efuse_rx_imp_ln1, instance-
> >efuse_intr_ln1);
>  		break;
>  	default:
>  		dev_warn(dev, "no sw efuse for type %d\n", instance-
> >type);
> @@ -1129,6 +1231,9 @@ static struct phy *mtk_phy_xlate(struct device
> *dev,
>  	case MTK_PHY_V3:
>  		phy_v2_banks_init(tphy, instance);
>  		break;
> +	case MTK_PHY_V4:
> +		phy_v4_banks_init(tphy, instance);
> +		break;
>  	default:
>  		dev_err(dev, "phy version is not supported\n");
>  		return ERR_PTR(-EINVAL);
> @@ -1169,6 +1274,12 @@ static const struct mtk_phy_pdata
> tphy_v3_pdata = {
>  	.version = MTK_PHY_V3,
>  };
>  
> +static const struct mtk_phy_pdata tphy_v4_pdata = {
> +	.avoid_rx_sen_degradation = false,
> +	.sw_efuse_supported = true,
> +	.version = MTK_PHY_V4,
> +};

Please try to use hardware efuse autoload way for this case first,
there is no hardware issue, so I don't think we need use software way.

As Sam said, the hardware ip used on 7981/7986 is MTK_PHY_V2;

Thanks a lot

> +
>  static const struct mtk_phy_pdata mt8173_pdata = {
>  	.avoid_rx_sen_degradation = true,
>  	.version = MTK_PHY_V1,
> @@ -1188,6 +1299,7 @@ static const struct of_device_id
> mtk_tphy_id_table[] = {
>  	{ .compatible = "mediatek,generic-tphy-v1", .data =
> &tphy_v1_pdata },
>  	{ .compatible = "mediatek,generic-tphy-v2", .data =
> &tphy_v2_pdata },
>  	{ .compatible = "mediatek,generic-tphy-v3", .data =
> &tphy_v3_pdata },
> +	{ .compatible = "mediatek,generic-tphy-v4", .data =
> &tphy_v4_pdata },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, mtk_tphy_id_table);

