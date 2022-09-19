Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B975BCBCD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiISM3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiISM3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:29:06 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45E515FF4;
        Mon, 19 Sep 2022 05:29:05 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id q62-20020a17090a17c400b00202a3497516so5920157pja.1;
        Mon, 19 Sep 2022 05:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=5lZfP2/VsvN9MXnxi1e3GKXZZbt08KE6itWQYdXqrnk=;
        b=XblivpqPz0a2yhRuPxuyfov0aIp0Lk1wVfd/BrS24xfa453oFJiBgWt6xroc69xYu7
         YpTsOF46ocPMEXFNjC9bsVMfVHxVmhmFw5NvSSEKM2ald7iRerC4PVbmptWFxPTNnGkP
         rseWIBPX2hRfDLygXeRIQCfDRBRdcA1m+S8GEPjBCBYd0izUDBdtxsLqJLXSuhk+F/VE
         XmvU1hl9v5whoyks2pRv5ovq4jTclziFa5aRueB/x2DJktCpYM1SBT9fpfKoLao0RR/O
         MYqFlqGzCWyYrChE6elNcDGyODPCSykHmhyeVkokwnnXrQc0XFyH8AIb0kzHYfXDRFMI
         NOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=5lZfP2/VsvN9MXnxi1e3GKXZZbt08KE6itWQYdXqrnk=;
        b=nn67Q1yF3bgjRh1zg8bbYE/0uAx9mdm7mufl/4mys/RNR1dRWVw7waj/1cEijvWUUs
         A0tvWrksPKPY7rnlJZz3/1bzyaM5csvqm8sJqma8WhPhmU7W/4vINwPNbOvQ5NPnRdVh
         H2kMdqw6s83qr5YHKM7D3IiZASBkPIKEB0t1VRC9whicNuSkcP6Pah0PLsZqiiYLrDJU
         qqNmjQQoentJ0knmVwFYyvK2YjDSMyn3wvz+JpWelshDcxQzKs4uV8wNrZm7Kpm6ZrbV
         8eHgAP7wMLrOjXawGfk+kX0PRThZsABTUCGxzJlOc4IhV4zX6Y1e93RXk98I21LgV2U9
         jXcg==
X-Gm-Message-State: ACrzQf0acHfthWv9nztMHRFsWhLJMV8fZOcMXwB0YsNtlxJvg+IR2uJc
        7l+Kf/rmIPavKFFSCTpYox9605+zuyX7WA==
X-Google-Smtp-Source: AMsMyM5iPb0PtbrYCNaGx7HiXijbZT3wK+boyV5lviw+qWu8YtxsYrrymsXDqqB1uzYvPknSkmWwzg==
X-Received: by 2002:a17:90a:1786:b0:202:856e:29bf with SMTP id q6-20020a17090a178600b00202856e29bfmr19357014pja.134.1663590545099;
        Mon, 19 Sep 2022 05:29:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s2-20020a170902ea0200b001753cb9893csm20045307plg.187.2022.09.19.05.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 05:29:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <736d150c-03fe-ce39-a42e-b9b62f40a937@roeck-us.net>
Date:   Mon, 19 Sep 2022 05:29:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] watchdog: sp5100_tco: Add "action" module parameter
Content-Language: en-US
To:     Vladimir Panteleev <git@vladimir.panteleev.md>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220918140829.443722-1-git@vladimir.panteleev.md>
 <aabb7c21-9a80-696e-6a38-29de57e025ba@roeck-us.net>
 <CAHhfkvw_U_uF1UFcLTBUsw=_YoM_7pi3tw3KCovTT6PZTnH0ig@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAHhfkvw_U_uF1UFcLTBUsw=_YoM_7pi3tw3KCovTT6PZTnH0ig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/22 22:58, Vladimir Panteleev wrote:
> On Mon, 19 Sept 2022 at 04:17, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 9/18/22 07:08, Vladimir Panteleev wrote:
>>> +MODULE_PARM_DESC(action, "Action taken when watchdog expires, 0 to reset, 1 to poweroff (default="
>>> +              __MODULE_STRING(WATCHDOG_ACTION) ")");
>>> +
>>
>> Other module parameters are not visible. I do not see the benefit of
>> having this one visible.
> 
> My bad
> 
>>> -#define SP5100_WDT_ACTION_RESET              BIT(2)
>>> +#define SP5100_WDT_ACTION            BIT(2)
>>
>> I do not see the point of renaming this define.
> 
> The bit is just called "action" ("WatchDogAction") in the technical
> documentation. I figure that the original author chose to name the
> define "ACTION_RESET" instead of just "ACTION" because the original
> implementation only ever cleared this bit, therefore only setting the
> action to "reset". Now that this is no longer true, calling it simply
> "action" to match the spec seemed more appropriate. What do you think?
> 

I am not getting into define name editing wars. The define is named as
it is. There is never a good reason to rename it. If I'd accept your
change, someone else might come tomorrow and want it renamed to
"SP5100_WDT_ACTION_POWEROFF" because setting the bit to 1 causes
the system to power off.

No, I am not getting into that.

Guenter
