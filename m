Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC9E6BB5D8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjCOOWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjCOOWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:22:04 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F9075A6C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:21:56 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id cn21so46052981edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678890115;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=viILU/rucad5qZXI7oROvpfUDFl4dgM2hV94PfjFjMw=;
        b=ASIZZhmaQ9pHTtcXbAZFOJ6RdjRkcxCcDpQeIIXevYEneKXpXo5Qipu9X218jl+rmb
         zusnD/GWiMYa5BctlOYbYtP3CFMr75Esg03GjG/jzxiAjeKpF8BciC5oPOdZoHHVuTiv
         a+S6rYjyyZmGdEqIdVehqQ09vHgzEW5HyYlqvr0f21Iv7f9SSTm3WVBXh9PDRZTLmtKa
         Qwc4DIL67T6xJBk2ZFXMWc2P3Krog7Zysv/3C83Y9Y/JyRy6mqkDalG4l0GzqSeZci9j
         /4MPlPJTaw/RJUtuO8pdNIE65Mr01HIwCgBU3P49CZ/g845yQaw8w/gTdmVfDBH+51jN
         dlrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678890115;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=viILU/rucad5qZXI7oROvpfUDFl4dgM2hV94PfjFjMw=;
        b=0y3fJnFBU117AMlr44l6wNouhpnznWnoOrBmGffy9DE5QzQIr4lClyuHrVvz2jWXFO
         YNy00/BImFUfSST8rCPg4yzSHJA5eeXLopHWdWzcSS54CpyLMjhdFbCsmiKqtl5hpAdQ
         nRbGrJNYtLNbkUiya0pj8lZo+DH8adZosMzlxMPJ6Fca3KjxD9xVlVs9w4MEvPp3pmqs
         3TO3IZMQouNNqptLBdTzuXVHMqfoeGdfW9dzrpfsWh/fk6aDmHON95JW/eRTRmeOCABL
         yfwAt/v4CuqcENIKM9D+t0QUNHz2X1Aoy5rtdOZ+L6F2964tCrCJXBM4gOagR0nfSxud
         PItA==
X-Gm-Message-State: AO0yUKWwoswIAIgQo1PECVTfMvgFyfIYjoDWcORK/30PXMHcibVKPnDJ
        2DUyF5JjAmburNW1c30PUCuSiDEfpxA=
X-Google-Smtp-Source: AK7set+mT5bhTLLOkiGyYLeqJmbualm8LQC5QUkIj0nWVWkTMvRFbXEZUI4EDYwk3XUYf3+a+jxZQQ==
X-Received: by 2002:a17:907:760e:b0:92b:de4c:f492 with SMTP id jx14-20020a170907760e00b0092bde4cf492mr5897911ejc.40.1678890115232;
        Wed, 15 Mar 2023 07:21:55 -0700 (PDT)
Received: from [192.168.1.16] ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id sd5-20020a170906ce2500b009222eec8097sm2577742ejb.75.2023.03.15.07.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 07:21:54 -0700 (PDT)
Message-ID: <11ebbcad-a779-59ee-fb88-6303183ea115@gmail.com>
Date:   Wed, 15 Mar 2023 16:21:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/2] staging: vme_user: add space around operators
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        martyn@welchs.me.uk, manohar.vanga@gmail.com, zoo868e@gmail.com,
        jerrykang026@gmail.com, cuigaosheng1@huawei.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <078be1ba242950f31d0aa13fe9815d92fe96468b.1678888612.git.eng.mennamahmoud.mm@gmail.com>
 <3cb654df-c08-881-f1c-52364ce2ad2b@inria.fr>
Content-Language: en-US
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
In-Reply-To: <3cb654df-c08-881-f1c-52364ce2ad2b@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On ١٥‏/٣‏/٢٠٢٣ ١٦:٠٣, Julia Lawall wrote:
>
> On Wed, 15 Mar 2023, Menna Mahmoud wrote:
>
>> add a space before and after the operator, for readability.
> add -> Add
> That is, start the sentence with a capital letter.
>
>> Reported By checkpatch script:
> By -> by
> No need for capital letters in the middle of a sentence, unless you are
> referring to a proper noun (name of someone or something).
>
> julia

Okay, I will fix them.


Thanks,

Menna

>> " CHECK: spaces preferred around that '+', '<<' and '>>' ".
>>
>> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
>> ---
>> change in v2:
>>          edit commit message
>> ---
>> change in v3:
>>          edit commit message
>> ---
>>   drivers/staging/vme_user/vme_tsi148.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
>> index 482049cfc664..bfa604043355 100644
>> --- a/drivers/staging/vme_user/vme_tsi148.c
>> +++ b/drivers/staging/vme_user/vme_tsi148.c
>> @@ -737,7 +737,7 @@ static int tsi148_alloc_resource(struct vme_master_resource *image,
>>   		return 0;
>>
>>   	if (!image->bus_resource.name) {
>> -		image->bus_resource.name = kmalloc(VMENAMSIZ+3, GFP_ATOMIC);
>> +		image->bus_resource.name = kmalloc(VMENAMSIZ + 3, GFP_ATOMIC);
>>   		if (!image->bus_resource.name) {
>>   			retval = -ENOMEM;
>>   			goto err_name;
>> @@ -983,7 +983,7 @@ static int tsi148_master_set(struct vme_master_resource *image, int enabled,
>>   		goto err_aspace;
>>   	}
>>
>> -	temp_ctl &= ~(3<<4);
>> +	temp_ctl &= ~(3 << 4);
>>   	if (cycle & VME_SUPER)
>>   		temp_ctl |= TSI148_LCSR_OTAT_SUP;
>>   	if (cycle & VME_PROG)
>> @@ -2187,14 +2187,14 @@ static int tsi148_crcsr_init(struct vme_bridge *tsi148_bridge,
>>
>>   	/* Ensure that the CR/CSR is configured at the correct offset */
>>   	cbar = ioread32be(bridge->base + TSI148_CBAR);
>> -	cbar = (cbar & TSI148_CRCSR_CBAR_M)>>3;
>> +	cbar = (cbar & TSI148_CRCSR_CBAR_M) >> 3;
>>
>>   	vstat = tsi148_slot_get(tsi148_bridge);
>>
>>   	if (cbar != vstat) {
>>   		cbar = vstat;
>>   		dev_info(tsi148_bridge->parent, "Setting CR/CSR offset\n");
>> -		iowrite32be(cbar<<3, bridge->base + TSI148_CBAR);
>> +		iowrite32be(cbar << 3, bridge->base + TSI148_CBAR);
>>   	}
>>   	dev_info(tsi148_bridge->parent, "CR/CSR Offset: %d\n", cbar);
>>
>> --
>> 2.34.1
>>
>>
>>
