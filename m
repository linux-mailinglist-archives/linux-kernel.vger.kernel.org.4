Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2298F627C53
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbiKNLaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbiKNL35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:29:57 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E601266B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:29:41 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 130so10690119pfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vBETPaJHyzocIStNZA3XfRFN7+BKiuVhfugdBUV5gm8=;
        b=L+KDN2Q5Uk4aDBsQTOW5tWjZBjXJJ2wTXTQIgtV+4APaRoJIkxZtPcYpnub4DahZTx
         DhR0T+lzvEdxppO4bB/YLHSCAwlxRQWExF15i1If/zqfvxHfqRAilpBkYdFy24ILAhIU
         KEeWnhJdkpgnNYoVx3n+DC5tqB3ojoecuauugUny/PhjdjtnNE5O+8sG/NPbpFDkrH4b
         taXYkIBuPOMc9SYvuiOclrsfut0NkKCoZ7r0+rR0+nIgK5E+nkhhTKaJGF735r8zc6rD
         cdzcl4JvhzPcPj+sj9i8CW+JNiLHklRxt0Of3TJv1nFI5HXQDjrIgAbL7nkx5hjPhQHN
         SZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vBETPaJHyzocIStNZA3XfRFN7+BKiuVhfugdBUV5gm8=;
        b=Gc1XqIeZl+vkWH60CKsFm5GXOcKUapr5sOMJfBRhBM3kpf+Fka2j1Rv+RCW/q7Rd+g
         S81oKW/U3USps/f/1e11Z8Y64iF5N/Fka0SIsCkrcwoScsipqTogbOmyd4TAebz+H2Im
         r4k0wS0CqD79iDUdOfLeTiVOjLmuEz7z1dD57+ISgXes6ks5YbtNkr+x7Bij9RnxS/Tg
         106hTLepSBayZ4ean8u7h3Sc/mh5WukKB2Iy6eea+6e4mDAlH+Gc1n0SjTQeoVlZ9o9l
         XvaCeZVgWwvI3zsP1d8OHi33YK06ecuTzov2lErMayPMPytn8LIZd+vXG0T1SkIA3DId
         ON2w==
X-Gm-Message-State: ANoB5pmdueCEPvtVyisf28wHrQYxGbCOqUC+KlRGfQT8GFR2uHcoH9th
        eE1IlbjSEmOH6tQjQnG9YtG9kDGLT+Pb
X-Google-Smtp-Source: AA0mqf7nx//U/UsojXgnxUtDKs7dhMT6vYkpeXEky7IF7vO4Fa2jid90q/5RiZyw4vUtN7u11puPkA==
X-Received: by 2002:a63:54a:0:b0:46f:fc9c:eb5 with SMTP id 71-20020a63054a000000b0046ffc9c0eb5mr11097737pgf.521.1668425381040;
        Mon, 14 Nov 2022 03:29:41 -0800 (PST)
Received: from thinkpad ([117.248.0.54])
        by smtp.gmail.com with ESMTPSA id gk9-20020a17090b118900b00205db4ff6dfsm6245427pjb.46.2022.11.14.03.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 03:29:40 -0800 (PST)
Date:   Mon, 14 Nov 2022 16:59:35 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     robin.murphy@arm.com, amit.pundir@linaro.org, andersson@kernel.org,
        quic_sibis@quicinc.com, sumit.semwal@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "arm64: dma: Drop cache invalidation from
 arch_dma_prep_coherent()"
Message-ID: <20221114112935.GN3869@thinkpad>
References: <20221114110329.68413-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221114110329.68413-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 04:33:29PM +0530, Manivannan Sadhasivam wrote:
> This reverts commit c44094eee32f32f175aadc0efcac449d99b1bbf7.
> 
> As reported by Amit [1], dropping cache invalidation from
> arch_dma_prep_coherent() triggers a crash on the Qualcomm SM8250 platform

s/SM8250/SDM845/g

Sorry for the confusion.

Thanks,
Mani

> (most probably on other Qcom platforms too). The reason is, Qcom
> qcom_q6v5_mss driver copies the firmware metadata and shares it with modem
> for validation. The modem has a secure block (XPU) that will trigger a
> whole system crash if the shared memory is accessed by the CPU while modem
> is poking at it.
> 
> To avoid this issue, the qcom_q6v5_mss driver allocates a chunk of memory
> with no kernel mapping, vmap's it, copies the firmware metadata and
> unvmap's it. Finally the address is then shared with modem for metadata
> validation [2].
> 
> Now because of the removal of cache invalidation from
> arch_dma_prep_coherent(), there will be cache lines associated with this
> memory even after sharing with modem. So when the CPU accesses it, the XPU
> violation gets triggered.
> 
> So let's revert this commit to get remoteproc's working (thereby avoiding
> full system crash) on Qcom platforms.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/CAMi1Hd1VBCFhf7+EXWHQWcGy4k=tcyLa7RGiFdprtRnegSG0Mw@mail.gmail.com/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/remoteproc/qcom_q6v5_mss.c#n933
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> 
> Will, Catalin: Please share if you have any other suggestions to handle the
> resource sharing in the remoteproc driver that could avoid this revert.
> 
>  arch/arm64/mm/dma-mapping.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 3cb101e8cb29..7d7e9a046305 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -36,7 +36,7 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
>  {
>  	unsigned long start = (unsigned long)page_address(page);
>  
> -	dcache_clean_poc(start, start + size);
> +	dcache_clean_inval_poc(start, start + size);
>  }
>  
>  #ifdef CONFIG_IOMMU_DMA
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
