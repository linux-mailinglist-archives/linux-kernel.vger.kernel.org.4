Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5E264D0FA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 21:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiLNUTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 15:19:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiLNUSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 15:18:04 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDF331DCD
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:07:06 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so379977pjm.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H0jYvI03VngWHu7dv8MwY4kRlHri3j1nty37BsCfhkQ=;
        b=46XbYZJeaKRa9E5a8YT6WBW/S5cjoRCJg3WvQEEmcG5KYcc/uzhiaXHwUqzdDVpZsX
         fHPQ9apRLqrATuBdCBihKxeQYIaxRCX9rfYNCqwlWkq1N8Qs4/B1wMFj67vupVddXoZ1
         bwFV0Dud8NTrIXb4LahhAXgaeihIMGWNzZoKBNmyIEs+k1y3sSnpoL6G+y1sclYWBo4H
         rydajxgOARcVlJzK8JFJCt0plT1rBmcjkAghPPgggs/OqkdbuwBd5VoK1gzt3aG534GB
         koIV9aYcXpvJPHX9dtJ/frB7JUHYzjjyC1FJ3uT8tdw+V7yJMi7L3nwKSI0hLO7X7OUn
         Ph5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H0jYvI03VngWHu7dv8MwY4kRlHri3j1nty37BsCfhkQ=;
        b=KNU5U1XNxFh/Sa164yvKIyBqk4E9TqKHUYUacOZTjg62IbOjS26Nk9EQv3PJYD2BjC
         eFgeYBYvWNTiAthPw5lPjZdssZRuD9D0Y77TxthJhIWoXKWdxQHgABWhY08QjMt2jLAP
         YhGjGquHeuRWFOvrolYzUE0jTteudlSgrR8V8rKPTG/3MO9zP0fETlfDPxCWVrqUGnSz
         jKt6Eo+NFQKHqyYZY7ebB+NIiPQdMv8S6Nciz/ed77swdYHP3Wj+3pDPmPyeuwkUlaaw
         NHKF8sChMLClSmaUz1VIf615SXdu0suzM+MYQQANroVrhOe2zjEchgKXavp4/14eClL0
         wK7w==
X-Gm-Message-State: ANoB5pnJMmoxoeiyvYKZKfc0OVD2nCGDFMUzq8ZPB80CtlD59zJVliW2
        6RiRhXzSOBKgZJymkBuRzjMzaQ==
X-Google-Smtp-Source: AA0mqf4GmD3hP0v0HXminWT9iyK39VmpjnKmBUJRfdH6u+Khbcr+wl9iTbxT4trCZ9j1EpYsfw4jEQ==
X-Received: by 2002:a05:6a20:6f08:b0:a2:df6d:e56b with SMTP id gt8-20020a056a206f0800b000a2df6de56bmr9291155pzb.14.1671048425738;
        Wed, 14 Dec 2022 12:07:05 -0800 (PST)
Received: from [192.168.50.116] (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id o131-20020a62cd89000000b00573eb4a775esm279621pfg.17.2022.12.14.12.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 12:07:05 -0800 (PST)
Message-ID: <8fe9cfaf-2cbc-8de6-3928-067de9113bfc@rivosinc.com>
Date:   Wed, 14 Dec 2022 12:07:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: RISCV Vector unit disabled by default for new task (was Re:
 [PATCH v12 17/17] riscv: prctl to enable vector commands)
Content-Language: en-US
To:     Palmer Dabbelt <palmer@dabbelt.com>, fweimer@redhat.com,
        Andrew Waterman <andrew@sifive.com>, stillson@rivosinc.com,
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
 <e9cf13a9-561a-3438-00f0-41fe2631888d@rivosinc.com>
 <Y5irn63DQkwumfvW@bruce.bluespec.com>
From:   Vineet Gupta <vineetg@rivosinc.com>
In-Reply-To: <Y5irn63DQkwumfvW@bruce.bluespec.com>
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

On 12/13/22 08:43, Darius Rad wrote:
> On Fri, Dec 09, 2022 at 11:42:19AM -0800, Vineet Gupta wrote:
>> But keeping the V unit disabled by default and using prctl as a gatekeeper
>> to enable it feels unnecessary and tedious.
>> Here's my reasoning below (I'm collating comments from prior msgs as well).
> Please reference the previous discussion [1] which has covered topics that
> have not been discussed recently.
>
> [1] https://lists.infradead.org/pipermail/linux-riscv/2021-September/thread.html#8361

