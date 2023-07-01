Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9237447B1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 09:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjGAH2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 03:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjGAH2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 03:28:36 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C971A3
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 00:28:34 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fb4146e8ceso31241855e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 00:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688196512; x=1690788512;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qP5UllHuZXC3hd0iLmBfiZxW7l6TOOsMoZA6FcK19FM=;
        b=HWTmlrV3QfqaYDorYKv86jQCoZU6N7Ji4wa1QzzEmsoMFrgqp5cXBPQkqYO6RhoJrt
         OMgCuxzOZV6U7NLCLllWehqAU1br0Cj99XtielJXjH0vtEItJnrkZcwi5aiQ9OKdmtDY
         Q9A/xEzTaYQkszawJHDc+mtC7LwD6bt2awQYLG+ycz1aizL7EkZdofCyymLtKhv1ZNz3
         3TjFr5Tcci6+Gug59XLL4912dDw99li64nXgikhdsE1m72dF9r2XyCgR+UoUfjg9p2L6
         HdUBlsgbO+jYrmIK7txaOOoyWQTrnvr1keTbUiMG2x79IoONNQqw0cyo27pJq6Nb/0IR
         6lQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688196512; x=1690788512;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qP5UllHuZXC3hd0iLmBfiZxW7l6TOOsMoZA6FcK19FM=;
        b=Vcpueo12c2AvqsRzK3+SUXR84pObV5EdYSo5lfwxQKonCSDXtLbM/azbIZnymMLP//
         VxuBICHSzwNAurw7DMpGMlhSQv0sbzBJJFsSiPPUXrCBAGN2NrPUhqRW5jUbUUNKUJBo
         Zdr6aKi0WHYQUiY3zLU/OJXE2BPP04wpk2sLx71hPFACkg/spqP2OyRoYh5Okk3C+5f0
         lWQn7XZXVZE0HIbyLUAI2jLV+Bo71lm+hW3tQDcmRQ6b08heez17KptVTNXnjIq8xx7P
         VfWzGV/DSRiW51e1dR5LaVbqMhXhAblIwfeYL/0heirXg4lxLrlcqAdBH9msJMR6fmZP
         o9iw==
X-Gm-Message-State: ABy/qLbXEj12BJAOVSGHRSIweCOr9atbOfIRrY2QpzaSznsjFA3rwr4G
        wkx3i/QXZ8sIHBil9YNTGLREhA==
X-Google-Smtp-Source: APBJJlFjtuC3Tiza+s3Cb7QixRQeylJI0w5f72lgqwymNXHkL0Y0+Z4T49/L9iwnc4UyE635aXPrvg==
X-Received: by 2002:a5d:6305:0:b0:314:1e86:e75d with SMTP id i5-20020a5d6305000000b003141e86e75dmr3520606wru.34.1688196512321;
        Sat, 01 Jul 2023 00:28:32 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id cs7-20020a056000088700b0030ada01ca78sm20230874wrb.10.2023.07.01.00.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jul 2023 00:28:31 -0700 (PDT)
Message-ID: <0c766514-1063-bb57-192e-332559e22529@linaro.org>
Date:   Sat, 1 Jul 2023 09:28:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] thermal: sysfs: avoid actual readings from sysfs
Content-Language: en-US
To:     Eduardo Valentin <evalenti@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, eduval@amazon.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
References: <7616fd9d-aa0d-2ecd-8751-894b1c9073c0@linaro.org>
 <ZJKFar/U75+PGCRt@uf8f119305bce5e.ant.amazon.com>
 <75eba2da-593f-f3bd-4eac-5155fcf5aee8@linaro.org>
 <ZJPUchRH+3LLvuKy@uf8f119305bce5e.ant.amazon.com>
 <CAJZ5v0jAJj-Eh9tJZRMamSFSWWJqVpzaWeHmqThyPvAGpzk17w@mail.gmail.com>
 <ZJyh1Dp5WrXyv9wW@uf8f119305bce5e.ant.amazon.com>
 <CAJZ5v0jn-zCgObgNYswGQK0vLbWaK1VhPZP1L+pB5k1BhNs5bA@mail.gmail.com>
 <2d59de0d-5011-780a-cb6c-94e6e2b74156@linaro.org>
 <CAJZ5v0jQssaVMim3b3yWEqw2NGt4SYSZP6Zb4i5O++=9Tp7C3w@mail.gmail.com>
 <1373aef0-c837-8e6f-fc94-9c6bd70a5b31@linaro.org>
 <ZJ+GIRfhuHxbSxRf@uf8f119305bce5e.ant.amazon.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ZJ+GIRfhuHxbSxRf@uf8f119305bce5e.ant.amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Eduardo,

