Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DBC649421
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 13:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiLKMIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 07:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiLKMIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 07:08:46 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46781FCDF
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 04:08:44 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id jl24so9346661plb.8
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 04:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WrHr/ARwnMyppm++yunzPxOr+kEprrwqMrIKFv+XIU=;
        b=NKtFvqzh0GHJdhTuyl8EatAHdryR01F6HQEMJNRDaDOuxCepmMGCLP72sSFp9gVMM7
         gygK2XTYA6YB9wdjJuJhKyrDCGd8+E2bvYP1+E5i6tnzpRvzVoNTesbIEU0IxQuQNtBd
         cXL3gmU9k9vplNNnWoDlULalhfziN+Me0plYqafFdeV71B3y7/xKu0DcJMcjlA2qfNju
         GEIN1h276n1tvlqmS4WDUa1MiJytO3gvN+P/9T/6vpPGEIaMojt3KnVmLA8htg9QN/uC
         CLDvzl0LClM3jOFa/Y+F+9pNIY64/zAL2nXzOp3cRkze1ifE27FpgFtwUIx11/k8iJ1v
         bRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9WrHr/ARwnMyppm++yunzPxOr+kEprrwqMrIKFv+XIU=;
        b=oSG6Iz57c1+zelQ0WMMiWaBIgyZZXlCVbfxwdk7pXs0xttmgF49EJycgCVNPeLX1bF
         Mt5VuOeFEUefsz4d5PAE44yArkQlyirADOA0N+h7/XxJLlA3l1b8I2IhIqYYK4yAiCJN
         3AgkcaiHAGst01tGfQzNWFZ0tUL7IKSHtHCfjzYVOeNFOJ23ok6edHhmeFLLoHBgn0X5
         WPhqG+U3QX6oOrk1LxbW3GvLdQM1nsr31KO3cwZ6tIHJ1Zk4A88w2FQ8K8Qj55zkZxrV
         Ix9Lm+Tskw7vc5pyO0HNDTkoJEQ94Tiw+7VLYuwSa4oNVbklfvV/ueVQt/RW5I5hLNiX
         72lg==
X-Gm-Message-State: ANoB5pmv7OwCRc69qzFoh74W661cHJIDnknW6jasbmjCc2nvD1ucgbWV
        q67XOJj38MvOA1DJJj0W3MxvYLcWAX8JJQ==
X-Google-Smtp-Source: AA0mqf6I8yxImjueeWCqD2/eos0s/WkdQT7MJbHro4tD1yZF6qlRgRjP54rcihxZSpmZms4el5rxgQ==
X-Received: by 2002:a05:6a21:3398:b0:a4:bd66:6201 with SMTP id yy24-20020a056a21339800b000a4bd666201mr19735663pzb.59.1670760523767;
        Sun, 11 Dec 2022 04:08:43 -0800 (PST)
Received: from [127.0.0.1] (ec2-18-162-209-88.ap-east-1.compute.amazonaws.com. [18.162.209.88])
        by smtp.gmail.com with ESMTPSA id a21-20020aa794b5000000b00574b86040a4sm3956601pfl.3.2022.12.11.04.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Dec 2022 04:08:43 -0800 (PST)
Message-ID: <547e58b1-942e-8beb-29a2-3920184c46a0@gmail.com>
Date:   Sun, 11 Dec 2022 20:08:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] f2fs: continuous counting for 'issued' in
 __issue_discard_cmd_orderly()
To:     Chao Yu <chao@kernel.org>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
References: <20221121161101.72847-1-Yuwei.Guan@zeekrlife.com>
 <7368c57a-141e-86b0-365f-8af795940483@kernel.org>
From:   Yuwei Guan <ssawgyw@gmail.com>
In-Reply-To: <7368c57a-141e-86b0-365f-8af795940483@kernel.org>
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



在 2022/12/11 10:36, Chao Yu 写道:
> On 2022/11/22 0:11, Yuwei Guan wrote:
>> As the 'dcc->discard_granularity' and 'dcc->max_ordered_discard' can 
>> be set
>> at the user space, and if the 'dcc->max_ordered_discard' is set larger 
>> than
>> 'dcc->discard_granularity' in DPOLICY_BG mode, or it's a volume device,
>> discard_granularity can be tuned to 1 in f2fs_tuning_parameters(),
>> it will may send more requests than the number of 'dpolicy->max_requests'
>> in issue_discard_thread().
>>
>> This patch will fix the issue.
>>
>> Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
>> ---
>>   fs/f2fs/segment.c | 17 ++++++++---------
>>   1 file changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 8b0b76550578..b0157bf392fb 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -1379,8 +1379,8 @@ static int __queue_discard_cmd(struct 
>> f2fs_sb_info *sbi,
>>       return 0;
>>   }
>> -static unsigned int __issue_discard_cmd_orderly(struct f2fs_sb_info 
>> *sbi,
>> -                    struct discard_policy *dpolicy)
>> +static int __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
>> +                    struct discard_policy *dpolicy, int *issued)
>>   {
>>       struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
>>       struct discard_cmd *prev_dc = NULL, *next_dc = NULL;
>> @@ -1388,7 +1388,6 @@ static unsigned int 
>> __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
>>       struct discard_cmd *dc;
>>       struct blk_plug plug;
>>       unsigned int pos = dcc->next_pos;
>> -    unsigned int issued = 0;
>>       bool io_interrupted = false;
>>       mutex_lock(&dcc->cmd_lock);
>> @@ -1415,9 +1414,9 @@ static unsigned int 
>> __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
>>           }
>>           dcc->next_pos = dc->lstart + dc->len;
>> -        err = __submit_discard_cmd(sbi, dpolicy, dc, &issued);
>> +        err = __submit_discard_cmd(sbi, dpolicy, dc, issued);
>> -        if (issued >= dpolicy->max_requests)
>> +        if (*issued >= dpolicy->max_requests)
>>               break;
>>   next:
>>           node = rb_next(&dc->rb_node);
>> @@ -1433,10 +1432,10 @@ static unsigned int 
>> __issue_discard_cmd_orderly(struct f2fs_sb_info *sbi,
>>       mutex_unlock(&dcc->cmd_lock);
>> -    if (!issued && io_interrupted)
>> -        issued = -1;
>> +    if (!(*issued) && io_interrupted)
>> +        *issued = -1;
>> -    return issued;
>> +    return *issued;
> 
> A little weired that __issue_discard_cmd_orderly() will output the data
> in both return value and @issued parameter.
> 
Got it.
> How about changing type of return value __issue_discard_cmd_orderly()
> from unsigned int to void.
> 
I will sent a v2 patch for this.
> Thanks,
> 
>>   }
>>   static unsigned int __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
>>                       struct discard_policy *dpolicy);
>> @@ -1465,7 +1464,7 @@ static int __issue_discard_cmd(struct 
>> f2fs_sb_info *sbi,
>>               break;
>>           if (i + 1 < dcc->max_ordered_discard && dpolicy->ordered)
>> -            return __issue_discard_cmd_orderly(sbi, dpolicy);
>> +            return __issue_discard_cmd_orderly(sbi, dpolicy, &issued);
>>           pend_list = &dcc->pend_list[i];
