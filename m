Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C30A60688B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiJTS5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiJTS5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:57:37 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E7D16A4DB;
        Thu, 20 Oct 2022 11:57:34 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1364357a691so696687fac.7;
        Thu, 20 Oct 2022 11:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1mcRseKjTDv1dnCkTp74lsoW6tE2eVMgrAQoJL5kJyc=;
        b=iG5AeI0/6LPqVn/bxFYgGKQkry7Ay9XE/eaONqFI/mo9j/HJzjIgsqQWjrVzX1KPY5
         nhQEIA/n+LseZ/34DnuQUZ2jNxlStZec6mw4ErMnB/ogzF2OOGNdnfsMVdlbc+UbI4/v
         a1T/DzEAyyD5zPkokF6Dl8HPYckT8JGnDakXqUrezAt7fO75IFdhcBQ0dahfJRfZW2+T
         mB4sI67g5K5uPgo/3yo6f0AW0hjXCy4SE1PtQzsWblE4HdvLqQqlwZqz2TtBsVvj1Drm
         Pghy1wllNqcwN22+e/Q6lPVYa91kFmS8qKyQY1Rt/pNKyK4vLyEbcSKqq60DWSxi1LVx
         Wvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1mcRseKjTDv1dnCkTp74lsoW6tE2eVMgrAQoJL5kJyc=;
        b=N1/AkeV9CysaMGBnJPbYAq4+Z0u1jTeOk51AHkPr9WEKh8TwWkbiUah1t3stTbvJ/f
         8m8HAA5hL9qz/el5Yjf1/Q7vENpMjiNEsIWyjtAJNVrZuzNCfYNpcN9aB0NbbzPfyhI5
         R0rIwyQRwJP0ZuXlv0AdKOv0c6WMhL1NgcaOlcAFYzllMA1+lgNZRJvFtpM6yMjRB900
         s1w9fkFvs0ZbEID2Rw1GPCXR6n0RyaFsKmAiQtwT9jP/syJsno1WODYXk1zvGdfU+ZY6
         k2efCu1aFQJwdpoBN/r5Tn31HykaQdiR6MfPGLjJjchaVh753vO8IqzmIv5xDWIV7WF5
         o7eA==
X-Gm-Message-State: ACrzQf1FxnTqzRaHWA80aNrvaSH+xDvp4LQuhCgx0xP7V5wPwzrILrsu
        KwAkGAYdQWnDex3XhO3p7oE=
X-Google-Smtp-Source: AMsMyM5H583fHPrarJCAQlhw2RpOm6I+O7B5AbrTGYZYamUDFMvjnn4q0fz+fOy7Qin0SLVMP9j01A==
X-Received: by 2002:a05:6870:b68d:b0:12d:484a:2643 with SMTP id cy13-20020a056870b68d00b0012d484a2643mr26753310oab.105.1666292253132;
        Thu, 20 Oct 2022 11:57:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c8-20020a9d4808000000b00661ac688285sm269710otf.0.2022.10.20.11.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 11:57:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ba17a8b0-bd35-d172-fced-222ffa771ace@roeck-us.net>
Date:   Thu, 20 Oct 2022 11:57:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Cc:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
References: <20221019133910.282-1-Ibrahim.Tilki@analog.com>
 <409d7e93-f911-11b6-ed54-8ae8c94a8af0@roeck-us.net>
 <DM8PR03MB624786DEF5E135986ECB7B1F962A9@DM8PR03MB6247.namprd03.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] drivers: rtc: add max313xx series rtc driver
In-Reply-To: <DM8PR03MB624786DEF5E135986ECB7B1F962A9@DM8PR03MB6247.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/22 07:47, Tilki, Ibrahim wrote:
> ...
> 
>>> +
>>> +static int max313xx_wdt_ping(struct watchdog_device *wdd)
>>> +{
>>> +	int ret;
>>> +
>>> +	ret = max313xx_wdt_stop(wdd);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	return max313xx_wdt_start(wdd);
>>
>> Having to stop a watchdog just to ping it is unusual. Is this really
>> necessary ?
>>
> 
> Unfortunately RTCs do not have any other way of resetting timer counter
> other than restarting the timer.
> 

That is a bit too generic. I sampled a couple of rtc drivers implementing
watchdog support, and they all support pinging the watchdog without
stopping it (or, in other words, they have explicit watchdog support).

Looking at one of the chip datasheets, I would argue that the timers
on that chip series are not really suitable (nor intended) to support
watchdog functionality. They are real time alarm timers. They don't
generate an alarm N seconds in the future, but at specific times/dates.
That means that updating the time would interfere with watchdog functionality.
That is way too fragile to be usable as watchdog timer.

I would suggest to drop watchdog support from this driver.

Thanks,
Guenter

