Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207625B9F37
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 17:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiIOPxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 11:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiIOPxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:53:34 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75C980029
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:53:32 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id f13so831709wrs.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/3wMcFW+Q2QkQYcgxSwnwev38w4amXX73UlBpLdQGfw=;
        b=SjegSkPXCFmpyiHfBdu98vP76DdfhYVOvbr/LBihuRn6MatxIy3ClbyqSIX2XpM0f2
         WElfJqmd1PRrBXCxH62Cod/tKmSjr11eXB8/exFsbTr/WMKQva40g4PkDBpe+3/nSGoe
         WbUglcsu+yUPIBlRrMRKE/ZbYsdi/d1qe4gYhWS/VBnSUxCX3N1/IXkhuVVH3p5+qCIZ
         Jknz8kgCpHmBkh/9HomdCKdV4xJ+rBBG/BZ7EYEdzU2h2gisCG7Rp/uqx8mGUkh+7MI5
         6Ftxjdh4O40UbO4OFEXK9+A/wnWLBj1iwT9GYAn4YyiMT0AsjOirgQvhmgiPfjG9vTs/
         7Meg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/3wMcFW+Q2QkQYcgxSwnwev38w4amXX73UlBpLdQGfw=;
        b=NhhY371FNRM5Q08TlHVE3+HnRZvVlXgqy21sG9iYNoak8xQQeThEEzi9fr60eVAERX
         QNiSl2t4L0npDTeQzLhAUV/95A+dIoztUBfnK8WyWcOD4VvCJDC5nr8sRMFrQc/1Nnkr
         bTzfv1a9bVf14z2+ekCy/aH1rz+AAOls15Ey5eXoiRQfthh8tnhwpAzGdCXBMcD3sgAh
         2fuy+2UqvRieirs7lENr4HWdD/qh5F1Yh7s1Br9LZNLj4Zzw1UFODk4Qp4MWRoXW40tK
         Hq8zZl6RqpVUMbeIZ67rFNNbG0vC7ZjOyWG0i28fzETccS4vz4q6gjgTJWzy9j2bDx7D
         PrEA==
X-Gm-Message-State: ACrzQf0GFv9KVtQhmpeSQCKL3//DLXEYsz/AburDqpJBoxj/rU779so6
        BUG20DK74RskagR3LBKPdZxn8Q==
X-Google-Smtp-Source: AMsMyM7ZOkmT70Vmw/HZ6InphqFsxwBe0lN9yQVkNrorY1EAAFc5Tl2dD8twdKHggcwKeFq4EtvUQg==
X-Received: by 2002:adf:e94e:0:b0:228:da92:3691 with SMTP id m14-20020adfe94e000000b00228da923691mr216490wrn.1.1663257211361;
        Thu, 15 Sep 2022 08:53:31 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id n3-20020a05600c3b8300b003a319b67f64sm3824359wms.0.2022.09.15.08.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 08:53:30 -0700 (PDT)
Message-ID: <92e80c4b-f41f-8822-93f1-2476499d0b6e@linaro.org>
Date:   Thu, 15 Sep 2022 17:53:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] thermal/drivers/imx_sc: Rely on the platform data
 to get the resource id
Content-Language: en-US
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220818082316.2717095-1-daniel.lezcano@linaro.org>
 <17d09638-01e6-038f-c3db-cbe02ccb9327@linaro.org>
In-Reply-To: <17d09638-01e6-038f-c3db-cbe02ccb9327@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Shawn, Sascha,

if there is no comment on these two patches. I'll pick them up

Thanks

   -- D.

On 26/08/2022 00:28, Daniel Lezcano wrote:
> On 18/08/2022 10:23, Daniel Lezcano wrote:
>> Currently the imx_sc driver is reimplementing part of the thermal zone
>> parsing from the thermal OF tree code to get the sensor id associated
>> with a thermal zone sensor.
>>
>> The driver platform specific code should know what sensor is present
>> and not rely on the thermal zone description to do a discovery. Well
>> that is arguable but all the other drivers have a per platform data
>> telling what sensor id to use.
>>
>> The imx_sc thermal driver is the only one using a different
>> approach. Not invalid but forcing to keep a specific function
>> 'thermal_zone_of_get_sensor_id()' to get the sensor id for a specific
>> thermal zone as the self-explanatory function tells and having device
>> tree code inside the driver.
>>
>> The thermal OF code had a rework and remains now self-encapsulated
>> with a register/unregister functions and their 'devm' variants, except
>> for the function mentioned above.
>>
>> After investigating, it appears the imx_sc sensor is defined in
>> arch/arm64/boot/dts/freescale/imx8qxp.dtsi:
>>
>> which defines the cpu-thermal zone with the id: IMX_SC_R_SYSTEM
>>
>> This dtsi is included by:
>>   - imx8qxp-ai_ml.dts
>>   - imx8qxp-colibri.dtsi
>>   - imx8qxp-mek.dts
>>
>> The two first ones do not define more thermal zones
>> The third one adds the pmic-thermal0 zone with id: IMX_SC_R_PMIC_0
>>
>> The thermal OF code returns -ENODEV if the thermal zone registration
>> with a specific id fails because the description is not available in
>> the DT for such a sensor id. In this case we continue with the other
>> ids without bailing out with an error.
>>
>> So we can build for the 'fsl,imx-sc-thermal' a compatible data, an
>> array of sensor ids containing IMX_SC_R_SYSTEM and IMX_SC_R_PMIC_0.
>>
>> The latter won't be found but that will not result in an error but a
>> normal case where we continue the initialization with other ids.
>>
>> Just to clarify, it is what the thermal framework does and what the
>> other drivers are expecting: when a registration fails with -ENODEV
>> this is not an error but a case where the description is not found in
>> the device tree, that be can the entire thermal zones description or a
>> specific thermal zone with an unknown id.
>>
>> There is one small functional change but without impact. When there is
>> no 'thermal-zones' description the probe function was returning
>> '-ENODEV', now it returns zero. When a thermal zone fails to register
>> with an error different from '-ENODEV', the error is detected and
>> returned.
>>
>> Change the code accordingly and remove the OF code from the driver.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>> The changes apply on the linux-next branch:
>>
>>   
>> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/log/?h=thermal/linux-next 
>>
>>
>> I don't have the platform, so I was not able to test the changes.
>>
>> Changelog:
>>   v2:
>>      - Clarified a bit more the changes description
>>
>>      - Fix use-after-free and add a couple of comments to reflect the
>>       patch description
>>
>>      - Put back the error message in case there is an error with the
>>        registration
>>
> 
> Is there any comment on this change ?
> 
> 
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
