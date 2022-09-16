Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780B35BA9AA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 11:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiIPJtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 05:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIPJtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 05:49:17 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EA723BC0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 02:49:16 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id e18so9561507wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 02:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/j9nkENP/q6n9kbcfrpHdp/54X7IRFuMR2LVA0qv9ts=;
        b=cE8QbI0lA5Jgj7boFeCXuuCkXUVczJZyE7yzzXhFRqFMQbqCh0oCeWV3dbWOdfUXFF
         9EtSzsxmzR91LIX4CGrkCFWcjK5OOQVKU1hn0mwnlCr1WgVI9maib83vAVUChytx7uaR
         CmIyV1aWxSyNs4Bw2xEXY3beGpudPmL38SkSp9sFo26jrQnUmgwElYzFWOqSObt2awUK
         tF+XmX3s4UQIJshdwm24Tm2dDh7/K11gr9KwJkycSZr6nrov/j8LopHwEHCkKo/0wwao
         TkL1fhij65qUdlX70XFNV2NPdCXWUbw0EdBOjXTH41WZgxFWOLcufqLtb5MuWeWm544C
         F9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/j9nkENP/q6n9kbcfrpHdp/54X7IRFuMR2LVA0qv9ts=;
        b=q4aXpLhUB684vCmuYWgJ+6MQxzDHvjx0/d0xX6DM9c0+4UinnW68wHWQnpqDa6ob+j
         r7WXM5iO1aaJO+9Ynu7JQhkXyqQziunUyDA3YLh/ZNtRrRraE+7w1oBpE+iGswm1dXQO
         FLLTEtwjf2STP4x9EksJyrjbRZ939rUoMwzLaq0iFV/Juov+QYCVP1c39skLA3ZILjuF
         LwDHtT+NWYiBhYIhBWvlwLooFDyLqevTEKkul9F6XRctV4zxLBBDlm16YpNtM/npCHmm
         74T+RxZhgQT0iHZZhZcq8CZyOv03VUkUDON8FOES/mCA56tDgYruU+jQ2UENOW7lOBow
         b3sg==
X-Gm-Message-State: ACrzQf3vTocTA4NME1c4SyMMNJ8Npd3NV8CgkEZGJZnRckN9rMBBI+wI
        rsIjO9W7jY/wi/bU/g5n/65ZhyYsS8BRAA==
X-Google-Smtp-Source: AMsMyM7VUZ8JkQEcQ8vUusOPHMBJ6VJW/luZecMrLFw/qRlKHZxicVVQkAl6X4QYntzgUEvmvpAW+w==
X-Received: by 2002:a05:600c:3ba6:b0:3b4:9894:d482 with SMTP id n38-20020a05600c3ba600b003b49894d482mr2719232wms.120.1663321755218;
        Fri, 16 Sep 2022 02:49:15 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id f17-20020a05600c4e9100b003a5bd5ea215sm1747288wmq.37.2022.09.16.02.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 02:49:14 -0700 (PDT)
Message-ID: <4e42389e-c1c4-fe41-3bc8-03cc9a40ac0b@linaro.org>
Date:   Fri, 16 Sep 2022 10:49:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] soundwire: qcom: update status from device id 1
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sanyog.r.kale@intel.com,
        yung-chuan.liao@linux.intel.com, quic_srivasam@quicinc.com
References: <20220915124215.13703-1-srinivas.kandagatla@linaro.org>
 <3962348a-33b4-5941-4a0b-cb447a513a41@linux.intel.com>
 <bffab27c-6e25-5787-6958-648f9f2e2686@linaro.org>
 <2e1b81d2-e20f-db9f-b84e-b3c5ebb312cb@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <2e1b81d2-e20f-db9f-b84e-b3c5ebb312cb@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/09/2022 10:39, Pierre-Louis Bossart wrote:
> 
> 
> On 9/16/22 11:12, Srinivas Kandagatla wrote:
>>
>>
>> On 15/09/2022 14:10, Pierre-Louis Bossart wrote:
>>>
>>>
>>> On 9/15/22 14:42, Srinivas Kandagatla wrote:
>>>> By default autoenumeration is enabled on QCom SoundWire controller
>>>> which means the core should not be dealing with device 0 w.r.t
>>>> enumeration.
>>>> Currently device 0 status is also shared with SoundWire core which
>>>> confuses
>>>> the core sometimes and we endup adding 0:0:0:0 slave device.
>>>
>>> The change looks fine, but the description of the issue is surprising.
>>
>> Thanks Pierre,
>>
>>>
>>> Whether autoenumeration is enabled or not is irrelevant, by spec the
>>> device0 cannot be in ALERT status and throw in-band interrupts to the
>>> host with this mechanism.
>>
>> This issue is more of around enumeration stage in specific during device
>> status change interrupt from controller. Sharing the device 0 status
>> with core makes it think that there is a device with 0:0:0:0 address and
>> it tries to park device to group 13.
> Still not clear, sorry, see my comment below.


> 
>>
>>
>> --srini
>>
>>>
>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>> ---
>>>>    drivers/soundwire/qcom.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
>>>> index e21a3306bf01..871e4d8b32c7 100644
>>>> --- a/drivers/soundwire/qcom.c
>>>> +++ b/drivers/soundwire/qcom.c
>>>> @@ -428,7 +428,7 @@ static int
>>>> qcom_swrm_get_alert_slave_dev_num(struct qcom_swrm_ctrl *ctrl)
>>>>          ctrl->reg_read(ctrl, SWRM_MCP_SLV_STATUS, &val);
>>>>    -    for (dev_num = 0; dev_num <= SDW_MAX_DEVICES; dev_num++) {
>>>> +    for (dev_num = 1; dev_num <= SDW_MAX_DEVICES; dev_num++) {
>>>>            status = (val >> (dev_num * SWRM_MCP_SLV_STATUS_SZ));
>>>>              if ((status & SWRM_MCP_SLV_STATUS_MASK) ==
>>>> SDW_SLAVE_ALERT) {
> 
> can this really happen?
> 
I have not see this happening, I had to change this line for consistency 
reasons due to other changes in the patch.

Only case the issue was seen is during enumeration.

> Device0 cannot be in alert status, can it? The only this it can do is
> assert PREQ and set the Device0 status to 1 (ATTACHED). I don't get how
> a device status could be 2.
> 
> So even if the status is shared somehow,I don't see how this could be
> related to parking the device as suggested above. If the condition is
> always false then changing the loop counter from 0 to 1 would not have
> an effect?

The reason why core tries to park this device is because it sees 
status[0] as SDW_SLAVE_ATTACHED and start programming the device id, 
however reading DEVID registers return zeros which does not match to any 
of the slaves in the list and the core attempts to park this device to 
Group 13.




--srini

> 
> 
>>>> @@ -448,7 +448,7 @@ static void qcom_swrm_get_device_status(struct
>>>> qcom_swrm_ctrl *ctrl)
>>>>        ctrl->reg_read(ctrl, SWRM_MCP_SLV_STATUS, &val);
>>>>        ctrl->slave_status = val;
>>>>    -    for (i = 0; i <= SDW_MAX_DEVICES; i++) {
>>>> +    for (i = 1; i <= SDW_MAX_DEVICES; i++) {
>>>>            u32 s;
>>>>              s = (val >> (i * 2));
