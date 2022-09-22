Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2212E5E6862
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 18:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbiIVQ3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 12:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiIVQ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 12:29:46 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E496DF87;
        Thu, 22 Sep 2022 09:29:44 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q9so9634827pgq.8;
        Thu, 22 Sep 2022 09:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=98S8pPs7rzJjS6NVmCTmxgW9Hvmjz5zZrdDMv06YzxY=;
        b=KYy99iDB9sA0qaPZysCNrqYfiMIi1b9a9T8V55/+StlgAxYwJ95rq5IPpos29HBlH+
         BZ/z+lLYGrAQqfyri4z2yz/K/c+Ij2e9jy0bn05m6+KJ+abkSCnQtpof+9rpc0RFSx79
         ijKI4jf2ISrxZBeqKBYVxvR+99KxhR8/kYsyAq+Tqktwjs7o954qAzMjYjJxx7gxVOen
         C1UvCRMZU2yiLam5n3gSvyz9iSBFMY2o3J5Q2LV/v5ja0puv14yNKHnIODK7A9oyLxQ0
         J/Xq+UY0g8Fwu3WHygsJU/p+NkXIVu2pPhBIHe42BTrugU9bgWLk1ZQYoE2/eh43bsTM
         7Yog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=98S8pPs7rzJjS6NVmCTmxgW9Hvmjz5zZrdDMv06YzxY=;
        b=7jdHyjL5Yi1Ze9LtwrX6o/f4vSaY9+dltOg1gHATv/Te8gIDSBdDnKDTWSt6+ybgRb
         Hf7JmoqHo7hX47a/6NzhKnUKve50wse4m17YLx69K/7GfpAX7+JcCa7+AQuCFzT93JIv
         wEPTXy2/czTsMYY9gse/3joZL+hXxbQxiOmkIHOeKSmYUD9nhk12wKOeq1oXPZJD+mL3
         4r7noVcFLtC04Tr4GxNHiE3vqUrk5CjwYdXxkfb5hrbLmNzArnFbSeQ9Bds4IMQtw0q9
         2zGjrC0gJ/SYGiAfIsSEECynWoVoABLhUpQF6tNGortNSLNw9WFtBFDXx0R/X7fwQ3Qn
         n+vg==
X-Gm-Message-State: ACrzQf1WnSRa5/f4d5zFCs/1p2aXA0RTgYYszkov/zGckqOagui/c7cX
        hKGd9cN6GnJGdMbyoFGbWU7ZDs3+ceGQtQ==
X-Google-Smtp-Source: AMsMyM5Lo7Us1zKpmxS5Mrt+HpCRm+LYfkDiHi2ILHUoF0ob4HmYoJNfS1jSWSk9rTwIdeBkLPcoGw==
X-Received: by 2002:a62:84c6:0:b0:538:3c39:5819 with SMTP id k189-20020a6284c6000000b005383c395819mr4371200pfd.4.1663864184029;
        Thu, 22 Sep 2022 09:29:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jg3-20020a17090326c300b0017315b11bb8sm4245398plb.213.2022.09.22.09.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 09:29:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <08906193-246b-c874-8bac-1d98d2313ac4@roeck-us.net>
Date:   Thu, 22 Sep 2022 09:29:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] x86/mm: Refuse W^X violations
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        keescook@chromium.org, Sean Christopherson <seanjc@google.com>
References: <YwySW3ROc21hN7g9@hirez.programming.kicks-ass.net>
 <20220921200726.GA3094503@roeck-us.net>
 <4dd594ad-490a-68ee-9e32-fbd9f135bd54@intel.com>
 <1a6e7165-cdae-6c8c-f57d-159fdb68897b@roeck-us.net>
 <d8cd7c7e-24c1-7f70-24a9-91c77aa634af@roeck-us.net>
 <YywS0keUorHwJJPt@hirez.programming.kicks-ass.net>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <YywS0keUorHwJJPt@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/22 00:46, Peter Zijlstra wrote:
> On Wed, Sep 21, 2022 at 08:09:13PM -0700, Guenter Roeck wrote:
> 
>> Oh well, that "helped" to hide one of the crashes. Here is another one.
>> This is with PAE enabled and booting through efi32.
> 
>> [    1.086592]  efi_runtime_update_mappings+0x36/0x42
>> [    1.086717]  efi_enter_virtual_mode+0x351/0x36e
>> [    1.086860]  start_kernel+0x57d/0x60f
>> [    1.086956]  ? set_intr_gate+0x42/0x55
>> [    1.087079]  i386_start_kernel+0x43/0x45
>> [    1.087272]  startup_32_smp+0x161/0x164
> 
> Does this help? Dave; perhaps we should just let i386 be i386 and let it
> bitrot :/
> 
> diff --git a/arch/x86/platform/efi/efi_32.c b/arch/x86/platform/efi/efi_32.c
> index e06a199423c0..d81e379fcd43 100644
> --- a/arch/x86/platform/efi/efi_32.c
> +++ b/arch/x86/platform/efi/efi_32.c
> @@ -136,6 +136,7 @@ void __init efi_runtime_update_mappings(void)
>   			if (md->type != EFI_RUNTIME_SERVICES_CODE)
>   				continue;
>   
> +			set_memory_ro(md->virt_addr, md->num_pages);
>   			set_memory_x(md->virt_addr, md->num_pages);
>   		}
>   	}

Yes, it does.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
