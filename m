Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8BC5BDBD6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 06:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiITExz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 00:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiITExv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 00:53:51 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F60E58DC9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 21:53:50 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e16so2320257wrx.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 21:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Vyg2BS4OgoN4PABi0kgWr5r2OkJO3xdUk2Gib7RnQ68=;
        b=pV5NEnzzTDNCMhIzv9W9eopezRmZC6OUF2OXuGZ9QRaxsXFUqT/5cgWD4AGCTFPCTe
         TZim8aD+ldgXRmWVldy/lzKLR+IMaFm+0C190mV2ozj8V6y+ZSJSHpJ7IqXJJmosUFCe
         4s8uLn1Bdg6rHPn6jCHn4OCyydLcbXzMGG8Z95MxVdlW+HPfIuqdrxfT+ZZ1c4VomHc5
         NEuDuICS60ulIQzhJeDcTXqLVO3ycKcpMSZy7bsh4eRkUTJFGdMQaEhG5WhycshOQivE
         nnUAE2gwIcb396TpI3cZHfZJWe9Ly9qgiXY2cVxwIZvbIlM88m9tp5qVxNmE0YewNwmX
         8rLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Vyg2BS4OgoN4PABi0kgWr5r2OkJO3xdUk2Gib7RnQ68=;
        b=Ok4ZUntZfdwgkLWaPtstGJydtxwweI0mT9tRlrbJvFZ+lsBthK13S0U3Hcwyr83Bfj
         T/fGrVq6QWQqZpsZQgUPyogszZhIVEudToXoS1tsUj2qQCptTm5glYNF2qgoFbFXr6x5
         mJZP0N81FUp3nhpUPMzlX7T5vhseOuPDAbt1xG80JK/d7Bot/GCkbkGtir/VX0hMK/HZ
         f5YkSFXQKyl/KUbfER5F4+C5UxstNIrYDMjTUoEUxy+HsRih9WtNRoq/cf+H4/QS1ouL
         kagAKZ1cvIFs70SuprehPv5os3oxEbq9p4vPqF8/vwsRlp87IZJQrDv8C3J0gedkQkNb
         BvYA==
X-Gm-Message-State: ACrzQf3rW0OBnl6VDS2IdITQPy0ZuuBFz7Yxt1fYr8UZdPuSVcKVtOkj
        osY/LsGkMNQdyucX2fB/ZDbMCg==
X-Google-Smtp-Source: AMsMyM5T6ErMvRyjiulCy6Ti1NqzRjFy2W7YBOLNH2YjQZqju8DY9WfnCm2AB5oJUKaKhAVsKpJbhw==
X-Received: by 2002:adf:d08d:0:b0:22a:4560:9c29 with SMTP id y13-20020adfd08d000000b0022a45609c29mr12541726wrh.579.1663649628800;
        Mon, 19 Sep 2022 21:53:48 -0700 (PDT)
Received: from ?IPV6:2003:d9:970b:c00:6690:5cde:f1af:9517? (p200300d9970b0c0066905cdef1af9517.dip0.t-ipconnect.de. [2003:d9:970b:c00:6690:5cde:f1af:9517])
        by smtp.googlemail.com with ESMTPSA id r13-20020adfa14d000000b0022af5e36981sm522866wrr.9.2022.09.19.21.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 21:53:48 -0700 (PDT)
Message-ID: <8d74a7d4-b80f-2a0f-ee95-243bdbd51ccd@colorfullife.com>
Date:   Tue, 20 Sep 2022 06:53:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v6 2/2] ipc/msg: mitigate the lock contention with percpu
 counter
To:     "Sun, Jiebin" <jiebin.sun@intel.com>, akpm@linux-foundation.org,
        vasily.averin@linux.dev, shakeelb@google.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, ebiederm@xmission.com,
        legion@kernel.org, alexander.mikhalitsyn@virtuozzo.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tim.c.chen@intel.com, feng.tang@intel.com, ying.huang@intel.com,
        tianyou.li@intel.com, wangyang.guo@intel.com,
        Tim Chen <tim.c.chen@linux.intel.com>
