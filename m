Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314EA7032CF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242660AbjEOQW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242192AbjEOQWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:22:25 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C61830CF
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:22:16 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bd2d7ba74so113197181a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684167735; x=1686759735;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HqUKnr7IQo6kAfIcW46mPtLrFF4JcKeEB/JMB18Eu9o=;
        b=IFOu69xMjQDkgS9weEDled/TdBHMLC8yBGornivzVwLbLX77xvDFLzkoUqW7hi9p1t
         CKaI3h/mDs5Z3JBQ7MBKkh9y4mCkeCX/9i6zRH7s4LBA8ibeKmgux3dAFjRGbwEy+Z36
         ApdQ3qPRZq5UXS2EtTjNC8uyb85BQCuYuGUK0hXmgkcbX7bT17ABTP5SS1jxo54Q0Ujy
         sjdtshj3OT9BXTu3drUjNDncIEBpqNBRRZdoPTJ71PUWyi5VNtciC6D7wzTEJ4XUfXuC
         F3vVSQyZ0Awq5Df63fkIJlHVjiGg/Xx2nrna0EMvpaA52kV2CS0e9KDA0wpEYhJfaeYp
         7kNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684167735; x=1686759735;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HqUKnr7IQo6kAfIcW46mPtLrFF4JcKeEB/JMB18Eu9o=;
        b=ahBqMwPeW36jR6QtyZpqmmicyYJVCEzVlE6EnRDTe+s0kB6dqAxVax/3ztBaDFRViZ
         1j9KCUXPuer9g/dROOm8+ZIOEYiQrz2+81LHI+S9cYiERW94/b1Cy1UdJ0e8CDiGp6mE
         uzpso9SHYJj+P2U7uwFA+XnEUjR8xQi1KQ+SYvGFP/+tv39bdl0eik4Nluq4RcRLCIcd
         LJ6gX99d1ZS6SQU7j1YmiFyzQPSGdvh1iI1qgH9U8L9dCGqsoRiy697wXfp5etnDMHHg
         ndGSDUBeJgMOlIZ7h8vijdeh3OvGmZ2xII3wyZ2geMYTObq33Wl26ubsj6P9C9pL0EzW
         1kiA==
X-Gm-Message-State: AC+VfDz6oRvB59dgs5JwEDfWx/f8fJBJukdOq92ay7lfQ9B0IO99GqEe
        7eQuLYAKSsx9llZcHAYc15theQ==
X-Google-Smtp-Source: ACHHUZ4LIljnAHBUrSfA9rndvPnsXVWvxuzuNDX+pSF5zFw9AsRvRtnw68XknYeYz635GIn79GF7dw==
X-Received: by 2002:a17:907:3ea8:b0:953:37d9:282f with SMTP id hs40-20020a1709073ea800b0095337d9282fmr28963636ejc.38.1684167734983;
        Mon, 15 May 2023 09:22:14 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6470:25b8:7c2d:1992? ([2a02:810d:15c0:828:6470:25b8:7c2d:1992])
        by smtp.gmail.com with ESMTPSA id fy7-20020a1709069f0700b00965af4c7f07sm9645534ejc.20.2023.05.15.09.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 09:22:14 -0700 (PDT)
Message-ID: <80da6b9e-ba82-d2c9-2854-b444635150fd@linaro.org>
Date:   Mon, 15 May 2023 18:22:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 04/13] dt-bindings: display: add Amlogic MIPI DSI Host
 Controller bindings
Content-Language: en-US
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
 <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-4-2592c29ea263@linaro.org>
 <fe2f22c7-8c39-faf3-bc65-a7c089200134@linaro.org>
 <eaa3ecd0-dcf0-01d8-b3ea-9dd900215839@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <eaa3ecd0-dcf0-01d8-b3ea-9dd900215839@linaro.org>
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

On 15/05/2023 18:15, Neil Armstrong wrote:
> On 13/05/2023 20:32, Krzysztof Kozlowski wrote:
>> On 12/05/2023 15:11, Neil Armstrong wrote:
>>> The Amlogic G12A, G12B & SM1 SoCs embeds a Synopsys DW-MIPI-DSI transceiver (ver 1.21a),
>>> with a custom glue managing the IP resets, clock and data input similar to the DW-HDMI Glue
>>> on the same Amlogic SoCs.
>>
>> Please wrap commit message according to Linux coding style / submission
>> process (neither too early nor over the limit):
>> https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586
> 
> This message may be automatic, but context is always important when reviewing,
> this commit message is a re-spin on v3 that was reviewed by rob but I decided to remove the review
> tags since I added a new clock and did some other cleanups.
> 
> While the process describes "how the patch itself *should* be formatted", it's a best effort
> and not a blocker.

Other issues are blockers.

> 
> I'll fix the wrapping since you pointed out, but referring to the submitting-patches.rst
> file (from a very old v5.18-rc4 version) is kind of childish.

It's just a link stored in automated responses, what's here childish?
It's still valid in current cycle! Look:

https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

What's the difference? Srsly, I can point you to submitting patches
without reference to specific line if you wish... Or you can check by
yourself.

I give the same reviews to so many people that have templates and Elixir
happens to be the only place allowing bookmarking specific line. Which
is helpful for beginners because the entire doc is huge.

I can make an exception for you and never paste direct links.

Best regards,
Krzysztof

