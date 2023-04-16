Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BC46E3810
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 14:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjDPMhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 08:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjDPMhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 08:37:05 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8382D40;
        Sun, 16 Apr 2023 05:37:04 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id xd13so23346093ejb.4;
        Sun, 16 Apr 2023 05:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681648624; x=1684240624;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VDa2GFtYkfWVlc8ZTMskD2bfRssb3+wPHR9VnWdgQkk=;
        b=Ye4lxVUXva7hfPvirb5EICjV7mvCIR+LZoN3QkH/Aa9mcMNRKXRHXY7XX9YxfQiM4d
         UHF+N75fqf6yWUywGE72iYA9LGogaxALspplCNngKKlCEiNB/KHmYLhX5s9kFNdrJlgm
         Ps5No9KHIl4sEN/LvkdFDyEuljHQ2Yb4FiMA1QptZREt1Bp0QkaLum68LKPqGSisGWmj
         02RcdFqsq/361uqczbuNL3um2U2cyI0NQiD7Oc40B1PwxsMYtEbKZYmC5yPD3d1E2/Ce
         TzkSQIRiqBSrM/faDZ7/OC9IJha+EfIshOaH1OD3tv+CNbl5x1Wr5b1zwVnYnEvDen3x
         FaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681648624; x=1684240624;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VDa2GFtYkfWVlc8ZTMskD2bfRssb3+wPHR9VnWdgQkk=;
        b=Z1hVKdWL6mcmQiAcTWG7ZSqXu4ypa/OHCRM3SiGO1/SE0HUojNJdQTmW9OzR5nZAzU
         yPy25ESlFFyu474/PVpYUe65AhBojgSp5I8ERpR2aQnlrTAzD+9CNUBmSYwuW9Mmgyak
         RUm0zAvitYy4vumWkoUtPdd53TPHRqZeolzwiZDdQxqWJU/WzZuC7FqvfvDZnq49O2mF
         Bz5ZpFYwDS0Q76y4PT0sFEPW5M9acX135DGNG99MQGk+AdSiyLDNdBus4lSHo2FwEaqX
         HBCD5UM5OJIKoa9k16S8InRTM8XlQjjQ+iL1IYvU+wiobVfPf2LryMz/9k3W8+AVcGgq
         6Ajw==
X-Gm-Message-State: AAQBX9eJHJLJCH9GjNjX9G2Jrn27Nc5b0UMl2wwIo1HqvqMkxGGvGgup
        yqnTGXBLnsaXXS0tDpo1z5s=
X-Google-Smtp-Source: AKy350Z9RmwvdFDkqAGZQeSDhkrMeMTMfOfNN8b8VmhaRJ5qZRpnoXUSxR2zWJy9cKGKUWb33636uQ==
X-Received: by 2002:a17:906:82c5:b0:93f:2256:fc05 with SMTP id a5-20020a17090682c500b0093f2256fc05mr4820249ejy.55.1681648624015;
        Sun, 16 Apr 2023 05:37:04 -0700 (PDT)
Received: from [192.168.50.244] (83.8.121.70.ipv4.supernova.orange.pl. [83.8.121.70])
        by smtp.gmail.com with ESMTPSA id i3-20020a1709061e4300b0092b8c1f41ebsm4999772ejj.24.2023.04.16.05.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 05:37:03 -0700 (PDT)
Message-ID: <8bb6e9a6-0143-3627-14c4-285ce2632070@gmail.com>
Date:   Sun, 16 Apr 2023 14:37:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 00/12] Re-introduce Exynos4212 support and add Samsung
 Galaxy Tab 3 8.0 boards
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
From:   Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <d0b2868f-cade-feb1-52cd-2aacd537c9c6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2023 12:53, Krzysztof Kozlowski wrote:
> On 16/04/2023 12:49, Artur Weber wrote:
>> On 16/04/2023 12:34, Krzysztof Kozlowski wrote:
>>> On 16/04/2023 12:26, Artur Weber wrote:
>>>> On 16/04/2023 12:16, Artur Weber wrote:
>>>>> This patches re-introduces the Exynos4212 platform and adds support
>>>>> for the Samsung Galaxy Tab 3 8.0 series of tablets that uses it:
>>>>>
>>>>>     - Samsung Galaxy Tab 3 8.0 WiFi (SM-T310/lt01wifi)
>>>>>     - Samsung Galaxy Tab 3 8.0 3G (SM-T311/lt013g)
>>>>>     - Samsung Galaxy Tab 3 8.0 LTE (SM-T315/lt01lte)
>>>>>
>>>>> What works:
>>>>>
>>>>>     - Display and backlight
>>>>>     - Touchscreen (without touchkeys)
>>>>>     - GPIO buttons, hall sensor
>>>>>     - WiFi and Bluetooth
>>>>>     - USB, fuel gauge, charging (partial)
>>>>>     - Accelerometer and magnetometer
>>>>>     - WiFi model only: light sensor
>>>>
>>>> This patchset depends on "[PATCH 0/3] Add Samsung S6D7AA0 panel
>>>> controller driver" for the display panel support for the Samsung Galaxy
>>>> 3 8.0 boards.
>>>
>>> Why? DTS and ARM code cannot depend on driver changes. Please rework
>>> your patchsets to remove any of such dependencies.
>>
>> Ah, that makes sense. I'll re-send the patchset in a second with the
>> panel node removed.
> 
> I am sorry, I don't understand. Why would you remove anything from DTS?
> Are bindings NAKed?

The dependency display panel patchset introduces the panel and its 
bindings, which in turn are included in the Tab3 DTSI. It was submitted 
at roughly the same time as this series, and hasn't been fully reviewed 
or merged as of writing. (I have seen your comments on that patchset, 
and I will be addressing them shortly.) So the bindings haven't been 
explicitly ACKed yet (assuming you mean the Acked-by reply).

In response to:

 > Please rework your patchsets to remove any of such dependencies.

I suggested that I could remove the panel node from the DTSI for the 
time being. The intent was to submit it in a separate patch later, once 
the display is reviewed/merged, and thus actually available in the 
kernel; this way, the two patches could be reviewed and merged separately.

I could instead wait for the display patchset to get reviewed/merged 
first, then resubmit this series, if that's preferable.

I apologize for the confusion.

Best regards,
Artur Weber

