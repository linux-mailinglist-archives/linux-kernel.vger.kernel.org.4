Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E35D6D42D9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 13:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjDCLDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 07:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjDCLDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:03:15 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3157F11EB0
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 04:02:55 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Pqnxk5RLnz6J6q1;
        Mon,  3 Apr 2023 19:00:58 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 3 Apr
 2023 12:02:52 +0100
Date:   Mon, 3 Apr 2023 12:02:51 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Junhao He <hejunhao3@huawei.com>
CC:     <will@kernel.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <catalin.marinas@arm.com>, <kernel-team@android.com>,
        <linuxarm@huawei.com>, <yangyicong@huawei.com>,
        <f.fangjian@huawei.com>, <shenyang39@huawei.com>,
        <prime.zeng@hisilicon.com>
Subject: Re: [PATCH 1/2] drivers/perf: hisi: Remove redundant initialized of
 pmu->name
Message-ID: <20230403120251.00003fd7@Huawei.com>
In-Reply-To: <20230403081423.62460-2-hejunhao3@huawei.com>
References: <20230403081423.62460-1-hejunhao3@huawei.com>
        <20230403081423.62460-2-hejunhao3@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2023 16:14:22 +0800
Junhao He <hejunhao3@huawei.com> wrote:

> "pmu->name" is initialized by perf_pmu_register() function, so remove
> the redundant initialized in hisi_pmu_init().
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c  | 2 +-
>  drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 2 +-
>  drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  | 2 +-
>  drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  | 2 +-
>  drivers/perf/hisilicon/hisi_uncore_pa_pmu.c   | 2 +-
>  drivers/perf/hisilicon/hisi_uncore_pmu.c      | 4 +---
>  drivers/perf/hisilicon/hisi_uncore_pmu.h      | 3 +--
>  drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c | 2 +-
>  8 files changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c b/drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c
> index 4c67d57217a7..40f1bc9f9b91 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c
> @@ -316,7 +316,7 @@ static int hisi_cpa_pmu_probe(struct platform_device *pdev)
>  	if (!name)
>  		return -ENOMEM;
>  
> -	hisi_pmu_init(cpa_pmu, name, THIS_MODULE);
> +	hisi_pmu_init(cpa_pmu, THIS_MODULE);
>  
>  	/* Power Management should be disabled before using CPA PMU. */
>  	hisi_cpa_pmu_disable_pm(cpa_pmu);
> diff --git a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
> index 8c3ffcbfd4c0..8a3d74ddcd6d 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
> @@ -516,7 +516,7 @@ static int hisi_ddrc_pmu_probe(struct platform_device *pdev)
>  				      "hisi_sccl%u_ddrc%u", ddrc_pmu->sccl_id,
>  				      ddrc_pmu->index_id);
>  
> -	hisi_pmu_init(ddrc_pmu, name, THIS_MODULE);
> +	hisi_pmu_init(ddrc_pmu, THIS_MODULE);
>  
>  	ret = perf_pmu_register(&ddrc_pmu->pmu, name, -1);
>  	if (ret) {
> diff --git a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
> index 806698b9eabf..5701a84edb0e 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
> @@ -519,7 +519,7 @@ static int hisi_hha_pmu_probe(struct platform_device *pdev)
>  
>  	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "hisi_sccl%u_hha%u",
>  			      hha_pmu->sccl_id, hha_pmu->index_id);
> -	hisi_pmu_init(hha_pmu, name, THIS_MODULE);
> +	hisi_pmu_init(hha_pmu, THIS_MODULE);
>  
>  	ret = perf_pmu_register(&hha_pmu->pmu, name, -1);
>  	if (ret) {
> diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
> index 5b2c35f1658a..68596b566344 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
> @@ -557,7 +557,7 @@ static int hisi_l3c_pmu_probe(struct platform_device *pdev)
>  	 */
>  	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "hisi_sccl%u_l3c%u",
>  			      l3c_pmu->sccl_id, l3c_pmu->ccl_id);
> -	hisi_pmu_init(l3c_pmu, name, THIS_MODULE);
> +	hisi_pmu_init(l3c_pmu, THIS_MODULE);
>  
>  	ret = perf_pmu_register(&l3c_pmu->pmu, name, -1);
>  	if (ret) {
> diff --git a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
> index afe3419f3f6d..71b6687d6696 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
> @@ -412,7 +412,7 @@ static int hisi_pa_pmu_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	hisi_pmu_init(pa_pmu, name, THIS_MODULE);
> +	hisi_pmu_init(pa_pmu, THIS_MODULE);
>  	ret = perf_pmu_register(&pa_pmu->pmu, name, -1);
>  	if (ret) {
>  		dev_err(pa_pmu->dev, "PMU register failed, ret = %d\n", ret);
> diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> index f1b0f5e1a28f..2823f381930d 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> @@ -531,12 +531,10 @@ int hisi_uncore_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>  }
>  EXPORT_SYMBOL_GPL(hisi_uncore_pmu_offline_cpu);
>  
> -void hisi_pmu_init(struct hisi_pmu *hisi_pmu, const char *name,
> -		   struct module *module)
> +void hisi_pmu_init(struct hisi_pmu *hisi_pmu, struct module *module)
>  {
>  	struct pmu *pmu = &hisi_pmu->pmu;
>  
> -	pmu->name               = name;
>  	pmu->module             = module;
>  	pmu->task_ctx_nr        = perf_invalid_context;
>  	pmu->event_init         = hisi_uncore_pmu_event_init;
> diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
> index f8e3cc6903d7..07890a8e96ca 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
> +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
> @@ -121,6 +121,5 @@ ssize_t hisi_uncore_pmu_identifier_attr_show(struct device *dev,
>  int hisi_uncore_pmu_init_irq(struct hisi_pmu *hisi_pmu,
>  			     struct platform_device *pdev);
>  
> -void hisi_pmu_init(struct hisi_pmu *hisi_pmu, const char *name,
> -		   struct module *module);
> +void hisi_pmu_init(struct hisi_pmu *hisi_pmu, struct module *module);
>  #endif /* __HISI_UNCORE_PMU_H__ */
> diff --git a/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
> index 1e354433776a..6fe534a665ed 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
> @@ -445,7 +445,7 @@ static int hisi_sllc_pmu_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	hisi_pmu_init(sllc_pmu, name, THIS_MODULE);
> +	hisi_pmu_init(sllc_pmu, THIS_MODULE);
>  
>  	ret = perf_pmu_register(&sllc_pmu->pmu, name, -1);
>  	if (ret) {

