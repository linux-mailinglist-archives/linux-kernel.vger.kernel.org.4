Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CF36595F5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 08:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbiL3Hx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 02:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbiL3Hxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 02:53:54 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F3A17E1E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 23:53:53 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id n1so21468237ljg.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 23:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wteaOjqUStv05kTX2dIgFUVrbZUO7TezK4q3XUbgysk=;
        b=XuKRrftvoCemAypeWsYZ0OiXxkS4hQi2gBTIyPGNI4lGIBuK5bqaVk9Y1ZICA9cnD+
         WDBtvLfP6rxHilBzLcL38FZ/JACauxH/Itw8LSMISVqT3P+Yt9Olu6F1CmrVKK3vwbol
         PHxE6YrkEM1mAdMa2uIX9GBnTTSSbiyjMB1hp9d6zQPiJcpOybIap24zZMNDPA3X/LIw
         0MqfMgbF7t+zTB9Nyg3XNhJWiNeBYH4eKuFpZEk5TAf0eOLlXpb1Q09TIwXRkXeQgaWS
         UjFllRndYjHNRATCRRia/QKbVsp8Era6Vba3xgx/bdoMnZg+4E9Naq3q9Eh7r1FtecfN
         UYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wteaOjqUStv05kTX2dIgFUVrbZUO7TezK4q3XUbgysk=;
        b=lg8c45Ru6i/j9pVg+Has2596MUxtpiR+LYOR6nXI/nWrOsePN9JJwRSi9+nG254qcu
         TVGTVWe5Z54ZGIdyT5EdVlHRvLsOPQm+7cv0KWsNkreaNiG7ML58CR1ccIu3Yih7g/3F
         FBUL0MUtEs4ZqifCE+BmjNfD6qnQdTdUvvEEQ4RqIq9gNBKHLbTAZtOVtQp6trtY5+fX
         lz1Hu3h5mZzuQo6fWbTpm0d3HWF6YlHfisMBrT0sDfWUXoksn4r+RwG9uB2LDdliPKJY
         6vhuszuCj+802hgBREv7iPOtEf6zamnWDR/hXBxIBJA5i1A+olmWC4CsJ5Nli/uCrpFV
         Vw+A==
X-Gm-Message-State: AFqh2krLTjiFDMbcSCYLZ6TPcssOklkItwgqf7+D1izJmv0ryin4MXK6
        J/0fL2o6G0XHQdHZAWEyME534A==
X-Google-Smtp-Source: AMrXdXtbev16q7ONLYZzOU/zdhnSOOqAY/gknViUZlAxu6zfISXg8REkGb6Rdz8hBco08PPeeVSieQ==
X-Received: by 2002:a2e:b904:0:b0:26f:db35:6173 with SMTP id b4-20020a2eb904000000b0026fdb356173mr8628548ljb.17.1672386832058;
        Thu, 29 Dec 2022 23:53:52 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id r18-20020a2e8e32000000b0027cf0ecab3fsm2570075ljk.138.2022.12.29.23.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 23:53:51 -0800 (PST)
Message-ID: <c2932014-57f9-f80e-3c86-2aa7e5bd422d@linaro.org>
Date:   Fri, 30 Dec 2022 08:53:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] dt-bindings: arm: sunxi: Add iNet U70B Rev 01 Tablet
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-sunxi@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221229224547.25225-1-samuel@sholland.org>
 <20221229224547.25225-2-samuel@sholland.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221229224547.25225-2-samuel@sholland.org>
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

On 29/12/2022 23:45, Samuel Holland wrote:
> This is a white-label 7" tablet board based on the A33 SoC. It is found
> in products such as the "Nimbus 17 V1" tablet.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

