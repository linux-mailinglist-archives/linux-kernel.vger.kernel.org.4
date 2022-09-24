Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46D25E8F05
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 19:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiIXRpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 13:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbiIXRpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 13:45:04 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A9E29CAD
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 10:45:03 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id ay7-20020a05600c1e0700b003b49861bf48so6520187wmb.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 10:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=YyNxFfa5wN023SruSIFxh76V8W60w/tg0DATUJyNGKQ=;
        b=snseuyIrOMuNHfVo/N2eXhpgPasfJ2orxblPYN+46Pg/E42D93bZ63uOUs3O9QvDTs
         n8MCT8v3x8/qs6Yfu/L8iTAVzOW2uE97Vcp0TSGJEryuvLhFq4XncAjaiaErtHr1/XQD
         0KbbclNbYUdU0qZcC2yhxqt8UNrQ1ejm7JqfIt9DvAIEM5CPPIyICjBrvkUREChyq2vq
         yK2aO4uCUPQT6OwKBu8w+KpLz+aGOS9HnakNOyY/UX4ZvxsAUmY3/tnd2iGhF/9UfvUu
         GWtmk9XuqTJUr2Ohk4bIYTbRbDhcBRBqpP5/Y8kXb0+TQ0mXCVrSAc3kHYjmtnVIBoku
         lOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=YyNxFfa5wN023SruSIFxh76V8W60w/tg0DATUJyNGKQ=;
        b=ypqrbi6tF2SpEWf6yMjcsD0hOyVRsvOuTswxGd+T0+d0WQ4CIiPOKyMO9ZxEiVHfk7
         +oaR+rXyxBOTsOLQNcfQEE5DySeKIBCu1TwD3ju6DvBDmZ2b5ipsbty9kXaEZlVyvo40
         ancjGAMv5jDQcc4Wb3Gv+UEuJra9MXn3GGN7VqOYl+MXbiDRu76BtQ8iuiD1M5KMGvtX
         opOGo909E7aAa0qo15PtNzq14/oMZmr12gHjg5l2L0JjIY8wxa5GRCL2GhXkpeNTemzr
         QkzfF3eNsYMgg9qXYiFw7mtZexxYswUh8G7p+Ny9roLfaFcebggWW/Z7JK6m2yChAdUQ
         7iHw==
X-Gm-Message-State: ACrzQf26QNa7VhFUBLQte/vlKWI4NDGO3G6NQCoA6+pNNyIhzWMaB7VU
        nWI9Yyhwu1kVR4YOEstDwSvITE+FNrUrLw==
X-Google-Smtp-Source: AMsMyM6ZGo2SB9Pi3GeNZcDRu3qUNjtJLwNpanCp+TR5hBzGxLtxl2ynhuTWf/ni7ylDhO4Z9OZm0A==
X-Received: by 2002:a7b:ca46:0:b0:3b4:7ff1:4fcc with SMTP id m6-20020a7bca46000000b003b47ff14fccmr17024792wml.47.1664041501830;
        Sat, 24 Sep 2022 10:45:01 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id v15-20020adfa1cf000000b0022c96d3b6f2sm1892993wrv.54.2022.09.24.10.45.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Sep 2022 10:45:00 -0700 (PDT)
Message-ID: <499d1aca-940b-bf0a-75ce-c3c2b2fe66fb@linaro.org>
Date:   Sat, 24 Sep 2022 19:44:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 29/30] thermal/intel/int340x: Replace parameter to
 simplify
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Antoine Tenart <atenart@kernel.org>
References: <20220906164720.330701-1-daniel.lezcano@linaro.org>
 <20220906164720.330701-30-daniel.lezcano@linaro.org>
 <CAJZ5v0j+2UM9zONBZpLW=X2KKQU5mDd8r=o9DqTq3rqoigBqrw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0j+2UM9zONBZpLW=X2KKQU5mDd8r=o9DqTq3rqoigBqrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2022 19:36, Rafael J. Wysocki wrote:
> On Tue, Sep 6, 2022 at 6:48 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> In the process of replacing the get_trip_* ops by the generic trip
>> points, the current code has an 'override' property to add another
>> indirection to a different ops.
>>
>> Rework this approach to prevent this indirection and make the code
>> ready for the generic trip points conversion.
>>
>> Actually the get_temp() is different regarding the platform, so it is
>> pointless to add a new set of ops but just create dynamically the ops
>> at init time.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> A fix has been posted for this one already:
> 
> https://patchwork.kernel.org/project/linux-pm/patch/20220923152009.1721739-1-nathan@kernel.org/

Thanks I'll pick it up in the series.

I'm currently fixing a locking issue in the thermal linux-next branch


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
