Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C6570329D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242521AbjEOQQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242639AbjEOQPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:15:47 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F53735A0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:15:34 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so113264396a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684167332; x=1686759332;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MJS5D1vfgi4TTcjlnoJnfi8uWYCbp5zquITsCVwXKkg=;
        b=UUG1XXdqlD4uioi6zJCtsLUgjDOrepIXs7cNIP2OrvwpYp8EAF7MLpWDbTrOItVSff
         4ga8S9Cz7Z0R7u3C4HtPHVrr9VVzku5Q6YXnHYRRFVNMXRtSn5EvJKyLz0I2BUMSRW5f
         HUZvDG/bFvJGnKx4NSHkSbRgFFMRhJ8eFaSWjq60f5QgC7UC45gYrZgTWzcbqqQDAizY
         6otU9tEmOimhM8omtjqzsgblNTccZo7xHs27d+5rSJpbq3FRvPL2bYVZUGwmFSJMot25
         6hBEr+hboWjUCKeLYk5rfALpu2HFiuQ4UiIdn/Nib17Qkc97vvCvOa3FUjRchdN8OVCW
         PFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684167332; x=1686759332;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MJS5D1vfgi4TTcjlnoJnfi8uWYCbp5zquITsCVwXKkg=;
        b=Q9YybfbAGpUgtAL2i3I1R8XyfDo9m8Duri+v3WS8EMgUVy4CgfnRDcYIT5kmEchnQ5
         MLC7s+zpdwvMxdv0AqfDI68V40hsxjIQ85AcbrUNCm3c+hLLJfeGyAhg41M4R+Ebqrm0
         S6i1QNm+KiHNybtKHKT3QKYGpLucXkAqwiNz5W8jKrryb2DWp9a2x4KidQjmrhKIQmsv
         l7jk2WEXBAj8Nh5VokUXoUb73LL3xhrry1YUCWtXIZzl3YMxDrCTaUZXHYTqnRrY5kgF
         qXnNNQ7h0x0A1fsIL7l5r/fQbcXaODxCyqxjdqY3jDPOQtWSNFE9w1+3kvh0LgtSR+wF
         nG/A==
X-Gm-Message-State: AC+VfDzDwR5g8nwVBcKE1E/en1MKieDNeUcwRdYb4nlKVS8bPBqcihvy
        yu3zmytL1NrRNmBrnpenDjSRVQ==
X-Google-Smtp-Source: ACHHUZ4LvlP9DFb1havihsTe2GP8UdnxD25y3X6vt/zSG426igeLG5X2pfGZzbDWqmdBnqcy0NaQzA==
X-Received: by 2002:a17:907:6da5:b0:94a:6229:8fc1 with SMTP id sb37-20020a1709076da500b0094a62298fc1mr31799999ejc.31.1684167332604;
        Mon, 15 May 2023 09:15:32 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6470:25b8:7c2d:1992? ([2a02:810d:15c0:828:6470:25b8:7c2d:1992])
        by smtp.gmail.com with ESMTPSA id jl4-20020a17090775c400b009658475919csm9807639ejc.188.2023.05.15.09.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 09:15:32 -0700 (PDT)
Message-ID: <6228670c-3e06-3061-f304-a2c641962ffa@linaro.org>
Date:   Mon, 15 May 2023 18:15:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 01/13] dt-bindings: clk: g12a-clkc: export VCLK2_SEL
 and add CTS_ENCL clock ids
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     neil.armstrong@linaro.org, Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Nicolas Belin <nbelin@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-phy@lists.infradead.org
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-0-2592c29ea263@linaro.org>
 <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-1-2592c29ea263@linaro.org>
 <5cb38be4-a27f-dc1a-cbb9-c195505a9e7c@linaro.org>
 <9fa0662e-8854-05f9-da7f-ec8e08d2badf@linaro.org>
 <d5c030f9-2f4d-25cc-b922-d00f5033ac37@linaro.org>
In-Reply-To: <d5c030f9-2f4d-25cc-b922-d00f5033ac37@linaro.org>
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

On 15/05/2023 18:13, Krzysztof Kozlowski wrote:
> On 15/05/2023 18:06, Neil Armstrong wrote:
>> On 13/05/2023 20:28, Krzysztof Kozlowski wrote:
>>> On 12/05/2023 15:11, Neil Armstrong wrote:
>>>> Expose VCLK2_SEL clock id and add new ids for the CTS_ENCL and CTS_ENCL_SEL
>>>> clocks on G12A compatible SoCs.
>>>>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>>>   drivers/clk/meson/g12a.h              | 1 -
>>>>   include/dt-bindings/clock/g12a-clkc.h | 3 +++
>>>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>> Bindings must be a separate patch from the driver changes. If this
>>> causes bisectability issues, this means entire solution breaks ABI and
>>> is not appropriate anyway...
>>
>> This is basically how we handled CLK IDs on Amlogic clk bindings for the
>> last years, the amount of changes is very low and rather exceptional
>> compared to early development stage.
> 
> The commits with bindings are used in devicetree-rebasing repo, so we
> want them to be separate.
> 
> Meson is the only or almost the only platform making such changes. I
> don't get why, because the conflict could be easily avoided with using
> different names for defines in bindings and local clock. Approach of
> having bindings strictly tied with driver commit is never desired.

Also one more argument maybe not relevant here but for other cases -
this makes literally impossible to include the clock ID in DTS in the
same kernel revision, because you must not merge driver branch to DTS
branch. SoC folks were complaining about this many times.

Best regards,
Krzysztof