References: <20220902152243.479592-1-jiebin.sun@intel.com>
 <20220913192538.3023708-1-jiebin.sun@intel.com>
 <20220913192538.3023708-3-jiebin.sun@intel.com>
 <aadf6c7e-dea8-4dff-1815-cca9c2c2da9e@colorfullife.com>
 <6ed22478-0c89-92ea-a346-0349be2dd99c@intel.com>
Content-Language: en-US
From:   Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <6ed22478-0c89-92ea-a346-0349be2dd99c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/22 04:36, Sun, Jiebin wrote:
>
> On 9/18/2022 8:53 PM, Manfred Spraul wrote:
>> Hi Jiebin,
>>
>> On 9/13/22 21:25, Jiebin Sun wrote:
>>> The msg_bytes and msg_hdrs atomic counters are frequently
>>> updated when IPC msg queue is in heavy use, causing heavy
>>> cache bounce and overhead. Change them to percpu_counter
>>> greatly improve the performance. Since there is one percpu
>>> struct per namespace, additional memory cost is minimal.
>>> Reading of the count done in msgctl call, which is infrequent.
>>> So the need to sum up the counts in each CPU is infrequent.
>>>
>>> Apply the patch and test the pts/stress-ng-1.4.0
>>> -- system v message passing (160 threads).
>>>
>>> Score gain: 3.99x
>>>
>>> CPU: ICX 8380 x 2 sockets
>>> Core number: 40 x 2 physical cores
>>> Benchmark: pts/stress-ng-1.4.0
>>> -- system v message passing (160 threads)
>>>
>>> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
>>> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
>> Reviewed-by: Manfred Spraul <manfred@colorfullif.com>
>>> @@ -495,17 +496,18 @@ static int msgctl_info(struct ipc_namespace 
>>> *ns, int msqid,
>>>       msginfo->msgssz = MSGSSZ;
>>>       msginfo->msgseg = MSGSEG;
>>>       down_read(&msg_ids(ns).rwsem);
>>> -    if (cmd == MSG_INFO) {
>>> +    if (cmd == MSG_INFO)
>>>           msginfo->msgpool = msg_ids(ns).in_use;
>>> -        msginfo->msgmap = atomic_read(&ns->msg_hdrs);
>>> -        msginfo->msgtql = atomic_read(&ns->msg_bytes);
>>> +    max_idx = ipc_get_maxidx(&msg_ids(ns));
>>> +    up_read(&msg_ids(ns).rwsem);
>>> +    if (cmd == MSG_INFO) {
>>> +        msginfo->msgmap = percpu_counter_sum(&ns->percpu_msg_hdrs);
>>> +        msginfo->msgtql = percpu_counter_sum(&ns->percpu_msg_bytes);
>>
>> Not caused by your change, it just now becomes obvious:
>>
>> msginfo->msgmap and ->msgtql are type int, i.e. signed 32-bit, and 
>> the actual counters are 64-bit.
>> This can overflow - and I think the code should handle this. Just 
>> clamp the values to INT_MAX.
>>
> Hi Manfred,
>
> Thanks for your advice. But I'm not sure if we could fix the overflow 
> issue in ipc/msg totally by
>
> clamp(val, low, INT_MAX). If the value is over s32, we might avoid the 
> reversal sign, but still could
>
> not get the accurate value.

I think just clamping it to INT_MAX is the best approach.
Reporting negative values is worse than clamping. If (and only if) there 
are real users that need to know the total amount of memory allocated 
for messages queues in one namespace, then we could add a MSG_INFO64 
with long values. But I would not add that right now, I do not see a 
real use case where the value would be needed.

Any other opinions?

--

     Manfred

