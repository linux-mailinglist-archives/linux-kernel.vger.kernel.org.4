Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F185FCB6B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 21:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiJLTTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 15:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJLTTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 15:19:18 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF5D102DFC;
        Wed, 12 Oct 2022 12:19:08 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id b15so16132846pje.1;
        Wed, 12 Oct 2022 12:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6fX48vIWYpjViCZeXxicInI+kxNPFmk1lK5Wh8mOwOE=;
        b=hkf1+ecZnUs6So29ZrMzVhnpZJIc7YvWAraVgbsVnnRWZEJ6Z1lwp8UxBEsRbTwTwr
         H8/IPCQ1QX1OA9//RJK3tfbSMEtAo2QVs/qo0jR0I4pI16ALkwNw3OnVptrBI3kxavel
         zbA8MPtvTI03WPz0Dloz53jm1H8J3TTp4MtiliFW8gND3R/wG/aObAuHxga5ylwt5QNZ
         gzPWsRnKwQbBuebprJWh4agaVwkZ8Nk7xe1Ue8o6AzppUH6mDNuR6vWZObWwovfPdy88
         Dm/TXUNA3Chit+RmBaxbbIoI8s4PUFM0/poMjOlxhLB5P3rTHcLUvwGdtvBeTiMWNTkw
         cZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6fX48vIWYpjViCZeXxicInI+kxNPFmk1lK5Wh8mOwOE=;
        b=CAOjKOYfC70dSAF1YM3GgIaOKSMskyqZWJkQeIKhYhdeI4xOU7YaGaZlkffioMbPGu
         gzgW/LFkK/DTKjdfQPYTp6FJAFlts5nLBrA/3HZnttfRDHjSwCtrV5E373mjcJ26jsVO
         /B8y13Kje439A+UQA0iLonJjDZLVE0mHb/1W72RooppY1XPMCmGQ8mWXtWD2FRXE4f5c
         tWvggCzk3BCUFPR0UP8qlp9iVkfFYNvCFW3ULa0o56Me4at2wR8s5R2VaZOOt8J4ERWv
         RrsR5g7DU/h4HMKef/omLlaucr5lTSaU9NNU9WYrwn7tDDfnz/QEgI4CvcpVe5VrF63l
         yDTg==
X-Gm-Message-State: ACrzQf3gEXpiPucR04hduv7jrsC9uc4KCESy6t2+NKAmDWzZYc8/KZxc
        yyGp8np/RrmADsEx8e2ChGA=
X-Google-Smtp-Source: AMsMyM6eTdTcJhsmb+6koMRnl4pt5nemqWVsWU6ktVqtB8uM40UucIJ4B8qmiHyNDzjH6U/E/dBS5g==
X-Received: by 2002:a17:90b:1bcb:b0:20d:75b8:ee64 with SMTP id oa11-20020a17090b1bcb00b0020d75b8ee64mr6821059pjb.162.1665602347623;
        Wed, 12 Oct 2022 12:19:07 -0700 (PDT)
Received: from [172.30.1.63] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id z4-20020a170902ccc400b0018003571809sm10692908ple.224.2022.10.12.12.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 12:19:07 -0700 (PDT)
Message-ID: <abc402b1-1253-fe94-94c4-afb1dfb9aebd@gmail.com>
Date:   Thu, 13 Oct 2022 04:19:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] devfreq: governor: Add a private governor_data for
 governors in devfreq
Content-Language: en-US
From:   Chanwoo Choi <cwchoi00@gmail.com>
To:     Kant Fan <kant@allwinnertech.com>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221010072202.78731-1-kant@allwinnertech.com>
 <00ed0b46-54db-330e-8ff8-146ff9a09491@gmail.com>
