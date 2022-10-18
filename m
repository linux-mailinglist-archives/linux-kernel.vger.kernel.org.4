Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BAD603270
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiJRS3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiJRS3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:29:07 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CE5814EE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:29:06 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id f8so9232875qkg.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 11:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jf71w/kMAtLTuZpw+aeynxFbJonRYosXdM0sN0F9YJQ=;
        b=QyPtio5WxIjCn0zb+wjna2OySfw2zIuGY3eeBmkvLgsfLTvwctfMJVZB2v95/HPEjG
         W/LzBAjV7nX5q6D6mL2vXB9CwWc35oUIbragvzLNU2vBhPn0HQMAXTeIOPg9WKdKbcj0
         oRvf72Vpd6pIkGIsOe4Nk11/QqMfBFl5IRjl5qnV6xLDQ9WYhqCtAVO6YWTPfYa2gFcf
         wqFEzpDL89d8RZ/IjCHCC6fAnFN4xyxb7vQbY2vloC81sFeyAZWHHFq7g6wqOjHucsWJ
         JzBwV7nPLTdeMJVBK6GvWgsUOvghhC4kEYesz8jNDvMMMLvCLzsoU5S6HglApZ8IPcMB
         JP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jf71w/kMAtLTuZpw+aeynxFbJonRYosXdM0sN0F9YJQ=;
        b=cTDf+Y0A5mOCeijfhQpPM9qyEEbnH7cqgnE/u/monDU7TVpltLjfKL6wXJIRC2EBNM
         3/AvmriTaiaHGcZzDxeT+Xb8oNOH4fw8+OfseA8rbk8ESXNtMAry9CvXiU3RtxjkIX9E
         yizwtrUd9MdivnoUXLYZrJS7SKxh8RDD/JLWNrFDHGbxpY5+hKDbGIcEYWB7Y2n1XAgj
         8MR3P5eVZlOg24T4I8vR4bPvtetzHBsvcO2Wbla4NJd2WafUqohLVUbTbpa3GGS3zeBz
         UXspeo1qCyTAsXPC18bf+vEQZwxeD4T3Ai+UFQ0zmhgSzk4J/fQMvgwrqF/3NCYAGMF6
         0c0Q==
X-Gm-Message-State: ACrzQf1xlg4n41fD68vel1Y1Lzj90TVNtFoDo1CK6wiHvZNXlZtkCkpC
        hWWjs4wL9KBduMz/oB7mb9IxTw==
X-Google-Smtp-Source: AMsMyM6Ka5CO8JW+udIuW1pTo+oi3POKxDhOQ2etdGB19wypOpdxMZP7SqrspYTEsdDdzY/4x5HGTg==
X-Received: by 2002:a05:620a:1452:b0:6ec:3f82:522b with SMTP id i18-20020a05620a145200b006ec3f82522bmr2719440qkl.402.1666117745901;
        Tue, 18 Oct 2022 11:29:05 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id y4-20020a37e304000000b006b5cc25535fsm2699092qki.99.2022.10.18.11.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 11:29:04 -0700 (PDT)
Message-ID: <5d87f1c3-1c73-054b-dca1-9f52939e187d@linaro.org>
Date:   Tue, 18 Oct 2022 14:29:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/2] dt-bingdings: mmc: Mediatek: add ICE clock
Content-Language: en-US
To:     Mengqi Zhang <mengqi.zhang@mediatek.com>,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, wenbin.mei@mediatek.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221017142007.5408-1-mengqi.zhang@mediatek.com>
 <20221017142007.5408-3-mengqi.zhang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221017142007.5408-3-mengqi.zhang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2022 10:20, Mengqi Zhang wrote:
> Document the binding for crypto clock of the Inline Crypto Engine
> of Mediatek SoCs.

This does not match the patch contents at all.

> 
> Signed-off-by: Mengqi Zhang <mengqi.zhang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Best regards,
Krzysztof

