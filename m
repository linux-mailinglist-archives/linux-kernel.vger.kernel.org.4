Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092106E4476
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 11:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjDQJz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 05:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjDQJzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 05:55:01 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D19558A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 02:54:21 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id xd13so28611360ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 02:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681725167; x=1684317167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gcr5YmlYoVcdrEFDHra0XuIJQfELMbNwudSm2TRrzow=;
        b=hNQPAeO7roIO6GhA/CDHT/L+bHgrIpMw4KHbMpBZt+dcE0MT6BRNLElolGrIjj06uL
         v0oeBt2oeiJD/PcMLXUpALj+R/gjciFhBbDSBvlWc8jurdVgST8yMwJAQqDf0jj7nRYO
         2obf9bHKgUan3lsRWrvnkF+95LCpROpb5aXOe9LtCYeUutwNJGuZfA2boOJbSjgrno/r
         S0TiHu7by/zGq+suQPr8zXNBbbpY9ECY3eskJjihRzEdLZFeJE9hthxtuNd70b/ERSss
         E2FPAGCAq38un6VzIXUF3v1w8vuPdlW7XlAX2+HFWQ/pS1QVSD6w5AP9qkBT9NISEGzP
         u//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681725167; x=1684317167;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gcr5YmlYoVcdrEFDHra0XuIJQfELMbNwudSm2TRrzow=;
        b=VqceYmoOSy9bHJuzJafK0+XOkRxiY7eOq8CmT0MYfubbbSmKK8hs0PoxmcGDAAk5Y4
         2EN/y1PoDwEcqSOPxzNEHGbv1vEPNXeEUhYcozlEFbCtUwf5ycseVm/xqv/8nobXo0dy
         d83FxXQeG76ADQ7ecNtGyOOgAnCBOyIPzg0LrxEnJX+CwRRpY278oPPkYGozPL2g5ByO
         GxkefFb483kZb0BiDxgwM1+t3voMA2Wg1RIKWAbrvGwk5xaGjW7o87O/wirkFp0mK6X6
         uWXCrEiT6Qr6dateQzZ6yeaAQZ3gfYpQBLeDF8RvH3jkG9lv4Bnn7xdfA85HerETTpDY
         lFgQ==
X-Gm-Message-State: AAQBX9dBiJvjYkyBsu4P/ug36zQnfIwDF45OZhkKGbjr6YoXynd869M/
        YHc/JS96GiRnFpp1JCCbNFdlvw==
X-Google-Smtp-Source: AKy350YsZx2nKFyEnXBZglFwnu+EZhMUrIcOvtxJAINOd9ys3x1JK5D6h749rW6LsTd/MCLy+Pzwlw==
X-Received: by 2002:a17:906:e2d4:b0:94e:8d26:f610 with SMTP id gr20-20020a170906e2d400b0094e8d26f610mr6489616ejb.28.1681725167046;
        Mon, 17 Apr 2023 02:52:47 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id h3-20020a170906530300b0093a0e5977e2sm6357961ejo.225.2023.04.17.02.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 02:52:46 -0700 (PDT)
Message-ID: <cfb7743b-03b0-96c4-fcc3-7095694f6fbb@linaro.org>
Date:   Mon, 17 Apr 2023 11:52:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 2/2] thermal: mediatek: change clk_prepare_enable to
 devm_clk_get_enabled in mtk_thermal_probe
To:     void0red@hust.edu.cn
Cc:     amitk@kernel.org, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, daniel@makrotopia.org, dzm91@hust.edu.cn,
        error27@gmail.com, henry.yen@mediatek.com,
        hust-os-kernel-patches@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        matthias.bgg@gmail.com, rafael@kernel.org, rdunlap@infradead.org,
        rui.zhang@intel.com, void0red@gmail.com
References: <b2e5ef14-9a12-15d5-8016-d0994c1177c3@linaro.org>
 <20230411063531.3976354-1-void0red@hust.edu.cn>
 <20230411063531.3976354-2-void0red@hust.edu.cn>
 <4fed91ef.3c256.18783c407e3.Coremail.void0red@hust.edu.cn>
Content-Language: en-US
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4fed91ef.3c256.18783c407e3.Coremail.void0red@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

this patch does not apply:

Analyzing 9 messages in the thread
Will use the latest revision: v3
You can pick other revisions using the -vN flag
Checking attestation on all messages, may take a moment...
---
   [PATCH v3 2/2] thermal: mediatek: change clk_prepare_enable to 
devm_clk_get_enabled in mtk_thermal_probe
     + Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
     + Link: 
https://lore.kernel.org/r/20230411063531.3976354-2-void0red@hust.edu.cn
---
Total patches: 1 (cherrypicked: 2)
---
  Link: 
https://lore.kernel.org/r/20230411063531.3976354-1-void0red@hust.edu.cn
  Base: not specified
Applying: thermal: mediatek: change clk_prepare_enable to 
devm_clk_get_enabled in mtk_thermal_probe
error: patch failed: drivers/thermal/mediatek/auxadc_thermal.c:1182
error: drivers/thermal/mediatek/auxadc_thermal.c: patch does not apply
Patch failed at 0001 thermal: mediatek: change clk_prepare_enable to 
devm_clk_get_enabled in mtk_thermal_probe
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".



