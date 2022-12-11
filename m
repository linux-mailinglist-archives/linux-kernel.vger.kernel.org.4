Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C833649431
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 13:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiLKMaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 07:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiLKMaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 07:30:17 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AF6C76E
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 04:30:16 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id gt4so7615530pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 04:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXB5W428WcmiLDh9olLI0YAELLNF2UnndQkJgDlXhtk=;
        b=KoKtLqBOByRsEcfyjWQLuoxwGM6iAXlVuWfSMJXj9gBME51IW/0T1ov2mSja5aLe0k
         CZrLrdq7nVtdxx4W+kmUZXSK+MCyz+oe8mfuZnDeH32DxROtXrP3k5xQb46uskeXZfN5
         mtTBe4T7GKZvsm79NJFSxYX1nZ2l+YyyHXYi4DJsnI/DwruI/SYZ+e632zlegMxYxW8G
         TIym35cFXDp5I2wtgeUynjAQIHYETZql6kELmLYGJhos2h6fL6FXEsI0IwjAASWRa+um
         annuXZ0cwr0d5pf4ayx5w/5rsxfgL/oFVxzauPt5PlpI+Hu8w0TnDeXGtdF7iXTnRD21
         rlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TXB5W428WcmiLDh9olLI0YAELLNF2UnndQkJgDlXhtk=;
        b=Xkct3gckd8N987k7BsRTSsYawsJhA1/WxgaMFaKANE7BieiM0xG2qHS4j7bQO+5djL
         c15ydsGRObgRCvjaZkPD2J9UHo05cpJtJcuTzuvnFaUMwgHgwVPTkd5Yukveo7Xw8zps
         Au1cuc5S+gwjepoRGqOGRQRg4jFXUkXyDUbCLFBTnQdYhPBODqe3Wiobg6fNE42LHCrh
         3xQqjMQt5vHSjNMveY4W3D4RZs1h+LkwrF7AelzNBiWW3uuTxRxvK4Lhqo4JKs8dpFL+
         iYQOsYcoVm2VZZIv0hkWN/E6ViHx7pchGpTKpPH/+inzDt5Ey2a8H2xKgZYPjFOr1xNj
         nWBg==
X-Gm-Message-State: ANoB5plciqQgj87sKFr87g6lQUjzCW9fSsXSdbTEUPi84L+PMm1DqjRN
        3/33rJD3GdLmNEVtBTTtw+M=
X-Google-Smtp-Source: AA0mqf5KGDAJiOQZeIj6Gt4exWhqZP2aizPD5q3LuOo2o9CDxLBTTIMEfZaGP3etGnf+MCPuvTU+Fg==
X-Received: by 2002:a17:902:e30a:b0:189:deeb:8c94 with SMTP id q10-20020a170902e30a00b00189deeb8c94mr11162599plc.22.1670761816017;
        Sun, 11 Dec 2022 04:30:16 -0800 (PST)
Received: from [127.0.0.1] (ec2-18-162-209-88.ap-east-1.compute.amazonaws.com. [18.162.209.88])
        by smtp.gmail.com with ESMTPSA id x19-20020a633113000000b00478dad38eacsm3528425pgx.38.2022.12.11.04.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Dec 2022 04:30:15 -0800 (PST)
Message-ID: <3b51e6ae-5df5-60c4-3261-557b44e34291@gmail.com>
Date:   Sun, 11 Dec 2022 20:30:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] f2fs: do decrease_sleep_time() if any of the victims have
 been selected
To:     Chao Yu <chao@kernel.org>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
References: <20221209112813.73700-1-Yuwei.Guan@zeekrlife.com>
 <810bd221-1f35-db79-e9f3-a521464b3eaf@kernel.org>
From:   Yuwei Guan <ssawgyw@gmail.com>
In-Reply-To: <810bd221-1f35-db79-e9f3-a521464b3eaf@kernel.org>
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



在 2022/12/11 10:52, Chao Yu 写道:
> On 2022/12/9 19:28, Yuwei Guan wrote:
>> In non-foreground gc mode, if no victim is selected, the gc process
>> will wait for no_gc_sleep_time before waking up again. In this
>> subsequent time, even though a victim will be selected, the gc process
>> still waits for no_gc_sleep_time before waking up. The configuration
>> of wait_ms is not reasonable.
>>
>> After any of the victims have been selected, we need to do
>> decrease_sleep_time() to reduce wait_ms.
>>
>> If it is GC_URGENT_HIGH or GC_URGENT_MID gc mode,
>> wait_ms will keep urgent_sleep_time after executing 
>> decrease_sleep_time().
>>
>> In decrease_sleep_time() wait_time will be reduced to max_sleep_time
>> from no_gc_sleep_time, if *wait is no_gc_sleep_time. And then it goes
>> down in the next step.
>>
>> Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
>> ---
>>   fs/f2fs/gc.c | 2 ++
>>   fs/f2fs/gc.h | 7 ++++++-
>>   2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index f0c6506d8975..c023ffeb9268 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -141,6 +141,8 @@ static int gc_thread_func(void *data)
>>               /* don't bother wait_ms by foreground gc */
>>               if (!foreground)
>>                   wait_ms = gc_th->no_gc_sleep_time;
>> +        } else {
>> +            decrease_sleep_time(gc_th, &wait_ms);
> 
> Once BGGC selects valid victim, it will go faster and fater?
> > How about:
> 
>      } else {
>          /* reset wait_ms to default sleep time */
>          if (wait_ms == gc_th->no_gc_sleep_time)
>              wait_ms = gc_th->min_sleep_time;
>      }
Indeed. it will go faster and fater, until wait_ms reduces to 
min_sleep_time. But your suggestion seems more reasonable, I will send 
it in v2 patch.
> 
> Thanks,
> 
>>           }
>>           if (foreground)
>> diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
>> index 19b956c2d697..6402584dcd72 100644
>> --- a/fs/f2fs/gc.h
>> +++ b/fs/f2fs/gc.h
>> @@ -150,8 +150,13 @@ static inline void decrease_sleep_time(struct 
>> f2fs_gc_kthread *gc_th,
>>   {
>>       unsigned int min_time = gc_th->min_sleep_time;
>> -    if (*wait == gc_th->no_gc_sleep_time)
>> +    if (*wait == gc_th->urgent_sleep_time)
>> +        return;
>> +
>> +    if (*wait == gc_th->no_gc_sleep_time) {
>>           *wait = gc_th->max_sleep_time;
>> +        return;
>> +    }
>>       if ((long long)*wait - (long long)min_time < (long long)min_time)
>>           *wait = min_time;
