Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EF5690D8E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjBIPuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjBIPtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:49:51 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53555FC2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 07:49:49 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id qb15so5580174ejc.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 07:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZvbDxphreobTfyTz56K8iceNEMC0+serSIcYlN+OIZc=;
        b=nCcn+CK4ryoNFdFSsEAqd9X3rb30IJ0SkNdlG7bAd6ZwN8R4QCxvmVCDuJKlIUXMAj
         SkVab0ayTprP7B7OdtwQUnydFgxelvzmE+EO3ioKnJATc5RqNramMdx4azErLjnpDomD
         LtxmZrpwutQbz6W23mHwDk4D2mN7DJFEHs2LiPVhpeKqJxZm7s/06q2ShYJ0msbmLR4l
         xKjucp0u2L/m68v+GhBrD/MkGAW11iqMUvixwPP+bvZwPbBUhxjEaAF0kt5ikK1fT03O
         u1eG7QGruyll1HUDisES2paIGEJO9e49qeRBef5D6LAyfJyNQvzbrZ211CvuTlYuLRnW
         eCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvbDxphreobTfyTz56K8iceNEMC0+serSIcYlN+OIZc=;
        b=ADs6zAo6TQzbG9ZhyrLwIcvvlrA0RcWvvQ72IytmOUlMGJC2bnT3Xx4K9ae58FJ3TV
         KxmDhuWKY5jFt6Pji+N9S9i/80fvpKkR488AijQZhGORQsX4cyJMybT2nLZ/ljDuCacv
         qSE2+3D6HE2huT00twoguYRVwoACB239XcdyH6nQZ0YTrif6LIeKok/oqyQZ29Xk644e
         wP4hlyfSbEbjFmNgtY6xF+OhadPbCSImIv4pUxE9CVJOknYilRePMZzEsmGfsZpZNsUQ
         23CJG8JXeCUR1FcdgaqSe60O+O+XWRqO5ZEsBji4Vi+4AO6u9joXo7330I6oMs1k9A85
         ct8Q==
X-Gm-Message-State: AO0yUKViMgdOdTjgmR2TQK09RZVwXyX0JYXLrbxVauxvh8zKksarP0sU
        I/VKfiK+RMZywnUJct1hgtvsQg==
X-Google-Smtp-Source: AK7set8cvSHlfYpbVpKbj8ojMEE8gNz6UFVKIAFXX5Svs8eFpRRB16Ynoc6eBzeVrRO31H6ymFMQ9g==
X-Received: by 2002:a17:906:6b8b:b0:879:2a5:dc40 with SMTP id l11-20020a1709066b8b00b0087902a5dc40mr11812346ejr.76.1675957788332;
        Thu, 09 Feb 2023 07:49:48 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id m10-20020a170906580a00b0086f4b8f9e42sm1017358ejq.65.2023.02.09.07.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 07:49:47 -0800 (PST)
Message-ID: <920f0b73-238e-8923-2344-98ac5cc96d7d@linaro.org>
Date:   Thu, 9 Feb 2023 15:49:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/5] soundwire: qcom: enable runtime pm before controller
 is registered
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        johan+linaro@kernel.org, quic_bjorande@quicinc.com
References: <20230209131336.18252-1-srinivas.kandagatla@linaro.org>
 <20230209131336.18252-3-srinivas.kandagatla@linaro.org>
 <92a2560a-74cd-aa13-fea6-7619e355b26e@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <92a2560a-74cd-aa13-fea6-7619e355b26e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/02/2023 15:21, Pierre-Louis Bossart wrote:
> 
> 
> On 2/9/23 07:13, Srinivas Kandagatla wrote:
>> Registering controller even before pm runtime is enabled will result
>> in pm runtime underflow warnings. Fix this by properly moving
>> the runtime pm enable before registering controller.
> 
> That seems very odd. The Intel code configures the pm_runtime stuff
> *after* the call to sdw_bus_master_add(), and we've not seen any
> underflow warnings? We even configure pm_runtime after starting the bus.
> Likewise for peripherals the pm_runtime part is enabled after the device
> is initialized.
> 
This was very random during bootup, Let me see if I can collect a back 
trace after reverting this patch..

--srini

> Not following the problem and suggested solution.
> 
>> Fixes: 74e79da9fd46 ("soundwire: qcom: add runtime pm support")
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/soundwire/qcom.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
>> index 9d8ae77bad0a..b2363839624c 100644
>> --- a/drivers/soundwire/qcom.c
>> +++ b/drivers/soundwire/qcom.c
>> @@ -1417,6 +1417,12 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>>   		}
>>   	}
>>   
>> +	pm_runtime_set_autosuspend_delay(dev, 3000);
>> +	pm_runtime_use_autosuspend(dev);
>> +	pm_runtime_mark_last_busy(dev);
>> +	pm_runtime_set_active(dev);
>> +	pm_runtime_enable(dev);
>> +
>>   	ret = sdw_bus_master_add(&ctrl->bus, dev, dev->fwnode);
>>   	if (ret) {
>>   		dev_err(dev, "Failed to register Soundwire controller (%d)\n",
>> @@ -1435,12 +1441,6 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>>   		 (ctrl->version >> 24) & 0xff, (ctrl->version >> 16) & 0xff,
>>   		 ctrl->version & 0xffff);
>>   
>> -	pm_runtime_set_autosuspend_delay(dev, 3000);
>> -	pm_runtime_use_autosuspend(dev);
>> -	pm_runtime_mark_last_busy(dev);
>> -	pm_runtime_set_active(dev);
>> -	pm_runtime_enable(dev);
>> -
>>   	/* Clk stop is not supported on WSA Soundwire masters */
>>   	if (ctrl->version <= 0x01030000) {
>>   		ctrl->clock_stop_not_supported = true;
