Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1797330B5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345160AbjFPME1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345152AbjFPMEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:04:21 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A3C30C5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:04:15 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5189f49c315so751080a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686917054; x=1689509054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SYJ0sO+y+coB/SN7dSjeDmcGjzJst4L98PYQLZlcHCo=;
        b=wWEzjXt4rdG7IBUDKcK3vY7aCw3BwXIwe8kSjoBZwfwn0BRJXOhkVqGWgApl4L7FzU
         kVAc+lPIn3GswPeZg/B8u7oC1bfMwdPkgkQpJnHk2DyEz636Ed8PxwQSDGhYLQ8J8h9m
         uthyVF0lhJ0x9SNUMQjbf3UYfra31b6GsG12WluSKf7S6/P45AOjpn2fMndNVEDMlohV
         crLayzW5kgiVUTFn7nj1DHMwj5N4xXjXzYywqxUgmakXpME37sjJMPuuXUHYYm2tVSKL
         yJ2kE2wjFW5XkwRLdUw5E7BYrrzmcJ9hUC54ncD5X8ihiEXnUJYQUjf0htbriKJYkVN9
         oaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686917054; x=1689509054;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SYJ0sO+y+coB/SN7dSjeDmcGjzJst4L98PYQLZlcHCo=;
        b=Ud+0UV1KpNVEvB70Wnbpjmlh2UlehC3Ds4nm4H70wfBJFiROKyb7z3oK5oq67p7C4L
         KGq3axm/Q1p4CM2C+JBArod2obeIDg6TX5qgvTK2XWR3ix/5QRnIRV4aLkTLk4wZHGxq
         UY7728MpZhKxCTzVLra7YncHW2oM/MASWPxArV3Owo6w6nCNa51GZrtGbhTlVlQBZXEg
         hMcvIzHz+TzKj7tXL9A2G9bcSBbQtPv9NvHCDJ37+cYxSN9MgAFC8kIDunvYYon8RdIw
         beni+oT4wE1NpGWLE3DlnXHhhGsPjEw9Plo1Cu83BDjTJ8qg126y1qk7Dzr+BUBBPn+4
         EDHw==
X-Gm-Message-State: AC+VfDz9OLUyg7ZPWpn//cos4+M0OUsI9yHOxPXM5lDZEpKIDUOikTLi
        iNm4V45zcJSwRmPfl3WslApHrA==
X-Google-Smtp-Source: ACHHUZ73d340GHQZRziUfYm4S4dcZnof9MDGnOjcytce7VOow60tTtRFHBzxGMp+mFwKAmwwUkE1Ng==
X-Received: by 2002:a17:907:3189:b0:974:2169:5f81 with SMTP id xe9-20020a170907318900b0097421695f81mr1596693ejb.22.1686917053673;
        Fri, 16 Jun 2023 05:04:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id g19-20020a170906395300b00977cd6d2127sm10587207eje.6.2023.06.16.05.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 05:04:13 -0700 (PDT)
Message-ID: <eedf5cea-84e9-7d3d-856b-448912417b60@linaro.org>
Date:   Fri, 16 Jun 2023 14:04:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 03/13] dt-bindings: display: mediatek: merge: Add
 compatible for MT8188
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>
References: <20230616114111.17554-1-shawn.sung@mediatek.com>
 <20230616114111.17554-4-shawn.sung@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230616114111.17554-4-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2023 13:41, Hsiao Chien Sung wrote:
> Add compatible name for MediaTek MT8188 MERGE.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


---

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

