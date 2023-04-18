Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E166E65B3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjDRNTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbjDRNTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:19:38 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D1214F6C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:19:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id kt6so34951505ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681823975; x=1684415975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bIX4Rr3ehv2fMoH6ZgqIbWsmVfGdQo2i8FUTrHShcig=;
        b=pB7wXu1ywZIBBUonDsDq5inPakthH6Vy3I76ItK9jN1tih7yBOxvY/FgnwG4oqtgHK
         i+M37Oh3+41Abtz3/DNjk4RR7JI9RNSbiusp5YzeRpOvWhH58yz8YdnwQqMiQ/B3Zo/p
         WR8Kry0BQPQwA59G8HZgQorBqDdQqrVL8TwgJWjoJ+nQcEN53rwYm2+vdRBf1cxhao4y
         2Rj3tbxzzQmDuAsIHBGb3Bx/AIMv4GQztYZL7s+WYI7Vbua+B3NnGRz7ZYaBv4JK6VoW
         Xae7N+o6eTlS3eVftvt+Odr1ASmq5BiHw7iNsbpuq+0SuDz/Of5ikYVg18hPUCh92N1a
         wwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681823975; x=1684415975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bIX4Rr3ehv2fMoH6ZgqIbWsmVfGdQo2i8FUTrHShcig=;
        b=craxTD4iGG9ZV1i6cLeYsoJkkSs7jjaCdjPmplkqHq/AetVFM9lQPL7bpWn0nh6vmH
         LUteYx4YYXtRGxbSfDkx7ImyfDC6pznrEy1+AyyG+eq+meNDEsDUjlDCHRO6j11Rw+7Z
         NEjRU6e4UoqOWDsUw5Rv4zE+sLYSblVp2ydQSbB9KdAwrRJRQ37F8X7Z2hTyQ0L5TlXD
         KAljS7BlOFxgfEPTNBqv7sT56lbFo828V4gO6zc7zCFdXwKPAzVN41kBPf/hINSN9HI6
         X9FMolch2ggP8OSvWPPE9W0iX0nKoGsi+HpNoO6U5v81wAgcyFg4tIKe6dvOunp/B7Kn
         qmFw==
X-Gm-Message-State: AAQBX9chxuOiVqJoFNwy1sEDyigVlKJXLYo0fnBD7OLIMHDu7qydp5Cn
        lyGhEFRryWN0YKmu+cArShxpwbeCiJAyun44oiK3QA==
X-Google-Smtp-Source: AKy350auYZpuRF8dsf9xL60a7BUYDlrVge9la3UOE6deGPEpmQQCziMBihvpBb7AgbinT46ger1D5Q==
X-Received: by 2002:a17:906:da88:b0:94f:6616:8b00 with SMTP id xh8-20020a170906da8800b0094f66168b00mr7603319ejb.74.1681823975270;
        Tue, 18 Apr 2023 06:19:35 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a276:7d35:5226:1c77? ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id g17-20020a170906349100b0094eeea5c649sm6234681ejb.114.2023.04.18.06.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 06:19:34 -0700 (PDT)
Message-ID: <ae487706-1081-bab3-0b31-1c5b3a72890e@linaro.org>
Date:   Tue, 18 Apr 2023 15:19:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] dt-bindings: mfd: stm32: Remove unnecessary blank
 lines
Content-Language: en-US
To:     Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20230417181342.v2.1.I483a676579cc7e3ac07e1db649091553743fecc8@changeid>
 <fde49fb8-c337-3a6b-811e-b9d7c3620393@linaro.org>
 <f2ad2414-526e-8b9b-aa95-a35953556f36@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f2ad2414-526e-8b9b-aa95-a35953556f36@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 15:03, Patrick DELAUNAY wrote:
> Hi,
> 
> On 4/18/23 09:22, Krzysztof Kozlowski wrote:
>> On 17/04/2023 18:14, Patrick Delaunay wrote:
>>> Remove double blank line.
>>>
>>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>> ---
>>>
>>> Changes in v2:
>>> - update commit title and commit message to reflect what the change is
>>>    V1="dt-bindings: mfd: stm32: Fix STM32F4 DT include fil
>> More than one file has the same issue. This is quite a churn to handle
>> such patch one by one. Please fix all of them or just skip, as it is
>> harmless.
> 
> 
> To be crystal clear, it is minor difference between files in U-Boot
> 
> and in Linux, just because we correct the check-patch errors
> 
> when this file for STM32F4 was up streamed in U-Boot.
> 
> 
> I prefer correct this line in the Linux file and no having
> 
> this difference for each device tree synchronization with U-Boot.

I don't know what is there in U-Boot, so my comment was not about it. I
prefer all the files in Linux kernel being correct, but done once for
all. Not once for stm32XX, then later for stm32XY and then stm32XZ...

Best regards,
Krzysztof

