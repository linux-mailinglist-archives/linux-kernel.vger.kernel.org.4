Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9290072C70A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237128AbjFLOK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236976AbjFLOKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:10:52 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6E5E7B;
        Mon, 12 Jun 2023 07:10:47 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CB9kRo004087;
        Mon, 12 Jun 2023 16:10:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=qDnB/Ttau+kc/Wg5I//2bOem0e9PFiWCTRRnCsljavE=;
 b=mxBzoRgtXDbmbBLAdwsBAmrx8LMmThleqhFae/EJrdqCds8ELuHvHLAbgUm+/UO6sEvp
 /3xdjZCGJTgALooad/6QWQabCmgqoSvjD593VEwSAPse2YgddVPEyKyRzLUGZ0+Zg31x
 14FDqvtAq9Butiyt0DN/WGgDXhUyFve4tTS2syk02KiOHd0B/EZB9zV6Zxd46OOt+AZP
 n5t7Cr1LSXNeCnlECGF2JJx7K4lTjZ2pwMxDG8lcreatDAw6uqN69cv83sY2XU5ZQvod
 bJIkIynakuYOCsiDkTj5iMNrh4Q952eYEVb4qEP5CW6+ToAnZk4fuPgfUz2V1yzqwnvw DA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r5yd7tbsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 16:10:26 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B523510002A;
        Mon, 12 Jun 2023 16:10:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A918523C6B3;
        Mon, 12 Jun 2023 16:10:23 +0200 (CEST)
Received: from [10.252.14.202] (10.252.14.202) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 12 Jun
 2023 16:10:23 +0200
Message-ID: <7846c69b-5c2d-16d3-6079-d11a60171a69@foss.st.com>
Date:   Mon, 12 Jun 2023 16:10:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] remoteproc: stm32: use correct format strings on 64-bit
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Arnd Bergmann <arnd@arndb.de>, Ben Levinsky <ben.levinsky@amd.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230609120546.3937821-1-arnd@kernel.org>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <20230609120546.3937821-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.14.202]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_06,2023-06-09_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd

On 6/9/23 14:05, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> With CONFIG_ARCH_STM32 making it into arch/arm64, a couple of format
> strings no longer work, since they rely on size_t being compatible
> with %x, or they print an 'int' using %z:
> 
> drivers/remoteproc/stm32_rproc.c: In function 'stm32_rproc_mem_alloc':
> drivers/remoteproc/stm32_rproc.c:122:22: error: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'size_t' {aka 'long unsigned int'} [-Werror=format=]
> drivers/remoteproc/stm32_rproc.c:122:40: note: format string is defined here
>   122 |         dev_dbg(dev, "map memory: %pa+%x\n", &mem->dma, mem->len);
>       |                                       ~^
>       |                                        |
>       |                                        unsigned int
>       |                                       %lx
> drivers/remoteproc/stm32_rproc.c:125:30: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'size_t' {aka 'long unsigned int'} [-Werror=format=]
> drivers/remoteproc/stm32_rproc.c:125:65: note: format string is defined here
>   125 |                 dev_err(dev, "Unable to map memory region: %pa+%x\n",
>       |                                                                ~^
>       |                                                                 |
>       |                                                                 unsigned int
>       |                                                                %lx
> drivers/remoteproc/stm32_rproc.c: In function 'stm32_rproc_get_loaded_rsc_table':
> drivers/remoteproc/stm32_rproc.c:646:30: error: format '%zx' expects argument of type 'size_t', but argument 4 has type 'int' [-Werror=format=]
> drivers/remoteproc/stm32_rproc.c:646:66: note: format string is defined here
>   646 |                 dev_err(dev, "Unable to map memory region: %pa+%zx\n",
>       |                                                                ~~^
>       |                                                                  |
>       |                                                                  long unsigned int
>       |                                                                %x
> 
> Fix up all three instances to work across architectures, and enable
> compile testing for this driver to ensure it builds everywhere.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


I also have it for the stm32mp2 :)

Please find a remark below , with or without that

Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>

> ---
>  drivers/remoteproc/Kconfig       | 2 +-
>  drivers/remoteproc/stm32_rproc.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index a850e9f486dd6..48845dc8fa852 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -313,7 +313,7 @@ config ST_SLIM_REMOTEPROC
>  
>  config STM32_RPROC
>  	tristate "STM32 remoteproc support"
> -	depends on ARCH_STM32
> +	depends on ARCH_STM32 || COMPILE_TEST
>  	depends on REMOTEPROC
>  	select MAILBOX
>  	help
> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> index a7457777aae43..cf073bac79f73 100644
> --- a/drivers/remoteproc/stm32_rproc.c
> +++ b/drivers/remoteproc/stm32_rproc.c
> @@ -119,10 +119,10 @@ static int stm32_rproc_mem_alloc(struct rproc *rproc,
>  	struct device *dev = rproc->dev.parent;
>  	void *va;
>  
> -	dev_dbg(dev, "map memory: %pa+%x\n", &mem->dma, mem->len);
> +	dev_dbg(dev, "map memory: %pad+%zx\n", &mem->dma, mem->len);
>  	va = ioremap_wc(mem->dma, mem->len);
>  	if (IS_ERR_OR_NULL(va)) {
> -		dev_err(dev, "Unable to map memory region: %pa+%x\n",
> +		dev_err(dev, "Unable to map memory region: %pad+0x%zx\n",
>  			&mem->dma, mem->len);
>  		return -ENOMEM;
>  	}
> @@ -643,7 +643,7 @@ stm32_rproc_get_loaded_rsc_table(struct rproc *rproc, size_t *table_sz)
>  
>  	ddata->rsc_va = devm_ioremap_wc(dev, rsc_pa, RSC_TBL_SIZE);
>  	if (IS_ERR_OR_NULL(ddata->rsc_va)) {
> -		dev_err(dev, "Unable to map memory region: %pa+%zx\n",
> +		dev_err(dev, "Unable to map memory region: %pa+%x\n",
>  			&rsc_pa, RSC_TBL_SIZE);

What about cast the RSC_TBL_SIZE define instead to ensure to be independent from
the arch and to match with the use of RSC_TBL_SIZE?

#define RSC_TBL_SIZE		((size_t)1024)

Thanks,
Arnaud

>  		ddata->rsc_va = NULL;
>  		return ERR_PTR(-ENOMEM);
