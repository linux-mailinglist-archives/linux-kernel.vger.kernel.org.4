Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DAD5E80FA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiIWRlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbiIWRlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:41:05 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6B3EE64D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:40:03 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bq9so1069493wrb.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 10:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=QsuVOjPfclMcwP8wqLr3n2RY9nvNNr77YjobAM/HIYY=;
        b=H6L0D+4TyYrNgvSkApP3b4Z76j95XxG1wzK/98bF4r5NxPIgb62i0rFLWy7lMOvkkM
         K2wKnBfWNguTP9RlvxCX+D4ylUt5GJa0LqaNUv0DJ3zuoCyYFXgtkt2AXeFUmiHCKY/K
         gjLm0jcN5dNBLqMBFXrapcKnM2pQeBGr/KnQVNCl5SZRMln4rlMnRWaUemU8Qb17FQkj
         fjQpHq8KhbN+kc+zF7Mpy3qB/F+2rNMjisawq2BnM3J2jNh+krf58RpFbN+6xuh4emUl
         Zbv6JjQ2T0654GYpBj6vO1bpT46YsgrRhNKP5zsILNm/pDUJUESMuZARa9VFTWeTsYeo
         2BoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=QsuVOjPfclMcwP8wqLr3n2RY9nvNNr77YjobAM/HIYY=;
        b=TPcA3vu6/ED/WQu53rljjZ8+QYJNWIwykMHbzbWBml3McRbX+prFACNyvibZoWnQaZ
         hOm4XvyaavkuRYnaeI+ZHfyWrdil7kz+ue1ojEmsL6b9j9r1EQh2otD7Smy8eGrtxBkw
         aMXRMolQnd6A4hdLOuDXc4za3JuFAkzJiDZeqi3j60SplNs1bZwDo0dwEabtvU+PCuD8
         6307TA3bO0IosvyQGJbSA1MUhuO3brSYK/LdO5HVWEuCQwBIN0+oN8mkZtwNMfd0AUup
         +xnkDtfYPnaPt4EZkUkFaBzIzpI8OMqNMh5ilJv0XXKQft5P6pPvd62K7MCkQWA6NQDh
         6VPw==
X-Gm-Message-State: ACrzQf3ZJq3dnvsUbHpjxRi5ln+W5IYdYU1vjHrxnTOpx6/tALPKMujZ
        r5NMfgzhpbxVzeZbcmH8a+mHDA==
X-Google-Smtp-Source: AMsMyM7yk1FJy6WdVruMMyboi96UzFPD0vgB/hJC1F1S3+IGXF1csrbyA/C+3skWQY7oeMXIBuh/oQ==
X-Received: by 2002:adf:f80b:0:b0:228:dbb9:5bdf with SMTP id s11-20020adff80b000000b00228dbb95bdfmr5974312wrp.327.1663954802047;
        Fri, 23 Sep 2022 10:40:02 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id e6-20020adfdbc6000000b00228dc37ce2asm7648551wrj.57.2022.09.23.10.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 10:40:01 -0700 (PDT)
Message-ID: <cdbe5e4b-b0b1-3539-2a9a-bbf87a4d8e92@linaro.org>
Date:   Fri, 23 Sep 2022 19:40:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 10/30] thermal/drivers/exynos: Replace
 of_thermal_is_trip_valid() by thermal_zone_get_trip()
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "open list:SAMSUNG THERMAL DRIVER" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>
References: <20220921094244.606948-1-daniel.lezcano@linaro.org>
 <20220921094244.606948-11-daniel.lezcano@linaro.org>
 <CGME20220923140903eucas1p180002df0deb308d5148cc6004aef7efe@eucas1p1.samsung.com>
 <bc3a5137-b2be-0bfe-003a-db201a7a50e8@samsung.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <bc3a5137-b2be-0bfe-003a-db201a7a50e8@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marek,

thanks for reporting

On 23/09/2022 16:09, Marek Szyprowski wrote:

[ ... ]

> Exception stack(0xf082dfb0 to 0xf082dff8)
> 
> [deadlock]
> 
> Something is wrong in locking in the functions from the above stacktrace.

Are you sure this deadlock is coming from this patch? Does a revert of 
this patch solve the issue ?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
