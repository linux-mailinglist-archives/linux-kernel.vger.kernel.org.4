Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75B663C01E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbiK2MeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbiK2MeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:34:02 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3938A532F1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:34:01 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id b3so22263671lfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f9sbQEDzMM7deiFqJtWAUwlYfevD9A6Thc++FTBpOp0=;
        b=Mmwt30Cg1DoLoleoyI9sP/raJmK0bJLf1QPfunesxliFOn1RkCBqc9nhphoGwiYj4W
         uIXpnNCjw8ASeXLacpOA1hOhEUHopCTfae8bLSEXUNV9komSw65ZTHlJsmsl4tMflptF
         mEorZkyR5LJ+c7TG9fc/LzecgeONR7E3kC5JPOf19CsPoGjFex/ZkjlCYDZ6uVGNddsu
         GBO5zDwcHHVLHiJXJjgM3+X8s49mvn1stftUyyP072epEzBDFJwGGv2ln05+QfQoZMSN
         zoqdNwrUxxtoua2QCVK5FKIC+hORGuvB96CX00K6dWjz4dn/g0MEd7prfwVnUtd1k+bY
         lPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f9sbQEDzMM7deiFqJtWAUwlYfevD9A6Thc++FTBpOp0=;
        b=BVs0MEyTcd8yQ9mvR38NMOSKP/ZCxgBkBSbplVemsqkdQZgUEExd4jonFcr/+jrXKj
         BS5NZPymugEJknhQzvM6f34n0eiawonQTnCvOgS9Eh8lIeDP8Nyry/wjxNBexz5K9niU
         iB12OlmnxbgveRnIOWnDVZevk8hzK3wpD/BdGvqbk6qZjxOjL0uwPxHPx6U3cB6MVOhE
         PgNHCZGPYU+KRG22CMhdZPmUXEbsuQyVfsHRvyZzqBeLR9b2C3b0MveO6o3ngUFjv/R2
         OpYWgEdElMn2FRLJmzjGQRqat0Z2U4Myce2glxM1/BV/Pa23Xcn+rm9nG63kyEF7AvaK
         iAhQ==
X-Gm-Message-State: ANoB5pmrcO/tmkWIrp8nrKj7dS9Q4iDRZG/nsWzl2T5WFSjbC1rhW38a
        Jzk1+Pml4+kXU9xXzK/SjuRbJg==
X-Google-Smtp-Source: AA0mqf4xeT1/9X/mxp7YorBjPOl6QcZCZO8jPwRziue4qif5XnSEu77isodnRGFOf0GH36N38swjzQ==
X-Received: by 2002:a05:6512:3189:b0:4b4:e3bd:6ca0 with SMTP id i9-20020a056512318900b004b4e3bd6ca0mr12438508lfe.278.1669725239607;
        Tue, 29 Nov 2022 04:33:59 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z2-20020a056512370200b004b4a0482a53sm2179992lfr.231.2022.11.29.04.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 04:33:59 -0800 (PST)
Message-ID: <ad9720b1-fb9a-e251-bf03-1870a980b0f4@linaro.org>
Date:   Tue, 29 Nov 2022 13:33:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] dt-bindings: mfd: da9062: Correct file name for watchdog
Content-Language: en-US
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-kernel@vger.kernel.org
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>, kernel@dh-electronics.com,
        devicetree@vger.kernel.org
References: <20221122111124.6828-1-cniedermaier@dh-electronics.com>
 <20221122111124.6828-2-cniedermaier@dh-electronics.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221122111124.6828-2-cniedermaier@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2022 12:11, Christoph Niedermaier wrote:
> Replace the watchdog file name with the name currently in use.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> ---
> Cc: Support Opensource <support.opensource@diasemi.com>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Marek Vasut <marex@denx.de>
> Cc: kernel@dh-electronics.com
> Cc: devicetree@vger.kernel.org
> To: linux-kernel@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/mfd/da9062.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt b/Documentation/devicetree/bindings/mfd/da9062.txt
> index bab0d0e66cb3..e96629eb9f48 100644
> --- a/Documentation/devicetree/bindings/mfd/da9062.txt
> +++ b/Documentation/devicetree/bindings/mfd/da9062.txt
> @@ -85,7 +85,7 @@ Sub-nodes:
>  
>  - onkey : See ../input/da9062-onkey.txt
>  
> -- watchdog: See ../watchdog/da9062-watchdog.txt
> +- watchdog: See ../watchdog/da9062-wdt.txt

How is this related to LED patch? Don't mix threads.

Best regards,
Krzysztof

