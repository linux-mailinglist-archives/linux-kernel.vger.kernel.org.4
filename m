Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F6B5F6554
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 13:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiJFLnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 07:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiJFLnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 07:43:31 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02889D504
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 04:43:28 -0700 (PDT)
X-UUID: 4198f20003ab47ebb8a3cd5ff352561e-20221006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=i2dFv5u/USsOJ5+ExuxllA/r71M3NGC2+F4uNH0Sfu0=;
        b=UHb98RNkFzs7vJF0XW2YXG+rWY+n1g+WvRyB5dKPc5ac4pq44TIbLw0tRfsr7+JRye8jySyEcP+eEmdF4ENfuG0P4kY/u50YquWJGfRp/VgtfbIru6QbkOKy8Cmk1Wd+NITQgzxGTi95HUxPck9JGLbDPVLvvZubnkfcZEm+C3E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:9a02e96a-697f-41f4-bce0-39c31fad372b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.11,REQID:9a02e96a-697f-41f4-bce0-39c31fad372b,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:39a5ff1,CLOUDID:84d572fe-ee8c-4ff7-afe9-644435e96625,B
        ulkID:221006194323LGB9XC1V,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|823|
        824|102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:
        nil,COL:0
X-UUID: 4198f20003ab47ebb8a3cd5ff352561e-20221006
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 623317465; Thu, 06 Oct 2022 19:43:22 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 6 Oct 2022 19:43:21 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 6 Oct 2022 19:43:21 +0800
Message-ID: <cf0c39bdb5da55d850b3bf33bf76f5862becb098.camel@mediatek.com>
Subject: Re: [PATCH 5/8] soc: mediatek: mtk-svs: Move SoC specific functions
 to new files
From:   Roger Lu <roger.lu@mediatek.com>
To:     <matthias.bgg@kernel.org>, <jia-wei.chang@mediatek.com>
CC:     <nfraprado@collabora.com>, <khilman@baylibre.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Date:   Thu, 6 Oct 2022 19:43:21 +0800
In-Reply-To: <20220928155519.31977-6-matthias.bgg@kernel.org>
References: <20220928155519.31977-1-matthias.bgg@kernel.org>
         <20220928155519.31977-6-matthias.bgg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

> drivers/soc/mediatek/mtk-svs-mt8183.c | 234 ++++++++
> drivers/soc/mediatek/mtk-svs-mt8192.c | 100 ++++

We've encountered some build warnings as below. Could we put mtk-svs-mtxx.c
implementation into mt81xx-svs.h and remove mtk-svs-mtxx.c?

kernel/mediatek/drivers/soc/mediatek/mtk-svs-mt8183.c:103:6: warning: no
previous prototype for ‘svs_mt8183_efuse_parsing’ [-Wmissing-prototypes]
 bool svs_mt8183_efuse_parsing(struct svs_platform *svsp)
      ^~~~~~~~~~~~~~~~~~~~~~~~
/mfs/mtkslt1043/mtk11157/upstream/2022_1003_1704/kernel/mediatek/drivers/soc/med
iatek/mtk-svs-mt8183.c:198:5: warning: no previous prototype for
‘svs_mt8183_platform_probe’ [-Wmissing-prototypes]
 int svs_mt8183_platform_probe(struct svs_platform *svsp)
     ^~~~~~~~~~~~~~~~~~~~~~~~~

kernel/mediatek/drivers/soc/mediatek/mtk-svs-mt8192.c:5:6: warning: no previous
prototype for ‘svs_mt8192_efuse_parsing’ [-Wmissing-prototypes]
 bool svs_mt8192_efuse_parsing(struct svs_platform *svsp)
      ^~~~~~~~~~~~~~~~~~~~~~~~
