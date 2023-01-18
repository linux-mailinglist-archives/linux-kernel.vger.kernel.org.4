Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9CF672148
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjARP3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjARP2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:28:50 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5D54AA68
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:28:19 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id p24so37206439plw.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1OpOAaZLDBZwIcKhB8f5D7QZijHxGB6vA+uOjDRAnP4=;
        b=xsf6XlV16XgE3UECaYTxXM9NSNBUUd1c26+00o83eltx/b3NLDtDuWSkWKEdNjC8LO
         9Vz102fr3QWaUf0xwi+L+lmP/cFV+v5lF5WV3enOjTulMMsAPvUNOFnyrBp/BQ0xFI04
         RkLxiVh+WV81KjO55Fhc1o3e7U0XKK7z18Fvdm2iIQ1HziR4kumcZcpczsU2CeicBiRj
         VwnCGVvjDhcpW+DGxzh5izoKH0J69gAc7gOZIKK8MtVMq0Tj9cKcBUQrQNZ3XtZ0xE48
         jkqKdLQB2r2D/LbWa11zjPojTjeRH3hE9/tyIjLdihAFyNdtFHnT0yjc3XS5AIvs+G6y
         Oxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1OpOAaZLDBZwIcKhB8f5D7QZijHxGB6vA+uOjDRAnP4=;
        b=wIIOknfiMQnly0rHfsNU6vQ0hTYtASP+lukolltgBgcLZ2mdCVA4wXcisMrQdhTlFW
         gXdCdEWlXCV5d38WL6cxo1b856c4cg8EhupDA28Nvuu0xqy1rguOKRwJXokXThqfBSv9
         HDLE+nzLPl7M6LeuH3WssgBscXweXJfH/BFjp3K5HwlIyGxpvGUCKZAx5bbMemxDbiJo
         AoVvrLX7/5NKaH6aANI/86lN7k1Z46BnBcs6r5/1z2F9OYjdZmrBFnpY/U1yPBpp3ZXR
         bU7G4WuDpwIa+gh3qhduLusg35sI/GeNM+D09NXqG1htBbz6Zfycsrw5fatk0SVT+tEK
         BUbw==
X-Gm-Message-State: AFqh2kpo8ZsMAGzGZcwltNS7ueM2c/tluCVr/KdlMW1ADOhg8RzuT6es
        ozOrBO8xL/UMs74o3JoswHH1
X-Google-Smtp-Source: AMrXdXue7Xsdr13GXyu90w85O2Fntx4faZksW69pVo7NLm0JWQLw2IALCxyJheaOCLZAMVv+OntIxA==
X-Received: by 2002:a05:6a20:c189:b0:b8:6168:bc2e with SMTP id bg9-20020a056a20c18900b000b86168bc2emr8459540pzb.52.1674055698482;
        Wed, 18 Jan 2023 07:28:18 -0800 (PST)
Received: from thinkpad ([27.111.75.61])
        by smtp.gmail.com with ESMTPSA id 35-20020a631563000000b0044ed37dbca8sm19032149pgv.2.2023.01.18.07.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 07:28:17 -0800 (PST)
Date:   Wed, 18 Jan 2023 20:58:09 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     andersson@kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@somainline.org,
        amit.pundir@linaro.org, regressions@leemhuis.info,
        sumit.semwal@linaro.org, will@kernel.org, catalin.marinas@arm.com,
        robin.murphy@arm.com
Subject: Re: [PATCH V4 06/11] remoteproc: qcom_q6v5_mss: Use a carveout to
 authenticate modem headers
Message-ID: <20230118152809.GC4690@thinkpad>
References: <20230117085840.32356-1-quic_sibis@quicinc.com>
 <20230117085840.32356-7-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230117085840.32356-7-quic_sibis@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 02:28:35PM +0530, Sibi Sankar wrote:
