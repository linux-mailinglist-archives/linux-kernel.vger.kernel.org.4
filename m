Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087106E37B0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 13:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjDPLRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 07:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDPLRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 07:17:11 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E766E270B
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 04:17:08 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id xi5so56984179ejb.13
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 04:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681643827; x=1684235827;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ghy1vBrrOopi9da9RaVmh1imZTAoDfQaq0rl9RiH25Y=;
        b=y9YlHJpe/YX4wp7vcZrsKZBoVJSGKCK29B/Zbvl9+dp04+scETF793YiUGa5AszuId
         MW6QXkqSxwfkzPxqqZzh+2SuPAddkf40bPvtBAZan0AHk7vuGE+Yke5m/z1d0rZVvB/O
         X+wfgWcyufFVZD58pUkURLe3WbJOHEwThWqGDZasYcpnewwSDJMRWcFfyqdUFg3LjJiQ
         YBAmL2zvFzlApO30+KrYCkN6MdOEvwabgeJLVJoszaseR/rQPvgsII8Xx4HyiDDVWedV
         6AYSJMulOY5+BQYTnn4bsBJuULpkctFOI7fVt3nuoT+1t4U1gkMea1ITPHYxjjTsOmmd
         Evjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681643827; x=1684235827;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ghy1vBrrOopi9da9RaVmh1imZTAoDfQaq0rl9RiH25Y=;
        b=gs57cTD51AROSRlxiJml8iCSkcGmYJP+uIQVp5NXXg6cwZ7wbFIo4EIWF/OnDglfjr
         +HtE6ngVjHaRv6bwK/Xf+qoaQO5RQ1lROEhhvKHh+AmjHuRHAGS58/9tkZB7F+6+OrSd
         TXjykDIm1tAbi/Jd5q++J1BLMbitTNk5rl8Q4olPeyI2SFoEafqBPHUFgSapyaXfAuMY
         J9JN4+qkiDS5q2opYk5KKZkA7y8D3jdKnWpEf4Hp1EOq+ut/QI22qpJbPQ3JSjdNWs6Y
         LaOBdr2p+IwSd1/HbeY/77laEZVR70QgpyeJ6L0yKDt6tNByuLqnJkMDYnfsDLl6oku4
         NU9w==
X-Gm-Message-State: AAQBX9ccMOaeEhLSmcpmbYcHhRCBpLU9gff/gppuhC7Djt3img3Sbg9K
        h9+JL15aWSZxUo/c33zSYAyLdQ==
X-Google-Smtp-Source: AKy350YveBF6sakE3Jo3HZxABjt/Jvg0DDaSL6crvK8r3ou+E+gcURkLQxWBbdbPuTRK+kEZ4JnLdA==
X-Received: by 2002:a17:906:5610:b0:94e:ff98:44a7 with SMTP id f16-20020a170906561000b0094eff9844a7mr4579441ejq.72.1681643827424;
        Sun, 16 Apr 2023 04:17:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:29dd:ded4:3ccc:83db? ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id p7-20020a170906784700b00947740a4373sm4927755ejm.81.2023.04.16.04.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 04:17:07 -0700 (PDT)
Message-ID: <1ff86f70-8e8d-5689-13f5-8f04a72cb600@linaro.org>
Date:   Sun, 16 Apr 2023 13:17:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC v4 3/4] dt-binding: mmc: hi3798cv200-dw-mshc: convert
 to YAML and rename to histb-dw-mshc
Content-Language: en-US
To:     forbidden405@outlook.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     tianshuliang <tianshuliang@hisilicon.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        David Yang <mmyangfl@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230415-mmc-hi3798mv200-v4-0-44096e187f53@outlook.com>
 <20230415-mmc-hi3798mv200-v4-3-44096e187f53@outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230415-mmc-hi3798mv200-v4-3-44096e187f53@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2023 11:19, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> The renaming is due to the fact that it is now supporting SoCs other
> than Hi3798CV200.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



This is an automated instruction, just in case, because many review tags
are being ignored. If you do not know the process, here is a short
explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tools like b4 can help
here. However, there's no need to repost patches *only* to add the tags.
The upstream maintainer will do that for acks received on the version
they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

Best regards,
Krzysztof

