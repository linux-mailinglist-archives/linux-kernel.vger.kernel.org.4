Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6307125B0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 13:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243349AbjEZLhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 07:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242184AbjEZLhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 07:37:23 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437F51BD
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 04:37:03 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QAYrKk025556;
        Fri, 26 May 2023 13:36:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=S6XM50mu6V6wJscvmX3U+TyamOHBOuxRqWN0uH6wbq4=;
 b=unOnYOP7pMFoXzyoENqDTT4xAyA+yQWxd5n6RU4anROy+7RfJHMrProvk9QNE++9xQhw
 0DICGNUlXhcutzH4/qsG0D5X+ynvnA1I2ZBlFSJV3cA9hwPaRjAg4AqtCWRdoeVUatQG
 2S8oNmyT3TgXTAHtX5cAqD8HejmsjawCU5VNT1wUhf/XpWCaxwQSoAVmf6XZIrkj1uEB
 8UkxUNPv8obmB3snpbGuxamsK1DZMFxZTiZKEr4Z+wGUvuArdMUGhlv8VB34zg5BpXmd
 f8ozAU+VxMATa1687S+u/PIzn0YXPVEk5NpP1yK7zboxwDRf9Jdnriph5RN6uYUeqVlF xg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qt4aw0k43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 13:36:45 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 225F010002A;
        Fri, 26 May 2023 13:36:45 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 13497229A83;
        Fri, 26 May 2023 13:36:45 +0200 (CEST)
Received: from [10.48.0.148] (10.48.0.148) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 26 May
 2023 13:36:43 +0200
Message-ID: <f6aaa6b7-7f48-2574-ed0f-54cd3519bfbe@foss.st.com>
Date:   Fri, 26 May 2023 13:36:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH -next] drm/stm: dsi: Use devm_platform_ioremap_resource()
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, <yannick.fertre@foss.st.com>
CC:     <raphael.gallais-pou@foss.st.com>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230421083402.21364-1-yang.lee@linux.alibaba.com>
From:   Philippe CORNU <philippe.cornu@foss.st.com>
In-Reply-To: <20230421083402.21364-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.0.148]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/21/23 10:34, Yang Li wrote:
> Convert platform_get_resource(),devm_ioremap_resource() to a single call
> to devm_platform_ioremap_resource(), as this is exactly what this function
> does.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> index 89897d5f5c72..1750b6a25e87 100644
> --- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> +++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> @@ -444,15 +444,13 @@ static int dw_mipi_dsi_stm_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct dw_mipi_dsi_stm *dsi;
>   	struct clk *pclk;
> -	struct resource *res;
>   	int ret;
>   
>   	dsi = devm_kzalloc(dev, sizeof(*dsi), GFP_KERNEL);
>   	if (!dsi)
>   		return -ENOMEM;
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	dsi->base = devm_ioremap_resource(dev, res);
> +	dsi->base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(dsi->base)) {
>   		ret = PTR_ERR(dsi->base);
>   		DRM_ERROR("Unable to get dsi registers %d\n", ret);

Applied on drm-misc-next.
Many thanks for your patch,
Philippe :-)
