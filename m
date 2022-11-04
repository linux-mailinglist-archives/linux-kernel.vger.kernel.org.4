Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E2D6198B9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiKDOFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiKDOE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:04:57 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B1F24BE8
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:04:55 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso3234190wmp.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 07:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WrEOdMf1GMkeq1OQaiBOBbaVxySuKCCitXKqPe1eQto=;
        b=KGXICG13fLDFm+7bgCOZWXNar1xBVbaxRtiz6EPXDpBfWd38sj2NDk1kIe0pVd5hIg
         W9ursfTmfTA3AJO093ue/+AukqBaTCMKmURvA5eTz9XrNRPk34tu8mDZupfZY16b9Iwn
         zBKLEtqNLOELjpUcA5xA3h46yGwp8Oo5soQyhyPGEHHYpOQzGHuAbEOlAu66We4zONog
         53o7hruoSqu6fy6QWl+QCJCtVxn60sMc7BrEQd9djr6t/n0tNmgDZlC4Iq21iiLY95Yl
         SK7131s+znheqj3IbPzeyHxZ979BDPZKx0cRLmLSRnRFJoajA4FPebofk21ha2ont9om
         79vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WrEOdMf1GMkeq1OQaiBOBbaVxySuKCCitXKqPe1eQto=;
        b=ALLlHwjF5exx+DmYuUuE73u/QhTBMcyZufvyBvxBllFvgsK9/3DxPauN0cMAHx4923
         h0jeAD/ze7nuChb+G0RGcD6gXjBZxQyMEDdTxScYZOh4n2eJMiEFWcDPlYGbCTJzVfwC
         GRa0GC6W/DcRzZpRcjwVFX0BFK+2gXKzHUZpCRlp464b3tqmKDCc0fXgfYTw0rfQauM+
         fRfzUGy/bnmO2yLEy45zpxjegOnEPBVwUtmZj5cFPpHXTMs8aIElWJkoj277gYPwglFN
         WBdPrgJc6vHFECDBip8+uzwDz+WUuaIL3ah3X1vduGlIFz/vMEyteMAbGxC2CHzugyIl
         CO8g==
X-Gm-Message-State: ACrzQf1WV7fcZy5hbgp9mC/hmo7EbHS9LWsLzFopbHJ9ZJJyzVDiJrjB
        RKzLUWmSVGX7Ehh830KnuTZFgg==
X-Google-Smtp-Source: AMsMyM5/Tel7T8Pg26XJyrSPh1iMst0IIxFHJJStp9WKC67bo+jAc3KoL4hvw99NGNuI6el3zC3Y4Q==
X-Received: by 2002:a05:600c:4587:b0:3c6:f645:dbc2 with SMTP id r7-20020a05600c458700b003c6f645dbc2mr34442198wmo.83.1667570694310;
        Fri, 04 Nov 2022 07:04:54 -0700 (PDT)
Received: from [10.101.1.4] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z18-20020a5d44d2000000b002365254ea42sm3626048wrr.1.2022.11.04.07.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 07:04:53 -0700 (PDT)
Message-ID: <6af9d462-885a-df77-2c83-588363026e7f@baylibre.com>
Date:   Fri, 4 Nov 2022 15:04:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v6 4/6] mfd: tps65219: Add driver for TI TPS65219 PMIC
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org, dmitry.torokhov@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, tony@atomide.com, vigneshr@ti.com,
        bjorn.andersson@linaro.org, shawnguo@kernel.org,
        geert+renesas@glider.be, dmitry.baryshkov@linaro.org,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, arnd@arndb.de, jeff@labundy.com,
        afd@ti.com, khilman@baylibre.com, narmstrong@baylibre.com,
        msp@baylibre.com, j-keerthy@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org
References: <20221011140549.16761-1-jneanne@baylibre.com>
 <20221011140549.16761-5-jneanne@baylibre.com> <Y1+q2Usm9ecicXqp@google.com>
 <1383fd22-c720-811e-a2bb-be2151675089@baylibre.com>
 <Y2UaCq+EL0f2mJ3p@google.com>
From:   jerome Neanne <jneanne@baylibre.com>
In-Reply-To: <Y2UaCq+EL0f2mJ3p@google.com>
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



On 04/11/2022 14:56, Lee Jones wrote:
> On Fri, 04 Nov 2022, jerome Neanne wrote:
> 
>>
>>
>> On 31/10/2022 12:00, Lee Jones wrote:
>>>> diff --git a/include/linux/mfd/tps65219.h b/include/linux/mfd/tps65219.h
>>>> new file mode 100644
>>>> index 000000000000..2c1cf92e92ac
>>>> --- /dev/null
>>>> +++ b/include/linux/mfd/tps65219.h
>>
>>>> +/**
>>>> + * struct tps65219 - tps65219 sub-driver chip access routines
>>>> + *
>>>> + * Device data may be used to access the TPS65219 chip
>>>> + *
>>>> + * @dev MFD device
>>>> + * @regmap Regmap for accessing the device registers
>>>> + * @irq_data Regmap irq data used for the irq chip
>>>> + * @nb notifier block for the restart handler
>>>> + */
>>>
>>> This header needs work.
>> I'm not sure to get your point here. Just something like below to match
>> format or do you expect more:
>>
>> /**
>>   * struct tps65219 - tps65219 sub-driver chip access routines
>>   *
>>   * Device data may be used to access the TPS65219 chip
>>   *
>>   * @dev: MFD device
>>   * @regmap: Regmap for accessing the device registers
>>   * @irq_data: Regmap irq data used for the irq chip
>>   * @nb: notifier block for the restart handler
>>   */
>>
>>>
>>> Can you try an compile with W=1 please.
>> This raise one warning on mfd:
> 
> Is that before or after the header was fixed-up?
After the header was fixed-up.
> 
>> drivers/mfd/tps65219.c:28:12: warning: ‘tps65219_soft_shutdown’ defined but
>> not used [-Wunused-function]
>>     28 | static int tps65219_soft_shutdown(struct tps65219 *tps)
>>        |            ^~~~~~~~~~~~~~~~~~~~~~
>> soft_shutdown has been validated and is used in TI baseline even if not
>> hooked in upstream version further to this review:
>> https://lore.kernel.org/lkml/20220825150224.826258-5-msp@baylibre.com/
> 
> Will tps65219_soft_shutdown() be used?
> 
> I think it should be removed until it's utilised in Mainline.
> 
I'll remove then

Thanks for your feedback
