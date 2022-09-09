Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39D65B3B68
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiIIPE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiIIPEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:04:21 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7881B13A079;
        Fri,  9 Sep 2022 08:04:20 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m3so1791985pjo.1;
        Fri, 09 Sep 2022 08:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=hL2cx70YG7RrNd5UJ8t17Ow01zpeAQX1aXJ6HHL43VU=;
        b=MVTXFFiN01myXOcvZRWQOavuunxR1LDgIMoIoTgtq8MhcbPSmRb1WnVe/JoFoOPszO
         +fwLp3vbRKlWd4Fp6I5V/5pF9OAQ5GFVQh90xkwumUkcXLg1S5hwZr89Z8jEf6E0AaH3
         /73V+AK6AcIcR2cgRWXKiIHvogWet4PRgWC5HuI/4d5eyaJX75Svp2F0CZEQLnhK6bHr
         J4Z1mHRnRfSAc20wOtSdjwGCrNtbn/+MqqS+RqZR0us9YAaeMiHWliAGkvI6Rtk3mkYd
         p/RzPRYprscRh5XtN5Ys2Egx49GuTS62ApxWBWXoAzgWC0tDc0JdrgndedtYHiajB3Op
         nfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=hL2cx70YG7RrNd5UJ8t17Ow01zpeAQX1aXJ6HHL43VU=;
        b=Rj4TdniAO5igEvzal3c6n6cQl2fdOMMCLZ5dEHYWCsBI0xogkRwDNJsEyT/CVrgHt0
         +gTNlUgkVgvuOiifJ8uq17gG9LKhfTDroITETYJ8azKo5G1DOLGNlydcermj4D94o2D/
         NCgnsnOEjFkgCla1frxSfnH5NSIX0eDO4tYcUjC+HaPv/bgndHAv0KOryfp4CdF2WHJS
         8PrirB2sWY1GLmy/Ie+3jCiBmNtXgjTxBGCDz71ZUyuLRPnAXz0b0yocgyyyIn+gD7Wg
         5eNmny7q1bvP9Eg1PqPyC5RfupHiPaC1vGkp7KPB1rMbSSUnjR/IhDNp8/zzro1ZLVSi
         aZLA==
X-Gm-Message-State: ACgBeo2BxSPE14JCKWOjyqNH+iwXJkEe0j6X3jZm8cUligsYDyyNvL5R
        tpMW2L/t/R8kEJyb6G2LPAg=
X-Google-Smtp-Source: AA6agR50U/n1AVhoAp7HplEc5VUgXT2sSAw3o2gbK2pzDWAaC/1vFPh0ZEqNEeMbzvp1JarBYH7Fgg==
X-Received: by 2002:a17:90a:e60d:b0:201:6b28:5406 with SMTP id j13-20020a17090ae60d00b002016b285406mr9917776pjy.228.1662735859939;
        Fri, 09 Sep 2022 08:04:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902ec8800b00172dd10f64fsm553052plg.263.2022.09.09.08.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 08:04:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ba55b70f-b1b1-c31a-e1ef-a079f0f02782@roeck-us.net>
Date:   Fri, 9 Sep 2022 08:04:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 3/4] dt-bindings: hwmon: Add bindings for max31760
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220909133718.388213-1-Ibrahim.Tilki@analog.com>
 <20220909133718.388213-4-Ibrahim.Tilki@analog.com>
 <9d5e8a41-8e0a-c67a-1b68-f743b4680510@linaro.org>
 <339d3857-2deb-b5d9-332d-cc65cc90ca19@roeck-us.net>
 <96766080-dee3-1c06-031e-331a8702cf37@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <96766080-dee3-1c06-031e-331a8702cf37@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/22 07:56, Krzysztof Kozlowski wrote:
> On 09/09/2022 16:52, Guenter Roeck wrote:
>> Hi Krzysztof,
>>
>> On 9/9/22 07:49, Krzysztof Kozlowski wrote:
>>> On 09/09/2022 15:37, Ibrahim Tilki wrote:
>>>> Adding bindings for Analog Devices MAX31760 Fan-Speed Controller
>>>>
>>>> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
>>>> ---
>>>
>>>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> Please wait with applying for Rob's bot to check it.
>>>
>>
>> I don't think I see those results unless there is a failure.
> 
> That's correct.
> 
>> Is there a link where I can look up the results ?
> 
> It will pop-up on Patchwork:
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20220909133718.388213-4-Ibrahim.Tilki@analog.com/
> 
> Like for example here:
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20220908184925.2714098-3-sireeshkodali1@gmail.com/
> 
Thanks!

Guenter

