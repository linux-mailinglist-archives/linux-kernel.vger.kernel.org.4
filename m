Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A385EA893
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbiIZOhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbiIZOgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:36:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FF6DF073
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 05:55:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bk15so2324529wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 05:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=01DFwmFwike7Fdq5WGGY81jYBvZfQEs05v9GcTAcNCg=;
        b=lS0ujQauahabsf6VkekKTr7paCDACbNSq5+SN46iLYtafd+oXj9h07p/QjFwpSBz21
         6dJZhYRAlPaOGc108Nasp4HWu4SJ1Yhzvf5HedRMcP2HL7ehkkA2vy5AX1F2z0e30y7n
         lZutyWiCfZ5rPXlRgSmC+jWc5SnUIDdjsyvEHjbYeztzycA0jUWyGX+/Siu3bM8ws1yc
         V3c1rl9HK9UsBMVc6qHHuhvPChDgjg00/OYnz8hKhrqDD1bnmR81cN+7brIWo1Ztyk/F
         3iuEgokwSJ2qlXsjD11wbepNGWCvIoSDayf+z+/EKoSSjsB1vi/5PgQmIxKJv+FUWg/z
         DcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=01DFwmFwike7Fdq5WGGY81jYBvZfQEs05v9GcTAcNCg=;
        b=IbclBrTi8sZsx5hetLK6MRyJoVLbVz2xtEFw1BuB9prxG1IQv31xD5f/EmHYDWPSJz
         Sfkgw9mq1J1SlIqW/Nr/aoakdpHqQmg57EkbftewECuMOJ/HdnrVn2DmFY+dhEw/1QNI
         2XdJ5E2XLKX9+dMiYVQxor0Zrtxytchi0XJqz9ugOhyC72+x3d2ED39ze3o3wRv80XkI
         nCH1paHk67oMohCV/xOn4DZG8PU3umyE08zG4TMOzRW42eROOtzizmctq2FJnzfw0QCF
         K7b1nKOxWneDJh/FZI7F/QburPoFW2LdvbWH42+APUMpxQb+Y36E/5PZ7sAuGESOKyZY
         5xNg==
X-Gm-Message-State: ACrzQf3dWEmBxty8Jqcveacnj/ksc4bwo+eYbwm4yqg4Zc9f9L34q7/i
        jleDj2VJIxfgTh8YCynaT78Hrg==
X-Google-Smtp-Source: AMsMyM6EVH5TrMAh840LxVK5oJ1lYbiUhTPR2KGv8P2Mrz2ZLMCWYrl/7hUHQ3xcKh5u2E7t9+BDAw==
X-Received: by 2002:a05:6000:1849:b0:228:c848:2593 with SMTP id c9-20020a056000184900b00228c8482593mr13566324wri.557.1664196939084;
        Mon, 26 Sep 2022 05:55:39 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id f8-20020adfb608000000b00228692033dcsm13768070wre.91.2022.09.26.05.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 05:55:38 -0700 (PDT)
Message-ID: <6492701b-9723-56d0-a298-59e5cd896424@linaro.org>
Date:   Mon, 26 Sep 2022 14:55:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 02/30] thermal/sysfs: Do not make get_trip_hyst
 optional
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>
References: <20220921094244.606948-1-daniel.lezcano@linaro.org>
 <20220921094244.606948-3-daniel.lezcano@linaro.org>
 <c1d4ec94cc666897d8e493364352bd1442bdb819.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <c1d4ec94cc666897d8e493364352bd1442bdb819.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2022 16:19, Zhang Rui wrote:
> On Wed, 2022-09-21 at 11:42 +0200, Daniel Lezcano wrote:
>> The get_trip_hyst() ops is optional. It results all around the
>> thermal
>> framework code a check against the ops pointer and different action
>> adding more complexity and making the code less readable and
>> understandable.
>>
>> A zero hysteresis value is perfectly valid, so instead of adding more
>> circumvolutions in the code, create unconditionnaly the hysteresis
>> and
>> use the thermal_zone_get_trip() function which returns a zero
>> hysteresis if the get_trip_hyst() is not defined.
> 
> I think an alternative way is to use the .is_visible() callback to make
> this cleanup transparent to userspace.

This would apply for the group not per trip point file, no?


> With this, we can remove the
> 	if (tz->ops->set_trip_hyst)check in create_trip_attrs() as well.
> 
> But you make the cal. :)
> 
> thanks,
> rui
> 
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
