Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E4860A6F7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 14:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbiJXMm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 08:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbiJXMjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 08:39:36 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D97F7D7A0;
        Mon, 24 Oct 2022 05:07:18 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id j188so10574680oih.4;
        Mon, 24 Oct 2022 05:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=CbU95M10rqKY9XTXjrLAHGbidlvO8mcbEqMNhmT7zvE=;
        b=lZ72Dng6YwE1VM+uB0t4UEk3Y1M9gpQwvU+esV+jNeqLh/Af6sPMswmzLSAnudaLSn
         Vq6KW2BBQOJy6bgnGyAofVWyQQGJDoL78TW/swcYuOV/8v43h5Lf2cqGaZWcoPHBCC0B
         +O5tahgUM9fWvEE7V2Ws8lynfYb+GyC9uAPsw769WBn+OtlHX+Gz/+TIZlfNDMeWYEah
         pFZYUW+YmWwzCcq2C2FoziwEGUSx998jU1v7ZmgBq45oTvhCIEFoj/Y8efDUkCwPQBoC
         eH/6/KtDuqtmOnmFZ82Jt1wg5VFyN0SRyjVDngcTQK7tmH9vHCgLbXpJ9zlUiPJnSbfv
         ldHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbU95M10rqKY9XTXjrLAHGbidlvO8mcbEqMNhmT7zvE=;
        b=rIJcIO2Hv+sOijdSnNs0kO08GgdInm2wVTcyVZ8948IYk9swncFL0BciEkGnFmEaIU
         31X21fmKzdcuMxsY3tGEImuz7HB5x6VfqcgcUbMtrzENOMM1Ou6ymS9m4Bx9w1dAJ6nF
         VboMroPNC0ep9DfS0hiMFi5slNODxU3WCu+ftSD32ft5oeGyrLRdEJCBf5TsMh/F+ile
         M89cWqagkmZ00BhDh5Zxr7befvzDDMueNBiwliRRSugsLpB7cLykbBZjDR+C3y59gKOF
         +twnff2IvwMpRZ5+bsNW2x5VlzH6xrq2KfdIy8VloM6u4ULvPoGuS4kuupV36EE/cvm/
         bk6Q==
X-Gm-Message-State: ACrzQf16hVvz4qrtFLfoXG0xMkPNx87ewe3N9YNmJFS3RB2C8Yciuluj
        2DdAf0O1eq3DpzRkkbKeexDHXgYlZeM=
X-Google-Smtp-Source: AMsMyM7eUvJ+DnIELw80appBQ9f9gpDH65K7vBNEnv7NXO4DBYMxT/SuDsF5dZgN1MxDw4UuOtzYog==
X-Received: by 2002:a05:6870:538a:b0:132:756f:2c98 with SMTP id h10-20020a056870538a00b00132756f2c98mr35892818oan.134.1666612607711;
        Mon, 24 Oct 2022 04:56:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q9-20020a05683033c900b006622d085a7fsm3493018ott.50.2022.10.24.04.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 04:56:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <93e24737-29e4-6e03-7b47-cd730989047f@roeck-us.net>
Date:   Mon, 24 Oct 2022 04:56:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: (bug report) HWMON & Thermal interactions
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        daniel.lezcano@linaro.org
Cc:     sudeep.holla@arm.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <Y1WHnJ6h1RSOipV4@e120937-lin>
 <8005acfe-da2d-8d38-0e87-a96c438eeab1@roeck-us.net>
