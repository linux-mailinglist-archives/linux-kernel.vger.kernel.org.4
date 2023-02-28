Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67616A5B6B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjB1PLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjB1PK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:10:59 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F349E212A0;
        Tue, 28 Feb 2023 07:10:53 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id u6so6445457ilk.12;
        Tue, 28 Feb 2023 07:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0hFgCVYvdf8qCio/mcfsT/HFMMai5H9F95nC41WxplU=;
        b=dijrorNv9fDP9TTW1Cs81VGsu1XCztj0Z2xPY7I9NWdwoIiqm/LKgimo/i6O2xaMLR
         yzO0K0yqc+hQZL25Vvoly6iZBrakjAHqmGhnXrK+npdDeH0UokiBGgYyi4Yhsedvc8on
         pJ5ZZZhqZH/4JcwVJxjJ4GHUsz0wizN2i9HYjsCLYiGhTgSyaVQ3p3N6M3HPj4DQXi/H
         2BW/swGHEI1Qhpu/AKdH3ur9UBbIvcdkvOShLPwADfDQxDzuFmwGD7KVupZ9IikRl/17
         mXzUpZ+uPVzJYf08j/rWYYyOCtn+QG3AjRVoj0mav667JNh/tAu9VjuxeBovRWgbL7v2
         MLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0hFgCVYvdf8qCio/mcfsT/HFMMai5H9F95nC41WxplU=;
        b=NitGhgVsPRE/j8Mk0ws15T7ceegBvORTxmhx6pze5BgsMPAkN12adinjrnj1x1Acvl
         2TuSJ1aNCj8BVku2m/bPl2sW34sx/nUNPOcpl/2ObUaMuCYuyMkerdbWmYhr0yGTGgjJ
         86VxNL7VjHcBsL8ITVgr3QFSykRB2xDLzsbGPKsw7noTUpTL8BQIxoa/fj4PZ9cPe/O/
         zNAjP8xyu0A7ozM/1P5O82b40otj0kw512RumFmGriBHBmv7RZRbwTIO4Q4S4Z5W7tfL
         nAGJLF95gQns69W2KiO2rHgHFmi5+5qmjSaPE+YbXGnsU+iby3AxSsZsTRkQbzrJ/XfI
         ItVA==
X-Gm-Message-State: AO0yUKVO/ZdyyQ5Xs0SeV9Koj3IdYL3qXt3IRQUMwhJNJZfD1y0U0kpN
        tEfdkxSfS72V3yKuV4fRXF8=
X-Google-Smtp-Source: AK7set/G+92FN/0hLG5LTDqB/5HLO+jsglkAAhxlxzfORyNGXB0Myo5noi0wmboxoHyoUt8qSFqJcg==
X-Received: by 2002:a92:cd89:0:b0:315:34b8:4c6d with SMTP id r9-20020a92cd89000000b0031534b84c6dmr2888115ilb.17.1677597053373;
        Tue, 28 Feb 2023 07:10:53 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b13-20020a05663801ad00b003e9e5e1aacasm2778973jaq.143.2023.02.28.07.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 07:10:52 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d2aada79-61c4-0cc7-7b09-058564ed9fce@roeck-us.net>
Date:   Tue, 28 Feb 2023 07:10:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 2/2] drivers: watchdog: Add StarFive Watchdog driver
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>
References: <20230220081926.267695-1-xingyu.wu@starfivetech.com>
 <20230220081926.267695-3-xingyu.wu@starfivetech.com>
 <CAJM55Z823iqUqD8enM0qJ_MA3Tw94Mn0mq71fbLT1Qjo2s2J3g@mail.gmail.com>
 <0ffb02d2-0bbd-fd0d-b0f6-cb5605570050@starfivetech.com>
 <CAJM55Z_hRpUYueZ-XuWUx1NfAsL9E+-4ry9TYeRWM_bKXvym-g@mail.gmail.com>
 <Y/3coFvMWOLaaY9p@wendy> <545c23f3-1d68-2bff-89d9-584e3ca31044@linaro.org>
 <Y/3hVlp/YPnWHDCX@wendy>
 <f9e380f6-334f-11fa-1118-8d6c3c9befaf@starfivetech.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <f9e380f6-334f-11fa-1118-8d6c3c9befaf@starfivetech.com>
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

On 2/28/23 05:16, Xingyu Wu wrote:
> On 2023/2/28 19:11, Conor Dooley wrote:
>> On Tue, Feb 28, 2023 at 11:57:58AM +0100, Krzysztof Kozlowski wrote:
>>> On 28/02/2023 11:51, Conor Dooley wrote:
>>>> On Tue, Feb 28, 2023 at 11:36:49AM +0100, Emil Renner Berthing wrote:
>>>>> On Tue, 28 Feb 2023 at 10:44, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
>>>>>> On 2023/2/26 22:14, Emil Renner Berthing wrote:
>>>>>>> On Mon, 20 Feb 2023 at 09:21, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
>>>>
>>>>>> So the dt-bingdings need to rename, and which one could be better,
>>>>>> 'starfive,jh71x0-wdt.yaml' or 'starfive,jh-wdt.yaml'?
>>>>>
>>>>> Sure, starfive,jh71x0-wdt.yaml sounds good to me.
>>>>
>>>> I feel like a common comment I see from the dt folks is to not put
>>>> wildcards in filenames & just pick the first compatible.
>>>> I could very well be wrong on that front though...
>>>
>>> First compatible is a bit better, unless you are sure this will cover
>>> all such compatibles now and in the future. For many bindings the
>>> family/wildcards were fine in filename.
>>
>> Ahh cool, good to know what the specific policy is - thanks!
> 
> If this watchdog driver is improved to also support JH7100 in next patch,
> it seems more reasonable to rename the dt-bingdings to 'starfive,jh71x0-wdt.yaml'.


Up to the devicetree maintainers to decide, but I for my part never accept
wildcards in file names. You can not guarantee that all of jh71[0-9]0 will
be supported by this set of bindings. On top of that, when / if you add
support for anything outside that range (say, jh7200 or jh8100 or jh7101
or whatever) you'd have an even worse problem. Are you then going to suggest
renaming the file to jhxxxx-wdt ? Or one digit at a time ?

Guenter