/mfs/mtkslt1043/mtk11157/upstream/2022_1003_1704/kernel/mediatek/drivers/soc/med
iatek/mtk-svs-mt8192.c:67:5: warning: no previous prototype for
‘svs_mt8192_platform_probe’ [-Wmissing-prototypes]
 int svs_mt8192_platform_probe(struct svs_platform *svsp)

...[snip]...

> +#define debug_fops_ro(name)						\
> +	static int svs_##name##_debug_open(struct inode *inode,		\
> +					   struct file *filp)		\
> +	{								\
> +		return single_open(filp, svs_##name##_debug_show,	\
> +				   inode->i_private);			\
> +	}								\
> +	static const struct file_operations svs_##name##_debug_fops = {	\
> +		.owner = THIS_MODULE,					\
> +		.open = svs_##name##_debug_open,			\
> +		.read = seq_read,					\
> +		.llseek = seq_lseek,					\
> +		.release = single_release,				\
> +	}
> +
> +#define debug_fops_rw(name)						\
> +	static int svs_##name##_debug_open(struct inode *inode,		\
> +					   struct file *filp)		\
> +	{								\
> +		return single_open(filp, svs_##name##_debug_show,	\
> +				   inode->i_private);			\
> +	}								\
> +	static const struct file_operations svs_##name##_debug_fops = {	\
> +		.owner = THIS_MODULE,					\
> +		.open = svs_##name##_debug_open,			\
> +		.read = seq_read,					\
> +		.write = svs_##name##_debug_write,			\
> +		.llseek = seq_lseek,					\
> +		.release = single_release,				\
> +	}
> +
> +#define svs_dentry_data(name)	{__stringify(name),
> &svs_##name##_debug_fops}
> +

CHECK: Please don't use multiple blank lines
#208: FILE: drivers/soc/mediatek/mtk-svs.c:208:
+
+

...[snip]...

> -static struct device *svs_get_subsys_device(struct svs_platform *svsp,
> +struct device *svs_get_subsys_device(struct svs_platform *svsp,
>  					    const char *node_name)
>  {
>  	struct platform_device *pdev;
> @@ -2032,7 +1522,7 @@ static struct device *svs_get_subsys_device(struct
> svs_platform *svsp,
>  	return &pdev->dev;
>  }
>  
> -static struct device *svs_add_device_link(struct svs_platform *svsp,
> +struct device *svs_add_device_link(struct svs_platform *svsp,
>  					  const char *node_name)

CHECK: Alignment should match open parenthesis
#1502: FILE: drivers/soc/mediatek/mtk-svs.c:1502:
+struct device *svs_get_subsys_device(struct svs_platform *svsp,
+                                           const char *node_name)

CHECK: Alignment should match open parenthesis
#1526: FILE: drivers/soc/mediatek/mtk-svs.c:1526:
+struct device *svs_add_device_link(struct svs_platform *svsp,
+                                         const char *node_name)

... [snip]...

> +struct device *svs_add_device_link(struct svs_platform *svsp,
> +					  const char *node_name);
> +struct device *svs_get_subsys_device(struct svs_platform *svsp,
> +					    const char *node_name);

CHECK: Alignment should match open parenthesis
#269: FILE: drivers/soc/mediatek/mtk-svs.h:269:
+struct device *svs_add_device_link(struct svs_platform *svsp,
+                                         const char *node_name);

CHECK: Alignment should match open parenthesis
#271: FILE: drivers/soc/mediatek/mtk-svs.h:271:
+struct device *svs_get_subsys_device(struct svs_platform *svsp,
+                                           const char *node_name);

> +int svs_thermal_efuse_get_data(struct svs_platform *svsp);
> +
> +void svs_get_bank_volts_v2(struct svs_platform *svsp);
> +void svs_set_bank_freq_pct_v2(struct svs_platform *svsp);
> +
> +void svs_get_bank_volts_v3(struct svs_platform *svsp);
> +void svs_set_bank_freq_pct_v3(struct svs_platform *svsp);
> +#endif

Sincerely,
Roger Lu.

