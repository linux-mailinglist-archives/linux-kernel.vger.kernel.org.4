Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1621654DE8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 09:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiLWIw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 03:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLWIw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 03:52:57 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BFD192A0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 00:52:56 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id p36so6247603lfa.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 00:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sKAjt2iJj5kzIuD1ftaS1rKB66aNgi7BWJ7wJa8xL6o=;
        b=q8gAbYsGWv03QrFQ+UDY/3L35Sn3/iO29JHWFi3224D1nLsT4hUG9IF/q6LqYPb+mJ
         h/uzrDV24+LiZvswjqUksjbuslDt5NMn43oHs9Qf0V6cHUHwD7YJVlKqDmRpjig/4L49
         dAT7JgiiNgohgl0rCZrtomAeNr68Vl66xq2UTHx79oeTSll4YVX/qfuzsjA2jiQwX3XD
         B9k4h8KO6gs+05NTD7bsWo1XyV9SDTKf2NpQMEYpDOzkDTHAARTk5WktkfQ/N4rB4ds5
         16N6fn8vrxPW7MEHNUXyKv5VFF9xrwrOej9s84n5/RP+6o0gSg7eNPrxPr3EkKXJMUHF
         BkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sKAjt2iJj5kzIuD1ftaS1rKB66aNgi7BWJ7wJa8xL6o=;
        b=dBGNYVAGdkuFt96i5rnRCA3BELdXaDFOn6gpmpqeXDeHacKd+okk7M6hYLtxnkkSI8
         b46Y3JQIBhb5fMyMFh601LwUHSa1o2T7nrP0sG2Z4LZtL2Vy0OxsWPkH97Olr45nFfBF
         uhrTPfuUuXeysYldq/6JzgDw4GQILnrqsP7Z9kml8c4JaZ6KzEZKqLDj7nOzvWJnGMPf
         uq8D92QazvNIcL4qaQDYqXwkd8fgzFxUgQIv4Qh9lE+DxJ+Wh/8GHaLgAw8xtBjOq3nx
         fpHP213arV6sncHXnbg6Iy+1KZug5GZfVv5sJkCvgxuezEgOFftr4WEIaHTui3tIucE5
         evzg==
X-Gm-Message-State: AFqh2kqPvwtR3+VxOhobYoJ38Z604QUK4h3A4q4eytIGRmsCGfCGVRn3
        6fgkM/nnGXatd2oE86nyAoRWeg==
X-Google-Smtp-Source: AMrXdXvBNZVygllcLaQKKB3jySv/Pl0JkRS0BFcl3+kOZGL7NEk0TxfKZBUG2rp2iydlJvHGAZ2eEw==
X-Received: by 2002:a19:5f58:0:b0:4bb:a49c:2f0c with SMTP id a24-20020a195f58000000b004bba49c2f0cmr2553409lfj.25.1671785575072;
        Fri, 23 Dec 2022 00:52:55 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k9-20020ac257c9000000b004947a12232bsm424901lfo.275.2022.12.23.00.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 00:52:54 -0800 (PST)
Message-ID: <869ae494-d74e-03a0-3622-b3a2b0b10470@linaro.org>
Date:   Fri, 23 Dec 2022 09:52:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 08/25] dt-bindings: clock: mt8173: Add dummy clock ID
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wenst@chromium.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        fparent@baylibre.com, chun-jie.chen@mediatek.com,
        sam.shih@mediatek.com, y.oudjana@protonmail.com,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        ryder.lee@kernel.org, daniel@makrotopia.org,
        jose.exposito89@gmail.com, yangyingliang@huawei.com,
        pablo.sun@mediatek.com, msp@baylibre.com, weiyi.lu@mediatek.com,
        ikjn@chromium.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
References: <20221222114857.120060-1-angelogioacchino.delregno@collabora.com>
 <20221222114857.120060-9-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221222114857.120060-9-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2022 12:48, AngeloGioacchino Del Regno wrote:
> Some old MediaTek clock drivers are starting the clock count (so, the
> clock ID) from one instead of zero and this is logically incorrect,
> as we should start from 0.
> During a cleanup an issue emerged due to that and the cleanest and
> shortest way to keep devicetree backwards compatibility while still
> performing the well deserved cleanup is to add a dummy clock where
> needed, with ID 0.

Unfortunately I do not understand at all why adding dummy (fake) ID
cleans anything here. Unifying IDs to start from 0 is not an argument on
DT bindings header IDs.

Best regards,
Krzysztof

