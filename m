Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488C76010E1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiJQOOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiJQOOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:14:38 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1971C11A2A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:14:35 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u10so18703113wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vq5kCnUtoL+6Ezgs4d51zvzN1gUGsMC/kvnhiOvxhZA=;
        b=tz3RbYuUFruNlDazal9vUSlnltiLDHvOxIl0LPUBuv6NxoHo4Vq9jqpO+al2nQKQI5
         jgcl8xIehpkHmpp4r4Q+IWD+dhvC9i80tQ5Wzp5nQou+s9jLpG8rhqY+Uh7I5z9wMxlt
         QF2zH65EKK1nXRdZNuvu7k7GEGtmX3+rZ5JWHfOoipbWSqjwn6KyzKKMzAZ85ZEuOHMV
         bpTAOFrf+BiU+6sZmU/F2OjMtWb1YvTZFJTAJeSXADdnC0J3jbbszwQAP0UX8EnC6t2Q
         DvyGE8C+YTFM/9xHctANb6CMFAo6zi46s9s+OfhIkFxaQNacgLnWj/3UByTYBYsKua1p
         9K6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vq5kCnUtoL+6Ezgs4d51zvzN1gUGsMC/kvnhiOvxhZA=;
        b=Tw/VDvJ1sB64YXbCs0QrAG6k13MrvtZbqrPP3FXSkg8cbyXKSwx4xuFYJKUGZj1egr
         B+D0vJpqUyKilZIyJZP+EzAt2nSYkQvlcM7TCgsKWF9i2BD3j1q63PsAnvK8tG/54ffc
         +5VG1K66+zp5+ye7rohu+/jEcIJlDQxHtBvU6v+My/Lx7KumzRLSw3BB6faBxhyQ+VBC
         WMby1h1197hYL7PLiqWPqOn0hUshCt9JoI9HSvJbwHOL0IQEK/r22JiMG3zwgFPQNNUZ
         Ax+oasPY5FGxPKAbZlZFtt2IQnhH7LTWWbk+JPBQCCi4rC95RlJgMK+uvsmrXH28gOBF
         AGMw==
X-Gm-Message-State: ACrzQf1SBTyZmSOXPkVw4eI+KQSq4GYs2aOBx2EhgBeCKhqBFwd9A25w
        MENWQeiJUdTmIL/fBXndy+F2SA==
X-Google-Smtp-Source: AMsMyM7CM0UpKnoMrB0XCN0oLx3Pp5aNEqNuOcOBP8m2CUuk58Y8mdiVuC8BXiFJDuJcLQxlD0XrEg==
X-Received: by 2002:adf:fd4a:0:b0:22d:d3aa:e004 with SMTP id h10-20020adffd4a000000b0022dd3aae004mr6402643wrs.173.1666016073416;
        Mon, 17 Oct 2022 07:14:33 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ea6:24ea:3fe7:64b9? ([2a05:6e02:1041:c10:ea6:24ea:3fe7:64b9])
        by smtp.googlemail.com with ESMTPSA id x17-20020adff0d1000000b00231ed902a4esm8608659wro.5.2022.10.17.07.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 07:14:33 -0700 (PDT)
Message-ID: <e7229067-71e5-0b1c-fd46-acd5a64ecc2b@linaro.org>
Date:   Mon, 17 Oct 2022 16:14:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] thermal/drivers/exynos: Fix NULL pointer dereference when
 getting the critical temp
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>, rafael@kernel.org
Cc:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "open list:SAMSUNG THERMAL DRIVER" <linux-pm@vger.kernel.org>,
        "open list:SAMSUNG THERMAL DRIVER" 
        <linux-samsung-soc@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <4e4d873b-4a40-334a-34e7-defb0fcc4e6b@samsung.com>
 <CGME20221003133014eucas1p1fe47bf216e05f96e946c7dcc5fc7eea9@eucas1p1.samsung.com>
 <20221003132943.1383065-1-daniel.lezcano@linaro.org>
 <1155a694-b821-d41a-da54-8a9656d90e50@samsung.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1155a694-b821-d41a-da54-8a9656d90e50@samsung.com>
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

On 17/10/2022 15:48, Marek Szyprowski wrote:
> Hi Daniel,
> 
> On 03.10.2022 15:29, Daniel Lezcano wrote:
>> The driver is assuming the get_critical temperature exists as it is
>> inherited by the thermal of ops. But this one has been removed in
>> favor of the generic one.
>>
>> Use the generic thermal_zone_get_crit_temp() function instead
>>
>> Fixes: 13bea86623b ("thermal/of: Remove of_thermal_get_crit_temp(")
>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> This patch has been dropped from -next, is there are reason for that?

No, my mistake. I dropped it accidentally when I rebased the branch.

Thanks for pointing it out.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
