Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDAB73A3D4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjFVO5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjFVO5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:57:39 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE651710;
        Thu, 22 Jun 2023 07:57:37 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-668723729c5so3476198b3a.3;
        Thu, 22 Jun 2023 07:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687445857; x=1690037857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jwOACF4Cm96Y53XmCdPinKvkgKtl8JixiB5Ndw9ya3w=;
        b=ZLZv2qKKiBUJM4zOad+ld+YEywuAgqTfAe8D9uG2834frWERYt7dOAf1vfSpVmN5YZ
         yOxEcEncjDN7kOhTlOFDLwVXHHNx1R3s7A4A7WvW9KH55wLrpgFfYbKyLuxNpba3VEDy
         /GSflkQH4SMop1Pu8qE/gxyKtXCxcgJaR7oq5heJaeZsg3oPIoXwikzS+WpKl3KqWPwt
         01ynR7Rhpzgw9X6SBU6pTsD9kQIZ1LwKAa0A0yL6oB63PRLXJaYv9ZlqWe3CdGpN/BYl
         lfzDoc7rUiaSfRMkrmuzviGuWf1YmCafY+a8lj5LEKWwgL8eh8xDsMZcS1yEx/O0JGMy
         BCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687445857; x=1690037857;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jwOACF4Cm96Y53XmCdPinKvkgKtl8JixiB5Ndw9ya3w=;
        b=FC2nFRgAxebRf25Rnsf+zQfRSs0sTjivV04xjvSDUkF5hPydMTLkpgwsa/hXv2JflP
         Kc2UeP4uFMJsWegnmpzgueaDIcEGGx0ISCD1kcYGqowF9tvX2RrrW3ZEiiHR8Rc8GxpT
         cSDHAzyQgjrEPIR1kXMuQ/AQmmGj69Jf0qQBWIkiF56+yOpwCpv/BLHXYy9SIAgy6m7n
         1tpLIz5aAEXhYmUQL5vNqgXOe1Jz8hZWvEHf5AZNejsG5o2h18SkmAbpnAmOjPDLkXGD
         p241NKoM85NBKqgzZYxQK0ThJlouQi/a+Z/Bppi9lO+Ut3UzVIVK/W5YT1xkYWRxZNmn
         K7qg==
X-Gm-Message-State: AC+VfDwouZh5nvClHE0E9aUUdli12Dt9svDGX4OIKj9hueLNR/su61PW
        ML46VNJfxWw4K6dJL7mokvs=
X-Google-Smtp-Source: ACHHUZ7SykTFwUl4Pg0cnKe++eFMAAWwdMSv8sx+ts0vphadPA7YhT4gBMX8VVlYqUagi9Fq98njJQ==
X-Received: by 2002:a05:6a21:339b:b0:122:1fc:38b8 with SMTP id yy27-20020a056a21339b00b0012201fc38b8mr10410540pzb.48.1687445857125;
        Thu, 22 Jun 2023 07:57:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902b58900b0019719f752c5sm5510512pls.59.2023.06.22.07.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 07:57:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <dd9dc41b-0830-0403-6abd-41d7aa664be3@roeck-us.net>
Date:   Thu, 22 Jun 2023 07:57:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 14/24] init: clear root_wait on all invalid root= strings
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
References: <20230523074535.249802-1-hch@lst.de>
 <20230523074535.249802-15-hch@lst.de>
 <8c1992bc-110a-4dad-8643-766c14bf6fd4@roeck-us.net>
 <20230622035149.GA4667@lst.de>
 <2205ef1e-9bb6-fb1e-9ca3-367c1afe12ac@roeck-us.net>
 <20230622060001.GA8351@lst.de>
 <8e6c8365-5c2b-2bad-bf3c-df2d65cc8afa@roeck-us.net>
 <20230622144042.GA21415@lst.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230622144042.GA21415@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/23 07:40, Christoph Hellwig wrote:
> On Thu, Jun 22, 2023 at 06:54:41AM -0700, Guenter Roeck wrote:
>> On 6/21/23 23:00, Christoph Hellwig wrote:
>>> Hi Guenter,
>>>
>>> can you try this patch?
>>>
>>> diff --git a/block/early-lookup.c b/block/early-lookup.c
>>> index a5be3c68ed079c..66e4514d671179 100644
>>> --- a/block/early-lookup.c
>>> +++ b/block/early-lookup.c
>>> @@ -174,7 +174,7 @@ static int __init devt_from_devname(const char *name, dev_t *devt)
>>>    	while (p > s && isdigit(p[-1]))
>>>    		p--;
>>>    	if (p == s || !*p || *p == '0')
>>> -		return -EINVAL;
>>> +		return -ENODEV;
>>>      	/* try disk name without <part number> */
>>>    	part = simple_strtoul(p, NULL, 10);
>>
>> Not completely. Tests with root=/dev/sda still fail.
>>
>> "name" passed to devt_from_devname() is "sda".
>>
>>         for (p = s; *p; p++) {
>>                  if (*p == '/')
>>                          *p = '!';
>>          }
>>
>> advances 'p' to the end of the string.
>>
>>          while (p > s && isdigit(p[-1]))
>> 		p--;
>>
>> moves it back to point to the first digit (if there is one).
>>
>>          if (p == s || !*p || *p == '0')
>> 		return -EINVAL;
>>
>> then fails because *p is 0. In other words, the function only accepts
>> drive names with digits at the end (and the first digit must not be '0').
>>
>> I don't recall how I hit the other condition earlier. I have various
>> "/dev/mmcblkX" in my tests, where X can be any number including 0.
>> Maybe those fail randomly as well.
>>
>> Overall I am not sure though what an "invalid" devicename is supposed
>> to be in this context. I have "sda", "sr0", "vda", "mtdblkX",
>> "nvme0n1", "mmcblkX", and "hda". Why would any of those not be eligible
>> for "rootwait" ?
>>
>> In practice, everything not ending with a digit, or ending with
>> '0', fails the first test. Everything ending with a digit > 0
>> fails the second test. But "humptydump3p4" passes all those tests.
> 
> 
> Yeah.  I guess I should give up on the idea of error out in this
> particular parser.  The idea sounded good, but I guess it doesn't
> work.  So we'll probably want his fix:
> 

Yes, that fixes the problem for me.

Guenter

> 
> diff --git a/block/early-lookup.c b/block/early-lookup.c
> index a5be3c68ed079c..9e2d5a19de1b3b 100644
> --- a/block/early-lookup.c
> +++ b/block/early-lookup.c
> @@ -174,7 +174,7 @@ static int __init devt_from_devname(const char *name, dev_t *devt)
>   	while (p > s && isdigit(p[-1]))
>   		p--;
>   	if (p == s || !*p || *p == '0')
> -		return -EINVAL;
> +		return -ENODEV;
>   
>   	/* try disk name without <part number> */
>   	part = simple_strtoul(p, NULL, 10);
> @@ -185,7 +185,7 @@ static int __init devt_from_devname(const char *name, dev_t *devt)
>   
>   	/* try disk name without p<part number> */
>   	if (p < s + 2 || !isdigit(p[-2]) || p[-1] != 'p')
> -		return -EINVAL;
> +		return -ENODEV;
>   	p[-1] = '\0';
>   	*devt = blk_lookup_devt(s, part);
>   	if (*devt)

