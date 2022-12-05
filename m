Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE2D643423
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbiLETmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbiLETly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:41:54 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70996DFA8
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 11:39:33 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id n7so9581123wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 11:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7pzik94DCRnikniychtCYn/if7UtyQkTWFCyd0BXZAs=;
        b=mPhxALAdZmhXA3LNUW3pO/6N9g17MLwyztZmXWZVb6a+DOYDAztdnk9+7GRr2lj+ON
         g3Y0gaqlIYyK/dkcOudswwzJYkV4QDFemDAKFOZfsxvEDrRuEjyHENJguwDr9rneRstQ
         Ys/AJ4BPPEWzUWUgGjyHCjTxK4WjajfsVRjLXweIKCPHc4b78j6VizaBs97dSVp/C2Wr
         DutF4W6xrJ9/AQ15NTZHpvCKMvVTx0MJokJnFrUyyrCJn29dWhmWmnTYaJIQAYF8vkik
         kVbQT0V0Gi2ZLbKIsBVfaoZJYRpYr41h4whRPg/iNg0swzNE/nmLIdcYYFZ9ixr3heC+
         uHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7pzik94DCRnikniychtCYn/if7UtyQkTWFCyd0BXZAs=;
        b=uLIq58/SAWhtSrujkfuYfCiRFH91LnxghhFJoYbMb62EjoCfIZupYxYkxTkJz7IuYr
         fteJsLZFMnuHMs3fOLgb8nsy5r0TUtSp5DQygFO0C/1hg9VjUepOI1tOpJ+xtemCJCo5
         btcTjeHOJku91MRCmMLqOyn6cRCJkkW2y4S2v0TofCOG/dvbBqE0A6fReU2KV6gc4M1y
         ENk/BOiyYgA85EyzkSmytoiW3+3J2GD+O7/ajfqOHWfOf4iRdiGLYpwlRzi/ujk7Qvrq
         cR/OJ+QVctlV+yoTyKwkyS0B/8stzLoRfhQzAODaT6WKDfyifV0grpqboXi4cv73xlmn
         lZvw==
X-Gm-Message-State: ANoB5pna2IYy4EyqTCfCaNpgpsZVNQKVy4meblBf9nzHok7/VKnGu2jz
        BR0IAsQ84uHscbu0q/XQ2IsSuw==
X-Google-Smtp-Source: AA0mqf7D6o5HZCbdZtrrkeiqgEkjfSmeglDG8CxGKl4IAXFIfOgqAXoQLydm+9jhl4i4m7nwJHIssA==
X-Received: by 2002:a05:600c:1da2:b0:3cf:147d:ad9a with SMTP id p34-20020a05600c1da200b003cf147dad9amr48581382wms.33.1670269171966;
        Mon, 05 Dec 2022 11:39:31 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id v14-20020a05600c444e00b003a1980d55c4sm23867622wmn.47.2022.12.05.11.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 11:39:31 -0800 (PST)
Message-ID: <adfe41f7-00e5-876b-7803-3127919fba13@linaro.org>
Date:   Mon, 5 Dec 2022 20:39:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 4/4] thermal: mediatek: add another get_temp ops for
 thermal sensors
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Michael Kao <michael.kao@mediatek.com>,
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
References: <20221018-up-i350-thermal-bringup-v7-0-ebf08ff2eddb@baylibre.com>
 <20221018-up-i350-thermal-bringup-v7-4-ebf08ff2eddb@baylibre.com>
 <4121bb6b-30db-7a23-f4c8-40afdda7a0b5@linaro.org>
 <COTTJX635TNF.1WL2TEZN7VW9O@amjad-ThinkPad-T490>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <COTTJX635TNF.1WL2TEZN7VW9O@amjad-ThinkPad-T490>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Amjad,


On 05/12/2022 11:41, Amjad Ouled-Ameur wrote:

[ ... ]

>>> @@ -1161,11 +1197,24 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>>>    
>>>    	platform_set_drvdata(pdev, mt);
>>>    
>>> -	tzdev = devm_thermal_of_zone_register(&pdev->dev, 0, mt,
>>> -					      &mtk_thermal_ops);
>>> -	if (IS_ERR(tzdev)) {
>>> -		ret = PTR_ERR(tzdev);
>>> -		goto err_disable_clk_peri_therm;
>>> +	for (i = 0; i < mt->conf->num_sensors + 1; i++) {
>>> +		tz = devm_kmalloc(&pdev->dev, sizeof(*tz), GFP_KERNEL);
>>> +		if (!tz)
>>> +			return -ENOMEM;
>>> +
>>> +		tz->mt = mt;
>>> +		tz->id = i;
>>> +
>>> +		tzdev = devm_thermal_of_zone_register(&pdev->dev, i, tz, (i == 0) ?
>>> +							     &mtk_thermal_ops :
>>> +							     &mtk_thermal_sensor_ops);
>>
>> Here you use again the aggregation
> I addressed this concern in V6, could you please take a look and let me
> know what you think [0].
> 
> [0]: https://lore.kernel.org/all/5eb0cdc2-e9f9-dd42-bf80-b7dcd8bcc196@baylibre.com/

May I misunderstanding but AFAICS, this patch is setting the 
mtk_thermal_ops if the sensor id is zero. The get_temp is computing the 
max temperature in this ops which is what we don't want to do.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