> Any access to the dynamically allocated metadata region by the application
> processor after assigning it to the remote Q6 will result in a XPU
> violation. Fix this by replacing the dynamically allocated memory region
> with a no-map carveout and unmap the modem metadata memory region before
> passing control to the remote Q6.
> 
> Reported-and-tested-by: Amit Pundir <amit.pundir@linaro.org>
> Fixes: 6c5a9dc2481b ("remoteproc: qcom: Make secure world call for mem ownership switch")
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> 
> v4:
>  * Use size/alloc-ranges instead of a specific address [Bjorn]
>  * Include size checks
> 
> v3:
>  * Drop revert no_kernel_mapping since it's already on the list [Mani]
>  * kfree metadata from the branch for parity
> 
>  drivers/remoteproc/qcom_q6v5_mss.c | 59 +++++++++++++++++++++++++++---
>  1 file changed, 53 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index e2f765f87ec9..292e22f58df3 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -17,6 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
> +#include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> @@ -215,6 +216,9 @@ struct q6v5 {
>  	size_t mba_size;
>  	size_t dp_size;
>  
> +	phys_addr_t mdata_phys;
> +	size_t mdata_size;
> +
>  	phys_addr_t mpss_phys;
>  	phys_addr_t mpss_reloc;
>  	size_t mpss_size;
> @@ -973,15 +977,35 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
>  	if (IS_ERR(metadata))
>  		return PTR_ERR(metadata);
>  
> -	ptr = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
> -	if (!ptr) {
> -		kfree(metadata);
> -		dev_err(qproc->dev, "failed to allocate mdt buffer\n");
> -		return -ENOMEM;
> +	if (qproc->mdata_phys) {
> +		if (size > qproc->mdata_size) {
> +			ret = -EINVAL;
> +			dev_err(qproc->dev, "metadata size outside memory range\n");
> +			goto free_metadata;
> +		}
> +
> +		phys = qproc->mdata_phys;
> +		ptr = memremap(qproc->mdata_phys, size, MEMREMAP_WC);
> +		if (!ptr) {
> +			ret = -EBUSY;
> +			dev_err(qproc->dev, "unable to map memory region: %pa+%zx\n",
> +				&qproc->mdata_phys, size);
> +			goto free_metadata;
> +		}
> +	} else {
> +		ptr = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
> +		if (!ptr) {
> +			ret = -ENOMEM;
> +			dev_err(qproc->dev, "failed to allocate mdt buffer\n");
> +			goto free_metadata;
> +		}
>  	}
>  
>  	memcpy(ptr, metadata, size);
>  
> +	if (qproc->mdata_phys)
> +		memunmap(ptr);
> +
>  	/* Hypervisor mapping to access metadata by modem */
>  	mdata_perm = BIT(QCOM_SCM_VMID_HLOS);
>  	ret = q6v5_xfer_mem_ownership(qproc, &mdata_perm, false, true,
> @@ -1010,7 +1034,9 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
>  			 "mdt buffer not reclaimed system may become unstable\n");
>  
>  free_dma_attrs:
> -	dma_free_attrs(qproc->dev, size, ptr, phys, dma_attrs);
> +	if (!qproc->mdata_phys)
> +		dma_free_attrs(qproc->dev, size, ptr, phys, dma_attrs);
> +free_metadata:
>  	kfree(metadata);
>  
>  	return ret < 0 ? ret : 0;
> @@ -1847,6 +1873,7 @@ static int q6v5_init_reset(struct q6v5 *qproc)
>  static int q6v5_alloc_memory_region(struct q6v5 *qproc)
>  {
>  	struct device_node *child;
> +	struct reserved_mem *rmem;
>  	struct device_node *node;
>  	struct resource r;
>  	int ret;
> @@ -1893,6 +1920,26 @@ static int q6v5_alloc_memory_region(struct q6v5 *qproc)
>  	qproc->mpss_phys = qproc->mpss_reloc = r.start;
>  	qproc->mpss_size = resource_size(&r);
>  
> +	if (!child) {
> +		node = of_parse_phandle(qproc->dev->of_node, "memory-region", 2);
> +	} else {
> +		child = of_get_child_by_name(qproc->dev->of_node, "metadata");
> +		node = of_parse_phandle(child, "memory-region", 0);
> +		of_node_put(child);
> +	}
> +
> +	if (!node)
> +		return 0;
> +
> +	rmem = of_reserved_mem_lookup(node);
> +	if (!rmem) {
> +		dev_err(qproc->dev, "unable to resolve metadata region\n");
> +		return -EINVAL;
> +	}
> +
> +	qproc->mdata_phys = rmem->base;
> +	qproc->mdata_size = rmem->size;
> +
>  	return 0;
>  }
>  
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்
