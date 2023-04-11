Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B558F6DD21D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 07:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjDKFxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 01:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjDKFxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:53:10 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F90E6A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 22:53:09 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id q23so8005051ejz.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 22:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681192388;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jGJMWLnnw1TNjAcH5jejTOIieThYiOC+fZDvfBG4mz8=;
        b=s3zZhrocrIy2rTP4h8m2drsdqMkByiIOLURPKhB8XqC2agb3wLtUWKxaNuv/9seJxi
         DfbbjnS+IG10sGQCXlsTftEgAglP3Het6I054hYHRQMqYlsjBXvl+R+UMqxVbL0LXD80
         G08+R9xzdaQpdIxgi+Jyotr8onstNUYs60vuKQniHNzOk4jyckv+TiZHl7AyP+DX6ATH
         SfeJFsLy8lx+tjVvoLamTSEQS8jkPtanPmdgHV1gbmZf55AAVgKQkWry4TBdH2tx1WJx
         NTOos6qbuZp5oDj2kDVURMbIkCFHbpnA3ix4NG+WV48ceQJd1oKniIN8T1v/5daMuz57
         01Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681192388;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jGJMWLnnw1TNjAcH5jejTOIieThYiOC+fZDvfBG4mz8=;
        b=35sk60fpHLP36IjL0c6PWL9ir4JU7EpiH4JUyNa14jDX81ByRmuSJ9AQzezCsKC3/q
         BR/LpkuOEIcOUJNVm/2BQMiGiZbO6qlj3HdMAzQH0jamuEzOGSb2BtKT5103aNg1ZPXJ
         KJj9qPc8xUca98bAqE5m0zx6Yh90VRnZzM0c6GRPJxkMunwqlYrfXGcRDk31c/0ocZoM
         Mgdj/rsLZjoxLm23VmdCIQImFJdiDn7BsEkNS8ZgWM6JXqMW0v+MveqzQWwaJbSODEHN
         U5O6TmK20Y3YkF5gXvXEus9bsZl5qLXU5FRaVwDEiatOE7Ld+BemQquVl6SjWJD+1WgI
         WB3Q==
X-Gm-Message-State: AAQBX9dQ6FTqyt7zHomFUfjhyamQ3i9gjiAPUj8JuRhypIVX4QUDY4dT
        hI2dTtNJz1hdtj42DFM7j1Ke0w==
X-Google-Smtp-Source: AKy350ZWHQo+x68Mgme9ibvo2YSW6hSWdaYSmIIyZ5VsnI+E/RGiFgntU3XgfudiE8WlsKWYJ8BENg==
X-Received: by 2002:a17:907:3201:b0:947:c7f4:2342 with SMTP id xg1-20020a170907320100b00947c7f42342mr9794316ejb.4.1681192388337;
        Mon, 10 Apr 2023 22:53:08 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:dad2:72b7:3626:af61? ([2a02:810d:15c0:828:dad2:72b7:3626:af61])
        by smtp.gmail.com with ESMTPSA id d19-20020a1709067f1300b0094a671c2298sm2359644ejr.62.2023.04.10.22.53.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 22:53:07 -0700 (PDT)
Message-ID: <604f8aaf-2dbb-2703-c4dc-960a820ee961@linaro.org>
Date:   Tue, 11 Apr 2023 07:53:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 1/2] dt-bindings: i2c: i2c-mt65xx: add MediaTek MT7981
 SoC
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, linux-i2c@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Qii Wang <qii.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sam Shih <sam.shih@mediatek.com>
References: <cover.1680857025.git.daniel@makrotopia.org>
 <4ad55cb4248db60111c20d833631a65854fa1d02.1680857025.git.daniel@makrotopia.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4ad55cb4248db60111c20d833631a65854fa1d02.1680857025.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2023 18:19, Daniel Golle wrote:
> Add compatible string for the I2C controllers found in the MediaTek
> MT7981 SoC.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

