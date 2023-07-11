Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EBB74EDBC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjGKMLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjGKMLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:11:11 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09D2E7E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:11:03 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3159d75606dso1923910f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689077462; x=1691669462;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aNBxTgVnJ8Dr2x17xMcs2WWzX7OlQI5PaEygLf/8jHQ=;
        b=CphdP3GnwEqZ5uS7/ISnyFpMuZAbwlhJY8n7vFWhBzhDI3lwOsLA7vleGh2jwD+a2T
         Eed+cb4e0ezP82Usz2z15XaCZXAMuSkVxnEVrNj6hhmNY0XNgGHWtdV+Xl5TCBUCq7mt
         7c/nniN1rHrPzH+i44pZRvbR504xq2HTuPETTAFWfxPWQkQtYzrCeaHeoXcsxkVScDuE
         C1PnsS5Nrkd1KJHFUFOkFbnCVK/kHacCiW3C2xQLs/IChwBOHefT6CqAdD7+eA9tCP1C
         AqiMqMEtYlzoPtOefLqd06F1MaPY64cFD013Cqx4h0g/fWaJqcDe3nM5OBNfhqLNYwDt
         RELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077462; x=1691669462;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aNBxTgVnJ8Dr2x17xMcs2WWzX7OlQI5PaEygLf/8jHQ=;
        b=b9k4vQcx5AVfbYy32kuj3urdKlS/kJmtwhoe9JHd99rvgv/badbVQn8MI6YyC7Tn/w
         brkAr8IYry3Xmk6qpZDYVzJp+boO+QR2dFr5lUutWyo2mYp0bCNCMNtfMBGcfAMu6ASU
         ZOBvnNrwuID2PDiXBZ195aQRJ+5OERE3s6BtushjTacwuM55GFkeOXVi+1cI3NMbNpKL
         8Q49h0Z/jQ05StBvlzeV4XPCIp4PzxlTB1LtACECNSxK39psSekeIRllGCGFotDcl+uJ
         KkbvqqgV4W3Wo/KLhJitqQU5MOPWl7h4TSD+5IKLB1EuvwQZH08WTE3qCf8qSqpNtvvN
         eOoA==
X-Gm-Message-State: ABy/qLYEQosG/OHH5q2yQ2G+ikmSBjTNVBnjjXu8FMHCO8krmtPdn3if
        KC8SMuKHlS+SsekAxshd5GgA3Q==
X-Google-Smtp-Source: APBJJlHfEYu/APKtZSXN8LAB/F/9n1Tv09E1GKFAx6mKx+60OmRokA5q23AGE+Nr5jEmAgd0rxIIEg==
X-Received: by 2002:a5d:5603:0:b0:314:37e7:efb4 with SMTP id l3-20020a5d5603000000b0031437e7efb4mr11909981wrv.11.1689077462078;
        Tue, 11 Jul 2023 05:11:02 -0700 (PDT)
Received: from [192.168.1.82] (host-92-17-99-126.as13285.net. [92.17.99.126])
        by smtp.gmail.com with ESMTPSA id t14-20020adfe44e000000b00314374145e0sm2091419wrm.67.2023.07.11.05.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 05:11:01 -0700 (PDT)
