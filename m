Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807B95FE328
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 22:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiJMUOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 16:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJMUOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 16:14:21 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9253A18DC15;
        Thu, 13 Oct 2022 13:14:03 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o17-20020a17090aac1100b0020d98b0c0f4so4556688pjq.4;
        Thu, 13 Oct 2022 13:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fQ0RTMXid+yvfopB0Z9Ush/4I0H7oBpQisS3WhSB0a8=;
        b=BJqFjVmTxQ8onS0OYCt4QiSKY4IFnRU/gt1M9kwt41J8n/eGw7g/JwUcUCfTJdSFOQ
         oARsSO5tWzyOMcdTAuPPL/18R7vn2kKUGYpGQl2Yzv5wjfT2lDDRd+E+nxJcPyNq9FSy
         iLMwd0fmsIt/QE1Ly5iztf5r5yr6cWa5fV1o5tucmChLTExnsiDSX8L5Zx/O02lCut6V
         pqVztux/IPbPzvw3zU4XxOq/P4TxRmMbWPE2QTzKKpq40vp4Sq44dBkV8ttNrGANzPrs
         ZDM96vbPD2qhbWq9jr1NESFMTu7wgeuks/kaerkVs32FhGSIjLir209yZjd8u82fYWRW
         mKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQ0RTMXid+yvfopB0Z9Ush/4I0H7oBpQisS3WhSB0a8=;
        b=A2y3tc3vZd0mXjUephLiLq6AQcku5b13wj5Cj5xNgM7mNyRNR8NeM2KVUJ9KUIyv2I
         ctTDnpzUDffDMGZZZvgwDI4Upky7gCEwZi+cnp2p3/c/QvT7bHMw9Etx/YEbIHbEQNRE
         F+ZOcz/DEdA6uU/WyptVZ/cm/utNGFJNfJXZekZ3o0H7VM0/zarSoQADOAdiGezHTKjB
         ldwI9Tei6621sruXil6bpU9WJhRyNyvl9hXMK1apWRsS2tLHT85Xk/r3usKO1b1fsZk4
         7o5LUPxE5c8+imvxMOPhQrNF8Z/NZI+EsR5Xem+mKrcO7CkP8r+H46QrQ+6RMtrJRFDa
         k0oQ==
X-Gm-Message-State: ACrzQf0CjEUTh90ONXu8Ai+2RvnZdF+yQrTpHr+gqOBj+mnQEJAn3vf3
        jTXawHfiCNGqu/aLLil4TLQ=
X-Google-Smtp-Source: AMsMyM634CQ53S3LbQ7fF1oVeNsygl48Kfa8h7AF+DhI+q8S+1zaq5jXcQ7ACu9zSgq69SvywFtrpw==
X-Received: by 2002:a17:90b:3b45:b0:20c:2eae:e70 with SMTP id ot5-20020a17090b3b4500b0020c2eae0e70mr1659944pjb.240.1665692042857;
        Thu, 13 Oct 2022 13:14:02 -0700 (PDT)
Received: from [172.30.1.63] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id y64-20020a62ce43000000b0053e72ed5252sm113386pfg.42.2022.10.13.13.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 13:14:02 -0700 (PDT)
Message-ID: <d47932c5-492c-32a6-f36c-f7dbef91bc0a@gmail.com>
Date:   Fri, 14 Oct 2022 05:13:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] devfreq: Support device update function
Content-Language: en-US
To:     Johnny Liu <johnliu@nvidia.com>
Cc:     cw00.choi@samsung.com, kyungmin.park@samsung.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        myungjoo.ham@samsung.com
References: <24e701e9-b560-5350-a2f7-89e2a4a1c97a@gmail.com>
 <20221013051627.17171-1-johnliu@nvidia.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20221013051627.17171-1-johnliu@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 10. 13. 14:16, Johnny Liu wrote:
> Thanks for your quick response and detailed comments. I will prepare a new patch
> series to include the user of the proposed function. But still I answer your
> concerns in the following sections.
> 
> On Thu, 13 Oct 2022 04:44, Chanwoo Choi wrote:
>> Hi,
>>
>> Basically, struct devfreq_dev_profile is used to pass the devfreq device data
>> from devfreq driver to governor. But, This means that it passes
>> the data from governor to devfreq driver reversely?
> 
> Yes, it means that governor can pass data to devfreq driver reversely.

Until now, all governors just passed the next target frequency to devfreq core.
It is different behavior against before governors. When you send v2,
I'll check them more detailed.

> 
>> On 22. 10. 3. 15:02, Johnny Liu wrote:
>>> To realize interrupt-driven closed-loop governors, governors need to be
>>
>> Could you explain the detailed means of 'interrupt-driven closed-loop governors'?
> 
> For term "interrupt-driven", it means the DFS logic is triggered by interrupts
> rather than performing DFS in a polling fashion. This can reduce the CPU load.

Thanks.

> 
> For term "closed-loop", it means that there is a target metric the governor will
> try to keep it at certain value/level. For example, if the target metric means
> device utilization, then the governor should perform DFS so that it will keep
> device utilization at certain level specified by the user.

If I understand right, the device utilization is such as 
exynos-nocp.c, exynos-ppmu.c, rockchip-dfi.c under drivers/devfreq/event.

