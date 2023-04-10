Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04766DC606
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 13:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjDJLBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 07:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjDJLBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 07:01:33 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF332111
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 04:01:32 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id y11-20020a17090a600b00b0024693e96b58so2904392pji.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 04:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1681124492;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vHUR/cT/p+Bdo1OvjDaF/vJAnET+Cck8N9vYs357g6k=;
        b=UhkOI50iI0W1wlRXpnku3ulk1L1jq+Zwd3HePmNJaQi8pZe+GUDdseF5xv5vPmFAFo
         hyHsE0HF2j28mIXiwj+IKXPL5TdtyAe15riQqFS1GEHvyxapg0NLshmYD3ANoECqE7ZP
         QHYuYJ+pONyP6zIUdfPWgqsZmzC7pI06GILF1BdOE+WpoCqkz087xp1Muw6WRB4AmGSa
         GyDQWpfD7RRXYhzoxaV/nLGWZDfgMK5s/aYiVwhpfxXQzagZ2lqDg7iI/1Pxixboi03x
         G/ULdId+nKzY9pDhcAx81WRRslQmyoGrQLU3qewM0KqXwavd/U8IMjo4DpuZcwnVtQcF
         F+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681124492;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vHUR/cT/p+Bdo1OvjDaF/vJAnET+Cck8N9vYs357g6k=;
        b=021bPyt/vu10MW30NuuQOvpPBDRUmgPeL2HgMDYNg+l+B+IociXzGbWV1ripozzOFU
         J3K/KhIL6h5fZskveLd4ZPhyOGB+xd+loYK4ngfAyGh3JG7SL5Y4JAxtHKNluOOm4lwA
         PvhEEgYKKJOqxZrFHsy67YWokqS6sJdXEogr5j7VMHC/Lsmbsb+sUYMu7U1/+BxDKbHN
         zyaHLO2WqmmOhQVZvrUoCQHmySsvpQJVfr1Br3AJdeOc78NtN+/+6wzsxH6C13Hxc+8l
         ES87B0RKyITL3H9QLVNTHk1scdLOYq396PYy8LRBYZVDnc0/t5VJivH55FSECxMKPSk4
         HExA==
X-Gm-Message-State: AAQBX9dqFcG9o9fl97IhhUSd6rjbCIlvQ2PvlIzl4c9Mg24oEGG83JOO
        qulNXgsroGHX+EuUXJBaq/IZqg==
X-Google-Smtp-Source: AKy350bE/CwNUHEPaYuhWuQ0agUkJ0fFbr6BIZPJjWcujqi0Tsj0XjJL/sHWKACP6KyZsgoO33/BQw==
X-Received: by 2002:a17:902:c401:b0:1a0:48c6:3b43 with SMTP id k1-20020a170902c40100b001a048c63b43mr10178281plk.37.1681124491794;
        Mon, 10 Apr 2023 04:01:31 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id bd1-20020a170902830100b0019ac7319ed1sm7511848plb.126.2023.04.10.04.01.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 04:01:31 -0700 (PDT)
Message-ID: <cc61e2c5-a109-2f18-04e2-cfb010ba6b8a@igel.co.jp>
Date:   Mon, 10 Apr 2023 20:01:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] tools/virtio: fix build caused by virtio_ring changes
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20230410092419.302932-1-mie@igel.co.jp>
 <20230410054259-mutt-send-email-mst@kernel.org>
 <cd2619b1-5d0b-1e7e-12bd-bcb9dcb5c533@igel.co.jp>
 <a7332e82-27f6-8acd-2ff2-498eb66ea6e7@igel.co.jp>
 <20230410064435-mutt-send-email-mst@kernel.org>
