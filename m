Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF85617F90
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiKCOaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiKCOaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:30:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E9E2BCD;
        Thu,  3 Nov 2022 07:30:13 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h9so3113875wrt.0;
        Thu, 03 Nov 2022 07:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ay5uVzW4y/GRmRkmcgKyUCqUyAa2Ays6LturwQFJT6g=;
        b=C2GSX0TXsbkPGe2C+mK3YaMlOHWYffcJ/cKHvUDQB9+mEvgHY72lOXLtntLgQJrt2b
         MqAECVHC1sBGE+qzq7ykVM39bByTg+rqoYHNpr7qEbReUkOviUx1IZrRuqHQO1Gpq5yf
         kggFjxRyYWlkTUHwD1xRP9Td4hWq4u8w6ixjkA0g6CYu36U5AyReq5v4I89xgRGWgetR
         mCddPeEJIvnE7yMXQe0dTnQ48Lxd09PzvEMzY/SHFuZd18J/LlX762OGomH1ZnWJX+C1
         WHnjFxv5MZ0jJx9APveJXKSsJ8ZcWsMTeH99v9rCK2ejAHBvPK/VI42DycIGXoSJqJhN
         Hepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ay5uVzW4y/GRmRkmcgKyUCqUyAa2Ays6LturwQFJT6g=;
        b=YuVeERgwxJX+nucWOFEOwrH3nh3rSSTMyQ/0C8O35HyTsFiBDaQjT6VH4iKKKoaJua
         iclzw/Mc6FSe1CE+56PQLgqUxw5hjizdYo9zW48OxMhjiPs3ZEUnt3fMNUXkmeVlb1qD
         St/wjstli9Hxsk6pTK2oHoH0KYzkTyuaVZCQiv+rSP3rs9O8Ecx7RPpCrthBvCt/LVtC
         81MzOwBNMuWDUClxlZmLYz22mEA4JEUM3iNfQnCMvzyGDu9dZwXyS3OKE5w6Aq83DOFL
         r+CDPPT0xEXOurwr9gUqh3BMIRWyqJpSMNaTSQbgUg2KfNPIhNjXdJGYHNoHBC6E5b0j
         Ur4Q==
X-Gm-Message-State: ACrzQf08OY2WMN0MvGkYY7ie2IC7s7TC2OQuomrfGOd+s3+VBbxCE+qO
        9Dk+aPM84tsHhX576o9cYMk=
X-Google-Smtp-Source: AMsMyM6lZJ8Y8grZ1TzG2GtLZjnNdSmKVgB5zO7cx9dY1jFWKpE5vEZ1MPTlb0lif3t2BPOFKKCnJw==
X-Received: by 2002:a05:6000:170d:b0:236:6aa1:8a56 with SMTP id n13-20020a056000170d00b002366aa18a56mr18873255wrc.302.1667485812194;
        Thu, 03 Nov 2022 07:30:12 -0700 (PDT)
Received: from [192.168.0.210] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id q12-20020a05600c46cc00b003b4ac05a8a4sm203wmo.27.2022.11.03.07.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 07:30:11 -0700 (PDT)
Message-ID: <c0490cb3-28d2-457c-8ae6-89d07b8b7577@gmail.com>
Date:   Thu, 3 Nov 2022 14:30:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] cpufreq: longhaul: Make array speeds static const
Content-Language: en-US
To:     Joe Perches <joe@perches.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221103132141.79671-1-colin.i.king@gmail.com>
 <aec9ee4b771b70d0839d51b836e6301f0a2a1276.camel@perches.com>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <aec9ee4b771b70d0839d51b836e6301f0a2a1276.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2022 14:15, Joe Perches wrote:
> On Thu, 2022-11-03 at 13:21 +0000, Colin Ian King wrote:
>> Don't populate the read-only array speeds on the stack but instead
>> make it static. Also makes the object code a little smaller.
> []
>> diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
> []
>> @@ -407,7 +407,7 @@ static int guess_fsb(int mult)
>>   {
>>   	int speed = cpu_khz / 1000;
>>   	int i;
>> -	int speeds[] = { 666, 1000, 1333, 2000 };
>> +	static const int speeds[] = { 666, 1000, 1333, 2000 };
>>   	int f_max, f_min;
>>   
>>   	for (i = 0; i < 4; i++) {
> 
> style trivia:  the loop test is probably better using ARRAY_SIZE
> 
> 	for (i = 0; i < ARRAY_SIZE(speeds); i++)
> 
I'll send a V2 for that. Good idea.

Colin