Usually, governor keeps the following step to decide the next frequency:
1. governor collects the device status by using profile->get_dev_status
2. the specific devfreq driver try to get dev_status in case of that exynos-bus.c
   has used the drivers/devfreq/event/exynos-ppmu.c to get the device utilization.
3. governor decides the next target frequency by using the collected dev_status
4. devfreq core adjusts the target frequency
	with both user-input via /sys/class/devfreq/*/min_freq, max_freq
	and qos-value of DEV_PM_QOS_MIN_FREQUENCY, DEV_PM_QOS_MAX_FREQUENCY

As I understand, you mentioned that need to limit the min/max device utilization
scope such as DEV_PM_QOS_MIN_FREQUENCY, DEV_PM_QOS_MAX_FREQUENCY?

Instead of setting the min/max value of device utilization,
the devfreq core has already adjusted the final target frequency
on above 4 step by using user-inpu and qos-value.

If possible, I'd like you to explain it with the more detailed example
why user should specify the level of device utilization. 

> 
>>> able to send data to the underlying devfreq driver to ask for updating
>>> the device settings, such as hardware registers for frequency limits,
>>
>> I think that governor is not able to get the hardware information direclty
>> instead of devfreq driver. Usually, the devfreq driver should get the
>> h/w info and then passed to governor if required.
> 
> Yes, governor should not be able to the HW info directly. From my perspective,
> I think governor should be able to pass down hint, such as device utilization
> specified by the user in the governor, to the devfreq driver. Then, the
> devfreq driver can configure the device accordingly so that interrupts get
> triggered when device utilization exceeds or drops by certain amount.

As I mentioned above, the device utilization was transferred from devfreq driver
to governor by using struct devfreq_dev_status as following sequence.
	devfreq driver -> devfreq core -> governor

We better to discuss with your next version patches
with real use-case for understanding because your suggestion is different
from existing communication between governor and devfreq core/driver.

I'll expect of what is meaning of 'down hint'.

> 
>> Lastly, this patch doesn't contain the any use-case of devfreq_update_dev().
>> I prefer to post the real use-case of this patch.
> 
> I will include the user of it in a new patch series.

Thanks. I'll expect v2 patches.

> 
>>> which are compared against the device frequency to generate interrupts
>>>
>>> Since governors might export several tunable parameters, users can
>>> enforce different policies for the control logics. Under different
>>> policies, governors need to send different information to inform the
>>> devfreq driver to configure the device accordingly.
>>>
>>> The introduced update function improves the flexibility of governors
>>> and acts as a communication interface between governors and devfreq
>>> drivers.
>>>
>>> Signed-off-by: Johnny Liu <johnliu@nvidia.com>
>>> ---
>>> v2: Correct the function signature of devfreq_update_dev
>>>
>>>  drivers/devfreq/governor.h | 8 ++++++++
>>>  include/linux/devfreq.h    | 8 ++++++++
>>>  2 files changed, 16 insertions(+)
>>>
>>> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
>>> index 0adfebc0467a..b5781fa549c7 100644
>>> --- a/drivers/devfreq/governor.h
>>> +++ b/drivers/devfreq/governor.h
>>> @@ -124,4 +124,12 @@ static inline int devfreq_update_stats(struct devfreq *df)
>>>
>>>  	return df->profile->get_dev_status(df->dev.parent, &df->last_status);
>>>  }
>>> +
>>> +static inline int devfreq_update_dev(struct devfreq *df, void *data)
>>> +{
>>> +	if (!df->profile->update)
>>> +		return -EINVAL;
>>> +
>>> +	return df->profile->update(df->dev.parent, data);
>>> +}
>>>  #endif /* _GOVERNOR_H */
>>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>>> index 34aab4dd336c..91648e8f8d76 100644
>>> --- a/include/linux/devfreq.h
>>> +++ b/include/linux/devfreq.h
>>> @@ -92,6 +92,8 @@ struct devfreq_dev_status {
>>>   *			devfreq.last_status.
>>>   * @get_cur_freq:	The device should provide the current frequency
>>>   *			at which it is operating.
>>> + * @update:		An optional function to allow governors send data back
>>> + *			to the devfreq driver to update the device settings.
>>
>> IMO, 'update' word is too generic. I think that 'update_device_data' is better
>> to improve the readability.
> 
> Yes, "update_device_data" has better readability compared to "update".
> 
>>>   * @exit:		An optional callback that is called when devfreq
>>>   *			is removing the devfreq object due to error or
>>>   *			from devfreq_remove_device() call. If the user
>>> @@ -114,6 +116,7 @@ struct devfreq_dev_profile {
>>>  	int (*get_dev_status)(struct device *dev,
>>>  			      struct devfreq_dev_status *stat);
>>>  	int (*get_cur_freq)(struct device *dev, unsigned long *freq);
>>> +	int (*update)(struct device *dev, void *data);
>>>  	void (*exit)(struct device *dev);
>>>
>>>  	unsigned long *freq_table> @@ -451,6 +454,11 @@ static inline int devfreq_update_stats(struct devfreq *df)
>>>  {
>>>  	return -EINVAL;
>>>  }
>>> +
>>> +static inline int devfreq_update_dev(struct devfreq *df, void *data)
>>> +{
>>> +	return -EINVAL;
>>> +}
>>>  #endif /* CONFIG_PM_DEVFREQ */
>>>
>>>  #endif /* __LINUX_DEVFREQ_H__ */
> 
> --
> Best Regards,
> Johnny Liu


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
