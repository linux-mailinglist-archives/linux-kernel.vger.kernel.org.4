Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC94745313
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 01:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjGBXiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 19:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjGBXiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 19:38:17 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5637E44;
        Sun,  2 Jul 2023 16:38:16 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-51452556acdso2133794a12.2;
        Sun, 02 Jul 2023 16:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688341096; x=1690933096;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=65jMXDvPf/Qj+THtJErSPUJIq6P3A0R/jH1TvPSuwd0=;
        b=eS/E2Qtqe53v13qJkSP5jC/FyeaBq38i1/QQ7JVDnKJd8fBhk7s9JR4UMg5XhfFpb1
         Tp/RifilTKmY9L6LcVCsMjyqRRNquCKlryYl9k9ddTF5mRU7cNqllHN3QxuN9IopdR2/
         c7erU5huwGacsq85Gv5wTAcVIRfER14xAIhovJYT9NmPjfG+HwA8fdcmvbh/+V+2ArX3
         GWWMEWL9xlgKJnBF6Lv5ywTiZtTOP3hqqAuixQ5/5/4qmEdsC9IIhDheCX+2yobFKUS+
         J1r6rDwvTWXX77M0y2uRSWcv6F6Us5fNrNeB5PDafz25yThLbWJOepD3aDbphUpda1rn
         c6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688341096; x=1690933096;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=65jMXDvPf/Qj+THtJErSPUJIq6P3A0R/jH1TvPSuwd0=;
        b=Q+S5AKne3WiKDtB5z2KajFoCWFlE1pGOhBTZwb/2mW6qwdbivKgpUqeRSN44UAi5+t
         WanJhWV3RdB9JroK3Ia3A5xtXwPTX3Aul4z2zuMMEarKqlAVld3Xci+aUOQTHHeDVQ0l
         fZplYGz+iarasxbi9iBueMABMLjGKtvIAZ/J3ie4bxicNVXIyWxR7HX2NogCtCjFp9Oi
         PN65zVB1/RCFpzi5BAVC3V3OXCUhy+2MOYfdRRI3z1UDNM1GufkeQe7linvawbCHSfLN
         isHS8nYPxHBjMUiE0d+b6dC0iOQij9Notp4H9XTNVMmR8zBJoDLj6McB6nfSWamdLLFI
         jcdg==
X-Gm-Message-State: ABy/qLbZRMQnDx/r1jrkHoa/5zqaodiCuJkTeh/obnutwU+Szerl1LZc
        HqlTa0jCpzuoGZhJl0huAXg=
X-Google-Smtp-Source: APBJJlEh9wCyLD0icdeFz1oX98Xq0nzyLJDgjmNTzR22tfYoI+ZKtiz1DTjru/TwKPIOw43OAJuUAw==
X-Received: by 2002:a17:90a:35b:b0:263:5c6a:1956 with SMTP id 27-20020a17090a035b00b002635c6a1956mr5348022pjf.25.1688341096178;
        Sun, 02 Jul 2023 16:38:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id co21-20020a17090afe9500b00262dbf8648esm12790495pjb.34.2023.07.02.16.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 16:38:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <dde6077b-83e8-24fa-440a-180ce8123080@roeck-us.net>
Date:   Sun, 2 Jul 2023 16:38:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cocci <cocci@systeme.lip6.fr>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230702211450.3789779-1-linux@roeck-us.net>
 <676aae2eb65d228796d6f18e86d261ed96540a87.camel@perches.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] checkpatch: Add old hwmon APIs to deprecated list
In-Reply-To: <676aae2eb65d228796d6f18e86d261ed96540a87.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/23 15:42, Joe Perches wrote:
> On Sun, 2023-07-02 at 14:14 -0700, Guenter Roeck wrote:
>> hwmon_device_register() and [devm_]hwmon_device_register_with_groups()
>> have been deprecated. All hardware monitoring drivers should use
>> [devm_]hwmon_device_register_with_info() instead.
>>
>> The problem with the old API functions is that they require sysfs attribute
>> handling in driver code. The new API handles sysfs attributes in the
>> hwmon core. Using the new API typically reduces driver code size by 20-40%.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Seems sensible, thanks.
> 
> But how big an effort is it to convert all the existing uses
> and remove the code?  There are less than 200 uses.
> 
> Perhaps it's not that onerous.
> Is it something that coccinelle could do reasonably well?
> 
> $ git grep -w hwmon_device_register | wc -l
> 49
> 
> $ git grep -w hwmon_device_register_with_groups | wc -l
> 22
> 
> $ git grep -w devm_hwmon_device_register_with_groups | wc -l
> 108
> 

Unfortunately that doesn't work, because the parameters are completely
different. Coccinelle is god, but not that good.

The _with_info API implements sysfs attributes in the hwmon core.
The older APIs implement sysfs attributes in the individual drivers.
I have converted a number of drivers, but it is a lot of work, and it
can only be done safely if one has access to hardware to test the result.

Problem is that I still see submissions using the old API, with arguments
such as "this other driver uses it". On top of that, there have been attempts
to abuse the with_info API by providing only the (old) groups argument.
Commit ddaefa209c4a ("hwmon: Make chip parameter for with_info API mandatory")
made that impossible, and commit aededf875a23 ("Documentation/hwmon:
Remove description of deprecated registration functions") removed the old API
calls from the documentation. Unfortunately that is still insufficient.
The next step would be to print a warning if the with_groups API is used,
but I don't want to go that far yet.

Guenter

>> ---..
>>   scripts/checkpatch.pl | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 7bfa4d39d17f..6d97f1a6028e 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -842,6 +842,9 @@ our %deprecated_apis = (
>>   	"kunmap"				=> "kunmap_local",
>>   	"kmap_atomic"				=> "kmap_local_page",
>>   	"kunmap_atomic"				=> "kunmap_local",
>> +	"hwmon_device_register"			=> "hwmon_device_register_with_info",
>> +	"hwmon_device_register_with_groups"	=> "hwmon_device_register_with_info",
>> +	"devm_hwmon_device_register_with_groups"=> "devm_hwmon_device_register_with_info",
>>   );
>>   
>>   #Create a search pattern for all these strings to speed up a loop below
> 

