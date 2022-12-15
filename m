Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FC364E16D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiLOS5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiLOS5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:57:09 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE336159
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:57:08 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id l10so7818444plb.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y+47s1xAdNyBz4g1fVdzMecYrKvurW3RHPdAWqvqDsI=;
        b=jD+1Cj5gJs2Uf4HQEw1HYFmywinfjK/+FWmh1ciGaQZOyOKJ/Kg5SMANR0RiVLBVUD
         8RyUkf7pA+EUgU24as+SiX3bnUopfZg+G2Ix4/3ZgoChLbG5uT7LnQFDX8Ra6tZIdUv1
         nVkhiZ+Y1dN3PnvlSqB2XSsYfUbdbXlTv/VBF8vxdNoiEsGKTnAA2unN6J16A5eKkqB5
         DHuriSz24tabClN3QcjAHV6H5CJOJtffCAXR+dZmmG8XR6HrD3rMkwwfpkOkMVUhp5tr
         nK79TnDfdbX8WoUoX/uvzaExU7Aq9PoP0F3n8zJngj6jXEP6Bpnz45W/Yfjn+Hfv/OwK
         Xiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y+47s1xAdNyBz4g1fVdzMecYrKvurW3RHPdAWqvqDsI=;
        b=nLWVjSzRmdrXVa0keo9x41rOpIhKD6YO6+iMVKTYZDUdYWs4Y0vAUVs9Jc6mABUGgK
         2oYPPuIs5HAUO2QWrakx/Ylr7HoSitigHtVCdx3AIenEZiR+foD0whe6e47A1DTN8aZ8
         hxUIi5kGETUihprMGmXq7R29rm/OHzLcc+8LPW24OMhStLc2zj2czZoRhKompDnq0Fzn
         79AHBhqUk3vqtOB1XqdmOMBX81t3kb6smJUShnQYMX+aRkcXkp5/FcDvtJC+GPW+l/P7
         wk7rQ8J6BVC5GOa+BYflQvREfmKSAgj/zHto/RisX7CtgXuHM7o/sP8Vujw7Tw2CWejx
         0EqQ==
X-Gm-Message-State: ANoB5pnTNlgZjKEJP6XtRNKRkowvRumag1jkiHmrw67wMRtxkQuwTNZi
        EH96TDKolR4jw3pnbPnUZ19xjQ==
X-Google-Smtp-Source: AA0mqf6ELJjqFjBDGa6oMZGkw0/s5xWSyTm6RxKD01xa2PL7NTHARAmItfZLAU8xB3HuHPlat+DsUA==
X-Received: by 2002:a17:902:7e47:b0:18f:5bc0:5893 with SMTP id a7-20020a1709027e4700b0018f5bc05893mr22939101pln.0.1671130627861;
        Thu, 15 Dec 2022 10:57:07 -0800 (PST)
