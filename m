Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F32B699827
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjBPO6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjBPO6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:58:21 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE412886B;
        Thu, 16 Feb 2023 06:57:57 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-16e809949eeso1265270fac.9;
        Thu, 16 Feb 2023 06:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=D0SWa6ZBRkjqa18mu1E+Tl+FPjfljxPZFk68O+yxexw=;
        b=YKdtLtbmUpldrBKWVbzDVnWWch57Y/JXvy6Lup/JK6NA2Em5Zn/21rALTQJBHPgo0/
         fqXLaShcR2amSP2E0uZqZJK4xXFb8LKuu00AohCqC/EAXF8vdLg0CZveDPkjBV5BG2QR
         uF5ZaD7VXVWA9zK3SDGYxvaDBMjQBL+zvO0Oq7X0v+A2bPak2lQCXNJhnpP1kMIQD140
         3xBA0rpJlNbMjCI2Z9mGDTYHvXoHJYTrr4eF9cPe6MenaFR8YUur0fmS6Ropwu7RSCz2
         1XdNo9o4Co19sDT5ZtkvkuOXqfsOrSTGePQTzJRAY7UJjNRHupOr2UpbchivMXw+pOzK
         U09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D0SWa6ZBRkjqa18mu1E+Tl+FPjfljxPZFk68O+yxexw=;
        b=LRpQOnBoOtQ+anN77qoBcbrqd3emRSKwrGeLQJy2pwADXplIfUbZB0tztG2f9G7b1V
         mnYtmMSwGQibgoy2sMKyhpc3QEa7knH4UGfnN3Hth0dRmTWNHm6JgDS4YQrfndC1MDN8
         ntpKqa1HDcBfrlJah8LCHIC+3/75ci8cnv3ttgzDQ+hTf7pT9En0EfVojtZbOhji7+nb
         azHbDmBlp0swL12WxuDQZ70ewIu14JVcqWLBYdbEVZ/tcJm+/YNRdMGfLA2Q74aO9HM1
         oZAAl63SdomjVYW491HCo4pR75NM3UW8YmE4VXDbPhcABaF/v7JPWQ04sxFVs1/8Suo8
         7H2g==
X-Gm-Message-State: AO0yUKXH3AYX3I6dabvXv1K2ZxbuYTi2o/vCs+C0+2GELaD+04kmTeTf
        ckeIHCyJSGrWI6M3Geh0AL4=
X-Google-Smtp-Source: AK7set/qIkXn0ARD0apht7YbDTCtMTsrBPfcN20gMPdgnzo2fkgFPzcCqyvcvGeo6ZL5TGFxx05lxw==
X-Received: by 2002:a05:6870:b6aa:b0:16e:f84:5552 with SMTP id cy42-20020a056870b6aa00b0016e0f845552mr3553893oab.57.1676559475549;
        Thu, 16 Feb 2023 06:57:55 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r6-20020a4ae506000000b005177c244f31sm691325oot.41.2023.02.16.06.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 06:57:54 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <bfc81429-1829-bec1-ac29-0559f6a01215@roeck-us.net>
Date:   Thu, 16 Feb 2023 06:57:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/3] drivers: watchdog: Add StarFive Watchdog driver
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
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
        linux-kernel@vger.kernel.org
References: <20221219094233.179153-1-xingyu.wu@starfivetech.com>
 <20221219094233.179153-3-xingyu.wu@starfivetech.com>
 <20230201224619.GA3194283@roeck-us.net>
 <1f18bfdc-7a04-4914-d970-7ef1d4f99653@starfivetech.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <1f18bfdc-7a04-4914-d970-7ef1d4f99653@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/23 23:11, Xingyu Wu wrote:
> On 2023/2/2 6:46, Guenter Roeck wrote:
>> On Mon, Dec 19, 2022 at 05:42:32PM +0800, Xingyu Wu wrote:
>>> Add watchdog driver for the StarFive JH7110 SoC.
>>>
>>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>>> +
>>> [...]
>>> +
>>> +static const struct watchdog_info starfive_wdt_ident = {
>>> +	.options = OPTIONS,
>>> +	.firmware_version = 0,
>>
>> It is not necessary to initilize a static variable with 0.
>>
>>> +	.identity = "StarFive Watchdog",
>>> +};
> 
> Hi Guenter,
> 
> It would be a compilation error if drop the '0'. I found that other files

No.

> initialize this static variable as well.
> 

Ah, the old "others do it, so do I" argument.
Sorry, that is not a valid argument.

Guenter

