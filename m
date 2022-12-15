Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF24B64DDDC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 16:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiLOPeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 10:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiLOPd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 10:33:58 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9F327936
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 07:33:57 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso3152878pjt.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 07:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oy98eREJ/U08Ijl7nb4a4sr3FJDv3ahMiFs+yTIRwyI=;
        b=Mf9dxrCd6+/PMgzE3s7B4l27HdANlE/bJp9sooJz4AdKA8nSHD+uztdexBXL7UWrOP
         a65Y5iU74zojj+edTgqcepO93YEw6AYVGKASOlABYPZ4bV56LMiJQ/NKqb6uMtYEwX/v
         7+kLDjCPMG3RKAcr9JEh2tKPhjGEQXFnQZiijc8sViu6E+yoIUs79b0x9GB76jYdz8Mn
         1tKRYtDm9CG9i0or+S73JGLR+XhZLbOHhwIiuBXQqG2WXC5r8KnbEdmmKp9ZZ7yiPIJp
         CNLm5kHPKJFdaQDHylQrCzHfm9oqFWYRu8wwwAOiKgbfiUVbOMNQB21i61+kKqrjckFY
         6zhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oy98eREJ/U08Ijl7nb4a4sr3FJDv3ahMiFs+yTIRwyI=;
        b=gKChjoJs5bgPVD3JRzXneVb9FBw6BNOIac6toRq3m/qIPnuaercbF/oHKBHdnSyEx5
         lzOofM+gtv+9HYBvlZgBk6Dt5XaCGueV4EXfelGmdH5w5CnHXxts+ZmwUn1Scj7rnlNz
         ElGElbNzeY06uXOEiV3yNs+adENjdkluQb6KTrj5OZR56ow5LkMRPBGvRl9dbtnqZcbt
         7dp6R/13KVS4D4ZifeNF1Sk7RjpKduHoKYjua19ZXJo2b9rTd72rhnJ3MuoWG5ZqA+Ic
         7G/Jb/P+wtvACw02xH51ExM728+zOaG0SfXiyt+QIo9K3u4R8qK6P9cNWZvWXgopneng
         pjSw==
X-Gm-Message-State: ANoB5pnxweQf0Phcwe2xf3qHt0TCLP4uWHtDp+Q6FH2nPGMgrmcToBOI
        w35O/Wa5ltnxICz1nM4WMyiJXg==
X-Google-Smtp-Source: AA0mqf5KODDCvZ+aTJxkTD/kZbAZbzu4afb2pnxx0S6C9GpDTpjhZd7JDbhoGi6S29YagehPHmPedw==
X-Received: by 2002:a05:6a20:4925:b0:ac:6543:d65d with SMTP id ft37-20020a056a20492500b000ac6543d65dmr34962768pzb.24.1671118437319;
        Thu, 15 Dec 2022 07:33:57 -0800 (PST)
Received: from ?IPV6:2602:47:d48c:8101:a80f:54a1:edc3:6cb4? ([2602:47:d48c:8101:a80f:54a1:edc3:6cb4])
        by smtp.gmail.com with ESMTPSA id p15-20020a654bcf000000b00478fd9bb6c7sm1714007pgr.75.2022.12.15.07.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 07:33:56 -0800 (PST)
Message-ID: <24a1a812-95a9-ed97-abd1-c0ff259726d2@linaro.org>
Date:   Thu, 15 Dec 2022 07:33:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: RISCV Vector unit disabled by default for new task (was Re:
 [PATCH v12 17/17] riscv: prctl to enable vector commands)
Content-Language: en-US
To:     Florian Weimer <fweimer@redhat.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Darius Rad <darius@bluespec.com>,
        Vineet Gupta <vineetg@rivosinc.com>,
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
From:   Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87h6xwdf5g.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/22 04:28, Florian Weimer via Libc-alpha wrote:
> * Björn Töpel:
> 
>>> For SVE, it is in fact disabled by default in the kernel.  When a thread
>>> executes the first SVE instruction, it will cause an exception, the kernel
>>> will allocate memory for SVE state and enable TIF_SVE.  Further use of SVE
>>> instructions will proceed without exceptions.  Although SVE is disabled by
>>> default, it is enabled automatically.  Since this is done automatically
>>> during an exception handler, there is no opportunity for memory allocation
>>> errors to be reported, as there are in the AMX case.
>>
>> Glibc has an SVE optimized memcpy, right? Doesn't that mean that pretty
>> much all processes on an SVE capable system will enable SVE (lazily)? If
>> so, that's close to "enabled by default" (unless SVE is disabled system
>> wide).
> 
> Yes, see sysdeps/aarch64/multiarch/memcpy.c:
> 
>    static inline __typeof (__redirect_memcpy) *
>    select_memcpy_ifunc (void)
>    {
>      INIT_ARCH ();
>    
>      if (sve && HAVE_AARCH64_SVE_ASM)
>        {
>          if (IS_A64FX (midr))
>            return __memcpy_a64fx;
>          return __memcpy_sve;
>        }
>    
>      if (IS_THUNDERX (midr))
>        return __memcpy_thunderx;
>    
>      if (IS_THUNDERX2 (midr) || IS_THUNDERX2PA (midr))
>        return __memcpy_thunderx2;
>    
>      if (IS_FALKOR (midr) || IS_PHECDA (midr))
>        return __memcpy_falkor;
>    
>      return __memcpy_generic;
>    }
>    
> And the __memcpy_sve implementation actually uses SVE.
> 
> If there were a prctl to select the vector width and enable the vector
> extension, we'd have to pick a width in glibc anyway.

There *is* a prctl to adjust the SVE vector width, but glibc does not need to select 
because SVE dynamically adjusts to the currently enabled width.  The kernel selects a 
default width that fits within the default signal frame size.

The other thing of note for SVE is that, with the default function ABI all of the SVE 
state is call-clobbered, which allows the kernel to drop instead of save state across 
system calls.  (There is a separate vector function call ABI when SVE types are used.)

So while strcpy may enable SVE for the thread, the next syscall may disable it again.


r~
