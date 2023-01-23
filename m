Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174E9678393
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjAWRsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjAWRsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:48:50 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B99A301B9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:48:45 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id mp20so32569990ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eDP5MhJamRnx89DUQvThFcrZxYZBmeDARbsADOsVCa0=;
        b=Lc7Qm68gy2MwAMGSYPbIyX5UfQ//izoQPF6duUjNG2CB0n3m86dAxluJyF19rFpj8i
         HMI84X/LBJyKYWXDrk0sSpKDdH754PbXiLo28wGh7rTpGS41ZOOUJ3Av7fyiXTI3hrJW
         3Vc89r2tsS7i5ArMSOGeFwL181VWAby1LpAV6w31Tked+FyYkSOnQpEBi5Oz/Gvnexrn
         9iclSybSSbugBQl1R3lboxmm+8z3+TSkPSqjomRibvr75yHHb0rUJVy7YFz6y8bO6rIH
         mfe92kf3Zhw/MX3zRBjEhN6OTCl7p2VRkW+X+ubp3PsCuMg0lRviXWEi3xRQFmWph3G9
         khPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eDP5MhJamRnx89DUQvThFcrZxYZBmeDARbsADOsVCa0=;
        b=6BkXkEZ+xoe7xE3SnbbJxo2V9e1ocYTlIpWii1mubahKr6X7sdamlM+R/T7O8ejU5Q
         4kqlw0Im+9X7rE387hEYKiwvO9KqSLH3AbP44Gx78Iq7OjYtgW/4iUUjo6cbpLXN3q4R
         1h3JwT5Ciau3D4463cqRk4ay07lvIKHd9Fk/bVlJsOzUH8RgEDkYb5gMlvEiZVa5x5Ei
         zScZ3v9UJYLK7lvaeNoOSKtGgdu94m+wzfxkj91yODEw44NJT3pcSrYFxUxg6/DzCxby
         LJEJpYzsNzUfSSp+NwJz7G692LRTmpYiu/rDy++sFWy/dE32MQVrQaAc4H0BnxlPpbAZ
         Wb6w==
X-Gm-Message-State: AFqh2kqf8vPwqxbcu+vTUNny5scbQkIT//OfunqkB8VWgjB4rsEV0OT6
        efqoWnsHdpAc+CBt2ArXqPQ=
X-Google-Smtp-Source: AMrXdXu0a7GL0MA2yReD2CCilns47v/JXM32tQ74eEglC0fWTTL/p+Vq4xzELk371gic+jxcAX/o/w==
X-Received: by 2002:a17:906:60d2:b0:872:6bd0:d2b with SMTP id f18-20020a17090660d200b008726bd00d2bmr24581957ejk.45.1674496123935;
        Mon, 23 Jan 2023 09:48:43 -0800 (PST)
Received: from [192.168.1.17] (91-159-146-104.elisa-laajakaista.fi. [91.159.146.104])
        by smtp.gmail.com with ESMTPSA id g9-20020a17090604c900b0085ca279966esm17416158eja.119.2023.01.23.09.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 09:48:43 -0800 (PST)
Message-ID: <0ec67737-3c09-ba5c-f840-9ed02a0ea6bf@gmail.com>
Date:   Mon, 23 Jan 2023 19:48:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/2] mm: Implement memory-deny-write-execute as a prctl
To:     Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lennart Poettering <lennart@poettering.net>,
        =?UTF-8?Q?Zbigniew_J=c4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net, nd@arm.com, shuah@kernel.org
References: <20230119160344.54358-1-joey.gouly@arm.com>
 <20230119160344.54358-2-joey.gouly@arm.com>
 <4a1faf67-178e-c9ba-0db1-cf90408b0d7d@redhat.com> <Y857Uoq7fjO0lZ12@arm.com>
 <8b4e31cf-de20-703c-4b53-ad86d4282a37@redhat.com> <Y86wA0s/HRVtqLru@arm.com>
