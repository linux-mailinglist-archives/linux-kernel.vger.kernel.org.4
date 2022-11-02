Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A821615D6D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiKBIOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKBIOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:14:42 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15971F9DD
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 01:14:38 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id t25so43223679ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 01:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D14YT3XLwuvaV8kqztxV7M3vETwAqi+zmM/96cR0AHc=;
        b=GpxpLcagq0joGePZScEoh0i3uH5ugjVvEjPoxt6kBCBuuyzlqo35cKCnfHJbdie61w
         5924bp2eq0lkMdv6rrVStc/1EDNUfXLLfHgyzrWuin2h2jlj4y0iYMtNajL4TmLzDdNs
         qH3BGDP7oIMrRmR4ievX+HdXwMyP9WjFo5MJtElo6QNB+baDZ1ZOxIBLHWQ/k3DKhnyC
         cqwwEIMjTqU7dz+O55o01joMEgDoWIbpj7ggH1OouJ/WJT6ZtBCwS9BmiyxqWwkSvWW2
         vcpFf4ICDsu+KcmJO0q9Wc+movMbILbPOvqFKyHIv6XByLlDdw4aOKUzACk+rlX6nORq
         RzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D14YT3XLwuvaV8kqztxV7M3vETwAqi+zmM/96cR0AHc=;
        b=sFJOAMeUglHb0CYTsNVABdlWYlLQgUPMTt5wJHMfd52imfTNdVwLuBt91jSh93Y7A0
         WWZEXknjrVEc6rSGR+9wPDBhnywpBcItqp2Ht4F3AR+In1l14yJjAGkHQIub2TsyJf/Q
         hFiFYEfYnppsUIIWVdAjEjyuuFAx5Te/yNF/GZoNt82LVSdvYTKiB+Kwgfe7XWKCrhZI
         eZ7A5bXCLLnsl6q4/NLxIgw6KhzaG4vZMBoTwM2/SPnypqRjta4VdlEqY2lYabXLBTMs
         d9B4ZgvOjPvF9KRE/n6hLfZEe71AzwhDFh9dUvZc+2QTGUQ4aAxL0ETyojqIxhAsFqBs
         ACqA==
X-Gm-Message-State: ACrzQf0rEMl48umShnTKXB4mFJyDM7uQjUzENXD6UPK+TU/oaBSFJ3kP
        1zuBlGMpKKLUERST2yPvUuT8FQ==
X-Google-Smtp-Source: AMsMyM4Hi9Yx2VNLrU6zltuTqYjap+HJCkqA9L0ASaNW32WvbmixRlXRCpjN14oizcYbeHci3HBLOw==
X-Received: by 2002:a17:907:1b24:b0:76d:7b9d:2f8b with SMTP id mp36-20020a1709071b2400b0076d7b9d2f8bmr22307335ejc.414.1667376877280;
        Wed, 02 Nov 2022 01:14:37 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-748-2a9a-a2a6-1362.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:748:2a9a:a2a6:1362])
        by smtp.gmail.com with ESMTPSA id w25-20020aa7d299000000b00463bc1ddc76sm1522773edq.28.2022.11.02.01.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 01:14:36 -0700 (PDT)
Date:   Wed, 2 Nov 2022 09:14:35 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Bo Liu <liubo03@inspur.com>
Cc:     anup@brainfault.org, atishp@atishpatra.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: KVM: use vma_lookup() instead of
 find_vma_intersection()
Message-ID: <20221102080749.dcp76ow2sfv5hhx3@kamzik>
References: <20221101053811.5884-1-liubo03@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101053811.5884-1-liubo03@inspur.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 01:38:11AM -0400, Bo Liu wrote:
> vma_lookup() finds the vma of a specific address with a cleaner interface
> and is more readable.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---
>  arch/riscv/kvm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 3620ecac2fa1..5942d10c9736 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -632,7 +632,7 @@ int kvm_riscv_gstage_map(struct kvm_vcpu *vcpu,
>  
>  	mmap_read_lock(current->mm);
>  
> -	vma = find_vma_intersection(current->mm, hva, hva + 1);
> +	vma = vma_lookup(current->mm, hva);
>  	if (unlikely(!vma)) {
>  		kvm_err("Failed to find VMA for hva 0x%lx\n", hva);
>  		mmap_read_unlock(current->mm);
> -- 
> 2.27.0
> 
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
