Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F05266BC6F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjAPLIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjAPLI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:08:29 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F8744A7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:08:27 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id bi26-20020a05600c3d9a00b003d3404a89faso3613165wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oY1CMwQPo9pqZFQ5X1XWiszDlHo8i56moA+2uRb8fME=;
        b=v/DvQjBqu50BLIO+pJ77FapwhDEE5Lhg9ZhPAcxgnBVjEXReDNOtqyuiv/wE6ZnBvu
         8+8QLqBj60uSmx6ealELllodGODsWwVnOnfNY8058quhAUDu/im1S3Z5JWdR1Zx3IAC1
         o9/6Ikqr3BIkJB7HeCzEH6BW782lDcCVYnM6XZe0M5z/RcnvuluEEo665P3J6GWyZheu
         m/PH6FUsiTvhZx1PXqoFTINIoyU2ghGvOQbii5VSR/JUUKpZEzdW3csa/VT6S4Q0Sh7N
         U0ENE+ipIgI97GBdktAW+ZLmJysqMB0+hUl+fOLCjJbr5h8FWwFvdTBR8RxLigN1XJxW
         f10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oY1CMwQPo9pqZFQ5X1XWiszDlHo8i56moA+2uRb8fME=;
        b=IUSz4bQtbkrb6cFPLbFq0zK3FaqEjLo6C+Guu1AeHkbeHIkSSWdM5wSX5EHWXfvKfs
         5HYZTuoj1g1m+zIxIJtmMLi2QLk+OBfYiNzHO+lBa24/NWaEsBbF4LiWNvJtRm04QRN7
         MeuDOZHzxb6dCFHFomLbU71dnLiHsMGn0n/v2dOECAEQjGVKQsLRYpz7PR5qi7R1FK+c
         QgGrGEwIEj7+5olte4k+oP9qTnPKrzz2nysSnoKhmcFVlR07YQIXXl2MXKA5u9d4N9An
         0enieDdFLlMBAnMRcYhb1gPrDNj8MHLutmM0a7teFr2yYF3pXpjy8Arg9OORz6Ra2qls
         IT3w==
X-Gm-Message-State: AFqh2kpmWYY5OoBm1qbEwm/07VdBHPNDx5dtSsKE21CgsO0Qy5c45r72
        VslzCpIsTR8KCk0gcXrkaBQkPg==
X-Google-Smtp-Source: AMrXdXt836Nug7KTTOBqrUZsGMleiuqv5Q4zzsuf84wWCwYJA3gixUDb9n32kRKYj11+eosGImg95A==
X-Received: by 2002:a05:600c:a51:b0:3cf:6f4d:c259 with SMTP id c17-20020a05600c0a5100b003cf6f4dc259mr65053587wmq.39.1673867306323;
        Mon, 16 Jan 2023 03:08:26 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id i18-20020a1c5412000000b003db01178b62sm1062390wmb.40.2023.01.16.03.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 03:08:25 -0800 (PST)
Message-ID: <1ee1152b-b83b-ed7b-6368-26601ece37e8@linaro.org>
Date:   Mon, 16 Jan 2023 12:08:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v10 4/6] thermal/drivers/mediatek: Add the Low Voltage
 Thermal Sensor driver
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, bchihi@baylibre.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230112152855.216072-1-bchihi@baylibre.com>
 <20230112152855.216072-5-bchihi@baylibre.com>
 <feab4ff4-b874-aa10-2031-ad6b84cbc004@collabora.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <feab4ff4-b874-aa10-2031-ad6b84cbc004@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2023 11:50, AngeloGioacchino Del Regno wrote:
