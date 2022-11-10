Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8B3623C76
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbiKJHPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiKJHMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:12:53 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F0131EF3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 23:12:47 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id k8so950816wrh.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 23:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JZHBIAsduIpLZAGr957MixGoNnkjIIF3w+4h6AJbGtg=;
        b=uronP4ZRqhYXYsRo6aUos+70AxdqTrzphzLe3xHiGZ9cVcvroNyDdeUDYy8fO7cJTX
         /C4GCST9lJDlea09kVl/gBH8Vybcip1ugS6RdAKj/R7kee2FJvqRdM25UE+p8v/F2hc5
         NIsFlmtkj1w4Y7eQilGrslxCwkP7f/CbHcKYi1LzEFARhpF0PORaoQbro8xJJ+2YFXis
         E5alciTtUse37488fd+M9q7TRUvzcuTPmIsucmYhb3dj86TwEATCZGCIkFGiimHcgO+X
         yPwHIbZ1fWq1h0mfBy9nwHr6JCl80Xu2ivqmOb8tYMbMumD95YRFrKav+WxZPM9oZld5
         PQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JZHBIAsduIpLZAGr957MixGoNnkjIIF3w+4h6AJbGtg=;
        b=UGqIu6Nlu8Q6KZQ2fZcTZILUsU6k0clgZa6Prx1OMW0J7ERGZ2xuZv1sLsszSd6jD9
         /ZUf63pMQwoDrqXpTztPrTLXRV4X36MIealikRnBQ6NIR1mH2qXP3hhl+Gw0vfkaoWkJ
         M2W5iftO+0aieMLr8XSNcgNKwQ1eHjr/c5OTVWVciAt5704EEJPsuKfcd/8Fg0soRYY8
         tH2CwgvmY5H8P5vyAoOKfq0kHTngUolyFPMgFqv82dU2rzfl3JcHaw21MKkyVtKkBQIJ
         845sD3Yy71dZHvuGmx+blI5wj9wr4u3CXB2tyC1Jbt++htGcE5X2EXwJbiFonTSDnQtH
         CQJA==
X-Gm-Message-State: ACrzQf2CH9BFNB/1hAlkm7OioeEH0DtsHkKso8J1UoTcdadnvsdJRgCF
        etI1os0pEfTe0l/wwnlkdlFA7w==
X-Google-Smtp-Source: AMsMyM61VRTRaEX3VIu4ke6jRK4GkClgTxznoQx/Os1ZBw3Wbtkf7K1hL6m+rFXCxUEKiMM4k9xewg==
X-Received: by 2002:adf:f04e:0:b0:236:5d8d:8a1e with SMTP id t14-20020adff04e000000b002365d8d8a1emr40711618wro.392.1668064366300;
        Wed, 09 Nov 2022 23:12:46 -0800 (PST)
Received: from [10.101.1.4] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id iw2-20020a05600c54c200b003cf77e6091bsm3901962wmb.11.2022.11.09.23.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 23:12:45 -0800 (PST)
Message-ID: <1267bf43-618c-7347-be3a-2792c656d9b6@baylibre.com>
Date:   Thu, 10 Nov 2022 08:12:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v6 4/6] mfd: tps65219: Add driver for TI TPS65219 PMIC
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Nishanth Menon <nm@ti.com>
Cc:     Lee Jones <lee@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, kristo@kernel.org,
        dmitry.torokhov@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, tony@atomide.com,
        vigneshr@ti.com, bjorn.andersson@linaro.org, shawnguo@kernel.org,
        geert+renesas@glider.be, dmitry.baryshkov@linaro.org,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, arnd@arndb.de, jeff@labundy.com,
        narmstrong@baylibre.com, msp@baylibre.com, j-keerthy@ti.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org
References: <20221011140549.16761-1-jneanne@baylibre.com>
 <20221011140549.16761-5-jneanne@baylibre.com> <Y1+q2Usm9ecicXqp@google.com>
 <1383fd22-c720-811e-a2bb-be2151675089@baylibre.com>
 <20221105000104.rtj3r6ufqwqmepon@keenly> <7heduewjp0.fsf@baylibre.com>
 <5418ac3b-04d7-5e77-7612-c8f168e24621@ti.com>
From:   jerome Neanne <jneanne@baylibre.com>
In-Reply-To: <5418ac3b-04d7-5e77-7612-c8f168e24621@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/11/2022 22:59, Andrew Davis wrote:
> On 11/7/22 3:14 PM, Kevin Hilman wrote:
>> Nishanth Menon <nm@ti.com> writes:
>>
>>> On 13:58-20221104, jerome Neanne wrote:
>>>>
>>> [...]
>>>
>>>>
>>>>>
>>>>> Can you try an compile with W=1 please.
>>>> This raise one warning on mfd:
>>>> drivers/mfd/tps65219.c:28:12: warning: ‘tps65219_soft_shutdown’ 
>>>> defined but
>>>> not used [-Wunused-function]
>>>>     28 | static int tps65219_soft_shutdown(struct tps65219 *tps)
>>>>        |            ^~~~~~~~~~~~~~~~~~~~~~
>>>> soft_shutdown has been validated and is used in TI baseline even if not
>>>> hooked in upstream version further to this review:
>>>> https://lore.kernel.org/lkml/20220825150224.826258-5-msp@baylibre.com/
>>>>
>>>> It was a TI requirement to implement it...
>>>> Let me know if you want me to remove this function or if we can keep 
>>>> it like
>>>> this.
>>>
>>> There are platforms without psci, correct? I think the comment was to
>>> drop the force override with system-power-controller property,
>>>
>>> if (!pm_power_off) {
>>>     tps65219_i2c_client = client;
>>>     pm_power_off = &tps65219_pm_power_off;
>>> }
>>>
>>> Could still be valid for such platforms, no? I do see that the
>>> capability that the PMIC has - which is software shutdown is a valid
>>> feature that we support in many different PMIC drivers. Is'nt the job of
>>> the driver to introduce the functionality in a manner that is
>>> appropriate to the OS framework?
>>
>> Yeah, I think Nishanth is right here.
>>
>> We should probably keep the `if (!pm_power_off)` part so the PMIC will
>> be used if PSCI is not, but it also allows an easy way to test/use the 
>> PMIC
>> shutdown functionality downstream if needed.
>>
> 
> Then should be using the sys-off handler API[0] so it doesn't block PSCI
> which is also switching over[1].
> 
> Andrew
> 
> [0] https://lwn.net/Articles/894511/
> [1] https://www.spinics.net/lists/arm-kernel/msg1024127.html
Can we go for upstream with v7 without tps65219_soft_shutdown. Then if 
everyone agrees with Andrew proposal, I'll submit a separate patch which 
adds implementation of tps65219_soft_shutdown support through sys-off 
handler.

So that we are not blocking upstream in case further 
discussions/alignment are required.

Jerome
