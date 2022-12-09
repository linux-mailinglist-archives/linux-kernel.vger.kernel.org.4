Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004F3648924
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 20:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiLITnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 14:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiLITmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 14:42:32 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B552B3D81
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 11:42:22 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so9177851pje.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 11:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sdh+OHaTkwVbiZvE0C8NICtGt7CceNsZBQVdmNDraAM=;
        b=mi2dqq6GAojBjnjxMAYvd2eyZXPZ6ibTL+Mdj/sIYNpN5+JdKNCKN9l9L+GunuBX3d
         VLn6bBU/ef3yiHdspi8tws4S2/bikyYzFz+HdbijHzRGPMJGpdrBnEtHXAn+e9rrM7e3
         8Uqd2CTKXuSlUQnWUaoC04caaX51zY+UfevVGPp8KjpEow4kHNwpj4pN32OT3+h3vfkQ
         07ppjedJ/KRWv70UlfBRa0BqRCW0Vx4fMTOd6I0Ijl3MvonkkKhaxyTLk3M2qxB5pyET
         U5x9GuRCCeKNZW7S+bsKC5c3vmRuuYGxUSKd8gpvD2ire1wttVXySKNkOxrI7qtTlaTp
         a/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sdh+OHaTkwVbiZvE0C8NICtGt7CceNsZBQVdmNDraAM=;
        b=dagJJFiVmqa9Kz8g3Rgkg55dBgQUBhdVH/P87a69JVdSUPML0lRwEPtfdK9SC36umW
         DM+eb34kZLp8df8mUXAEI0u5kqWaWU12HxZpIzEJAmQPKxz1m8DTeY9bdQmYHeNCWiZA
         P+yQyAq/0q3/3Fj4QNdkJ5dK3HOdtdcR3ukyVCEb8mY9sDauS2C9eo4sJix03oBHgAxN
         h1YjkAt4o6Kp4QsJY16AykUynXylgAZ9es8g8bQYsZb/Vo3VusyNOb8Xw8gdT/8R1Uq3
         yYhl7y4afBbgo9dD5MWTCpxoezQshQnIhqyU6gdOZkOyh1DSR9YKM5xq0gSKg7wptDx3
         3A0A==
X-Gm-Message-State: ANoB5plMwwmNZPIec1CRak0REn2g41qxWeTVZRCJkQr27xDr/VjmCzS0
        wKNILjq791ikV2MJJPWk200Qgg==
X-Google-Smtp-Source: AA0mqf782NfywRPZ4oBo31wo7Bm6p+cVkRrwutod9Oz1na+ghn4AyzEKqVxqf0Bh3kjU1my8lOyTZw==
X-Received: by 2002:a17:902:aa81:b0:186:61b3:d507 with SMTP id d1-20020a170902aa8100b0018661b3d507mr6661923plr.43.1670614941488;
        Fri, 09 Dec 2022 11:42:21 -0800 (PST)
