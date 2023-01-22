Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48934677120
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 18:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjAVRgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 12:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjAVRgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 12:36:47 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FD82D56
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 09:36:46 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso9180918pjf.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 09:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L1k4meEZKAf66tXkdJ6J+WHVPbucWvBqpX+pVJTA9ys=;
        b=NwV1e5R86M8bWtBaV9Vpay6r6PfoafmwPNhyWdCu7Hu167lD7SHHy4jE4UAQww1HrJ
         AU9gXKGJCAc/mKWOWkxz4bO1TgXiJsa+J+3omqVKZ6xu2O04HKb5KDOVFlIN6XUTmF8M
         DeA+sSjnH97ke06KhesBtPVgt5+65aoWg8yB60uHPzmsXkjOdaJbBhTvoHNWp9YQbM/6
         tkznctEKHX6c1VXCmvWgnL31Yneg53whju87EmQ1C8iGH78hQkSj7r12uvhfZ3t4/dN5
         9iDJYiST+NwMCgcuOh2yajkhWZ/74RISH1rvbj79G3rw8jxhuR6WaWMxftD9QkogzKDv
         GlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L1k4meEZKAf66tXkdJ6J+WHVPbucWvBqpX+pVJTA9ys=;
        b=zR1+j2viKFGDXkgJ7NCnFroTWteWYWJwl98KnlBwM5NggzG4dSRflEFVYHdx8px25A
         pFC5yoMtq7SPSvsZC+8S2yoaoT3gAx4pRdsh/CJ6l4NvLihd7sSfNtMTCNdugzS331DW
         XnTVxhpG4sff9O/gtwH9Z+SM5z4zMwOSoHyPeH9uS9MgqVYpUHGthebydkht6EqJIg+U
         CguffKvNviZYRO4zI7yf4uVfXZlKt82mN+qcGRXeDZr3w6x1zMa3b/BMCkkU/oSTiwQU
         +qLDOG9uvZGZ+XKImKlu9aRfno48xMa3WaYYtFaUbdBnBoyJ3C9qk/GkFD7sx0SoYOCi
         b20w==
X-Gm-Message-State: AFqh2kqBHze3PS/0hOuC9NT3aAoI8RHyqDZHTzHD2HB9txdKqD0w5szA
        Gm9ou00bKGmCNeYv1WCxYR4=
X-Google-Smtp-Source: AMrXdXsYR9jO+MVSpwBqH1qbiNlY6WO5wHP4lSotgKN8fOpSdehAs7Zn12h8/hDF614Pfk1RDz4mew==
X-Received: by 2002:a17:902:c3cd:b0:193:3154:5c86 with SMTP id j13-20020a170902c3cd00b0019331545c86mr24991131plj.21.1674409005506;
        Sun, 22 Jan 2023 09:36:45 -0800 (PST)
Received: from ?IPV6:2400:4050:a840:1e00:4457:c267:5e09:481b? ([2400:4050:a840:1e00:4457:c267:5e09:481b])
        by smtp.gmail.com with ESMTPSA id cp19-20020a170902e79300b00177efb56475sm6787098plb.85.2023.01.22.09.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 09:36:44 -0800 (PST)
Message-ID: <0ac18497-8392-8ea3-05ee-7f2377a4374c@gmail.com>
Date:   Mon, 23 Jan 2023 02:36:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v7 7/7] KVM: arm64: Normalize cache configuration
Content-Language: en-US
To:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>
Cc:     Akihiko Odaki <akihiko.odaki@daynix.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>
References: <20230112023852.42012-1-akihiko.odaki@daynix.com>
 <20230112023852.42012-8-akihiko.odaki@daynix.com>
 <Y8meCFkrVXurXlTk@google.com> <86k01gm6ys.wl-maz@kernel.org>
 <Y8wru2IrgHtBIofM@google.com>
From:   Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <Y8wru2IrgHtBIofM@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/01/22 3:15, Oliver Upton wrote:
> Hey Marc,
> 
> On Sat, Jan 21, 2023 at 12:02:03PM +0000, Marc Zyngier wrote:
>> On Thu, 19 Jan 2023 19:46:16 +0000, Oliver Upton <oliver.upton@linux.dev> wrote:
>>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>>> index 459e6d358dab..b6228f7d1d8d 100644
>>> --- a/arch/arm64/kvm/sys_regs.c
>>> +++ b/arch/arm64/kvm/sys_regs.c
>>> @@ -148,17 +148,19 @@ static u32 get_ccsidr(struct kvm_vcpu *vcpu, u32 csselr)
>>>   
>>>   static int set_ccsidr(struct kvm_vcpu *vcpu, u32 csselr, u32 val)
>>>   {
>>> -	u8 line_size = FIELD_GET(CCSIDR_EL1_LineSize, val);
>>> +	u8 line_size = SYS_FIELD_GET(CCSIDR_EL1, LineSize, val);
>>> +	u32 cur = get_ccsidr(vcpu, csselr);
>>> +	u8 min_line_size = SYS_FIELD_GET(CCSIDR_EL1, LineSize, cur);
>>>   	u32 *ccsidr = vcpu->arch.ccsidr;
>>>   	u32 i;
>>>   
>>> -	if ((val & CCSIDR_EL1_RES0) || line_size < get_min_cache_line_size(csselr))
>>> +	if (cur == val)
>>> +		return 0;
>>> +
>>> +	if ((val & CCSIDR_EL1_RES0) || line_size < min_line_size)
>>>   		return -EINVAL;
>>
>> This doesn't look right. You're comparing the value userspace is
>> trying to set for a given level with the value that is already set for
>> that level, and forbid the cache line size to be smaller. It works if
>> no value has been set yet (you fallback to something derived from
>> CTR_EL0), but this fails if userspace does multiple writes.
> 
> Good catch, I tried to skip over the unit/field conversions by doing this
> but it has the consequence of not working as expected for multiple writes.
> 
>> The original check is against CTR_EL0, which makes absolute sense
>> because we want to check across the whole hierarchy. It is just that
>> the original code has two bugs:
>>
>> - It fails to convert the CCSIDR_EL1.LineSize value to a number of
>>    words (the missing +4). Admire how the architecture is actively
>>    designed to be hostile to SW by providing two different formats for
>>    the cache line size, none of which is in... bytes.
>>
>> - It passes the full CSSELR value to get_min_cache_line_size(), while
>>    this function wants a bool... Yes, there are times where you'd want
>>    a stronger type system (did anyone say Rust? ;-)
> 
> Hey now, if you say it enough times people are going to start getting
> ideas ;-P
> 
>> I propose that we fold something like the patch below in instead
>> (tested with get-reg-list).
> 
> Agreed, I've backed out my diff and applied yours. Pushed (with force!)
> to my repo now, PTAL.
> 
> --
> Thanks,
> Oliver
> 

I was so careless that I missed two bugs and failed to test the last 
version of my patch. It is fortunate that the bugs were caught by 
careful review though we don't have a strong type system (yet). Your 
tree looks good to me.

Regards,
Akihiko Odaki
