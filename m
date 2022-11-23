Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C94E634B90
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 01:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiKWAOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 19:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbiKWAOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 19:14:32 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7C6D53BF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 16:14:31 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id k7so15177794pll.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 16:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qSXez7TMqEXPVH18DMil2V+wMo2ZAq8fU8n9Svrm0YU=;
        b=ttIttDPZTykCFPR3yUs+dkffd67+C/A5MJ4fjN6FD+7T43G1YL8Nk6mcVeB9JjVkXw
         gi32sFfDUwtdO5dpXDeb6QBf2ncMZm9XF8fJGMkN+1ZgADqJ8mjuxQeYoQ13AG+PRwID
         h0N+LcbcG84cYpzmSdiSPiimEhxTrl/3izqU9Oki/3QOcg9DwKHTId350Q05Xu/5q03W
         +RzHliDUY0k/H2L7qOGzhs5f+mLdOuKqxRlwV1RAfI1afEZ1ol4mDSxmGEnUF4zV6lYS
         C9LS/8OzmHlDuxle0r1MBda7KUlW6NkHgcdYImd+cbzJWGzZbf5s5Z6jIbhuljCi95bI
         Xc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qSXez7TMqEXPVH18DMil2V+wMo2ZAq8fU8n9Svrm0YU=;
        b=goxZ+z55M/z3A8jisM9ATtBCg4k3RyjHJXT8RHy/GL6Cgay9eCb8/KZm6EW0ItMgtW
         xp5GZb3LcqGlS/6Nnb/6wU1zskVHvDaXRkLOnVv0rMpBLp2VlG9o0KHsVX5pfcSv1xqO
         pqRbPoa8I9kFJn1SFdHExBa6pZqE5Vw5C7M8FXbu+lnnxJV34ihE+q4UZtMDCpYowJLi
         wP054Agzt1dP21/wVct2mbi+hWFdrbtHLZp9faSb6t9VoYidwucPGT2H/b+n/h3ZlZZr
         fO/5X3Qs5WPGTWMKJA6UJKH0M3Ct8FZUGdlHuw+jjlLiYYN6ZhOKNNkFMbzwPPJP73nT
         odBw==
X-Gm-Message-State: ANoB5plepHSEsILEiAaaFdM72R5tGIfIL1PKSNOeiKP4JoAj2k90C1cq
        BnFonFGbnwQVFERBDuNZIoQTnw==
X-Google-Smtp-Source: AA0mqf6GVtLxBNKUS6oMjDNlawwIOIT8MPUoiUGJO7VE6o0/Tx/aXX+y/u3LzT2gGYwHKQocQeQDMA==
X-Received: by 2002:a17:902:7b96:b0:188:b0db:cd5d with SMTP id w22-20020a1709027b9600b00188b0dbcd5dmr7458453pll.104.1669162470773;
        Tue, 22 Nov 2022 16:14:30 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902e88300b00186985198a4sm12753838plg.169.2022.11.22.16.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 16:14:30 -0800 (PST)
Message-ID: <1f52ccb1-c357-a2a0-ef9d-48d7e2eb51f8@kernel.dk>
Date:   Tue, 22 Nov 2022 17:14:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 4/5] blk-iocost: fix sleeping in atomic context
 warnning
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, josef@toxicpanda.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20221104023938.2346986-1-yukuai1@huaweicloud.com>
 <20221104023938.2346986-5-yukuai1@huaweicloud.com>
 <Y3K8MSFWw8eTnxtm@slm.duckdns.org>
 <3da991c6-21e4-8ed8-ba75-ccb92059f0ae@huaweicloud.com>
 <Y306xJV6aNXd94kb@slm.duckdns.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y306xJV6aNXd94kb@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/22 2:10 PM, Tejun Heo wrote:
> On Thu, Nov 17, 2022 at 07:28:50PM +0800, Yu Kuai wrote:
>> Hi, Tejun!
>>
>> 在 2022/11/15 6:07, Tejun Heo 写道:
>>
>>>
>>> Any chance I can persuade you into updating match_NUMBER() helpers to not
>>> use match_strdup()? They can easily disable irq/preemption and use percpu
>>> buffers and we won't need most of this patchset.
>>
>> Does the following patch match your proposal?
>>
>> diff --git a/lib/parser.c b/lib/parser.c
>> index bcb23484100e..ded652471919 100644
>> --- a/lib/parser.c
>> +++ b/lib/parser.c
>> @@ -11,6 +11,24 @@
>>  #include <linux/slab.h>
>>  #include <linux/string.h>
>>
>> +#define U64_MAX_SIZE 20
>> +
>> +static DEFINE_PER_CPU(char, buffer[U64_MAX_SIZE]);
>> +
>> +static char *get_buffer(void)
>> +{
>> +       preempt_disable();
>> +       local_irq_disable();
>> +
>> +       return this_cpu_ptr(buffer);
>> +}
>> +
>> +static void put_buffer(void)
>> +{
>> +       local_irq_enable();
>> +       preempt_enable();
>> +}
>> +
>>
>> Then match_strdup() and kfree() in match_NUMBER() can be replaced with
>> get_buffer() and put_buffer().
> 
> Sorry about the late reply. Yeah, something like this.

Doesn't local_irq_disable() imply preemption disable as well?

-- 
Jens Axboe


