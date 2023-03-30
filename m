Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D3F6CFCC9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjC3Hbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjC3HbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:31:23 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1DB6EB3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:31:21 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p34so10274529wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680161480;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gv8JVciuDxQ0wesT323VY8sddT9TR9dSupeai1kGABw=;
        b=zSozlUjEPWi4/jPhKpPD0C6ryndKS450YaiCkk5K6zfzdIkAgtnLWUJuqip8reAA+G
         m8KkCUhyj8NceK3K4vNBbB3vCjptyYz0hDyaYEQk/BGeBbu9xzDi3teEqOZLy2Os7Gtk
         0DJcwLVFAacIyewhxbY2yA6qQ7BpDyJFnav0KjjJYRDzBOyynQV4MZO8ndEnlquJQtmp
         uqab2pc6lcF0XsEH7nwODf8J2bSQnKOyKpECAkVtxh3eArxE9o9iXaeK1CzBkDLakEzV
         u3dkqQKfLey/rKeaXjTYhziIsNYZ//fq7v7pSZN1tfvFHNbqcgU06PUaSU7olCpsiWfD
         u1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680161480;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gv8JVciuDxQ0wesT323VY8sddT9TR9dSupeai1kGABw=;
        b=qRfOFJ0cyqX6KA4oq6WEcwyJZUitTblaLSPa47WN8MwsJzn/O4j+xwN00bQoDU7zh7
         OcU7azhRozoMRJKh4QM79BynQ6eCxCZQIq1a3pwCkZekcXEw+2+GLy4GIqlwi7YAvO4O
         L/gUo4FmxC2mNFfE6kmIYnR7Z/HKXnrd6KxVrck/hlSY4NFoLWg5kPW8pspmPqokJ+Z5
         5F705FDmW6mrRM3te/L83Mi4rC8o7CkioMDOzu7hR5QPxGUY/A6FZCQs1a7g9mq7MfW9
         0fwKm0AJARR7M+qcg6KkrzgbayDcY2SdNPegcQYk2e3EbDaNpvVUOzvyUncwSUsFuNBh
         gOkA==
X-Gm-Message-State: AO0yUKWc9Ma5Yo5EXZU7vGrYgXFzBaj8fymYos0qsCtrnZ05zngOSuY6
        2M01KWy4O1O8SpDEjg+ZymktHw==
X-Google-Smtp-Source: AK7set/8syKQO2oLKnczLLSt+e88iWzGJM51xpz2K8yppyOXjZwYcbmpU/VbsF2MocQQGOy4acHhtg==
X-Received: by 2002:a1c:7516:0:b0:3ef:3ce6:7c69 with SMTP id o22-20020a1c7516000000b003ef3ce67c69mr16845825wmc.8.1680161480232;
        Thu, 30 Mar 2023 00:31:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:fe8e:8291:fc25:6c8f? ([2a01:e0a:982:cbb0:fe8e:8291:fc25:6c8f])
        by smtp.gmail.com with ESMTPSA id l10-20020a1ced0a000000b003ee1acdb036sm4833807wmh.17.2023.03.30.00.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 00:31:19 -0700 (PDT)
Message-ID: <c63d6fb5-fcc4-3370-7b4b-f46846136d19@linaro.org>
Date:   Thu, 30 Mar 2023 09:31:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] dt-bindings: rng: Drop unneeded quotes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230327170153.4105594-1-robh@kernel.org>
Organization: Linaro Developer Services
In-Reply-To: <20230327170153.4105594-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2023 19:01, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   Documentation/devicetree/bindings/rng/amlogic,meson-rng.yaml | 4 ++--

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

>   Documentation/devicetree/bindings/rng/brcm,iproc-rng200.yaml | 4 ++--
>   Documentation/devicetree/bindings/rng/mtk-rng.yaml           | 4 ++--
>   Documentation/devicetree/bindings/rng/ti,keystone-rng.yaml   | 2 +-
>   4 files changed, 7 insertions(+), 7 deletions(-)
> 

<snip>

