Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EB1652E51
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 10:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbiLUJP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 04:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbiLUJPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 04:15:51 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C631BDF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 01:15:46 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 82so10061194pgc.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 01:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2KUDYCSoD2AR1pNrDgSkwFfCRcQklBfsXuQ70QZWMgM=;
        b=pcEogXXL3NvRgooEZ7uSHA4fA28PfLFqpltbhCyG90WADJ11BPsxPB2CdOrXq2i5GZ
         B5DBBXc0jrXe+hxGfzaR5oP9cXi4afslu/fFdh535pjU8W/TwkFHUXE+AAe7suUZ7d/o
         VAqRV/3Ji+aqB2xPA+Dhh1zgSRML4rokZSIssSIbLe9AEG7jyxQZqmz+34bmJafsmx62
         oQsVMtGVADyX9oevjjKcYjHlRvLlU+P9cVfaf4yjZ+w67IZEY0a0/hNx7vJjTMEaV9M9
         SO7JR3SSX4S10sC42FifyFZFC13Ad62hv9VH8qKFTzloZADZuP3BFXHkIr+AFRBJjlJj
         tA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2KUDYCSoD2AR1pNrDgSkwFfCRcQklBfsXuQ70QZWMgM=;
        b=Eqh4E40LUEcBy1+YaWf9w/CdJa9hICLtLp0QGzIQjUy9/rDInaOQCbwcxOyGpr0Owp
         Io6iaTqAIRndkILs4WiCuhJ8E4TtuvlRhgnsFKvgWeOF9gFdLbiJO1OjOyEKViEDdsJg
         3I2olZeL/SCJOXFM+5LyzHvj0B87uAU49XpYxWEOqIDnhEPxzhwhY2CgnVzC3L8ixBor
         A56jC2LI4uZoecetz4KvSIbhxkiIV4d0QYEao2rgwi6DkwSeCuQ6TNHFJ8ZL3Yci8NlE
         mQ6Gu3cFpRDS9JB/7f8AKhc/IjTUclwvaZZmis7hRhtAlpS6c75zw6encWtbuFPcGjrv
         76AA==
X-Gm-Message-State: AFqh2kqAug9vpeJFxn7Vqc0tYsi51fGnGdW88dFq2MKGFBmjlvzeuBNO
        GNxWcDKPxcBS+OYY8pAsPJWaQA==
X-Google-Smtp-Source: AMrXdXvpFQcuTqPDKBVMDz36OFvwOte3Qhiiqhh4g1oqD+dZHYLnUI2pO96lZ8lkcriem2+YtDF8jw==
X-Received: by 2002:aa7:983a:0:b0:57e:827c:901b with SMTP id q26-20020aa7983a000000b0057e827c901bmr838661pfl.34.1671614146174;
        Wed, 21 Dec 2022 01:15:46 -0800 (PST)
Received: from [10.16.128.218] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id l187-20020a6225c4000000b0057621a437d7sm10010694pfl.116.2022.12.21.01.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 01:15:45 -0800 (PST)
Message-ID: <a8ef5b8f-2dc2-808e-1f24-0e3de09b5356@igel.co.jp>
Date:   Wed, 21 Dec 2022 18:15:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] tools/virtio: fix the vringh test for virtio ring changes
Content-Language: en-US
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20221221075506.3291148-1-mie@igel.co.jp>
 <20221221091302.mxnmrnqvn7oua7nf@sgarzare-redhat>
From:   Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <20221221091302.mxnmrnqvn7oua7nf@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your quick response.

On 2022/12/21 18:13, Stefano Garzarella wrote:
> On Wed, Dec 21, 2022 at 04:55:06PM +0900, Shunsuke Mie wrote:
>> Fix the build caused by missing kmsan_handle_dma() and 
>> is_power_of_2() that
>> are used in drivers/virtio/virtio_ring.c.
>>
>> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
>> ---
>> tools/virtio/linux/cpumask.h  |  7 +++++++
>> tools/virtio/linux/gfp.h      |  7 +++++++
>> tools/virtio/linux/kernel.h   |  1 +
>> tools/virtio/linux/kmsan.h    | 12 ++++++++++++
>> tools/virtio/linux/log2.h     | 11 +++++++++++
>> tools/virtio/linux/topology.h |  7 +++++++
>> 6 files changed, 45 insertions(+)
>> create mode 100644 tools/virtio/linux/cpumask.h
>> create mode 100644 tools/virtio/linux/gfp.h
>> create mode 100644 tools/virtio/linux/kmsan.h
>> create mode 100644 tools/virtio/linux/log2.h
>> create mode 100644 tools/virtio/linux/topology.h
>>
>> diff --git a/tools/virtio/linux/cpumask.h b/tools/virtio/linux/cpumask.h
>> new file mode 100644
>> index 000000000000..307da69d6b26
>> --- /dev/null
>> +++ b/tools/virtio/linux/cpumask.h
>> @@ -0,0 +1,7 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_CPUMASK_H
>> +#define _LINUX_CPUMASK_H
>> +
>> +#include <linux/kernel.h>
>> +
>> +#endif /* _LINUX_CPUMASK_H */
>> diff --git a/tools/virtio/linux/gfp.h b/tools/virtio/linux/gfp.h
>> new file mode 100644
>> index 000000000000..43d146f236f1
>> --- /dev/null
>> +++ b/tools/virtio/linux/gfp.h
>> @@ -0,0 +1,7 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __LINUX_GFP_H
>> +#define __LINUX_GFP_H
>> +
>> +#include <linux/topology.h>
>> +
>> +#endif
>> diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
>> index 21593bf97755..8b877167933d 100644
>> --- a/tools/virtio/linux/kernel.h
>> +++ b/tools/virtio/linux/kernel.h
>> @@ -10,6 +10,7 @@
>> #include <stdarg.h>
>>
>> #include <linux/compiler.h>
>> +#include <linux/log2.h>
>> #include <linux/types.h>
>> #include <linux/overflow.h>
>> #include <linux/list.h>
>> diff --git a/tools/virtio/linux/kmsan.h b/tools/virtio/linux/kmsan.h
>> new file mode 100644
>> index 000000000000..272b5aa285d5
>> --- /dev/null
>> +++ b/tools/virtio/linux/kmsan.h
>> @@ -0,0 +1,12 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_KMSAN_H
>> +#define _LINUX_KMSAN_H
>> +
>> +#include <linux/gfp.h>
>> +
>> +inline void kmsan_handle_dma(struct page *page, size_t offset, 
>> size_t size,
>> +                 enum dma_data_direction dir)
>> +{
>> +}
>> +
>> +#endif /* _LINUX_KMSAN_H */
>> diff --git a/tools/virtio/linux/log2.h b/tools/virtio/linux/log2.h
>> new file mode 100644
>> index 000000000000..aa67bb21d8e2
>> --- /dev/null
>> +++ b/tools/virtio/linux/log2.h
>> @@ -0,0 +1,11 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifndef _LINUX_LOG2_H
>> +#define _LINUX_LOG2_H
>> +
>> +inline bool is_power_of_2(unsigned long n)
>> +{
>> +    return true;
>> +}
>
> is_power_of_2 seems defined in tools/include/linux/log2.h so
> `#include <linux/log2.h>` in tools/virtio/linux/kernel.h should be
> enough.
>
> If that's not the case, however, I think we should return true here only
> if n is really power of 2.
I'm going to check and try those.
> Thanks,
> Stefano
>
Best,

Shunsuke

