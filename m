Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E48E600639
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 07:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiJQFWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 01:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJQFWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 01:22:18 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5BF52FC6;
        Sun, 16 Oct 2022 22:22:18 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id b2so9785320plc.7;
        Sun, 16 Oct 2022 22:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6gkSgz4A9z/u94pPmICvWvMxMQ4nQAtTsf/oOCb+8c=;
        b=CyvNHlbs8X4uyOyXboay6cgqPtwFRTrsDruX49GQ2fTVAYDMeOl8aElHLD/0nz36Kt
         cCMu4VbmvxRwBM/HoQbyNaw9YyZOrhojdE4IqkEE0M7zHFkqDYnX/+ZBpwDk+GdNkTaJ
         Q2PARvllzsMMt7rfaW8raXCspOE7nxPo/R7QCOlSn2JD6Bt4EOGvANghyXmkDVzkxxZn
         sJPn0PYY4Svg5HIyT3dEg4hhLuxSUp0bV+25do89W+W8hOcydoZGqyUCn0iIuHb8FKEf
         im/nARWTu8QDB8MSQ2utciLERope4n0iUBiaqR25a92bkIY8REA1YSvzXqINLKry/thA
         apuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n6gkSgz4A9z/u94pPmICvWvMxMQ4nQAtTsf/oOCb+8c=;
        b=LFW0u08aqgfpBfTP1DyfgPTpw5z8/NXrLDjCuLjYCwnpo+SyNVHxIm6Rw+c82RPeTm
         IOQ8senjdrGKoTnlvBGrjeIAl3dZZ4k6gnytTVV5LtoRTXlyHUlFOOs01zdc4ZZSBjq0
         au6umMYe2fUceXTrWEUqTUBbS09yF9KT7PSidw/RSguJc8dIYB6zjL3EeeMDP09fcplH
         f3nS1CqhtjrwCpOgltjyWy0k56Z9jd9jmLOKtgO5TJHUPqQlcgLrGuadLPAX5sp404q4
         HsmcDIUI+PpXS45Ao/Icfha/MxHCyNn3SgdzOSXuMMnUz+iz5tBCZ5mrL3QpYd3GSe/y
         pTIw==
X-Gm-Message-State: ACrzQf1f/akxI6RuvjiDlLb/D24nNbMGb2oBswQSg31sN+V/WZEd091V
        BuAC7kAtksYGptCVZJGJxRI=
X-Google-Smtp-Source: AMsMyM6w+afqOX66jIFzfpn1e5GkaAhZt6Z7/jnHXbeTqUo/fhMbUjz3ilcOP4oaUO6P5/JrVYAZaw==
X-Received: by 2002:a17:902:d4c3:b0:185:4c1f:7457 with SMTP id o3-20020a170902d4c300b001854c1f7457mr8907285plg.117.1665984137442;
        Sun, 16 Oct 2022 22:22:17 -0700 (PDT)
Received: from [10.114.96.48] ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id e19-20020a170902ed9300b00173411a4385sm5639849plj.43.2022.10.16.22.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 22:22:16 -0700 (PDT)
Message-ID: <b760f3ab-3833-3651-24a0-ab0aea5304b7@gmail.com>
Date:   Mon, 17 Oct 2022 13:22:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [RESEND PATCH] block, bfq: remove unused variable for bfq_queue
To:     Yu Kuai <yukuai1@huaweicloud.com>, paolo.valente@linaro.org,
        axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuwei.Guan@zeekrlife.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20221017032019.101-1-Yuwei.Guan@zeekrlife.com>
 <98809bee-a5d6-d7c0-7229-4a74c6eec67f@huaweicloud.com>
From:   Yuwei Guan <ssawgyw@gmail.com>
In-Reply-To: <98809bee-a5d6-d7c0-7229-4a74c6eec67f@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/10/17 11:38, Yu Kuai wrote:
> Hi,
>
> 在 2022/10/17 11:20, Yuwei Guan 写道:
>> it defined in d0edc2473be9d, but there's nowhere to use it,
>> so remove it.
>>
>> Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
>> Acked-by: Paolo Valente <paolo.valente@linaro.org>
>> ---
>>   block/bfq-iosched.h | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
>> index 64ee618064ba..6bcef8e5871a 100644
>> --- a/block/bfq-iosched.h
>> +++ b/block/bfq-iosched.h
>> @@ -369,11 +369,8 @@ struct bfq_queue {
>>       unsigned long split_time; /* time of last split */
>>         unsigned long first_IO_time; /* time of first I/O for this 
>> queue */
>> -
>>       unsigned long creation_time; /* when this queue is created */
>>   -    /* max service rate measured so far */
>> -    u32 max_service_rate;
>
> You left two blank lines here. Have you tried checkpatch?
>
> Thanks,
> Kuai

Hi Kuai,

I checked it with checkpatch.pl, but 0 errors, 0 warnings.

I will delete one blank line, then resend it.

>>       /*
>>        * Pointer to the waker queue for this queue, i.e., to the
>>
>
