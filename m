Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8B96DC577
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 12:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjDJKAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 06:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjDJKAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 06:00:10 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F48B55BC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 03:00:09 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id bp17-20020a17090b0c1100b0023f187954acso3997479pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 03:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1681120809;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1lOn71eOpVH75+mzBFJgeHPK/bE4oCp6up1ds6aJ9dU=;
        b=IDv2Pb1q8CQSZ0dn9AEvTUL7La35AnVpTkWiO5k4hgtk1vN3OBuSIYblAvhssVpsHV
         RssDkI5d8UtWU1+JSN6NnZvXrlXlkRbY/97+mH3CGe92FftSlVwBAlVAOCIQ0mwXeoXi
         b+1lB0F+jbI6NRHoQ7e1HrA9+6fti25ipytnzBcI9qT9x6Rv/rD4GQxtx4tmVncwF3a3
         icPjQHMmFckiZdkoEIxb6hTK/Nbi3/sjIVwhuDl5oNktvh6Pmhi9ygqD/YfieFQzSebx
         PxHCqvCJuKHvj2SrCN+7JKIx/4HGs0v53KGumC0AXezB6WH4oS7e6g0UTPtYDJt2/0KE
         ZJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681120809;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1lOn71eOpVH75+mzBFJgeHPK/bE4oCp6up1ds6aJ9dU=;
        b=rG8PzCYiOsThCknQ11ivggfwmRxvIqmlzXqkTKFjPM4Lzs5sQIh79NZRkni5iOhCRa
         9IKWWgZyDFBRGW1XakXv/mkfJVlWvm1+VwoW4jmyieIrKIwld/I4Tv38ASB7wR/Wkf04
         ghoEaqppIV8J3Ev3y08/kgrlcx+bgloV2E527WXw8Zdw7TKARKyJSadkqXNpLk1z+nKD
         hKKEJLGjTgAs7vHM+vUHM0vmD/zqBBPwK/oElVYTinBobPT5eovgOwGJjpD9Q4/U4RiP
         +CkN5jrOMAz+KmoEnO5WZf/8NVMU9KwhsC4MTIVO1AmBTaUees4n+usvMXffjLQxVz9n
         5Msw==
X-Gm-Message-State: AAQBX9fYXyzq/8HaOaBtwItMlHnvgoJDNCldl3r/nu5x62oQmP1ZOz+B
        bM5iTYJNdji5jhJxvgsZTk24Rg==
X-Google-Smtp-Source: AKy350a7xWTWdOZiQI/K8arMXIWagE5vLIjHC5mhuISjeRI/iHZx3CTkQK/JnKwWoTvO4JQGgxdD0A==
X-Received: by 2002:a17:90b:2241:b0:246:9c75:351a with SMTP id hk1-20020a17090b224100b002469c75351amr3658215pjb.12.1681120808990;
        Mon, 10 Apr 2023 03:00:08 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id b11-20020a17090a550b00b0023cd53e7706sm8800617pji.47.2023.04.10.03.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 03:00:08 -0700 (PDT)
Message-ID: <cd2619b1-5d0b-1e7e-12bd-bcb9dcb5c533@igel.co.jp>
Date:   Mon, 10 Apr 2023 19:00:04 +0900
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
From:   Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <20230410054259-mutt-send-email-mst@kernel.org>
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


