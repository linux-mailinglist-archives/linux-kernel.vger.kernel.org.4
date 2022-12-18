Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B970C64FEC5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 12:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiLRLfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 06:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiLRLfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 06:35:20 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D628A6422
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 03:35:18 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so6435471pjd.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 03:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rty+gpqd+eA6AphifEAmmJ4M709v9JxSpj7F1QZvTIc=;
        b=rX1F2dWgXZwxuIDJaP6FADhEdITe6iLUWSgTYipr1uRJNKw7uwoOTxiZvmH5N4m2SF
         vwLh8iOkGzm1i0EJpfLfyK10qF2lfES2JC93yZliwxDFMUsA1qasbEHIUJppUrhwyxiX
         V1OEK/wWL6fLDtsMPy5vuoY6nv4UtQRi9EpZ1PCQaWGIQiaVpEiVPlW8ag8XpfrV58WG
         Dk8jBOQuJFSnHaK9DTGyqLY13fzpkO71ksuD53JkP7CCwiiQJPIU2b5+WSzUSKXLla6P
         zGgJCMicombA2/LP6pYJPuXeY/qsFTYfMpla0OvqwTcZ6WyZLI4e0PJVfMUl4HceKn5l
         57ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rty+gpqd+eA6AphifEAmmJ4M709v9JxSpj7F1QZvTIc=;
        b=qwSNdNNFcaJ4RfIeP0LJ1tzMAxhsCteXGWBLSXWly8DN9qfTBcDm0Oo/zfXDqWMUzT
         p8rconq709jy68VTpHbUlY5dG0diUu4ICydrETuZvGw6q+V25HiPrlUjSiw0RiYQ4OTC
         aypOmTtv2NBZsG8zos2Ct9zHSx33w9p4o04bIdx9WpLOmNcsf7Z6awN7uttVmlGdSTVn
         oU9Y8V3PgeIsImBY2KtE/PY9f+U6U+9G/qWiiZaCg4M/OyGSwzzibW2xvvSis4MF0wJ9
         mSpgwpxURSztWe9QSO905wk0SpjCmdZJaxk2yETMZsPw6vEaZf2cyh4kFIzs0A6q42qz
         62Aw==
X-Gm-Message-State: ANoB5plaTj/RL7dR7eRqd/FGhgIwGclTYNXViwn6GU07eEQqdMGqxWPt
        PY7P6JOJieijzuS62c7oQt3zPg==
X-Google-Smtp-Source: AA0mqf74k04nAvEcKiP5y4JIHLcCk6t+UInE5HPcz0u12pjKwMJYmzyuAUgg9V5xtJ6hJ6Zw9pRPnw==
X-Received: by 2002:a17:90a:20e:b0:213:18f3:68d1 with SMTP id c14-20020a17090a020e00b0021318f368d1mr40701969pjc.29.1671363318359;
        Sun, 18 Dec 2022 03:35:18 -0800 (PST)
Received: from ?IPV6:2400:4050:c360:8200:8ae8:3c4:c0da:7419? ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id s92-20020a17090a2f6500b002191873187dsm7562502pjd.33.2022.12.18.03.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Dec 2022 03:35:17 -0800 (PST)
Message-ID: <1ef32b0c-6cee-75f7-e1e0-ede1f5b9a016@daynix.com>
Date:   Sun, 18 Dec 2022 20:35:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 1/7] arm64/sysreg: Convert CCSIDR_EL1 to automatic
 generation
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>
References: <20221218051412.384657-1-akihiko.odaki@daynix.com>
 <20221218051412.384657-2-akihiko.odaki@daynix.com>
 <87cz8hez0i.wl-maz@kernel.org>
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87cz8hez0i.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/18 20:23, Marc Zyngier wrote:
> On Sun, 18 Dec 2022 05:14:06 +0000,
> Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> Convert CCSIDR_EL1 to automatic generation as per DDI0487I.a. The field
>> definition is for case when FEAT_CCIDX is not implemented. Fields WT,
>> WB, RA and WA are defined as per A.j since they are now reserved and
>> may have UNKNOWN values in I.a, which the file format cannot represent.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   arch/arm64/include/asm/sysreg.h |  1 -
>>   arch/arm64/tools/sysreg         | 11 +++++++++++
>>   2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
>> index 7d301700d1a9..910e960661d3 100644
>> --- a/arch/arm64/include/asm/sysreg.h
>> +++ b/arch/arm64/include/asm/sysreg.h
>> @@ -425,7 +425,6 @@
>>   
>>   #define SYS_CNTKCTL_EL1			sys_reg(3, 0, 14, 1, 0)
>>   
>> -#define SYS_CCSIDR_EL1			sys_reg(3, 1, 0, 0, 0)
>>   #define SYS_AIDR_EL1			sys_reg(3, 1, 0, 0, 7)
>>   
>>   #define SYS_RNDR_EL0			sys_reg(3, 3, 2, 4, 0)
>> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
>> index 384757a7eda9..acc79b5ccf92 100644
>> --- a/arch/arm64/tools/sysreg
>> +++ b/arch/arm64/tools/sysreg
>> @@ -871,6 +871,17 @@ Sysreg	SCXTNUM_EL1	3	0	13	0	7
>>   Field	63:0	SoftwareContextNumber
>>   EndSysreg
>>   
>> +Sysreg	CCSIDR_EL1	3	1	0	0	0
>> +Res0	63:32
>> +Field	31:31	WT
>> +Field	30:30	WB
>> +Field	29:29	RA
>> +Field	28:28	WA
> 
> For fields described as a single bit, the tool supports simply
> indicating the bit number (28 rather than 28:28).
> 
> However, I strongly recommend against describing fields that have been
> dropped from the architecture.  This only happens when these fields
> are never used by any implementation, so describing them is at best
> useless.

arch/arm64/tools/gen-sysreg.awk does not allow a hole and requires all 
bits are described hence these descriptions. If you have an alternative 
idea I'd like to hear.

> 
>> +Field	27:13	NumSets
>> +Field	12:3	Associavity
>> +Field	2:0	LineSize
>> +EndSysreg
>> +
> 
> I don't think we have a good solution for overlapping fields that
> depend on other factors, either contextual (such as a mode that
> changes the layout of a sysreg), or architecture warts such as
> FEAT_CCIDX (which changes the layout of a well-known sysreg).
> 
> At least, put a comment here that indicates the context of the
> description.

Sounds good. I'll do so with the next version.

Regards,
Akihiko Odaki

> 
> Thanks,
> 
> 	M.
> 
