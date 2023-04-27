Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486286F0D7E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344097AbjD0Uxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343615AbjD0Uxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:53:51 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A621989
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:53:47 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f199696149so45435595e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 13:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682628826; x=1685220826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xD786TZT7B+/3S4wzJgEnZTLWsTRx10unO92/z5CZGc=;
        b=azCUsh6921oUgHNRyfqO5FxwrJoviUyl7ZwWzqkMETiUgEFKwDsNBbFg8S1Gt0NXTb
         IGJS/yps0R6b3f3LrWeXIFIpH/68i+amTZYzApkLKMjRZi2M2vywnpPubCuI+G9DWxil
         d520ZYFUy8llub9eQ9lomnW9eCqPwOx8UmXUejcTJuXzYG6bLXLh4100x614KXVrZnNE
         LpSc8qHZMAN6UrZCgZvOpjA6Btf1nvCFoRhUOhtIs2nqH44oQTk0Q3ZSsKw1CNfsV/0t
         XoTO+m7tIBeKEh6Sf/H/mN81A7CsU8nY5JbJhXvxU4Ddnu45W65pc+VyAYwG5dyWn+8k
         d60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682628826; x=1685220826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xD786TZT7B+/3S4wzJgEnZTLWsTRx10unO92/z5CZGc=;
        b=A71NwR9nPMkfOPfsSHzbYZRslJJTaz6H9MS6vOU/Bkt1IkHYvdErz8q4ZgXDVGduR8
         c1jDqelWSlBbbkZEkPoo6kqB21EurDVZpIuL4kvS4UbOKEO92468uUQyW3ySg1HsuS43
         z9COfsV+Oxe6v4BXytsSHXA4CGcC9CwMcPs+puHJAfW2Ml9ZDQSvNin3949wF4XuQLGq
         PkNPt1ePUogKxze7EOLvU3R/ibaeaDS3JQCama/RYSAwvEcBFyds9XqZZdMQ253L2SBI
         oZDWoImJbEqwa0QGiXeLTqt4UofL1lnAmAJgECSoOgK2U+dhzjQEAaA1lbaDp56EpS5y
         l8Mw==
X-Gm-Message-State: AC+VfDyGgxEzU6NNPHaNNvs4MpifdTfPMKjbnbf1VOVdbqDcuHVB05YL
        jxnxUJKI7U2b9MUUj9Ublm+Lq/rqRFYDjCKl3lf5oQ==
X-Google-Smtp-Source: ACHHUZ5s+2AVbZ7GKUo6usOUQ4yRJYhHyyrpGJYDTK9r1qH0dGog9PlLpihu9NJZ9VsCjwEgfuZVUQ==
X-Received: by 2002:a7b:c7d0:0:b0:3f1:75b3:60df with SMTP id z16-20020a7bc7d0000000b003f175b360dfmr2300008wmk.41.1682628826054;
        Thu, 27 Apr 2023 13:53:46 -0700 (PDT)
Received: from [172.23.3.48] ([31.221.30.162])
        by smtp.googlemail.com with ESMTPSA id h15-20020a05600c314f00b003f1978bbcd6sm23530408wmo.3.2023.04.27.13.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 13:53:45 -0700 (PDT)
Message-ID: <93fcee42-0157-52e2-d694-83307f0eadaf@linaro.org>
Date:   Thu, 27 Apr 2023 22:53:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 0/6] Thermal zone device structure encapsulation
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20230419083343.505780-1-daniel.lezcano@linaro.org>
 <CAJZ5v0jKRew48KNXXBJjENxpOhEE5jxwfAcmiuu_4nvhQL-FGA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0jKRew48KNXXBJjENxpOhEE5jxwfAcmiuu_4nvhQL-FGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2023 19:23, Rafael J. Wysocki wrote:
> On Wed, Apr 19, 2023 at 10:33 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> The thermal zone device structure is defined in the exported thermal
>> header include/linux/thermal.h
>>
>> Given the definition being public, the structure is exposed to the
>> external components other than the thermal framework core code. It
>> results the drivers are tampering the structure internals like taking
>> the lock or changing the field values.
>>
>> Obviously that is bad for several reasons as the drivers can hook the
>> thermal framework behavior and makes very difficult the changes in the
>> core code as external components depend on it directly.
>>
>> Moreover, the thermal trip points being reworked, we don't want the
>> drivers to access the trips array directly in the thermal zone
>> structure and doing assumptions on how they are organized.
>>
>> This series provides a second set of changes moving to the thermal
>> zone device structure self-encapsulation.
>>
>> The ACPI and the Menlon drivers are using the thermal zone's device
>> fields to create symlinks and new attributes in the sysfs thermal zone
>> directory. These changes provide a hopefully temporary wrapper to
>> access it in order to allow moving forward in the thermal zone device
>> self-encapsulation and a Kconfig option to disable by default such a
>> extra sysfs information.
>>

[ ... ]

> Patches [4/6] and [6/6] were superseded by the Menlow driver removal.
> 
> I've applied the rest as 6.4-rc material, with some subject
> adjustments and after removing some trailing white space in a few
> places.


Thanks!

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

