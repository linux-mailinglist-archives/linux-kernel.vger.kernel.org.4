Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491DD6384EE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 09:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiKYICh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 03:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiKYICe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 03:02:34 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4562A559D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 00:02:33 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id x102so5389316ede.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 00:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r47lxpAlmEVI5SZmOnV7ojQvY12OH1FcHXRnZ5IZQpg=;
        b=FflgkK1IFiX6gJG48jUUG6HQ6UBNUIBr0KpQ0GUhFdGrrdAjteke3CjWbe0S8lQZ9s
         8VMcLsaOcq55oo6sHEMXtV6g/RP/zZyFw+DLFPFM/qcZkM647nM4zwyVX4wPgKv9bm+2
         9JDN83itAS2CbQ1fVYQDsC6G6+LSxRweHAlf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r47lxpAlmEVI5SZmOnV7ojQvY12OH1FcHXRnZ5IZQpg=;
        b=vN2dcUXU6Ik3uqKHksVYcZv3epL8qwuIChwwj4fm4entjr/bOfcJtUffdLR+eGBnus
         hkR+spYid2nbLT13HUm0SCFia31opx/MW035I29XRZEB3d0jITsRaIMffcuQnk7SeBKY
         9Sh4ymUhlEBsPmvVHwBr60tRbaK9kM7KYErrvTWCXhEIK1nUrPXFbRZsSvk6138J8kWT
         R6DQVk5XtjADzpRUJxFZwtuwwN6nEJUuzvdkCXCenu3LPU4roua/9hYbJ4gkmvFXSmq0
         Ou5R/gacz3Bru8p2QmBYR2/1V0qSTV7Vt7nOipsmTrz1S46C44dq8LJva+yDAfQd7czG
         TMRQ==
X-Gm-Message-State: ANoB5plHtD+kI9EYFrIEappYGgJzOgTRSM2tOQ1IFGMP3dRZ0lMBOvgA
        QQvuXN5X5JAPLXWypMJ8/tBT0u3YX/iKRd3s
X-Google-Smtp-Source: AA0mqf5JN7k4JtsVSIurwKWsi38PwPudjjN/uj4c43SHFAYXYjnFk48jhsUZHvboHR1bLdw44Ozczw==
X-Received: by 2002:aa7:d998:0:b0:463:a4a7:d3f1 with SMTP id u24-20020aa7d998000000b00463a4a7d3f1mr25798323eds.299.1669363351490;
        Fri, 25 Nov 2022 00:02:31 -0800 (PST)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f15-20020a50fc8f000000b00462e1d8e914sm1466467edq.68.2022.11.25.00.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 00:02:30 -0800 (PST)
Message-ID: <5d7ff259-819e-df9f-1db3-271c263be9cd@rasmusvillemoes.dk>
Date:   Fri, 25 Nov 2022 09:02:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v6 2/3] random: introduce generic vDSO getrandom()
 implementation
Content-Language: en-US, da
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Linux API <linux-api@vger.kernel.org>
References: <20221121152909.3414096-1-Jason@zx2c4.com>
 <20221121152909.3414096-3-Jason@zx2c4.com>
 <842fd97b-c958-7b0d-2c77-6927c7ab4d72@rasmusvillemoes.dk>
 <Y37GXIQVvUvRac6D@zx2c4.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <Y37GXIQVvUvRac6D@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2022 02.18, Jason A. Donenfeld wrote:
> Hi Rasmus,
> 
> On Wed, Nov 23, 2022 at 09:51:04AM +0100, Rasmus Villemoes wrote:
>> On 21/11/2022 16.29, Jason A. Donenfeld wrote:
>>
>> Cc += linux-api
>>
>>>
>>>       if (!new_block)
>>>         goto out;
>>>       new_cap = grnd_allocator.cap + num;
>>>       new_states = reallocarray(grnd_allocator.states, new_cap, sizeof(*grnd_allocator.states));
>>>       if (!new_states) {
>>>         munmap(new_block, num * size_per_each);
>>
>> Hm. This does leak an implementation detail of vgetrandom_alloc(),
>> namely that it is based on mmap() of that size rounded up to page size.
>> Do we want to commit to this being the proper way of disposing of a
>> succesful vgetrandom_alloc(), or should there also be a
>> vgetrandom_free(void *states, long num, long size_per_each)?
> 
> Yes, this is intentional, and this is exactly what I wanted to do. There
> are various wrappers of vm_mmap() throughout, mmap being one of them,
> and they typically then resort to munmap to unmap it. This is how
> userspace handles memory - maps, always maps. So I think doing that is
> fine and consistent.

OK. Perhaps for the benefit of future libc implementors drop a comment
somewhere as to how to dealloc the blob.

> However, your point about it relying on it being a rounded up size isn't
> correct. `munmap` will unmap the whole page if the size you pass lies
> within a page. So `num * size_of_each` will always do the right thing,
> without needing to have userspace code round anything up. (From the man
> page: "The  address addr must be a multiple of the page size (but length
> need not be). 

I know, and I never said userspace needed to round anything up.

All pages containing a part of the indicated range are
> unmapped.") And as you can see in my example code, nothing is rounded
> up. So I don't know why you made that comment.

I made that comment because it's clear from what this does that you get
something back that is _at least_ num*size_per_each in size, but what is
not clear is that the actual allocation is exactly and will always be
that size rounded up to a page size (and no more), so that
munmap(num*size_per_each), with its well-known and documented semantics,
will DTRT.

> I think adding more control is exactly what this is trying to avoid.
> It's very intentionally *not* a general allocator function, but
> something specific for vDSO getrandom(). However, it does already, in
> this very patchset here, take a (currently unused) flags argument, in
> case we have the need for later extension.

OK.

Perhaps you can spend a few more words on why this allocation _needs_ to
be MAP_LOCKED? That seems somewhat of a policy thing imposed by the
kernel, something that would be better left to the libc or distro or
whatnot to request via a flag. I could imagine applications that
currently run at the mlock limit start failing after a libc upgrade -
which could of course be considered a libc problem, and perhaps it's too
unlikely to worry about.

Rasmus

