Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C85862F301
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241647AbiKRKyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbiKRKyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:54:11 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB5A9151B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:54:10 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id 4so4270645pli.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E8RSHQUiWtqrJUmJKZ3NQU+slzxgKtl8fWqvswxEAig=;
        b=TwCxcwwrIrjpkHgMxhE/U+p3xiAIwt+7F+bKeMqNYnhQjSTgfWPHUWffPmS9Shu3+j
         vyc7gEZLbmv/UvlWlMcjDw0CiK8rm7SQ7ICesgdbPvY50k2/tkvSLGXYXB5IXfWDToy5
         kDDc5TC16s90kxyfCs4vSuMbVdycaqq6CZMA/Hntwv1AF2mPfZScRt5LrClXRRu+16gf
         xwc2NxeoavvRhug1N7WMkjCQmtCUlpY2b1p2ATs+RSmnYGiYWq4j6CT/iyXJdi3OYi4K
         A0ICm8hMxbFuVcs/G4p32bpvrwiGk2VXR0a7wCxPbjXEE9WrYhvg/nkXoJIKEOCME2lQ
         9I/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E8RSHQUiWtqrJUmJKZ3NQU+slzxgKtl8fWqvswxEAig=;
        b=7q9Y+A3JKEA589HJmetZhpONJEMDZn6KnEK6Am4fJzThxACMLUu3sc4u5bFEyZVh/c
         aDPkGitHhsFnYJuqChPtG+cjtnuaYTV9+2f5cdLzJOQARPHkDgEY0/YHE+cqk039KMLn
         9f9MLh/UT58rpql8eboh7aTY4+lZL2MBWMg88Q/V1/4WJms+4Q//G0jtlW0SUENMLjZv
         hYEqjjQuamPwpxln/BQvaVOLnzU3m6+Xu5cFIOhx0duNJQrjoV80WSC/7p/ZnCSSCpW+
         l9vxAc0lRZUgDiPaQG6sxF1WU9BCHOMHN2c2geIvU5TzSblYs71qaneg0ov19e9eCoLd
         QF+g==
X-Gm-Message-State: ANoB5pk87bT4MiT467nFzZJEBA9TtCoc7qEBHyhH7+l+zZ0shmmuUb9e
        79gQYF4IxGTPeSrilp+YpWbs
X-Google-Smtp-Source: AA0mqf5vM5vqRsguszUPOdk6wex4+LgwMUCIx5+aFiucCxNJhj5igtbl01S/J3oCdMWPp1lkpcAz0g==
X-Received: by 2002:a17:90a:710b:b0:218:725:c820 with SMTP id h11-20020a17090a710b00b002180725c820mr7249679pjk.170.1668768849828;
        Fri, 18 Nov 2022 02:54:09 -0800 (PST)
Received: from thinkpad ([59.92.102.90])
        by smtp.gmail.com with ESMTPSA id z5-20020a626505000000b0056c6c63fda6sm2844396pfb.3.2022.11.18.02.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 02:54:08 -0800 (PST)
Date:   Fri, 18 Nov 2022 16:24:02 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        amit.pundir@linaro.org, andersson@kernel.org,
        quic_sibis@quicinc.com, sumit.semwal@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "arm64: dma: Drop cache invalidation from
 arch_dma_prep_coherent()"
Message-ID: <20221118105402.GA184726@thinkpad>
References: <20221114110329.68413-1-manivannan.sadhasivam@linaro.org>
 <20221114141109.GG30263@willie-the-truck>
 <1659929b-1372-cea6-5840-c58369a4252d@arm.com>
 <Y3J8+O7Y3f3onH0P@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3J8+O7Y3f3onH0P@arm.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 05:38:00PM +0000, Catalin Marinas wrote:
> On Mon, Nov 14, 2022 at 03:14:21PM +0000, Robin Murphy wrote:
> > On 2022-11-14 14:11, Will Deacon wrote:
> > > On Mon, Nov 14, 2022 at 04:33:29PM +0530, Manivannan Sadhasivam wrote:
> > > > This reverts commit c44094eee32f32f175aadc0efcac449d99b1bbf7.
> > > > 
> > > > As reported by Amit [1], dropping cache invalidation from
> > > > arch_dma_prep_coherent() triggers a crash on the Qualcomm SM8250 platform
> > > > (most probably on other Qcom platforms too). The reason is, Qcom
> > > > qcom_q6v5_mss driver copies the firmware metadata and shares it with modem
> > > > for validation. The modem has a secure block (XPU) that will trigger a
> > > > whole system crash if the shared memory is accessed by the CPU while modem
> > > > is poking at it.
> > > > 
> > > > To avoid this issue, the qcom_q6v5_mss driver allocates a chunk of memory
> > > > with no kernel mapping, vmap's it, copies the firmware metadata and
> > > > unvmap's it. Finally the address is then shared with modem for metadata
> > > > validation [2].
> > > > 
> > > > Now because of the removal of cache invalidation from
> > > > arch_dma_prep_coherent(), there will be cache lines associated with this
> > > > memory even after sharing with modem. So when the CPU accesses it, the XPU
> > > > violation gets triggered.
> > > 
> > > This last past is a non-sequitur: the buffer is no longer mapped on the CPU
> > > side, so how would the CPU access it?
> > 
> > Right, for the previous change to have made a difference the offending part
> > of this buffer must be present in some cache somewhere *before* the DMA
> > buffer allocation completes.
> > 
> > Clearly that driver is completely broken though. If the DMA allocation came
> > from a no-map carveout vma_dma_alloc_from_dev_coherent() then the vmap()
> > shenanigans wouldn't work, so if it backed by struct pages then the whole
> > dance is still pointless because *a cacheable linear mapping exists*, and
> > it's just relying on the reduced chance that anything's going to re-fetch
> > the linear map address after those pages have been allocated, exactly as I
> > called out previously[1].
> 
> So I guess a DMA pool that's not mapped in the linear map, together with
> memremap() instead of vmap(), would work around the issue. But the
> driver needs fixing, not the arch code.
> 

Okay, thanks for the hint. Can you share how to allocate the dma-pool that's
not part of the kernel's linear map? I looked into it but couldn't find a way.

Thanks,
Mani

> -- 
> Catalin

-- 
மணிவண்ணன் சதாசிவம்
