Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8886779EA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 12:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjAWLPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 06:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjAWLPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 06:15:37 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C13AA268
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 03:15:35 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id y1so5939962wru.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 03:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3XkQ9oUZTbY4eAuJQ4rHHOrVFOAzENNJtkSeiTWtEh0=;
        b=wUtzcgACzqkGpAo+dlIAkkVs6Qga9eBS/4luyVihK9aL8B6be54Fdz8ErF4ZFZJOJH
         GA6F/QEDPB/5QQUKt47SnMBOxvtVP+LU6haiTyp5PPUSCD+9aeAh4mMyKKimLsa2Dz5e
         wpLH8Y9Q/2I8HkCyurp36dJyHl53vmT38wyKT0U4ON6cJy8FYY0RdjBquA3/ewmyoYR1
         5nefyRK7/5LFic8ciEONbsrNRkWjBOZyryDHEaPZ0A2AK/J4FcEeQoQcUTCV13YPJC7l
         1+sb3j5YU4Op9lqoer1aeogDqiVDX9aQfwuFTepkhNzn9IIHcI4ju8wLBQYlkyplx0qn
         tQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3XkQ9oUZTbY4eAuJQ4rHHOrVFOAzENNJtkSeiTWtEh0=;
        b=XS5gFhH4B36kwSP9KQoP87VQW5itHrr0yo3twycIU+C1MbfengBxe9IUq9TMyucOkQ
         c+MokG8yU6566EyAPpFTQvG64a5hh6Er2R4g9P06BafOxHnu09d5XTS214dMI6yntlMp
         6E0cykKbdkFIVN0mjReq6LDsVl/bjxlaombvuSjT+QUq4ESgpBx+DpNduYjWGEPHOtik
         zV0cZ8GU1MLivofYPcbaSSRs9+TaLlSGq4lnJr2F+ToB3VuPUfKYG1zbUKGwi+qyqCMo
         ihl5Z3+J1/wO2UxiuoWape7CcvT0ypf4UBPvSXDyML4QnLXF1seyTv4yrHGoPIlcDjff
         yttg==
X-Gm-Message-State: AFqh2kosgZRjDdURVn596lnjJtWW6ySI3P8y3kdw1mUByTPlLI9viIc5
        obWGvOdFeTB57BO5KDw+WcfRb23pFbXkW/IX
X-Google-Smtp-Source: AMrXdXtDML4IHtodIbfm9IsqYkufHLWTDtMNlTsWu6FPw06LoyDhO1IrZK4zXFMaz4QiNCrwC+nxTw==
X-Received: by 2002:a5d:5c07:0:b0:2bd:fa1d:5291 with SMTP id cc7-20020a5d5c07000000b002bdfa1d5291mr23368215wrb.67.1674472533568;
        Mon, 23 Jan 2023 03:15:33 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id b9-20020adff909000000b002be5401ef5fsm7908845wrr.39.2023.01.23.03.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 03:15:33 -0800 (PST)
Message-ID: <6a073166-af3c-4867-6237-dca6e03633db@linaro.org>
Date:   Mon, 23 Jan 2023 12:15:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 1/3] thermal/acpi: Add ACPI trip point routines
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rui.zhang@intel.com, christophe.jaillet@wanadoo.fr,
        Amit Kucheria <amitk@kernel.org>
References: <20230120231530.2368330-1-daniel.lezcano@linaro.org>
 <20230120231530.2368330-2-daniel.lezcano@linaro.org>
 <5911499.lOV4Wx5bFT@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <5911499.lOV4Wx5bFT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/01/2023 23:08, Rafael J. Wysocki wrote:
> On Saturday, January 21, 2023 12:15:28 AM CET Daniel Lezcano wrote:
>> The ACPI specification describes the trip points, the device tree
>> bindings as well.
>>
>> The OF code uses the generic trip point structures.
>>
>> The ACPI has their own trip points structure and uses the get_trip_*
>> ops to retrieve them.
>>
>> We can do the same as the OF code and create a set of ACPI functions
>> to retrieve a trip point description. Having a common code for ACPI
>> will help to cleanup the remaining Intel drivers and get rid of the
>> get_trip_* functions.
>>
>> These changes add the ACPI thermal calls to retrieve the basic
>> information we need to be reused in the thermal ACPI and Intel
>> drivers.
>>
>> The different ACPI functions have the generic trip point structure
>> passed as parameter where it is filled.
>>
>> This structure aims to be the one used by all the thermal drivers and
>> the thermal framework.
>>
>> After this series, a couple of Intel drivers and the ACPI thermal
>> driver will still have their own trip points definition but a new
>> series on top of this one will finish the conversion to the generic
>> trip point handling.
>>
>> This series depends on the generic trip point added to the thermal
>> framework and available in the thermal/linux-next branch.
>>
>>   https://lkml.org/lkml/2022/10/3/456
>>
>> It has been tested on a Intel i7-8650U - x280 with the INT3400, the
>> PCH, ACPITZ, and x86_pkg_temp. No regression observed so far.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Reviewed-by: Zhang Rui <rui.zhang@intel.com>
>> Tested-by: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> Co-developed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Also I'm not sure if this version has been tested and reviewed.
> 
> There are still a few things to improve in it, but overall I think that
> something like the patch below would be better - it is fewer lines of code
> and less duplication.

I'm always in favor of the simplest code, in terms of line of code and 
readability. I'm perfectly fine with your proposal.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