I sure read thru that thread, and many more :-) to get context.
The highlight is we should something because AVX/AMX do so (or failed to 
do so).
But on the flip side ARM SVE is not disabling this by default.
Your other concerns seems to be potential power implications for leaving 
it on and sharing of V unit across harts (see more on that below)
Maybe leaving it on all the time will be motivation for hw designers to 
be more considerate of the idle power draw.

>
>> 2. People want the prctl gatekeeping for ability to gracefully handle memory
>> allocation failure for the extra V-state within kernel. But that is only
>> additional 4K (for typical 128 wide V regs) per task.
> But vector state scales up to as much as 256k.  Are you suggesting that
> there is no possibility that future systems would support more than
> VLEN=128?

I mentioned "typical". And below also said that memory allocation 
concerns are moot, since fork/execve failures due to failing to allocate 
would take care of those anyways.

>> If that is failing,
>> the system is not doing well anyways. Besides it is not an issue at all
>> since ENOMEM in clone/execve for the additional space should handle the
>> failure anyways. Only very sophisticated apps would downgrade from executing
>> V to Scalar code if the prctl failed.
> This seems unlikely.  As vector support does not exist in any present
> hardware, and the vector extension is only optional in the RISC-V profiles
> that include it, I would think that it is almost certain that any
> application that supports V would have a fallback path for when the V
> extension is not available.

For specialized cases sure we would expect fat binaries with IFUNC based 
dispatches (glibc mem*/str* are obvious examples). But with newer 
compilers autovec is increasing becoming default even at medium 
optimization levels such as -O2. So V code littered all over is just a 
matter of time for the profiles/variants which allow V. For less capable 
systems w/o V this is all but moot discussion since kernel itself need 
not be built with V enabled.


> Another motivation for requiring that user space request use of the vector
> extension is that the vector unit may be shared between multiple harts
> and/or have power or performance implications in the system.  By requiring
> that user space request access, it allows the system to decline that
> access, and user space can handle this gracefully.

But in this specific example won't the prctl cause more pain. So 2 
concurrent processes on 2 different harts with shared V unit. One sends 
prctl to enable and other wants to disable, what would the kernel do. 
Will it just be whoever ends up running later wins. Granted I'm not too 
familiar with how such a cross-hart sharing would work in a Vector 
instructions being part of ISA  (vs. Vector accelerator with job 
push/pull approach)

Honestly I'm sympathetic to your power concerns with keeping V enabled 
all the time. But the mechanics of implementing this prctl makes me 
wary. Assuming this is done from dynamic loader, it implies loader 
itself needs to be built with V disabled. This also leaves bunch of perf 
on table since loader does tons of of string and memory operations which 
could potentially benefit from V enabled code, granted it is not deal 
breaker.



> If we add a mechanism for user space to request access to the vector
> extension, and it turns out that it was unnecessary, the worst that has
> happened is a slight inconvenience.
>
> If we do not add such a mechanism, and later determine that it is
> necessary, we have a much greater problem.  There would be backward
> compatibility issues with the ABI, and such a mechanism could probably not
> be fully implemented at all due to the desire to support potential future
> legacy vector code.

Very true, but this in itself is not sufficient of a reason to warrant 
adding it now.

> This is a similar problem on x86.  According to some, it was handled poorly
> with AVX-512 by missing this type of mechanism, and improved with AMX [2].
> There is opportunity to learn from that experience and do things better on
> RISC-V.
>
> [2] https://lore.kernel.org/lkml/87k0ntazyn.ffs@nanos.tec.linutronix.de/

Right, but then why did ARM SVE guys chose to not take this path.

-Vineet
