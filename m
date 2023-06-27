Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F28673FF3B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjF0PEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjF0PEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:04:43 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5966B97;
        Tue, 27 Jun 2023 08:04:42 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fa99742af9so21735425e9.2;
        Tue, 27 Jun 2023 08:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687878281; x=1690470281;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=flxUY/GjVm03jw49gNx/Qy5C1bgJNdklvrVyfZAIyFU=;
        b=FHSmWc8HaepVYP52x25LhodOpA+3+2KN1GyFNlBK3uV2xugZNwZMqWG8jZyeaAVfyH
         KbOsRh1uLaNaRX5EP6hn6l4RcI44s1HLKYaN/hui+Kd6Emhawhh7DgYX8gVoLZckmmq+
         TCsFZo8z6WHumOJNB11Cj/J7TML8Yjul/Z1sJGPVxZe31/dw36EB/7fN/yKB9b2+YBps
         6H6qtoxRoef/vHk/3efOVQ0LUS6ihg+gSsDDFrMl3TnMeQd/uLSuBmlCgNjsfHyw/pSC
         bxA4iY47LI6IYolp5tir1p3Sfv72Jr+RmwXhsx0bw7lfzEu56u98Jur67v4VKxv4MAHH
         zypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687878281; x=1690470281;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=flxUY/GjVm03jw49gNx/Qy5C1bgJNdklvrVyfZAIyFU=;
        b=kQV2V2Y2TC5L5sgRECcc20md/urAO9D9K/iBf5hflb4u6FcxSPpH2IjnMbEQMTcLw7
         BnpQvyyQxDq3SDP9o4Aujw+hTOMHuaAk8WXmLM/bsn5+3J4tZDkVCpAB8GGmLFsZQj8R
         T5bPy+WYhUvQJBN47TzwKdNLidQcWQYPuydIVu8crxe/SpFGPbI9obH1q5oiYZXN2O2i
         MjvC8Y2KyhtLtyEhI0d3he+QfPIPuDDlQjVhqWgf3TSAXhGh/BpWHqf2TLdr2eP+X01W
         vVdpF+cqAJLVFWhdUPwQtj0grDx3K+63tXvuSnB1tu6RVN29Lil0CJE5U/60ECAJe/Cn
         zveg==
X-Gm-Message-State: AC+VfDzpPwAR+6ulxJwpdiTFZbUdRwcgpOf8LYnAsc+1r2doYRoBpS2d
        06zQrMk2ecPqi3zsPW/ZcdJaOz7enMRoBg==
X-Google-Smtp-Source: ACHHUZ4NvRe+wbx+RoAlBXuD6tmiYSIBE5iIdesHIoh5sgBFI25o+9Vwjw4foKp0nAxiKjX4NPIZkA==
X-Received: by 2002:a7b:c411:0:b0:3fb:52c3:a177 with SMTP id k17-20020a7bc411000000b003fb52c3a177mr2522391wmi.4.1687878280608;
        Tue, 27 Jun 2023 08:04:40 -0700 (PDT)
Received: from [192.168.0.101] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id f7-20020a1c6a07000000b003fb5e3710d3sm3112585wmc.43.2023.06.27.08.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 08:04:39 -0700 (PDT)
Message-ID: <2b17acc9-44c3-acf6-0674-04a43aa742e0@gmail.com>
Date:   Tue, 27 Jun 2023 16:04:38 +0100
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
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <ZJr0WvhFfCILwbeP@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
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

On 27/06/2023 15:38, Tommaso Merciai wrote:
> Hi Colin,
> 
> On Tue, Jun 27, 2023 at 02:48:51PM +0100, Colin Ian King wrote:
>> Don't populate the arrays on the stack, instead make them static const.
>> Also add spaces between values to clean up checkpatch style warnings.
>>
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>> ---
>>   drivers/media/pci/bt8xx/dvb-bt8xx.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/media/pci/bt8xx/dvb-bt8xx.c b/drivers/media/pci/bt8xx/dvb-bt8xx.c
>> index 4cb890b949c3..df83b59a618d 100644
>> --- a/drivers/media/pci/bt8xx/dvb-bt8xx.c
>> +++ b/drivers/media/pci/bt8xx/dvb-bt8xx.c
>> @@ -190,11 +190,15 @@ static int cx24108_tuner_set_params(struct dvb_frontend *fe)
>>   	u32 freq = c->frequency;
>>   	int i, a, n, pump;
>>   	u32 band, pll;
>> -	u32 osci[]={950000,1019000,1075000,1178000,1296000,1432000,
>> -		1576000,1718000,1856000,2036000,2150000};
>> -	u32 bandsel[]={0,0x00020000,0x00040000,0x00100800,0x00101000,
>> +	static const u32 osci[] = {
>> +		950000, 1019000, 1075000, 1178000, 1296000, 1432000,
>> +		1576000, 1718000, 1856000, 2036000, 2150000
>> +	};
>> +	static const u32 bandsel[] = {
>> +		0, 0x00020000, 0x00040000, 0x00100800, 0x00101000,
>>   		0x00102000,0x00104000,0x00108000,0x00110000,
> 
> Are you not missing space also here?

I can't see the space you are referring to.

> 
>> -		0x00120000,0x00140000};
>> +		0x00120000, 0x00140000
>> +	};
>>   
>>   	#define XTAL 1011100 /* Hz, really 1.0111 MHz and a /10 prescaler */
>>   	dprintk("cx24108 debug: entering SetTunerFreq, freq=%d\n", freq);
>> -- 
>> 2.39.2
>>
> 
> Regards,
> Tommaso

