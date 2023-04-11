Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADFA6DD00D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 05:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjDKDR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 23:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjDKDRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 23:17:53 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D894198A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 20:17:52 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-635a81be246so511027b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 20:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1681183071;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0i4sacpzXDdA/hnFZhlWTyon+8D7LzSMzXk2XHrkT40=;
        b=shohQdAnhYMUMlB4tI9RYOTnYwy60WZ5spGEWv+d4W6D3qVgZFQJtLvK9+fESJ4AJ+
         pqzsVjYJEvKS1C5xRf2CRRPQ39ICdFkFn4AyBINrGlN19van8TJkdSJJAszBBIgxC96D
         /w5OlvoWJYzaxPQVH2+5SCVL6Rxe+q2quS5v9Z3FDssCZNWBB3jhBUfoUwXXMRtrv4Ic
         LoC+0xmopfhAM71kIkjJmKt8bvzKVCIuguOjZ2zLmJhsFmp5mbiWdQLmR8I9EqDfUQnm
         m2Z7huSZa1UYO7/BheuSA/rwRDTrqNJzhn//Z1+GPkRjS3a9xlQt1lCIY8gWi63S6tfq
         g+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681183071;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0i4sacpzXDdA/hnFZhlWTyon+8D7LzSMzXk2XHrkT40=;
        b=r9avrZ5Vzj+uuD7sFHjLtGKgk3JMvtHRhgqXb9HfD9GuzVqGc72sOef9CuQ04k9L6u
         +4gQeCauaovs8jrOkcwo2O/PC+8hAuiH8iAxhVRPxYVliLDz4vcJZtCcI8S3AoWdkyVY
         vO6/GWiStcpAMFsnCPDlap+96ZNw1Gp1VDDSarxHd8FINxQ3num51tZRI7Dzom+FVfGg
         Mf8GTgOGhFLu7xkDosyTR2BdxZBbP2rrSpisDJE73piUFubBd8s781Kmw1CFZ6K8mEu1
         AbxTGi1ves6Zq0XOR7xOcxSajqEXuqGirEayCPqVLRKWT+Ak3pJyifJDo04Qa6F3w7vI
         tKcA==
X-Gm-Message-State: AAQBX9dS4mX4SsDVLcn49+1uLpSxHFEUvGRQGsoJhIg9mb7YllFiJWF3
        Loq7aXj6p2GW66/Rp87tQ+GIbmlvF+SE4GGCESU=
X-Google-Smtp-Source: AKy350Zu+w9A/P0WWtC00arO5OtiFSv2vBGHTuwKwC/YXhPPZgWJCoXoFfM/q9wcXM9rtM0WWEqbDQ==
X-Received: by 2002:aa7:956c:0:b0:626:2ce1:263c with SMTP id x12-20020aa7956c000000b006262ce1263cmr1462738pfq.5.1681183071512;
        Mon, 10 Apr 2023 20:17:51 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id d16-20020aa78690000000b00639c1fc8766sm1865246pfo.212.2023.04.10.20.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 20:17:51 -0700 (PDT)
Message-ID: <7e7f5268-c64e-c207-8b4d-f017816c4dfe@igel.co.jp>
Date:   Tue, 11 Apr 2023 12:17:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/2] tools/virtio: fix build caused by virtio_ring
 changes
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20230410112845.337212-1-mie@igel.co.jp>
 <20230410112845.337212-2-mie@igel.co.jp>
 <20230410080014-mutt-send-email-mst@kernel.org>
 <2023041055-provided-antiquely-bbdb@gregkh>
