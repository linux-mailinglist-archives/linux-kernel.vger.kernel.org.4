Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C979666231
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 18:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjAKRmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 12:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbjAKRll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 12:41:41 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCF52AF4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:40:38 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d15so17532059pls.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 09:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KpkaVTQGXazamk/VxjWqp4ydb0LD0blsaD+1AXj4yEY=;
        b=MjIMA5Ai8yWDh5T4BrRO6rExGL4rJ7QVwUKkkXRN6G2QrfhUCZP/KCPkE54+hFTu2/
         xPxq49fXLlszJ2KPOzI29AYUVeQNaomwOe6GjiKd5bevhEB55kHUhLyyo9j1bzvCmMF/
         vAa73q5kY5CZ7lthIYeYQufj/c4d6QGrFrQrl4EtknbCioz7uwXrbeAjtpkA84A0E+e4
         ctmS0BzLb2bXekbHNuHo/Q6oPT5rxbtM08mh8BH1Abxf6SrK+brSljPr73p6kPRJwZBu
         DFbV2LMTjjMJD8tR5iCIEM+smmc3HSWIOQkXB1kBxdKqW01vsOBMJq23xYDOeR4nVEhF
         1BLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KpkaVTQGXazamk/VxjWqp4ydb0LD0blsaD+1AXj4yEY=;
        b=dW4uvBEwagWCpR27KlrIy93ctN5EXEF9z9YWO20b87wAlpzcDXSxitpsTYBH/nW8p/
         EJClnv89qDhJkY20nir/1AtTjssal/kq9cEWSS+L+tHizqL6JvKCKhgUO4uTX3e9Qe9N
         LxxlpTWWJtc58meYVjCm4gVqAnOS2ad+xQBAkMDsBv1N7E+HJX0XkJ+K2uhBDSKSDY3J
         xoAkzc5wjk1vy+ejaTW1m/Gj9Yw3MnPpFXv1K+VGBg+yzqXwMM+84vKoxwWf7YbsRjsu
         M2zNysEKvjVBG1WDcrDLh0NzPDMtFbh80Ru1gExNctZGEOC8+4oIFR6k43ZiSjidbjMe
         pZPQ==
X-Gm-Message-State: AFqh2kpQL6aiJO8vsXf4slEv76+gv4tMqJW2kBGHzIuZSy/7tzneW/Ix
        WD4uOeQM8qR0T2LUojpx+bX3
X-Google-Smtp-Source: AMrXdXs+856ScIt9zQEEdg5PRmzDH9Y23S1wO2tLMxfcc3V2SMzAdwVZ8eM26ECcWBh/scrfTHzCfA==
X-Received: by 2002:a05:6a21:70cb:b0:ad:ceba:1bdc with SMTP id xd11-20020a056a2170cb00b000adceba1bdcmr78229590pzb.16.1673458838288;
        Wed, 11 Jan 2023 09:40:38 -0800 (PST)
Received: from thinkpad ([117.217.177.1])
        by smtp.gmail.com with ESMTPSA id d21-20020a630e15000000b0047781f8ac17sm8703105pgl.77.2023.01.11.09.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 09:40:37 -0800 (PST)
Date:   Wed, 11 Jan 2023 23:10:29 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, konrad.dybcio@somainline.org,
        amit.pundir@linaro.org, regressions@leemhuis.info,
        sumit.semwal@linaro.org, will@kernel.org, catalin.marinas@arm.com,
        robin.murphy@arm.com
Subject: Re: [PATCH V3 05/10] remoteproc: qcom_q6v5_mss: Use a carveout to
 authenticate modem headers
Message-ID: <20230111174029.GE4873@thinkpad>
References: <20230111114337.24782-1-quic_sibis@quicinc.com>
 <20230111114337.24782-6-quic_sibis@quicinc.com>
 <20230111115422.GD4873@thinkpad>
 <d714a068-ee48-2a86-4d54-173312d9720e@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d714a068-ee48-2a86-4d54-173312d9720e@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 05:58:49PM +0530, Sibi Sankar wrote:
