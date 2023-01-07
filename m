Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4997660DA0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 11:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjAGKGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 05:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjAGKFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 05:05:41 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF423633D
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 02:04:08 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id o7-20020a17090a0a0700b00226c9b82c3aso4310954pjo.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 02:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zw6BsvygKslxqg3MypxyuP3j9g0Ez8wpeLBnZnP7RaY=;
        b=yOfm4z08isU1CoslU/CR12c38TGhErHafl4Z/OJJO7Cy3tfWM8Bk0hKLQCg2jXJdXw
         vDku9B04925e3IM8tUW5sJ+MfowBsAPIdKJhIKxafy50v+8jcf/ymC1y6knHRXvMGcpC
         fEkHoSbzTzM/JyobI92IjqyO62Ea2VBBkrxAHyxWEQVD0tI/ckN/yp7iHPi13DNrRN9X
         EMe6XJg7UeUj1yoVV3Ma7Qv5M0CPqsrqvkQ6dpDpJ8fDA7rg5Gsk41/zOz70MMufZlqP
         EDbUbc++4+gFLkXe7P16piwkjbbES969sP0Onv5D+0346Op7sfpeNooQIk5pv22qHsya
         v4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zw6BsvygKslxqg3MypxyuP3j9g0Ez8wpeLBnZnP7RaY=;
        b=50tZcxyy8ROv5oMCnYyu3qrlTArMKJByyJ3jy6UgInO6FnXKWtyvBkbUaDzPnn4F0C
         syZJjvbpU97DbFWPmcIrMGZ5jSh46eqmmG4qJA1U5gi+9hGWh9igdZk+SNPcsHoPsnNr
         EuAmvgoMKi78dK4WUie+GgA9/ihl2y9M8My6NNZpIQuMV0ENN0reIFz3Dkae9s45hZhS
         waLTFBix6c8YOKhQ46PNE6uuyxi4B0eOp6ScTW2OW9Qd4BdKou40TYhTif3MjvF/NHLs
         ovwfo8b2vNmYsb6z3n33t2/K39584fVN0M0ff8/uRC5SUIy5nXx+SuVysVqcYdNMxK10
         lAKA==
X-Gm-Message-State: AFqh2kqBCdmIGGHnMcBvt+WT0g5twolRPtO7tKB1tWAHtnfBqlWuqtvV
        J0B+Sc+cUf89X6E4ZmfyoUiMww==
X-Google-Smtp-Source: AMrXdXubTN7smSgkB5+tW+ExOoOiP2JvVjgBrNxVrgvFagyvNyg0KkfxY2vUL5WYJvibfECOU+3h8Q==
X-Received: by 2002:a05:6a20:9592:b0:ad:394e:ac95 with SMTP id iu18-20020a056a20959200b000ad394eac95mr84922700pzb.24.1673085848461;
        Sat, 07 Jan 2023 02:04:08 -0800 (PST)
Received: from ?IPV6:2400:4050:a840:1e00:d54:e521:8bac:7bed? ([2400:4050:a840:1e00:d54:e521:8bac:7bed])
        by smtp.gmail.com with ESMTPSA id p189-20020a625bc6000000b00580cc63dce8sm407558pfb.77.2023.01.07.02.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jan 2023 02:04:08 -0800 (PST)
Message-ID: <df1f5846-dcfe-5b60-bfe3-54d93698831d@daynix.com>
Date:   Sat, 7 Jan 2023 19:04:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5 7/7] KVM: arm64: Normalize cache configuration
Content-Language: en-US
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>
References: <20221230095452.181764-1-akihiko.odaki@daynix.com>
 <20221230095452.181764-8-akihiko.odaki@daynix.com>
 <Y7c3AZJhlxKcc7y2@google.com>
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Y7c3AZJhlxKcc7y2@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/01/06 5:45, Oliver Upton wrote:
> Hi Akihiko,
> 
> On Fri, Dec 30, 2022 at 06:54:52PM +0900, Akihiko Odaki wrote:
> 
> [...]
> 
>> @@ -417,6 +418,9 @@ struct kvm_vcpu_arch {
>>   		u64 last_steal;
>>   		gpa_t base;
>>   	} steal;
>> +
>> +	/* Per-vcpu CCSIDR override or NULL */
>> +	u32 *ccsidr;
> 
> I don't believe we need to store this per-vCPU. Of course, it is
> possible to userspace to observe heterogeneous cache topologies
> depending on what core the KVM_GET_ONE_REG ioctl is handled on.
> 
> WDYT about keeping track of this per-VM? The value should be whatever
> was last written by userspace. To avoid breaking userspace this would
> also need to allow mismatched writes (i.e. vCPU0 has a different
> configuration than vCPU1).
A user would expect KVM_SET_ONE_REG will be per-VM so semantically it 
should be per-VM. Also, it should be noted that this change is to allow 
migration from older kernels; an older kernel can set different values 
for CCSIDR if the host has heterogeneous cache though I think nobody 
with big.LITTLE system wants to migrate VMs.

