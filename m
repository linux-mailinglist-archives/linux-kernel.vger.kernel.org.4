Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D126AF719
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 22:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjCGVBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 16:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCGVA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 16:00:58 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAAF9BE1B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 13:00:50 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p16so8637402wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 13:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678222849;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZiWKyCKsYgQsvAQyb2xD/X2o3aURk6fuaflgIR8iSQ4=;
        b=BMIYiSis2+aabp49ceTNPqBoCLm6q/4kyfwl5yGyHxTpOKhwh1tZih4+ol7WNnRLWr
         EckKpnJrl07beVzZuP1JODe40FDDJuQwWLD3bGoCS0Mm6uOHk9LF8an5koz7vJQrl/dO
         V9kmmPp+wAxxVHL2RdmXK8HgIzhXjZG5mWryMrkHebZZnG2r5TVxDcCrIHoRTUMdQPNs
         szKjTPDtEh16y33F6yqqK8uMHEPGwnofbSG0zVe2qC8JnEpWEW8atXVuHfCNqkEXsd8i
         JnV2eOKV3LdmBIxnE8QmuG7WdbcbSBBOubKXAEadcxODd3rL+4hL9LJVMlQHy//6uLQQ
         3blQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678222849;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiWKyCKsYgQsvAQyb2xD/X2o3aURk6fuaflgIR8iSQ4=;
        b=ltl0s5/zIlAxOqHcV7j7KeoTrpZyWDuHjGLtY7baL7krmC6JosO0fGzcidCVSybqLs
         P+ETVyZBJyIwndK5y9kraWMEtuhuwm4tOr+07JKmyfBg2398LYSrXXjCl4NCxBXcMg88
         oHyzXgOrtr5lSi6ZncmEd2CbyWc3miScKKXUJA3AUrL18Db8KzVrRLU6yBDPIYqiQYu5
         9iuJtTEcQzpB7gym349NZBFKJZcwKQiLJjUJSCbWJc0mNY3ZPqNOS9togXEKmUupVEl1
         7C1QGZQQo/1oJQw9s13tvHKnNnVf6qs0AnMONawcA2urXpRpxKoSRYAkUdfadkMWhelO
         UXsw==
X-Gm-Message-State: AO0yUKVcR5V6w/VK+019rPA2QzQmbSQXve0/CDWYXpJgSV5Ry9mQBkVo
        7e70NKZ5BLule3J/PO1PDPao4g==
X-Google-Smtp-Source: AK7set8+9/DumNsGhMPBhvbpwOv9d/L451f47xO9+A5TiXwFCw/MOvhQ6h6Bn/5f3TUFmMyC7xTX1Q==
X-Received: by 2002:a05:600c:1c96:b0:3eb:3300:1d13 with SMTP id k22-20020a05600c1c9600b003eb33001d13mr13894148wms.14.1678222848676;
        Tue, 07 Mar 2023 13:00:48 -0800 (PST)
Received: from ?IPV6:2a02:6b6a:b566:0:52ca:aea8:eb67:a912? ([2a02:6b6a:b566:0:52ca:aea8:eb67:a912])
        by smtp.gmail.com with ESMTPSA id he5-20020a05600c540500b003e2058a7109sm17692993wmb.14.2023.03.07.13.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 13:00:48 -0800 (PST)
Message-ID: <cb82069c-cd81-1799-91c7-dea79916ab1a@bytedance.com>
Date:   Tue, 7 Mar 2023 21:00:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [External] Re: [PATCH v13 00/11] Parallel CPU bringup for x86_64
Content-Language: en-US
To:     David Woodhouse <dwmw2@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>, tglx@linutronix.de,
        kim.phillips@amd.com, brgerst@gmail.com,
        "Rapan, Sabin" <sabrapan@amazon.com>
Cc:     piotrgorski@cachyos.org, oleksandr@natalenko.name,
        arjan@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        rcu@vger.kernel.org, mimoja@mimoja.de, hewenliang4@huawei.com,
        seanjc@google.com, pmenzel@molgen.mpg.de, fam.zheng@bytedance.com,
        punit.agrawal@bytedance.com, simon.evans@bytedance.com,
        liangma@liangbit.com
