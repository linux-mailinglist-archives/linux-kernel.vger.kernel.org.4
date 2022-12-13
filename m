Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4650064B945
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 17:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbiLMQHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 11:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbiLMQHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 11:07:33 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A323B20F49
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 08:07:31 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id o12so3865316pjo.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 08:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nYw4Wk/wT807/LgiPPGHkV8/oRES3dPfmE3Ij+E1SAo=;
        b=Xs/xsqkeq31qsNHywwgOOgSJX1yEBuermKIh1MbCQwT1W4Dl3GEpID73Teg8B6DOFL
         oLChZdH2BQrzoODEwB0TBC3dcJD1lltMvsOpJbxUgSdznEEjKQRlIbnxE8JJVb4C3wyQ
         HNRJalJ98EyBxebiasEruKBwih+z++EAW8A7aEw8wikzcuBvK0LZKkWEkNvsH8KcfwUI
         jDJ7s8igxveDoRvquxWuocHp7Ahi5hGJkHQXLckffjl3HfP6xVs/4uPa/5kbFc7SnFIL
         /WK4HGkHmbkINqfOD08hzk2pU+J+Iti54r1KGbhAIJm95S1LFiA8sz1ZUn33Q7mv5eKY
         l4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nYw4Wk/wT807/LgiPPGHkV8/oRES3dPfmE3Ij+E1SAo=;
        b=LKsdiC+XyEmkCsxTzca+nUaQ1ogll6/4SwlUQFD9b1D9Sx+OD52LQdI49GK9g3h/6j
         uH2yIXbizo8GBMRvYSwrB+HCsMTSMWwouEHoCgnIODSdQwaZpHFWGuQR9A0qLOZnkcf0
         cwHqUgVuMgr3Ezz4/IUPLFF9OzdN+F5aR2mCc83GiVH0IZgYaBrW/4aLkplmA56DFcd2
         9XF1HGobLTbD50153Kpds/pAdbSPQ4REqepRIAZyWWXVYPTOZI9eaEBobXC8+XcQuCqF
         4YylocAHb+PZ1jMwf3/5TgPWg9Jg5fh+Td32lFZC+7q1oHv8AcZS+83/z3pZooTDfYaT
         8Qlg==
X-Gm-Message-State: ANoB5pntQxV9PcqLrPejaW6cfTlioJSeYzs7u+y5Xqk6wen2e0rqRfOh
        f8vb5zm0n63Zc+a0uRpt5ZFt
X-Google-Smtp-Source: AA0mqf5lNgVAYbeR20LH33Pew7cxwbJr3xKNxnrgLTg/m5BvVaQK2XVV8mo5CNRr/eBmtnM38Z1IzA==
X-Received: by 2002:a17:90a:bb15:b0:20d:bd61:b531 with SMTP id u21-20020a17090abb1500b0020dbd61b531mr20764576pjr.37.1670947651041;
        Tue, 13 Dec 2022 08:07:31 -0800 (PST)
Received: from thinkpad ([27.111.75.5])
        by smtp.gmail.com with ESMTPSA id f4-20020a63dc44000000b004786c63c21esm7056939pgj.42.2022.12.13.08.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 08:07:29 -0800 (PST)
Date:   Tue, 13 Dec 2022 21:37:22 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, amit.pundir@linaro.org,
        regressions@leemhuis.info, sumit.semwal@linaro.org,
        will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH 4/4] remoteproc: qcom_q6v5_mss: Use a carveout to
 authenticate modem headers
Message-ID: <20221213160722.GC4862@thinkpad>
References: <20221213140724.8612-1-quic_sibis@quicinc.com>
 <20221213140724.8612-5-quic_sibis@quicinc.com>
 <741b64c2-0b09-6475-5736-d2cd3e33c34c@arm.com>
 <ba258979-0c65-4671-dd01-c1916c26e81b@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba258979-0c65-4671-dd01-c1916c26e81b@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 09:27:04PM +0530, Sibi Sankar wrote:
