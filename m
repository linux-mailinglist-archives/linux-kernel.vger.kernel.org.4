Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85096DC5FA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 12:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjDJK4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 06:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDJK4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 06:56:18 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B001712
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 03:56:17 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-632bcd6cb63so479987b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 03:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1681124177;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kUfYBMfNg0SmC86dn/fX5bWORs6cZUYHg91rhQn2QYM=;
        b=NY9rrM2WqjnhPe5auMnkJCTfiUe8zdxsNyUTjnmfZsN0G+rXISnMe2IP7OsZctLnLe
         YFdDteT3xd3ow+4c57SOE4Qq6MpxH7e/xV96fuy6qO5X5tk1PaW4ZCgzPCLALIXuM69C
         Nse0dLyuKfMscFlouF83z7WmDLL8FP55MnuirOXdBk1NaL4Zc30uZkB1vgsalevvGW8v
         hqRSxadVW3y2FTwI1+4E679pGyPaCdZOjOTmpShYHoUaPSfjHF8IibTiRfl39xc2Xask
         k6fj9due2CuUr5nbzo2/q95SriiepbkwQVhZfCzVwMaDz1osf5S2OMHmLjFAEzqhChbQ
         Vjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681124177;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kUfYBMfNg0SmC86dn/fX5bWORs6cZUYHg91rhQn2QYM=;
        b=ypW7R/yF1kTfK0C3hB49//e2jlnuCSF2JddjCsV0JHnyzlj7H3g/7tufAA76JoWvQU
         be+00+RZmPqd0A9FU+sVfjcqGC+Wjbq8E2WcNu8IldELEMqmMp6Ju3I6ApHfBGW2kO7j
         2DvpgCvTfndRRpQuHCJxMrOgx9gXchwJIH8gaTu7y9bTg74r0p+tDtgFUIzUHuAkVpNv
         jcfXpAOadOtqHHH4WjjaNFZ14L2kQyIPA2mjRkq0LlSDYeJ5LQQySeBrzJiy+YVrJmDC
         /z5qj5WhMPHlvXwJkUfiy86DRHuKD9p+Wlc9VccYNihGUHbjbg91fEoRQHZUKf6DT8TD
         NLwA==
X-Gm-Message-State: AAQBX9cD2+JDPjgG7sycftchJrJvaez4iEVRyXrQcXTjNvuHUEtWdAWH
        Hx5qOWBh/SrFAgNV5yj+hoFYrg==
X-Google-Smtp-Source: AKy350bFJfjMDeTrfzeTBW9bSfARNeu5n7yZBzOfGNll/E4rYYyfS5lmYSbNejLk8E9JFoeDCA9IlA==
X-Received: by 2002:a62:1d8e:0:b0:626:166f:6db1 with SMTP id d136-20020a621d8e000000b00626166f6db1mr10098940pfd.13.1681124177282;
        Mon, 10 Apr 2023 03:56:17 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id w5-20020aa78585000000b006348cb791f4sm3357460pfn.192.2023.04.10.03.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 03:56:16 -0700 (PDT)
Message-ID: <a7332e82-27f6-8acd-2ff2-498eb66ea6e7@igel.co.jp>
Date:   Mon, 10 Apr 2023 19:56:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] tools/virtio: fix build caused by virtio_ring changes
Content-Language: en-US
From:   Shunsuke Mie <mie@igel.co.jp>
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
In-Reply-To: <cd2619b1-5d0b-1e7e-12bd-bcb9dcb5c533@igel.co.jp>
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


