Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECDA7098EE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 16:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjESODr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 10:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjESODo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 10:03:44 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63C518D;
        Fri, 19 May 2023 07:03:43 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64d15660784so1481562b3a.0;
        Fri, 19 May 2023 07:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684505023; x=1687097023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=veSeRUByjygam3prdbXNh3NDFxBsJbAjdHCjGVdp/Ps=;
        b=hBs8/D9aMGTO/3J7gWPAq/xzOgKcQFA+p8/zL8Ndlys0Sa9IzdE0cp7uSsSdx2FYXf
         8s3e84pYlkknqD3Nmp9/r7KUYzfamcKSlHbXVx/Px/OT+choLxK0JLSyS7Z9csn/cWO7
         nAKBVNMiWktgZOsNM34BuRkvED1N1mrgkSxMjXoGI9yrkGh8lUl77lu3JZ9fA9p/QOcx
         Pw9H2jzKhvLyhbs1O9wHGEUZEXiQjiUJCpp82tDzuWqSUjhmObwY0P2StNegvHhEOfOc
         oMMRhzGlWH/Qo/EDJtD5VpK1Jg5m+YTc2AAR9PzjnlRvHYTCPGYtAytdAUgc1BI2PXMQ
         r04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684505023; x=1687097023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=veSeRUByjygam3prdbXNh3NDFxBsJbAjdHCjGVdp/Ps=;
        b=WIG/QlXnRfGpuC+Ocu2AUzd756pXiL1oGLJATkbfI2llhskCDmOVfQuFxEJk5BhqGK
         +czBy2JmuuhGzbKTPp9AeI0L0qYUN4eeJX03rxJTSyOng+YMlG1Nw2NvG0yQkTQgcp8V
         Rw/O6XuD6FmH/8Svgyza/tlgYI8+JjFpNjSciZr0ik8Do7GAMJH2htvD+gur2Gni0rS6
         yDe2F1jnyAVYlYyIsnjLWO0g6HymHsV/hKG0VZTVR1s64U+X2P4G/O23KkThTPR5vYrG
         wzKUuAGhiVhC/d+oysBmvaT2yip4PjSgjdmrIXqk4a1MIXjSHLHBAhZb/v/X31yYng8y
         j+9Q==
X-Gm-Message-State: AC+VfDx+QBc0a3DbYB89AxpOskJOdBL7x3/UJZRz3j8dE2BuS5T/Oj6j
        Ng7fTEFQyzE9vx0gMaJM6LGPo16AXIQ=
X-Google-Smtp-Source: ACHHUZ6UpPmjSvf/6vLp8ZFMXnnfY7ykZt+MPPT5GGF0zjYwlh3htii3HC9PEcInzfO/6wXr6AISqg==
X-Received: by 2002:a05:6a21:3986:b0:106:76e8:9414 with SMTP id ad6-20020a056a21398600b0010676e89414mr2274616pzc.40.1684505023163;
        Fri, 19 May 2023 07:03:43 -0700 (PDT)
Received: from [192.168.1.107] ([103.194.71.110])
        by smtp.gmail.com with ESMTPSA id w5-20020a636205000000b00530704f3a53sm3101727pgb.30.2023.05.19.07.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 07:03:42 -0700 (PDT)
Message-ID: <891d7a86-cab3-bbf3-89d3-6e521e5aef04@gmail.com>
Date:   Fri, 19 May 2023 19:33:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] hwmon: (nct6683) Add another customer ID for NCT6687D
 sensor chip on some MSI boards.
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230517042025.16942-1-llyyr.public@gmail.com>
 <f7b24380-cbb1-410b-9507-006c142c41b0@roeck-us.net>
 <bac9f57b-7a4e-40a2-5006-9074109a50d0@gmail.com>
 <ca6da82a-c535-4d31-9657-01c6327c870a@roeck-us.net>
From:   llyyr <llyyr.public@gmail.com>
In-Reply-To: <ca6da82a-c535-4d31-9657-01c6327c870a@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/23 19:21, Guenter Roeck wrote:
> On Fri, May 19, 2023 at 07:16:53PM +0530, llyyr wrote:
>> On 5/19/23 18:23, Guenter Roeck wrote:
>>> On Wed, May 17, 2023 at 09:50:25AM +0530, Gopal Prasad wrote:
>>>> From: llyyr <llyyr.public@gmail.com>
>>>>
>>>
>>> The above is still wrong. Never mind, I fixed that.
>>
>> I wasn't sure about it, but I checked and I'm pretty sure pseudonyms are
>> allowed [1]. Is the problem here that my online handle not have a first name
>> and a last name part?
>>
>> * https://www.kernel.org/doc/html/v6.3/process/submitting-patches.html#developer-s-certificate-of-origin-1-1
>>
> 
> "... using a known identity (sorry, no anonymous contributions.)"
>                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Are you making that up ?
> 
> Guenter

Please see commit d4563201f33a022fc0353033d9dfeb1606a88330 [1] and DCO 
Guidelines [2]

 > And despite the language, we've always accepted nicknames and
that language was never meant to be any kind of exclusionary wording.


 > A real name does not require a legal name, nor a birth name, nor any 
name that appears on an official ID (e.g. a passport). Your real name is 
the name you convey to people in the community for them to use to 
identify you as you. The key concern is that your identification is 
sufficient enough to contact you if an issue were to arise in the future 
about your contribution.

* 
https://github.com/torvalds/linux/commit/d4563201f33a022fc0353033d9dfeb1606a88330
* https://github.com/cncf/foundation/blob/main/dco-guidelines.md
