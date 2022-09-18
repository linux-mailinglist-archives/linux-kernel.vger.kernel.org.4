Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4975BBD34
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 11:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiIRJ6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 05:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiIRJ6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 05:58:11 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBD62981B
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 02:55:51 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id y14so173607ljn.7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 02:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=uJDbkaS+XsYA+l+f+wbMnU3wGxWDofURrR9zLtociWE=;
        b=UTLclj9isYRIkZwI/IEgMUn1xnFFiMIUn5BEDdx4mcbGyCIdk/7lEMpwdsGscUCpfs
         ZkaA7tyHUbJtjLYuLsZJbUdMIa5zEXoCbJZ4i4yuvbf39j5wgHlu7MFPiKcj9ckbugZj
         0qXrEc9dOIKLVa08k656mgAwRYs6UvUSH/F+ScYCz1VcutArFRKXB64fxqM/qe6RsXKI
         gye97Iz0PsXPpFAt8GIUqXCFKDCWxI8SjCy//QfHJ9AOxhC8j6WvWUR/xjgxzWOZWXTZ
         SZ47WKYZGaIpV5x1HMu9myl2+qZPfim/u6/vw1yH8ZBFspYe9KNDXLHj7Sv8iOw++S9p
         TvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=uJDbkaS+XsYA+l+f+wbMnU3wGxWDofURrR9zLtociWE=;
        b=rZ+Sw06JXEKmmDb9R4PrMG9y3cVvAYwYLWV7I5oax0tSfUNGmQw+SbSr0DrKi16S9g
         cs904xXDSjp0XXuq25XWqEUFyBROHovkZ196qXG6bogNl9hOzcJPX/5YYKkg645thSx5
         C+y5gDm/S4qRP/holbou44DSWSFUbUjCK0ffI+QFk5QhtfnLuOI1pVcuksHazAKfvqRS
         FW9fY9C5s/yvmTyzs89O5XAK8W2ngBxlsOExPzgJnEnhUAYw++71ucD48prTi6Bdm2IX
         AQ8GIatOx3I075oJqaMV4osQhVls2JFJqn6h/mf0aHcXViReUduReT64cAiWP7SG1Bjy
         6yaQ==
X-Gm-Message-State: ACrzQf1VOgmOYqWkPvrrx6TfExXirUBNU262uTK3ByEc51wiU3rLG+hy
        OoPcm7994yr4Ci4ckJiJqWsnug==
X-Google-Smtp-Source: AMsMyM7YhycPtcrow7NNduVCQCLpXLeHqzsHwGbPl7HWaKdORAeYW8z0BTfhkDBJyNg+yZ0X1gYzNQ==
X-Received: by 2002:a2e:891a:0:b0:26b:ebcc:68fb with SMTP id d26-20020a2e891a000000b0026bebcc68fbmr3528397lji.427.1663494949351;
        Sun, 18 Sep 2022 02:55:49 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z9-20020a056512370900b00494a27500c1sm4583294lfr.163.2022.09.18.02.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 02:55:48 -0700 (PDT)
Message-ID: <2cccf8a3-20cb-5cdc-cd42-9efe82c35320@linaro.org>
Date:   Sun, 18 Sep 2022 10:55:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 4/7] dt-bindings: leds: leds-mt6323: Document mt6331
 compatible
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, sean.wang@mediatek.com
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220915091214.59673-1-angelogioacchino.delregno@collabora.com>
 <20220915091214.59673-5-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220915091214.59673-5-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2022 10:12, AngeloGioacchino Del Regno wrote:
> Add mediatek,mt6331-led compatible for the LED controller found
> in the MT6331 PMIC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/leds/leds-mt6323.txt | 4 +++-


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
