Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2189360967A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 23:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJWVXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 17:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJWVXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 17:23:05 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3257AF585;
        Sun, 23 Oct 2022 14:23:04 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id j6-20020a4ab1c6000000b004809a59818cso1189740ooo.0;
        Sun, 23 Oct 2022 14:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=YJo2eoSpd0840BYnEtetg+AiX2kA0GgYy7/eADFAhgc=;
        b=XtzSyxWekFz4MnKQgq+88rWdcrb7O1160xWj5sgilKg3ViaeERF2evGfOFpld474rg
         gn1kQfBkGh+Vy+AEGL7rpBRDfAipRbznA3td7pdLTwCad8aAptmJYUwOFI03yviiagNT
         iSAeGMaEv96awqLdFSTySpDbAj9Mar9Vj7gNaZ+uR91HWNLu/ex4csux5h5b8xeCChiD
         BTFRlkjXgXPs2dhFdGkDJmLvB7PgyIdA0TKi8bJgbXf/qDe8/sR5iee3pjppaNTPYeL3
         S6WRSA/0K13/EZ/S8nJuaApANQJjVGuh5T1bIzTprjBAg378OhlKp6jCeb+CCm+tngYz
         MkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJo2eoSpd0840BYnEtetg+AiX2kA0GgYy7/eADFAhgc=;
        b=zrsTcu40EQAUDTgWFOIwJpkheSchbUEqv9rwAhJWUugwFis0ENm4Dae//0+7cW0J3/
         +OAgqA+45i+x2+AAYcDUYZaL1yAfhV3/RaV+W/CSQ6NWvmHHy1/iRYRmqD1PoYEm6GJL
         DCCh0ki4K/TiiEJ5fpuy2FeuRR8iLZb1nB/0sdzK9RprCBr6Otzaa9gZBn9cf19QFz1A
         +MSd/CaZtVS7P1OP/dwlL3YPM7QxIR/kGgyp0sRKKr+dsVTtH+S/lWr3OJC+DWSFOuYy
         ZrtletAmA3Lhs9+7MOvhub6vltcUN28ISdb4fl+4c15gmjrWhdsO+kwXkJj9i7fFHTTq
         mxDw==
X-Gm-Message-State: ACrzQf3g09QIphsyNs10d9ejT4hmgOG9ClaseKSnWAMX4Ila9lu3VSxT
        xK8DdjmNj6QJwDgPTlpphBl/ib2oZW8=
X-Google-Smtp-Source: AMsMyM6JEe+XxWFLLlJkCBLnL9EQLxcNu2eThkj+/YQJ7v69SBs/Fdghu1cDYliuIRDrnYLFsGSmOg==
X-Received: by 2002:a4a:e54e:0:b0:44a:fb57:7022 with SMTP id s14-20020a4ae54e000000b0044afb577022mr13483192oot.91.1666560183485;
        Sun, 23 Oct 2022 14:23:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s16-20020a05683004d000b00661a33883b8sm3609848otd.71.2022.10.23.14.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 14:23:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8005acfe-da2d-8d38-0e87-a96c438eeab1@roeck-us.net>
Date:   Sun, 23 Oct 2022 14:23:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: (bug report) HWMON & Thermal interactions
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>,
        daniel.lezcano@linaro.org
Cc:     sudeep.holla@arm.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <Y1WHnJ6h1RSOipV4@e120937-lin>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <Y1WHnJ6h1RSOipV4@e120937-lin>
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

On 10/23/22 11:27, Cristian Marussi wrote:
> Hi,
> 
> Starting with v6.1-rc1 the SCMI HWMON driver failed probing on my JUNO due
> to the fact that no trip points were (ever !) defined in the DT; bisecting it
> looks like that after:
> 
> https://lore.kernel.org/all/20220804224349.1926752-28-daniel.lezcano@linexp.org/
> 
> the presence of the mandatory trips node within thermal zones is now
> enforced.
> 
> So, this is NOT what this bug report is about (I'll post soon patches for
> the JUNO DT missing trips) BUT once this problem was solved in the DT,
> another issue appeared:
> 
> [    1.921929] hwmon hwmon0: temp2_input not attached to any thermal zone
> 
> that despite having now a goodi/valid DT describing 2 sensors and 2 thermal zones
> embedding that sensors, only the first one is found as belonging to one ThermZ.
> (this happens ALSO with v6.0 once I added the trips...)
> 
> Digging deep into this, it turned out that inside the call chain
> 
> devm_hwmon_device_register_with_info
>    hwmon_device_register_with_info
>      __hwmon_device_register
> 	hwmon_thermal_register_sensors(dev)
> 		--> hwmon_thermal_add_sensor(dev, j)
> 			--> devm_thermal_of_zone_register(dev, sensor_id, tdata, )
> 
> the HWMON channel index j is passed to the Thermal framework in order to
> search and bind sensors with defined thermal zone, but this lead to the
> assumption that sequential HWMON channel indexes corresponds one-to-one to the
> underlying real sensor IDs that the ThermalFramework uses for matching
> within the DT.
> 
> On a system like my SCMI-based DT where I have 2 temp-sensors bound to 2
> thermal zones like:
> 
> thernal_zones {
> 	pmic {
> 		...
> 		thermal-sensors = <&scmi_sensors0 0>;
> 		...
> 		trips {
> 			...
> 		}
> 	soc {
> 		...
> 		thermal-sensors = <&scmi_sensors0 3>;
> 		...
> 		trips {
> 			...
> 		}
> 	}
> }
> 
> This works fine by chance for the pmic (j=0, sensor_id=0) BUT cannot work for
> the soc where J=1 BUT the real sensor ID is 3.
> 
> Note that there can be a number of sensors, not all of them of a type handled
> by HWMON, and enumerated by SCMI in different ways depending on the
> platform.
> 
> I suppose this is not an SCMI-only related issue, but maybe in non-SCMI
> context, where sensors are purely defined in the DT, the solution can be
> more easily attained (i.e. renumber the sensors).
> 
> At first I tried to solve this inside scmi-hwmon.c BUT I could not find
> a way to present to the HWMON subsystem the list of sensors preserving
> the above index/sensor_id matching (not even with a hack like passing
> down dummy sensors to the HWMON subsystem to fill the 'holes' in the
> numbering)
> 
> My tentative solution, which works fine for me in my context, was to add
> an optional HWMON hwops, so that the core hwmon can retrieve if needed the
> real sensor ID if different from the channel index (using an optional hwops
> instead of some static hwinfo var let me avoid to have to patch all the
> existent hwmon drivers that happens to just work fine as of today...but
> maybe it is not necessarily the proper final solution...)
> 
> i.e.
> 
> ----8<----
> 
> Author: Cristian Marussi <cristian.marussi@arm.com>
> Date:   Fri Oct 21 17:24:04 2022 +0100
> 
>      hwmon: Add new .get_sensor_id hwops
>      
>      Add a new optional helper which can be defined to allow an hwmon chip to
>      provide the logic to map hwmon indexes to the real underlying sensor IDs.
>      

Maybe I am missing something, but ...

The driver isn't supposed to know anything about thermal devices and
thermal zones. If that no longer works, and drivers have to know about
thermal zones and thermal zone device index values anyway, we might
as well pull thermal device support from the hwmon core and implement
it in drivers.

Guenter

