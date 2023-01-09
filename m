Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D073966200A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbjAIIdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbjAIIct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:32:49 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BAA25D7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:32:48 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id i65so2090815pfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 00:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SHMUlyBLH0Q2xt7U2A19C6HrjxjXmZIvH2mKuIhnuV0=;
        b=yHC47N7tRLOutov73Jd6WOaM3gkL1+6ZTDBuR8M7HMgchMCadgbrXUguT7G8/g6NAn
         s1VQoqgcWL57F8HmoPRVahFU7t47R0GDTz3nNfIJR9njRu4JYpeaxhLNqnvD0sjM8Sdz
         aLtYdY/vwJ89Y5/aQmPBGApLmrvMxtDK3NJoUQvrhIK6xwecf5bYGBqa/PQzo3rP/e86
         wFKNuYLwvIpnjQxGDulSRWT2RzekA//ZtDJTk0Y/CApGwBA1HDE8ZMrbeH86cUyNwvRH
         Ywbs62/z0FHs9/bk85293t8TDuHyOfupX/k5CMzT6pnQrRHPlPaR1ltkE2hJy6shq0yk
         DFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SHMUlyBLH0Q2xt7U2A19C6HrjxjXmZIvH2mKuIhnuV0=;
        b=KWK8LINTKfTJ6UbIEp7K718u1ttqI6Ur7j/NrkJyuJDzN80Lc5brb1rrawBfCgWiUq
         Ccb30yjKzquLm2R5uH+vtW0c3TI6tf/x3PnaapMY4mA4pY14pMa8Dk8Zed4AMum/WNwn
         tuF/A8duXDE38OuMSGwiAwbry+LQWcR5PIr1BSymIbBDxxbwdYo/zT0QxvAvMF4kKsvH
         d/x80ZIf1RcWHU3KEta7b6KKnmB7UmGJoMrGrMOwpU11uq/NMpLXQWIG4Mo3UYyjDMsX
         kQaNzOZAILtFjLhxN+WU/+o0wcX4lKXXOpzG1zOicCoBspG0XNU8758wEyUFNDe7rIo+
         K1Pg==
X-Gm-Message-State: AFqh2kpPjrHjI9K52TYvjhnlfxP7wvmu3QVD7eBa3l8XvbCjOwCpKZyh
        ZV9IfwSGSCu74RK7VGTrWvJl
X-Google-Smtp-Source: AMrXdXu+jYwZSGZTybimGhKGn+1dTrGicGL3lTyXesxruRNJFfO1HoZCGpPDD3lUoBOk+4taacoVGQ==
X-Received: by 2002:a05:6a00:18a3:b0:582:197e:f6c1 with SMTP id x35-20020a056a0018a300b00582197ef6c1mr47346974pfh.4.1673253168084;
        Mon, 09 Jan 2023 00:32:48 -0800 (PST)
Received: from thinkpad ([117.217.177.135])
        by smtp.gmail.com with ESMTPSA id j123-20020a62c581000000b00576d76c9927sm5488519pfg.106.2023.01.09.00.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 00:32:47 -0800 (PST)
Date:   Mon, 9 Jan 2023 14:02:31 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, robin.murphy@arm.com, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        amit.pundir@linaro.org, regressions@leemhuis.info,
        sumit.semwal@linaro.org, will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH V2 06/11] remoteproc: qcom_q6v5_mss: Use a carveout to
 authenticate modem headers
Message-ID: <20230109083231.GB4966@thinkpad>
References: <20230109034843.23759-1-quic_sibis@quicinc.com>
 <20230109034843.23759-7-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230109034843.23759-7-quic_sibis@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 09:18:38AM +0530, Sibi Sankar wrote:
> Any access to the dynamically allocated metadata region by the application
> processor after assigning it to the remote Q6 will result in a XPU
> violation. Fix this by replacing the dynamically allocated memory region
> with a no-map carveout and unmap the modem metadata memory region before
> passing control to the remote Q6.
> 
> Reported-and-tested-by: Amit Pundir <amit.pundir@linaro.org>
> Fixes: 6c5a9dc2481b ("remoteproc: qcom: Make secure world call for mem ownership switch")
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
> 
> v2:
>  * Revert no_kernel_mapping [Mani/Robin]
> 
>  drivers/remoteproc/qcom_q6v5_mss.c | 48 ++++++++++++++++++++++++++----
>  1 file changed, 42 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index e2f765f87ec9..b7a158751cef 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -215,6 +215,7 @@ struct q6v5 {
>  	size_t mba_size;
>  	size_t dp_size;
>  
> +	phys_addr_t mdata_phys;
>  	phys_addr_t mpss_phys;
>  	phys_addr_t mpss_reloc;
>  	size_t mpss_size;
> @@ -973,15 +974,29 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
>  	if (IS_ERR(metadata))
>  		return PTR_ERR(metadata);
>  
> -	ptr = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
> -	if (!ptr) {
> -		kfree(metadata);
> -		dev_err(qproc->dev, "failed to allocate mdt buffer\n");
> -		return -ENOMEM;
> +	if (qproc->mdata_phys) {
> +		phys = qproc->mdata_phys;
> +		ptr = memremap(qproc->mdata_phys, size, MEMREMAP_WC);
> +		if (!ptr) {
> +			dev_err(qproc->dev, "unable to map memory region: %pa+%zx\n",
> +				&qproc->mdata_phys, size);
> +			ret = -EBUSY;
> +			goto free_dma_attrs;

There is no memory to free at this point.

Thanks,
Mani

> +		}
> +	} else {
> +		ptr = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
> +		if (!ptr) {
> +			kfree(metadata);
> +			dev_err(qproc->dev, "failed to allocate mdt buffer\n");
> +			return -ENOMEM;
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
> @@ -1010,7 +1025,8 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
>  			 "mdt buffer not reclaimed system may become unstable\n");
>  
>  free_dma_attrs:
> -	dma_free_attrs(qproc->dev, size, ptr, phys, dma_attrs);
> +	if (!qproc->mdata_phys)
> +		dma_free_attrs(qproc->dev, size, ptr, phys, dma_attrs);
>  	kfree(metadata);
>  
>  	return ret < 0 ? ret : 0;
> @@ -1893,6 +1909,26 @@ static int q6v5_alloc_memory_region(struct q6v5 *qproc)
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
> +	ret = of_address_to_resource(node, 0, &r);
> +	of_node_put(node);
> +	if (ret) {
> +		dev_err(qproc->dev, "unable to resolve metadata region\n");
> +		return ret;
> +	}
> +
> +	qproc->mdata_phys = r.start;
> +
>  	return 0;
>  }
>  
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்
