Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8387C683497
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjAaSCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjAaSCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:02:21 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9470510AB3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:02:19 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so13091105wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dpDv+9QPHupt1UyeJB0z1k2Ufnogyk9lZGLkIf5nWzc=;
        b=svhNacA6geE2Ndg8QTafTeJu6fXopqBbRymSroIFbX/LguDYlC21U70PeI85j0xCO/
         de7Rlm3uRrh8/qlrB1NYmw40Q4ecXeuTtNnWmIu4sV6zoZ1/B40no6R1OICgEj/YiwqO
         chbqhdxE1n1PbVE6UtbqKZ/dH0C5M6cetlRhN5aflW70jBH8H0V3FdD1Kg1BsTxxEtOp
         o14OYqQLXk7wjBOd4JHFQrK5rTWVdkXYAnuaXZJIolGF+VmnH9VpjnnC9OkG8YfpzF7N
         BltxlLu0omgrNryDuBjGAUIG+WKGKdknMrQCjT4rOD2tcGRxjccSZD1mZl/p8KwOR1+H
         GHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dpDv+9QPHupt1UyeJB0z1k2Ufnogyk9lZGLkIf5nWzc=;
        b=HUT995X+e7BgLzip73AFmUk3dcig2FADqR7Yjfb+HB4tvbWHP6M8YEBTEOnGDHITDS
         AEdv+0sbiXpeZizOUQn4BvfnMC8emZp4feJggY+1z0cw4/tOTvuu1C1QI3QEQnZFcYFG
         VvT40t79ZdHHvH8sq2RpZcT3pxSwNrJumxxktXPHwfRyLE2rSbyjBEBlCP2NfRwf7+bY
         1bJHU5Uc3MgWod3KCHSpx8QfQg3cwQ4L/uqWSOPm97c1su0cWBWIkcBeRTpsbb8pE8Q/
         S9Ty1NTbvM2YvFlv/QAjgQc2s88wM4fuT3ZRoBkyfTdHbbxenwkxzpn1KkN8yK2UhOyK
         ShYQ==
X-Gm-Message-State: AFqh2kquSxkYQJiSJgsZS679OqdqGPZoby0qpPmGDgMVxS17TLA5yx1Z
        483OwbpNUHR/0UmkoefHY7bI1Q==
X-Google-Smtp-Source: AMrXdXtKb+4uvfotizMeuQfwAZA8MV5qRAu8vrz2XPdlaH7ZSWFKiEGd/DB4cabCuP4PCRF20iHbaA==
X-Received: by 2002:a1c:ed0a:0:b0:3d3:4a47:52e9 with SMTP id l10-20020a1ced0a000000b003d34a4752e9mr55153400wmh.15.1675188138023;
        Tue, 31 Jan 2023 10:02:18 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600c314d00b003db2b81660esm7148131wmo.21.2023.01.31.10.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 10:02:17 -0800 (PST)
Message-ID: <622ef51f-643e-5eb5-3884-3f22bf4fa9be@linaro.org>
Date:   Tue, 31 Jan 2023 19:02:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/2] dt: bindings: add dt entry for XO calibration
 support
Content-Language: en-US
To:     Youghandhar Chintala <quic_youghand@quicinc.com>, kvalo@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230131140345.6193-1-quic_youghand@quicinc.com>
 <20230131140345.6193-2-quic_youghand@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230131140345.6193-2-quic_youghand@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2023 15:03, Youghandhar Chintala wrote:
> Add dt binding to get XO calibration data support for Wi-Fi RF clock.

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).
Hint: dt-bindings: net: qcom,ath11k:

> 
> Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
> ---
>  .../devicetree/bindings/net/wireless/qcom,ath11k.yaml         | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> index f7cf135aa37f..205ee949daba 100644
> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
> @@ -41,6 +41,10 @@ properties:
>          * reg
>          * reg-names
>  
> +  xo-cal-data:
> +    description:
> +      XO cal offset to be configured in XO trim register

Missing type. I also do not understand what's this and why some register
offset should be stored in DT. Please give us some justification why
this is suitable for DT.

Best regards,
Krzysztof

