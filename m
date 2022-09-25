Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6975E91A5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 10:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiIYIUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 04:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiIYIUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 04:20:49 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B99629831
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 01:20:46 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id d12-20020a05600c3acc00b003b4c12e47f3so2086238wms.4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 01:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=3f7xryob0fjp6E4pNLcCzs6IRZqkpNTpwM4Ki3mJWfc=;
        b=tKILDON0dYSkuS1KXcE9usQK+2lgvJ4U5Vi7MJ7mSJ1DGm0pKT/ZESeve4LOnEK8pz
         szirFAU0vYZBagmvdZ0t53biGOBPwzcYEqFr6BsOkqpB4J3fnuV1avWQwkXWMYRBUtY+
         LAHXwtr6FldJ9igXbF48vr5wDo48XC1mvOm/ELILJBxkWeauPkrKCaNfTdtVDEBDpGAH
         oKbxQnaYZvuwKvqTcVvmDMoVYWZ8HIsDYiP/TMlMmb0KjcJo8kPhagrKqYInZFsb8Pxz
         PJaLoDeoUJYmgq4LiqELDdZHPiBQZSl5tTY9hQYBC/PfyjIo7hHqBogF07l7vrrYHFaq
         cfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3f7xryob0fjp6E4pNLcCzs6IRZqkpNTpwM4Ki3mJWfc=;
        b=RwDyc1QSwKeK+bqODafZh/+/OgxoUuYmugWmh7dFCAhefQ/ca0mLdH3tsbtWsFI6DE
         4n9Y8xl9Y2c4t5Q+Paoih4Wvl2OgVTbus0kTnbIxAaFku+XrmQUrDhFSagcTo6Whpk5r
         15ch6BDmS+dCFv+fneWb68YXEHrTLW8n5uZRb+iTI6wFhtgBbrzloy0nMaL8dNGZX007
         8WZyUBnWk4NbnjHwDFH/ZknHepPlizZ/nJva29x95RUzvyUH2CIHE32WRNcTVwE7Wyk8
         HjH6bBM2AHoHavwD8TATkXh4B24V8Jc6fuafABXRe6RklzDnrtT36f+8l5YXF6WGuKI8
         WbpQ==
X-Gm-Message-State: ACrzQf30ZfA1Y0NmFCgecSohjZ+YhNtEwobw7ItKOU8ahXWsyNWojsvu
        rUpzWaKMIy9/RPY2CuLzu1sfzw==
X-Google-Smtp-Source: AMsMyM4cqxu5WJGMnD/9bR1PxxPIazd9fL7WS6iN33LiqEvKrjfIVowpwiRISp5yWEonAQq1k5kbug==
X-Received: by 2002:a05:600c:4e8b:b0:3b4:c8ce:be87 with SMTP id f11-20020a05600c4e8b00b003b4c8cebe87mr19206401wmq.157.1664094044671;
        Sun, 25 Sep 2022 01:20:44 -0700 (PDT)
Received: from [192.168.0.20] (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.gmail.com with ESMTPSA id x12-20020adfffcc000000b0022ac672654dsm11225689wrs.58.2022.09.25.01.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 01:20:43 -0700 (PDT)
Message-ID: <9db42de1-50c4-8738-6d8b-774cc6d5756e@baylibre.com>
Date:   Sun, 25 Sep 2022 10:20:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 1/1] arm64: dts: mediatek: mt8183: disable thermal
 zones without trips.
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        daniel.lezcano@linaro.org
References: <20220921-mt8183-disables-thermal-zones-up-v2-0-4a31a0b19e1e@baylibre.com>
 <20220921-mt8183-disables-thermal-zones-up-v2-1-4a31a0b19e1e@baylibre.com>
 <a5838d66-21dc-4905-03c5-ea049e3bd055@linaro.org>
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
In-Reply-To: <a5838d66-21dc-4905-03c5-ea049e3bd055@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 9/25/22 09:57, Krzysztof Kozlowski wrote:
> On 21/09/2022 11:05, Amjad Ouled-Ameur wrote:
>> Thermal zones without trip point are not registered by thermal core.
>>
>> tzts1 ~ tzts6 zones of mt8183 were intially introduced for test-purpose
>> only.
>>
>> Disable the zones above and keep only cpu_thermal enabled.
> Please test your patches before sending upstream. :(
My apologies for the inconvenience, I mistakenly missed the error,

will send a proper V3.


Regards,

Amjad

> Best regards,
> Krzysztof
>