References: <20230302111227.2102545-1-usama.arif@bytedance.com>
 <faa0eb3bb8ba0326d501516a057ab46eaf1f3c05.camel@infradead.org>
 <effbb6e2-c5a1-af7f-830d-8d7088f57477@amd.com>
 <269ed38b5eed9c3a259c183d59d4f1eb5128f132.camel@infradead.org>
From:   Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <269ed38b5eed9c3a259c183d59d4f1eb5128f132.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 9d956571ecc1..d194c4ffeef8 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1510,6 +1510,71 @@ void __init smp_prepare_cpus_common(void)
>   	set_cpu_sibling_map(0);
>   }
>   
> +
> +/*
> + * We can do 64-bit AP bringup in parallel if the CPU reports its APIC
> + * ID in CPUID (either leaf 0x0B if we need the full APIC ID in X2APIC
> + * mode, or leaf 0x01 if 8 bits are sufficient). Otherwise it's too
> + * hard. And not for SEV-ES guests because they can't use CPUID that
> + * early.
> + */
> +static bool __init prepare_parallel_bringup(void)
> +{
> +	if (IS_ENABLED(CONFIG_X86_32) || boot_cpu_data.cpuid_level < 1)
> +		return false;
> +
> +	if (x2apic_mode) {
> +		unsigned int eax, ebx, ecx, edx;
> +
> +		if (boot_cpu_data.cpuid_level < 0xb)
> +			return false;
> +
> +		/*
> +		 * To support parallel bringup in x2apic mode, the AP will need
> +		 * to obtain its APIC ID from CPUID 0x0B, since CPUID 0x01 has
> +		 * only 8 bits. Check that it is present and seems correct.
> +		 */
> +		cpuid_count(0xb, 0, &eax, &ebx, &ecx, &edx);
> +
> +		/*
> +		 * AMD says that if executed with an umimplemented level in
> +		 * ECX, then it will return all zeroes in EAX. Intel says it
> +		 * will return zeroes in both EAX and EBX. Checking only EAX
> +		 * should be sufficient.
> +		 */
> +		if (!eax) {
> +			pr_info("Disabling parallel bringup because CPUID 0xb looks untrustworthy\n");
> +			return false;
> +		}
> +
> +		if (IS_ENABLED(AMD_MEM_ENCRYPT) && static_branch_unlikely(&sev_es_enable_key)) {
> +			pr_debug("Using SEV-ES CPUID 0xb for parallel CPU startup\n");
> +			smpboot_control = STARTUP_APICID_SEV_ES;
> +		} else if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT)) {
> +			/*
> +			 * Other forms of memory encryption need to implement a way of
> +			 * finding the APs' APIC IDs that early.
> +			 */
> +			return false;
> +		} else {
> +			pr_debug("Using CPUID 0xb for parallel CPU startup\n");
> +			smpboot_control = STARTUP_APICID_CPUID_0B;

I believe TDX guests with x2apic mode will end up here and enable 
parallel smp if Sean was correct in this 
(https://lore.kernel.org/all/Y91PoIfc2jdRv0WG@google.com/). i.e. "TDX 
guest state is also encrypted, but TDX doesn't return true 
CC_ATTR_GUEST_STATE_ENCRYPT.".

So I believe the above else if 
(cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT)) is not useful as thats 
set for just SEV-ES guests? which is covered in the if part.

Thanks,
Usama


> +		}
> +	} else {
> +		if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
> +			return false;
> +
> +		/* Without X2APIC, what's in CPUID 0x01 should suffice. */
> +		pr_debug("Using CPUID 0x1 for parallel CPU startup\n");
> +		smpboot_control = STARTUP_APICID_CPUID_01;
> +	}
> +
> +	cpuhp_setup_state_nocalls(CPUHP_BP_PARALLEL_DYN, "x86/cpu:kick",
> +				  native_cpu_kick, NULL);
> +
> +	return true;
> +}
> +
>   /*
>    * Prepare for SMP bootup.

