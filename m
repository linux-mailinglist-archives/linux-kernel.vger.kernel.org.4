Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D687624330
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiKJN2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiKJN2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:28:02 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99407748EC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 05:27:58 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id g7so3227842lfv.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 05:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f5DcG84whpNkZMgdPanLq5gCZ/VBXiFyiq+gALEmIjw=;
        b=b04L+Z+dTjKbIloGzP2Fg1AgBpMzy5kQm0+vPdQfYxFVyATqSkJnlowkLYJNVlQj/k
         qH6GN/F5zz6EODYFHlF5z7kQBroyoo+4QPwqUlrVXsjjYfVGezs1rBbZVwnvSRP5z869
         YFjPbAgSzDMyu68mZba7BA1RWa2SGx2IMoyE7a6SBKo1vVry3Pako+kXuWOiHXn6i5gD
         1mQ7+UPMDRxwG0KxZa3BRpMFnCyFi/ZIjdETCvodRzQXuxlacDtbvwQMi+PkDyxut3rd
         p7827C7n+2okHeEmQsRBknnY3DfZWKVDS7mvyX7QyOblZF556bg4f1n4XugqygHPv/OJ
         dnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f5DcG84whpNkZMgdPanLq5gCZ/VBXiFyiq+gALEmIjw=;
        b=HRO3MyNkscyqskp2roLW2JUYk5+jKGQ8YLPY6lVHcaHpPdHP/5w/Q0E7DCHNV2qStN
         /1UAImszgHQLBQDSMjsmeDV6a12WVCfU3CcQEvhVnMMS/fKRBs0Gen184vmBjm4uuZaC
         QwIKgeljAWQKDBqBj6RVuVlqXlK3tzm7Ccx+wwVZuWHz523zj46PXe44iFnVvY0nRNS5
         PJId49I3wJBylPnNQz7d1nOcTUkkMsDc5J6mAmeWjISFOhpy/dYPlOyKzZIxXL5uik1Q
         zIQN6erkPbXmUilgjz8lWQOS3rRphV/2JWrMQ7V3TwX1xyEi7NS6s/p2mXmUY1KIS+/5
         IP3g==
X-Gm-Message-State: ACrzQf0QpCD8Pei0Th3187HqjIC1Zga9hBo6EA9HCzibXWOekRiKTF0R
        2p5zAXMv77hx+eP6mvPRuT/jsA==
X-Google-Smtp-Source: AMsMyM5NwYvLDvN5XweF7hs6r6xhzV8Wnbyva8godKXWoixzDuP64x+tEFiHlDzGwPBXbaJBsh9Abw==
X-Received: by 2002:a05:6512:3411:b0:4a2:3087:cebd with SMTP id i17-20020a056512341100b004a23087cebdmr1347322lfr.66.1668086876977;
        Thu, 10 Nov 2022 05:27:56 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id d36-20020a0565123d2400b004947555dbc2sm2749406lfv.100.2022.11.10.05.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 05:27:56 -0800 (PST)
Message-ID: <c7a4d63e-9a85-93c7-a5a9-435f85740393@linaro.org>
Date:   Thu, 10 Nov 2022 14:27:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] ASoC: codecs: wsa883x: Use proper shutdown GPIO values
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20221109163740.1158785-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221109163740.1158785-1-krzysztof.kozlowski@linaro.org>
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

On 09/11/2022 17:37, Krzysztof Kozlowski wrote:
> The shutdown GPIO is active_low (sd_n), but this depends on actual board
> layout.  Linux drivers should only care about logical state, where high
> (1) means shutdown and low (0) means do not shutdown.
> 
> Invert the GPIO to match logical value.
> 
> Fixes: 43b8c7dc85a1 ("ASoC: codecs: add wsa883x amplifier support")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

I will also update the example in bindings. Not a blocker for this
patch, but better to keep these together, so there will be a v2.

Best regards,
Krzysztof

