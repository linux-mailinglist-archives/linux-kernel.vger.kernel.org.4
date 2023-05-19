Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E2F7098C5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 15:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjESNxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 09:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjESNxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 09:53:50 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B49107;
        Fri, 19 May 2023 06:53:49 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64cfb8d33a5so2344514b3a.2;
        Fri, 19 May 2023 06:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684504428; x=1687096428;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ykIiuQEtuMiJtv1LfFdK5FNLzye5kr215kVGeT2aTpA=;
        b=ayMlXNjd8y1Wft8ZYRp5t0aDsPFv2fsFpGUl6LHTw6RWxZjAOeCs9dahsSjVseK/0W
         B8r2y4Td4EdXVPiVEi4Zc59JKB7NaWNCvI9j4OVNNPhaH9B7/1ZuT8QzpynLWUQiB7hh
         QiymsHncaD2oNPf/l0BmeA4e1AoaBcSyLs4yiADsDf8ONmdhmTVJZwrqPdQjAn5o7l6O
         z/WkoBNdNBEEpriNqnIS3E7SQsVwOrNQvJe7GeCrkuAs0lOvj5TYrkPWW+7W1tIA1Ha/
         RzCv65te2zyrY6grTbw3Qbo6n65vK9HV73rz5jK3juBsP7PufXohzbOivNt5HePxEZW5
         vY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684504428; x=1687096428;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ykIiuQEtuMiJtv1LfFdK5FNLzye5kr215kVGeT2aTpA=;
        b=ZW/nwTzTppWXxV06b5h1E+Qq7TCX1N9a39TwB26V4GvnfE4TczcKwEUOlp0XUb9QOj
         ofmVPgH0yN3HKGooRnfMciu/TCSp4ebYnxyruCgmdFU3R8+9P2wik3066AuAoZGufS1w
         gzh5LgPSYls86ztPGWTOknKWJLje+idWFII4hFLR94uu482WgngOHaHoI5N7fjLn5+uc
         Om5yaHfYvOfbn3NhxpnQfh4XxjMMDDqnORH2WfYtaQ5F0HjsGHbJVaDIqQFZma+x9+3f
         jWvSWoAumBZPSAlwFGHOeuv6bNkQpV9m/m2Hu4lmiwR85DdJJm0TBQsQa0/jewuud6tB
         jLhg==
X-Gm-Message-State: AC+VfDxpZ9ZdtDMW0NrUrlFAR0B58QLCm+3w6z+MPrc3jc0xn144LTK4
        tYj/TAX8o6IFDrRAxL+8RulRQq/+Ke0=
X-Google-Smtp-Source: ACHHUZ4NPFjRGpOA/HeaUHlNCEX5SrZuHUMExa9YiSu+tL5vzu1Fl/F10/tEccyX4JNPw44Ym061cA==
X-Received: by 2002:a05:6a00:c91:b0:63d:2d7d:b6f2 with SMTP id a17-20020a056a000c9100b0063d2d7db6f2mr3637414pfv.4.1684504428363;
        Fri, 19 May 2023 06:53:48 -0700 (PDT)
Received: from [192.168.1.107] ([103.194.71.110])
        by smtp.gmail.com with ESMTPSA id l1-20020a62be01000000b006466f0be263sm3033217pff.73.2023.05.19.06.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 06:53:47 -0700 (PDT)
Message-ID: <f4a097ec-aaa3-9f4f-287e-deac830fed80@gmail.com>
Date:   Fri, 19 May 2023 19:23:43 +0530
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

An online handle is not an anonymous contribution. Pseudonyms were 
explicitly mentioned in a previous version but removed later [1].

Besides, there are plenty of linux contributors commiting under 
pseudonyms like Asahi Lina.

* 
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#developer-s-certificate-of-origin-1-1
