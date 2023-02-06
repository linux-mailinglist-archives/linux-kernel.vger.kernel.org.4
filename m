Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BAF68C049
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjBFOi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjBFOiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:38:23 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CED51ABD7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 06:38:19 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id g6so2587238wrv.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 06:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sf/528wXAQUAwrFpLgVFCwIJzpqE7FME4cXLMCiQ9q4=;
        b=SFl9P6mJB4sMOiUWh46YPfTw67evHCpobeIYqBGB3FXcLQE7OI+Whm6vEJ+dz1b73C
         WVODA1ekHEt8t+KimKYEuXwF3FbAL06LLNVA6G6hQAz7O9BXpIRFP28xlgjYEBzQQMa2
         T+FrUB8SvWWNVBLcSxSoFwPwGI4KmBhYIVE9K0Xu2fhIiMPHGF0uc7lltqcKRKpnBeyW
         dc4guszP3mI/UGFFf2znZlrMByVFFmjz2snKGOYfS8SSI1NMzhY8ZeVIQFOCca0WDNAm
         bafVZp6pu9jliK2/II2xsSYdKo/yUp+fcQV8y5jJY956gMaeE/ogLOUaJigRIQoxIpyT
         /FMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sf/528wXAQUAwrFpLgVFCwIJzpqE7FME4cXLMCiQ9q4=;
        b=U9an9zPDMIvgHfIrAtGFaFWHZHWCikKfbVzL5mS/j0lI0pd6UrjGUxwSYbHVbyyecW
         4LQank5HOJWfskhS+ATIk823QTrSvAB8DvoKa+6ClCmY0ipPotY9k9ngII2roDEPdu+I
         bNF8jzh4iBwQi+GE/sL/7rLFbcv+65yr5w+C7CtSPOw8a/alOf1DK7OfE6ZzBgkex7CI
         luMj+uQBqq/MH5Zx67au784LtvFX8HhTATZ6oCyh7TXDtbclCOtb1HMzHXNLDzRzPQKT
         PJbgNmGkjWeVQrmk0GMFC+jAIJYJS84aznISL4jHzY/ux6H9tNMOw6drL7LxvdHgJM9X
         yQOQ==
X-Gm-Message-State: AO0yUKXOmiuyqgIsDEHzkp+n/oq/6fkgCNQoh3wVWUmySrJhds7pL5vR
        wFGDnmtf8VkloNbB98pYui04CQ==
X-Google-Smtp-Source: AK7set9WEiQQfj69zfozOpjUPK78PzdVOxESwEbgbyE39wzmtW0iMjikdve/zkaIsPj3uSNQsEa5yg==
X-Received: by 2002:a5d:46cf:0:b0:2c3:ea6b:ef83 with SMTP id g15-20020a5d46cf000000b002c3ea6bef83mr3042598wrs.12.1675694297531;
        Mon, 06 Feb 2023 06:38:17 -0800 (PST)
Received: from [172.17.59.64] (wifi-eduroam-trans.univ-tlse3.fr. [195.220.58.237])
        by smtp.googlemail.com with ESMTPSA id o1-20020a5d4a81000000b002c3d67aac74sm8510523wrq.88.2023.02.06.06.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 06:38:17 -0800 (PST)
Message-ID: <ea30d169-2ae6-2744-fbfd-01bbbba36554@linaro.org>
Date:   Mon, 6 Feb 2023 15:38:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v12] thermal: drivers: mediatek: Add the Low Voltage
 Thermal Sensor driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
 <b6a24ff7-4154-f2b4-88b1-a8a87c30d30a@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <b6a24ff7-4154-f2b4-88b1-a8a87c30d30a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2023 15:30, Krzysztof Kozlowski wrote:
> On 06/02/2023 15:07, Daniel Lezcano wrote:
>> On Wed, Feb 01, 2023 at 08:55:07AM +0100, Krzysztof Kozlowski wrote:
>>> On 31/01/2023 16:38, bchihi@baylibre.com wrote:
>>>> From: Balsam CHIHI <bchihi@baylibre.com>
>>>>
>>>> The Low Voltage Thermal Sensor (LVTS) is a multiple sensors, multi
>>>> controllers contained in a thermal domain.
>>>>
>>>> A thermal domains can be the MCU or the AP.
>>>>
>>>> Each thermal domains contain up to seven controllers, each thermal
>>>> controller handle up to four thermal sensors.
>>>>
>>>> The LVTS has two Finite State Machines (FSM), one to handle the
>>>> functionin temperatures range like hot or cold temperature and another
>>>> one to handle monitoring trip point. The FSM notifies via interrupts
>>>> when a trip point is crossed.
>>>>
>>>
>>> (...)
>>>
>>>> +
>>>> +struct lvts_domain {
>>>> +	struct lvts_ctrl *lvts_ctrl;
>>>> +	struct reset_control *reset;
>>>> +	struct clk *clk;
>>>> +	int num_lvts_ctrl;
>>>> +	void __iomem *base;
>>>> +	size_t calib_len;
>>>> +	u8 *calib;
>>>> +};
>>>> +
>>>> +#ifdef CONFIG_MTK_LVTS_THERMAL_DEBUGFS
>>>> +
>>>> +static struct dentry *root;
>>>
>>> How do you handle two instances of driver?
>>
>> For now, we can put the entry in /sys/kernel/debug/<dev_name>
>>
>> I'm preparing a debugfs series for the thermal framework and that will provide
>> an entry to hook in for the sensors debugfs if available
> 
> The code looked like it does not support it at all. I think it would
> remove entries from second instance, while unbinding the first (or the
> opposite).

Yes, and you are right.

So instead of having:

/sys/kernel/debugfs/lvts/lvts@mcu

We will have:

/sys/kernel/debugfs/lvts@mcu

Later, when the other domain is added, we will have:

/sys/kernel/debugfs/lvts@mcu
/sys/kernel/debugfs/lvts@ap

Each instance takes care of removing its own entry

When I'll introduce thermal debugfs, I'll take care of massaging the 
driver to have them like:

/sys/kernel/debugfs/thermal/thermal_zone/0/sensors/lvts@mcu,0
/sys/kernel/debugfs/thermal/thermal_zone/1/sensors/lvts@ap,1




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

