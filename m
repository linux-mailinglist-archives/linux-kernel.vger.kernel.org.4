Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E36F5BA911
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 11:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiIPJMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 05:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiIPJMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 05:12:18 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4171C6F251
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 02:12:16 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r5-20020a1c4405000000b003b494ffc00bso755743wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 02:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=mlaT4dkUmey+WYaJiYLCVZ+l1HaRfFbeV5h9SKJM/6M=;
        b=d2qcsHqlhbDrF7hMGXrk69KrkRyLIM0KsG91A88dSqc6m9oNU1AhLqbkfHn8VmenI/
         faZhxTdqbshYTPV9bEjex0lIx+MEaqaRYWNMjODryyYJghYdTfe+IM44WgcXKC0+Xk3E
         tHgLeNzdUd8oDDGNNqs6zSfLOBfoJb9Va6Wu2yltaC76HdSpeKeqiU1PxmT087DesfNO
         YGti+RSQwXKJ1t8reFU09wD/o3J2G7aQa2WkTWfG3TuRUiV26WyvB/CWS/kpYI5PtDD9
         IrF1hnEVclUlYlEZ28m0i2nD++dPzrUOX4OaWIWt1mHoNweIcgpi3xfaMyo+ylLk7oMC
         Nptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=mlaT4dkUmey+WYaJiYLCVZ+l1HaRfFbeV5h9SKJM/6M=;
        b=uTBM3XETqFnOix169lURrQ/CBma2PY0Ad712tr4IS+01mWsH9amY7gQcii/xoBzC58
         mnVxD3PGwfEWakZC/RQ5YiAu4N2fUhOq4kjLMO9RWmB2z7Jcy3LESqagbVpj4K/eIdX/
         2vp025N6KWfIOrbT+6QGNtI/GNBt8bNv3CFUIQ9slAYxVAKBQ/hN9V1pSMe0qcm8kI7k
         WnDAz/vBkBk91o/WH6HkcUNy/iTHfb3DivaTdSNkFibowGzrfUuqbO8WrpIe4F9tRvul
         nblORj/v6luXfSMqNZpDG+KQsXJ4Y/TzgpPIHQJZQOH3WAmXx+5893tsuQ/aR8KZpF+T
         IbFg==
X-Gm-Message-State: ACrzQf2V9hpps0pC64PREGmowwqC908m/wVC5RX2uoEWUzjjH1PafB1v
        6kNDnaSL2r9utZ4wluh7m9TZPzUxEr3JTw==
X-Google-Smtp-Source: AMsMyM79yY6pM1sgA9nNRpDt7+rngES5wrlzIG0j+hKlNPLl69x36Kw8WIt0JsZYVmOh4GFlD5sIKQ==
X-Received: by 2002:a05:600c:3d05:b0:3b4:9a42:10d0 with SMTP id bh5-20020a05600c3d0500b003b49a4210d0mr2682614wmb.135.1663319534795;
        Fri, 16 Sep 2022 02:12:14 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id e4-20020a05600c4e4400b003a6a3595edasm1580200wmq.27.2022.09.16.02.12.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 02:12:13 -0700 (PDT)
Message-ID: <bffab27c-6e25-5787-6958-648f9f2e2686@linaro.org>
Date:   Fri, 16 Sep 2022 10:12:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] soundwire: qcom: update status from device id 1
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
References: <20220915124215.13703-1-srinivas.kandagatla@linaro.org>
 <3962348a-33b4-5941-4a0b-cb447a513a41@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <3962348a-33b4-5941-4a0b-cb447a513a41@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/09/2022 14:10, Pierre-Louis Bossart wrote:
> 
> 
> On 9/15/22 14:42, Srinivas Kandagatla wrote:
>> By default autoenumeration is enabled on QCom SoundWire controller
>> which means the core should not be dealing with device 0 w.r.t enumeration.
>> Currently device 0 status is also shared with SoundWire core which confuses
>> the core sometimes and we endup adding 0:0:0:0 slave device.
> 
> The change looks fine, but the description of the issue is surprising.

Thanks Pierre,

> 
> Whether autoenumeration is enabled or not is irrelevant, by spec the
> device0 cannot be in ALERT status and throw in-band interrupts to the
> host with this mechanism.

This issue is more of around enumeration stage in specific during device 
status change interrupt from controller. Sharing the device 0 status 
with core makes it think that there is a device with 0:0:0:0 address and 
it tries to park device to group 13.


--srini

> 
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/soundwire/qcom.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
>> index e21a3306bf01..871e4d8b32c7 100644
>> --- a/drivers/soundwire/qcom.c
>> +++ b/drivers/soundwire/qcom.c
>> @@ -428,7 +428,7 @@ static int qcom_swrm_get_alert_slave_dev_num(struct qcom_swrm_ctrl *ctrl)
>>   
>>   	ctrl->reg_read(ctrl, SWRM_MCP_SLV_STATUS, &val);
>>   
>> -	for (dev_num = 0; dev_num <= SDW_MAX_DEVICES; dev_num++) {
>> +	for (dev_num = 1; dev_num <= SDW_MAX_DEVICES; dev_num++) {
>>   		status = (val >> (dev_num * SWRM_MCP_SLV_STATUS_SZ));
>>   
>>   		if ((status & SWRM_MCP_SLV_STATUS_MASK) == SDW_SLAVE_ALERT) {
>> @@ -448,7 +448,7 @@ static void qcom_swrm_get_device_status(struct qcom_swrm_ctrl *ctrl)
>>   	ctrl->reg_read(ctrl, SWRM_MCP_SLV_STATUS, &val);
>>   	ctrl->slave_status = val;
>>   
>> -	for (i = 0; i <= SDW_MAX_DEVICES; i++) {
>> +	for (i = 1; i <= SDW_MAX_DEVICES; i++) {
>>   		u32 s;
>>   
>>   		s = (val >> (i * 2));