> Hey Robin,
> 
> Thanks for taking time to review the series.
> 
> On 12/13/22 20:37, Robin Murphy wrote:
> > On 2022-12-13 14:07, Sibi Sankar wrote:
> > > The memory region allocated using dma_alloc_attr with no kernel mapping
> > > attribute set would still be a part of the linear kernel map. Any access
> > > to this region by the application processor after assigning it to the
> > > remote Q6 will result in a XPU violation. Fix this by replacing the
> > > dynamically allocated memory region with a no-map carveout and unmap the
> > > modem metadata memory region before passing control to the remote Q6.
> > > 
> > > Reported-by: Amit Pundir <amit.pundir@linaro.org>
> > > Fixes: 6c5a9dc2481b ("remoteproc: qcom: Make secure world call for
> > > mem ownership switch")
> > > Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> > > ---
> > > 
> > > The addition of the carveout and memunmap is required only on SoCs that
> > > mandate memory protection before transferring control to Q6, hence the
> > > driver falls back to dynamic memory allocation in the absence of the
> > > modem metadata carveout.
> > 
> > The DMA_ATTR_NO_KERNEL_MAPPING stuff is still broken and pointless, so
> > I'd expect to see this solution replacing it, not being added alongside.
> > It's just silly to say pass the "I don't need a CPU mapping" flag, then
> > manually open-code the same CPU mapping you would have got if you
> > hadn't, in a way that only works at all when a cacheable alias exists
> > anyway.
> 
> only a subset of SoCs supported by the driver are affected by
> the bug i.e. on the others dma_alloc_attr would still work
> without problems. I can perhaps drop the NO_KERNEL_MAPPING along
> with the vmap/vunmap and simplify things for those SoCs.
> 

Or perhaps revert fc156629b23a?

Thanks,
Mani

> - Sibi
> 
> > 
> > Thanks,
> > Robin.
> > 
> > >   drivers/remoteproc/qcom_q6v5_mss.c | 85 +++++++++++++++++++++---------
> > >   1 file changed, 61 insertions(+), 24 deletions(-)
> > > 
> > > diff --git a/drivers/remoteproc/qcom_q6v5_mss.c
> > > b/drivers/remoteproc/qcom_q6v5_mss.c
> > > index fddb63cffee0..8264275ecbd0 100644
> > > --- a/drivers/remoteproc/qcom_q6v5_mss.c
> > > +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> > > @@ -211,6 +211,7 @@ struct q6v5 {
> > >       size_t mba_size;
> > >       size_t dp_size;
> > > +    phys_addr_t mdata_phys;
> > >       phys_addr_t mpss_phys;
> > >       phys_addr_t mpss_reloc;
> > >       size_t mpss_size;
> > > @@ -935,6 +936,7 @@ static int q6v5_mpss_init_image(struct q6v5
> > > *qproc, const struct firmware *fw,
> > >   {
> > >       unsigned long dma_attrs = DMA_ATTR_FORCE_CONTIGUOUS |
> > > DMA_ATTR_NO_KERNEL_MAPPING;
> > >       unsigned long flags = VM_DMA_COHERENT | VM_FLUSH_RESET_PERMS;
> > > +    void *mdata_region;
> > >       struct page **pages;
> > >       struct page *page;
> > >       dma_addr_t phys;
> > > @@ -951,34 +953,48 @@ static int q6v5_mpss_init_image(struct q6v5
> > > *qproc, const struct firmware *fw,
> > >       if (IS_ERR(metadata))
> > >           return PTR_ERR(metadata);
> > > -    page = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL,
> > > dma_attrs);
> > > -    if (!page) {
> > > -        kfree(metadata);
> > > -        dev_err(qproc->dev, "failed to allocate mdt buffer\n");
> > > -        return -ENOMEM;
> > > -    }
> > > +    if (qproc->mdata_phys) {
> > > +        mdata_region = memremap(qproc->mdata_phys, size, MEMREMAP_WC);
> > > +        if (!mdata_region) {
> > > +            dev_err(qproc->dev, "unable to map memory region:
> > > %pa+%zx\n",
> > > +                &qproc->mdata_phys, size);
> > > +            ret = -EBUSY;
> > > +            goto free_dma_attrs;
> > > +        }
> > > -    count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> > > -    pages = kmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
> > > -    if (!pages) {
> > > -        ret = -ENOMEM;
> > > -        goto free_dma_attrs;
> > > -    }
> > > +        memcpy(mdata_region, metadata, size);
> > > +        memunmap(mdata_region);
> > > +        phys = qproc->mdata_phys;
> > > +    } else {
> > > +        page = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL,
> > > dma_attrs);
> > > +        if (!page) {
> > > +            kfree(metadata);
> > > +            dev_err(qproc->dev, "failed to allocate mdt buffer\n");
> > > +            return -ENOMEM;
> > > +        }
> > > -    for (i = 0; i < count; i++)
> > > -        pages[i] = nth_page(page, i);
> > > +        count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> > > +        pages = kmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
> > > +        if (!pages) {
> > > +            ret = -ENOMEM;
> > > +            goto free_dma_attrs;
> > > +        }
> > > -    vaddr = vmap(pages, count, flags, pgprot_dmacoherent(PAGE_KERNEL));
> > > -    kfree(pages);
> > > -    if (!vaddr) {
> > > -        dev_err(qproc->dev, "unable to map memory region:
> > > %pa+%zx\n", &phys, size);
> > > -        ret = -EBUSY;
> > > -        goto free_dma_attrs;
> > > -    }
> > > +        for (i = 0; i < count; i++)
> > > +            pages[i] = nth_page(page, i);
> > > -    memcpy(vaddr, metadata, size);
> > > +        vaddr = vmap(pages, count, flags,
> > > pgprot_dmacoherent(PAGE_KERNEL));
> > > +        kfree(pages);
> > > +        if (!vaddr) {
> > > +            dev_err(qproc->dev, "unable to map memory region:
> > > %pa+%zx\n", &phys, size);
> > > +            ret = -EBUSY;
> > > +            goto free_dma_attrs;
> > > +        }
> > > -    vunmap(vaddr);
> > > +        memcpy(vaddr, metadata, size);
> > > +
> > > +        vunmap(vaddr);
> > > +    }
> > >       /* Hypervisor mapping to access metadata by modem */
> > >       mdata_perm = BIT(QCOM_SCM_VMID_HLOS);
> > > @@ -1008,7 +1024,8 @@ static int q6v5_mpss_init_image(struct q6v5
> > > *qproc, const struct firmware *fw,
> > >                "mdt buffer not reclaimed system may become unstable\n");
> > >   free_dma_attrs:
> > > -    dma_free_attrs(qproc->dev, size, page, phys, dma_attrs);
> > > +    if (!qproc->mdata_phys)
> > > +        dma_free_attrs(qproc->dev, size, page, phys, dma_attrs);
> > >       kfree(metadata);
> > >       return ret < 0 ? ret : 0;
> > > @@ -1882,6 +1899,26 @@ static int q6v5_alloc_memory_region(struct
> > > q6v5 *qproc)
> > >       qproc->mpss_phys = qproc->mpss_reloc = r.start;
> > >       qproc->mpss_size = resource_size(&r);
> > > +    if (!child) {
> > > +        node = of_parse_phandle(qproc->dev->of_node,
> > > "memory-region", 2);
> > > +    } else {
> > > +        child = of_get_child_by_name(qproc->dev->of_node, "metadata");
> > > +        node = of_parse_phandle(child, "memory-region", 0);
> > > +        of_node_put(child);
> > > +    }
> > > +
> > > +    if (!node)
> > > +        return 0;
> > > +
> > > +    ret = of_address_to_resource(node, 0, &r);
> > > +    of_node_put(node);
> > > +    if (ret) {
> > > +        dev_err(qproc->dev, "unable to resolve metadata region\n");
> > > +        return ret;
> > > +    }
> > > +
> > > +    qproc->mdata_phys = r.start;
> > > +
> > >       return 0;
> > >   }

-- 
மணிவண்ணன் சதாசிவம்
