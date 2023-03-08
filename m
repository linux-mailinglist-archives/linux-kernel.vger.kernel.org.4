Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97CE6B10B4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 19:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjCHSL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 13:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjCHSLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 13:11:54 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B06FCE967
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 10:11:46 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id cy23so69111224edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 10:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678299105;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dIbkTfbuYaA3+RtOg7HrzhffYJa9wKgDrnO04ZjeBhE=;
        b=DdJ5ND4zyMvr9mwMG3s365t9o3KE0ukJtj1YUDCtCv3nCUlkUOpfvCieZ0dz1ecQP2
         ROcgXniTT4umF0h3naad4Q24Ta3U6wXijdZBqdI0zLJtUfCywhXWLlP9SNJF1tbhgxSL
         bYuUJYPUOf5xI/7pmerUBtG94IuvjpYzwylVGDmPLoAs6S7hN7EQyJgBe/4Mk/VIODcJ
         iRytKqpLIn+zy0h5qHh6eAUvpccOmWrcNr8uTmN3xrHziSp/di2uQlHpap/swSknIizC
         Du3Mi0O32jpWaEYc6Uw1s/jNUG51dSay2ukUuVHn0VaBFdMvqWXVv/wfTNF+UM4sIAOT
         JScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678299105;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dIbkTfbuYaA3+RtOg7HrzhffYJa9wKgDrnO04ZjeBhE=;
        b=iNGE/tIMh+Q9zyNgzZj1xa+btwPlkdHg8YmmbL+CeazrajZFkN1Hm1sFQxbBfFE1Re
         23/nLqWOsbFLo7/urQiz4lNfd0AW8Zt3QX7iMyZ1EmyZL6Nv9+KWAnw/jt75NDIDgB8v
         AGuC+QftNa8ud0H8vBi127jNONuNhdcAUEoefzyn90NsA+Dowh3yoJ/AGSq3krVKA3pN
         ZfNQNDRTMbRufVpky0U1/sN9awTnVSfW16acBbKMpS/GzIGYwpqIh606elvbEreB7jML
         WTE/I/siiWAKGT4TCCi31yxGF91BPM3uqYhvI+TDy66p3miSdo0qCAoptiaVv6p/4IAL
         vA6g==
X-Gm-Message-State: AO0yUKWulvJPtJtEIRlSYK1Vzx86JPqpyeoBx1Xa/yswPZI8+awAyQbo
        OIWeEHY+KQteRk98HbKAljW6kQ==
X-Google-Smtp-Source: AK7set+80cZBExXbCTHag1Wy6TbwvmP01bgn9yhvAxwdmR/++/eWcPR5be2UxGhWfA1YEFrVu9A6fg==
X-Received: by 2002:aa7:c50d:0:b0:4c0:d157:a57c with SMTP id o13-20020aa7c50d000000b004c0d157a57cmr17607239edq.4.1678299105057;
        Wed, 08 Mar 2023 10:11:45 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:ff33:9b14:bdd2:a3da? ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id n2-20020a50c202000000b004f0e11e071dsm2248904edf.73.2023.03.08.10.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 10:11:44 -0800 (PST)
Message-ID: <5856c91d-b1d9-50d6-9e7d-cafee8b05092@linaro.org>
Date:   Wed, 8 Mar 2023 19:11:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 11/11] ASoC: wcd938x: switch to using gpiod API
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20221116053817.2929810-1-dmitry.torokhov@gmail.com>
 <20221116053817.2929810-11-dmitry.torokhov@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221116053817.2929810-11-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2022 06:38, Dmitry Torokhov wrote:
> Switch the driver from legacy gpio API that is deprecated to the newer
> gpiod API that respects line polarities described in ACPI/DT.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  sound/soc/codecs/wcd938x.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 

I almost sent same patch. DTS was already aligned with this, thus:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

