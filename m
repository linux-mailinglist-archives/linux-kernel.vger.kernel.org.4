Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A1D6A2C0C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 23:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjBYWPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 17:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBYWPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 17:15:07 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623C415550
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 14:15:05 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c18so1993704wmr.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 14:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xJRxyhuvTDeSFMK8E3/75q1sBwOVODDjZi3weVBSKEo=;
        b=du/8zIIPZKGQHK+BRBIoCZRDgnRZP2ig9aNV+wHNK1YvWlSaX6EmUrmT8nHsA2i0Ek
         y4u0rZkHWpD+HuJE8wieg2TAQShLvjnixFnwl2ICcNOtsIDrlfOtpqWA1d8elmTxIF3G
         2x0jPwLU+Y/vyeJawuh4yxdw45B0SqR6YpetBgbQGJ9O75eu2yduRs4xVoNlj98qTjwt
         MWrSv8NLXSk0xqqQrWBU4c0fyvSFeJMzR7yVNssThQw4PMpLNeWlVM/TLrtLaRmAUgjj
         n0T6+LufJ0e14vtq2osnj5vAtiG5praGMf5AIM1WOgiZyff8q4Gj33vzvJqfHz2FxeRA
         kPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJRxyhuvTDeSFMK8E3/75q1sBwOVODDjZi3weVBSKEo=;
        b=SFjE7Vmygwai2VE5UHBkJ5Nzg15gemPuKZjkC+o/gYaXsdsTli4G1TvZ4SvKHgt4aH
         LGMmjkD4Jg+jVM6yP1Han30sExzinr6P5TcnXO71pQwB0Us84PtchWLZ2MLHQrSIDpRK
         otEZQd01uclSezskBoO/eCdoVQ9h+lfjPomMK8C6Ln4LWa44wt8hRkzMD9+7CcQkkUQG
         crR627TpXu1Xolg4bzBgBgYeaf2zm3sYWLkeJ1VAGoAVKTQvN0h/f4/jl3DtTTt5gBCl
         Tyv408rVSQAVVodKbPAeDbdwG7QZG7T0WyLzCHUJynBqouQGBQtpLlf/kodVE5n+wDMh
         VP/A==
X-Gm-Message-State: AO0yUKWngISTxkxtXX5TcEBVCEJeI+SBC+lBwJ3El67wACv0d72r4QrD
        LkFDT7rZGZUtd/kmzu6Q9I3FqQ==
X-Google-Smtp-Source: AK7set9gCL+Gh2bIm6Q28hokLfkbIZCR7Hm2V1TsRAMCAb21B7MVni03X13IhZW56kiAPkGe81cv6g==
X-Received: by 2002:a05:600c:2ed2:b0:3eb:38e6:f64f with SMTP id q18-20020a05600c2ed200b003eb38e6f64fmr1460489wmn.8.1677363303889;
        Sat, 25 Feb 2023 14:15:03 -0800 (PST)
Received: from ?IPV6:2a02:6b6a:b566:0:df7b:4668:3e23:d0c9? ([2a02:6b6a:b566:0:df7b:4668:3e23:d0c9])
        by smtp.gmail.com with ESMTPSA id a2-20020a05600c348200b003e8f0334db8sm7729039wmq.5.2023.02.25.14.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 14:15:03 -0800 (PST)
Message-ID: <d6d4096c-2373-aafc-ed17-e44e351e66e1@bytedance.com>
Date:   Sat, 25 Feb 2023 22:15:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [External] [PATCH v2 0/5] x86-64: Remove global variables from
 boot
Content-Language: en-US
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        Yuan Yao <yuan.yao@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
References: <20230224154235.277350-1-brgerst@gmail.com>
 <cfdb9c5a-4723-d920-511e-b57ae6c492f7@bytedance.com>
 <CAMzpN2hvPHWYOeyzfpRmk39XYwCrSJx0UyqxE48F1TjTNyoKAg@mail.gmail.com>
 <ca5788873c373249983ab6ac9ee173b12293641e.camel@infradead.org>
 <CAMzpN2ixYTKQaNoizkeNBrHQH_2SN9OMexnK9t3oVMDDCMwbOA@mail.gmail.com>
 <E940A2E7-6FAC-4E87-96DE-596BA3F505AF@infradead.org>
 <671dc8ad-2721-a3a3-7aa2-0e2558d5c953@bytedance.com>
 <1c64afc8769c222e27ee22a3758b6c32348949d0.camel@infradead.org>