On 15/04/2023 09:14, void0red@hust.edu.cn wrote:
> 
> 
> 
>> -----Original Messages-----
>> From: "Kang Chen" <void0red@hust.edu.cn>
>> Sent Time: 2023-04-11 14:35:31 (Tuesday)
>> To: daniel.lezcano@linaro.org
>> Cc: amitk@kernel.org, angelogioacchino.delregno@collabora.com, bchihi@baylibre.com, daniel@makrotopia.org, dzm91@hust.edu.cn, error27@gmail.com, henry.yen@mediatek.com, hust-os-kernel-patches@googlegroups.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, matthias.bgg@gmail.com, rafael@kernel.org, rdunlap@infradead.org, rui.zhang@intel.com, void0red@gmail.com, void0red@hust.edu.cn
>> Subject: [PATCH v3 2/2] thermal: mediatek: change clk_prepare_enable to devm_clk_get_enabled in mtk_thermal_probe
>>
>> use devm_clk_get_enabled to do automatic resource management.
>> Meanwhile, remove error handling labels in the probe function and
>> the whole remove function.
>>
>> Signed-off-by: Kang Chen <void0red@hust.edu.cn>
>> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
>> ---
>> v3 -> v2: remove some useles func calls.
>> v2 -> v1: init
>>
>> Notice the devm_clk_get_enabled do the clk_get and clk_prepare_enable
>> at the same time.
>> I'm not sure if this has any side effects in initialization.
>>
>>   drivers/thermal/mediatek/auxadc_thermal.c | 48 +++++------------------
>>   1 file changed, 10 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
>> index 3372f7c29626..995837ce3ea2 100644
>> --- a/drivers/thermal/mediatek/auxadc_thermal.c
>> +++ b/drivers/thermal/mediatek/auxadc_thermal.c
>> @@ -1116,14 +1116,6 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>>   
>>   	mt->conf = of_device_get_match_data(&pdev->dev);
>>   
>> -	mt->clk_peri_therm = devm_clk_get(&pdev->dev, "therm");
>> -	if (IS_ERR(mt->clk_peri_therm))
>> -		return PTR_ERR(mt->clk_peri_therm);
>> -
>> -	mt->clk_auxadc = devm_clk_get(&pdev->dev, "auxadc");
>> -	if (IS_ERR(mt->clk_auxadc))
>> -		return PTR_ERR(mt->clk_auxadc);
>> -
>>   	mt->thermal_base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
>>   	if (IS_ERR(mt->thermal_base))
>>   		return PTR_ERR(mt->thermal_base);
>> @@ -1182,16 +1174,16 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		return ret;
>>   
>> -	ret = clk_prepare_enable(mt->clk_auxadc);
>> -	if (ret) {
>> -		dev_err(&pdev->dev, "Can't enable auxadc clk: %d\n", ret);
>> -		return ret;
>> +	mt->clk_auxadc = devm_clk_get_enabled(&pdev->dev, "auxadc");
>> +	if (IS_ERR(mt->clk_auxadc)) {
>> +		dev_err(&pdev->dev, "Can't enable auxadc clk: %d\n", mt->clk_auxadc);
>> +		return PTR_ERR(mt->clk_auxadc);
>>   	}
>>   
>> -	ret = clk_prepare_enable(mt->clk_peri_therm);
>> -	if (ret) {
>> -		dev_err(&pdev->dev, "Can't enable peri clk: %d\n", ret);
>> -		goto err_disable_clk_auxadc;
>> +	mt->clk_peri_therm = devm_clk_get_enabled(&pdev->dev, "therm");
>> +	if (IS_ERR(mt->clk_peri_therm)) {
>> +		dev_err(&pdev->dev, "Can't enable peri clk: %d\n", mt->clk_peri_therm);
>> +		return PTR_ERR(mt->clk_peri_therm);
>>   	}
>>   
>>   	if (mt->conf->version != MTK_THERMAL_V1) {
>> @@ -1215,38 +1207,18 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>>   
>>   	tzdev = devm_thermal_of_zone_register(&pdev->dev, 0, mt,
>>   					      &mtk_thermal_ops);
>> -	if (IS_ERR(tzdev)) {
>> -		ret = PTR_ERR(tzdev);
>> -		goto err_disable_clk_peri_therm;
>> -	}
>> +	if (IS_ERR(tzdev))
>> +		return PTR_ERR(tzdev);
>>   
>>   	ret = devm_thermal_add_hwmon_sysfs(tzdev);
>>   	if (ret)
>>   		dev_warn(&pdev->dev, "error in thermal_add_hwmon_sysfs");
>>   
>>   	return 0;
>> -
>> -err_disable_clk_peri_therm:
>> -	clk_disable_unprepare(mt->clk_peri_therm);
>> -err_disable_clk_auxadc:
>> -	clk_disable_unprepare(mt->clk_auxadc);
>> -
>> -	return ret;
>> -}
>> -
>> -static int mtk_thermal_remove(struct platform_device *pdev)
>> -{
>> -	struct mtk_thermal *mt = platform_get_drvdata(pdev);
>> -
>> -	clk_disable_unprepare(mt->clk_peri_therm);
>> -	clk_disable_unprepare(mt->clk_auxadc);
>> -
>> -	return 0;
>>   }
>>   
>>   static struct platform_driver mtk_thermal_driver = {
>>   	.probe = mtk_thermal_probe,
>> -	.remove = mtk_thermal_remove,
>>   	.driver = {
>>   		.name = "mtk-thermal",
>>   		.of_match_table = mtk_thermal_of_match,
>> -- 
>> 2.34.1
> 
> ping?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

