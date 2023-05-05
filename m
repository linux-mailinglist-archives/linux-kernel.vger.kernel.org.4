Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240B86F83E7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjEENZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjEENYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:24:50 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584FD20758
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 06:24:49 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bcb229adaso3377735a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 06:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683293088; x=1685885088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=88pW8qWBWl/gwLo1P5APo+OBYDB/KVhHfdTYqAO9eAY=;
        b=AYnqjAD5rvuD0ZLSQ5l7Hx9KJ9x+C+/56HPgqiMC3wy3USc+lyae/7wy9iNF7t0vxb
         lvrAaaQBdc0S1YkRVHZo+0sD3UDvZNQSkuwx6CPFfAUibMm1mHqyPM3TMSp351Jn6VIt
         VrwvYV30SSKTYqbhmhusdZFioAnNVpYUwfVWEwLuG11XE9PNhZcecwjcCY9Erbtv5Uci
         FHYoc8dBhR6TNPell11XM5U3IEOj8EjSZfnQQpI5Rlzhy3y9OnheMWlcHj+ztw3baaDJ
         PIuHKw9ZbJ/toYNj6//FTWJMhfHsi3HUbmsWXGeWMBjxmNcnAfPDv5rAZ3pJvbLAKiNv
         r/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683293088; x=1685885088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=88pW8qWBWl/gwLo1P5APo+OBYDB/KVhHfdTYqAO9eAY=;
        b=XQ64bzrYRt7XXSQ9TRxorKl7/Fg5K0ebDLRsoCX34odJfeXacsOEJG9Z0goxDPIK7C
         BnreTvJhWIo8gk6bc/Dpabkm5mfDPIokppL0o6apwMklE3eHEA01YZqvY9OV8Giotvk7
         zJ3pV8e38m4Bd/tcjVzk4GgVPKqWQUWlIlOkCJ2+D1CWSXaVslawitBXG+nBNsE9tddk
         zdniBSHsdvYbtwjpc3qNhPd/PUHtJjcYDyc/cr6RhiNEIdgHkM7FIJHLe56+yM1Bl6Na
         Aby5zpKvwDgOH+fiopymEYlVOGuOTkNoUCicvh8Hr/2zZOD68ResgdifZBcVmS0WSuWY
         Fuww==
X-Gm-Message-State: AC+VfDy5g9rXx/oEwQpgjler7GmG39rZFrCJ4iBS8JYuGAApzTspVRiB
        Izr3ve9qRXecmJNtTs2BaRSREA==
X-Google-Smtp-Source: ACHHUZ7tE6qiopnAwq868iND3B4v8MQrCg6KKrBzkP+dMPCgtv9gp6t7xiaJTraOtyF4Q0MGc7vvBw==
X-Received: by 2002:a17:907:7d94:b0:961:b0:3e0e with SMTP id oz20-20020a1709077d9400b0096100b03e0emr1314712ejc.30.1683293087751;
        Fri, 05 May 2023 06:24:47 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:52e:24ce:bbc1:127d? ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id i19-20020a17090685d300b0094ebc041e20sm930557ejy.46.2023.05.05.06.24.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 06:24:47 -0700 (PDT)
Message-ID: <6582da01-03c0-77cf-9646-fc536ceb9b3d@linaro.org>
Date:   Fri, 5 May 2023 15:24:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 1/2] dt-bindings: reset: mt8188: add thermal reset
 control bit
To:     Runyang Chen <runyang.chen@mediatek.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
References: <20230505131308.27190-1-runyang.chen@mediatek.com>
 <20230505131308.27190-2-runyang.chen@mediatek.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230505131308.27190-2-runyang.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2023 15:13, Runyang Chen wrote:
> To support reset of infra_ao, add the index of infra_ao reset of thermal
> for MT8188.
> 
> Signed-off-by: Runyang Chen <runyang.chen@mediatek.com>
> ---
>  include/dt-bindings/reset/mt8188-resets.h | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

