Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F416A6F6948
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 12:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjEDKtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 06:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjEDKtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 06:49:46 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8293D46B9
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 03:49:42 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-959a3e2dd27so54434566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 03:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683197381; x=1685789381;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ijejTY9A5l5sCeqYd4iecgvq6mxZnReLL8evvRwo+9I=;
        b=Sb+/lqZnX/i/xFFxFZqZyRmxH7apRXMMT/CsCULMDKEXH3t6CkMuBufANaGmZuiClk
         AdzqJgWgi5s7/JQXnq9Z44iudW/GbHDMyDWCjORKq8N04JKCXYVpC0VFA406VqrAEO59
         V7x14wquUR/NSt3gpVfZIYQOE23Db2BSwWruCF5XmOtingOY9aTjFucPwuhblUQAcYld
         yiQjqJLuChPTWmXJALKdyMzPaFihXqxxTvFjddRqNcoW+slUzxZoiHNZq9Bv9Oc+nhvD
         Mzg8PFG/I/qHUy3y+o07F9TcpqxzOQhrqorYh/a9hssAnNCSuFNDwN3kBNzPXj+Bqb/D
         G7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683197381; x=1685789381;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ijejTY9A5l5sCeqYd4iecgvq6mxZnReLL8evvRwo+9I=;
        b=fyQY0LMZT7L3Rln5vRaWR4JDRYgnjdgl7PTzBodrE1wsUi+XS3GfGLQfJhHUDsRSNA
         tVuxK2pL6R2i3gCVxUMfbmIJGzI6KOlQnnH5Hk6FevhIjB8E15Z5aQU22xaXrGORYgQu
         ipLnRcbeJdQPakomtPeNh9v892wjxazb0pHdw+a7ZSmgFNZE0hJg6ZLcYlIvlpikBMyT
         lpC4X0yczLSCmtTNbma71jCiAfpZ8xpZrl+f12uRSyXacYwrxu4t7m5drrDjYOFWzz37
         CETeXei9lHGogrgMIaCJW41oGhibHiFl1WN2hrarfGQlBzjGMLyMfu54bPo5Vql8p5Gq
         WhiQ==
X-Gm-Message-State: AC+VfDz+P5ZfWak2bQ9pWz8t2sqeUrS+D0ChVAAgaXeAEIeBszCpgwNk
        Nao/8aqeBRHCBdR2Xq9L3Lpieg==
X-Google-Smtp-Source: ACHHUZ6b7lxd8rsEGUG1s6s8pUCyRZtddm7ZY+NRU7xZ6jrcd5uUq59K9PzIZAdQdNvCMY7cGt+I2w==
X-Received: by 2002:a17:906:da8a:b0:94f:553:6fd6 with SMTP id xh10-20020a170906da8a00b0094f05536fd6mr5833388ejb.24.1683197380956;
        Thu, 04 May 2023 03:49:40 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id hx4-20020a170906846400b009659ad1072fsm1132309ejc.113.2023.05.04.03.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 03:49:40 -0700 (PDT)
Message-ID: <ea8c85e1-3bc1-14ce-90d4-27915bcef631@linaro.org>
Date:   Thu, 4 May 2023 12:49:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: imu: mpu6050: Add icm20600
 bindings to mpu6050
Content-Language: en-US
To:     Hermes Zhang <chenhuiz@axis.com>, jic23@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com, Lars-Peter Clausen <lars@metafoo.de>,
        devicetree@vger.kernel.org
References: <20230504091421.2054451-1-chenhuiz@axis.com>
 <20230504091421.2054451-3-chenhuiz@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230504091421.2054451-3-chenhuiz@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 11:14, Hermes Zhang wrote:
> ICM-20600 is almost same as ICM-20602 which already support in mpu6050
> driver. Specify "invensense,icm20602" as a fallback compatible
> 
> Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
> ---
> 
> Notes:
>     v2: require specifying "invensense,icm20602" as a fallback compatible
>         in the binding, as suggested
> 
>  .../devicetree/bindings/iio/imu/invensense,mpu6050.yaml        | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
> index ec64d7877fe5..711a1beeaecf 100644
> --- a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
> @@ -33,6 +33,9 @@ properties:
>        - items:
>            - const: invensense,icm20608d
>            - const: invensense,icm20608
> +      - items:
> +          - const: invensense,icm20600
> +          - const: invensense,icm20602

Don't stuff entries at the end. This should be rather before above
icm20608 entry.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