In-Reply-To: <8005acfe-da2d-8d38-0e87-a96c438eeab1@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/23/22 14:23, Guenter Roeck wrote:
> On 10/23/22 11:27, Cristian Marussi wrote:
>> Hi,
>>
>> Starting with v6.1-rc1 the SCMI HWMON driver failed probing on my JUNO due
>> to the fact that no trip points were (ever !) defined in the DT; bisecting it
>> looks like that after:
>>
>> https://lore.kernel.org/all/20220804224349.1926752-28-daniel.lezcano@linexp.org/
>>
>> the presence of the mandatory trips node within thermal zones is now
>> enforced.
>>
>> So, this is NOT what this bug report is about (I'll post soon patches for
>> the JUNO DT missing trips) BUT once this problem was solved in the DT,
>> another issue appeared:
>>
>> [    1.921929] hwmon hwmon0: temp2_input not attached to any thermal zone
>>
>> that despite having now a goodi/valid DT describing 2 sensors and 2 thermal zones
>> embedding that sensors, only the first one is found as belonging to one ThermZ.
>> (this happens ALSO with v6.0 once I added the trips...)
>>
>> Digging deep into this, it turned out that inside the call chain
>>
>> devm_hwmon_device_register_with_info
>>    hwmon_device_register_with_info
>>      __hwmon_device_register
>>     hwmon_thermal_register_sensors(dev)
>>         --> hwmon_thermal_add_sensor(dev, j)
>>             --> devm_thermal_of_zone_register(dev, sensor_id, tdata, )
>>
>> the HWMON channel index j is passed to the Thermal framework in order to
>> search and bind sensors with defined thermal zone, but this lead to the
>> assumption that sequential HWMON channel indexes corresponds one-to-one to the
>> underlying real sensor IDs that the ThermalFramework uses for matching
>> within the DT.
>>
>> On a system like my SCMI-based DT where I have 2 temp-sensors bound to 2
>> thermal zones like:
>>
>> thernal_zones {
>>     pmic {
>>         ...
>>         thermal-sensors = <&scmi_sensors0 0>;
>>         ...
>>         trips {
>>             ...
>>         }
>>     soc {
>>         ...
>>         thermal-sensors = <&scmi_sensors0 3>;
>>         ...
>>         trips {
>>             ...
>>         }
>>     }
>> }
>>
>> This works fine by chance for the pmic (j=0, sensor_id=0) BUT cannot work for
>> the soc where J=1 BUT the real sensor ID is 3.
>>
>> Note that there can be a number of sensors, not all of them of a type handled
>> by HWMON, and enumerated by SCMI in different ways depending on the
>> platform.
>>
>> I suppose this is not an SCMI-only related issue, but maybe in non-SCMI
>> context, where sensors are purely defined in the DT, the solution can be
>> more easily attained (i.e. renumber the sensors).
>>
>> At first I tried to solve this inside scmi-hwmon.c BUT I could not find
>> a way to present to the HWMON subsystem the list of sensors preserving
>> the above index/sensor_id matching (not even with a hack like passing
>> down dummy sensors to the HWMON subsystem to fill the 'holes' in the
>> numbering)
>>
>> My tentative solution, which works fine for me in my context, was to add
>> an optional HWMON hwops, so that the core hwmon can retrieve if needed the
>> real sensor ID if different from the channel index (using an optional hwops
>> instead of some static hwinfo var let me avoid to have to patch all the
>> existent hwmon drivers that happens to just work fine as of today...but
>> maybe it is not necessarily the proper final solution...)
>>
>> i.e.
>>
>> ----8<----
>>
>> Author: Cristian Marussi <cristian.marussi@arm.com>
>> Date:   Fri Oct 21 17:24:04 2022 +0100
>>
>>      hwmon: Add new .get_sensor_id hwops
>>      Add a new optional helper which can be defined to allow an hwmon chip to
>>      provide the logic to map hwmon indexes to the real underlying sensor IDs.
> 
> Maybe I am missing something, but ...
> 
> The driver isn't supposed to know anything about thermal devices and
> thermal zones. If that no longer works, and drivers have to know about
> thermal zones and thermal zone device index values anyway, we might
> as well pull thermal device support from the hwmon core and implement
> it in drivers.
> 

No, wait: The question is really: Why does the scmi driver present the sensor
with index 3 to the hwmon subsystem as sensor with index 1 ?

If the sensor has index 3, and is presented to other entities as sensor
with index 3, it should be presented to the hwmon subsystem as sensor with
index 3, not with index 1. If sensors with index 1..2 do not exist,
the is_visible function should return 0 for those sensors.

Guenter

> Guenter
> 

