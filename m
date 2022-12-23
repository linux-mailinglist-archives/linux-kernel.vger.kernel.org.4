Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3935F655194
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 15:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbiLWOrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 09:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbiLWOrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 09:47:43 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B744494D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 06:47:38 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id fy4so5207946pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 06:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jJM00YEPG1ZrW968XxjVUE7AX3Hq8AZNHgIKgxgW064=;
        b=h4v0UjN3sDVaAbgLQVJBvt5BqhmpXNaE+YVi+J42CA3NSUa2CtnA5QypC3zdPhinWm
         Ew8BcSkDxc/vy/jb1vo5JMq0knvKYDKa7BBzazcI+0ZXj6KnPS4OszH1/FRcr51Fu+7W
         tbYfsXqQa2Z3SM9RSp4jJNL0CSI9or4j62aFgPHU/9eLexfCMG2zv8oQdJ/Jh+PPAW28
         vCO7zhi+ln1BwyC+TMXC2uoMJpEw4djJb1QCFuJvNGkRsySpRrS8CG5A1FviGX7oKWGv
         D1yaRi0OeM4tOvoXGUYE41PaP33iq9FsROXRuotay1is4PAWjMKrE0CVKWzxDY0gEEE0
         6ggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJM00YEPG1ZrW968XxjVUE7AX3Hq8AZNHgIKgxgW064=;
        b=ZiBXfLLhLXAq7JaWe3yNCLBkhRXUNq9fnGqURz1VssYGlinByWcCZGuqy9XJ7YthQg
         1c9ODKdcanJcwo1998Tb9f6WkF3B1b2YVvQAhumeti+GLCIw8EKzX/26/1hnwmwwZhnR
         NfjNMj8V9LQMJ4xS/B+Z9IlBHja5Y9UEmxKV6fEGRfxO4l1QItUx5seKo6ZWHSUdQTjc
         exINs2h2MVOZImHQgfxwHl0DRShRZkqHh/yhCeb4GKVo0639N2rfuzlzuwuU1lvgWQ2r
         HfdJj84sUhgaQ26m3fR+A6cxvIWYw90VHeshlwIxm+qCA1KW7I4hLMyriBNdacr6d846
         IUzQ==
X-Gm-Message-State: AFqh2kqbz/HGtOd7w9yQdmgm27f6cDx9dC5wJpxsiKcvsHSb6BGNvT8W
        m9Z1q6YI3U5fm0vrxjJ2Qn5Y
X-Google-Smtp-Source: AMrXdXsjU622IO+mgehF4+9ivq19hzZRf6NBvr+d6kIyOVIcsFXYAOgNrdKUrLOtJXQxhyzCL0rBuQ==
X-Received: by 2002:a17:902:ccd0:b0:189:6ab3:9e57 with SMTP id z16-20020a170902ccd000b001896ab39e57mr10742244ple.22.1671806857501;
        Fri, 23 Dec 2022 06:47:37 -0800 (PST)
Received: from thinkpad ([27.111.75.82])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709027fce00b0019141c79b1dsm2436193plb.254.2022.12.23.06.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 06:47:36 -0800 (PST)
Date:   Fri, 23 Dec 2022 20:17:31 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH 1/2] Revert "remoteproc: qcom_q6v5_mss: map/unmap
 metadata region before/after use"
Message-ID: <20221223144731.GA4587@thinkpad>
References: <20221223092703.61927-1-hch@lst.de>
 <20221223092703.61927-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221223092703.61927-2-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 10:27:02AM +0100, Christoph Hellwig wrote:
> This reverts commit fc156629b23a21181e473e60341e3a78af25a1d4.
> 
> This commit manages to do three API violations at once:
> 
>  - dereference the return value of dma_alloc_attrs with the
>    DMA_ATTR_NO_KERNEL_MAPPING mapping, which is clearly forbidden and
>    will do the wrong thing on various dma mapping implementations.  The
>    fact that dma-direct uses a struct page as a cookie is an undocumented
>    implementation detail
>  - include dma-map-ops.h and use pgprot_dmacoherent despite a clear
>    comment documenting that this is not acceptable
>  - use of the VM_DMA_COHERENT for something that is not the dma-mapping
>    code
>  - use of VM_FLUSH_RESET_PERMS for vmap, while it is only supported for
>    vmalloc
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/remoteproc/qcom_q6v5_mss.c | 38 +++++-------------------------
>  1 file changed, 6 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index fddb63cffee078..a8b141db4de63f 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -10,7 +10,6 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/devcoredump.h>
> -#include <linux/dma-map-ops.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> @@ -933,52 +932,27 @@ static void q6v5proc_halt_axi_port(struct q6v5 *qproc,
>  static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
>  				const char *fw_name)
>  {
> -	unsigned long dma_attrs = DMA_ATTR_FORCE_CONTIGUOUS | DMA_ATTR_NO_KERNEL_MAPPING;
> -	unsigned long flags = VM_DMA_COHERENT | VM_FLUSH_RESET_PERMS;
> -	struct page **pages;
> -	struct page *page;
> +	unsigned long dma_attrs = DMA_ATTR_FORCE_CONTIGUOUS;
>  	dma_addr_t phys;
>  	void *metadata;
>  	int mdata_perm;
>  	int xferop_ret;
>  	size_t size;
> -	void *vaddr;
> -	int count;
> +	void *ptr;
>  	int ret;
> -	int i;
>  
>  	metadata = qcom_mdt_read_metadata(fw, &size, fw_name, qproc->dev);
>  	if (IS_ERR(metadata))
>  		return PTR_ERR(metadata);
>  
> -	page = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
> -	if (!page) {
> +	ptr = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
> +	if (!ptr) {
>  		kfree(metadata);
>  		dev_err(qproc->dev, "failed to allocate mdt buffer\n");
>  		return -ENOMEM;
>  	}
>  
> -	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -	pages = kmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
> -	if (!pages) {
> -		ret = -ENOMEM;
> -		goto free_dma_attrs;
> -	}
> -
> -	for (i = 0; i < count; i++)
> -		pages[i] = nth_page(page, i);
> -
> -	vaddr = vmap(pages, count, flags, pgprot_dmacoherent(PAGE_KERNEL));
> -	kfree(pages);
> -	if (!vaddr) {
> -		dev_err(qproc->dev, "unable to map memory region: %pa+%zx\n", &phys, size);
> -		ret = -EBUSY;
> -		goto free_dma_attrs;
> -	}
> -
> -	memcpy(vaddr, metadata, size);
> -
> -	vunmap(vaddr);
> +	memcpy(ptr, metadata, size);
>  
>  	/* Hypervisor mapping to access metadata by modem */
>  	mdata_perm = BIT(QCOM_SCM_VMID_HLOS);
> @@ -1008,7 +982,7 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
>  			 "mdt buffer not reclaimed system may become unstable\n");
>  
>  free_dma_attrs:
> -	dma_free_attrs(qproc->dev, size, page, phys, dma_attrs);
> +	dma_free_attrs(qproc->dev, size, ptr, phys, dma_attrs);
>  	kfree(metadata);
>  
>  	return ret < 0 ? ret : 0;
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
