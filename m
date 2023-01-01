Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4589665AA6A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 16:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjAAPki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 10:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjAAPkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 10:40:35 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C555038BE
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 07:40:34 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id cf42so38399083lfb.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 07:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c5RuwWSVhOy4bx3U84+ZDzXx4NkVujrybKX74oDk6bs=;
        b=p8LUuneUt0KRQyiTOVJOG2ZINoHCZC9JZAqRg65HoN7tPfgd5wC+2B6khS0mexhByU
         SS+4PaKyhWC/kdYaWlwAXb269IxXgLwbb8qUvZafx95iD465JmTZQx62XmmhyC3U6ne+
         /MipjrLY/AkgJtPrEkyGfbuzn/6rog13TatWOE9MAPNSTGYWeZ1t+zrshD2qG1w71wCA
         t5yJXTlLSXXf+ImaMNnjcyqovYkUatErnMvdY0mVgorfLuo8HFMg98My3H1sNjMtzIiU
         fsy+YBuUB1Yxuh3XgpgO4VNYUP++bDc0hzNj3++CThwNLOT+8wDeCxbYo1uWtGPbJicA
         8UvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c5RuwWSVhOy4bx3U84+ZDzXx4NkVujrybKX74oDk6bs=;
        b=A9ahxLoKHaImWPwQa9fSyETV33eikwBCwfKzbHfDz62jTBxbQ1+u5PDw3YUuqMsuG8
         nGx6vP1gubQH9ElCeDFDzvDI117NfK3os63jbxI2nvkTUZLTPxY1xU+PlpbmLk8lCtp6
         O9cKsbDj38S0zyUaxDt6KFhwYGyjZUsOQP7hblFazGubYq43eXJtKycEElXzDYHRxX3x
         K5LZk5szz8rSOw8ZYGVE7s0+E8S+KHHvbriO+OeWX3iESopcbVjKBvZLb5BbgHgdpaFc
         ezsyycozaHfQU/SDMoCUC2s6qo+oHPAMMSxZeIiZ1lByojomGb7F3PCBhQahpReGKplX
         N95g==
X-Gm-Message-State: AFqh2kpsjnYjuqHr6LmDPNNsWW9jFaMyQYB5IoTkdyxbunrlRnQbrcnf
        EuXdzbMFXgF3+AGd0jIbOpjYLQ==
X-Google-Smtp-Source: AMrXdXskNqBM5s1DAF2mSUlq4PHai+KtIFBVwyONA30znFvyr7u1VisNSecOLbVdEMZCF73YgMbNnw==
X-Received: by 2002:ac2:5494:0:b0:4b5:5bc1:16da with SMTP id t20-20020ac25494000000b004b55bc116damr10172196lfk.39.1672587633160;
        Sun, 01 Jan 2023 07:40:33 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id w4-20020a05651234c400b0049d0a98f73csm4152591lfr.154.2023.01.01.07.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Jan 2023 07:40:32 -0800 (PST)
Message-ID: <396b0ef2-b3da-2c44-66a1-16d1b21ac6ef@linaro.org>
Date:   Sun, 1 Jan 2023 16:40:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 5/6] dt-bindings: arm: qcom: Document
 xiaomi,laurel-sprout board
Content-Language: en-US
To:     Lux Aliaga <they@mint.lgbt>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        marijn.suijten@somainline.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221231222420.75233-1-they@mint.lgbt>
 <20221231222420.75233-6-they@mint.lgbt>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221231222420.75233-6-they@mint.lgbt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/12/2022 23:24, Lux Aliaga wrote:
> Document the Xiaomi Mi A3 (xiaomi-laurel-sprout) smartphone which is
> based on the Snapdragon 665 SoC.
> 
> Signed-off-by: Lux Aliaga <they@mint.lgbt>

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.




Best regards,
Krzysztof