If you care only practicality but semantics, probably you can just 
ignore writes to CCSIDR from the userspace. I don't think any guest will 
care even if CCSIDR values change after migration. Either way is fine 
for me.

> 
> [...]
> 
>> +static u8 get_min_cache_line_size(u32 csselr)
> 
> It would be nice to have a comment indicating that it returns
> Log2(line_size), not line size outright.
> 
>> +{
>> +	u64 ctr_el0;
>> +	int field;
>> +
>> +	ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
>> +	field = csselr & CSSELR_EL1_InD ? CTR_EL0_IminLine_SHIFT : CTR_EL0_DminLine_SHIFT;
>> +
>> +	return cpuid_feature_extract_unsigned_field(ctr_el0, field) - 2;
> 
> This probably deserves a comment describing that CTR_EL0 represents line
> size in units of words, not bytes. Furthermore, a subtle reminder on the
> log transformation being done here would help also.
> 
>> +}
>> +
>>   /* Which cache CCSIDR represents depends on CSSELR value. */
>> -static u32 get_ccsidr(u32 csselr)
>> +static u32 get_ccsidr(struct kvm_vcpu *vcpu, u32 csselr)
>>   {
>> -	u32 ccsidr;
>> +	if (vcpu->arch.ccsidr)
>> +		return vcpu->arch.ccsidr[csselr];
>>   
>> -	/* Make sure noone else changes CSSELR during this! */
>> -	local_irq_disable();
>> -	write_sysreg(csselr, csselr_el1);
>> -	isb();
>> -	ccsidr = read_sysreg(ccsidr_el1);
>> -	local_irq_enable();
>> +	/*
>> +	 * Fabricate a CCSIDR value as the overriding value does not exist.
>> +	 * The real CCSIDR value will not be used as it can vary by the
>> +	 * physical CPU which the vcpu currently resides in.
>> +	 *
>> +	 * The line size is determined with get_min_cache_line_size(), which
>> +	 * should be valid for all CPUs even if they have different cache
>> +	 * configuration.
>> +	 *
>> +	 * The associativity bits are cleared, meaning the geometry of all data
>> +	 * and unified caches (which are guaranteed to be PIPT and thus
>> +	 * non-aliasing) are 1 set and 1 way.
>> +	 * Guests should not be doing cache operations by set/way at all, and
>> +	 * for this reason, we trap them and attempt to infer the intent, so
>> +	 * that we can flush the entire guest's address space at the appropriate
>> +	 * time. The exposed geometry minimizes the number of the traps.
>> +	 * [If guests should attempt to infer aliasing properties from the
>> +	 * geometry (which is not permitted by the architecture), they would
>> +	 * only do so for virtually indexed caches.]
>> +	 *
>> +	 * We don't check if the cache level exists as it is allowed to return
>> +	 * an UNKNOWN value if not.
>> +	 */
>> +	return get_min_cache_line_size(csselr) << CCSIDR_EL1_LineSize_SHIFT;
> 
> I don't believe this is correct. The value of CCSIDR_EL1.LineSize is
> actually:
> 
>     Log2(Number of bytes in cache line) - 4 (from DDI0487I.a D17.2.26)
> 
> 
> With that, I'd expect the following instead:
> 
> 	line_size = get_min_cache_line_size(csselr);
> 	return FIELD_PREP(CCSIDR_EL1_LineSize_MASK, line_size - 4);
> 
> --
> Thanks,
> Oliver

I added a comment to get_min_cache_line_size() with v6. Hopefully it 
will clarify the intention.

Regards,
Akihiko Odaki
