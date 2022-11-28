Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B82463A1E0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 08:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiK1HRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 02:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiK1HRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 02:17:45 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9924910FFA
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 23:17:44 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id b12so15289370wrn.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 23:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eG6Be3t23obGN2ATen8OVvK4rfTQoYDTZRglqML50dM=;
        b=poG5sOzFpRAXOKgMdrCfvvkeYKjQN58l3yG8Y0RXCFeucW9p7tCSm2XJDB/DM2Uwjw
         3/Y/na8LgamKOd7SmShUgO7J6B0oxo0mC3/UK16aji85NNE8emK0oIpso5ELBhGVu4bW
         sgaNaJbVk11x9JsZhsDDJzmF8yHn4GCmFdNkrdflrScLGBhbU92dXfgTDlhZRwWaR3Th
         WFHIN+Lf4JwcbjiLvKkRiUo+MHx1OIKsMpjn1ergLA5bSafz0z+WVyOjpd13JGT+gbLp
         dtJdFYD/kx0h98IMtd+SPaYDuIa/nkD2rTbLO0uJyIOJ07hjfTQFRKbZ7jYPrCWZUHOy
         wTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eG6Be3t23obGN2ATen8OVvK4rfTQoYDTZRglqML50dM=;
        b=W5Zo44bMCIn3x8aS7AOwdoZEziekifkB3wm1TLO2C1gr2Ti1dG3YO2HnKyWQ/8sxdP
         2gg6+DSdWI0OeCCoRwxRM/lIamT8SBcihcCGAwk/KbxzQvZHAAXEuoLtpKWnznFiK8Ci
         SYRjjabVKhBZqOQLo8VxIZp1go5brl5KiOs0Rj9mIoQ5C6sFXVOwQE/67RsVW3VH9BH/
         2U9OURMrs1ItV/NMg170MB/UvQFKmTqKkdMqst5khYGR3bZOUdQBBLhYMcee4Vhn3hpl
         l/hw4XP8aqzE9pnco/ZsdB6McKJF2euUkokbKb7tPiRGy/GHqfjctcCtaviNsGyHFwtI
         9unQ==
X-Gm-Message-State: ANoB5pnsGOfmB3qXau8fmr101Y58QhgsMM4Ma2NQjCz/9MGTHU1sXA7N
        Oabd8202ZmlN3N3MJyAZaxmh3s8mxyvqp3sv
X-Google-Smtp-Source: AA0mqf6Pw15Eqs2pCDoN5k8uvi+hNG9DvT5YpbugugAhcBiKU7PpmSSF7GYVBfsCF2jNQBm6vp50Ag==
X-Received: by 2002:adf:eb92:0:b0:236:80a8:485e with SMTP id t18-20020adfeb92000000b0023680a8485emr22959279wrn.362.1669619863181;
        Sun, 27 Nov 2022 23:17:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:9475:5832:6c06:e04d? ([2a01:e0a:982:cbb0:9475:5832:6c06:e04d])
        by smtp.gmail.com with ESMTPSA id t2-20020a5d42c2000000b0023662d97130sm9879851wrr.20.2022.11.27.23.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 23:17:42 -0800 (PST)
Message-ID: <669d0399-dbc7-965a-9e50-017f017ca823@linaro.org>
Date:   Mon, 28 Nov 2022 08:17:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH] arm64: dts: amlogic: align LED node names with dtschema
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221125144141.477253-1-krzysztof.kozlowski@linaro.org>
 <3719828c-0ac5-34c9-a04b-251cbeb5f6ef@linaro.org>
 <a135f93a-235a-27b8-f649-69d62f6ebd30@linaro.org>
 <54f500cb-d7d0-8af1-eb58-99fbe71791a5@linaro.org>
 <CAB6niQ4808JEgdQEvRvaYqq8YmFCGo_YLnxXo+rjpSgxQxu+7g@mail.gmail.com>
 <615eb86b-a00a-56bc-ae1a-9f0e4e86f77c@linaro.org>
 <a3b7e1f0-16cb-4284-c740-5b5874612ea4@linaro.org>
 <c89f9330-715f-4830-49fb-64c0b533ed39@linaro.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <c89f9330-715f-4830-49fb-64c0b533ed39@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Le 27/11/2022 à 20:07, Krzysztof Kozlowski a écrit :
> On 27/11/2022 14:33, Neil Armstrong wrote:
>>
>> Le 27/11/2022 à 13:25, Krzysztof Kozlowski a écrit :
>>> On 26/11/2022 17:03, Neil Armstrong wrote:
>>>>>>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>>> Aren't you maintainer of the platform? This means I should take care of
>>>>>> this patch?
>>>>> Ah, this will be picked up by Kevin or Jerome? So this tag means only
>>>>> Reviewer's statement of oversight, right?
>>>> Of course I'll pick it.
>>>>
>>> So that's confusing to see Review which does not mean review, but
>>> maintainer pick...
>>
>> Reviewed-by means reviewed, there's no confusion here, the significance
>> is clearly documented on https://docs.kernel.org/process/submitting-patches.html
>>
>>>
>>> Reviewed-by means, I should take your tag and add to v2 or the
>>> maintainer will add it when picking up.
>>
>> Reviewed-by means reviewed, fully reviewed patches are ready to
>> be picked unless a change is asked by a reviewer.
>>
>> Decision to pick or not a patch does not depend on any tags, but
>> is the sole decision of the maintainer adding it's Signed-off-by.
> 
> Then why giving review tag and not notifying about the pick, while the
> pick actually happens? This is confusing. When the maintainer, which is
> supposed to pick patch, gives reviewed it means always the same as
> acked, so the patch is expected to go other way. Not through that
> maintainer's tree.
> 
> If you just apply it, say you apply it.

This last reply goes beyond acceptability on my side, this thread
went too far and I'll stop replying further after this.

If your goal was to kindly ask me to use Acked-by to notify you I'll
pick the patch in the future, while this "rule" is only implicit,
the actual form is far from it.

Concerning this patch, since I already sent the ARM64 DT PR for v6.2,
and I usually don't take new changes except urgent ones after rc6, I'll
pick this patch and "20221125144120.476933-1-krzysztof.kozlowski@linaro.org"
after the next merge window and you'll be notified as I always do.

> 
> Best regards,
> Krzysztof
> 

Neil
