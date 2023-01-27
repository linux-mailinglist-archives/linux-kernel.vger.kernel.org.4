Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3C867E06F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbjA0Jid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbjA0Jib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:38:31 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7742CC67
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 01:37:56 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id y1so4425406wru.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 01:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yksAV7yHL3wN3w9c8k40mCMMPiyV1hd99TyFgaBpDUE=;
        b=Q1IgsFXQgA4vRbKnGHEV09YcIKYNHOU6wbfDCYOa/8oRhBoDcw6DOo3ZtKEAlh/hVz
         DJXrF3MPff5EwbaLVr5ax7Z1ASkgVRgaqhrum6TGTC4BF4AzSIDJb3HMsnFv3BL0KI6/
         hDyRGvdPoXOnHloSa515sLqxxEYhkDAy5I3adl8lqK6S6sLoLLXSpvC4rxcCWqU2ePVU
         g4M/iYrz5B1PflrG4UZ8+Cg4sFR761tiBYlxlG4aqy9XJdeCYl+0isoKHa/U8upK4wMy
         xZmtzVlG9Z1mYf0Zgf3inLuQupaVfE7vsRrndR0C/EA1zbyvM6leuc7wKxEh9L+cR0JY
         QEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yksAV7yHL3wN3w9c8k40mCMMPiyV1hd99TyFgaBpDUE=;
        b=xrfbF8EVbOKyrynrlYetv5yyJr4GbtzftrUdrWwUZKvsI4tFr6WLk/YOScQyNFiMrd
         /bWFi7siSQGoy4ORhJhH6X4I/Xt7CCv8YsuvIAnZ39+t2Ms8dGXWFfaVxtje9mwXkUbl
         4gGM6LEWnWOO6WS5HLXOB8VYQbDn3wZZAG1ngivv3RSCPVQ/eR3PoZtvQR4lXftj8cUc
         enPlf+YhQTy1rNlGkrmPh18tko+riOMXZrdTWbkcGQjlMxCReb3ni4r35ZnpSGW29FpT
         LOpcZPA7PVwroxpsaSJfkz3F3mhi+lc3OvBXwI/shvFA6cvwuINCmJeVd3LfDQe1koLF
         fcCw==
X-Gm-Message-State: AO0yUKX6E3zVIraLjvgy7RZ9xWjPZYhfOJZGUbXG3IGRj0uovwO32IjX
        G1kWw/ClfJHLXJjubKnQKdZihw==
X-Google-Smtp-Source: AK7set88fvpm7mZ/TBDrWIqtjTBm/K9NABW+jcJf7uWpwGFZ9Oh/xUoCN/DyAVGGqWyO2zpOiFJfPA==
X-Received: by 2002:a5d:65cd:0:b0:2bf:bd43:aacc with SMTP id e13-20020a5d65cd000000b002bfbd43aaccmr7088381wrw.55.1674812274879;
        Fri, 27 Jan 2023 01:37:54 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n6-20020a7bcbc6000000b003d237d60318sm3842947wmi.2.2023.01.27.01.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 01:37:54 -0800 (PST)
Message-ID: <7e941a2d-25d9-44e0-7438-13225c87d8ac@linaro.org>
Date:   Fri, 27 Jan 2023 10:37:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 0/9] media: dt-bindings: common CEC properties
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, Joe Tessler <jrt@google.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-tegra@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-media@vger.kernel.org, Jeff Chase <jnchase@google.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20221208103115.25512-1-krzysztof.kozlowski@linaro.org>
 <cd803c70-faf0-963e-fca3-0edd13fa8a29@linaro.org>
 <c092c11f-870f-6520-ad89-001468ed59dc@xs4all.nl>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c092c11f-870f-6520-ad89-001468ed59dc@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2023 10:04, Hans Verkuil wrote:
> Hi Krzysztof,
> 
> On 13/01/2023 09:59, Krzysztof Kozlowski wrote:
>> On 08/12/2022 11:31, Krzysztof Kozlowski wrote:
>>> Hi,
>>>
>>> Changes since v3
>>> ================
>>> 1. cec-gpio: Add missing SPDX.
>>> 2. nvidia,tegra114-cec: Correct path in maintainers.
>>>
>>
>>
>> Mauro (and maybe Hans?), any comments here. Can you apply the patchset?
> 
> No comments yet. I plan to review and likely merge this next week.

Hi Hans,

I hope they didn't get forgotten and you still have a plan to look at
these. Patchwork shows they are waiting for review:
https://patchwork.kernel.org/project/linux-media/patch/20221208103115.25512-2-krzysztof.kozlowski@linaro.org/

Best regards,
Krzysztof

