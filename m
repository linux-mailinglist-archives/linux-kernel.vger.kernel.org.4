Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBA06659F2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjAKLYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjAKLXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:23:37 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7752FB
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:23:35 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id m7-20020a17090a730700b00225ebb9cd01so19664565pjk.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 03:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NdOgn1yCYJAyY06Gupgzi8+hM+Xp+RpyK1OnwHdM6Og=;
        b=vy3Yu4DtcL96gccpDy/joOJ/lLj+h1IShOJMXAy1yh/hO/NvznzlkNUxewqnzk9VkW
         EMHlz6Rr6/ILIwne8BiEO8wFVCh49WEfMwvvYp/5XskhLwbN6wig2ngBuf58jE6EfgdZ
         rs++Kj55GRKD7q5G6x4vW8bPon5PkcE8yraczc8svUxhl4DlXy943PAOBRQ0XIeg64G9
         48l44Jvluszb6Wq4uEhvg63Ly3FFJIkbB2+toC1JWE2Fqx52HpthyXA3yYW/ohMoQXlv
         Zlu12NiFaRumyTHQTikCImxBRHtL2kxxL3JsmNbg9c8SY9ejUkTOOc/9aPScHxdIY0VY
         LHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NdOgn1yCYJAyY06Gupgzi8+hM+Xp+RpyK1OnwHdM6Og=;
        b=sVlHFE6lG26FdUoQZegEqnI6KHjgVJZXE52oEOOEaT1n7crBOP/p1ROQgNGgVVFL1U
         NB/rgDbBjDNS8D0T74xduBJhJSpyE6hNtAyn7wOkYCRaEMg6kIbJtpTjleyiLXnrkweG
         WkH6lBijw/YTS90KUj7OnoM+YOeHdXvVJcFz1zdENZNg9seWoQjmYb9RfszT5xYdnr9B
         oXWCksCcvspBEaKk2ubEx5jl1MV4ZPQSS0b84t8RZgMC+4TeCFuZKJUdOIJ8Wa1Y6xNZ
         E8GNk/gPOMUuMiRaW9mkxQ8yKiopUJyLYA3wdT5LU8vrI2yEj/oArhX7NSTLjxffBAI3
         64PQ==
X-Gm-Message-State: AFqh2krj5JQusysDMJeelJV9IqJkTJ5v4xa6XNLbgZ5RAjtVFOMuc4t+
        CnJ7aiLb5VTSGDQxzqQPfyAe
X-Google-Smtp-Source: AMrXdXsjMOamYa8/f02u2xtM4J9oNufkjaCTGrGv0jSv1qMVhosBp/2ZhTx8Haic2yN1xI8jYctqfg==
X-Received: by 2002:a17:903:3286:b0:193:1952:5a45 with SMTP id jh6-20020a170903328600b0019319525a45mr5187962plb.19.1673436214834;
        Wed, 11 Jan 2023 03:23:34 -0800 (PST)
Received: from thinkpad ([117.217.177.1])
        by smtp.gmail.com with ESMTPSA id jg7-20020a17090326c700b0019324fbec59sm7633311plb.41.2023.01.11.03.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 03:23:33 -0800 (PST)
Date:   Wed, 11 Jan 2023 16:53:24 +0530
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
Message-ID: <20230111112324.GA4873@thinkpad>
References: <20230109034843.23759-1-quic_sibis@quicinc.com>
 <20230109034843.23759-7-quic_sibis@quicinc.com>
 <20230109083231.GB4966@thinkpad>
 <7552f8a1-9503-de7c-a6d4-46452ef78ece@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7552f8a1-9503-de7c-a6d4-46452ef78ece@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 03:35:31PM +0530, Sibi Sankar wrote:
> Hey Mani,
> 
> On 1/9/23 14:02, Manivannan Sadhasivam wrote:
> > On Mon, Jan 09, 2023 at 09:18:38AM +0530, Sibi Sankar wrote:
> > > Any access to the dynamically allocated metadata region by the application
> > > processor after assigning it to the remote Q6 will result in a XPU
> > > violation. Fix this by replacing the dynamically allocated memory region
> > > with a no-map carveout and unmap the modem metadata memory region before
> > > passing control to the remote Q6.
> > > 
> > > Reported-and-tested-by: Amit Pundir <amit.pundir@linaro.org>
> > > Fixes: 6c5a9dc2481b ("remoteproc: qcom: Make secure world call for mem ownership switch")
> > > Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> > > ---
> > > 
> > > v2:
> > >   * Revert no_kernel_mapping [Mani/Robin]
> > > 
> > >   drivers/remoteproc/qcom_q6v5_mss.c | 48 ++++++++++++++++++++++++++----
> > >   1 file changed, 42 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> > > index e2f765f87ec9..b7a158751cef 100644
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
> > > +			dev_err(qproc->dev, "unable to map memory region: %pa+%zx\n",
> > > +				&qproc->mdata_phys, size);
> > > +			ret = -EBUSY;
> > > +			goto free_dma_attrs;
> > 
> > There is no memory to free at this point.
> 
> we would just free the metadata in the no-map carveout scenario since
> mdata_phys wouldn't be NULL. I can do a kfree(metadata) directly from
> this branch and return as well if you think it makes things more
> readable.
> 

Oops, I missed that. But yeah it is confusing too with the current way of
freeing metadata. I'd suggest using a separate label instead.

Thanks,
Mani

> > 
> > Thanks,
> > Mani
> > 
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