> Hey Mani,
> 
> Thanks for taking time to review the series.
> 
> On 1/11/23 17:24, Manivannan Sadhasivam wrote:
> > On Wed, Jan 11, 2023 at 05:13:32PM +0530, Sibi Sankar wrote:
> > > Any access to the dynamically allocated metadata region by the application
> > > processor after assigning it to the remote Q6 will result in a XPU
> > > violation. Fix this by replacing the dynamically allocated memory region
> > > with a no-map carveout and unmap the modem metadata memory region before
> > > passing control to the remote Q6.
> > > 
> > > Reported-and-tested-by: Amit Pundir <amit.pundir@linaro.org>
> > > Fixes: 6c5a9dc2481b ("remoteproc: qcom: Make secure world call for mem ownership switch")
> > > Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> > 
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > > ---
> > > 
> > > v3:
> > >   * Drop revert no_kernel_mapping since it's already on the list [Mani]
> > 
> > I thought you are going to include Christoph's patch into your series. That way
> > all the patches will be in the same series, makig life easier for Bjorn.
> > 
> 
> Since there were multiple patches in Christoph's original series, I
> decided I'll just drop the revert and have it depends on instead.
> 

There is only one patch in that series and that was independent of the
remoteproc change. So, it should be fine to include the revert patch to this
series.

Thanks,
Mani

> 
> > Thanks,
> > Mani
> > 
> > >   * kfree metadata from the branch for parity
> > > 
> > >   drivers/remoteproc/qcom_q6v5_mss.c | 48 ++++++++++++++++++++++++++----
> > >   1 file changed, 42 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> > > index e2f765f87ec9..e25d44e20ae7 100644
> > > --- a/drivers/remoteproc/qcom_q6v5_mss.c
> > > +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> > > @@ -215,6 +215,7 @@ struct q6v5 {
> > >   	size_t mba_size;
> > >   	size_t dp_size;
> > > +	phys_addr_t mdata_phys;
> > >   	phys_addr_t mpss_phys;
> > >   	phys_addr_t mpss_reloc;
> > >   	size_t mpss_size;
> > > @@ -973,15 +974,29 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
> > >   	if (IS_ERR(metadata))
> > >   		return PTR_ERR(metadata);
> > > -	ptr = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
> > > -	if (!ptr) {
> > > -		kfree(metadata);
> > > -		dev_err(qproc->dev, "failed to allocate mdt buffer\n");
> > > -		return -ENOMEM;
> > > +	if (qproc->mdata_phys) {
> > > +		phys = qproc->mdata_phys;
> > > +		ptr = memremap(qproc->mdata_phys, size, MEMREMAP_WC);
> > > +		if (!ptr) {
> > > +			kfree(metadata);
> > > +			dev_err(qproc->dev, "unable to map memory region: %pa+%zx\n",
> > > +				&qproc->mdata_phys, size);
> > > +			return -EBUSY;
> > > +		}
> > > +	} else {
> > > +		ptr = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
> > > +		if (!ptr) {
> > > +			kfree(metadata);
> > > +			dev_err(qproc->dev, "failed to allocate mdt buffer\n");
> > > +			return -ENOMEM;
> > > +		}
> > >   	}
> > >   	memcpy(ptr, metadata, size);
> > > +	if (qproc->mdata_phys)
> > > +		memunmap(ptr);
> > > +
> > >   	/* Hypervisor mapping to access metadata by modem */
> > >   	mdata_perm = BIT(QCOM_SCM_VMID_HLOS);
> > >   	ret = q6v5_xfer_mem_ownership(qproc, &mdata_perm, false, true,
> > > @@ -1010,7 +1025,8 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
> > >   			 "mdt buffer not reclaimed system may become unstable\n");
> > >   free_dma_attrs:
> > > -	dma_free_attrs(qproc->dev, size, ptr, phys, dma_attrs);
> > > +	if (!qproc->mdata_phys)
> > > +		dma_free_attrs(qproc->dev, size, ptr, phys, dma_attrs);
> > >   	kfree(metadata);
> > >   	return ret < 0 ? ret : 0;
> > > @@ -1893,6 +1909,26 @@ static int q6v5_alloc_memory_region(struct q6v5 *qproc)
> > >   	qproc->mpss_phys = qproc->mpss_reloc = r.start;
> > >   	qproc->mpss_size = resource_size(&r);
> > > +	if (!child) {
> > > +		node = of_parse_phandle(qproc->dev->of_node, "memory-region", 2);
> > > +	} else {
> > > +		child = of_get_child_by_name(qproc->dev->of_node, "metadata");
> > > +		node = of_parse_phandle(child, "memory-region", 0);
> > > +		of_node_put(child);
> > > +	}
> > > +
> > > +	if (!node)
> > > +		return 0;
> > > +
> > > +	ret = of_address_to_resource(node, 0, &r);
> > > +	of_node_put(node);
> > > +	if (ret) {
> > > +		dev_err(qproc->dev, "unable to resolve metadata region\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	qproc->mdata_phys = r.start;
> > > +
> > >   	return 0;
> > >   }
> > > -- 
> > > 2.17.1
> > > 
> > 

-- 
மணிவண்ணன் சதாசிவம்
