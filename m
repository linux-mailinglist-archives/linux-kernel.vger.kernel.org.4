Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE2D6E3787
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 12:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjDPKuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 06:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjDPKuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 06:50:00 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45C91FFD;
        Sun, 16 Apr 2023 03:49:57 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id xd13so22986367ejb.4;
        Sun, 16 Apr 2023 03:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681642196; x=1684234196;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BibkchVpgNQZFLMyVpH9dMmq5gXEMqLoVYGl24gL/LE=;
        b=FNmxjCNuVJEW1wzbJhBhNa4rhwTePIcUwtK1gGe+SxlYGVzzIfN2NhGydt7BZD0p2h
         0FXzUOln5q8tn9q2Txy8735GhUI9pzTyPx85OgW7CUhCSVvF98P5noDuzGAPlGu6qRY1
         LYLnALhNEoaHZ+POCl/HiYCXZ7jg3YWwYpi2i73N67gYGoe3u0veQGoRUQN7V2RnWexA
         ohDhgvxruBJC2kNmI/J05a0LAEuBCkU+wJb01kQ8cqckZHS96Nl+PXccv9EH8iN2nNe8
         CTIi1O2LApEAJN95m8QezV4pcPJ89tBH+4LYKLMW6a3ZwfCDM0LKNBWH+cIasKhYX8uD
         aFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681642196; x=1684234196;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BibkchVpgNQZFLMyVpH9dMmq5gXEMqLoVYGl24gL/LE=;
        b=hbCMI89pZc83Rsi0IsaBYl87H0fPthGs4+dSfBgjnOT5zArBDkHSCbL4e5ihMIZR54
         l2rLtnMiBMnA5oz6ulZN+2QKizZoPkzqN6lvdHnKEAL1yAtVc1e6um4NQ8lrDFzPtVI7
         pyNTksITEwBe7M5pq4Gu7B4yIAbUg63WYXgpYlcFqeUo+xkR/+ELPMBVBTAwaHAoXCzI
         wa6GtJABdYfiAcj45Ah8nFsm8jax/NNN5G2mMBalrqonYJNOwpq4KouGvbUBokXTI6Fe
         jkL++CkJysgfP0w6Hk3u8Propw69T3aW3UzkL/4w+WhoQVKoHQDrtyVK/t+uYECNHh+z
         X0WQ==
X-Gm-Message-State: AAQBX9cceU0Eu2ptceO9NdqUswre38yPe4sRNDzCiSVDmZfl+4pP51vV
        Dyakowzc9R4Tp11reVk/OLE=
X-Google-Smtp-Source: AKy350b3gK1lQb0qbsz4ilgiLjCfmtji8PDJG74IvoKxlOG8p+9hOgmdVoSmln/+2mWbUc32g9X/ow==
X-Received: by 2002:a17:906:5384:b0:94e:c306:f42f with SMTP id g4-20020a170906538400b0094ec306f42fmr3610946ejo.16.1681642196157;
        Sun, 16 Apr 2023 03:49:56 -0700 (PDT)
Received: from [192.168.50.244] (83.8.121.70.ipv4.supernova.orange.pl. [83.8.121.70])
        by smtp.gmail.com with ESMTPSA id yk17-20020a17090770d100b0094f442c6399sm937253ejb.90.2023.04.16.03.49.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 03:49:55 -0700 (PDT)
Message-ID: <36287654-c6e6-f4bd-320c-866bef692d2f@gmail.com>
Date:   Sun, 16 Apr 2023 12:49:53 +0200
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
From:   Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <ba148e6c-1685-f6d4-458f-bbdf1dd674cf@linaro.org>
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

On 16/04/2023 12:34, Krzysztof Kozlowski wrote:
> On 16/04/2023 12:26, Artur Weber wrote:
>> On 16/04/2023 12:16, Artur Weber wrote:
>>> This patches re-introduces the Exynos4212 platform and adds support
>>> for the Samsung Galaxy Tab 3 8.0 series of tablets that uses it:
>>>
>>>    - Samsung Galaxy Tab 3 8.0 WiFi (SM-T310/lt01wifi)
>>>    - Samsung Galaxy Tab 3 8.0 3G (SM-T311/lt013g)
>>>    - Samsung Galaxy Tab 3 8.0 LTE (SM-T315/lt01lte)
>>>
>>> What works:
>>>
>>>    - Display and backlight
>>>    - Touchscreen (without touchkeys)
>>>    - GPIO buttons, hall sensor
>>>    - WiFi and Bluetooth
>>>    - USB, fuel gauge, charging (partial)
>>>    - Accelerometer and magnetometer
>>>    - WiFi model only: light sensor
>>
>> This patchset depends on "[PATCH 0/3] Add Samsung S6D7AA0 panel
>> controller driver" for the display panel support for the Samsung Galaxy
>> 3 8.0 boards.
> 
> Why? DTS and ARM code cannot depend on driver changes. Please rework
> your patchsets to remove any of such dependencies.

Ah, that makes sense. I'll re-send the patchset in a second with the 
panel node removed.

Best regards
Artur Weber

