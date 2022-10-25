Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEB760D26E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 19:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbiJYR1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 13:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbiJYR1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 13:27:22 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B444146D9E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:27:20 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id t15so2687054edd.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EaSiIImo3JpIdKX1XllTmgX6wW97dTj/LLBn4tq/kbE=;
        b=k6GEFgmko2iv7eIA3sKE4/a2Tv+/HYyzI06MSyqdGelsHvMn7JCWBEl9t2EucOy2ju
         78JD8tdGbJCZhVO8srnL9fJw+lXJn9FWLHXXOInNEMb+30lCy8l7v1SwipffeEpfdvtJ
         LtKSHmkgdtipEHbYpNOBxLNbE4BTYpTN/P9iWkc65tIBfoDnZCZoZ/Yld7MrSdAE61zY
         2RElIXpJ2BXrnHaIcgazUiIuknWVZMSCmFPNQUKjhu2+N1BYQoRn3ewqBxaLb7d/U0Ol
         Ig4NjIsghQKJHdqYveXIz0T6Iy2QTlr+IjX35SDX0nvI3Scmeao+rN785Q4YwXTAEE4w
         b7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EaSiIImo3JpIdKX1XllTmgX6wW97dTj/LLBn4tq/kbE=;
        b=EzIzrZ7yDu8QX9L8jsu1VPHCmgMaVJKlMAHcgw4FbUWyxVX7APUra4p9AwGdoE5FDU
         THkgC+LBLCoSaGUyxrdxA29aJpvTmERPwuKxeeo/aOfmoHbaGQSuQhCpJNwSfa6Qm8hJ
         JeGOapmEjAwhxDJCtZVGO/l41vXl3HPNGlIyQNNMCNbKL8UBsQceEaXXA2Sq9T2ZHqgp
         CH6wkusV5M6oHNoUpMY5VXtY5t6YL7eiiZtqXiHij7yLUB3+iPct3+Ysl1fZVoBReK4j
         DLQo9nB3L2z9CiByJIEP6avX/ysdihzg8+EgGzaRsAjgERA98n+W3pHhcMDD3x0JpVuv
         J0Og==
X-Gm-Message-State: ACrzQf1PPB+frW8SN2VgrBQZdCQnWLnZvfY6VVyrM+5il1+KVlqwOifY
        4RgWg3a2G3M7/msuY5tj+6Q=
X-Google-Smtp-Source: AMsMyM5NTzt87MA/WplphX8cnMJ3lFLsiEj/M/U0zqtRaiH2Zf66ybz5rXmhJctErsdAPexGBskGNQ==
X-Received: by 2002:a05:6402:11c7:b0:462:549d:fbbe with SMTP id j7-20020a05640211c700b00462549dfbbemr123777edw.199.1666718839085;
        Tue, 25 Oct 2022 10:27:19 -0700 (PDT)
Received: from [192.168.1.93] (adsl-115.176.58.194.tellas.gr. [176.58.194.115])
        by smtp.gmail.com with ESMTPSA id t1-20020a50d701000000b0045bd14e241csm2058971edi.76.2022.10.25.10.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 10:27:18 -0700 (PDT)
Message-ID: <6cab9931-8f72-9b90-bf58-f12108f84c58@gmail.com>
Date:   Tue, 25 Oct 2022 20:27:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 1/2] xen/virtio: Optimize the setup of "xen-grant-dma"
 devices
Content-Language: en-US
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>
References: <20221025162004.8501-1-olekstysh@gmail.com>
 <20221025162004.8501-2-olekstysh@gmail.com>
From:   Xenia Ragiadakou <burzalodowa@gmail.com>
In-Reply-To: <20221025162004.8501-2-olekstysh@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/22 19:20, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> This is needed to avoid having to parse the same device-tree
> several times for a given device.
> 
> For this to work we need to install the xen_virtio_restricted_mem_acc
> callback in Arm's xen_guest_init() which is same callback as x86's
> PV and HVM modes already use and remove the manual assignment in
> xen_setup_dma_ops(). Also we need to split the code to initialize
> backend_domid into a separate function.
> 
> Prior to current patch we parsed the device-tree three times:
> 1. xen_setup_dma_ops()->...->xen_is_dt_grant_dma_device()
> 2. xen_setup_dma_ops()->...->xen_dt_grant_init_backend_domid()
> 3. xen_virtio_mem_acc()->...->xen_is_dt_grant_dma_device()
> 
> With current patch we parse the device-tree only once in
> xen_virtio_restricted_mem_acc()->...->xen_dt_grant_init_backend_domid()
> 
> Other benefits are:
> - Not diverge from x86 when setting up Xen grant DMA ops
> - Drop several global functions
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Reviewed-by: Xenia Ragiadakou <burzalodowa@gmail.com>

