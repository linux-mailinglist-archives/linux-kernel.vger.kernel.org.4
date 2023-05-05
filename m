Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5856F7BE5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 06:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjEEEcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 00:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEEEcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 00:32:32 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311AE7A99;
        Thu,  4 May 2023 21:32:31 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6434e263962so1073457b3a.2;
        Thu, 04 May 2023 21:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683261150; x=1685853150;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=KNVDhl6t1BrQV4FKZzt8ocPzfmjVVSGt2sBw+NlEOCA=;
        b=fO5qpouHNYOyZKfc1oheoEuLE5dOZ1K2WlgnhzbXWemliOeHab7iL/d5xiLxQjtBy5
         6FMOHAaflBDm4RKLu1HWQYKg33QT/+ZJeDO0eGKq0CwVmEQtEBYxO6FnmLgRQ3vtjTqX
         KKXrNld20KflZ67g0rNU+6FwhtegaPUyjlH0aHTbjezjWTlpM55muud57U0GbZWGHY9y
         DTTr8JGDfp3T/kN5MA4kA6qPNDMoJQitebvg/UAaU27m0SyvjWFCN/nGT3VAhw6Yr1mi
         l06fbzQHqyHsEUb+3Ntn1LQAzhW1hfyJaNcj5SOYkvtbrBcCRExNt8ieeWASmPxJaJ6o
         2eyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683261150; x=1685853150;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KNVDhl6t1BrQV4FKZzt8ocPzfmjVVSGt2sBw+NlEOCA=;
        b=KKdBAFgahNS3hI1UBd7dYTI/r/NJzLbGz/d47WEnmkOsBfj6W24LUYWt8tZ2YUbg8Y
         IQh9KQIdEXA4v9opUIhbUt36NxUSQfjxL90Dz8NdRBn0Us2wY5S8lvbRrQsbN7kJJHp4
         ehJ4WeNMSZ4uiLn7iiqF7nmClnxgnBA/xEozwJDFKZAeosWGpkLbJk7Pd4ZXHZVohZ2s
         rceYA4WyM2e53dHNQsXuXqod19D9QTzUPdO+5ElMQMagTSuLvV+8bEoojtuvP785JXto
         y5tyCDjRyIoAdK2BfEU1SIOudp2/zNyuYRFv8xbovkHxLNZh+S5MY4mcIMI3td6wWNW5
         WrsA==
X-Gm-Message-State: AC+VfDx5PNrTyxtrQ9MtneK3yGvmebikNhQCcxfln4eIY5BG5clp1bma
        M7212FFglr+GV734n1nfPM0=
X-Google-Smtp-Source: ACHHUZ7A8NjhLQvJosr9+utHiv4cBG+Hpp+o6PLUOqG95ou3UKqJMQqAnWJS7TKOzAiSJBW9/nghxQ==
X-Received: by 2002:a05:6a00:2e8f:b0:63d:2343:f9b with SMTP id fd15-20020a056a002e8f00b0063d23430f9bmr684519pfb.19.1683261150486;
        Thu, 04 May 2023 21:32:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m3-20020aa79003000000b0063d2d9990ecsm576587pfo.87.2023.05.04.21.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 21:32:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <49ea68fd-6468-c61a-fb7a-6ef2f0497542@roeck-us.net>
Date:   Thu, 4 May 2023 21:32:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC 05/11] Documentation/hwmon: Revise PMBus core documentation
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, James Seo <james@equiv.tech>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230504075752.1320967-1-james@equiv.tech>
 <20230504075752.1320967-6-james@equiv.tech> <ZFSFzaWZsS9qxmzz@debian.me>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <ZFSFzaWZsS9qxmzz@debian.me>
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

On 5/4/23 21:27, Bagas Sanjaya wrote:
> On Thu, May 04, 2023 at 12:57:46AM -0700, James Seo wrote:
>> -[from pmbus.org] The Power Management Bus (PMBus) is an open standard
>> -power-management protocol with a fully defined command language that facilitates
>> -communication with power converters and other devices in a power system. The
>> -protocol is implemented over the industry-standard SMBus serial interface and
>> -enables programming, control, and real-time monitoring of compliant power
>> -conversion products. This flexible and highly versatile standard allows for
>> -communication between devices based on both analog and digital technologies, and
>> -provides true interoperability which will reduce design complexity and shorten
>> -time to market for power system designers. Pioneered by leading power supply and
>> -semiconductor companies, this open power system standard is maintained and
>> -promoted by the PMBus Implementers Forum (PMBus-IF), comprising 30+ adopters
>> -with the objective to provide support to, and facilitate adoption among, users.
>> +  The Power Management Bus (PMBus) is an open standard power-management protocol
>> +  with a fully defined command language that facilitates communication with
>> +  power converters and other devices in a power system. The protocol is
>> +  implemented over the industry-standard SMBus serial interface and enables
>> +  programming, control, and real-time monitoring of compliant power conversion
>> +  products. This flexible and highly versatile standard allows for communication
>> +  between devices based on both analog and digital technologies, and provides
>> +  true interoperability which will reduce design complexity and shorten time to
>> +  market for power system designers. Pioneered by leading power supply and
>> +  semiconductor companies, this open power system standard is maintained and
>> +  promoted by the PMBus Implementers Forum (PMBus-IF), comprising 30+ adopters
>> +  with the objective to provide support to, and facilitate adoption among,
>> +  users.
>> +
>> +    (from pmbus.org)
> 
> Seems like a candidate for attribution:
> 

Yes, and I do not feel comfortable removing it.

Guenter

> ---- >8 ----
> diff --git a/Documentation/hwmon/pmbus-core.rst b/Documentation/hwmon/pmbus-core.rst
> index 2f88a03446d2be..75404f088fd777 100644
> --- a/Documentation/hwmon/pmbus-core.rst
> +++ b/Documentation/hwmon/pmbus-core.rst
> @@ -21,7 +21,7 @@ Introduction
>     with the objective to provide support to, and facilitate adoption among,
>     users.
>   
> -    (from pmbus.org)
> +  -- (from pmbus.org)
>   
>   Unfortunately, while PMBus commands are standardized, there are no mandatory
>   commands, and manufacturers can add as many non-standard commands as they like.
> 
> Otherwise the formatting LGTM, thanks!
> 
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> 