Received: from [192.168.50.116] (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id a3-20020a170902710300b0016d773aae60sm9595pll.19.2022.12.15.10.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 10:57:07 -0800 (PST)
Message-ID: <15d902d0-4492-f828-7147-164319d741f9@rivosinc.com>
Date:   Thu, 15 Dec 2022 10:57:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: RISCV Vector unit disabled by default for new task (was Re:
 [PATCH v12 17/17] riscv: prctl to enable vector commands)
Content-Language: en-US
To:     Richard Henderson <richard.henderson@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Darius Rad <darius@bluespec.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Waterman <andrew@sifive.com>, stillson@rivosinc.com,
        Paul Walmsley <paul.walmsley@sifive.com>, anup@brainfault.org,
        atishp@atishpatra.org, guoren@kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        greentime.hu@sifive.com, vincent.chen@sifive.com,
        andy.chiu@sifive.com, arnd@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        libc-alpha@sourceware.org, christoph.muellner@vrull.eu,
        Aaron Durbin <adurbin@rivosinc.com>, linux@rivosinc.com
References: <mhng-975b1d7b-7b3f-4e88-804c-8b22787f9588@palmer-ri-x1c9>
 <e9cf13a9-561a-3438-00f0-41fe2631888d@rivosinc.com>
 <Y5irn63DQkwumfvW@bruce.bluespec.com>
 <8fe9cfaf-2cbc-8de6-3928-067de9113bfc@rivosinc.com>
 <Y5qByfCtpV0uNID3@bruce.bluespec.com>
 <877cysx4yf.fsf@all.your.base.are.belong.to.us>
 <87h6xwdf5g.fsf@oldenburg.str.redhat.com>
 <24a1a812-95a9-ed97-abd1-c0ff259726d2@linaro.org>
From:   Vineet Gupta <vineetg@rivosinc.com>
In-Reply-To: <24a1a812-95a9-ed97-abd1-c0ff259726d2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/15/22 07:33, Richard Henderson wrote:
> On 12/15/22 04:28, Florian Weimer via Libc-alpha wrote:
>> * Björn Töpel:
>>
>>>> For SVE, it is in fact disabled by default in the kernel.  When a 
>>>> thread
>>>> executes the first SVE instruction, it will cause an exception, the 
>>>> kernel
>>>> will allocate memory for SVE state and enable TIF_SVE. Further use 
>>>> of SVE
>>>> instructions will proceed without exceptions.  Although SVE is 
>>>> disabled by
>>>> default, it is enabled automatically.  Since this is done 
>>>> automatically
>>>> during an exception handler, there is no opportunity for memory 
>>>> allocation
>>>> errors to be reported, as there are in the AMX case.
>>>
>>> Glibc has an SVE optimized memcpy, right? Doesn't that mean that pretty
>>> much all processes on an SVE capable system will enable SVE 
>>> (lazily)? If
>>> so, that's close to "enabled by default" (unless SVE is disabled system
>>> wide).
>>
>> Yes, see sysdeps/aarch64/multiarch/memcpy.c:
>>
>>    static inline __typeof (__redirect_memcpy) *
>>    select_memcpy_ifunc (void)
>>    {
>>      INIT_ARCH ();
>>         if (sve && HAVE_AARCH64_SVE_ASM)
>>        {
>>          if (IS_A64FX (midr))
>>            return __memcpy_a64fx;
>>          return __memcpy_sve;
>>        }
>>         if (IS_THUNDERX (midr))
>>        return __memcpy_thunderx;
>>         if (IS_THUNDERX2 (midr) || IS_THUNDERX2PA (midr))
>>        return __memcpy_thunderx2;
>>         if (IS_FALKOR (midr) || IS_PHECDA (midr))
>>        return __memcpy_falkor;
>>         return __memcpy_generic;
>>    }
>>    And the __memcpy_sve implementation actually uses SVE.
>>
>> If there were a prctl to select the vector width and enable the vector
>> extension, we'd have to pick a width in glibc anyway.
>
> There *is* a prctl to adjust the SVE vector width, but glibc does not 
> need to select because SVE dynamically adjusts to the currently 
> enabled width.  The kernel selects a default width that fits within 
> the default signal frame size.
>
> The other thing of note for SVE is that, with the default function ABI 
> all of the SVE state is call-clobbered, which allows the kernel to 
> drop instead of save state across system calls.  (There is a separate 
> vector function call ABI when SVE types are used.)

For the RV psABI, it is similar - all V regs are 
caller-saved/call-clobbered [1] and syscalls are not required to 
preserve V regs [2]
However last I checked ARM documentation the ABI doc seemed to suggest 
that some (parts) of the SVE regs are callee-saved [3]

>
> So while strcpy may enable SVE for the thread, the next syscall may 
> disable it again.

Next syscall could trash them, but will it disable SVE ? Despite 
syscall/function-call clobbers, using V in tight loops such as mem*/str* 
still is a win.


[1] 
https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/master/riscv-cc.adoc
[2] 
https://github.com/riscv/riscv-v-spec/blob/master/calling-convention.adoc
[3] 
https://github.com/ARM-software/abi-aa/blob/2982a9f3b512a5bfdc9e3fea5d3b298f9165c36b/aapcs64/aapcs64.rst#the-base-procedure-call-standard
Sec 6.1.3 ".... In other cases it need only preserve the low 64 bits of 
z8-z15"

