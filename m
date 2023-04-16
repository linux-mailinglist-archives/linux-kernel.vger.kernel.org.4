Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BE76E3790
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 12:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjDPKxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 06:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjDPKxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 06:53:20 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CBC2689
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 03:53:18 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ud9so56716659ejc.7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 03:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681642397; x=1684234397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ouacL5jzwqdrqc6h6cItWvGdIc1UJBQ5F31zwjpSlE=;
        b=ySR9w98P8RnXzxDyjT5uqepX//GbkqEGw5tC571tl0ZdhTXPQQcvJP7AgNxP3neV9P
         TUrP0pJcjwpwNyjp6mpS6tPz2rTywKDvBijjxzSescmDF7HJHCwc8m2mStVWnb8TKbEE
         nu5SA27QGxsybnotK16UiRK5mGrc608EqMjJ6jxME5EtP3rb3yx8/WkZKy1AMRRkdvf7
         UtyMxDuCF32w7IRYMcYRULAceslZlfudSH6sxwzy88KJx/r2mjfWNoBFMfxwXIn4AVQs
         /OF4CSYzEyPpdE0bElp8yyr8ISlrXyZhbehmQ8O1MxpPKUtIdtUu19Mcm2kL8j92KFdh
         MkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681642397; x=1684234397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ouacL5jzwqdrqc6h6cItWvGdIc1UJBQ5F31zwjpSlE=;
        b=Kohl4UlUJBEIQnlGsKHMS+1CPJLQMgAdGnjmRdvVL1hF4JljunVE2fFwQQIBnRoGKq
         WipY5tIoiGxTQ39XhDvzFj0+IYGVyCgm4iglXHeO/XUyZ8z2sSsio3h5qaSnY0JhuQkm
         72whJU5iQjce9YckY4x5IUBWswUTwn6yvSmVpGMCLNbvEh0BGlXshGgwx5r8fcgR4XlM
         Vpm9cNyKAN2D+BkclKmC/mJENBplg04uhqSa5XidIfBsA78Nl3SqNO1XtSdnjUl6iMme
         y1UvRtHNtHOAHCFM2CBZwLLuApS0c4BR5kp0EWRb0ZbcX7+LqVYnpOgg5yz0YPHP1rWj
         FHjg==
X-Gm-Message-State: AAQBX9epg6RGLXqQnfnu7n8CT2OoPASVidSQG0kmXT9MYZS4n6pYv/Ay
        HURhJ5GsHXjO8dlcdRBbvncT+g==
X-Google-Smtp-Source: AKy350YiRHdtMmcT7j7PJPXYEMEyZ4e1Bw1LhCILnCce78Lp2xLtZeLuqXkwcSyY8+YlACLr4t7D3Q==
X-Received: by 2002:a17:906:f14f:b0:94a:171:83b1 with SMTP id gw15-20020a170906f14f00b0094a017183b1mr4650225ejb.2.1681642397392;
        Sun, 16 Apr 2023 03:53:17 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:29dd:ded4:3ccc:83db? ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id qw24-20020a170906fcb800b009353066595csm4913522ejb.136.2023.04.16.03.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 03:53:17 -0700 (PDT)
Message-ID: <d0b2868f-cade-feb1-52cd-2aacd537c9c6@linaro.org>
Date:   Sun, 16 Apr 2023 12:53:15 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <36287654-c6e6-f4bd-320c-866bef692d2f@gmail.com>
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

On 16/04/2023 12:49, Artur Weber wrote:
> On 16/04/2023 12:34, Krzysztof Kozlowski wrote:
>> On 16/04/2023 12:26, Artur Weber wrote:
>>> On 16/04/2023 12:16, Artur Weber wrote:
>>>> This patches re-introduces the Exynos4212 platform and adds support
>>>> for the Samsung Galaxy Tab 3 8.0 series of tablets that uses it:
>>>>
>>>>    - Samsung Galaxy Tab 3 8.0 WiFi (SM-T310/lt01wifi)
>>>>    - Samsung Galaxy Tab 3 8.0 3G (SM-T311/lt013g)
>>>>    - Samsung Galaxy Tab 3 8.0 LTE (SM-T315/lt01lte)
>>>>
>>>> What works:
>>>>
>>>>    - Display and backlight
>>>>    - Touchscreen (without touchkeys)
>>>>    - GPIO buttons, hall sensor
>>>>    - WiFi and Bluetooth
>>>>    - USB, fuel gauge, charging (partial)
>>>>    - Accelerometer and magnetometer
>>>>    - WiFi model only: light sensor
>>>
>>> This patchset depends on "[PATCH 0/3] Add Samsung S6D7AA0 panel
>>> controller driver" for the display panel support for the Samsung Galaxy
>>> 3 8.0 boards.
>>
>> Why? DTS and ARM code cannot depend on driver changes. Please rework
>> your patchsets to remove any of such dependencies.
> 
> Ah, that makes sense. I'll re-send the patchset in a second with the 
> panel node removed.

I am sorry, I don't understand. Why would you remove anything from DTS?
Are bindings NAKed?

Best regards,
Krzysztof

