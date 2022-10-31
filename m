Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560DD613A06
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbiJaPan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiJaPaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:30:39 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFDF55B9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:30:38 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so11057283wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5mDFR+RdO5huNZUkaxvUa34t0tWmRPvuIvqKzwNCrQ8=;
        b=zM4Ptw7pwKvXYbBX8jpa7nx3vE4BgHPmo0NBjPHn4aE8ZCIcBcM8t4JOf+ykucHdeO
         MwsfX04iBFvui7i8iQPdqS+myiBg3mxKKzkrorC6x6XGrWbI9BdaxhjXoJuL6CwDidRY
         bqGcqN5sos3PYumnpo1gNga4ibjhZd82GYIV0AxvxfzzNE7ZFUOkH9Gj78VQYdvCWZtE
         3K0ijJO0d8BIB7xUcTPkhyvw/+xfvwvxsVi3RUEGuE/leGaf8DOSWz3Q71Jn//gCNv3e
         XgBZtQXg1AUBq1bs7dv3TsOF/lX9+vWaqYYXfBsXI0Tgpssuo7hC43mNRiIK0SAAe4+Q
         B0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5mDFR+RdO5huNZUkaxvUa34t0tWmRPvuIvqKzwNCrQ8=;
        b=k70ivM+zfxBB2DLFs32YSgHGi1EdQs/5cKm3xvgX5eXkYBQsSS3k7NklAM70Pk0y73
         4N1v0gIzDxuHYTCj52Gv+P8uJ9793ChSurWfZYcELZyALWPFVEA6qTuI67daV5cJaFDo
         PD1rOzMcrns8yr8mWBrfXOH4cDI3KEkv5KtIapMqWeHGlaOl3IO1h4sOWgJFBvSxyfuT
         /FgMiu2pQrQ9cEHtt1AHsGMtTYbkqZye3mnoAD0SoWi/TH23VY3ZNzSkl0dJZD8cKdyX
         f6CFSohNzWkcGyC+vDhtyiD2Y661hwnPYyrH5PGok86hNZ/OtoYC65+vKFNqXsvJfNV+
         v1aw==
X-Gm-Message-State: ACrzQf051xGrEQPhSdDzOdiqPKVS0ObFPkI10erOE3JpDUNBhv+E8u1t
        Rpqm9VZq57saI1p3K3q8CC7Kt9DR3u5rcA==
X-Google-Smtp-Source: AMsMyM7jVFi+PWvxtkxE8R2pac8ui3ZWT24W5dldRRiou7BmXSeyz2y+BNnaPYEzaVceZlbXb7koEQ==
X-Received: by 2002:a05:600c:4f81:b0:3c8:3424:8b9 with SMTP id n1-20020a05600c4f8100b003c8342408b9mr18092867wmq.149.1667230237082;
        Mon, 31 Oct 2022 08:30:37 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:34f:ed70:97ca:71f8:f780:5cf1? ([2a0d:e487:34f:ed70:97ca:71f8:f780:5cf1])
        by smtp.gmail.com with ESMTPSA id l20-20020a5d5274000000b0022cbf4cda62sm9348146wrc.27.2022.10.31.08.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 08:30:36 -0700 (PDT)
Message-ID: <bba2bb57-05ce-ca0e-f215-60588a1af88c@linaro.org>
Date:   Mon, 31 Oct 2022 16:30:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] mfd: rk808: permit having multiple PMIC instances
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20221025-rk808-multi-v1-0-c07b7cf3fd67@linaro.org>
 <Y1/oGhqPZNvyVTkY@google.com>
Content-Language: en-US
Organization: Linaro Developer Services
In-Reply-To: <Y1/oGhqPZNvyVTkY@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31/10/2022 16:22, Lee Jones wrote:
> On Tue, 25 Oct 2022, Neil Armstrong wrote:
> 
>> This set each cells id to -1 to allow multiple instances of
>> each cell in case multiple PMICs handled by the rk808 driver
>> are probed.
>>
>> This fixes probing a RK818 and a RK817 on the Odroid Go Ultra
>> devices.
> 
> No issue with the premise Neil, but would you be kind enough to use
> the define provided (PLATFORM_DEVID_NONE) instead of the magic number
> please?

