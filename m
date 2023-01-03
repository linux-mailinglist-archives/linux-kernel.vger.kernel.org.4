Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F101F65C1CA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 15:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237998AbjACOXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 09:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237964AbjACOWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 09:22:55 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBCE658E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:22:52 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id bs20so27497040wrb.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 06:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ulJSyOqXIWJ2HiTvUjWjMNh2Sb0xfd3VnU0PyMIB40=;
        b=QbNv4aDS8IiMoW9MC1CUJki1IzxiOa5aDT+RPVY3ZVXQkMHonRTWDcl+2gT2SY1d5G
         gfMdlMG79DEkgwxPZWytNLVFwqFNMz9SQ5DPLEJdAR9b/cCOD5//Qeb4KXTBV50kDHgG
         w1kIYTAxedqeGFPC1vcFQr6dABTvEulf1G3P64QL62pLWa7J2MUKMSdHzolSJgtGi0UG
         mDzlg6SGTSh1X0NCdmfLLYhNTDOkG+kXzHLKwaJ4Lh8VaAaSrDwl4t3RiHO998c4GDV3
         Kd4lJs5lnYblIdsyew8U2eQ3w+eRCTznDPTd5a2CeNQh8NScNXVf+WHzOcKVC9jBT/MI
         PRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ulJSyOqXIWJ2HiTvUjWjMNh2Sb0xfd3VnU0PyMIB40=;
        b=xCBhSILCoUpH8DXbuYnxTIpGllrZJtJ3lwC1Hu6DrM45RNxvmkD68QKRiBCMLbJHo1
         cBArEuiAJkIiR+ncV6Vw/1gHpgNearctpVigICmpVumzMqUHz2SFGg2n5Ch8GyZOYrkk
         fgJsRZsGzFfQWpCzesl8P0TCT3lK2+Zy12OyCB5kLjQcivjVwKbbf+y+IGXNT5I8H2hU
         DnITLmum+IENnq2TaxZflSd6bVNXs9ZOSrdEwVMnSjS7dkBKjpRdBVsifT6b3lBkrbM6
         1zsGBcH6v2tLZT3TVO1UJJlA1V28YqVU0uJvhdgCr5V3YVHWFX01F/atGGjtUHzskrE2
         LDFg==
X-Gm-Message-State: AFqh2koXd8OR93x07aVFyE6yg5+wNXdTuf6OKTNigDNvHAIJzqkt3/0k
        pRfNfmCq7HPOdMAZ1xRfZpPOHQ==
X-Google-Smtp-Source: AMrXdXuxerG02DjJJFQvbpU+7fmKx4OJ39Q6NMAGaoEvjaa/Q2YxQpVsFtx58UK4L9DQ9xs17smENg==
X-Received: by 2002:adf:fe8f:0:b0:242:68fb:da2b with SMTP id l15-20020adffe8f000000b0024268fbda2bmr29070495wrr.18.1672755770698;
        Tue, 03 Jan 2023 06:22:50 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id h29-20020adfaa9d000000b002368f6b56desm38768641wrc.18.2023.01.03.06.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 06:22:49 -0800 (PST)
Message-ID: <b118af4c-e4cc-c50b-59aa-d768f1ec69ff@linaro.org>
Date:   Tue, 3 Jan 2023 14:22:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] nvmem: core: Fix race in nvmem_register()
Content-Language: en-US
To:     Hector Martin <marcan@marcan.st>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Eric Curtin <ecurtin@redhat.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
References: <20230103114427.1825-1-marcan@marcan.st>
 <ff77ba1c-8b67-4697-d713-0392d3b1d77a@linaro.org>
 <95a4cfde-490f-d26d-163e-7ab1400e7380@marcan.st>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <95a4cfde-490f-d26d-163e-7ab1400e7380@marcan.st>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/01/2023 13:48, Hector Martin wrote:
> On 03/01/2023 21.41, Srinivas Kandagatla wrote:
>>
>>
>> On 03/01/2023 11:44, Hector Martin wrote:
>>> nvmem_register() currently registers the device before adding the nvmem
>>> cells, which creates a race window where consumers may find the nvmem
>>> device (and not get PROBE_DEFERred), but then fail to find the cells and
>>> error out.
>>>
>>> Move device registration to the end of nvmem_register(), to close the
>>> race.
>>>
>>> Observed when the stars line up on Apple Silicon machines with the (not
>>> yet upstream, but trivial) spmi nvmem driver and the macsmc-rtc client:
>>>
>>> [    0.487375] macsmc-rtc macsmc-rtc: error -ENOENT: Failed to get rtc_offset NVMEM cell
>>>
>>> Fixes: eace75cfdcf7 ("nvmem: Add a simple NVMEM framework for nvmem providers")
>>> Cc: stable@vger.kernel.org
>>> Reviewed-by: Eric Curtin <ecurtin@redhat.com>
>>> Signed-off-by: Hector Martin <marcan@marcan.st>
>>> ---
>>
>> What has changed since v1?
> 
> What you told me to. I'm trying to get a silly bug fixed after you
> ignored my original patch until Russell independently discovered and
> submitted a fix for the same thing. I think we've wasted enough
> developer time here already.

