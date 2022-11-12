Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD79626753
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 07:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbiKLGLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 01:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbiKLGL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 01:11:29 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3665B5BE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 22:11:27 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bp15so11201399lfb.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 22:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ZLvRaeS8y+cZCF03n5SSnu9zu8bM48xjEr/wYSpTlQ=;
        b=BBKlTL9UNjZg3IEZMt3+y5InaJzZApQ7RNP/Jv9nNrfynKwJRQGV2d/E3Noa+wzkcK
         4LwgVlg4VJWXr9uA1oDhdFHpRn5fzKdUD020vrNmhoh/scL73vgFasNgxf0snOAESocl
         3KtbwEFaahz+YpOlBHgl3hGiBJRIibun7RIihbxxMgnD3Ssn0oFmna0b6XVKuOA6677e
         xi8EQ712kwMAvFjW+CMQ/2Dj90qGZ89yDRcwTuwNti1GWsRqnrTW9Wicnv7F3K9BLnK5
         4qcVWLEXBRCMenV0CMQPLK2O3j0hriQmFaEaJJDm2Tz7iQmp1oC01gi3GTfbjQmYPzWD
         QBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZLvRaeS8y+cZCF03n5SSnu9zu8bM48xjEr/wYSpTlQ=;
        b=Pm5dMsSkfjiNljuPA6PBNnp7nDVc1dAMQOedCqucXUekK3YgC8GDdkHz12PQTBSYRZ
         sx1VJw3hCx+pr9xP4X4KH7JKfzTBgQCcrAgLbubAXNH9StB1ymycT/sR5cqjBFnG85LZ
         Q2DRQIakJKxxbvXXULQzibJRZ9JYl8AJsYqgSiayOjTdSoTxyYe6GLdblx3U+gx0Tc6Y
         5FKAXg+4Mp6oasi+GWXFRumfB4qK0ZGRpuF1mrQwFu8UqrMdBJaBFNgjE+tureUF4eW8
         zm5Wp5o+PpZP+GB/aQCsbbYuZSEXhkYAHGA6FRRVQnKaCX4oguULL1nXdfqlmo9YKCqy
         Te/Q==
X-Gm-Message-State: ANoB5pkIBssNXvsQ2zGRuMx2gDCw7kk4LIr9Pg0R9CHJZN4QZQuipFwN
        eGCNZs2gOL9IpijMUCzQejAw6sltLRZNGw==
X-Google-Smtp-Source: AA0mqf61PLdv0bjkPFdOk6TopWXuZVrtchqhyLcjmBwmZLffdDwe+Agt8OGIuMn2kPoGJ1zRtu36Ow==
X-Received: by 2002:ac2:411a:0:b0:499:4f:2582 with SMTP id b26-20020ac2411a000000b00499004f2582mr1901357lfi.515.1668233485763;
        Fri, 11 Nov 2022 22:11:25 -0800 (PST)
Received: from [192.168.1.12] (91-159-148-109.elisa-laajakaista.fi. [91.159.148.109])
        by smtp.gmail.com with ESMTPSA id u2-20020ac258c2000000b004996fbfd75esm705413lfo.71.2022.11.11.22.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 22:11:25 -0800 (PST)
Message-ID: <45419a7d-04dd-2749-2534-6ba3bbd5d060@gmail.com>
Date:   Sat, 12 Nov 2022 08:11:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v1 1/2] mm: Implement memory-deny-write-execute as a prctl
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Joey Gouly <joey.gouly@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
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
Content-Language: en-US
From:   Topi Miettinen <toiwoton@gmail.com>
In-Reply-To: <Y2zojDe0Oj4OSbIc@arm.com>
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

On 10.11.2022 14.03, Catalin Marinas wrote:
> On Thu, Nov 10, 2022 at 11:27:14AM +0000, Joey Gouly wrote:
>> On Fri, Oct 28, 2022 at 11:51:00AM -0700, Kees Cook wrote:
>>> On Wed, Oct 26, 2022 at 04:04:56PM +0100, Joey Gouly wrote:
>>>> diff --git a/mm/mmap.c b/mm/mmap.c
>>>> index 099468aee4d8..42eaf6683216 100644
>>>> --- a/mm/mmap.c
>>>> +++ b/mm/mmap.c
>>>> @@ -1409,6 +1409,9 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>>>>   			vm_flags |= VM_NORESERVE;
>>>>   	}
>>>>   
>>>> +	if (map_deny_write_exec(NULL, vm_flags))
>>>> +		return -EACCES;
>>>> +
>>>
>>> This seems like the wrong place to do the check -- that the vma argument
>>> is a hard-coded "NULL" is evidence that something is wrong. Shouldn't
>>> it live in mmap_region()? What happens with MAP_FIXED, when there is
>>> an underlying vma? i.e. an MAP_FIXED will, I think, bypass the intended
>>> check. For example, we had "c" above:
>>>
>>>       c)	mmap(PROT_READ);
>>> 	mprotect(PROT_READ|PROT_EXEC);		// fails
>>>
>>> But this would allow another case:
>>>
>>>       e)	addr = mmap(..., PROT_READ, ...);
>>> 	mmap(addr, ..., PROT_READ | PROT_EXEC, MAP_FIXED, ...);	// passes
>>
>> I can move the check into mmap_region() but it won't fix the MAP_FIXED
>> example that you showed here.
>>
>> mmap_region() calls do_mas_munmap(..) which will unmap overlapping regions.
>> However the `vma` for the 'old' region is not kept around, and a new vma will
>> be allocated later on "vma = vm_area_alloc(mm);", and the vm_flags are just set
>> to what is passed into mmap_region(), so map_deny_write_exec(vma, vm_flags)
>> will just be as good as passing NULL.
>>
>> It's possible to save the vm_flags from the region that is unmapped, but Catalin
>> suggested it might be better if that is part of a later extension, what do you
>> think?
> 
> I thought initially we should keep the behaviour close to what systemd
> achieves via SECCOMP while only relaxing an mprotect(PROT_EXEC) if the
> vma is already executable (i.e. check actual permission change not just
> the PROT_* flags).
> 
> We could pass the old vm_flags for that region (and maybe drop the vma
> pointer entirely, just check old and new vm_flags). But this feels like
> tightening slightly systemd's MDWE approach. If user-space doesn't get
> confused by this, I'm fine to go with it. Otherwise we can add a new
> flag later for this behaviour
> 
> I guess that's more of a question for Topi on whether point tightening
> point (e) is feasible/desirable.

I think we want 1:1 compatibility with seccomp() for the basic version, 
so MAP_FIXED shouldn't change the verdict. Later we can introduce more 
versions (perhaps even less strict, too) when it's requested by 
configuration, like MemoryDenyWriteExecute=[relaxed | strict].

-Topi