From:   Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <1c64afc8769c222e27ee22a3758b6c32348949d0.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/02/2023 13:52, David Woodhouse wrote:
> On Sat, 2023-02-25 at 13:33 +0000, Usama Arif wrote:
>>
>> Yeah looks good! I am testing with the macro diff for tr_lock from
>> https://lore.kernel.org/all/05e27a7a-1faa-944e-2764-6ab4d620fb8f@bytedance.com/.
>> If it all works, happy for me to send out v12 with it?
> 
> I moved the macro definition up a little to put it between the .code16
> and the .align, pushed it out as a commit on top of the above branch.
> 
> We'll collapse it into the 'Support parallel startup' patch, yes?
> 

Yes, collapsed with "Support parallel startup of secondary CPUs" patch. 
I think Thomas' solution to dealing with suspend might be better? So I 
was thinking of sending v12 on top of v6.2 release with the following 
diff over your branch (merged in the right commit ofcourse):

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index defe76ee9e64..97a36d029b0e 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -205,6 +205,4 @@ extern unsigned int smpboot_control;
  #define STARTUP_APICID_CPUID_0B        0x80000000
  #define STARTUP_APICID_CPUID_01        0x40000000

-#define STARTUP_PARALLEL_MASK (STARTUP_APICID_CPUID_01 | 
STARTUP_APICID_CPUID_0B)
-
  #endif /* _ASM_X86_SMP_H */
diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 5dcf5ca15383..214dd4a79860 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -58,6 +58,7 @@ asmlinkage acpi_status __visible 
x86_acpi_enter_sleep_state(u8 state)
   */
  int x86_acpi_suspend_lowlevel(void)
  {
+       unsigned int __maybe_unused saved_smpboot_ctrl;
         struct wakeup_header *header =
                 (struct wakeup_header *) 
__va(real_mode_header->wakeup_header);

@@ -113,16 +114,11 @@ int x86_acpi_suspend_lowlevel(void)
  #else /* CONFIG_64BIT */
  #ifdef CONFIG_SMP
         current->thread.sp = (unsigned long)temp_stack + 
sizeof(temp_stack);
-       /*
-        * Ensure the CPU knows which one it is when it comes back, if
-        * it isn't in parallel mode and expected to work that out for
-        * itself.
-        */
-       if (!(smpboot_control & STARTUP_PARALLEL_MASK))
-               smpboot_control = smp_processor_id();
+       /* Force the startup into boot mode */
+       saved_smpboot_ctrl = xchg(&smpboot_control, 0);
  #endif
         initial_code = (unsigned long)wakeup_long64;
-       saved_magic = 0x123456789abcdef0L;
+       saved_magic = 0x123456789abcdef0L;
  #endif /* CONFIG_64BIT */

         /*
@@ -132,6 +128,9 @@ int x86_acpi_suspend_lowlevel(void)
         pause_graph_tracing();
         do_suspend_lowlevel();
         unpause_graph_tracing();
+
+       if (IS_ENABLED(CONFIG_64BIT) && IS_ENABLED(CONFIG_SMP))
+               smpboot_control = saved_smpboot_ctrl;
         return 0;
  }


>>> I can probably work out how to test the AMD SEV path; is there a
>>> way I can test the startup_64 MADT one?
>>
>> I guess the easiest way is to create a TDX VM on Sapphire Rapids which I
>> believe mostly Intel people have access to right now? Maybe we can post
>> v12 and someone from Intel could just quickly verify if it boots with
>> it? I have added Yuan from the other thread in here who pointed it out
>> initially.
> 
> Yeah, I should also be able to rustle up both SPR and SEV-SNP if I dig
> around at work a little.

Sounds good!
