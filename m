Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534D361FD97
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbiKGSav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbiKGSat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:30:49 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC78F1A046
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 10:30:48 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id k7so11839839pll.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 10:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eOgVsIAsrne2RGr05kp3qZLB8zxsQRZ1bdjAelDdoHY=;
        b=K744o80UvSD2QHtY98/IvJEitqOtWQg+H0OuAvIlpmM7D9VK0aQrl8OMyItoinxi5e
         MHABQNT0asHUfLdnr0QiZy7vWPgMGjC+NNY0p3EO+nOFZdEntIOpOj55JDIViLMeBXJ5
         5T0cqUD7Ox+4dB/5Wv2UrVwpcQuNSJIc5g+T/4TNmNCX2mYlHV8vFINTcW3nDC3U0MK6
         bGgqSBtl2L/YtIwCXW1Z16aIYBZxpA4DcYUcLjjaPXScg3USaZ03/iX/iuCu98040NUZ
         5K22snT6lnEcREoInNeAQB4Y6ifjwdDhLjJlPTZX8T2Fcd503LEaT/nXVFiOtGbQrHJh
         MyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOgVsIAsrne2RGr05kp3qZLB8zxsQRZ1bdjAelDdoHY=;
        b=wk+UaJWCHHVYGLJX2iPZg5pomQz/krv+X479vxKXYUi7Rnt9krDtyUFAWKEL/K0Vpc
         t8YePsYMKc2yGuTAKwwbtJOc8XrdjZ+vnfd19Z1Ps/q+jNGj0Xr7BeQiF9BVqU6x4Sej
         oqbDFPzS1MtkmiMfZ/BMG0jNomxHDycWJLc2KJdwSjcFTyYZkaL7d6XUZLVumrCSUKbf
         o5CFJBkaT9c0suc5ZNMzxZ3WRQSc61plEj9iuPW+2kTRVx8oXn/H6EHWbsOK+p5MK9rJ
         5ylwzeAw2cULDtxtk9bPij4bwbk0kB1Rr2ATQdp77pXRcq7kRN5ik1Hgc65P+gvQ5sBT
         uO3A==
X-Gm-Message-State: ACrzQf3+O0y24bvgV87ISfyoF5RD0RWlqv9rsVKBcvKFzu/hO2MUeQBu
        +fbQ3DKRChtXfrvEqZCoMooNlg==
X-Google-Smtp-Source: AMsMyM5TCWfGrWZyWLKvedu2XldfcYy10WsNCUL7xcXO5xYqi31L5tAz/Zo5Y5slL7GJXF8IfQ0oSw==
X-Received: by 2002:a17:902:834c:b0:187:49e0:fd4d with SMTP id z12-20020a170902834c00b0018749e0fd4dmr29535678pln.81.1667845848256;
        Mon, 07 Nov 2022 10:30:48 -0800 (PST)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id o8-20020aa79788000000b0056c003f9169sm4822056pfp.196.2022.11.07.10.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:30:47 -0800 (PST)
Date:   Mon, 7 Nov 2022 10:30:44 -0800
From:   David Matlack <dmatlack@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, vkuznets@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] KVM: selftests: Move hypercall() to hyper.h
Message-ID: <Y2lO1HQtaMBCGpcZ@google.com>
References: <20221105045704.2315186-1-vipinsh@google.com>
 <20221105045704.2315186-6-vipinsh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221105045704.2315186-6-vipinsh@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 09:57:03PM -0700, Vipin Sharma wrote:
> hypercall() can be used by other hyperv tests, move it to hyperv.h.
> 
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> ---
>  .../selftests/kvm/include/x86_64/hyperv.h       | 17 +++++++++++++++++
>  .../selftests/kvm/x86_64/hyperv_features.c      | 17 -----------------
>  2 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86_64/hyperv.h b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
> index 9d8c325af1d9..87d8d9e444f7 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/hyperv.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/hyperv.h
> @@ -199,4 +199,21 @@ static inline uint64_t hv_linux_guest_id(void)
>  	       ((uint64_t)LINUX_VERSION_CODE << 16);
>  }
>  
> +static inline uint8_t hypercall(u64 control, vm_vaddr_t input_address,
> +				vm_vaddr_t output_address, uint64_t *hv_status)
> +{
> +	uint8_t vector;
> +
> +	/* Note both the hypercall and the "asm safe" clobber r9-r11. */
> +	asm volatile("mov %[output_address], %%r8\n\t"
> +		     KVM_ASM_SAFE("vmcall")
> +		     : "=a" (*hv_status),
> +		       "+c" (control), "+d" (input_address),
> +		       KVM_ASM_SAFE_OUTPUTS(vector)
> +		     : [output_address] "r"(output_address),
> +		       "a" (-EFAULT)
> +		     : "cc", "memory", "r8", KVM_ASM_SAFE_CLOBBERS);
> +	return vector;
> +}

Since this function is Hyper-V specific it probably makes sense to
rename it to hyperv_hypercall() as part of moving it to library, e.g. to
differentiate it from kvm_hypercall().

> +
>  #endif /* !SELFTEST_KVM_HYPERV_H */
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_features.c b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
> index b5a42cf1ad9d..31b22ee07dfb 100644
> --- a/tools/testing/selftests/kvm/x86_64/hyperv_features.c
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
> @@ -13,23 +13,6 @@
>  #include "processor.h"
>  #include "hyperv.h"
>  
> -static inline uint8_t hypercall(u64 control, vm_vaddr_t input_address,
> -				vm_vaddr_t output_address, uint64_t *hv_status)
> -{
> -	uint8_t vector;
> -
> -	/* Note both the hypercall and the "asm safe" clobber r9-r11. */
> -	asm volatile("mov %[output_address], %%r8\n\t"
> -		     KVM_ASM_SAFE("vmcall")
> -		     : "=a" (*hv_status),
> -		       "+c" (control), "+d" (input_address),
> -		       KVM_ASM_SAFE_OUTPUTS(vector)
> -		     : [output_address] "r"(output_address),
> -		       "a" (-EFAULT)
> -		     : "cc", "memory", "r8", KVM_ASM_SAFE_CLOBBERS);
> -	return vector;
> -}
> -
>  struct msr_data {
>  	uint32_t idx;
>  	bool available;
> -- 
> 2.38.1.273.g43a17bfeac-goog
> 
