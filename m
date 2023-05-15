Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76DC70330E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242453AbjEOQci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242723AbjEOQca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:32:30 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48710213D
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:32:28 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-965ab8ed1fcso2404592066b.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684168347; x=1686760347;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3v/Wb7rBhzrVb0azi8VEofeBQJDbLwQtTKKw6U3ZDgU=;
        b=IQsT47xSa6tWwtSS4bpFB6i7IlU4UCWjoB2VM6EVgVr5RwUXSq3USycHcD4tbK/vCl
         XKFNwbFQf/jruqOo/rvlMLjUuPCZycBQeUffWIkGgw5dBLDgAwgJsfn9sB2c1gpt/MWb
         ZimOxt+//pU5CUmXwdB6oaX701pD1/lBK9C8i44PPeQrgsn9OEHGJWH/NYbcHEPFyLA7
         Bsl/ZYBWcDioxjk2hHAzwoKjTcchrRCwPZ+4MkGwJt8hwBqHRsFf9J56AHJFmzCUvieH
         SSmmFu0lLW2Mx6PmN0R2RGRyKeGfRuZzS/ydIrOHo83gK/ShptAv3j5ZJAky00BooIMT
         CZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684168347; x=1686760347;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3v/Wb7rBhzrVb0azi8VEofeBQJDbLwQtTKKw6U3ZDgU=;
        b=geiDX6I8WwxolNOX+OIaHZnE5aMBYbZC8ceFHYuTY6FqmcYgm6gfRCy6rucR7oKeFE
         5H9qW155p4cn0VgN+pJ2b1f2zT9nBnqRoHDFvxDZBSliscFvFs5VLUUsNzKAWOnMG9rd
         j+TBa+9bRDwxEuQQEenlOaWCBjvvZLVbg9f0sg/4wLY3uzrKyeI7MyogJJAGQkXJClmv
         KfqYCFe3rzoDtYJs3rP8brX+Lv/05fc0+eoe3YczHTpOIqv7u2PFiwTHIM9Yf0OY907o
         f9wLZRrm/fvldpnjyFvVEoTH/p02KEfFaCPViBO7CB21JkL2h6FTG2Ubap9UyIfknrzr
         /69w==
X-Gm-Message-State: AC+VfDzvexLiLkj3U8SnsYWvJaVtZXp8ST2CEMA6bYFxUxcyEAYkxFSX
        i1B1upazXDvqa3iLbf0xxpbdwUepSLSCb35HUyE=
X-Google-Smtp-Source: ACHHUZ6gTLs+3cm2BhuQPDtT2O40r+PYINlcdVU5ENN0zj7TYzrHOXrFQdEsXBWgivvJve1UghmM7A==
X-Received: by 2002:a17:907:7fa8:b0:96a:9b5b:5d80 with SMTP id qk40-20020a1709077fa800b0096a9b5b5d80mr11887393ejc.13.1684168346707;
        Mon, 15 May 2023 09:32:26 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6470:25b8:7c2d:1992? ([2a02:810d:15c0:828:6470:25b8:7c2d:1992])
        by smtp.gmail.com with ESMTPSA id s25-20020a170906285900b0096a5d341b50sm6679818ejc.111.2023.05.15.09.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 09:32:26 -0700 (PDT)
Message-ID: <17bfc33b-029f-a0f1-564d-e8c8d0a8695c@linaro.org>
Date:   Mon, 15 May 2023 18:32:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 01/13] dt-bindings: clk: g12a-clkc: export VCLK2_SEL
 and add CTS_ENCL clock ids
Content-Language: en-US
To:     neil.armstrong@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Nicolas Belin <nbelin@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-phy@lists.infradead.org, David Airlie <airlied@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-0-2592c29ea263@linaro.org>
 <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-1-2592c29ea263@linaro.org>
 <5cb38be4-a27f-dc1a-cbb9-c195505a9e7c@linaro.org>
 <9fa0662e-8854-05f9-da7f-ec8e08d2badf@linaro.org>
 <d5c030f9-2f4d-25cc-b922-d00f5033ac37@linaro.org>
 <6228670c-3e06-3061-f304-a2c641962ffa@linaro.org>
 <9cba6384-123b-1cd1-ed02-08365a0ed529@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9cba6384-123b-1cd1-ed02-08365a0ed529@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 18:22, neil.armstrong@linaro.org wrote:
>>> Meson is the only or almost the only platform making such changes. I
>>> don't get why, because the conflict could be easily avoided with using
>>> different names for defines in bindings and local clock. Approach of
>>> having bindings strictly tied with driver commit is never desired.
> 
> If we did it now, we would have make it differently and expose all the clock
> IDs on the bindings like on Qcom, be sure of that.

No, you just keep different names. The only problem here is that your
clock name is the same thus you cannot split bindings into separate patch.

> 
>>
>> Also one more argument maybe not relevant here but for other cases -
>> this makes literally impossible to include the clock ID in DTS in the
>> same kernel revision, because you must not merge driver branch to DTS
>> branch. SoC folks were complaining about this many times.
> 
> Actually we handle this very simply by having such patches merged in a immutable
> branch merged in the clock and DT pull-requests, it worked perfectly so far
> and neither Stephen or Arnd complained about that.

Arnd, Olof,

Any changes in the policies? Do you allow now driver branches (with
driver code) to be merged into DT branch?

Best regards,
Krzysztof