On 2023/04/10 19:00, Shunsuke Mie wrote:
>
> On 2023/04/10 18:46, Michael S. Tsirkin wrote:
>> On Mon, Apr 10, 2023 at 06:24:19PM +0900, Shunsuke Mie wrote:
>>> Fix the build dependency for virtio_test. virtio_ring requires
>>> container_of_const() and struce device.
>>>
>>> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
>>> ---
>>>   tools/include/linux/container_of.h | 36 
>>> ++++++++++++++++++++++++++++++
>>>   tools/virtio/linux/compiler.h      |  3 +++
>>>   tools/virtio/linux/kernel.h        |  5 +----
>>>   tools/virtio/linux/module.h        |  1 +
>>>   4 files changed, 41 insertions(+), 4 deletions(-)
>>>   create mode 100644 tools/include/linux/container_of.h
>>>
>>> diff --git a/tools/include/linux/container_of.h 
>>> b/tools/include/linux/container_of.h
>>> new file mode 100644
>>> index 000000000000..06e293b7cfda
>>> --- /dev/null
>>> +++ b/tools/include/linux/container_of.h
>>> @@ -0,0 +1,36 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +#ifndef _LINUX_CONTAINER_OF_H
>>> +#define _LINUX_CONTAINER_OF_H
>>> +
>>> +#include <linux/build_bug.h>
>>> +#include <linux/stddef.h>
>>> +
>>> +/**
>>> + * container_of - cast a member of a structure out to the 
>>> containing structure
>>> + * @ptr:    the pointer to the member.
>>> + * @type:    the type of the container struct this is embedded in.
>>> + * @member:    the name of the member within the struct.
>>> + *
>>> + * WARNING: any const qualifier of @ptr is lost.
>>> + */
>>> +#define container_of(ptr, type, member) ({                \
>>> +    void *__mptr = (void *)(ptr);                    \
>>> +    static_assert(__same_type(*(ptr), ((type *)0)->member) ||    \
>>> +              __same_type(*(ptr), void),            \
>>> +              "pointer type mismatch in container_of()"); \
>>> +    ((type *)(__mptr - offsetof(type, member))); })
>>> +
>>> +/**
>>> + * container_of_const - cast a member of a structure out to the 
>>> containing
>>> + *            structure and preserve the const-ness of the pointer
>>> + * @ptr:        the pointer to the member
>>> + * @type:        the type of the container struct this is embedded in.
>>> + * @member:        the name of the member within the struct.
>>> + */
>>> +#define container_of_const(ptr, type, member) \
>>> +    _Generic(ptr,                            \
>>> +        const typeof(*(ptr)) *: ((const type *)container_of(ptr, 
>>> type, member)),\
>>> +        default: ((type *)container_of(ptr, type, member)) \
>>> +    )
>>> +
>>> +#endif    /* _LINUX_CONTAINER_OF_H */
>>
>> Please just do
>> #include "../../../include/linux/container_of.h"
>> instead.
> Okey, I'll do that.
>>
>>
>>> diff --git a/tools/virtio/linux/compiler.h 
>>> b/tools/virtio/linux/compiler.h
>>> index 2c51bccb97bb..ac27b3ea6e67 100644
>>> --- a/tools/virtio/linux/compiler.h
>>> +++ b/tools/virtio/linux/compiler.h
>>> @@ -8,4 +8,7 @@
>>>   #define READ_ONCE(var) (*((volatile typeof(var) *)(&(var))))
>>>     #define __aligned(x) __attribute((__aligned__(x)))
>>> +
>>> +#define __same_type(a, b) __builtin_types_compatible_p(typeof(a), 
>>> typeof(b))
>>> +
>>>   #endif
>> #include "../../../include/linux/compiler_types.h" instead?
> I'll try it.
>>> diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
>>> index 8b877167933d..3cd20cb92649 100644
>>> --- a/tools/virtio/linux/kernel.h
>>> +++ b/tools/virtio/linux/kernel.h
>>> @@ -10,6 +10,7 @@
>>>   #include <stdarg.h>
>>>     #include <linux/compiler.h>
>>> +#include <linux/container_of.h>
>>>   #include <linux/log2.h>
>>>   #include <linux/types.h>
>>>   #include <linux/overflow.h>
>>> @@ -107,10 +108,6 @@ static inline void free_page(unsigned long addr)
>>>       free((void *)addr);
>>>   }
>>>   -#define container_of(ptr, type, member) ({            \
>>> -    const typeof( ((type *)0)->member ) *__mptr = (ptr);    \
>>> -    (type *)( (char *)__mptr - offsetof(type,member) );})
>>> -
>>>   # ifndef likely
>>>   #  define likely(x)    (__builtin_expect(!!(x), 1))
>>>   # endif
>>> diff --git a/tools/virtio/linux/module.h b/tools/virtio/linux/module.h
>>> index 9dfa96fea2b2..e2e791dbd104 100644
>>> --- a/tools/virtio/linux/module.h
>>> +++ b/tools/virtio/linux/module.h
>>> @@ -5,3 +5,4 @@
>>>       static __attribute__((unused)) const char 
>>> *__MODULE_LICENSE_name = \
>>>           __MODULE_LICENSE_value
>>>   +struct device;
>>
>> It's not there in include/linux/module - pls put it in the
>> same here where it is for linux.
> I understood. I'll add some files that has the definition.

In vringh.c, 'struct device' is used in virtio_ring.h. Upon 
investigating the preprocessed file, it was

discovered that 'struct device' is defined in bitmap.h, which is 
included from architecture-specific headers.

On x86, the nesting includes

'linux/module.h' -> ... -> 'arch/x86/include/asm/msr.h' -> 
'arch/x86/include/asm/cpumask.h' -> 'linux/cpumask.h' -> 'linux/bitmap.h'.

Could you advise on the appropriate way to include this file?

>>> -- 
>>> 2.25.1
>
> Best regards,
>
> Shunsuke.
>