Received: from [192.168.50.116] (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id w7-20020a170902e88700b00178aaf6247bsm1698631plg.21.2022.12.09.11.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 11:42:21 -0800 (PST)
Message-ID: <e9cf13a9-561a-3438-00f0-41fe2631888d@rivosinc.com>
Date:   Fri, 9 Dec 2022 11:42:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: RISCV Vector unit disabled by default for new task (was Re:
 [PATCH v12 17/17] riscv: prctl to enable vector commands)
Content-Language: en-US
To:     Palmer Dabbelt <palmer@dabbelt.com>, fweimer@redhat.com
Cc:     Andrew Waterman <andrew@sifive.com>, stillson@rivosinc.com,
        Paul Walmsley <paul.walmsley@sifive.com>, anup@brainfault.org,
        atishp@atishpatra.org, guoren@kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        greentime.hu@sifive.com, vincent.chen@sifive.com,
        andy.chiu@sifive.com, arnd@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        bjorn@kernel.org, libc-alpha@sourceware.org,
        christoph.muellner@vrull.eu, Aaron Durbin <adurbin@rivosinc.com>,
        linux@rivosinc.com
References: <mhng-975b1d7b-7b3f-4e88-804c-8b22787f9588@palmer-ri-x1c9>
From:   Vineet Gupta <vineetg@rivosinc.com>
In-Reply-To: <mhng-975b1d7b-7b3f-4e88-804c-8b22787f9588@palmer-ri-x1c9>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/9/22 09:21, Palmer Dabbelt wrote:
> On Fri, 09 Dec 2022 05:04:23 PST (-0800), fweimer@redhat.com wrote:
>> * Darius Rad:
>>
>>> On Fri, Dec 09, 2022 at 01:32:33PM +0100, Florian Weimer via 
>>> Libc-alpha wrote:
>>>> * Darius Rad:
>>>>
>>>> > On Fri, Dec 09, 2022 at 11:02:57AM +0100, Florian Weimer wrote:
>>>> >> * Andrew Waterman:
>>>> >>
>>>> >> > This suggests that ld.so, early-stage libc, or possibly both 
>>>> will need
>>>> >> > to make this prctl() call, perhaps by parsing the ELF headers 
>>>> of the
>>>> >> > binary and each library to determine if the V extension is used.
>>>> >>
>>>> >> If the string functions use the V extension, it will be enabled
>>>> >> unconditionally.  So I don't see why it's okay for libc to 
>>>> trigger this
>>>> >> alleged UAPI change, when the kernel can't do it by default.
>>>> >>
>>>> >
>>>> > Because the call to enable can fail and userspace needs to deal 
>>>> with that.
>>>>
>>>> Failure is usually indicated by an AT_HWCAP or AT_HWCAP2 bit remaining
>>>> zero, or perhaps a special CPU register (although that is more 
>>>> unusual).
>>>
>>> That would indicate that the extension is not present, which is one 
>>> of, but
>>> not the only way it can fail.
>>
>> I think you should bring down the number of failure modes. HWCAP has
>> the advantage that it communicates kernel/hypervisor/firmware/CPU
>> support in a single bit, which simplifies the programming model and
>> avoids hard-to-detect bugs.  It's not clear why it would be beneficial
>> to continue on ENOMEM failures here because the system must clearly be
>> in bad shape at this point, and launching a new process is very unlikely
>> to improve matters.  So I think the simpler programming model is the way
>> to go here.
>>
>>> The vector extension relies on dynamically allocated memory in the 
>>> kernel,
>>> which can fail.
>
> The issue I'm worried about is that V needs more space in the 
> ucontext-type structures.  We have an extensibility scheme there so we 
> think it can be made to work, but IIUC we'll need glibc to be updated 
> to handle the extended contexts in order to avoid losing state when 
> doing ucontext-related operations like signal handling.

Sorry this is not relevant to this thread. I started a different thread 
on ABI/sigcontext aspects, lets discuss it there.

>
> I don't see a way to handle that with just HWCAP, as we essentially 
> need some bi-directional communicaton between userspace and the kernel 
> so they can both decide to turn on V.  I don't think we strictly need 
> a system call to do that, we kicked around the idea of encoding this 
> in the ELF, but there's a lot of flavors of vector in RISC-V and we've 
> had trouble trying to encode these in binaries before so it seems 
> easier to just use the syscall.
>
>> But this failure can be reported as part of execve and clone.
>>
>>> It also provides the opportunity for the kernel to deny access to the
>>> vector extension, perhaps due to administrative policy or other future
>>> mechanism.
>>
>> HWCAP can do this, too.

Having the prctl as general purpose knob to disable the V unit for 
various reasons makes sense.

But keeping the V unit disabled by default and using prctl as a 
gatekeeper to enable it feels unnecessary and tedious.
Here's my reasoning below (I'm collating comments from prior msgs as well).

1. Doesn't it add another userspace ABI which is already a headache for 
this feature. And that needs to be built into not just libc but 
potentially other runtimes too. Even after implemention there will be an 
interim pain as the new prctl takes time to trickle down into tooling 
and headers. Besides the new stuff will never be compatible with older 
kernel but that is a minor point since older kernel not supporting V is 
a deal breaker anyways.

2. People want the prctl gatekeeping for ability to gracefully handle 
memory allocation failure for the extra V-state within kernel. But that 
is only additional 4K (for typical 128 wide V regs) per task. If that is 
failing, the system is not doing well anyways. Besides it is not an 
issue at all since ENOMEM in clone/execve for the additional space 
should handle the failure anyways. Only very sophisticated apps would 
downgrade from executing V to Scalar code if the prctl failed. Instead 
memory allocation is more likely to be an issue when copying V state on 
a deep user stack across signal handling but there's nothing we can do 
about it.

3. Another argument to prctl gatekeeping is ensuring user-space conforms 
to vector length. But isn't the holy grail of RV V-extension VLA (Vector 
Length Agnostic) programming. I expect most implements to follow that. 
If there are super sophisticated (or dumb) apps that don't follow, they 
will fail randomly. I think of Vector Length as any other ISA extensions 
- its not that currently apps are required to prctl() for bitmanip 
extension if they want to use it. Sure they could use AT_HWCAP (or 
/proc/cpuinfo or any other portable way) to query the capability, same 
can be done for V as well. Besides vlen is readable from user space so 
the app can read it to make sure. My worry is we are providing 
additional safety net to a small category of apps at the expense of 
making it tiresome for everyone else.

HWCAP solves the kernel to user-space communication of capabilities. The 
prctl is for user-space to kernel communication but I'm not convinced it 
is really solving problems for the common case.

Thx,
-Vineet