You should remember that maintainers have other regular job and holidays 
apart from maintaining. When you last sent the patch we are already in 
near/middle of merge window. If I had applied your original patch 
without proper review, It would have introduced more regressions. Be 
patient and we/I understand your concern.

Its always possible that multiple developers hit same bug and endup in 
multiple patches, there is no way to avoid this unless every developer 
checks for similar patches on the list.

> 
>>
>>>    drivers/nvmem/core.c | 32 +++++++++++++++++---------------
>>>    1 file changed, 17 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>>> index 321d7d63e068..606f428d6292 100644
>>> --- a/drivers/nvmem/core.c
>>> +++ b/drivers/nvmem/core.c
>>> @@ -822,11 +822,8 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>>>    		break;
>>>    	}
>>>
>>> -	if (rval) {
>>> -		ida_free(&nvmem_ida, nvmem->id);
>>> -		kfree(nvmem);
>>> -		return ERR_PTR(rval);
>>> -	}
>>> +	if (rval)
>>> +		goto err_gpiod_put;
>>
>> Why was gpiod changes added to this patch, that should be a separate
>> patch/discussion, as this is not relevant to the issue that you are
>> reporting.
> 
> Because freeing the device also does a gpiod_put in the destructor, so
This are clearly untested, And I dont want this to be in the middle to 
fix to the issue you are hitting.
We should always be careful about untested changes, in this case gpiod 
has some conditions to check before doing a put. So the patch is 
incorrect as it is.

> doing this is correct in every other instance below and maintains
> existing behavior, and it just so happens that this instance converges
> into the same codepath so it is correct to merge it, and it just so
> happens that the gpiod put was missing in this path to begin with so
> this becomes a drive-by bugfix.
> 
> If you don't like it I can remove it (i.e. reintroduce the bug for no
> good reason) and you can submit this fix yourself, because I have no
> incentive to waste time submitting a separate patch to fix a GPIO leak
> in an error path corner case in a subsystem I don't own and I have much
> bigger things to spend my (increasingly lower and lower) willingness to
> fight for upstream submissions than this.
> 
> Seriously, what is wrong with y'all kernel people. No other open source
> project wastes contributors' time with stupid nitpicks like this. I

These are not stupid nit picks your v1/v2 patches introduced memory 
leaks and regressions so i will not be picking up any patches that fall 
in that area.

> found a bug, I fixed it, I then fixed the issues you pointed out, and I
> don't have the time nor energy to fight over this kind of nonsense next.

I think its worth reading ./Documentation/process/submitting-patches.rst


thanks,
Srini
> Do you want bugs fixed or not?
> 
>>>
>>>    	nvmem->read_only = device_property_present(config->dev, "read-only") ||
>>>    			   config->read_only || !nvmem->reg_write;
>>> @@ -837,20 +834,16 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>>>
>>>    	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
>>>
>>> -	rval = device_register(&nvmem->dev);
>>> -	if (rval)
>>> -		goto err_put_device;
>>> -
>>>    	if (nvmem->nkeepout) {
>>>    		rval = nvmem_validate_keepouts(nvmem);
>>>    		if (rval)
>>> -			goto err_device_del;
>>> +			goto err_gpiod_put;
>>>    	}
>>>
>>>    	if (config->compat) {
>>>    		rval = nvmem_sysfs_setup_compat(nvmem, config);
>>>    		if (rval)
>>> -			goto err_device_del;
>>> +			goto err_gpiod_put;
>>>    	}
>>>
>>>    	if (config->cells) {
>>> @@ -867,6 +860,15 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>>>    	if (rval)
>>>    		goto err_remove_cells;
>>>
>>> +	rval = device_register(&nvmem->dev);
>>> +	if (rval) {
>>> +		nvmem_device_remove_all_cells(nvmem);
>>> +		if (config->compat)
>>> +			nvmem_sysfs_remove_compat(nvmem, config);
>>> +		put_device(&nvmem->dev);
>>> +		return ERR_PTR(rval);
>>> +	}
>>> +
>>>    	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
>>>
>>>    	return nvmem;
>>> @@ -876,10 +878,10 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>>>    err_teardown_compat:
>>>    	if (config->compat)
>>>    		nvmem_sysfs_remove_compat(nvmem, config);
>>> -err_device_del:
>>> -	device_del(&nvmem->dev);
>>> -err_put_device:
>>> -	put_device(&nvmem->dev);
>>> +err_gpiod_put:
>>> +	gpiod_put(nvmem->wp_gpio);
>>> +	ida_free(&nvmem_ida, nvmem->id);
>>> +	kfree(nvmem);
>>>
>>>    	return ERR_PTR(rval);
>>>    }
>>> --
>>> 2.35.1
>>>
>>
> 
> 
> - Hector