From:   Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <2023041055-provided-antiquely-bbdb@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/04/11 3:40, Greg Kroah-Hartman wrote:
> On Mon, Apr 10, 2023 at 08:00:33AM -0400, Michael S. Tsirkin wrote:
>> On Mon, Apr 10, 2023 at 08:28:45PM +0900, Shunsuke Mie wrote:
>>> Fix the build dependency for virtio_test. The virtio_ring that is used from
>>> the test requires container_of_const(). Change to use container_of.h kernel
>>> header directly and adapt related codes.
>>>
>>> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
>> This is only for next right? That's where container_of_const
>> things are I think ...
> container_of_const() is in 6.2.
>
>
>>> ---
>>>   tools/include/linux/types.h   |  1 -
>>>   tools/virtio/linux/compiler.h |  2 ++
>>>   tools/virtio/linux/kernel.h   |  5 +----
>>>   tools/virtio/linux/module.h   |  1 -
>>>   tools/virtio/linux/uaccess.h  | 11 ++---------
>>>   5 files changed, 5 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
>>> index 051fdeaf2670..f1896b70a8e5 100644
>>> --- a/tools/include/linux/types.h
>>> +++ b/tools/include/linux/types.h
>>> @@ -49,7 +49,6 @@ typedef __s8  s8;
>>>   #endif
>>>   
>>>   #define __force
>>> -#define __user
> Why is this needed?
>
>>>   #define __must_check
>>>   #define __cold
>>>   
>>> diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.h
>>> index 2c51bccb97bb..1f3a15b954b9 100644
>>> --- a/tools/virtio/linux/compiler.h
>>> +++ b/tools/virtio/linux/compiler.h
>>> @@ -2,6 +2,8 @@
>>>   #ifndef LINUX_COMPILER_H
>>>   #define LINUX_COMPILER_H
>>>   
>>> +#include "../../../include/linux/compiler_types.h"
> While I understand your need to not want to duplicate code, what in the
> world is this doing?  Why not use the in-kernel compiler.h instead?  Why
> are you copying loads of .h files into tools/virtio/?  What is this for
> and why not just use the real files so you don't have to even attempt to
> try to keep things in sync (hint, they will always be out of sync.)
>
>>> +
>>>   #define WRITE_ONCE(var, val) \
>>>   	(*((volatile typeof(val) *)(&(var))) = (val))
>>>   
>>> diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
>>> index 8b877167933d..6702008f7f5c 100644
>>> --- a/tools/virtio/linux/kernel.h
>>> +++ b/tools/virtio/linux/kernel.h
>>> @@ -10,6 +10,7 @@
>>>   #include <stdarg.h>
>>>   
>>>   #include <linux/compiler.h>
>>> +#include "../../../include/linux/container_of.h"
> Either do this for all .h files, or not, don't pick and choose.
>
>
>
>>>   #include <linux/log2.h>
>>>   #include <linux/types.h>
>>>   #include <linux/overflow.h>
>>> @@ -107,10 +108,6 @@ static inline void free_page(unsigned long addr)
>>>   	free((void *)addr);
>>>   }
>>>   
>>> -#define container_of(ptr, type, member) ({			\
>>> -	const typeof( ((type *)0)->member ) *__mptr = (ptr);	\
>>> -	(type *)( (char *)__mptr - offsetof(type,member) );})
>>> -
>>>   # ifndef likely
>>>   #  define likely(x)	(__builtin_expect(!!(x), 1))
>>>   # endif
>>> diff --git a/tools/virtio/linux/module.h b/tools/virtio/linux/module.h
>>> index 9dfa96fea2b2..5cf39167d47a 100644
>>> --- a/tools/virtio/linux/module.h
>>> +++ b/tools/virtio/linux/module.h
>>> @@ -4,4 +4,3 @@
>>>   #define MODULE_LICENSE(__MODULE_LICENSE_value) \
>>>   	static __attribute__((unused)) const char *__MODULE_LICENSE_name = \
>>>   		__MODULE_LICENSE_value
>>> -
> This change has nothing to do with what you said was happening in this
> patch :(
>
> Please be more careful.
>
>>> diff --git a/tools/virtio/linux/uaccess.h b/tools/virtio/linux/uaccess.h
>>> index 991dfb263998..cde2c344b260 100644
>>> --- a/tools/virtio/linux/uaccess.h
>>> +++ b/tools/virtio/linux/uaccess.h
>>> @@ -6,15 +6,10 @@
>>>   
>>>   extern void *__user_addr_min, *__user_addr_max;
>>>   
>>> -static inline void __chk_user_ptr(const volatile void *p, size_t size)
>>> -{
>>> -	assert(p >= __user_addr_min && p + size <= __user_addr_max);
>>> -}
>>> -
> What does this function have to do with container_of()?
>
>
>>>   #define put_user(x, ptr)					\
>>>   ({								\
>>>   	typeof(ptr) __pu_ptr = (ptr);				\
>>> -	__chk_user_ptr(__pu_ptr, sizeof(*__pu_ptr));		\
>>> +	__chk_user_ptr(__pu_ptr);		\
> Why are you trying to duplicate in-kernel .h files?
>
> This all doesn't look ok, sorry.
>
> greg k-h

Thank you. I'll modify problems you commented, but we have to discuss 
the design of tools/virtio.

Best regards,

Shunsuke.

