Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BF3660D6F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 10:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbjAGJyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 04:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjAGJxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 04:53:54 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF8F7FECA
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 01:53:34 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id 17so4293206pll.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 01:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZvpXpT1Ky1e5AYlFd/MAc5bKweGcXE3957nMDydsC48=;
        b=D95m4YQXS8WHfRC3jEEq7PHeAUm47ibQ9hLFdTpWAfsKicrq1c4eoEWt64dkl+HlZ/
         DimaYNWNHmj7Eqy67H0VHcCyHZWfazX9EMjd3mAtzYJee8uW75ZNKmaJf5aPfgTYBOvN
         ITZJuqIJ/LocP15/MBe+jupY7ApZ/GH5SkJdLmX6oa3pAUd2Rgpa+02Hn+IX52KR8fiW
         JjEd3nwhuj+cmwoQWPzLznkXXkcpYaMOR2n5JELfgPB7Cm6nc3asBM/QyJk40brNywqu
         OH05M6x730rLUKVuEiWAtE54j0KnQ0W9V2xtvCmRMWkWZEz0SFsUZiFYxikIJV6ePkRi
         2psA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvpXpT1Ky1e5AYlFd/MAc5bKweGcXE3957nMDydsC48=;
        b=mUbhLbVDNSi309oJx7+nbt5nnrp0RMvuqddhFVRCr3soYqIDmulbP42yPvp4AffY+Q
         rMMtYEhelz8HOR++0jjsqZkztpSLn1X8ydXFnT+1TOw1tPptN5A30dHbhlYMboJYSgJL
         +mHYnFDM9px/68abUnVYODnQ6AGOxnYp0C2t061TKtDIWvGB1QXalRW3ef4EGYDO2vJG
         s3M1vEDno3Vs5muaJrPrCoOvOqvWKRRQGhmBcVQ2lXZrfwhUKWHdQ2Sd7HuqtI6XcrYe
         NFOUwt8Ewe02pQtqo+F/cK/2m6z9wMdAPNDBgUq4ZdQD2jzCknvWMvALkNuuJdSkiHzy
         YDwQ==
X-Gm-Message-State: AFqh2kr3GX+0a0AhoRwG9qg6vTOFAJLddaLB55y9KIFcxMznscJGFPaK
        EQlNTDeZo+OtSCGUYDf0qyBr6jSWhuppZB4F
X-Google-Smtp-Source: AMrXdXv5SBuUSPC6/xJKA93nQCS9A3SD15xbEP57fF5p/kQgc/6pznyw9eQ6sulp/19xM9s9+7LjQw==
X-Received: by 2002:a17:90b:23c8:b0:226:db61:c8ae with SMTP id md8-20020a17090b23c800b00226db61c8aemr6318211pjb.20.1673085213573;
        Sat, 07 Jan 2023 01:53:33 -0800 (PST)
Received: from ?IPV6:2400:4050:a840:1e00:d54:e521:8bac:7bed? ([2400:4050:a840:1e00:d54:e521:8bac:7bed])
        by smtp.gmail.com with ESMTPSA id i7-20020a655b87000000b0049f476e9906sm2074487pgr.53.2023.01.07.01.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jan 2023 01:53:33 -0800 (PST)
Message-ID: <b47d77c6-0fb5-b11b-d98a-f85e1bbc5d38@daynix.com>
Date:   Sat, 7 Jan 2023 18:53:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5 6/7] KVM: arm64: Mask FEAT_CCIDX
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
 <20221230095452.181764-7-akihiko.odaki@daynix.com>
 <Y7dNihZMs4NSSw0v@google.com>
Content-Language: en-US
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Y7dNihZMs4NSSw0v@google.com>
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

On 2023/01/06 7:22, Oliver Upton wrote:
> On Fri, Dec 30, 2022 at 06:54:51PM +0900, Akihiko Odaki wrote:
>> The CCSIDR access handler masks the associativity bits according to the
>> bit layout for processors without FEAT_CCIDX. KVM also assumes CCSIDR is
>> 32-bit where it will be 64-bit if FEAT_CCIDX is enabled. Mask FEAT_CCIDX
>> so that these assumptions hold.
>>
>> Suggested-by: Marc Zyngier <maz@kernel.org>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> FYI, I'm an idiot and replied to v4 of this patch... Forwarding comments
> below:
> 
>> ---
>>   arch/arm64/kvm/sys_regs.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index f4a7c5abcbca..aeabf1f3370b 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -1124,6 +1124,12 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu, struct sys_reg_desc const *r
>>   						      ID_DFR0_PERFMON_SHIFT,
>>   						      kvm_vcpu_has_pmu(vcpu) ? ID_DFR0_PERFMON_8_4 : 0);
>>   		break;
>> +	case SYS_ID_AA64MMFR2_EL1:
>> +		val &= ~ID_AA64MMFR2_EL1_CCIDX_MASK;
>> +		break;
>> +	case SYS_ID_MMFR4_EL1:
>> +		val &= ~ARM64_FEATURE_MASK(ID_MMFR4_CCIDX);
>> +		break;
> 
> Not that it is necessarily worth addressing, but I wanted to point
> something out.
> 
> This change breaks migration from older kernels on implementations w/
> FEAT_CCIDX. There is most likely exactly 0 of those in the wild, but
> we need to be careful changing user-visible stuff like this.
> 
> --
> Thanks,
> Oliver

I also don't think whether FEAT_CCIDX is visible matters for any guest 
because the line size a guest would care is held in the same bits 
whether FEAT_CCIDX is implemented. But if it concerns you I can write a 
bit more code so that it won't mask CCIDX bit if it's set from the 
userspace.

Regards,
Akihiko Odaki
