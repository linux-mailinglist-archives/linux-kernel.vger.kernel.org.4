Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8B36659F5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjAKLYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjAKLYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:24:20 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994FB17048
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:24:13 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id v3so10315200pgh.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4E7LXVeMTXBOr35S4gFhTPaaqu2rDKrbKMzVXIhGQao=;
        b=LD3ulaCuMTQsKiuagMew8X7Z9p6wuiNusp5U9mLqnGSfhmPt6Uh7gNKHAh4Jk+162Y
         YKxxJ1ASYRJCSniu0b7/Jt8XdA11yC3V0llKAAR2hB4NYK8z9MJE+oJrvMe0BafHTH3x
         wbmHZLBpAkEwkqXVXnr0Q/OnEU486IJJSnLnNE+BHiBAe5yDcDEatU7OtpWsdcHnsKnf
         OJfg+TMwAcWKNGqxdQ8/kZSf9qUIRHYvOGFfON7VgPIDn1RbK8gABFIyGf9wLWdRp7Nf
         jBITO+NHG+qX/MlMPU9HbAUt1iIZt5pypDn6fzXonWbt/zv0TSDq8254o3AkCCTb52er
         lb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4E7LXVeMTXBOr35S4gFhTPaaqu2rDKrbKMzVXIhGQao=;
        b=eebh/mdu6sdrXe2RJk+Vl2GVgQ+YQAyX9l3BLoLo26GYA3Zrlg0Yt7ooRdatDRngWT
         VXtkZm+VBpYhbDT2QXZqlE435xF9k7X9iHnCnL1N4pXbuftr2n1JFjjam9GTIKM8cNvz
         B0f9U0/xRJldIEOmrm5sdKRJ/v0SNHcXUMFz5fQM1eSG12A3+zYPVfpOk/j8ZUKMUaIV
         m3/kJAzqKhkruFltwmzhZplTBY/lm3/G2Z9ctsducO5Av9+6HHITAZcHXeO7SHEJzvg3
         7nSJbdUf3JQEoy8oniMrNyiIWtiFxnCyzxGwI+KQw5x0CdhhBn7nhjikSiMucjWIpxzC
         3DEQ==
X-Gm-Message-State: AFqh2krlTmp8LJFRy67d6lq4dTiH9gewEHbgqLe5+j19sy1hjWPvmm4I
        U09AHpqTsIQu7MchY/F1gCTJ
X-Google-Smtp-Source: AMrXdXumpb0lRMGhQmyoqCMCAtV9YiuVEbpsjqP2P4ZKSfNlM0jL174iQC00vUui/+RTFggHIHMfKg==
X-Received: by 2002:a05:6a00:1382:b0:586:a3a9:6163 with SMTP id t2-20020a056a00138200b00586a3a96163mr19309301pfg.28.1673436253083;
        Wed, 11 Jan 2023 03:24:13 -0800 (PST)
Received: from thinkpad ([117.217.177.1])
        by smtp.gmail.com with ESMTPSA id p128-20020a625b86000000b00580d25a2bb2sm5236085pfb.108.2023.01.11.03.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 03:24:12 -0800 (PST)
Date:   Wed, 11 Jan 2023 16:54:03 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, robin.murphy@arm.com, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        amit.pundir@linaro.org, regressions@leemhuis.info,
        sumit.semwal@linaro.org, will@kernel.org, catalin.marinas@arm.com,
        hch@lst.de
Subject: Re: [PATCH V2 05/11] remoteproc: qcom_q6v5_mss: revert "map/unmap
 metadata region before/after use"
Message-ID: <20230111112403.GB4873@thinkpad>
References: <20230109034843.23759-1-quic_sibis@quicinc.com>
 <20230109034843.23759-6-quic_sibis@quicinc.com>
 <20230109081832.GA4966@thinkpad>
 <92a32081-a521-33c7-72bd-fb8cb307c5bc@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92a32081-a521-33c7-72bd-fb8cb307c5bc@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 03:30:22PM +0530, Sibi Sankar wrote:
