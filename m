Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE256116B8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiJ1QBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiJ1P74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 11:59:56 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36F5214657;
        Fri, 28 Oct 2022 08:59:01 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id n83so6549650oif.11;
        Fri, 28 Oct 2022 08:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kGV5CRuXO/AflfNqwOyb3q124XfnO4+Le7SUJ2VJU3I=;
        b=YEtveQ5geZPkTIxyIW1RGzgwGnwFThDcL8Wv8vKpWOWescIp3AKZvU140u86bHSctS
         /WHC/hmjpHBos5Hsg0sNydLxJm4tylUPI8AzWzyWluY1vVuXG/7OjgnTWV2zDOBQ2tgh
         2YIIErFMOMyFYdwhQ285czT3VOJpUm8T9YJgxEQvLj1Rd4ZX/bFyImyiSJ0Mc/1okjkI
         JcInEEarNY+WFTfmOAsL5smiQld4j8i/XdWjxxwznnvmmqB6CYjLjXOT73p7CvI2Dnwr
         CTHW1+tadB0YLfZ02AD8Tk0QlPInG43fpuM7w8eLUkFLnrVfJ3NmH2HDECrKJlDIDVuA
         oNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kGV5CRuXO/AflfNqwOyb3q124XfnO4+Le7SUJ2VJU3I=;
        b=XjEW36iyuH1+PNyWU3bocMDYjqjjws7diM14xC6V5JAGS56vQDZJW5o/Fe5nYkVHAD
         X3/zlxPRFmp91T6A7Bz5Ae6YXXVfRTxicKn9CQOLjhJbUEY3GmEoVGwrB92xuut8H4La
         nOFZLxdXhZFpkfaospJ+4/VyL2Ay7B6qhJrKQBSOcqV7YjIaTBooFDqO5KGRrL3FpPy7
         zMpwhuRwMXJSuEy2x3jLs8MeOr5Y6E8wsKV7u7LRh024nC/KSFg4c1Md1Gaku8UaXwII
         URiUS0JwewA8MVQYJlYI5exi/OFwLPZijlKdF+t1MT1rY7vpIX2JSkTkvVd5PANML5BO
         JHHw==
X-Gm-Message-State: ACrzQf2rc4G/+GP5zNXLeIbuKb9oQHl91g3kjUWyPDugXArEqI8ekjNM
        jDw4Q3A0Uj0+e03wJq5gUiVCajXYwR4=
X-Google-Smtp-Source: AMsMyM4SI17djKyPfTO294g8vpTQAc+lvUiYSSoWh5QXmXPQBgV9ybiftpT43M5gbq2CZaSK3grXfg==
X-Received: by 2002:a05:6808:2083:b0:355:2c71:7e58 with SMTP id s3-20020a056808208300b003552c717e58mr8578008oiw.168.1666972740889;
        Fri, 28 Oct 2022 08:59:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l23-20020a544517000000b00359ba124b07sm1626854oil.36.2022.10.28.08.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 08:59:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e4040686-851c-d8b0-b274-ac71d38685e1@roeck-us.net>
Date:   Fri, 28 Oct 2022 08:58:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-hwmon@vger.kernel.org
References: <20221028140833.280091-1-cristian.marussi@arm.com>
 <20221028140833.280091-7-cristian.marussi@arm.com>
 <b914ea25-a9a8-f443-2ba0-615bdd6cc04f@roeck-us.net>
 <Y1v2ozURFdIk1PfU@e120937-lin>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 7/8] hwmon: (scmi) Register explicitly with Thermal
 Framework
In-Reply-To: <Y1v2ozURFdIk1PfU@e120937-lin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/22 08:35, Cristian Marussi wrote:
[ ... ]
>>> +	/*
>>> +	 * Try to register a temperature sensor with the Thermal Framework:
>>> +	 * skip sensors not defined as part of any thermal zone (-ENODEV) but
>>> +	 * report any other errors related to misconfigured zones/sensors.
>>> +	 */
>>> +	tzd = devm_thermal_of_zone_register(dev, th_sensor->info->id, th_sensor,
>>> +					    &scmi_hwmon_thermal_ops);
>>> +	if (IS_ERR(tzd)) {
>>> +		devm_kfree(dev, th_sensor);
>>> +
>>> +		if (PTR_ERR(tzd) != -ENODEV)
>>> +			return PTR_ERR(tzd);
>>> +
>>> +		dev_info(dev, "Sensor '%s' not attached to any thermal zone.\n",
>>> +			 sensor->name);
>>
>> There were complaints about this message as it is noisy. If you send
>> another version, please drop it unless attaching each sensor to a thermal
>> zone is strongly expected. If you don't send another version, I'll drop it
>> while applying.
>>
> 
> Ok fine for me. I am waiting to have some feedback from Sudeep too, but
> I do not have plan for another version as of now.
> 
> As a side note, though, I understand the 'noisiness' argument, but,
> sincerely this same message in the original HWMON code was the only
> reason why I spotted that something was wrong with the SCMI/HWMON
> interactions and discovered the indexes/ids mismatch...if not for
> that it would have gone un-noticed that a perfectly configured
> ThermalZone/Sensor was not working properly...
> (un-noticed at least until something would have been burnt to fire
>   in my house .. joking :P)
> 

Good point.

Did you ever check the returned error code ? Maybe we could use it to
distinguish "it is not attached to a thermal zone because it is not
associated with one" from "attaching to a thermal zone failed because
its configuration is bad/incomplete".

Thanks,
Guenter

