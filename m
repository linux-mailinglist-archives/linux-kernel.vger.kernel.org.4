Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9756388BF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiKYL3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKYL3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:29:48 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CE7E71
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:29:47 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b3so6453581lfv.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 03:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AlAaAFE6C5OWWwdg+ZapGy1tLZGrCpnjydf36VbXlug=;
        b=jJUw+czORzXYz3tJ1rpIjyElMLsUPzx4CSNPXLW8GuItlyqJ8fVyezeHlThWJVHzeu
         fY7YqvzVtEkAU5AQ6AadoxXStN8VpZFAxItzbGyA8r108llFZBvtMGMaYz00GlINkSj3
         VgYczWIw+IN1zCqdqycVZYQ1JNzI5SQKLJ/q6pJ8jE7eN59YEQnnzVd6vXesp00DUdLa
         AG5oxd+ESLI8O37/AmIZy28pPIB9y3EQjlR9ih1v4aloaOWiLVX9/ZsMf/FrAs28dOoX
         PHsfupgpi/BJE8bmB/iKwvvonYTGlOdEOzqiaCfz92Wz72TTYxlEY4POqPTJjXAkTv0j
         oNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AlAaAFE6C5OWWwdg+ZapGy1tLZGrCpnjydf36VbXlug=;
        b=jzNi4TQDc8rkOWfUYZySXRGyzIOSM0neu7BGBVBrWZPjp+hxN5gaAzknb/3+zfX54S
         hKvQO9Z9g7QhXWEfRW8Orm0pydfOQY8RJUjpbYxZET63UjfYmhyR6FxrMVNjxJOEgKS1
         cF6MWD6kBflUmdInJrNvOo/jodvsG3JAX+E+62KwLWivLP2LfchUww+S6gvGYyao9Jye
         Nq0WTV0ElJdwBujsnejYIyoUiDdq2QJE2rfHmtX+Ab45n9Vus2ZExogTpQTkYVSqWV0o
         OofXEZYiL5SKzZFn3DmfcCgdhv+AXJrjqnlnAdbF5zH8UZoS+/qWXE8Z3pX0DGpd6foZ
         qDmw==
X-Gm-Message-State: ANoB5pmbyZCf64WkHJ6AS1PR6gKtI5s/5lwm8uCnli/xn6cFCltAe0/X
        fMsK8enFYAja8S/6OpBVlY/bPw==
X-Google-Smtp-Source: AA0mqf6d9rfUIFY8b9xP3QC9gltABhmbCQF9thPu9QZ9Tr2WJgaf/kvsMW/2fAf+e26rRNFwZR5QaQ==
X-Received: by 2002:a05:6512:2385:b0:4ab:13d7:5751 with SMTP id c5-20020a056512238500b004ab13d75751mr12849274lfv.631.1669375786097;
        Fri, 25 Nov 2022 03:29:46 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b13-20020a2e894d000000b0026a92616cd2sm342500ljk.35.2022.11.25.03.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 03:29:45 -0800 (PST)
Message-ID: <13a33962-ac55-e3f1-933a-a9addf9bc10d@linaro.org>
Date:   Fri, 25 Nov 2022 12:29:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/2] dt-bindings: mfd: syscon: Add tesla compatibles
 found on FSD SoC
Content-Language: en-US
To:     Sriranjani P <sriranjani.p@samsung.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        devicetree@vger.kernel.org, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, ravi.patel@samsung.com,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>
Cc:     linux-kernel@vger.kernel.org
References: <20221125070657.28335-1-sriranjani.p@samsung.com>
 <CGME20221125070709epcas5p329c4a6d9caf4e9903b60f2e6624fb7b3@epcas5p3.samsung.com>
 <20221125070657.28335-2-sriranjani.p@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221125070657.28335-2-sriranjani.p@samsung.com>
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

On 25/11/2022 08:06, Sriranjani P wrote:
> Add compatible for Tesla SYSREG controllers found on FSD SoC.
> 
> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
> ---

Thank you for your patch. There is something to discuss/improve.

>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 4e4baf53796d..8c3334999bec 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -69,6 +69,7 @@ properties:
>                - samsung,exynos5433-sysreg
>                - samsung,exynos850-sysreg
>                - samsung,exynosautov9-sysreg
> +              - tesla,fsd-sysreg

I think we made mistake starting from 5433. Before (Exynos3/4/5) there
was only one block called actually SYSREG. For example on Exynos5433 we
have SYSREG_DISP, SYSREG_CAM1 and so on. These are different so we
should have dedicated compatibles. The same for Tesla - please provide
dedicated compatibles per each block.

I'll fix Exynos5433. Maybe someone can also fix Exynos850 and Autov9.

Best regards,
Krzysztof

