Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C232F60AFF0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiJXP6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiJXP5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:57:53 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B1812A35A;
        Mon, 24 Oct 2022 07:52:59 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id j188so11075043oih.4;
        Mon, 24 Oct 2022 07:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QGp3vy8SaD8VcezG8ydCZcPCdpgA7nYU+TlH07+fURI=;
        b=oG6EFbpSdscf73YHAhbG6iqDAWJDkpTMJQtXR8Wae6hHa419KUpn2/mNyLxjk8mAMs
         XkiQFCInJWWb5Ol2FIOAIbi+gozIp8lWy/gQbktjmkUNgohmD0nF8p2NrrmT5P4mKMoy
         6EdxU2oacA70swgtqLSnIXk7wv79x0EYlGjx95uA2zLe+6Z9pUh8TcBM8SwFTljT6y52
         d+r9hfKqjT+T5NSC6n/+bTRWNW9SWdX6Hfqz1i576VDH1/sCk1u4Z5mt4tF5PuOC0vku
         8YOK3Lr+mWTJzP/7je+HP5K8wcRX24QdcVhTEv5Sgix9H4O0WzoehPfBZyLrBqfuTSuf
         i7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QGp3vy8SaD8VcezG8ydCZcPCdpgA7nYU+TlH07+fURI=;
        b=W2PD0XLkcLcmD8Mesgbc7fypQUD1pYwoJ1zPrEzlcWOz1oOGoxXpPwqo6Pqa5Xdr0I
         fvGO3rDRWGT3kYcrbPbpbW6f6AuqUxdAc7Na2kdCyWRiDJ/nqPVCBvvArvbviqDpnSR0
         nE9pSnknbl5iigbmAoVNxZvY+cyQhdqATT/llS9jnEdKyiO2TnLP769TdIqWg+naGwIs
         XM/0musfoWHYKuKD8+7ByzwbbYt1G9ahzwiXi1mymTf6yeWrLWAB7KwSd+P1wYNKdO8E
         ysDI6jO+D/YEVH6XonE6xPOBgQOI2kMKVjq7tfcj8dITYWmZsMGl91q4zf0jlDI9KNdR
         5AnQ==
X-Gm-Message-State: ACrzQf2dK/VeDv22ZtVnsyKC7vZDsjqU4b+Vn8Z/eqrK+Ju/05RZWdO/
        tUn3bKHgGCnzdj2b0P3byG4+8HfTiTs=
X-Google-Smtp-Source: AMsMyM7/V4HRDb8D0rYzffYVnXxIL+7NX9ZTNgzLTCdTGLrNKtiqd3EO/fxKCywSxXRP/WTo/96Tdg==
X-Received: by 2002:a05:6808:124a:b0:351:9c1a:cab8 with SMTP id o10-20020a056808124a00b003519c1acab8mr30792452oiv.39.1666623071888;
        Mon, 24 Oct 2022 07:51:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o10-20020a4aa80a000000b00476989d42ebsm68544oom.8.2022.10.24.07.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 07:51:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <24b7c1b4-c690-408b-7ebf-a4e4a4cf919e@roeck-us.net>
Date:   Mon, 24 Oct 2022 07:51:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     daniel.lezcano@linaro.org, sudeep.holla@arm.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Y1WHnJ6h1RSOipV4@e120937-lin>
 <8005acfe-da2d-8d38-0e87-a96c438eeab1@roeck-us.net>
 <93e24737-29e4-6e03-7b47-cd730989047f@roeck-us.net>
 <Y1aJTxVdOS6BIVTV@e120937-lin>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: (bug report) HWMON & Thermal interactions
In-Reply-To: <Y1aJTxVdOS6BIVTV@e120937-lin>
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