I have a question unrelated to the patch.
CONFIG_XEN_VIRTIO_FORCE_GRANT cannot be used to force backend dom0 in 
case xen_dt_grant_init_backend_domid() fails?

> ---
> New patch
> ---
>   arch/arm/xen/enlighten.c    |  2 +-
>   drivers/xen/grant-dma-ops.c | 77 ++++++++++++++-----------------------
>   include/xen/arm/xen-ops.h   |  4 +-
>   include/xen/xen-ops.h       | 16 --------
>   4 files changed, 30 insertions(+), 69 deletions(-)
> 
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index 93c8ccbf2982..7d59765aef22 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -445,7 +445,7 @@ static int __init xen_guest_init(void)
>   		return 0;
>   
>   	if (IS_ENABLED(CONFIG_XEN_VIRTIO))
> -		virtio_set_mem_acc_cb(xen_virtio_mem_acc);
> +		virtio_set_mem_acc_cb(xen_virtio_restricted_mem_acc);
>   
>   	if (!acpi_disabled)
>   		xen_acpi_guest_init();
> diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
> index daa525df7bdc..1e797a043980 100644
> --- a/drivers/xen/grant-dma-ops.c
> +++ b/drivers/xen/grant-dma-ops.c
> @@ -292,50 +292,20 @@ static const struct dma_map_ops xen_grant_dma_ops = {
>   	.dma_supported = xen_grant_dma_supported,
>   };
>   
> -static bool xen_is_dt_grant_dma_device(struct device *dev)
> -{
> -	struct device_node *iommu_np;
> -	bool has_iommu;
> -
> -	iommu_np = of_parse_phandle(dev->of_node, "iommus", 0);
> -	has_iommu = iommu_np &&
> -		    of_device_is_compatible(iommu_np, "xen,grant-dma");
> -	of_node_put(iommu_np);
> -
> -	return has_iommu;
> -}
> -
> -bool xen_is_grant_dma_device(struct device *dev)
> -{
> -	/* XXX Handle only DT devices for now */
> -	if (dev->of_node)
> -		return xen_is_dt_grant_dma_device(dev);
> -
> -	return false;
> -}
> -
> -bool xen_virtio_mem_acc(struct virtio_device *dev)
> -{
> -	if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT) || xen_pv_domain())
> -		return true;
> -
> -	return xen_is_grant_dma_device(dev->dev.parent);
> -}
> -
>   static int xen_dt_grant_init_backend_domid(struct device *dev,
> -					   struct xen_grant_dma_data *data)
> +					   domid_t *backend_domid)
>   {
>   	struct of_phandle_args iommu_spec;
>   
>   	if (of_parse_phandle_with_args(dev->of_node, "iommus", "#iommu-cells",
>   			0, &iommu_spec)) {
> -		dev_err(dev, "Cannot parse iommus property\n");
> +		dev_dbg(dev, "Cannot parse iommus property\n");
>   		return -ESRCH;
>   	}
>   
>   	if (!of_device_is_compatible(iommu_spec.np, "xen,grant-dma") ||
>   			iommu_spec.args_count != 1) {
> -		dev_err(dev, "Incompatible IOMMU node\n");
> +		dev_dbg(dev, "Incompatible IOMMU node\n");
>   		of_node_put(iommu_spec.np);
>   		return -ESRCH;
>   	}
> @@ -346,12 +316,28 @@ static int xen_dt_grant_init_backend_domid(struct device *dev,
>   	 * The endpoint ID here means the ID of the domain where the
>   	 * corresponding backend is running
>   	 */
> -	data->backend_domid = iommu_spec.args[0];
> +	*backend_domid = iommu_spec.args[0];
>   
>   	return 0;
>   }
>   
> -void xen_grant_setup_dma_ops(struct device *dev)
> +static int xen_grant_init_backend_domid(struct device *dev,
> +					domid_t *backend_domid)
> +{
> +	int ret = -ENODEV;
> +
> +	if (dev->of_node) {
> +		ret = xen_dt_grant_init_backend_domid(dev, backend_domid);
> +	} else if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT) || xen_pv_domain()) {
> +		dev_info(dev, "Using dom0 as backend\n");
> +		*backend_domid = 0;
> +		ret = 0;
> +	}
> +
> +	return ret;
> +}
> +
> +static void xen_grant_setup_dma_ops(struct device *dev, domid_t backend_domid)
>   {
>   	struct xen_grant_dma_data *data;
>   
> @@ -365,16 +351,7 @@ void xen_grant_setup_dma_ops(struct device *dev)
>   	if (!data)
>   		goto err;
>   
> -	if (dev->of_node) {
> -		if (xen_dt_grant_init_backend_domid(dev, data))
> -			goto err;
> -	} else if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT)) {
> -		dev_info(dev, "Using dom0 as backend\n");
> -		data->backend_domid = 0;
> -	} else {
> -		/* XXX ACPI device unsupported for now */
> -		goto err;
> -	}
> +	data->backend_domid = backend_domid;
>   
>   	if (store_xen_grant_dma_data(dev, data)) {
>   		dev_err(dev, "Cannot store Xen grant DMA data\n");
> @@ -392,12 +369,14 @@ void xen_grant_setup_dma_ops(struct device *dev)
>   
>   bool xen_virtio_restricted_mem_acc(struct virtio_device *dev)
>   {
> -	bool ret = xen_virtio_mem_acc(dev);
> +	domid_t backend_domid;
>   
> -	if (ret)
> -		xen_grant_setup_dma_ops(dev->dev.parent);
> +	if (!xen_grant_init_backend_domid(dev->dev.parent, &backend_domid)) {
> +		xen_grant_setup_dma_ops(dev->dev.parent, backend_domid);
> +		return true;
> +	}
>   
> -	return ret;
> +	return false;
>   }
>   
>   MODULE_DESCRIPTION("Xen grant DMA-mapping layer");
> diff --git a/include/xen/arm/xen-ops.h b/include/xen/arm/xen-ops.h
> index b0766a660338..70073f5a2b54 100644
> --- a/include/xen/arm/xen-ops.h
> +++ b/include/xen/arm/xen-ops.h
> @@ -8,9 +8,7 @@
>   static inline void xen_setup_dma_ops(struct device *dev)
>   {
>   #ifdef CONFIG_XEN
> -	if (xen_is_grant_dma_device(dev))
> -		xen_grant_setup_dma_ops(dev);
> -	else if (xen_swiotlb_detect())
> +	if (xen_swiotlb_detect())
>   		dev->dma_ops = &xen_swiotlb_dma_ops;
>   #endif
>   }
> diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
> index a34f4271a2e9..47f11bec5e90 100644
> --- a/include/xen/xen-ops.h
> +++ b/include/xen/xen-ops.h
> @@ -216,26 +216,10 @@ static inline void xen_preemptible_hcall_end(void) { }
>   #endif /* CONFIG_XEN_PV && !CONFIG_PREEMPTION */
>   
>   #ifdef CONFIG_XEN_GRANT_DMA_OPS
> -void xen_grant_setup_dma_ops(struct device *dev);
> -bool xen_is_grant_dma_device(struct device *dev);
> -bool xen_virtio_mem_acc(struct virtio_device *dev);
>   bool xen_virtio_restricted_mem_acc(struct virtio_device *dev);
>   #else
> -static inline void xen_grant_setup_dma_ops(struct device *dev)
> -{
> -}
> -static inline bool xen_is_grant_dma_device(struct device *dev)
> -{
> -	return false;
> -}
> -
>   struct virtio_device;
>   
> -static inline bool xen_virtio_mem_acc(struct virtio_device *dev)
> -{
> -	return false;
> -}
> -
>   static inline bool xen_virtio_restricted_mem_acc(struct virtio_device *dev)
>   {
>   	return false;

-- 
Xenia
