Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5744F619730
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiKDNNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiKDNNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:13:34 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333492E9DB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 06:13:33 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id i12so3150116qvs.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 06:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1bnFZ7o4kg+fqVaSO5UqWHHFD2jpODXgYxhzkNtuqlI=;
        b=JvpieB1N3npmqXZHfwJWhY4LJava9QpaBTNT7a2mHKoJ70YY6k5LfpbanjxCvuYO+D
         g0jEvvkfF7CDgXwSEFv+i90DfNHG8nLCD25sBGbhIQ4S2MLBha/6bJM/RPs4lfsVYI+6
         o3P4T3LCNt4Uz/0jBJ7L/CRhloZWhqkBx82aIF+zqqQxZkzq6CWlqAparkH+m3AHi94p
         zaADUzIwmh5uvVeYXzLwsl78W6DGYjtlhZKpU89JtAegedn1xmwjRIfmWP53U/5zaHqF
         NUgjF4VFUqKFO25c6vFtuLBahQQ8BQ7rJrEZTYWa3i8j2NR+vNU5q/kY0bVa/2R1ng/v
         +2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1bnFZ7o4kg+fqVaSO5UqWHHFD2jpODXgYxhzkNtuqlI=;
        b=msmfSL4UrcYj2cNVqK7El8oNwObzXpYQQ1V/zaexYH7RWniP334H04MVKnGkJnhQ0p
         jrzR/BW2PVnfJDl/em5gVWk0ikSCwtU0L61Ayc1jSiygarI9ScoeBTR6x80ZyJgwYi1y
         qDnKnG/LK1mtxAPYp8uMvX4GOFXfN8OyGKIh74xf0BHTzoCFqVH6OgIj/GtmP5nNLah/
         DplUW46zmGONk/qq7NMCl8ypSGnVRDauhWG0cwKL0FKx7Z9TSgG7O2rRXmmOB0eDZH2N
         2TnGXRFIyXrpMqEZLfGNG26iHiyfz/cEqCNJfV4iYnw6voOUIMlxxoG3iWT3MjfG5qhC
         oBLg==
X-Gm-Message-State: ACrzQf3rUrDniDOmkqj+J19BgfDfTKPytki/bbcPCe0DAHMAHhJYY8Xo
        SfORibxSgbroKCAVPSM9UEJkkQ==
X-Google-Smtp-Source: AMsMyM5X4IARocSixuDRx2dMkgmzWDzfdHur9P5jdQq+TlTDZVwjOV+Mu0q+kTJafF0mq1aPZzUhAg==
X-Received: by 2002:a05:6214:202b:b0:4bb:56b0:4979 with SMTP id 11-20020a056214202b00b004bb56b04979mr30734499qvf.94.1667567612401;
        Fri, 04 Nov 2022 06:13:32 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id u23-20020ac87517000000b0039a372fbaa5sm2377669qtq.69.2022.11.04.06.13.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 06:13:32 -0700 (PDT)
Message-ID: <73ce512d-1d2b-5e0f-86da-dffef06423fe@linaro.org>
Date:   Fri, 4 Nov 2022 09:13:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: rockchip: Add Rockchip rk3566 box demo
 board
Content-Language: en-US
To:     Andy Yan <andyshrk@163.com>, heiko@sntech.de,
        linux-rockchip@lists.infradead.org
Cc:     krzysztof.kozlowski+dt@linaro.org, pgwipeout@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221104123804.484109-1-andyshrk@163.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221104123804.484109-1-andyshrk@163.com>
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

On 04/11/2022 08:38, Andy Yan wrote:
> Add device tree binding for Rockchip rk3566 box demo board.
> 
> Signed-off-by: Andy Yan <andyshrk@163.com>
> ---
> 
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 244c42eaae8c..618c78fb9d5e 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -754,6 +754,11 @@ properties:
>            - const: rockchip,rk3568-evb1-v10
>            - const: rockchip,rk3568
>  
> +      - description: Rockchip RK3566 BOX Evaluation Demo board

This does not look ordered by name or SoC number.

> +        items:
> +          - const: rockchip,rk3566-box-demo
> +          - const: rockchip,rk3566
> +
>        - description: Rockchip RK3568 Banana Pi R2 Pro
>          items:
>            - const: rockchip,rk3568-bpi-r2pro

Best regards,
Krzysztof

