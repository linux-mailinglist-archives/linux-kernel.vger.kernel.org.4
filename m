Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87275EA886
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbiIZOfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbiIZOer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:34:47 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D5088A10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 05:53:25 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id b75so6595839pfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 05:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=JfI/MQ3cqMqiBUWply4+srFdGKgWiHs9QbzXGnedrjw=;
        b=py/jOoP+LNdmJsrwUiecLbM+RTy9qdwEEAUALnxViUcmpv12jPLZ1j8G3Pfx7DLDqV
         K99WGoTIFAGynejfWry3s0e5BHXkn0fc2ohyqEpW0Evq54sfrnUjTnwSrmsvgRz+BRqo
         k/Lzkdml0LQ6B0ieqaNEV73WkMwrBW4yi/P9OYlCbEW6X3FUNcd3N4VpE2fdgeEXPM70
         JpCnbC5hJuxY73hbCc6CnKtUyCoyoBco8sXVwsObAYGR/2GGLe4ZcYGdFRSYrxpyLa35
         z32e9L5Ukv6DsMO6XpMMJErLNKv9h9nndfxOliXE3TUOnAE9XbqHiG2IoRhKG0sJfqOF
         zYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=JfI/MQ3cqMqiBUWply4+srFdGKgWiHs9QbzXGnedrjw=;
        b=DaatloEU3YnWeCNmpRpROodb7cRj6d3Pb1L7pDIXCNi1r9h25D+ATJrYlCKsvuw+0q
         sMIH5KIvZ1/cs9g1sSxxszVKJcitvxEBuNcsMsKbweYBPS55yfvlK7ofBCkPhv1QVVz6
         pyOc3j2rZPEsAXkZLI/CYqJa5gBaPjR3yQuQDycZi5d2FZFRwnvQE3Ls9dA9wCotITEi
         v94HwwflWwIoQlZ5cw19o/YZQ5zFmB2jJIjwruuNmcK60jZt3l8gnaTBEJzrYwpy9iOI
         MFA6h+qwl14VFBuyrQrOSHMrvBHh8CgpXyO1gEj10tL/9o1G1lhCMuRhLm9bfLUHkp/I
         Reng==
X-Gm-Message-State: ACrzQf1wj7Su605quh0a1qzcSYTW1YzcybcARCdzldTIvvAJLbZHEr9v
        KqdltAitfTstDjc8nYkKxKkCJQ==
X-Google-Smtp-Source: AMsMyM4pRwA8C32gEkFcBudu2gl4n1YxKWuI7PaQvRSdl0XKQx52Sa6xuC252+HH/8g8/i7QCjy3LA==
X-Received: by 2002:a62:6085:0:b0:53e:7874:5067 with SMTP id u127-20020a626085000000b0053e78745067mr23937829pfb.4.1664196804856;
        Mon, 26 Sep 2022 05:53:24 -0700 (PDT)
Received: from [10.68.76.92] ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id q20-20020aa78434000000b0053fcb800ec0sm12107196pfn.9.2022.09.26.05.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 05:53:24 -0700 (PDT)
Message-ID: <24b20953-eca9-eef7-8e60-301080a17d2d@bytedance.com>
Date:   Mon, 26 Sep 2022 20:53:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [External] Re: [RFC] proc: Add a new isolated /proc/pid/mempolicy
 type.
To:     Michal Hocko <mhocko@suse.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        wuyun.abel@bytedance.com
References: <20220926091033.340-1-hezhongkun.hzk@bytedance.com>
 <YzF3aaLvEvFhTQa3@dhcp22.suse.cz>
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
In-Reply-To: <YzF3aaLvEvFhTQa3@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> [Cc linux-api - please do so for any patches making/updating
> kernel<->user interfaces]
> 
> 
> On Mon 26-09-22 17:10:33, hezhongkun wrote:
>> From: Zhongkun He <hezhongkun.hzk@bytedance.com>
>>
>> /proc/pid/mempolicy can be used to check and adjust the userspace task's
>> mempolicy dynamically.In many case, the application and the control plane
>> are two separate systems. When the application is created, it doesn't know
>> how to use memory, and it doesn't care. The control plane will decide the
>> memory usage policy based on different reasons.In that case, we can
>> dynamically adjust the mempolicy using /proc/pid/mempolicy interface.
> 
> Is there any reason to make it procfs interface rather than pidfd one?

Hi michal,  thanks for your reply.

I just think that it is easy to display and adjust the mempolicy using 
procfs. But it may not be suitable, I will send a pidfd_set_mempolicy 
patch later.

Btw.in order to add per-thread-group mempolicy, is it possible to add 
mempolicy in mm_struct?


