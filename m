Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA710703087
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238905AbjEOOtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 10:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjEOOsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:48:40 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15211170B;
        Mon, 15 May 2023 07:48:39 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-643a1656b79so9144326b3a.3;
        Mon, 15 May 2023 07:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684162118; x=1686754118;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J1aV8qCIxRKxw+oymCWIME7fdKU9B9JXSxVICxlkIf4=;
        b=gWNBqcS+q8xpobstiDRZGZXKPFsS/4sRamFO0H8d45S4hLGfvxDrU8U7Fii7VxWLbt
         PTBkoaFDJOudsDIqXRsjHD1gvdW5C528bbvPqjqCXI3Wg6ZCtoYNf0MZ5usuPIsZf2Sn
         u1q38wBUj2IeWBPv31Ghmd3Wwh0Ohz8xGyIOAxbo74XpXccUHFGIg0a+8soZmv0Qqtrc
         G/mW49amybhgj3tDw0tU4e1UMufjuXtn5cfqjjB4Vx233crkN7+NNvZW9v0Aj7cjYcEB
         DFSlOeQk0oTuWvSCrdSiGcW+X+ieIAFkQ+V9oc4CYe9XZTs+hb9pp0Vnfjfffcum+hZU
         bBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684162118; x=1686754118;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J1aV8qCIxRKxw+oymCWIME7fdKU9B9JXSxVICxlkIf4=;
        b=RJFKPf9QQdgnuMRfi31D1gYyFPl011IPog2dUulybcCwbddSL8WlTMUkQiCLw8LobK
         EKmvgxoxIlKNizrMhPgFNICaSN8UWUZ98+o7KcE8kqUEJNBaA/CKUPGTbx6sVQz0Xi1d
         uir31MGfqt51dIqhCYuKSdiaamNO0uo/x3XKwDGyqnbLOiTwhZmsprOXw6lA3o+6t3lv
         q87NlzcFsZ7UlEw+Hvs0aQCTGljU16uWJbfD93msVdu9N1p0h/dDP+md1g+2TSV6jVOT
         7moUq9r45SpZH8lg2KeNTQVx4spYPwYO5TvCJ0SmTe5mfR9YnA+4ptevD8cAnQq98LNo
         9Dsg==
X-Gm-Message-State: AC+VfDwL8optQUK8Jaj2aPuKNk5cSUXBzPzLBSvGfi4pilO3OsyVrtw7
        VmYotiOupiED4R/tdzvFMRM=
X-Google-Smtp-Source: ACHHUZ5e1N8GKMA/iaLaD1TAhXF65WfNjS1QdwVY72rejjMh1Q/Me3MFUXhnFN6UTho/R/oSfFQuDw==
X-Received: by 2002:a05:6a20:441b:b0:101:6f3f:638c with SMTP id ce27-20020a056a20441b00b001016f3f638cmr30482065pzb.42.1684162118495;
        Mon, 15 May 2023 07:48:38 -0700 (PDT)
Received: from [192.168.1.107] ([103.194.71.110])
        by smtp.gmail.com with ESMTPSA id b30-20020a631b1e000000b0050bd4bb900csm11657552pgb.71.2023.05.15.07.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 07:48:38 -0700 (PDT)
Message-ID: <d356103b-4d68-dc56-0324-4010a9015548@gmail.com>
Date:   Mon, 15 May 2023 20:18:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] hwmon: (nct6683) Add another chip ID for NCT6687D sensor
 chip found on some MSI boards.
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230515092546.21154-1-llyyr.public@gmail.com>
 <350dc86f-8341-4c3d-a3f8-0f4f5568ae77@roeck-us.net>
From:   llyyr <llyyr.public@gmail.com>
In-Reply-To: <350dc86f-8341-4c3d-a3f8-0f4f5568ae77@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/23 18:49, Guenter Roeck wrote:
> On Mon, May 15, 2023 at 02:55:46PM +0530, llyyr wrote:
>> This value was found on MSI Z690-A PRO DDR5, with a NCT6687D chip.
>>
>> Signed-off-by: llyyr <llyyr.public@gmail.com>
>> ---
>>   drivers/hwmon/nct6683.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/hwmon/nct6683.c b/drivers/hwmon/nct6683.c
>> index a872f783e..5df9b9ce7 100644
>> --- a/drivers/hwmon/nct6683.c
>> +++ b/drivers/hwmon/nct6683.c
>> @@ -14,6 +14,7 @@
>>    * nct6683d     21(1)   16      8       32(1) 0xc730
>>    * nct6686d     21(1)   16      8       32(1) 0xd440
>>    * nct6687d     21(1)   16      8       32(1) 0xd590
>> + *                                           (0xd592)
>>    *
>>    * Notes:
>>    *	(1) Total number of vin and temp inputs is 32.
>> @@ -71,6 +72,7 @@ static const char * const nct6683_chip_names[] = {
>>   #define SIO_NCT6683_ID		0xc730
>>   #define SIO_NCT6686_ID		0xd440
>>   #define SIO_NCT6687_ID		0xd590
>> +#define SIO_NCT6687_ID2		0xd592
>>   #define SIO_ID_MASK		0xFFF0
>>   
>>   static inline void
>> @@ -1362,6 +1364,7 @@ static int __init nct6683_find(int sioaddr, struct nct6683_sio_data *sio_data)
>>   		sio_data->kind = nct6686;
>>   		break;
>>   	case SIO_NCT6687_ID:
>> +	case SIO_NCT6687_ID2:
>>   		sio_data->kind = nct6687;
>>   		break;
> 
> The checked value is masked with SIO_ID_MASK, or 0xfff0. Why would it be
> necessary or even make sense to compare that masked value with 0xd592 ?
> Please provide evidence that and why this code is needed.
> 
> Guenter

You're right, sorry for the useless traffic. In my testing this only 
worked because I was loading the module with `force=1`. This is actually 
a case of missing customer ID, I'll be sending a different patch shortly.
