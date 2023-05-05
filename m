Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505506F8A8B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjEEVKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjEEVKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:10:47 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E4B46B7;
        Fri,  5 May 2023 14:10:46 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1aae46e62e9so16307755ad.2;
        Fri, 05 May 2023 14:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683321046; x=1685913046;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1O4ehL8q5WLT4Vb1zmuSl4VayRAoKz0ZG16LrnSfK38=;
        b=mL5hsJhoMIgu5mAlVXKvauZ43GC1BEszjaEeW4FycRb3baLa36CyTQr8aCm2DYk8wj
         YRozDomwzsjy+cklvqELretqBuLCWTNLYFbQkcpBHvJ3MdE49O1NHIQq44bXaVQVjEvq
         8uQ8kEGvGG428+0OHykSv05tBVx2WoPkm11uaa+97SwvPFtRct0CjCia89cf7VYe/myb
         BCj5KbYCwUf0KSRjd7EkYCXHoiq0tYEW/L5VV8DgT/RfXRf+TP+l+KRcTaM/M1MAx2Co
         viRh3oHH2f/dMJNuQvVwIyWAz4mRVpKKqQqTb1fcksseKR22PzhbsAXj/gb/Ni/DdZlE
         DjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683321046; x=1685913046;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1O4ehL8q5WLT4Vb1zmuSl4VayRAoKz0ZG16LrnSfK38=;
        b=MDBPoUJbE+IYg8hPzKEq6VpCPz4ZjlXa6tOGq+qugvPTBnDoalJjOfNW5sc83pjHva
         tQU0tAjPv4fx7dSgy9eDpj0Yz11Qxrc8np7qEdRbm9m3r/RXRbYA0pTda1WJ+U+3cRRD
         4pxNAkH3yV2kZ7ASMyw8k+XZ4iC6Cu5X6+j9QDAMLWGeGd/Z+oqxsUklOr6514kkIfPM
         7NZSJ9PhS2oagniZmYinurNAl6W2IxPeHBOp+tDxV26Nah/LCUwn96blTvygO0kueZHW
         qQaMBcU3eY8uRv++Y7UuUcO/l+y5mJFm2t2TjZOaGcZvo3U/bhQ89/WlO2lm5f4g23Uy
         ovXA==
X-Gm-Message-State: AC+VfDwHq2zZSz8to9RUu2C4pbauzzgaHqh1yIEeg8pqm0LXrvpAuqj1
        rDWFlaVc/slvvhg3lqmO7jk=
X-Google-Smtp-Source: ACHHUZ5+keknf5YE8Hv+dldrz8ag3pM/3xqWNJw5IlKjKhZi3IzdsGxrfjG5rn6RTXCx3z+Coxm7Kg==
X-Received: by 2002:a17:902:e80c:b0:1ab:1dff:9540 with SMTP id u12-20020a170902e80c00b001ab1dff9540mr3662196plg.14.1683321045605;
        Fri, 05 May 2023 14:10:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o5-20020a1709026b0500b001a6cd1e4205sm2191814plk.279.2023.05.05.14.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 14:10:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d672523b-9d91-df76-a275-d7732e10db55@roeck-us.net>
Date:   Fri, 5 May 2023 14:10:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC 08/11] Documentation/hwmon: Revise userspace tools
 documentation
Content-Language: en-US
To:     James Seo <james@equiv.tech>, Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230504075752.1320967-1-james@equiv.tech>
 <20230504075752.1320967-9-james@equiv.tech> <ZFSOIXLCnd01ofBv@debian.me>
 <ZFUcy9SLiE8SwOzR@equiv.tech>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <ZFUcy9SLiE8SwOzR@equiv.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/23 08:12, James Seo wrote:
> On Fri, May 05, 2023 at 12:03:29PM +0700, Bagas Sanjaya wrote:
>> On Thu, May 04, 2023 at 12:57:49AM -0700, James Seo wrote:
>>> +If needed, sources may be found at https://hwmon.wiki.kernel.org/lm_sensors.
>>> +Basic compilation, installation, and uninstallation may be accomplished with
>>> +``make all``, ``make install``, and ``make uninstall``, respectively.
>>> +
>>
>> The sources is on GitHub:
>>

Above page has a "Download" link which points to the github repository.
Personally I think it is better to have a reference to a more generic
location such as to kernel.org in the kenrel and point to the
actual repository (which is more likely to change, after all)
from there.

Guenter

>> ---- >8 ----
>> diff --git a/Documentation/hwmon/userspace-tools.rst b/Documentation/hwmon/userspace-tools.rst
>> index 79c932954e4af5..fd96ea92f72eea 100644
>> --- a/Documentation/hwmon/userspace-tools.rst
>> +++ b/Documentation/hwmon/userspace-tools.rst
>> @@ -44,9 +44,9 @@ Most Linux distributions provide the ``lm-sensors`` suite as a package.
>>   It is recommended that you use this package for ease of installation.
>>   Please consult your Linux distribution's documentation for more information.
>>   
>> -If needed, sources may be found at https://hwmon.wiki.kernel.org/lm_sensors.
>> -Basic compilation, installation, and uninstallation may be accomplished with
>> -``make all``, ``make install``, and ``make uninstall``, respectively.
>> +If the distribution package isn't available, sources can be obtained at
>> +`GitHub <https://github.com/lm-sensors/lm-sensors>`_.
>> +See ``INSTALL`` in the sources for how to build the suite.
>>   
>>   Usage
>>   -----
>>
>> Thanks.
>>
>> -- 
>> An old man doll... just what I always wanted! - Clara
> 
> The document previously mentioned the old official lm-sensors site,
> so I thought I should mention the current one, which has a GitHub link
> anyway. But I will change this and add a link to the current site
> separately.
> 
> Thanks.
> 
> James

