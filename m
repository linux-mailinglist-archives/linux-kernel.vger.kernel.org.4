Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2316E0687
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 07:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjDMFsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 01:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDMFsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 01:48:12 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367014490;
        Wed, 12 Apr 2023 22:48:11 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id h37so838315lfv.0;
        Wed, 12 Apr 2023 22:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681364889; x=1683956889;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2J3hZLfv4Ais2nnWyi587H3aSP1FPUxtsM5ow+18kMQ=;
        b=hScxUxQrvFBaYjsK+DYKLVYeuf9dgqHaXSmHyX0lFVolQ5paLNlhSsKloQwcYkE4is
         Vv5V5MoCWp5utMwzKEhvD9vTvfRFcqXU68GZtfTypkBJ+/5vY8UhJep/uaMOa0gh4og6
         WMNCkic2SBgh8d78SYdLKd3zfFfjIYp4RopADKQ4rGwLQpqvnwlFkLCQhTMxJcx/fFJX
         4akIywPcyE8SUPkRL6lwqSwq7Bx4NbZHSLkTKl3kQwgClcYMzL5IOY8RxJjzE2Zcrr6/
         E+XQ2bSIn6p8aDMzmklLKC4Aju5ghQFI2xkh1gWx8GWRIc+tGz2ITEGeXqLqai+185f2
         c62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681364889; x=1683956889;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2J3hZLfv4Ais2nnWyi587H3aSP1FPUxtsM5ow+18kMQ=;
        b=bLRZWG2f3zbe8KloF/8aM4ymszgpqnQ2YG6r82xgwHIDzGchO41oSOHhdUHmTl4pcg
         vAr1ASsGJDU+JYCOPmfLsg0oQp1BCQcEbkPVHTEwBvdaG11dmFHojtnSNQK/u57WJ9hS
         yNmnhpPuUsFy7a6gMpHb75cZf8Xf2nFu8Dhlossd3KKmA6LWrOMiue440JNj14EnGQLF
         HwoQLfR7Avv7oNKneC21wDfnmPnI2mOEPix9oUMoqIPU8bsr0owOSPigP/L9sh0GQqDe
         dEC7eFR1PPkwN0Dcl3/35/U2w48AijHvbmAciMrqLK7gjRPZqXc9JxTlLFvzRFY7nuMk
         G6BQ==
X-Gm-Message-State: AAQBX9fBf/FJdOoD6eTIqjc6h0pc0Qold/BVUrHjy7xqLlFuoqFHdfNj
        5JZ+on1sNTC5lGBAZMg10tDCkoDM+sE=
X-Google-Smtp-Source: AKy350b+T6IbAxGnjRNP6MjoVLxKkqo8NKoudf6X692ixGh2iWr+CWtOOYQU0aP/FSigREJUVdXyIw==
X-Received: by 2002:ac2:4c1a:0:b0:4db:513f:fe2a with SMTP id t26-20020ac24c1a000000b004db513ffe2amr489970lfq.23.1681364889154;
        Wed, 12 Apr 2023 22:48:09 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id o15-20020ac2494f000000b004d3d43c7569sm154792lfi.3.2023.04.12.22.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 22:48:08 -0700 (PDT)
Message-ID: <6b0e2cd2-b419-8474-c53c-81449b8f6325@gmail.com>
Date:   Thu, 13 Apr 2023 08:48:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
References: <cover.1681301472.git.mazziesaccount@gmail.com>
 <d31f2ebf08837337d3bbc6a00fd4b5eb3c86a04e.1681301472.git.mazziesaccount@gmail.com>
 <20230412213208.49912897@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 1/3] iio: core: add IIO_VAL_INT_MICRO
