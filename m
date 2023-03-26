Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65456C97B0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 22:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjCZUEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 16:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjCZUEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 16:04:05 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E26E4EFE
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 13:04:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 591CE604F2;
        Sun, 26 Mar 2023 22:04:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1679861040; bh=K4W3BB5anItSzCtmT/+mFDStMxjXsM9eUkxQjb4A8Tk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=zrCYzfT1IikatDAye+fwv2Jtziq/S1QRscCm7IIxMoGd4crTrs5JRpubrm5kUTP7l
         6NFDXjumz2rXuU4WFmnzoX7SxJRuUqeSTqO01hgpNvyVz5HjPSiVV9fz8dVNaRAc5W
         tIvpet4eFGQFm/ch4ZfKuAzWo0uvtK8t+mTk2KOwmaxSJUIQ3nFjzBXB22u/nnmJPy
         87Ushpom5n63oFwJgmh6NTcrUiSabdUJddBwy3+Wu1gre+3BnQZeYvJoxOa9pllfsZ
         HaimDM8Hb+WUYLW3yaWxMyjXnq3bOwU/bQOp47wGIQ5Xw3NUvUwVFZic0/5RTubZmf
         bAOXZ70Ip+CmQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id z5UHODX3zmbV; Sun, 26 Mar 2023 22:03:58 +0200 (CEST)
Received: from [192.168.1.3] (unknown [77.237.101.225])
        by domac.alu.hr (Postfix) with ESMTPSA id 2FB21604EF;
        Sun, 26 Mar 2023 22:03:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1679861038; bh=K4W3BB5anItSzCtmT/+mFDStMxjXsM9eUkxQjb4A8Tk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lFc9UgqOneLEIU5/N7HCVedrLTu2sf8jMbYkx1Nzhs9S5Nv4c2YKjTB72hKoh9FG4
         rTqCelJvhoIeL+6Ai/2R3w0oMJIUvmpDFAhbpOrO3zDQBl1CStfOjHBSscnUUGuu//
         nDTVRo+l+pwzOId/d9okG+q5Ngt/2UqN1bJBHubzlYJFrTLQ37Lga5RN7CZalRRj20
         y0Z7ah/tEu4J9OAC5Gnpw5489LLA5/Px0cYP9PtiIbpV0mi3HP86q9CMkWDiOzHbcK
         ATLA4PUZuBkQXAVSfKq5XruHPUXRoPwPFRxU/L727s9bCpApjI7UeGQpIxXPetFI7B
         mPFa9WwrfbzXg==
Message-ID: <431b2e3d-94ea-4612-ffe4-8e071dae3280@alu.unizg.hr>
Date:   Sun, 26 Mar 2023 22:03:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 8/8] selftests/proc: Assert clock_gettime(CLOCK_BOOTTIME)
 VS /proc/uptime monotonicity
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Wei Li <liwei391@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu Liao <liaoyu15@huawei.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>
References: <20230222144649.624380-1-frederic@kernel.org>
 <20230222144649.624380-9-frederic@kernel.org>
 <219c5d09-0099-83e9-b21b-299fa513decd@alu.unizg.hr>
 <ZBmmtMlKXcf2+hnq@lothringen>
Content-Language: en-US, hr
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZBmmtMlKXcf2+hnq@lothringen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 03. 2023. 13:44, Frederic Weisbecker wrote:
> On Wed, Mar 08, 2023 at 04:59:41PM +0100, Mirsad Todorovac wrote:
>> On 2/22/23 15:46, Frederic Weisbecker wrote:
>> From what I see, you round the CLOCK_BOOTIME time to 1/100ths of a second.
>>
>> A simple program that queries clock_getres() on system clocks gives this
>> result:
>>
>> clock_res [CLOCK_REALTIME] = 0.000000001s
>> clock_res [CLOCK_REALTIME_COARSE] = 0.004000000s
>> clock_res [CLOCK_MONOTONIC] = 0.000000001s
>> clock_res [CLOCK_MONOTONIC_COARSE] = 0.004000000s
>> clock_res [CLOCK_MONOTONIC_RAW] = 0.000000001s
>> clock_res [CLOCK_BOOTTIME] = 0.000000001s
>> clock_res [CLOCK_PROCESS_CPUTIME_ID] = 0.000000001s
>> clock_res [CLOCK_THREAD_CPUTIME_ID] = 0.000000001s
>>
>> A number of programs may depend i.e. on CLOCK_REALTIME or CLOCK_BOOTIME to give
>> different result each nanosecond.
>>
>> I came across this when generating nonces for HMACs according to recommendations
>> from RFC 4086 "Randomness Requirements for Security".
>>
>> If the value of CLOCK_BOOTTIME or CLOCK_REALTIME is incremented not in what
>> clock_getres() gives, but at best in 1/100th of second instead, that would seriously
>> weaken our security (for as you know, in many cryptographic uses nonces need not
>> be random, but MUST NOT ever repeat nor go backwards).
>>
>> Could we modify the test for this assumption, or is the assumption wrong?
>>
>> Here the test for CLOCK_PROCESS_CPUTIME_ID and CLOCK_THREAD_CPUTIME_ID
>> increasing monotonically with guaranteed increased value of nanoseconds
>> would also seem good.
>>
>> Maybe this is already covered in another test case, but it seems that all
>> clocks should be guaranteed to be monotonically increasing, and increased
>> at least by one nanosecond with each syscall, or many algorithms would break.
>>
>> In other words, CLOCK_BOOTTIME should be tested to increase monotonically in
>> the resolution given by clock_getres (CLOCK_BOOTTIME, &tv_res), not in 1/100ths
>> of second (IMHO).
> 
> Maybe but verifying a clock against its own resolution is another testcase. Here the
> point is to verify that CLOCK_BOOTTIME is monotonic against /proc/uptime, and
> since /proc/uptime has an 1/100 second resolution, rounding clock_gettime(CLOCK_BOOTTIME)
> result down to that is the best we can do.
> 
> Thanks.

Hi Frederic,

Thank you for explaining that.

I've read somewhere (forgot the link) that clock_gettime(CLOCK_*) clocks should
be guaranteed to return at least a nanosecond increased value for a PID or TID
from call to call.

Returning the same value would break some algorithms that depend on monotonous
increase of time - for example, some naive implementations of nonce generators.

I believe this is worth assuring in tests, or possibly some naive crypto
would reveal its pre-shared secrets in consecutive calls (Please see RFC 4086,
"Randomness Requirements for Security" for greater detail in explanation.

Best regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

