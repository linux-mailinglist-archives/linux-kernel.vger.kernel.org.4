Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F46F64EA32
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiLPLWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiLPLVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:21:33 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BB55C777
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 03:21:24 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id j4so3085550lfk.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 03:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gWCOz09++vt7gSRrrVtRk3U9xHsMwJfb4psYolKcH30=;
        b=kRIMTH3NVuPxweks9ohzawd0D6G6PqOQ2Y5M5YKn63mQ1G9Nd+w3aeo/PSGkX81f/L
         bqm0BlA/W+uEIODniJu/t2H1H/51JOGPiG1FX5jj3RypSkxd2ulukn6ZOj/uxbkL73Xr
         a7s+iNLb0lWDHQN21j54wekHbY+6rj/f8A9/9hrJXAhad1dMqJfLwNBnSwZgp3buimHM
         39dRuPo8Be27u59rNWXwNXj7ulC/kzvHYIQVys/aw3z0efA5skeWvYCRCQ6mbJqpVe/l
         05Y5gOAkj5Rjlo1YcPtoERzuu3OF5jqOShIhDP/28SXOWawPMF1ozZTXdD8D18/zaKJ0
         AlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gWCOz09++vt7gSRrrVtRk3U9xHsMwJfb4psYolKcH30=;
        b=6lbz7MUecLOyjZG6/YUnTUDcQ6ixSbgyMFReEy0EqfqVegOOp3B9XN1XJTrFRGt7tz
         SC6tIyxE1Y15iqcayMIrXOVQvpOzGXraUSa84DkuXmMkt+mgMT+psNP/5UNuEAyAsQrE
         yXv7SSXSS3Voa8bElM2hqx60poSJRcDc+Y5c1etxSleYMC0vt06qIWf5nOqNKb+RaWFr
         yJxCCUsMSNL55ZmMEc1juEOszHYDhveTMTmtMdIVH9B9hJz5HRhRFUYbAqVU4dq1F2WX
         WfN8t1ojNggITnt4gau1A4Rxr7gkg3VyQaAW/pi8hzbGioiXEvCC3U9gYmNU3NYoxfjO
         Sy/A==
X-Gm-Message-State: ANoB5plQ94uH4M6Z+srapoyl6GoAwAWD+WhCLmxOsFgvpCelL7uqanrd
        LRKOPQvM/txoVncfIoPzMGaY7Q==
X-Google-Smtp-Source: AA0mqf4AT1JDqt3ZxbzOYpPIlykdyBRhcC/2ieSzTZj6qxdmbP3PJAUglkgCv8x0PI+2zLhPY3tbSg==
X-Received: by 2002:a05:6512:3d8f:b0:4b6:ee14:3e98 with SMTP id k15-20020a0565123d8f00b004b6ee143e98mr12959406lfv.23.1671189682473;
        Fri, 16 Dec 2022 03:21:22 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q27-20020ac25a1b000000b004b4b5da5f80sm192992lfn.219.2022.12.16.03.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 03:21:22 -0800 (PST)
Message-ID: <bb2b5b72-42b3-3a6c-d865-9e338e34aba0@linaro.org>
Date:   Fri, 16 Dec 2022 12:21:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 01/10] dt-bindings: display: bridge: it66121: Add
 compatible string for IT6610
Content-Language: en-US
To:     Paul Cercueil <paul@crapouillou.net>,
        Robert Foss <robert.foss@linaro.org>
Cc:     Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        list@opendingux.net, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221214125821.12489-1-paul@crapouillou.net>
 <20221214125821.12489-2-paul@crapouillou.net>
 <CAG3jFytgK0noWteGvXTdSm9as9Q=qfhf_ep3Z8Wv2ofmLzGb=A@mail.gmail.com>
 <c78e92ae3cbea037abdd31ecd64e997c8dd1def2.camel@crapouillou.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c78e92ae3cbea037abdd31ecd64e997c8dd1def2.camel@crapouillou.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/2022 11:46, Paul Cercueil wrote:

>>>  properties:
>>>    compatible:
>>> -    const: ite,it66121
>>> +    enum:
>>> +      - ite,it66121
>>> +      - ite,it6610

These should be ordered alphabetically. What's with the tendency of
adding always to the end?

>>>
>>>    reg:
>>>      maxItems: 1
>>> --
>>> 2.35.1
>>>
>>
>> Reviewed-by: Robert Foss <robert.foss@linaro.org>
> 
> Series applied to drm-misc-next.
> 
I wished you give DT maintainers a bit more time than two days.

Best regards,
Krzysztof

