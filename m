Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5475F6556
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 13:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJFLnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 07:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiJFLnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 07:43:37 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1A4895CE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 04:43:36 -0700 (PDT)
X-UUID: 3fc9263b452e41aeba0ee3f90f6ae159-20221006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Jn/iVXXN2eOqpbmPNz9Am7fIqyo1qxnZ2gCBdAEKE8Y=;
        b=MXOFP3X3ny3X3vjtJivhYpp3t+OqiStAIaSP7JL6upd7dgfRwoWSSOUBwPntZs3wF/k8XSDTaPE5TX8vxhWuC/eHXzv2ryvYlxDrjDOLOuuNN8A0NxdeOQ5/Tw0wwNme/zVm72Jgyf7RVh5DyRG++ddpLW6fR8hO6cJ4z0PGiUk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:40dcdb54-316b-4abc-862f-06534d1e75be,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:bbbb1be1-2948-402a-a6e4-b5d31fe11eb7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 3fc9263b452e41aeba0ee3f90f6ae159-20221006
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 295986733; Thu, 06 Oct 2022 19:43:31 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 6 Oct 2022 19:43:30 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 6 Oct 2022 19:43:30 +0800
Message-ID: <d8addc83702f41e1afb2ded341da0fd797539ffc.camel@mediatek.com>
Subject: Re: [PATCH 8/8] soc: mtk-svs: mt8192: fix bank data
From:   Roger Lu <roger.lu@mediatek.com>
To:     <matthias.bgg@kernel.org>, <jia-wei.chang@mediatek.com>
CC:     <nfraprado@collabora.com>, <khilman@baylibre.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Date:   Thu, 6 Oct 2022 19:43:30 +0800
In-Reply-To: <20220928155519.31977-9-matthias.bgg@kernel.org>
References: <20220928155519.31977-1-matthias.bgg@kernel.org>
         <20220928155519.31977-9-matthias.bgg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias Sir,

This addition is for indicating vmax value is increased by dvt_fixed.
Please keep this information to make it be seen. Many thanks.

Sincerely,
Roger Lu.

On Wed, 2022-09-28 at 17:55 +0200, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> Values vmax and dvt_fixed are not changed at runtime, set them as needed
> in the svs_banks struct.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> 
> ---
> 
>  drivers/soc/mediatek/mt8192-svs.h     | 4 ++--
>  drivers/soc/mediatek/mtk-svs-mt8192.c | 2 --
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mt8192-svs.h b/drivers/soc/mediatek/mt8192-
> svs.h
> index 6571ebcb2c0f..bf8c6030428f 100644
> --- a/drivers/soc/mediatek/mt8192-svs.h
> +++ b/drivers/soc/mediatek/mt8192-svs.h
> @@ -16,7 +16,7 @@ static struct svs_bank svs_mt8192_banks[] = {
>  		.turn_freq_base		= 688000000,
>  		.volt_step		= 6250,
>  		.volt_base		= 400000,
> -		.vmax			= 0x60,
> +		.vmax			= 0x61,
>  		.vmin			= 0x1a,
>  		.age_config		= 0x555555,
>  		.dc_config		= 0x1,
> @@ -41,7 +41,7 @@ static struct svs_bank svs_mt8192_banks[] = {
>  		.turn_freq_base		= 688000000,
>  		.volt_step		= 6250,
>  		.volt_base		= 400000,
> -		.vmax			= 0x60,
> +		.vmax			= 0x66,
>  		.vmin			= 0x1a,
>  		.age_config		= 0x555555,
>  		.dc_config		= 0x1,
> diff --git a/drivers/soc/mediatek/mtk-svs-mt8192.c b/drivers/soc/mediatek/mtk-
> svs-mt8192.c
> index 838a94834741..183acf2829f0 100644
> --- a/drivers/soc/mediatek/mtk-svs-mt8192.c
> +++ b/drivers/soc/mediatek/mtk-svs-mt8192.c
> @@ -40,8 +40,6 @@ bool svs_mt8192_efuse_parsing(struct svs_platform *svsp)
>  			svsb->dcbdet = (svsp->efuse[17] >> 16) & GENMASK(7, 0);
>  			svsb->dcmdet = (svsp->efuse[17] >> 24) & GENMASK(7, 0);
>  		}
> -
> -		svsb->vmax += svsb->dvt_fixed;
>  	}
>  
>  	ret = svs_thermal_efuse_get_data(svsp);

