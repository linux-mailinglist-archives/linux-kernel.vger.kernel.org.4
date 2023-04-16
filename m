Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4736E3919
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 16:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjDPOOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 10:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjDPOOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 10:14:08 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C972B26AE
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 07:14:04 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a5so1071096ejb.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 07:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681654443; x=1684246443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CqjZpfyKPAXa2my2S9Kqm0ywJgkkRuAyH0u0+ZgWeBo=;
        b=j4GkOa4aNXRE+r4a4/nRTgrCWkl7MYHpNnYSl0JUMuXQMFmbIBleGTKd4PpQexnVfb
         ybv3marMchyBRQjoztB01LrSlUdnNIgEC2ZRC9/I9vufBTND2fzAkZTAK27uji8UbvVN
         eXR7Vj1YD0XwMQTYaih7Z7jTeVysyDnc2M/CwTZYD7pe01ug16FiAD3Excw0mMBKNXxE
         ZLVfBxHmOA3nj0qVdBkY6gXLPmuqkoPl62SIH8BJpmyd/dkWX6gNXzS9gq9SWdgsZX6a
         WW3kWlsSnOis2a9y4OWL5EztRceKZZ4dk438V1Mjju23FydTqMpKSxldchxID3YY+pFo
         zGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681654443; x=1684246443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CqjZpfyKPAXa2my2S9Kqm0ywJgkkRuAyH0u0+ZgWeBo=;
        b=KNOb1bxm7uZKWmd89Pq2SN8CcUdPHtNWAfWJqSAJ5aEoouP9wt0e9vSyQBY+OHpEr3
         1NpixZB4mDUFNOAl/c9QJ30dVPDZeUWG/7r2qk+UpwJvApFgEVfVtKXBPjkWzzvclv2V
         2rMPdk74KVINO7kmgvpSl4gKa+8Zna5A4N2eMxP2EGkQWI/FKJHZdeahqXL6VburLX+b
         CAgV5riERwomuxusrCG1B4ts8xosk2RxHTCh+MJWAiOBQ84SdDMOyfWJo7lvIFVQZ3cM
         8r1PoC5q0mK+NuZq4StrsZyLWgikC4g1WizCsDjFViYmrd1tMp0/WOJfqMBOha7ywUeL
         EBuA==
X-Gm-Message-State: AAQBX9dj1CnZ7LQKXud/oAdoMCcggUaSPxpSvZOOloqAnxOqId/EtvOw
        y9z0P47MfZSlFqqn8h9bcVaN2w==
X-Google-Smtp-Source: AKy350ayEmg9ZXfl/HB5LQ9Hom4UKULeEgkxZWgCAIx/UHNm3rrpWuZPfU3gw9Fv1tjxFQ4I1e04Cw==
X-Received: by 2002:a17:906:6091:b0:94c:93e4:b0c with SMTP id t17-20020a170906609100b0094c93e40b0cmr4922508ejj.76.1681654443262;
        Sun, 16 Apr 2023 07:14:03 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ba4d:301c:484d:5c9? ([2a02:810d:15c0:828:ba4d:301c:484d:5c9])
        by smtp.gmail.com with ESMTPSA id ce18-20020a170906b25200b0094ee2b8ab77sm3589650ejb.73.2023.04.16.07.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 07:14:02 -0700 (PDT)
Message-ID: <421f998a-8d66-d333-4e41-58a74bc687e9@linaro.org>
Date:   Sun, 16 Apr 2023 16:14:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 00/12] Re-introduce Exynos4212 support and add Samsung
 Galaxy Tab 3 8.0 boards
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
References: <20230416133422.1949-1-aweber.kernel@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230416133422.1949-1-aweber.kernel@gmail.com>
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

On 16/04/2023 15:34, Artur Weber wrote:
> This patches re-introduces the Exynos4212 platform and adds support
> for the Samsung Galaxy Tab 3 8.0 series of tablets that uses it:
> 
>  - Samsung Galaxy Tab 3 8.0 WiFi (SM-T310/lt01wifi)
>  - Samsung Galaxy Tab 3 8.0 3G (SM-T311/lt013g)
>  - Samsung Galaxy Tab 3 8.0 LTE (SM-T315/lt01lte)
> 
> What works:
> 
>  - Display and backlight
>  - Touchscreen (without touchkeys)
>  - GPIO buttons, hall sensor
>  - WiFi and Bluetooth
>  - USB, fuel gauge, charging (partial)
>  - Accelerometer and magnetometer
>  - WiFi model only: light sensor
> 
> Display panel bindings used by the Tab3 DTSI are added in a separate
> patchset - "[PATCH 0/3] Add Samsung S6D7AA0 panel controller driver":
> https://lore.kernel.org/all/20230416131632.31673-1-aweber.kernel@gmail.com/
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> 
> Changed in v2:
>  - Added note about display panel bindings to cover letter and
>    Tab3 DTSI commit

That's not really a reason for resend and you explained me the bindings.
Wait for at least a day before sending big patchsets, to get a chance of
review.

Best regards,
Krzysztof

