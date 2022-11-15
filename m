Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6950262A1E2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 20:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiKOTbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 14:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKOTbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:31:08 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19ECCE0E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 11:31:06 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id a15so18903580ljb.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 11:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GyIes3iMStNxnqC1zOqI35/7e76O5dm/XUcc8xXZAU0=;
        b=BwbnG2RfwynQyF60LQWulCgZz/hWVDpZdDS/W4Afc0GwH9VaX/6v6MpM6FEicoD3qh
         kBXdUWCdP5DC6h8mf/mrnzxSXR4bYpUaF5FDGkrw4k+jZpzvIlkdVAYAv1nLUyuYgfAa
         nEvcfHM60NM+upX/oP3JL3COzv02zmik+Pjw0Z14qW+f0Lheo2gLM/N6Pi02pMo9NDzy
         0QGl5Wq9Kh0BxozfGXGpDQFXzOb7LZVCPt0TCIbTR3OFcM2+VLvFGmB5tryDDYgYbyj3
         mYi1eHd+nMCdFvqLKrmEhIi/rAvyUgVf2Mo6BvxaGGwhBLq+b+71j38DXgdOyLej9R2A
         4vtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GyIes3iMStNxnqC1zOqI35/7e76O5dm/XUcc8xXZAU0=;
        b=voOaK+/K9C8Qr57PsZ5OggAsj3TqqBhh46cmx8ZlUptL3S8hhgeKzMHRbM5T3m1ylW
         qZFc7k03YWtyKNC3Y/x0VqxMeT9SrJMjfftv4wFdt3U6ebeYjqAL53sfgTWNXiIIQ/an
         PDFP2e4H7rBFEFCTIp97pDMS+MasWKMZU9MLCIhz4kp424FZxIdLYSrg1NJ2tuBwVtKN
         bj7VhJr1iGQAnAgSqR41zINt3Sh2NR23wZfVT1HjDAPcPQoHJJAsw37MvcbuBNGL9m6A
         2cxmF7EEhFnio/QNuW5IYUzzK4GKVxMDy8oYmwG+OF73A+GrqbjScgDfG4AsIQXA/ToE
         ws1A==
X-Gm-Message-State: ANoB5pkwNMsnPUnyS6xnYqvFcFFX2EI085duLTlbuH2IJ1EuL9vh3fi4
        7k2t3NRT7oug8/YB/m0pfAk=
X-Google-Smtp-Source: AA0mqf5E7tedpNnEAREDyyxzme4BhAXLv4FsoAZtAChSVnsk1YdNBoZXKk4qdoZLXnO/ckEuuwCskQ==
X-Received: by 2002:a05:651c:220f:b0:277:1d5b:74b with SMTP id y15-20020a05651c220f00b002771d5b074bmr6339410ljq.522.1668540664883;
        Tue, 15 Nov 2022 11:31:04 -0800 (PST)
Received: from [192.168.1.12] (91-159-148-109.elisa-laajakaista.fi. [91.159.148.109])
        by smtp.gmail.com with ESMTPSA id g25-20020a19ee19000000b004ac393ecc32sm2304658lfb.304.2022.11.15.11.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 11:31:04 -0800 (PST)
Message-ID: <3238cc28-218e-ae73-2e12-a7c1a08bc353@gmail.com>
Date:   Tue, 15 Nov 2022 21:31:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v1 1/2] mm: Implement memory-deny-write-execute as a prctl
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Joey Gouly <joey.gouly@arm.com>, Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lennart Poettering <lennart@poettering.net>,
        =?UTF-8?Q?Zbigniew_J=c4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net, nd@arm.com, shuah@kernel.org
References: <20221026150457.36957-1-joey.gouly@arm.com>
 <20221026150457.36957-2-joey.gouly@arm.com> <202210281053.904BE2F@keescook>
 <20221110112714.GA1201@e124191.cambridge.arm.com> <Y2zojDe0Oj4OSbIc@arm.com>
 <45419a7d-04dd-2749-2534-6ba3bbd5d060@gmail.com> <Y3Ox1QxAzdouCGUr@arm.com>