> Hey Mani,
> Thanks for taking time to review the series.
> 
> On 1/9/23 13:48, Manivannan Sadhasivam wrote:
> > + Christoph
> > 
> > Hi Sibi,
> > 
> > On Mon, Jan 09, 2023 at 09:18:37AM +0530, Sibi Sankar wrote:
> > > This reverts commit fc156629b23a21181e473e60341e3a78af25a1d4.
> > > 
> > > The memory region allocated using dma_alloc_attr with no kernel mapping
> > > attribute set would still be a part of the linear kernel map. Hence as a
> > > precursor to using reserved memory for modem metadata region, revert back
> > > to the simpler way of dynamic memory allocation.
> > > 
> > > Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> > 
> > Christoph already submitted a patch that reverts fc156629b23a:
> > https://lore.kernel.org/linux-arm-msm/20221223092703.61927-2-hch@lst.de/
> 
> Having ^^ revert as part of the this series makes more sense. I'll
> just replace my patch with ^^ in the next re-spin.
> 

That makes sense to me.

Thanks,
Mani

> > 
> > Thanks,
> > Mani
> > 
> > > ---
> > >   drivers/remoteproc/qcom_q6v5_mss.c | 38 +++++-------------------------
> > >   1 file changed, 6 insertions(+), 32 deletions(-)
> > > 
> > > diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> > > index 2f4027664a0e..e2f765f87ec9 100644
> > > --- a/drivers/remoteproc/qcom_q6v5_mss.c
> > > +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> > > @@ -10,7 +10,6 @@
> > >   #include <linux/clk.h>
> > >   #include <linux/delay.h>
> > >   #include <linux/devcoredump.h>
> > > -#include <linux/dma-map-ops.h>
> > >   #include <linux/dma-mapping.h>
> > >   #include <linux/interrupt.h>
> > >   #include <linux/kernel.h>
> > > @@ -961,52 +960,27 @@ static void q6v5proc_halt_axi_port(struct q6v5 *qproc,
> > >   static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
> > >   				const char *fw_name)
> > >   {
> > > -	unsigned long dma_attrs = DMA_ATTR_FORCE_CONTIGUOUS | DMA_ATTR_NO_KERNEL_MAPPING;
> > > -	unsigned long flags = VM_DMA_COHERENT | VM_FLUSH_RESET_PERMS;
> > > -	struct page **pages;
> > > -	struct page *page;
> > > +	unsigned long dma_attrs = DMA_ATTR_FORCE_CONTIGUOUS;
> > >   	dma_addr_t phys;
> > >   	void *metadata;
> > >   	int mdata_perm;
> > >   	int xferop_ret;
> > >   	size_t size;
> > > -	void *vaddr;
> > > -	int count;
> > > +	void *ptr;
> > >   	int ret;
> > > -	int i;
> > >   	metadata = qcom_mdt_read_metadata(fw, &size, fw_name, qproc->dev);
> > >   	if (IS_ERR(metadata))
> > >   		return PTR_ERR(metadata);
> > > -	page = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
> > > -	if (!page) {
> > > +	ptr = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
> > > +	if (!ptr) {
> > >   		kfree(metadata);
> > >   		dev_err(qproc->dev, "failed to allocate mdt buffer\n");
> > >   		return -ENOMEM;
> > >   	}
> > > -	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> > > -	pages = kmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
> > > -	if (!pages) {
> > > -		ret = -ENOMEM;
> > > -		goto free_dma_attrs;
> > > -	}
> > > -
> > > -	for (i = 0; i < count; i++)
> > > -		pages[i] = nth_page(page, i);
> > > -
> > > -	vaddr = vmap(pages, count, flags, pgprot_dmacoherent(PAGE_KERNEL));
> > > -	kfree(pages);
> > > -	if (!vaddr) {
> > > -		dev_err(qproc->dev, "unable to map memory region: %pa+%zx\n", &phys, size);
> > > -		ret = -EBUSY;
> > > -		goto free_dma_attrs;
> > > -	}
> > > -
> > > -	memcpy(vaddr, metadata, size);
> > > -
> > > -	vunmap(vaddr);
> > > +	memcpy(ptr, metadata, size);
> > >   	/* Hypervisor mapping to access metadata by modem */
> > >   	mdata_perm = BIT(QCOM_SCM_VMID_HLOS);
> > > @@ -1036,7 +1010,7 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
> > >   			 "mdt buffer not reclaimed system may become unstable\n");
> > >   free_dma_attrs:
> > > -	dma_free_attrs(qproc->dev, size, page, phys, dma_attrs);
> > > +	dma_free_attrs(qproc->dev, size, ptr, phys, dma_attrs);
> > >   	kfree(metadata);
> > >   	return ret < 0 ? ret : 0;
> > > -- 
> > > 2.17.1
> > > 
> > 

-- 
மணிவண்ணன் சதாசிவம்