In-Reply-To: <00ed0b46-54db-330e-8ff8-146ff9a09491@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 10. 13. 04:00, Chanwoo Choi wrote:
> Hi,
> 
> I'm sorry for late reply. It looks good to me.
> Instead, this patch should contain the 'Fixes' information
> with the following commit because the changed code was merged
> on the patch[1]. Also, need to send it to stable mailing list.
> 
> [1] ce26c5bb9569d8b826f01b8620fc16d8da6821e9
> PM / devfreq: Add basic governors
> 
> Lastly, I think that need to change the patch title as following:
> - PM / devfreq: governor: Add a private governor_data for governor
> 
> 
> On 22. 10. 10. 16:22, Kant Fan wrote:
>> The member void *data in the structure devfreq can be overwrite
>> by governor_userspace. For example:
>> 1. The device driver assigned the devfreq governor to simple_ondemand
>> by the function devfreq_add_device() and init the devfreq member
>> void *data to a pointer of a static structure devfreq_simple_ondemand_data
>> by the function devfreq_add_device().
>> 2. The user changed the devfreq governor to userspace by the command
>> "echo userspace > /sys/class/devfreq/.../governor".
>> 3. The governor userspace alloced a dynamic memory for the struct
>> userspace_data and assigend the member void *data of devfreq to
>> this memory by the function userspace_init().
>> 4. The user changed the devfreq governor back to simple_ondemand
>> by the command "echo simple_ondemand > /sys/class/devfreq/.../governor".
>> 5. The governor userspace exited and assigned the member void *data
>> in the structure devfreq to NULL by the function userspace_exit().
>> 6. The governor simple_ondemand fetched the static information of
>> devfreq_simple_ondemand_data in the function
>> devfreq_simple_ondemand_func() but the member void *data of devfreq was
>> assigned to NULL by the function userspace_exit().
>> 7. The information of upthreshold and downdifferential is lost
>> and the governor simple_ondemand can't work correctly.
>>
>> The member void *data in the structure devfreq is designed for
>> a static pointer used in a governor and inited by the function
>> devfreq_add_device(). This patch add an element named governor_data
>> in the devfreq structure which can be used by a governor(E.g userspace)
>> who want to assign a private data to do some private things.
>>
>> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>>
>> Signed-off-by: Kant Fan <kant@allwinnertech.com>
>> ---
>>  drivers/devfreq/governor_userspace.c | 12 ++++++------
>>  include/linux/devfreq.h              |  7 ++++---
>>  2 files changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
>> index ab9db7adb3ad..d69672ccacc4 100644
>> --- a/drivers/devfreq/governor_userspace.c
>> +++ b/drivers/devfreq/governor_userspace.c
>> @@ -21,7 +21,7 @@ struct userspace_data {
>>  
>>  static int devfreq_userspace_func(struct devfreq *df, unsigned long *freq)
>>  {
>> -	struct userspace_data *data = df->data;
>> +	struct userspace_data *data = df->governor_data;
>>  
>>  	if (data->valid)
>>  		*freq = data->user_frequency;
>> @@ -40,7 +40,7 @@ static ssize_t set_freq_store(struct device *dev, struct device_attribute *attr,
>>  	int err = 0;
>>  
>>  	mutex_lock(&devfreq->lock);
>> -	data = devfreq->data;
>> +	data = devfreq->governor_data;
>>  
>>  	sscanf(buf, "%lu", &wanted);
>>  	data->user_frequency = wanted;
>> @@ -60,7 +60,7 @@ static ssize_t set_freq_show(struct device *dev,
>>  	int err = 0;
>>  
>>  	mutex_lock(&devfreq->lock);
>> -	data = devfreq->data;
>> +	data = devfreq->governor_data;
>>  
>>  	if (data->valid)
>>  		err = sprintf(buf, "%lu\n", data->user_frequency);
>> @@ -91,7 +91,7 @@ static int userspace_init(struct devfreq *devfreq)
>>  		goto out;
>>  	}
>>  	data->valid = false;
>> -	devfreq->data = data;
>> +	devfreq->governor_data = data;
>>  
>>  	err = sysfs_create_group(&devfreq->dev.kobj, &dev_attr_group);
>>  out:
>> @@ -107,8 +107,8 @@ static void userspace_exit(struct devfreq *devfreq)
>>  	if (devfreq->dev.kobj.sd)
>>  		sysfs_remove_group(&devfreq->dev.kobj, &dev_attr_group);
>>  
>> -	kfree(devfreq->data);
>> -	devfreq->data = NULL;
>> +	kfree(devfreq->governor_data);
>> +	devfreq->governor_data = NULL;
>>  }
>>  
>>  static int devfreq_userspace_handler(struct devfreq *devfreq,
>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>> index 34aab4dd336c..d265af3fb0a4 100644
>> --- a/include/linux/devfreq.h
>> +++ b/include/linux/devfreq.h
>> @@ -152,8 +152,8 @@ struct devfreq_stats {
>>   * @max_state:		count of entry present in the frequency table.
>>   * @previous_freq:	previously configured frequency value.
>>   * @last_status:	devfreq user device info, performance statistics
>> - * @data:	Private data of the governor. The devfreq framework does not
>> - *		touch this.
>> + * @data:	devfreq core pass to governors, governor should not change it.

In addition, the devfreq driver pass the 'data' from devfreq driver
to governor by using devfreq_add_device. I think that 'devfreq driver'
is more proper 

* @data:	devfreq driver pass to governors, governor should not change it.

And then, there are extra changes required.

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 63347a5ae599..0c59b7978391 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -776,8 +776,7 @@ static void remove_sysfs_files(struct devfreq *devfreq,
  * @dev:       the device to add devfreq feature.
  * @profile:   device-specific profile to run devfreq.
  * @governor_name:     name of the policy to choose frequency.
- * @data:      private data for the governor. The devfreq framework does not
- *             touch this value.
+ * @data:      devfreq driver pass to governors, governor should not change it.
  */
 struct devfreq *devfreq_add_device(struct device *dev,
                                   struct devfreq_dev_profile *profile,
@@ -1011,8 +1010,7 @@ static void devm_devfreq_dev_release(struct device *dev, void *res)
  * @dev:       the device to add devfreq feature.
  * @profile:   device-specific profile to run devfreq.
  * @governor_name:     name of the policy to choose frequency.
- * @data:      private data for the governor. The devfreq framework does not
- *             touch this value.
+ * @data:      devfreq driver pass to governors, governor should not change it.
  *
  * This function manages automatically the memory of devfreq device using device
  * resource management and simplify the free operation for memory of devfreq

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
