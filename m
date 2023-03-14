Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720906B9BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjCNQnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjCNQm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:42:59 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50F61DBB2;
        Tue, 14 Mar 2023 09:42:52 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id j6so4476624ilr.7;
        Tue, 14 Mar 2023 09:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678812172;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=MxZSOfCWNDNJ14hSL1j3SL4LQ1yTeUuMdTOGWrYjnBw=;
        b=oGkcRGoYBzfKZcwb0CVNjcvFi+97rNw0dYByC6MEe92ueoVHNJVbWoq65crX9LN+jE
         XNVVvhDGpedmefPOAsK85HqaY5an92atQz1ehjYxBCHIBbJY5yMDCx8t/3tRzGNZZ1+o
         g6hnBmuQQDJC5dmO2dfIVStPcuf31jmALPZaRcajXkL+zM9ILAvR5uqLKCFK521PaUzd
         qzPMHDw2/NGXz+SbP0VgN1D7IClXoHJ4MUMBpdi/4CbQ/cfPFAS4mBnPsZ+SQU0oKkKf
         YTgDhYvy/bheEtZFIsGLSP3OF/8PQCkNJwmcnPC9gpTUSeFQYvd2dVHnFgspnUx/QiDW
         igIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678812172;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MxZSOfCWNDNJ14hSL1j3SL4LQ1yTeUuMdTOGWrYjnBw=;
        b=6VVaU/NU9FLIRkD1ixwjhLLtiSqnI6eU6mWhDjWxiZAG17EF8Rje2jz22m/t+IRaHv
         1WSq4qDDKwVRE2kxhBBehEzvIhMLRXyGceAS0fprTFLz2EwGPTWzDNyCYrUWpGqE8bjM
         iC5CJMwPrvGxtY5tpfaB39h3VDqEdJ1wbJ63IDx9Mt2U4tokwDHXQE/bTO5OFmAMjjST
         czzxWpV28O8scR6yRbOSiImqOO2DS4lUcbWb/oF7X1goGje98qRObHuKBpukYfjXn71r
         GMT9u4cY3YkcpwxYbnLHwMddXEVym5bWnIUybWZm25V9ErdaA5xPFtsuNX9wMTYkUwSF
         xdKg==
X-Gm-Message-State: AO0yUKXU20K1GXwhRgXQk3oN3lJkvFaWJHOPOOiGcLfVm/Rgcs6N9+AX
        LikRmG8g0YlLGO7lSPZ18qo=
X-Google-Smtp-Source: AK7set/ZJ3U6nq5gMwwoKA9g01Yk0CxUBFBCBI6kWXWJBdaRmS9FzI0z0x1YW8Rx1jW6FiXKLYePow==
X-Received: by 2002:a05:6e02:1d87:b0:323:66a:be22 with SMTP id h7-20020a056e021d8700b00323066abe22mr3095106ila.21.1678812172229;
        Tue, 14 Mar 2023 09:42:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p17-20020a056e02105100b0032301b2aa36sm923243ilj.26.2023.03.14.09.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 09:42:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ec4259d3-a7bf-d296-7805-aac3f7480b93@roeck-us.net>
Date:   Tue, 14 Mar 2023 09:42:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] watchdog: ebc-c384_wdt: Migrate to the regmap API
Content-Language: en-US
To:     William Breathitt Gray <william.gray@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Demetrotion <pdemetrotion@winsystems.com>,
        techsupport@winsystems.com
References: <20230314152916.185939-1-william.gray@linaro.org>
 <ZBCX0iVwYD4uVxwM@smile.fi.intel.com> <ZBChWA6aGLPZ/2vG@fedora>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <ZBChWA6aGLPZ/2vG@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/23 09:31, William Breathitt Gray wrote:
> On Tue, Mar 14, 2023 at 05:50:42PM +0200, Andy Shevchenko wrote:
>> On Tue, Mar 14, 2023 at 11:29:16AM -0400, William Breathitt Gray wrote:
>>> The regmap API supports IO port accessors so we can take advantage of
>>> regmap abstractions rather than handling access to the device registers
>>> directly in the driver.
>>
>> ...
>>
>>>   - Utilize watchdog_set_drvdata() and watchdog_get_drvdata()
>>
>> I'm wondering why you can't use dev_get_regmap() instead.
> 
> We can set `wdd->parent = dev` in ebc_c384_wdt_probe(), and then use
> `dev_get_regmap(wdev->parent)` to retrieve the regmap. The only downside
> I see if perhaps the added latency a call to devres_find(), whereas
> using watchdog_get_drvdata() is just a pointer dereference.
> 
> I'm indifferent to either choice, so if Guenter or Wim have a preference
> here I'll follow their decision.
> 

I am not inclined to accept a patch which calls dev_get_regmap() more
than once. It is not just added latency, it is unnecessarily executing
a lot of code. Maybe that call is abused nowadays, and/or maybe people do not
care about wasting CPU cycles anymore, but that is not its intended use case.

>>
>>>   - Map watchdog control registers based on offset 0x1 and adjust regmap
>>>     configurations accordingly; offset 0x0 is unused in this driver so we
>>>     should avoid unnecessary exposure of it
>>
>> I'm wondering what bad could happen if you expose it.
> 
> The WINSYSTEMS EBC-C384 documentation I have does not specify what
> offset 0x0 does (nor offsets 0x3-0x4), so I don't know if there are side
> effects to reading those addresses. Really, I'm just avoiding the hassle
> of writing an explicit precious registers table for those offsets by not
> exposing them at all.
> 

Counter questions:
- What would be the purpose of exposing register addresses if they are not needed ?
- What bad can happen by _not_ exposing those register addresses ?

Guenter