On 01/07/2023 03:49, Eduardo Valentin wrote:

[ ... ]

>> All that are hypothesis, that is why having a real use case would help
>> to figure out the temperature limit drift at mitigation time.
> 
> Yeah, I guess the problem here is that you are assuming I2C is not a real
> use case, not sure why. But it is and very common design in fact.

If it is so common you should be able to reproduce the issue and give 
numbers. At this point, what I read is "that may happen because I2C is 
slow and we may monitor it at an insane rate, so let's cache the value".

>> Assuming it is really needed, I'm not sure that should be exported via
>> sysfs. It is a driver issue and it may register the thermal zone with a
>> parameter telling the userspace rate limit.
>>
>> On the other side, hwmon and thermal are connected. hwmon drivers
>> register a thermal zone and thermal drivers add themselves in the hwmon
>> sysfs directory. The temperature cache is handled in the driver level in
>> the hwmon subsystems and we want to handle the temperature cache at the
>> thermal sysfs level. How will we cope with this inconsistency?
> 
> Yeah, I do not see this, again, as where to handle cache type of design problem only.
> This is really a protective / defensive code on the thermal core to avoid
> userspace interfering on a kernel based control.
> 
> 
> I agree that drivers may be free to go and defend themselves against
> too frequent userspace requests, like they do, as you already shared
> a link in another email. But saying that it is up to the driver to do this
> is basically saying that the thermal subsystem do not care about their
> own threads being delayed by a too frequent reads on a sysfs entry
> created by the thermal subsystem, just because it is drivers responsability
> to cache. To that is a missing defensive code.

No, the core code has not to be defensive against bad hardware design.

If multiple processes are reading in an infinite loop the temperature, 
they will constantly take the lock, and as the monitoring thread is a 
CFS task, this one will be considered as the readers and be delayed, 
with probably a mitigation temperature drift. Here we have a missing 
defensive / optimized code against a DoS but it is unrelated to the 
hardware and the fix is not caching the value.

>> As a side note, slow drivers are usually going under drivers/hwmon.
> 
> Have you seen this code?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/hwmon/lm75.c#n517
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/hwmon/hwmon.c#n850

Yes, and ?

That is what I said, the hwmon and the thermal zone are connected.

> I also do not understand when you say slow drivers are usually going under
> drivers/hwmon, does it really matter? One can design a thermal zone
> that is connected to a hwmon device as input. Why would that be illogical?

I'm not saying it is illogical. I'm pointing the slow drivers are under 
hwmon subsystems and usually don't aim in-kernel mitigation. The 
get_temp ops is going through hwmon and the drivers may cache the 
values. So *if* there is an in-kernel mitigation, the value will be 
already cached usually.

I do believe I raised some valid concerns regarding the approach. Could 
please take them into account instead of eluding them?

1. A real use case with temperature limit drift (easy to reproduce 
because it is very common)

2. How about the consistency between hwmon and thermal? (one driver but 
two ways to access the temperature - one may cache and the other not)

Another question regarding the I2C example, if another subsystem is 
using the I2C, won't it take the bus lock and create the contention 
also? I mean it is possible to create a mitigation drift by reading 
constantly another sensor value (eg. voltage or whatever) ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