Content-Language: en-US
From:   Topi Miettinen <toiwoton@gmail.com>
In-Reply-To: <Y86wA0s/HRVtqLru@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.1.2023 18.04, Catalin Marinas wrote:
> On Mon, Jan 23, 2023 at 01:53:46PM +0100, David Hildenbrand wrote:
>> On 23.01.23 13:19, Catalin Marinas wrote:
>>> On Mon, Jan 23, 2023 at 12:45:50PM +0100, David Hildenbrand wrote:
>>>> On 19.01.23 17:03, Joey Gouly wrote:
>>>>> diff --git a/include/linux/mman.h b/include/linux/mman.h
>>>>> index 58b3abd457a3..cee1e4b566d8 100644
>>>>> --- a/include/linux/mman.h
>>>>> +++ b/include/linux/mman.h
>>>>> @@ -156,4 +156,38 @@ calc_vm_flag_bits(unsigned long flags)
>>>>>     }
>>>>>     unsigned long vm_commit_limit(void);
>>>>> +
>>>>> +/*
>>>>> + * Denies creating a writable executable mapping or gaining executable permissions.
>>>>> + *
>>>>> + * This denies the following:
>>>>> + *
>>>>> + * 	a)	mmap(PROT_WRITE | PROT_EXEC)
>>>>> + *
>>>>> + *	b)	mmap(PROT_WRITE)
>>>>> + *		mprotect(PROT_EXEC)
>>>>> + *
>>>>> + *	c)	mmap(PROT_WRITE)
>>>>> + *		mprotect(PROT_READ)
>>>>> + *		mprotect(PROT_EXEC)
>>>>> + *
>>>>> + * But allows the following:
>>>>> + *
>>>>> + *	d)	mmap(PROT_READ | PROT_EXEC)
>>>>> + *		mmap(PROT_READ | PROT_EXEC | PROT_BTI)
>>>>> + */
>>>>
>>>> Shouldn't we clear VM_MAYEXEC at mmap() time such that we cannot set VM_EXEC
>>>> anymore? In an ideal world, there would be no further mprotect changes
>>>> required.
>>>
>>> I don't think it works for this scenario. We don't want to disable
>>> PROT_EXEC entirely, only disallow it if the mapping is not already
>>> executable. The below should be allowed:
>>>
>>> 	addr = mmap(0, size, PROT_READ | PROT_EXEC, flags, 0, 0);
>>> 	mprotect(addr, size, PROT_READ | PROT_EXEC | PROT_BTI);
>>>
>>> but IIUC what you meant, it fails if we cleared VM_MAYEXEC at mmap()
>>> time.
>>
>> Yeah, if you allow write access at mmap time, clear VM_MAYEXEC (and disallow
>> VM_EXEC of course).
> 
> This should work but it doesn't fully mimic systemd's MDWE behaviour
> (e.g. disallow mprotect(PROT_EXEC) even if the mmap was PROT_READ only).
> Topi wanted to stay close to that at least in the first incarnation of
> this control (can be extended later).
> 
>> But I guess we'd have to go one step further: if we allow exec access
>> at mmap time, clear VM_MAYWRITE (and disallow VM_WRITE of course).
> 
> Yes, both this and the VM_MAYEXEC clearing if VM_WRITE would be useful
> but as additional controls a process can enable.
> 
>> That at least would be then similar to how we handle mmaped files: if the
>> file is not executable, we clear VM_MAYEXEC. If the file is not writable, we
>> clear VM_MAYWRITE.
> 
> We still allow VM_MAYWRITE for private mappings, though we do clear
> VM_MAYEXEC if not executable.
> 
> It would be nice to use VM_MAY* flags for this logic but we can only
> emulate MDWE if we change the semantics of 'MAY': only check the 'MAY'
> flags for permissions being changed (e.g. allow PROT_EXEC if the vma is
> already VM_EXEC even if !VM_MAYEXEC). Another issue is that we end up
> with some weird combinations like having VM_EXEC without VM_MAYEXEC
> (maybe that's fine).
> 
>> Clearing VM_MAYWRITE would imply that also writes via /proc/self/mem to such
>> memory would be forbidden, which might also be what we are trying to
>> achieve, or is that expected to still work?
> 
> I think currently with systemd's MDWE it still works (I haven't tried
> though), unless there's something else forcing that file read-only.
> 
>> But clearing VM_MAYWRITE would mean that is_cow_mapping() would no
>> longer fire for some VMAs, and we'd have to check if that's fine in
>> all cases.
> 
> This will break __access_remote_vm() AFAICT since it can't do a CoW on
> read-only private mapping.
> 
>> Having that said, this patch handles the case when the prctl is applied to a
>> process after already having created some writable or executable mappings,
>> to at least forbid if afterwards on these mappings. What is expected to
>> happen if the process already has writable mappings that are executable at
>> the time we enable the prctl?
> 
> They are expected to continue to work. The prctl() is meant to be
> invoked by something like systemd so that any subsequent exec() will
> inherit the property.
> 
>> Clarifying what the expected semantics with /proc/self/mem are would be
>> nice.
> 
> Yeah, this series doesn't handle this. Topi, do you know if systemd does
> anything about /proc/self/mem? To me this option is more about catching
> inadvertent write|exec mappings rather than blocking programs that
> insist on doing this (they can always map a memfd file twice with
> separate write and exec attributes for example).
> 

I don't think so. For 100% compatibility with seccomp, the same cases of 
mprotect() use should be blocked regardless of the file descriptor used. 
There could be more relaxed PR_MDWE_* controls in the future if needed.

Updated systemd PR: https://github.com/systemd/systemd/pull/25276

I wish there were highly granular access controls for /proc, including 
/proc/self and /proc/sys/*. Now the best options are to use mount 
namespaces and/or SELinux, but they aren't too good for that.

-Topi

