Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936376B6A55
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 19:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCLSsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 14:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjCLSsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 14:48:11 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE17C14D;
        Sun, 12 Mar 2023 11:48:05 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id a4-20020a056830008400b0069432af1380so5627568oto.13;
        Sun, 12 Mar 2023 11:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678646884;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gcl4oMofNIyToXKyBYFlHzkkGWWxRL1J2M6ea2UM9dY=;
        b=Slg6rupXetqrFrwKKwYdT8uc0ry1yxUWN+TE/F1/L9+8rIgbMozDV8g2cph0Yet3Li
         vV9Ac6kiQwO6aILjHO+hrFm91Yogoh/a9YKD2PClCjGBo5Fk46d/P0iLQQjLLSvQ7AbL
         b6UJNYiXp/tDyxgz424LYF9Stv5qKdV0nQ2vS9ZykzkKD07NAj+xV7+m7nm95weyXWGi
         hLwT5/i94jUpJRoXqXLxIx7AY5UNjCuic2xo+FVWISZ9yt6YCCk9ZzxDhV5R4NUXgOvj
         9Ywy+kL8Ys19roZXqLRN75wXwlZ9Gh6Srg7AXWS4w7IbOI/3n81HZaYpZ1IS5SmGOYRW
         LMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678646884;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gcl4oMofNIyToXKyBYFlHzkkGWWxRL1J2M6ea2UM9dY=;
        b=dJorvvZKE/C9HV3Fnb41HWYIqJ0odMyuaus685xufVtEVPAzy7V6tn+lZ33vdwGkIa
         h9WDOlC3AuqnHJTP/8qNXxyY6fyoHqiQtwW+E5CK4SwV7tMn9ac1TuhAuQydPs0zGpNE
         0c/meC98PKzKsCCaAhRUXzQGWph1u+1nhfZ6m3jtW0EBC/+lWsYNZ415TBVTSpE/mmTo
         CGdagCFi6u17tzaZFuJpap/BESLAyDAEW8KcvNTYsUhP2+VWxndS8q16wc+77XOu8vIh
         Biwrl9OcVrePspy5jE2f6g8luHTJj17QJpZKWYZId9iCRJ0FttCINZ+ox6MLWmRAGF99
         sfKQ==
X-Gm-Message-State: AO0yUKWHlqlneErPYZVT0DqfJyU1APAtz4adSb6hZv3v+sUCfb6lj7Rj
        x7pfq5EkSWaf7tnecRnVnwE=
X-Google-Smtp-Source: AK7set/Z5EfQhbLT5zJAjq+ylrQsq2jaeoqk/zZBrIoWDfsdqgmXKHrZhczR7c6MN1K855KN8levRw==
X-Received: by 2002:a9d:705c:0:b0:68b:bf5e:492c with SMTP id x28-20020a9d705c000000b0068bbf5e492cmr19065020otj.28.1678646884416;
        Sun, 12 Mar 2023 11:48:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i17-20020a9d6251000000b0069457b86060sm2417927otk.47.2023.03.12.11.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 11:48:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9343421e-d35d-8d99-1ea7-1f81e28fbabb@roeck-us.net>
Date:   Sun, 12 Mar 2023 11:48:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230311111610.251774-1-krzysztof.kozlowski@linaro.org>
 <cd9067c7-0b99-4d62-9d5a-cdc028f33ba5@roeck-us.net>
 <48b6689e-f045-5e24-ead7-f6da5b8fe454@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] hwmon: gpio-fan: mark OF related data as maybe unused
In-Reply-To: <48b6689e-f045-5e24-ead7-f6da5b8fe454@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/23 11:08, Krzysztof Kozlowski wrote:
> On 12/03/2023 19:06, Guenter Roeck wrote:
>> On Sat, Mar 11, 2023 at 12:16:09PM +0100, Krzysztof Kozlowski wrote:
>>> The driver can be compile tested with !CONFIG_OF making certain data
>>> unused:
>>>
>>>    drivers/hwmon/gpio-fan.c:484:34: error: ‘of_gpio_fan_match’ defined but not used [-Werror=unused-const-variable=]
>>>
>>
>> How do you trigger that ? The driver depends on OF_GPIO which
>> in turn depends on OF. Arguably that means that of_match_ptr()
>> doesnot really make sense, but still I don't see how you can
>> trigger the above error message.
> 
> I can drop of_match_ptr, it's indeed in many cases not needed.
> 
> I just build x86_64 allyesconfig minus OF, with W=1.
> 

x86_64 allyesconfig minus OF minus results in SENSORS_GPIO_FAN being
deselected (it doesn't show up in the configuration anymore at all
after "make olddefconfig").

$ make allyesconfig
$ grep SENSORS_GPIO_FAN .config
CONFIG_SENSORS_GPIO_FAN=y
$ sed -i -e 's/CONFIG_OF=y/# CONFIG_OF is not set/' .config
$ make olddefconfig
#
# configuration written to .config
#
$ grep SENSORS_GPIO_FAN .config
$

I suspect what you did is to disable CONFIG_OF, and then you built
the driver without realizing that is was deselected.

> Do you want to me to drop of_match_ptr?
> 

Yes, sure, that makes more sense. The reason though is that the
driver depends on CONFIG_OF=y, not because of the build failure.

Thanks,
Guenter