Content-Language: en-US
From:   Topi Miettinen <toiwoton@gmail.com>
In-Reply-To: <Y3Ox1QxAzdouCGUr@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.11.2022 17.35, Catalin Marinas wrote:
> On Sat, Nov 12, 2022 at 08:11:24AM +0200, Topi Miettinen wrote:
>> On 10.11.2022 14.03, Catalin Marinas wrote:
>>> On Thu, Nov 10, 2022 at 11:27:14AM +0000, Joey Gouly wrote:
>>>> On Fri, Oct 28, 2022 at 11:51:00AM -0700, Kees Cook wrote:
>>>>> On Wed, Oct 26, 2022 at 04:04:56PM +0100, Joey Gouly wrote:
>>>>>> diff --git a/mm/mmap.c b/mm/mmap.c
>>>>>> index 099468aee4d8..42eaf6683216 100644
>>>>>> --- a/mm/mmap.c
>>>>>> +++ b/mm/mmap.c
>>>>>> @@ -1409,6 +1409,9 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>>>>>>    			vm_flags |= VM_NORESERVE;
>>>>>>    	}
>>>>>> +	if (map_deny_write_exec(NULL, vm_flags))
>>>>>> +		return -EACCES;
>>>>>> +
>>>>>
>>>>> This seems like the wrong place to do the check -- that the vma argument
>>>>> is a hard-coded "NULL" is evidence that something is wrong. Shouldn't
>>>>> it live in mmap_region()? What happens with MAP_FIXED, when there is
>>>>> an underlying vma? i.e. an MAP_FIXED will, I think, bypass the intended
>>>>> check. For example, we had "c" above:
>>>>>
>>>>>        c)	mmap(PROT_READ);
>>>>> 	mprotect(PROT_READ|PROT_EXEC);		// fails
>>>>>
>>>>> But this would allow another case:
>>>>>
>>>>>        e)	addr = mmap(..., PROT_READ, ...);
>>>>> 	mmap(addr, ..., PROT_READ | PROT_EXEC, MAP_FIXED, ...);	// passes
>>>>
>>>> I can move the check into mmap_region() but it won't fix the MAP_FIXED
>>>> example that you showed here.
>>>>
>>>> mmap_region() calls do_mas_munmap(..) which will unmap overlapping regions.
>>>> However the `vma` for the 'old' region is not kept around, and a new vma will
>>>> be allocated later on "vma = vm_area_alloc(mm);", and the vm_flags are just set
>>>> to what is passed into mmap_region(), so map_deny_write_exec(vma, vm_flags)
>>>> will just be as good as passing NULL.
>>>>
>>>> It's possible to save the vm_flags from the region that is unmapped, but Catalin
>>>> suggested it might be better if that is part of a later extension, what do you
>>>> think?
>>>
>>> I thought initially we should keep the behaviour close to what systemd
>>> achieves via SECCOMP while only relaxing an mprotect(PROT_EXEC) if the
>>> vma is already executable (i.e. check actual permission change not just
>>> the PROT_* flags).
>>>
>>> We could pass the old vm_flags for that region (and maybe drop the vma
>>> pointer entirely, just check old and new vm_flags). But this feels like
>>> tightening slightly systemd's MDWE approach. If user-space doesn't get
>>> confused by this, I'm fine to go with it. Otherwise we can add a new
>>> flag later for this behaviour
>>>
>>> I guess that's more of a question for Topi on whether point tightening
>>> point (e) is feasible/desirable.
>>
>> I think we want 1:1 compatibility with seccomp() for the basic version, so
>> MAP_FIXED shouldn't change the verdict. Later we can introduce more versions
>> (perhaps even less strict, too) when it's requested by configuration, like
>> MemoryDenyWriteExecute=[relaxed | strict].
> 
> Are you ok with allowing mprotect(PROT_EXEC|PROT_BTI) if the mapping is
> already PROT_EXEC? Or you'd rather reject that as well?
> 

I think that it's OK to allow that. It's an incompatible change, but it 
shouldn't break anything.

-Topi

