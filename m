Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE3C68C013
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjBFOaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjBFOaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:30:22 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A53C193F7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:30:20 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id g6so2561623wrv.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 06:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SelsI8yzcEBkNQxZNV8tPqWXPH22omPqI53i1VeNzBQ=;
        b=v9xwkDIZOVWO941JxF+vm1Dc2RxA14RNnwB27jT8wqZ1LXpVPkyXFUmXjc/af1vHzO
         hrbzb+qy5p4H+6Yn6ipuaPXXtlWNnsITuC2D+PTQH6mj8azff1144AifDaJl2RO2t3Qg
         8IxasxjeMKcjuBBail3/CwkeM6J5yJS9CeOCrzU0mfoAJRN69bQ8Bj8UT/IHbKUnDQtI
         D851ylmtb8mc5u1PnBx8cDU1IeDaNRCEdvSsARmGUVvR5aKh/UDfmquuAFcfieLIks3b
         OudZUhLerPC9dK9lwTMBvZuExUT7zJx4rSY5cG9XKl/gjA+mi7V9vdaCcxzNqkhAbbku
         gT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SelsI8yzcEBkNQxZNV8tPqWXPH22omPqI53i1VeNzBQ=;
        b=2yIkkgjqcZWWaD9y03Kozav/4iXZa/6pJqi/zt5LiMTYPruqxgT01qx/TJ3MhMddr/
         u1tcf5OjoxLtcy0BFRf3QCy4vqEc5ytnqTwEtZRfJzd3A/sxN1THyRrikcjNQ3PJzzgN
         kZAciCJduod6ynu3II3UIYJeRp2XamahjreG5KUe0BK02p/7GBdwIKnskankbBZkB5TU
         JAw5oI6DTvI4GT1UShWqPEf6C02jJo3IfmvNyy+C2Dj/FEA1boon2dItuNVfgcyDqNxF
         idtP1/9xX5SAfBlZ86Srmw12KQQtJMxLN/aH3hrWc9lmq3zt2BjiqXMarXKHU5trcnR6
         +tbQ==
X-Gm-Message-State: AO0yUKX1VsnIOgll3KdsIT9Q0xay+A1RdJ0FiLh583Pw4SwJ4UHq3qkl
        SHiW6y2+7Y6lI769fjChYlCycA==
X-Google-Smtp-Source: AK7set8OxFswJkWxdT01ruq6k/zxpz9cyuNcS2/TkMFSxlEM3tn6Wdo030SdfenRyBCXADtuBH9LLQ==
X-Received: by 2002:adf:f108:0:b0:2c3:ea77:26ab with SMTP id r8-20020adff108000000b002c3ea7726abmr3529496wro.60.1675693818971;
        Mon, 06 Feb 2023 06:30:18 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w2-20020a5d6802000000b002bfb1de74absm8928828wru.114.2023.02.06.06.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 06:30:18 -0800 (PST)
Message-ID: <b6a24ff7-4154-f2b4-88b1-a8a87c30d30a@linaro.org>
Date:   Mon, 6 Feb 2023 15:30:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v12] thermal: drivers: mediatek: Add the Low Voltage
 Thermal Sensor driver
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     bchihi@baylibre.com, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230124131717.128660-5-bchihi@baylibre.com>
 <20230131153816.21709-1-bchihi@baylibre.com>
 <ab1e4822-d5f4-79f6-ea38-47e2342ebe49@linaro.org>
 <20230206140713.GB15176@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230206140713.GB15176@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2023 15:07, Daniel Lezcano wrote:
> On Wed, Feb 01, 2023 at 08:55:07AM +0100, Krzysztof Kozlowski wrote:
>> On 31/01/2023 16:38, bchihi@baylibre.com wrote:
>>> From: Balsam CHIHI <bchihi@baylibre.com>
>>>
>>> The Low Voltage Thermal Sensor (LVTS) is a multiple sensors, multi
>>> controllers contained in a thermal domain.
>>>
>>> A thermal domains can be the MCU or the AP.
>>>
>>> Each thermal domains contain up to seven controllers, each thermal
>>> controller handle up to four thermal sensors.
>>>
>>> The LVTS has two Finite State Machines (FSM), one to handle the
>>> functionin temperatures range like hot or cold temperature and another
>>> one to handle monitoring trip point. The FSM notifies via interrupts
>>> when a trip point is crossed.
>>>
>>
>> (...)
>>
>>> +
>>> +struct lvts_domain {
>>> +	struct lvts_ctrl *lvts_ctrl;
>>> +	struct reset_control *reset;
>>> +	struct clk *clk;
>>> +	int num_lvts_ctrl;
>>> +	void __iomem *base;
>>> +	size_t calib_len;
>>> +	u8 *calib;
>>> +};
>>> +
>>> +#ifdef CONFIG_MTK_LVTS_THERMAL_DEBUGFS
>>> +
>>> +static struct dentry *root;
>>
>> How do you handle two instances of driver?
> 
> For now, we can put the entry in /sys/kernel/debug/<dev_name>
> 
> I'm preparing a debugfs series for the thermal framework and that will provide
> an entry to hook in for the sensors debugfs if available

The code looked like it does not support it at all. I think it would
remove entries from second instance, while unbinding the first (or the
opposite).

Best regards,
Krzysztof