On 2023/04/10 18:46, Michael S. Tsirkin wrote:
> On Mon, Apr 10, 2023 at 06:24:19PM +0900, Shunsuke Mie wrote:
>> Fix the build dependency for virtio_test. virtio_ring requires
>> container_of_const() and struce device.
>>
>> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
>> ---
>>   tools/include/linux/container_of.h | 36 ++++++++++++++++++++++++++++++
>>   tools/virtio/linux/compiler.h      |  3 +++
>>   tools/virtio/linux/kernel.h        |  5 +----
>>   tools/virtio/linux/module.h        |  1 +
>>   4 files changed, 41 insertions(+), 4 deletions(-)
>>   create mode 100644 tools/include/linux/container_of.h
>>
>> diff --git a/tools/include/linux/container_of.h b/tools/include/linux/container_of.h
>> new file mode 100644
>> index 000000000000..06e293b7cfda
>> --- /dev/null
>> +++ b/tools/include/linux/container_of.h
>> @@ -0,0 +1,36 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_CONTAINER_OF_H
>> +#define _LINUX_CONTAINER_OF_H
>> +
>> +#include <linux/build_bug.h>
>> +#include <linux/stddef.h>
>> +
>> +/**
>> + * container_of - cast a member of a structure out to the containing structure
>> + * @ptr:	the pointer to the member.
>> + * @type:	the type of the container struct this is embedded in.
>> + * @member:	the name of the member within the struct.
>> + *
>> + * WARNING: any const qualifier of @ptr is lost.
>> + */
>> +#define container_of(ptr, type, member) ({				\
>> +	void *__mptr = (void *)(ptr);					\
>> +	static_assert(__same_type(*(ptr), ((type *)0)->member) ||	\
>> +		      __same_type(*(ptr), void),			\
>> +		      "pointer type mismatch in container_of()");	\
>> +	((type *)(__mptr - offsetof(type, member))); })
>> +
>> +/**
>> + * container_of_const - cast a member of a structure out to the containing
>> + *			structure and preserve the const-ness of the pointer
>> + * @ptr:		the pointer to the member
>> + * @type:		the type of the container struct this is embedded in.
>> + * @member:		the name of the member within the struct.
>> + */
>> +#define container_of_const(ptr, type, member)				\
>> +	_Generic(ptr,							\
>> +		const typeof(*(ptr)) *: ((const type *)container_of(ptr, type, member)),\
>> +		default: ((type *)container_of(ptr, type, member))	\
>> +	)
>> +
>> +#endif	/* _LINUX_CONTAINER_OF_H */
>
> Please just do
> #include "../../../include/linux/container_of.h"
> instead.
Okey, I'll do that.
>
>
>> diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.h
>> index 2c51bccb97bb..ac27b3ea6e67 100644
>> --- a/tools/virtio/linux/compiler.h
>> +++ b/tools/virtio/linux/compiler.h
>> @@ -8,4 +8,7 @@
>>   #define READ_ONCE(var) (*((volatile typeof(var) *)(&(var))))
>>   
>>   #define __aligned(x) __attribute((__aligned__(x)))
>> +
>> +#define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
>> +
>>   #endif
> #include "../../../include/linux/compiler_types.h" instead?
I'll try it.
>> diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
>> index 8b877167933d..3cd20cb92649 100644
>> --- a/tools/virtio/linux/kernel.h
>> +++ b/tools/virtio/linux/kernel.h
>> @@ -10,6 +10,7 @@
>>   #include <stdarg.h>
>>   
>>   #include <linux/compiler.h>
>> +#include <linux/container_of.h>
>>   #include <linux/log2.h>
>>   #include <linux/types.h>
>>   #include <linux/overflow.h>
>> @@ -107,10 +108,6 @@ static inline void free_page(unsigned long addr)
>>   	free((void *)addr);
>>   }
>>   
>> -#define container_of(ptr, type, member) ({			\
>> -	const typeof( ((type *)0)->member ) *__mptr = (ptr);	\
>> -	(type *)( (char *)__mptr - offsetof(type,member) );})
>> -
>>   # ifndef likely
>>   #  define likely(x)	(__builtin_expect(!!(x), 1))
>>   # endif
>> diff --git a/tools/virtio/linux/module.h b/tools/virtio/linux/module.h
>> index 9dfa96fea2b2..e2e791dbd104 100644
>> --- a/tools/virtio/linux/module.h
>> +++ b/tools/virtio/linux/module.h
>> @@ -5,3 +5,4 @@
>>   	static __attribute__((unused)) const char *__MODULE_LICENSE_name = \
>>   		__MODULE_LICENSE_value
>>   
>> +struct device;
>
> It's not there in include/linux/module - pls put it in the
> same here where it is for linux.
I understood. I'll add some files that has the definition.
>> -- 
>> 2.25.1

Best regards,

Shunsuke.