From:   Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <20230410064435-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/04/10 19:58, Michael S. Tsirkin wrote:
> On Mon, Apr 10, 2023 at 07:56:13PM +0900, Shunsuke Mie wrote:
>> On 2023/04/10 19:00, Shunsuke Mie wrote:
>>> On 2023/04/10 18:46, Michael S. Tsirkin wrote:
>>>> On Mon, Apr 10, 2023 at 06:24:19PM +0900, Shunsuke Mie wrote:
>>>>> Fix the build dependency for virtio_test. virtio_ring requires
>>>>> container_of_const() and struce device.
>>>>>
>>>>> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
>>>>> ---
>>>>>    tools/include/linux/container_of.h | 36
>>>>> ++++++++++++++++++++++++++++++
>>>>>    tools/virtio/linux/compiler.h      |  3 +++
>>>>>    tools/virtio/linux/kernel.h        |  5 +----
>>>>>    tools/virtio/linux/module.h        |  1 +
>>>>>    4 files changed, 41 insertions(+), 4 deletions(-)
>>>>>    create mode 100644 tools/include/linux/container_of.h
>>>>>
>>>>> diff --git a/tools/include/linux/container_of.h
>>>>> b/tools/include/linux/container_of.h
>>>>> new file mode 100644
>>>>> index 000000000000..06e293b7cfda
>>>>> --- /dev/null
>>>>> +++ b/tools/include/linux/container_of.h
>>>>> @@ -0,0 +1,36 @@
>>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>>> +#ifndef _LINUX_CONTAINER_OF_H
>>>>> +#define _LINUX_CONTAINER_OF_H
>>>>> +
>>>>> +#include <linux/build_bug.h>
>>>>> +#include <linux/stddef.h>
>>>>> +
>>>>> +/**
>>>>> + * container_of - cast a member of a structure out to the
>>>>> containing structure
>>>>> + * @ptr:    the pointer to the member.
>>>>> + * @type:    the type of the container struct this is embedded in.
>>>>> + * @member:    the name of the member within the struct.
>>>>> + *
>>>>> + * WARNING: any const qualifier of @ptr is lost.
>>>>> + */
>>>>> +#define container_of(ptr, type, member) ({                \
>>>>> +    void *__mptr = (void *)(ptr);                    \
>>>>> +    static_assert(__same_type(*(ptr), ((type *)0)->member) ||    \
>>>>> +              __same_type(*(ptr), void),            \
>>>>> +              "pointer type mismatch in container_of()"); \
>>>>> +    ((type *)(__mptr - offsetof(type, member))); })
>>>>> +
>>>>> +/**
>>>>> + * container_of_const - cast a member of a structure out to the
>>>>> containing
>>>>> + *            structure and preserve the const-ness of the pointer
>>>>> + * @ptr:        the pointer to the member
>>>>> + * @type:        the type of the container struct this is embedded in.
>>>>> + * @member:        the name of the member within the struct.
>>>>> + */
>>>>> +#define container_of_const(ptr, type, member) \
>>>>> +    _Generic(ptr,                            \
>>>>> +        const typeof(*(ptr)) *: ((const type
>>>>> *)container_of(ptr, type, member)),\
>>>>> +        default: ((type *)container_of(ptr, type, member)) \
>>>>> +    )
>>>>> +
>>>>> +#endif    /* _LINUX_CONTAINER_OF_H */
>>>> Please just do
>>>> #include "../../../include/linux/container_of.h"
>>>> instead.
>>> Okey, I'll do that.
>>>>
>>>>> diff --git a/tools/virtio/linux/compiler.h
>>>>> b/tools/virtio/linux/compiler.h
>>>>> index 2c51bccb97bb..ac27b3ea6e67 100644
>>>>> --- a/tools/virtio/linux/compiler.h
>>>>> +++ b/tools/virtio/linux/compiler.h
>>>>> @@ -8,4 +8,7 @@
>>>>>    #define READ_ONCE(var) (*((volatile typeof(var) *)(&(var))))
>>>>>      #define __aligned(x) __attribute((__aligned__(x)))
>>>>> +
>>>>> +#define __same_type(a, b)
>>>>> __builtin_types_compatible_p(typeof(a), typeof(b))
>>>>> +
>>>>>    #endif
>>>> #include "../../../include/linux/compiler_types.h" instead?
>>> I'll try it.
>>>>> diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
>>>>> index 8b877167933d..3cd20cb92649 100644
>>>>> --- a/tools/virtio/linux/kernel.h
>>>>> +++ b/tools/virtio/linux/kernel.h
>>>>> @@ -10,6 +10,7 @@
>>>>>    #include <stdarg.h>
>>>>>      #include <linux/compiler.h>
>>>>> +#include <linux/container_of.h>
>>>>>    #include <linux/log2.h>
>>>>>    #include <linux/types.h>
>>>>>    #include <linux/overflow.h>
>>>>> @@ -107,10 +108,6 @@ static inline void free_page(unsigned long addr)
>>>>>        free((void *)addr);
>>>>>    }
>>>>>    -#define container_of(ptr, type, member) ({            \
>>>>> -    const typeof( ((type *)0)->member ) *__mptr = (ptr);    \
>>>>> -    (type *)( (char *)__mptr - offsetof(type,member) );})
>>>>> -
>>>>>    # ifndef likely
>>>>>    #  define likely(x)    (__builtin_expect(!!(x), 1))
>>>>>    # endif
>>>>> diff --git a/tools/virtio/linux/module.h b/tools/virtio/linux/module.h
>>>>> index 9dfa96fea2b2..e2e791dbd104 100644
>>>>> --- a/tools/virtio/linux/module.h
>>>>> +++ b/tools/virtio/linux/module.h
>>>>> @@ -5,3 +5,4 @@
>>>>>        static __attribute__((unused)) const char
>>>>> *__MODULE_LICENSE_name = \
>>>>>            __MODULE_LICENSE_value
>>>>>    +struct device;
>>>> It's not there in include/linux/module - pls put it in the
>>>> same here where it is for linux.
>>> I understood. I'll add some files that has the definition.
>> In vringh.c, 'struct device' is used in virtio_ring.h. Upon investigating
>> the preprocessed file, it was
>>
>> discovered that 'struct device' is defined in bitmap.h, which is included
>> from architecture-specific headers.
>>
>> On x86, the nesting includes
>>
>> 'linux/module.h' -> ... -> 'arch/x86/include/asm/msr.h' ->
>> 'arch/x86/include/asm/cpumask.h' -> 'linux/cpumask.h' -> 'linux/bitmap.h'.
>>
>> Could you advise on the appropriate way to include this file?
> Let's just add struct device; in virtio_ring.h, make it
> self-sufficient.
>
I agree. Thanks a lot.

>>>>> -- 
>>>>> 2.25.1
>>> Best regards,
>>>
>>> Shunsuke.
>>>
