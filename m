Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576EC611791
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiJ1QeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJ1QeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:34:11 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F5B1DE3CE;
        Fri, 28 Oct 2022 09:34:09 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id i7so6692566oif.4;
        Fri, 28 Oct 2022 09:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nwbPjBZmRyyK77zC/9SPzBIJETh2C9WOSbSEnKhMCwY=;
        b=B7YHTFsyLRTHAa4c9U0mEWUART9I0BHpU4ccCD8Rv4/9/2Gz4blKiCoeq/eQjUvLDS
         wAjQQgcZ2EiCofM6YtJYvK/gW8tQHoRjVTMvxc4my/tWnn4rOaYybarnPmjMU8ZTK6RP
         NmQQY67kfEluF9iJzf4pdwmnz6p5cGrv7pZiYP8b6uEiOc+WR0BkVsNy/fF+sjBBzNnA
         7ThUKAvQZNfVOA9miMgMsiovoNFkYU2/F4pKdFYd5HHyK3CvHBlyh0QMH0gWPem8riLM
         j5iSLuntEaRuqmGtMNRVCAiRl9p9gjdj3szv9/MlDb9q23TYJCS7duxZ43X31qX08epj
         mbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nwbPjBZmRyyK77zC/9SPzBIJETh2C9WOSbSEnKhMCwY=;
        b=tDN06vPGibDEVlU5VI84sS5SW6aXS+Dnrw7Kk5rlIrSCT9PF0yDEbLdr7KgtIqJRPZ
         LyAchDmFNnCwyQ8dHry4RzZ0MCqKGsNIy/lgAmnaOipMTPpjm72qDG48nIloV0DAoRND
         fXeFEehGzH4QPP8OpSwkpLrvuZUbuB8B7MH2m9ji40gt6GVoXY+agoVQ6qLPr8om64Es
         3FkxIalQv9i7AoOzP/3MsU8cmsIpNCZejcyu8Y72Rzb9h/lcNoFd9eOd+rHGGideMuvI
         2ra0ciSjGGYZioOb06BTN2RR4iv5q7JikVnQpU0zfmte/FREhxKexc5dZOlvjwaHnQl2
         cTDw==
X-Gm-Message-State: ACrzQf0bLaDj5m+dN/BB1R+YBuZoUeAff3C6cISU1WQO+DmOpLcRFkey
        Yc/+deQ25IejB7qwZLtymrc=
X-Google-Smtp-Source: AMsMyM57F2e1pkir5cLcENr/NGv8gZVjUbB/97CEMjfcnFPYB7ZnEwiO4FsIsZ9jyOvZjWsnqNhBfg==
X-Received: by 2002:a05:6808:f01:b0:354:2d95:3f96 with SMTP id m1-20020a0568080f0100b003542d953f96mr155387oiw.41.1666974848978;
        Fri, 28 Oct 2022 09:34:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d24-20020a9d5e18000000b0066c312b044dsm733848oti.27.2022.10.28.09.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 09:34:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7acc7a49-debb-abdb-f01c-f8adef4c1f0e@roeck-us.net>
Date:   Fri, 28 Oct 2022 09:34:05 -0700
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
 <e4040686-851c-d8b0-b274-ac71d38685e1@roeck-us.net>
 <Y1wAHyV/tLKQmo7l@e120937-lin>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 7/8] hwmon: (scmi) Register explicitly with Thermal
 Framework
In-Reply-To: <Y1wAHyV/tLKQmo7l@e120937-lin>
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

On 10/28/22 09:15, Cristian Marussi wrote:
> On Fri, Oct 28, 2022 at 08:58:58AM -0700, Guenter Roeck wrote:
>> On 10/28/22 08:35, Cristian Marussi wrote:
>> [ ... ]
>>>>> +	/*
>>>>> +	 * Try to register a temperature sensor with the Thermal Framework:
>>>>> +	 * skip sensors not defined as part of any thermal zone (-ENODEV) but
>>>>> +	 * report any other errors related to misconfigured zones/sensors.
>>>>> +	 */
>>>>> +	tzd = devm_thermal_of_zone_register(dev, th_sensor->info->id, th_sensor,
>>>>> +					    &scmi_hwmon_thermal_ops);
>>>>> +	if (IS_ERR(tzd)) {
>>>>> +		devm_kfree(dev, th_sensor);
>>>>> +
>>>>> +		if (PTR_ERR(tzd) != -ENODEV)
>>>>> +			return PTR_ERR(tzd);
>>>>> +
>>>>> +		dev_info(dev, "Sensor '%s' not attached to any thermal zone.\n",
>>>>> +			 sensor->name);
>>>>
>>>> There were complaints about this message as it is noisy. If you send
>>>> another version, please drop it unless attaching each sensor to a thermal
>>>> zone is strongly expected. If you don't send another version, I'll drop it
>>>> while applying.
>>>>
>>>
>>> Ok fine for me. I am waiting to have some feedback from Sudeep too, but
>>> I do not have plan for another version as of now.
>>>
>>> As a side note, though, I understand the 'noisiness' argument, but,
>>> sincerely this same message in the original HWMON code was the only
>>> reason why I spotted that something was wrong with the SCMI/HWMON
>>> interactions and discovered the indexes/ids mismatch...if not for
>>> that it would have gone un-noticed that a perfectly configured
>>> ThermalZone/Sensor was not working properly...
>>> (un-noticed at least until something would have been burnt to fire
>>>    in my house .. joking :P)
>>>
>>
>> Good point.
>>
>> Did you ever check the returned error code ? Maybe we could use it to
>> distinguish "it is not attached to a thermal zone because it is not
>> associated with one" from "attaching to a thermal zone failed because
>> its configuration is bad/incomplete".
>>
> 
> Yes, it is what I do already indeed, in this regards I mimicked what
> the hwmon-thermal bridge was doing.
> 
> In scmi_thermal_sensor_register() this message is printed out only
> if Thermal registration returned -ENODEV and no err is reported
> (which means teh specified sensor was not found attached to any TZ),
> while in the caller of scmi_thermal_sensor_register() for any error
> returned but -ENOMEM I print:
> 
> 	"Thermal zone misconfigured for %s. err=%d\n",
> 
> since any error reported by Thermal other than ENODEV and ENOMEM
> means the DT parsing unveiled some configuration anomaly.
> 

Ok, then let's hope that this finds misconfigurations and drop the
info message.

I just noticed another problem in your code:

+		if (ret == -ENOMEM)
+			return ret;
+		else if (ret)
+			dev_warn(dev,
+				 "Thermal zone misconfigured for %s. err=%d\n",
+				 sensor->name, ret);

Static analyzers will rightfully notice that else after return is unnecessary.
Please rewrite and drop the else. I think something like

		if (ret) {
			if (ret == -ENOMEM)
				return ret;
			dev_warn(dev,
				 "Thermal zone misconfigured for %s. err=%d\n",
				 sensor->name, ret);
		}

would be better since ret would only be evaluated once in the no-error case.

Thanks,
Guenter

