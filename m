Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5B173FF94
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjF0PWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjF0PWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:22:39 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2382942;
        Tue, 27 Jun 2023 08:22:38 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f9bdb01ec0so55952065e9.2;
        Tue, 27 Jun 2023 08:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687879357; x=1690471357;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IpTJWyv0zeCs9vl2nRoZaqUzt7MMDQDCNCafFpN+rt4=;
        b=UrfLdfT1KVP3WVEwjVfdRfixOlZYb1f95OYjSH1LfqNxw1RXb0hR5SyMz+8x5FdzEf
         A5sw25qTgVG9qU/Hh9RRWiOicAxvMraxYM2Y+b4sBkf6GX6JVS7eX55D3MHD5cvPW4N1
         2qJNH7oOvo6ocWN3qnMFu5ZHZZHZeuluLJpGRJU1Gom8s8pYVIsZC7Nj7LiyamaBM7ed
         bAwwfhuBK6LaI9uqszspCVZvIa5bE3HJthsQxBjYR7FWCnY4Vuk5HQvoTSMCFAdsKEMD
         vGIKSZ6wDBdZQIxPmX/ktXDCo0oQwsH6vpyWcW7ce2tOBTXNqA98O66mC+lqI294TIhK
         RgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687879357; x=1690471357;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IpTJWyv0zeCs9vl2nRoZaqUzt7MMDQDCNCafFpN+rt4=;
        b=U0I6h5nBCWy76dCURvGav/M4pNLZlzpl9eaLrfvBNhW74qyN2GrX3M6QIDlLsfTQr/
         wQQB1r8CeIxvYN5m1ZZP/h+Vnu88i/yhN45y1xINnYvGu6qfEIMCdo4CXK0V4uEd9Tz1
         yvyt60IhvMmfejS7tw/rYrLzVFFRLDI326kBloCtUSkAmSRoxHJRN7iSlp0FAoYVfr8i
         FU2IQv0EqVLDQkt1J6w9IxpEB6/yVawmxu2PP7TaGP2m1TRU9JIJ56hmJedes4zuTZq4
         8WLu8hIy2jcbu2k8JBX7tVQrBinHgXGuVxj19+G19IN7ngXR7iamMwZ7FRuRi1u04V51
         4uUg==
X-Gm-Message-State: AC+VfDzfUO7+vdzLnVd7go2bRqH60yRjekylC8W4fhYk8CUMz7VyTf30
        uDWCRpHJw/6BAmZdrsF0jIPDajFdMQeqOA==
X-Google-Smtp-Source: ACHHUZ4r5ONkO5s/FhTu6NksD5GcctdRolmKRLtcod7q7cStbsJu62dnB3Oo0/5OG/wxMjx2qEeldg==
X-Received: by 2002:a05:600c:2245:b0:3f8:f4f3:82ec with SMTP id a5-20020a05600c224500b003f8f4f382ecmr26820705wmm.8.1687879356637;
        Tue, 27 Jun 2023 08:22:36 -0700 (PDT)
Received: from [192.168.0.101] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id p8-20020a7bcc88000000b003fb225d414fsm4733425wma.21.2023.06.27.08.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 08:22:36 -0700 (PDT)
Message-ID: <bb22b565-a309-063c-4c7f-dcc9f7195371@gmail.com>
Date:   Tue, 27 Jun 2023 16:22:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH][next] media: bt8xx: make read-only arrays static
Content-Language: en-US
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230627134851.728487-1-colin.i.king@gmail.com>
 <ZJr0WvhFfCILwbeP@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <2b17acc9-44c3-acf6-0674-04a43aa742e0@gmail.com>
 <ZJr81Tg285kr4oEs@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <ZJr81Tg285kr4oEs@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2023 16:14, Tommaso Merciai wrote:
> Hi Coli,
> 
> On Tue, Jun 27, 2023 at 04:04:38PM +0100, Colin King (gmail) wrote:
>> On 27/06/2023 15:38, Tommaso Merciai wrote:
>>> Hi Colin,
>>>
>>> On Tue, Jun 27, 2023 at 02:48:51PM +0100, Colin Ian King wrote:
>>>> Don't populate the arrays on the stack, instead make them static const.
>>>> Also add spaces between values to clean up checkpatch style warnings.
>>>>
>>>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>>>> ---
>>>>    drivers/media/pci/bt8xx/dvb-bt8xx.c | 12 ++++++++----
>>>>    1 file changed, 8 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/media/pci/bt8xx/dvb-bt8xx.c b/drivers/media/pci/bt8xx/dvb-bt8xx.c
>>>> index 4cb890b949c3..df83b59a618d 100644
>>>> --- a/drivers/media/pci/bt8xx/dvb-bt8xx.c
>>>> +++ b/drivers/media/pci/bt8xx/dvb-bt8xx.c
>>>> @@ -190,11 +190,15 @@ static int cx24108_tuner_set_params(struct dvb_frontend *fe)
>>>>    	u32 freq = c->frequency;
>>>>    	int i, a, n, pump;
>>>>    	u32 band, pll;
>>>> -	u32 osci[]={950000,1019000,1075000,1178000,1296000,1432000,
>>>> -		1576000,1718000,1856000,2036000,2150000};
>>>> -	u32 bandsel[]={0,0x00020000,0x00040000,0x00100800,0x00101000,
>>>> +	static const u32 osci[] = {
>>>> +		950000, 1019000, 1075000, 1178000, 1296000, 1432000,
>>>> +		1576000, 1718000, 1856000, 2036000, 2150000
>>>> +	};
>>>> +	static const u32 bandsel[] = {
>>>> +		0, 0x00020000, 0x00040000, 0x00100800, 0x00101000,
>>>>    		0x00102000,0x00104000,0x00108000,0x00110000,
> +			0x00102000, 0x00104000, 0x00108000, 0x00110000,
> 
> ERROR: space required after that ',' (ctx:VxV)
> #199: FILE: drivers/media/pci/bt8xx/dvb-bt8xx.c:199:
> +		0x00102000,0x00104000,0x00108000,0x00110000,

Yep, I can see it now, I'll send a V2. :-/

> 
> I'm wrong?
> 
> Regards,
> Tommaso
> 
>>>
>>> Are you not missing space also here?
>>
>> I can't see the space you are referring to.
>>
>>>
>>>> -		0x00120000,0x00140000};
>>>> +		0x00120000, 0x00140000
>>>> +	};
>>>>    	#define XTAL 1011100 /* Hz, really 1.0111 MHz and a /10 prescaler */
>>>>    	dprintk("cx24108 debug: entering SetTunerFreq, freq=%d\n", freq);
>>>> -- 
>>>> 2.39.2
>>>>
>>>
>>> Regards,
>>> Tommaso
>>