On 10/24/22 05:47, Cristian Marussi wrote:
> On Mon, Oct 24, 2022 at 04:56:43AM -0700, Guenter Roeck wrote:
>> On 10/23/22 14:23, Guenter Roeck wrote:
>>> On 10/23/22 11:27, Cristian Marussi wrote:
>>>> Hi,
>>>>
>>>> Starting with v6.1-rc1 the SCMI HWMON driver failed probing on my JUNO due
>>>> to the fact that no trip points were (ever !) defined in the DT; bisecting it
>>>> looks like that after:
>>>>
>>>> https://lore.kernel.org/all/20220804224349.1926752-28-daniel.lezcano@linexp.org/
>>>>
>>>> the presence of the mandatory trips node within thermal zones is now
>>>> enforced.
>>>>
>>>> So, this is NOT what this bug report is about (I'll post soon patches for
>>>> the JUNO DT missing trips) BUT once this problem was solved in the DT,
>>>> another issue appeared:
>>>>
>>>> [    1.921929] hwmon hwmon0: temp2_input not attached to any thermal zone
>>>>
>>>> that despite having now a goodi/valid DT describing 2 sensors and 2 thermal zones
>>>> embedding that sensors, only the first one is found as belonging to one ThermZ.
>>>> (this happens ALSO with v6.0 once I added the trips...)
>>>>
>>>> Digging deep into this, it turned out that inside the call chain
>>>>
>>>> devm_hwmon_device_register_with_info
>>>>     hwmon_device_register_with_info
>>>>       __hwmon_device_register
>>>>      hwmon_thermal_register_sensors(dev)
>>>>          --> hwmon_thermal_add_sensor(dev, j)
>>>>              --> devm_thermal_of_zone_register(dev, sensor_id, tdata, )
>>>>
>>>> the HWMON channel index j is passed to the Thermal framework in order to
>>>> search and bind sensors with defined thermal zone, but this lead to the
>>>> assumption that sequential HWMON channel indexes corresponds one-to-one to the
>>>> underlying real sensor IDs that the ThermalFramework uses for matching
>>>> within the DT.
>>>>
>>>> On a system like my SCMI-based DT where I have 2 temp-sensors bound to 2
>>>> thermal zones like:
>>>>
>>>> thernal_zones {
>>>>      pmic {
>>>>          ...
>>>>          thermal-sensors = <&scmi_sensors0 0>;
>>>>          ...
>>>>          trips {
>>>>              ...
>>>>          }
>>>>      soc {
>>>>          ...
>>>>          thermal-sensors = <&scmi_sensors0 3>;
>>>>          ...
>>>>          trips {
>>>>              ...
>>>>          }
>>>>      }
>>>> }
>>>>
>>>> This works fine by chance for the pmic (j=0, sensor_id=0) BUT cannot work for
>>>> the soc where J=1 BUT the real sensor ID is 3.
>>>>
>>>> Note that there can be a number of sensors, not all of them of a type handled
>>>> by HWMON, and enumerated by SCMI in different ways depending on the
>>>> platform.
>>>>
>>>> I suppose this is not an SCMI-only related issue, but maybe in non-SCMI
>>>> context, where sensors are purely defined in the DT, the solution can be
>>>> more easily attained (i.e. renumber the sensors).
>>>>
>>>> At first I tried to solve this inside scmi-hwmon.c BUT I could not find
>>>> a way to present to the HWMON subsystem the list of sensors preserving
>>>> the above index/sensor_id matching (not even with a hack like passing
>>>> down dummy sensors to the HWMON subsystem to fill the 'holes' in the
>>>> numbering)
>>>>
>>>> My tentative solution, which works fine for me in my context, was to add
>>>> an optional HWMON hwops, so that the core hwmon can retrieve if needed the
>>>> real sensor ID if different from the channel index (using an optional hwops
>>>> instead of some static hwinfo var let me avoid to have to patch all the
>>>> existent hwmon drivers that happens to just work fine as of today...but
>>>> maybe it is not necessarily the proper final solution...)
>>>>
>>>> i.e.
>>>>
>>>> ----8<----
>>>>
>>>> Author: Cristian Marussi <cristian.marussi@arm.com>
>>>> Date:   Fri Oct 21 17:24:04 2022 +0100
>>>>
>>>>       hwmon: Add new .get_sensor_id hwops
>>>>       Add a new optional helper which can be defined to allow an hwmon chip to
>>>>       provide the logic to map hwmon indexes to the real underlying sensor IDs.
>>>
>>> Maybe I am missing something, but ...
>>>
>>> The driver isn't supposed to know anything about thermal devices and
>>> thermal zones. If that no longer works, and drivers have to know about
>>> thermal zones and thermal zone device index values anyway, we might
>>> as well pull thermal device support from the hwmon core and implement
>>> it in drivers.
>>>
>>
>> No, wait: The question is really: Why does the scmi driver present the sensor
>> with index 3 to the hwmon subsystem as sensor with index 1 ?
>>
>> If the sensor has index 3, and is presented to other entities as sensor
>> with index 3, it should be presented to the hwmon subsystem as sensor with
>> index 3, not with index 1. If sensors with index 1..2 do not exist,
>> the is_visible function should return 0 for those sensors.
>>
> 
> My understanding was that the hwmon index is the index of the channel
> and hwmon_channel_info struct groups channels by type while the index is
> really used as a pointer in the hwmon_channel_info.config field, so in
> this case you're saying I should present 4 temp sensors placing a 'hole'
> at sensor 1,2 making is_visible return 0 for those channels ?
> 
> Basically keeping the channel indexes in sync with the real sensor ID by
> the means of some dummy sensor entries in the config field: this could result
> potentially in a lot of holes given in SCMI the sensor_id is 16 bits and
> I thought that was too hackish but I can try.
> 

The underlying idea with the hwmon -> thermal bridge is that index values
used by thermal and by the hwmon subsystem match and, yes, that there would
if necessary be holes in hwmon index values (normally this is not a 16-bit
number space). If that doesn't work for scmi, and if there could indeed be
something like

         thermal-sensors = <&scmi_sensors0 12345>;

then I think the solution is indeed to not rely on the hwmon->thermal bridge
in the hwmon core for this driver.

> In the meantime, I gave it a go at what you suggested early (if I got it
> right...) by removing from the scmi-hwmon driver the HWMON_C_REGISTER_TZ
> attribute and adding a few explicit calls to devm_thermal_of_zone_register() at
> the end of the probe to specifically register the needed temp sensors (and
> associated real sensor IDs) with the ThermalFramework without relying on the
> HWMON core for Thermal and it works fine indeed.
> 

Excellent.

Thanks,
Guenter

