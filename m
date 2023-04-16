Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5636E382D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 14:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjDPMmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 08:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjDPMmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 08:42:21 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61061199E
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 05:42:19 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id sz19so202804ejc.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 05:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681648937; x=1684240937;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Stybf3H9Q45miG2lE4UZ2skOoton8ZUstQqbtnIu+I=;
        b=NGT0AtxQb+GWXTEwUxWLwQnDvnLlI3pfnsRfizmW84NIuRsHvTHhRn9R3eioHmpgXz
         vnqwp7YDdNb2q9mTkusj990j0bOCj62v17YX7rVOy0z+ig7nH6WhHKvPqB5FBe8Mso/J
         NR/JsI8ha/nP2HbRhG4edc7ERoIXrXQaBljwyG6ScQifnYwycKYabnP+/54g7VzqvDsl
         fTmcjlV3GJKzcvQQOzKUG6ObNhzYZBBuXB1lljTNpeAKXgMAr4O391eSLeSKOEtnUA8n
         JRGSY/rKo2fB38hwLyF7u568/jDu0avnzZTmGk7bcnVrQMKBkxvRabGIphQBb8xDlEIi
         dNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681648937; x=1684240937;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Stybf3H9Q45miG2lE4UZ2skOoton8ZUstQqbtnIu+I=;
        b=Uk9YKnxFlUDC5Ygt/ak3MDpJFgb6FgE4n5B6KkcivSSWQgSw1ptTqUuvhi4zT1eGNX
         pOHcI2aRjF6sy5QgwLftSH6UHkUUl9dUwGho4tJPehOM2S/oE2p9gIEyAVC7CcbnNvD8
         Gl4zdHyYPXi0iUu3C9Rj793xDUMNsMe0yiY0j4e8awp8PXMDrS11x4/uIfmrKFwIQq7D
         kWMvTsrPG69u+ehcW44On7/qYdzSKra3hOup8B4VCKOajJBnTYcsgt2EAET8OIw4NV4R
         l54PdeMxoVx3OaeZqHNnfD/cZYoDR6PIsHCvbIFYYLQn54ba7+yyEU9X8l5j0Dik1Gs+
         aQTg==
X-Gm-Message-State: AAQBX9dWN6BdYWEHO+BUKqwzaa0zdorONPVjHJf0JtI4rI9MXmJUEhDj
        sh1faHwH5rEZ6ONxiElTOC8n/A==
X-Google-Smtp-Source: AKy350ZZACWSXc/ruWCfjbW+QzpyKWJt4AoW9nPZTPV9iuhQ5pbR9y/19DYYC0FEWFU7sykL/wTPMQ==
X-Received: by 2002:a17:907:2c4f:b0:94a:5d16:a280 with SMTP id hf15-20020a1709072c4f00b0094a5d16a280mr4003531ejc.9.1681648937669;
        Sun, 16 Apr 2023 05:42:17 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:29dd:ded4:3ccc:83db? ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id wz9-20020a170906fe4900b0094ee6b963e0sm3434174ejb.60.2023.04.16.05.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 05:42:17 -0700 (PDT)
Message-ID: <e50f5980-b1f6-4495-08b7-7e3f4f78cc67@linaro.org>
Date:   Sun, 16 Apr 2023 14:42:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 00/12] Re-introduce Exynos4212 support and add Samsung
 Galaxy Tab 3 8.0 boards
Content-Language: en-US
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-phy@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230416101624.15866-1-aweber.kernel@gmail.com>
 <3e513119-4d6a-18ec-aaec-1c6b2b7e35b4@gmail.com>
 <ba148e6c-1685-f6d4-458f-bbdf1dd674cf@linaro.org>
 <36287654-c6e6-f4bd-320c-866bef692d2f@gmail.com>
 <d0b2868f-cade-feb1-52cd-2aacd537c9c6@linaro.org>
 <8bb6e9a6-0143-3627-14c4-285ce2632070@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8bb6e9a6-0143-3627-14c4-285ce2632070@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2023 14:37, Artur Weber wrote:
> On 16/04/2023 12:53, Krzysztof Kozlowski wrote:
>> On 16/04/2023 12:49, Artur Weber wrote:
>>> On 16/04/2023 12:34, Krzysztof Kozlowski wrote:
>>>> On 16/04/2023 12:26, Artur Weber wrote:
>>>>> On 16/04/2023 12:16, Artur Weber wrote:
>>>>>> This patches re-introduces the Exynos4212 platform and adds support
>>>>>> for the Samsung Galaxy Tab 3 8.0 series of tablets that uses it:
>>>>>>
>>>>>>     - Samsung Galaxy Tab 3 8.0 WiFi (SM-T310/lt01wifi)
>>>>>>     - Samsung Galaxy Tab 3 8.0 3G (SM-T311/lt013g)
>>>>>>     - Samsung Galaxy Tab 3 8.0 LTE (SM-T315/lt01lte)
>>>>>>
>>>>>> What works:
>>>>>>
>>>>>>     - Display and backlight
>>>>>>     - Touchscreen (without touchkeys)
>>>>>>     - GPIO buttons, hall sensor
>>>>>>     - WiFi and Bluetooth
>>>>>>     - USB, fuel gauge, charging (partial)
>>>>>>     - Accelerometer and magnetometer
>>>>>>     - WiFi model only: light sensor
>>>>>
>>>>> This patchset depends on "[PATCH 0/3] Add Samsung S6D7AA0 panel
>>>>> controller driver" for the display panel support for the Samsung Galaxy
>>>>> 3 8.0 boards.
>>>>
>>>> Why? DTS and ARM code cannot depend on driver changes. Please rework
>>>> your patchsets to remove any of such dependencies.
>>>
>>> Ah, that makes sense. I'll re-send the patchset in a second with the
>>> panel node removed.
>>
>> I am sorry, I don't understand. Why would you remove anything from DTS?
>> Are bindings NAKed?
> 
> The dependency display panel patchset introduces the panel and its 
> bindings, which in turn are included in the Tab3 DTSI. It was submitted 
> at roughly the same time as this series, and hasn't been fully reviewed 
> or merged as of writing. (I have seen your comments on that patchset, 
> and I will be addressing them shortly.) So the bindings haven't been 
> explicitly ACKed yet (assuming you mean the Acked-by reply).

So there is no dependency. DTS is (and must be) independent of driver.
You need to mention in the patch (under --- ) or cover letter that it
uses new bindings which are documented under the given link.

> 
> In response to:
> 
>  > Please rework your patchsets to remove any of such dependencies.
> 
> I suggested that I could remove the panel node from the DTSI for the 
> time being. The intent was to submit it in a separate patch later, once 
> the display is reviewed/merged, and thus actually available in the 
> kernel; this way, the two patches could be reviewed and merged separately.

No need, there is no dependency. Just remove such remarks from cover letter.


Best regards,
Krzysztof