Sure, will re-spin asap with PLATFORM_DEVID_NONE

Thanks,
Neil

> 
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>> Cc: Lee Jones <lee@kernel.org>
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   drivers/mfd/rk808.c | 26 ++++++++++++++++----------
>>   1 file changed, 16 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
>> index e00da7c7e3b1..b9cfd249912d 100644
>> --- a/drivers/mfd/rk808.c
>> +++ b/drivers/mfd/rk808.c
>> @@ -137,58 +137,64 @@ static const struct resource rk817_charger_resources[] = {
>>   };
>>   
>>   static const struct mfd_cell rk805s[] = {
>> -	{ .name = "rk808-clkout", },
>> -	{ .name = "rk808-regulator", },
>> -	{ .name = "rk805-pinctrl", },
>> +	{ .name = "rk808-clkout", .id = -1, },
>> +	{ .name = "rk808-regulator", .id = -1, },
>> +	{ .name = "rk805-pinctrl", .id = -1, },
>>   	{
>>   		.name = "rk808-rtc",
>>   		.num_resources = ARRAY_SIZE(rtc_resources),
>>   		.resources = &rtc_resources[0],
>> +		.id = -1,
>>   	},
>>   	{	.name = "rk805-pwrkey",
>>   		.num_resources = ARRAY_SIZE(rk805_key_resources),
>>   		.resources = &rk805_key_resources[0],
>> +		.id = -1,
>>   	},
>>   };
>>   
>>   static const struct mfd_cell rk808s[] = {
>> -	{ .name = "rk808-clkout", },
>> -	{ .name = "rk808-regulator", },
>> +	{ .name = "rk808-clkout", .id = -1, },
>> +	{ .name = "rk808-regulator", .id = -1, },
>>   	{
>>   		.name = "rk808-rtc",
>>   		.num_resources = ARRAY_SIZE(rtc_resources),
>>   		.resources = rtc_resources,
>> +		.id = -1,
>>   	},
>>   };
>>   
>>   static const struct mfd_cell rk817s[] = {
>> -	{ .name = "rk808-clkout",},
>> -	{ .name = "rk808-regulator",},
>> +	{ .name = "rk808-clkout", .id = -1, },
>> +	{ .name = "rk808-regulator", .id = -1, },
>>   	{
>>   		.name = "rk805-pwrkey",
>>   		.num_resources = ARRAY_SIZE(rk817_pwrkey_resources),
>>   		.resources = &rk817_pwrkey_resources[0],
>> +		.id = -1,
>>   	},
>>   	{
>>   		.name = "rk808-rtc",
>>   		.num_resources = ARRAY_SIZE(rk817_rtc_resources),
>>   		.resources = &rk817_rtc_resources[0],
>> +		.id = -1,
>>   	},
>> -	{ .name = "rk817-codec",},
>> +	{ .name = "rk817-codec", .id = -1, },
>>   	{
>>   		.name = "rk817-charger",
>>   		.num_resources = ARRAY_SIZE(rk817_charger_resources),
>>   		.resources = &rk817_charger_resources[0],
>> +		.id = -1,
>>   	},
>>   };
>>   
>>   static const struct mfd_cell rk818s[] = {
>> -	{ .name = "rk808-clkout", },
>> -	{ .name = "rk808-regulator", },
>> +	{ .name = "rk808-regulator", .id = -1, },
>>   	{
>>   		.name = "rk808-rtc",
>>   		.num_resources = ARRAY_SIZE(rtc_resources),
>>   		.resources = rtc_resources,
>> +		.id = -1,
>>   	},
>>   };
>>   
>>
>> ---
>> base-commit: 247f34f7b80357943234f93f247a1ae6b6c3a740
>> change-id: 20221025-rk808-multi-65dd03a92705
>>
>> Best regards,
> 

