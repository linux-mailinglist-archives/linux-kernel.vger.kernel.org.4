Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96282638504
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 09:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiKYILI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 03:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiKYIK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 03:10:56 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1009C21E01
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 00:10:55 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id a29so5722663lfj.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 00:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sL1NUAu6lSv+jlMLYFhjd/8Pjp4yH4Gi/+vBxDoZ+ks=;
        b=g3+PUwY4xc1OsQmrGhCpvVD+xktnoc9Q+9u9ZqE5ygYSKXtbkKc7gSdri4jQDsAhE3
         TDBzrmi0Lr38VfXcPtrPK77gCo/Bt6uzdnQftL5A6rgpSiP/C8+zMyhCHB9nVHg8iKZK
         +F6ItGNB20GLolup29DA+M+kgJojEQ8Pv09lUdMwbzfe9Czs9tjflxTouy9zKvnf5k14
         XQUIZutT+Snv52pnteTN7AqffK7zKfk4W2gdY473UEJ9QSKf4BXjsrlH8qSfHi1dEthw
         vL6E+F9OWHpv0STEwfrsokr51+gGm5iHmpMvpdF6FroJYOdLlmCEH8r/hCTcQsPa609J
         TUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sL1NUAu6lSv+jlMLYFhjd/8Pjp4yH4Gi/+vBxDoZ+ks=;
        b=yBkP1UwpEMjVgwbg0M28RkujzC2Dz+OjHRGIc2L8jR1/GiS+75sWmlUku7OeLDaxSa
         /l0cuEP7tM4rg2nTO/ZADxbg+46G0ebK+4d/Of56xqfiOckmwOby+m2EbIi8TxxIRI/s
         vOZ4LGp03AzouP17Pg4tcOAO0eMcMivDECy3lbqi/c1PQmuFd2PaIsJzE8TOjcKDXWp9
         YwPOjBYtBAOouTEzMHtD4/pnmrVmlJ0BHeE+yoTjmSPe3mo+9LwDBISLAsTOvhzimQY7
         STLivViLXhCSlRPx3ze9ltEFl9LvEuS45LiKe1Zhw2gUh9M4gjh1RFeFdepQWfhY3rpW
         et/A==
X-Gm-Message-State: ANoB5pnC0Hwp9axPCQiKhdCYMnjyXynr5qCI8CasbICM7wm0xwQW/PEK
        JvhUWyURRBszwnuKX951KDSNGg==
X-Google-Smtp-Source: AA0mqf6hra2shSkxsPNtb/2b1IHlfQhtErf0xh49kwt893xjrDT83WbRMB9jez0ppNQJlVyiYecu5Q==
X-Received: by 2002:a05:6512:c29:b0:4b1:b061:4815 with SMTP id z41-20020a0565120c2900b004b1b0614815mr11672276lfu.18.1669363853422;
        Fri, 25 Nov 2022 00:10:53 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s6-20020a056512214600b004afac783b5esm425357lfr.238.2022.11.25.00.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 00:10:52 -0800 (PST)
Message-ID: <8fe3c2a6-845a-06ab-1164-9ddd4f5e5ac9@linaro.org>
Date:   Fri, 25 Nov 2022 09:10:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 3/4] dt-bindings: sram: sunxi-sram: Add regulators
 child
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20221125040112.18160-1-samuel@sholland.org>
 <20221125040112.18160-4-samuel@sholland.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221125040112.18160-4-samuel@sholland.org>
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

On 25/11/2022 05:01, Samuel Holland wrote:
> Some sunxi SoCs have in-package regulators controlled by a register in
> the system control MMIO block. Allow a child node for this regulator
> device in addition to SRAM child nodes.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
> Changes in v4:
>  - Remove unevaluatedProperties from regulators schema reference
> 
> Changes in v3:
>  - Require the regulators node to have a unit address
>  - Reference the regulator schema from the SRAM controller schema
>  - Move the system LDOs example to the SRAM controller schema
>  - Reorder the patches so the example passes validation
> 
> Changes in v2:
>  - New patch for v2
> 
>  .../allwinner,sun4i-a10-system-control.yaml   | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
> index 98a7dc7f467d..c487ac9521e9 100644
> --- a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
> +++ b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
> @@ -56,6 +56,9 @@ properties:
>    ranges: true
>  
>  patternProperties:
> +  "^regulators@[0-9a-f]+$":
> +    $ref: /schemas/regulator/allwinner,sun20i-d1-system-ldos.yaml#
> +
>    "^sram@[a-z0-9]+":
>      type: object

You could add allOf:if:not:...then: clause making regulators as false
for all variants which do not support it. This would make it more specific.

Anyway:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

