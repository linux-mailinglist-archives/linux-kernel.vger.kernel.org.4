Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1936DD02A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 05:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjDKDZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 23:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjDKDZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 23:25:44 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1961010F8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 20:25:43 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q15-20020a17090a2dcf00b0023efab0e3bfso9565948pjm.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 20:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112; t=1681183542;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7XUoNyfPy7EwnAW1tUOTNtWKEocwT7jAS6X1S3hv+0Q=;
        b=bu1uq1SovAZxCB4dUdo7ThN4+LGmO8IbueHdlC2chn8IZUuBUl3uZXSMSGiYLHLzWT
         dMiEJIeF2KsLVJXwRAG+8u0kmsICsa9U+PEhIGTWYxIh0RG/KLNkRMAXJDp6Z7+YTe+A
         Esx5PDnmp3zbtbss3AGhWsQdPa+orI266obiBhI/UKPCcbYTkAsL8OsKbF2eTATyhYYH
         giIq+ccyf1iHM8RGMGd55PHeAdm8cnFni48+6Ti556jqZI+PF4kb+Sb4kSWNYf9OBdHI
         2n+JlkGfmpNTcgrhkWcWJ4AnUjRtHwB5w9juDVFyj7erDm/nSviBk0oLZ1YcSrosiAYQ
         qVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681183542;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7XUoNyfPy7EwnAW1tUOTNtWKEocwT7jAS6X1S3hv+0Q=;
        b=MDMdwooCv9H32oWHHQV0xLc3oHO7Lbh45xCTomD1BHko0zDuahYhPaBw6eKE3YEzwq
         TGSt3SvRZphiGfnucanDcRVnNCUn4RXHAYRe/P0Fzw+dwEiVyP2DnRiVWHBH1Eo/YYB+
         Lsq8016R8z4tU6G3yh1lQ00075ywl1TICWGttBVvSc6L52jZvM5kMZuxVmgwGARltGrk
         6dj0GBH2iuDwIDjjzhADvRHDLv7aJcp6lnF7FeasYfIsHeGbCGj5dEwkt/SWlRQZ5y9Z
         1KUs8V7z4Ryjbx9kpArehTqydHYKWojmy3+hyHNfNXdWrog3TImF8Z+luARZijLYOHzi
         TmSA==
X-Gm-Message-State: AAQBX9fvRpNCk27YTnHFTOBjWqQZKTlNb9Fv4vG/TyoB9EOubXfYUVtJ
        4MA0iGoLty3dOIAY998a9z1FfNCOuPdqQDoK4DY=
X-Google-Smtp-Source: AKy350acoaF3Wr3Z0i9aFV4dHgpSlRzjzEyS/9M1NzDDRHPf/HuH6joogmQHqgd/iNHE3EDxyuzT8A==
X-Received: by 2002:a17:903:68b:b0:1a1:f95a:24f2 with SMTP id ki11-20020a170903068b00b001a1f95a24f2mr1080611plb.19.1681183542532;
        Mon, 10 Apr 2023 20:25:42 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709028c8d00b001a19196af48sm8452094plo.64.2023.04.10.20.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 20:25:42 -0700 (PDT)
Message-ID: <de392fbd-3ffd-466d-cc7f-32f55c03227f@igel.co.jp>
Date:   Tue, 11 Apr 2023 12:25:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/2] tools/virtio: fix build caused by virtio_ring
 changes
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
 <20230410154035-mutt-send-email-mst@kernel.org>
From:   Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <20230410154035-mutt-send-email-mst@kernel.org>
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


On 2023/04/11 4:44, Michael S. Tsirkin wrote:
> On Mon, Apr 10, 2023 at 08:40:34PM +0200, Greg Kroah-Hartman wrote:
>> On Mon, Apr 10, 2023 at 08:00:33AM -0400, Michael S. Tsirkin wrote:
>>> On Mon, Apr 10, 2023 at 08:28:45PM +0900, Shunsuke Mie wrote:
>>>> Fix the build dependency for virtio_test. The virtio_ring that is used from
>>>> the test requires container_of_const(). Change to use container_of.h kernel
>>>> header directly and adapt related codes.
>>>>
>>>> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
>>> This is only for next right? That's where container_of_const
>>> things are I think ...
>> container_of_const() is in 6.2.
>
> Absolutely but the patch switching virtio to that is not there.
>
>
>>>> ---
>>>>   tools/include/linux/types.h   |  1 -
>>>>   tools/virtio/linux/compiler.h |  2 ++
>>>>   tools/virtio/linux/kernel.h   |  5 +----
>>>>   tools/virtio/linux/module.h   |  1 -
>>>>   tools/virtio/linux/uaccess.h  | 11 ++---------
>>>>   5 files changed, 5 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
>>>> index 051fdeaf2670..f1896b70a8e5 100644
>>>> --- a/tools/include/linux/types.h
>>>> +++ b/tools/include/linux/types.h
>>>> @@ -49,7 +49,6 @@ typedef __s8  s8;
>>>>   #endif
>>>>   
>>>>   #define __force
>>>> -#define __user
>> Why is this needed?
>>
>>>>   #define __must_check
>>>>   #define __cold
>>>>   
>>>> diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.h
>>>> index 2c51bccb97bb..1f3a15b954b9 100644
>>>> --- a/tools/virtio/linux/compiler.h
>>>> +++ b/tools/virtio/linux/compiler.h
>>>> @@ -2,6 +2,8 @@
>>>>   #ifndef LINUX_COMPILER_H
>>>>   #define LINUX_COMPILER_H
>>>>   
>>>> +#include "../../../include/linux/compiler_types.h"
>> While I understand your need to not want to duplicate code, what in the
>> world is this doing?  Why not use the in-kernel compiler.h instead?  Why
>> are you copying loads of .h files into tools/virtio/?  What is this for
>> and why not just use the real files so you don't have to even attempt to
>> try to keep things in sync (hint, they will always be out of sync.)
> Because it's doing a very weird hack: building some kernel
> code into a userspace binary, used for just for testing.
> This is all not part of kernel build intentionally, no
> one is supposed to use this binary in production, but
> it was helpful in finding bugs in virtio core in the past
> so I keep it around.
Would it be possible to switch to in-kernel tests, such as KUnit? If it's
possible, we could use the kernel headers and implementations as they are,
and we could address the concerns that Greg raised I think.


Best regards,

Shunsuke