Message-ID: <d9ecfde3-a1ec-8a83-c778-2349f51df31d@linaro.org>
Date:   Tue, 11 Jul 2023 13:11:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] remoteproc: qcom: Use of_reserved_mem_lookup()
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230710-rproc-of-rmem-v3-1-eea7f0a33590@gerhold.net>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20230710-rproc-of-rmem-v3-1-eea7f0a33590@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/07/2023 21:34, Stephan Gerhold wrote:
> Reserved memory can be either looked up using the generic function
> of_address_to_resource() or using the special of_reserved_mem_lookup().
> The latter has the advantage that it ensures that the referenced memory
> region was really reserved and is not e.g. status = "disabled".
> 
> of_reserved_mem also supports allocating reserved memory dynamically at
> boot time. This works only when using of_reserved_mem_lookup() since
> there won't be a fixed address in the device tree.
> 
> Switch the code to use of_reserved_mem_lookup(), similar to
> qcom_q6v5_wcss.c which is using it already. There is no functional
> difference for static reserved memory allocations.
> 
> While at it this also adds two missing of_node_put() calls in
> qcom_q6v5_pas.c.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Tested-by: Caleb Connolly <caleb.connolly@linaro.org> # SDM845
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Changes in v3:
> - Revert additional rmem->size checks: None of the existing users of
>   of_reserved_mem_lookup() have it so it sounds better to handle this 
>   internally in of_reserved_mem. I'll work on a separate patch series
>   to improve this independently of this one. (Caleb)
> - Link to v2: https://lore.kernel.org/r/20230529-rproc-of-rmem-v2-0-95e39b959585@gerhold.net
> 
> Changes in v2:
> - Add missing check for rmem (Bjorn)
> - Add checks for rmem->size to ensure dynamic reserved memory was 
>   really allocated
> - Link to v1: https://lore.kernel.org/r/20230529-rproc-of-rmem-v1-1-5b1e38880aba@gerhold.net
> ---
> See e.g. [1] for an example of dynamically allocated reserved memory.
> (This patch does *not* depend on [1] and is useful without as well...)
> 
> NOTE: Changes in qcom_q6v5_adsp.c and qcom_q6v5_pas.c are untested,
> I only checked qcom_q6v5_mss.c and qcom_wcnss.c on MSM8916/DB410c.
> The code changes are pretty similar for all of those though.
> 
> [1]: https://lore.kernel.org/linux-arm-msm/20230510-dt-resv-bottom-up-v1-5-3bf68873dbed@gerhold.net/
> ---
>  drivers/remoteproc/qcom_q6v5_adsp.c | 24 ++++++++---------
>  drivers/remoteproc/qcom_q6v5_mss.c  | 33 ++++++++++++++----------
>  drivers/remoteproc/qcom_q6v5_pas.c  | 51 ++++++++++++++++++++-----------------
>  drivers/remoteproc/qcom_wcnss.c     | 24 ++++++++---------
>  4 files changed, 69 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
> index 6777a3bd6226..d3caaa551916 100644
> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
> @@ -14,8 +14,8 @@
>  #include <linux/kernel.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
> -#include <linux/of_address.h>
>  #include <linux/of_device.h>
> +#include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> @@ -637,28 +637,26 @@ static int adsp_init_mmio(struct qcom_adsp *adsp,
>  
>  static int adsp_alloc_memory_region(struct qcom_adsp *adsp)
>  {
> +	struct reserved_mem *rmem = NULL;
>  	struct device_node *node;
> -	struct resource r;
> -	int ret;
>  
>  	node = of_parse_phandle(adsp->dev->of_node, "memory-region", 0);
> -	if (!node) {
> -		dev_err(adsp->dev, "no memory-region specified\n");
> +	if (node)
> +		rmem = of_reserved_mem_lookup(node);
> +	of_node_put(node);
> +
> +	if (!rmem) {
> +		dev_err(adsp->dev, "unable to resolve memory-region\n");
>  		return -EINVAL;
>  	}
>  
> -	ret = of_address_to_resource(node, 0, &r);
> -	of_node_put(node);
> -	if (ret)
> -		return ret;
> -
> -	adsp->mem_phys = adsp->mem_reloc = r.start;
> -	adsp->mem_size = resource_size(&r);
> +	adsp->mem_phys = adsp->mem_reloc = rmem->base;
> +	adsp->mem_size = rmem->size;
>  	adsp->mem_region = devm_ioremap_wc(adsp->dev,
>  				adsp->mem_phys, adsp->mem_size);
>  	if (!adsp->mem_region) {
>  		dev_err(adsp->dev, "unable to map memory region: %pa+%zx\n",
> -			&r.start, adsp->mem_size);
> +			&rmem->base, adsp->mem_size);
>  		return -EBUSY;
>  	}
>  
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index 70bffc9f33f6..69b90dc32d8a 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -15,7 +15,6 @@
>  #include <linux/kernel.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
> -#include <linux/of_address.h>
>  #include <linux/of_device.h>
>  #include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
> @@ -1875,8 +1874,6 @@ static int q6v5_alloc_memory_region(struct q6v5 *qproc)
>  	struct device_node *child;
>  	struct reserved_mem *rmem;
>  	struct device_node *node;
> -	struct resource r;
> -	int ret;
>  
>  	/*
>  	 * In the absence of mba/mpss sub-child, extract the mba and mpss
> @@ -1891,15 +1888,20 @@ static int q6v5_alloc_memory_region(struct q6v5 *qproc)
>  		of_node_put(child);
>  	}
>  
> -	ret = of_address_to_resource(node, 0, &r);
> +	if (!node) {
> +		dev_err(qproc->dev, "no mba memory-region specified\n");
> +		return -EINVAL;
> +	}
> +
> +	rmem = of_reserved_mem_lookup(node);
>  	of_node_put(node);
> -	if (ret) {
> +	if (!rmem) {
>  		dev_err(qproc->dev, "unable to resolve mba region\n");
> -		return ret;
> +		return -EINVAL;
>  	}
>  
> -	qproc->mba_phys = r.start;
> -	qproc->mba_size = resource_size(&r);
> +	qproc->mba_phys = rmem->base;
> +	qproc->mba_size = rmem->size;
>  
>  	if (!child) {
>  		node = of_parse_phandle(qproc->dev->of_node,
> @@ -1910,15 +1912,20 @@ static int q6v5_alloc_memory_region(struct q6v5 *qproc)
>  		of_node_put(child);
>  	}
>  
> -	ret = of_address_to_resource(node, 0, &r);
> +	if (!node) {
> +		dev_err(qproc->dev, "no mpss memory-region specified\n");
> +		return -EINVAL;
> +	}
> +
> +	rmem = of_reserved_mem_lookup(node);
>  	of_node_put(node);
> -	if (ret) {
> +	if (!rmem) {
>  		dev_err(qproc->dev, "unable to resolve mpss region\n");
> -		return ret;
> +		return -EINVAL;
>  	}
>  
> -	qproc->mpss_phys = qproc->mpss_reloc = r.start;
> -	qproc->mpss_size = resource_size(&r);
> +	qproc->mpss_phys = qproc->mpss_reloc = rmem->base;
> +	qproc->mpss_size = rmem->size;
>  
>  	if (!child) {
>  		node = of_parse_phandle(qproc->dev->of_node, "memory-region", 2);
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 3153d82037e7..58f8b81f6d52 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -13,8 +13,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/of_address.h>
>  #include <linux/of_device.h>
> +#include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> @@ -533,9 +533,8 @@ static void adsp_pds_detach(struct qcom_adsp *adsp, struct device **pds,
>  
>  static int adsp_alloc_memory_region(struct qcom_adsp *adsp)
>  {
> +	struct reserved_mem *rmem;
>  	struct device_node *node;
> -	struct resource r;
> -	int ret;
>  
>  	node = of_parse_phandle(adsp->dev->of_node, "memory-region", 0);
>  	if (!node) {
> @@ -543,17 +542,19 @@ static int adsp_alloc_memory_region(struct qcom_adsp *adsp)
>  		return -EINVAL;
>  	}
>  
> -	ret = of_address_to_resource(node, 0, &r);
> +	rmem = of_reserved_mem_lookup(node);
>  	of_node_put(node);
> -	if (ret)
> -		return ret;
> +	if (!rmem) {
> +		dev_err(adsp->dev, "unable to resolve memory-region\n");
> +		return -EINVAL;
> +	}
>  
> -	adsp->mem_phys = adsp->mem_reloc = r.start;
> -	adsp->mem_size = resource_size(&r);
> +	adsp->mem_phys = adsp->mem_reloc = rmem->base;
> +	adsp->mem_size = rmem->size;
>  	adsp->mem_region = devm_ioremap_wc(adsp->dev, adsp->mem_phys, adsp->mem_size);
>  	if (!adsp->mem_region) {
>  		dev_err(adsp->dev, "unable to map memory region: %pa+%zx\n",
> -			&r.start, adsp->mem_size);
> +			&rmem->base, adsp->mem_size);
>  		return -EBUSY;
>  	}
>  
> @@ -566,16 +567,19 @@ static int adsp_alloc_memory_region(struct qcom_adsp *adsp)
>  		return -EINVAL;
>  	}
>  
> -	ret = of_address_to_resource(node, 0, &r);
> -	if (ret)
> -		return ret;
> +	rmem = of_reserved_mem_lookup(node);
> +	of_node_put(node);
> +	if (!rmem) {
> +		dev_err(adsp->dev, "unable to resolve dtb memory-region\n");
> +		return -EINVAL;
> +	}
>  
> -	adsp->dtb_mem_phys = adsp->dtb_mem_reloc = r.start;
> -	adsp->dtb_mem_size = resource_size(&r);
> +	adsp->dtb_mem_phys = adsp->dtb_mem_reloc = rmem->base;
> +	adsp->dtb_mem_size = rmem->size;
>  	adsp->dtb_mem_region = devm_ioremap_wc(adsp->dev, adsp->dtb_mem_phys, adsp->dtb_mem_size);
>  	if (!adsp->dtb_mem_region) {
>  		dev_err(adsp->dev, "unable to map dtb memory region: %pa+%zx\n",
> -			&r.start, adsp->dtb_mem_size);
> +			&rmem->base, adsp->dtb_mem_size);
>  		return -EBUSY;
>  	}
>  
> @@ -584,29 +588,28 @@ static int adsp_alloc_memory_region(struct qcom_adsp *adsp)
>  
>  static int adsp_assign_memory_region(struct qcom_adsp *adsp)
>  {
> +	struct reserved_mem *rmem = NULL;
>  	struct qcom_scm_vmperm perm;
>  	struct device_node *node;
> -	struct resource r;
>  	int ret;
>  
>  	if (!adsp->region_assign_idx)
>  		return 0;
>  
>  	node = of_parse_phandle(adsp->dev->of_node, "memory-region", adsp->region_assign_idx);
> -	if (!node) {
> -		dev_err(adsp->dev, "missing shareable memory-region\n");
> +	if (node)
> +		rmem = of_reserved_mem_lookup(node);
> +	of_node_put(node);
> +	if (!rmem) {
> +		dev_err(adsp->dev, "unable to resolve shareable memory-region\n");
>  		return -EINVAL;
>  	}
>  
> -	ret = of_address_to_resource(node, 0, &r);
> -	if (ret)
> -		return ret;
> -
>  	perm.vmid = QCOM_SCM_VMID_MSS_MSA;
>  	perm.perm = QCOM_SCM_PERM_RW;
>  
> -	adsp->region_assign_phys = r.start;
> -	adsp->region_assign_size = resource_size(&r);
> +	adsp->region_assign_phys = rmem->base;
> +	adsp->region_assign_size = rmem->size;
>  	adsp->region_assign_perms = BIT(QCOM_SCM_VMID_HLOS);
>  
>  	ret = qcom_scm_assign_mem(adsp->region_assign_phys,
> diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
> index 1ed0647bc962..334a9c75dad6 100644
> --- a/drivers/remoteproc/qcom_wcnss.c
> +++ b/drivers/remoteproc/qcom_wcnss.c
> @@ -14,8 +14,8 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/io.h>
> -#include <linux/of_address.h>
>  #include <linux/of_device.h>
> +#include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> @@ -506,27 +506,25 @@ static int wcnss_request_irq(struct qcom_wcnss *wcnss,
>  
>  static int wcnss_alloc_memory_region(struct qcom_wcnss *wcnss)
>  {
> +	struct reserved_mem *rmem = NULL;
>  	struct device_node *node;
> -	struct resource r;
> -	int ret;
>  
>  	node = of_parse_phandle(wcnss->dev->of_node, "memory-region", 0);
> -	if (!node) {
> -		dev_err(wcnss->dev, "no memory-region specified\n");
> +	if (node)
> +		rmem = of_reserved_mem_lookup(node);
> +	of_node_put(node);
> +
> +	if (!rmem) {
> +		dev_err(wcnss->dev, "unable to resolve memory-region\n");
>  		return -EINVAL;
>  	}
>  
> -	ret = of_address_to_resource(node, 0, &r);
> -	of_node_put(node);
> -	if (ret)
> -		return ret;
> -
> -	wcnss->mem_phys = wcnss->mem_reloc = r.start;
> -	wcnss->mem_size = resource_size(&r);
> +	wcnss->mem_phys = wcnss->mem_reloc = rmem->base;
> +	wcnss->mem_size = rmem->size;
>  	wcnss->mem_region = devm_ioremap_wc(wcnss->dev, wcnss->mem_phys, wcnss->mem_size);
>  	if (!wcnss->mem_region) {
>  		dev_err(wcnss->dev, "unable to map memory region: %pa+%zx\n",
> -			&r.start, wcnss->mem_size);
> +			&rmem->base, wcnss->mem_size);
>  		return -EBUSY;
>  	}
>  
> 
> ---
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> change-id: 20230529-rproc-of-rmem-7d931f61f64e
> 
> Best regards,

-- 
// Caleb (they/them)