> Il 12/01/23 16:28, bchihi@baylibre.com ha scritto:
>> From: Balsam CHIHI <bchihi@baylibre.com>
>>
>> The Low Voltage Thermal Sensor (LVTS) is a multiple sensors, multi
>> controllers contained in a thermal domain.
>>
>> A thermal domains can be the MCU or the AP.
>>
>> Each thermal domains contain up to seven controllers, each thermal
>> controller handle up to four thermal sensors.
>>
>> The LVTS has two Finite State Machines (FSM), one to handle the
>> functionin temperatures range like hot or cold temperature and another
>> one to handle monitoring trip point. The FSM notifies via interrupts
>> when a trip point is crossed.
>>
>> The interrupt is managed at the thermal controller level, so when an
>> interrupt occurs, the driver has to find out which sensor triggered
>> such an interrupt.
>>
>> The sampling of the thermal can be filtered or immediate. For the
>> former, the LVTS measures several points and applies a low pass
>> filter.
>>
>> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
>> ---
>>   drivers/thermal/mediatek/Kconfig            |   15 +
>>   drivers/thermal/mediatek/Makefile           |    1 +
>>   drivers/thermal/mediatek/lvts_thermal.c     | 1244 +++++++++++++++++++
>>   include/dt-bindings/thermal/mediatek-lvts.h |   19 +
>>   4 files changed, 1279 insertions(+)
>>   create mode 100644 drivers/thermal/mediatek/lvts_thermal.c
>>   create mode 100644 include/dt-bindings/thermal/mediatek-lvts.h
>>
> 
> ..snip..
> 
>> +
>> +static int lvts_set_trips(struct thermal_zone_device *tz, int low, 
>> int high)
>> +{
>> +    struct lvts_sensor *lvts_sensor = tz->devdata;
>> +    void __iomem *base = lvts_sensor->base;
>> +    u32 raw_low = lvts_temp_to_raw(low);
>> +    u32 raw_high = lvts_temp_to_raw(high);
>> +
>> +    /*
>> +     * Hot to normal temperature threshold
>> +     *
>> +     * LVTS_H2NTHRE
>> +     *
>> +     * Bits:
>> +     *
>> +     * 14-0 : Raw temperature for threshold
>> +     */
>> +    if (low != -INT_MAX) {
>> +        dev_dbg(&tz->device, "Setting low limit temperature 
>> interrupt: %d\n", low);
>> +        writel(raw_low, LVTS_H2NTHRE(base));
>> +    }
>> +
>> +    /*
>> +     * Hot temperature threshold
>> +     *
>> +     * LVTS_HTHRE
>> +     *
>> +     * Bits:
>> +     *
>> +     * 14-0 : Raw temperature for threshold
>> +     */
>> +    dev_dbg(&tz->device, "Setting high limit temperature interrupt: 
>> %d\n", high);
>> +    writel(raw_high, LVTS_HTHRE(base));
>> +
>> +    return 0;
>> +}
>> +
>> +static irqreturn_t lvts_ctrl_irq_handler(struct lvts_ctrl *lvts_ctrl)
>> +{
>> +    irqreturn_t iret = IRQ_NONE;
>> +    u32 value, masks[] = { 0x0009001F, 0X000881F0, 0x00247C00, 
>> 0x1FC00000 };
> 
> Please, no magic numbers around.
> 
>> +    int i;
>> +
>> +    /*
>> +     * Interrupt monitoring status
>> +     *
>> +     * LVTS_MONINTST
>> +     *
>> +     * Bits:
> 
> You're describing the register with nice words, but there's another way 
> to do
> the same that will be even more effective.
> 
> /*
>   * LVTS MONINT: Interrupt Monitoring register
>   * Each bit describes the enable status of per-sensor interrupts.
>   */
> #define LVTS_MONINT_THRES_COLD    BIT(0)    /* Cold threshold */
> #define LVTS_MONINT_THRES_HOT    BIT(1)    /* Hot threshold */
> #define LVTS_MONINT_OFFST_LOW    BIT(2)    /* Low offset */
> #define LVTS_MONINT_OFFST_HIGH    BIT(3)    /* High offset */
> #define LVTS_MONINT_OFFST_NTH    BIT(4)    /* Normal To Hot */
> #define EVERYTHING_ELSE ........................

I don't see how this is more effective than describing the register 
layout. If someone wants to hack the driver, it is much better to have 
the layout than this long list of defines for every bits of every registers.




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

