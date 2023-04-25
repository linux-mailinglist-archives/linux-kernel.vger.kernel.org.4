Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33CB6EDDEF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 10:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbjDYI13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 04:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbjDYI1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 04:27:21 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E401861BC
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 01:27:17 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33P5Tuas010494;
        Tue, 25 Apr 2023 10:27:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=pxZI22//1Zd7Ao5iHKtfZElDlqjO1ZEYCCH7+Ni9CUc=;
 b=27UJAZcgSUwoqMlYBaUMSV1ykE4CDOtLdROunYoNSEDU5vjC5brO0ONB4t/E2mLn8eOc
 eUeXfmBPa7LddVDljGZu2I8bz0fPITrcrfaJXtQnDCldLGpWoySUFyGSY9i3ykJvn68g
 P9UFpEeyl8S+0MGmPCyVQhJko3GLGKeXlI1+eNblhCPdcy6QhcirFI/MZkj1WJENTOaa
 wM3mU0vs2BgEduZdbcu/lThDOLgx03zy4N6lhZS32SVJ5OwB+IRMB+knwz0ANWqLpXzZ
 Y2O3l671vV0vqH4ma3OcFOdanzlDgPAamUfpjLEWHjVAZ9haV6VKZ9BvexliB7G/af00 IQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3q5t4vd7bd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 10:27:01 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B26C810002A;
        Tue, 25 Apr 2023 10:27:00 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9D43E21860E;
        Tue, 25 Apr 2023 10:27:00 +0200 (CEST)
Received: from [10.129.178.187] (10.129.178.187) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 25 Apr
 2023 10:26:57 +0200
Message-ID: <67a4b02a-8967-b06b-bcc0-964eee99975e@foss.st.com>
Date:   Tue, 25 Apr 2023 10:26:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH -next] drm/stm: dsi: Use devm_platform_ioremap_resource()
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, <yannick.fertre@foss.st.com>
CC:     <philippe.cornu@foss.st.com>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230421083402.21364-1-yang.lee@linux.alibaba.com>
From:   Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20230421083402.21364-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.129.178.187]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_03,2023-04-21_01,2023-02-09_01
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

On 4/21/23 10:34, Yang Li wrote:
> Convert platform_get_resource(),devm_ioremap_resource() to a single call
> to devm_platform_ioremap_resource(), as this is exactly what this function
> does.
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> index 89897d5f5c72..1750b6a25e87 100644
> --- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> +++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> @@ -444,15 +444,13 @@ static int dw_mipi_dsi_stm_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct dw_mipi_dsi_stm *dsi;
>  	struct clk *pclk;
> -	struct resource *res;
>  	int ret;
>  
>  	dsi = devm_kzalloc(dev, sizeof(*dsi), GFP_KERNEL);
>  	if (!dsi)
>  		return -ENOMEM;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	dsi->base = devm_ioremap_resource(dev, res);
> +	dsi->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(dsi->base)) {
>  		ret = PTR_ERR(dsi->base);
>  		DRM_ERROR("Unable to get dsi registers %d\n", ret);


Thanks for the patch.

Acked-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>

