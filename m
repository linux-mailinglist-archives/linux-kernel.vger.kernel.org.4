Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB576E377B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 12:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjDPKfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 06:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjDPKe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 06:34:59 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB791BE2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 03:34:57 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-94a342f7c4cso524839566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 03:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681641296; x=1684233296;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oThM9IADx5S8GurQFnUC5Iudz8a82Ypmc1jPK7EMt28=;
        b=ojsL8rvxTKjkZ3105QQ6qMpe909jhc5eSavPPOPpTnGmPG3+UETC9x2kSBwk+kxBak
         hPE9Vp4Oll90PdjOzUdkRMk130wHf41avhU/MgtP+A9UilsLqMpmIF3pOW9wmmhs/nYx
         Abzva2M7DoABQkkxTw8FImLZJI7a6XZN+FtlFIP6TDsA4t8FPZNUWQ+BHN555glXUdGt
         V8oRqyRrs8LVJc5HBDxTs5hWYKFbuQlPV1ODN+bqee/uC+9eKdN8NfOUmtZcbbfPlatZ
         moXRSEmtJbKOnRBScf1hTSjzaLOJkqliRLaB7N9g3yI+1ujsz5tQkmG6r7p+/xPj1lVh
         CgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681641296; x=1684233296;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oThM9IADx5S8GurQFnUC5Iudz8a82Ypmc1jPK7EMt28=;
        b=QzFGFzZm53eM+YSbuxEGlmL8BGDkR44eA9OOu0kELcxNGzR61aR69srEDJXqb1Eofe
         Cs2XclkQtZZzDW9abrsk30cEgw6q+6900mweqbQ/tBzNaHCw04ZQMYVka5kT9eLVHCkJ
         escjiVqafv0ANYECGiVPn4TT1sMRS7aZDJVeIBxZ6elrUCU29HXyODz5Hd8nLzBVvJyr
         NNO7ikY0mHa2v6L6ci1nNdrCO2tp/UyuRqd/8DaaArHqqJihxvFoFO54ZhurDy3mLmvU
         AvvH0CS38d+mGep1EtfizTAIXz8heQOoA7oodnvnkx93oRbC7g3SCeFnAuFv0BatTGLU
         VdMw==
X-Gm-Message-State: AAQBX9fWlHIMlrKZbLWVLjLUjSL3MvA3u8bKrEHRMgIptasC6W6e84iM
        ml0oQaaEnFm7P+kBhjAVZ90EuA==
X-Google-Smtp-Source: AKy350Z0EYHAjycSnA/78baWXdJiAPBIp74WUoY2hN5f7HmirWp3PlBkc720nyajl9PAE44hpfE7Ng==
X-Received: by 2002:a05:6402:2d0:b0:502:7767:3c73 with SMTP id b16-20020a05640202d000b0050277673c73mr10051680edx.22.1681641295977;
        Sun, 16 Apr 2023 03:34:55 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:29dd:ded4:3ccc:83db? ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id o23-20020aa7dd57000000b005047847d3e5sm4364064edw.36.2023.04.16.03.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 03:34:55 -0700 (PDT)
Message-ID: <ba148e6c-1685-f6d4-458f-bbdf1dd674cf@linaro.org>
Date:   Sun, 16 Apr 2023 12:34:53 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3e513119-4d6a-18ec-aaec-1c6b2b7e35b4@gmail.com>
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

On 16/04/2023 12:26, Artur Weber wrote:
> On 16/04/2023 12:16, Artur Weber wrote:
>> This patches re-introduces the Exynos4212 platform and adds support
>> for the Samsung Galaxy Tab 3 8.0 series of tablets that uses it:
>>
>>   - Samsung Galaxy Tab 3 8.0 WiFi (SM-T310/lt01wifi)
>>   - Samsung Galaxy Tab 3 8.0 3G (SM-T311/lt013g)
>>   - Samsung Galaxy Tab 3 8.0 LTE (SM-T315/lt01lte)
>>
>> What works:
>>
>>   - Display and backlight
>>   - Touchscreen (without touchkeys)
>>   - GPIO buttons, hall sensor
>>   - WiFi and Bluetooth
>>   - USB, fuel gauge, charging (partial)
>>   - Accelerometer and magnetometer
>>   - WiFi model only: light sensor
> 
> This patchset depends on "[PATCH 0/3] Add Samsung S6D7AA0 panel 
> controller driver" for the display panel support for the Samsung Galaxy 
> 3 8.0 boards.

Why? DTS and ARM code cannot depend on driver changes. Please rework
your patchsets to remove any of such dependencies.

Best regards,
Krzysztof

