Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F083673309D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344782AbjFPMAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjFPMAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:00:19 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE4330DD
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:00:15 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-519608ddbf7so797928a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686916814; x=1689508814;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EpphWyl7ymX0IOPQSO+uEg2XIt+pkQmjxlMzsQAx/7s=;
        b=VdY1cyXveTTIYRJIt1BP0YhvUm1szLzcVcEwghxW2j/QTwyeW3VVFo/IdTcxY8A+Vo
         /L5pQr/f/wF2a6rwkcco6snmYGvXwkkoYvqCWsI4gePz3ZH9DKDpmk6f+/H4BwIGqR/i
         lESnTfWo987nMYx4KvB9+rVXHRezb08gH4SDto3GguNQPjUTSguJvIyN8bhamekUs3/P
         b/oVwdzhmQyGNbycrLkRkrIDVWwpX0K+T6fiCPCllcZUnR/f2GxmZmqtZruM+6GRdOuM
         8OKLqsqsvhGy2GAK0pIPkHxhcsw2A1wafxWztU6suXs/A8E/kE1CIVOf6OQsQVf5GLqI
         qi+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686916814; x=1689508814;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EpphWyl7ymX0IOPQSO+uEg2XIt+pkQmjxlMzsQAx/7s=;
        b=kn40GNlXqcSBlKGVT7o0QW/7Oz8OHyyca4iNm71cQSG+wwA0Sf8QAXlSPnXrEtOwFy
         5jo1TuCK2D/1SRhHu/cKueQC7YbA+Ki7AjTdVZ6cjZqFpVAuvz0mXKR97zLHcEDKehYQ
         dw/VEq258KMQ9aBGQ8HfCK0Iq/iaO862V98n/ULRxORn6tw3uBUEKsTpHvTr7cgh2EFu
         uHmea20rfRPZ4MqRI3tDX3yydwHLOHXq8hBM26eafQN9UpBi6FB4DxDf5FsHOCqhHuTs
         AprljcvGuEuZhFc0Rwf/6l95fjGVbnJ2ZF7W73MqCTbyngRUyVR2AZrHeCvuJzkUEPwA
         bljA==
X-Gm-Message-State: AC+VfDxxAh5esVkMk871U6QFQcUYjkUsQMN5sIK6Qzxc5SV9r2M+xCVm
        GpgL8WPxZ07NOGJjmaIUJ1pbiQ==
X-Google-Smtp-Source: ACHHUZ53pfboPQWvCKgtBZ5MALcYWa6/OJ228DvvV2w2b6BQCd55+S6rlMzcsb++j8y/rK/NNGTuBA==
X-Received: by 2002:aa7:c516:0:b0:518:7d0d:298 with SMTP id o22-20020aa7c516000000b005187d0d0298mr1156216edq.38.1686916813946;
        Fri, 16 Jun 2023 05:00:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id j17-20020aa7ca51000000b00518710798b3sm4683686edt.50.2023.06.16.05.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 05:00:13 -0700 (PDT)
Message-ID: <1b32a1bc-2be8-8ffd-b6fe-8565068601ee@linaro.org>
Date:   Fri, 16 Jun 2023 14:00:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 01/13] dt-bindings: display: mediatek: ethdr: Add
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
 <20230616114111.17554-2-shawn.sung@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230616114111.17554-2-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2023 13:40, Hsiao Chien Sung wrote:
> Add compatible name for MediaTek MT8188 ETHDR.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---

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