In-Reply-To: <20230412213208.49912897@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 4/12/23 23:32, Jonathan Cameron wrote:
> On Wed, 12 Apr 2023 15:27:14 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> There are a few cases like light sensor integration times, where values
>> returned from *_available() and read_raw() are smaller than 1 and often
>> in the units of micro. (Like micro second scale integration times,
>> always smaller than 1 second). Currently those are often handled using
>> IIO_VAL_INT_PLUS_MICRO, which requires drivers to initialize the integer
>> part to zero. Furthermore, using IIO_VAL_INT_PLUS_MICRO in iio lists
>> requires one to always allocate the 'dummy' integer part too.
>>
>> Introduce IIO_VAL_INT_MICRO which allows omitting the always zero integer.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Hi Matti,
> 
> I'm not keen on adding yet another case just to avoid having to
> have the integer part for IIO_VAL_INT_PLUS_MICRO.
> Seems like the wrong trade off of maintainability vs ease of use.

I see your point. I would still argue that adding the IIO_VAL_INT_MICRO 
was not really an intrusive change and I'd expect the maintenance effort 
should not be increased that much.

While the inconvenience for users in read_raw (initializing the *val = 
0) is minor (meaning the benefit of adding IIO_VAL_INT_MICRO is also 
minor in this regard), iio_lists are stronger reason to consider this. 
With IIO_VAL_INT_MICRO the iio-list memory footprint will be halved. In 
my opinion, this benefit would exceed the cost of maintenance effort 
increase - sure thing it's easy for me to say as I am not the maintainer 
;) (And as I wrote, this series was cooked in a hurry - I had no time to 
go through existing drivers to see how many could benefit from the new 
IIO_VAL_INT_MICRO. I may do this later when I get some pretty urgent 
things off my shoulders - assuming you're not opposing this change so 
strongly that this is out of the question no matter how many existing 
users could benefit from IIO_VAL_INT_MICRO).

Anyways, if this is your final stance, then I need to rework the 
integration time list allocations in the gts helper, but I am most 
likely not able to do this until a week or two from now - meaning it 
might be better to revert the bu27034 and iio-gts-helpers until this 
gets fixed. (I reserve the right to do this during some night if I can't 
get sleep though.)

Yours,
	-- Matti

> Jonathan
> 
>> ---
>>   drivers/iio/industrialio-core.c | 4 ++++
>>   include/linux/iio/types.h       | 1 +
>>   2 files changed, 5 insertions(+)
>>
>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>> index c117f50d0cf3..c5ae965e9961 100644
>> --- a/drivers/iio/industrialio-core.c
>> +++ b/drivers/iio/industrialio-core.c
>> @@ -628,6 +628,8 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
>>   	switch (type) {
>>   	case IIO_VAL_INT:
>>   		return sysfs_emit_at(buf, offset, "%d", vals[0]);
>> +	case IIO_VAL_INT_MICRO:
>> +		return sysfs_emit_at(buf, offset, "0.%06u", vals[0]);
>>   	case IIO_VAL_INT_PLUS_MICRO_DB:
>>   		scale_db = true;
>>   		fallthrough;
>> @@ -758,6 +760,7 @@ static ssize_t iio_format_list(char *buf, const int *vals, int type, int length,
>>   
>>   	switch (type) {
>>   	case IIO_VAL_INT:
>> +	case IIO_VAL_INT_MICRO:
>>   		stride = 1;
>>   		break;
>>   	default:
>> @@ -952,6 +955,7 @@ static ssize_t iio_write_channel_info(struct device *dev,
>>   		case IIO_VAL_INT_PLUS_MICRO_DB:
>>   			scale_db = true;
>>   			fallthrough;
>> +		case IIO_VAL_INT_MICRO:
>>   		case IIO_VAL_INT_PLUS_MICRO:
>>   			fract_mult = 100000;
>>   			break;
>> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
>> index 82faa98c719a..b4e316172c7f 100644
>> --- a/include/linux/iio/types.h
>> +++ b/include/linux/iio/types.h
>> @@ -30,6 +30,7 @@ enum iio_event_info {
>>   #define IIO_VAL_FRACTIONAL 10
>>   #define IIO_VAL_FRACTIONAL_LOG2 11
>>   #define IIO_VAL_CHAR 12
>> +#define IIO_VAL_INT_MICRO 13 /* val is micro <units>. Integer part is 0 */
>>   
>>   enum iio_available_type {
>>   	IIO_AVAIL_LIST,
> 

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

