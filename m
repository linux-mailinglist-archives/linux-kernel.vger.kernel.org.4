Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A222B6C019B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 13:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCSM1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 08:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCSM1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 08:27:43 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F5B1688D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:27:41 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x3so36826948edb.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679228859;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vpXswiCO9GB0qu55ryOfXAbsqOrMXNnhgIThuXGMTNY=;
        b=OaWSkRBcfDqZWIslAVamjhJiU3cHzQzosvRanoQ80UIEIXWiE7Snmef3ToMKGRsEDb
         Y2DJ/pRZ43GQ5LHSMf4Nant/F7oWYzoSCczgvmtsAofwXpUDHzvNMJyQ49x90lI/uqHK
         ejW8+O4MFn9sTyWdqt9uEQqTJRGzwDRwQl+BSxZXoEvwBKKuOXoQS/14jhzcx/GILPlB
         +4oDqHzdjmouOSgnR/1XEEJGEyMZ3r1XhKZJTJpCzNQnmbx6mWaJGm+27t08qhz1Q4ai
         uOoczqEUyVmzDPnEMNdTAxHdU2bb+uuJOSeB6i8aEmOqr3VtjU2TJeuMuvnpg42LFdJi
         80kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679228859;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vpXswiCO9GB0qu55ryOfXAbsqOrMXNnhgIThuXGMTNY=;
        b=Lzwdue3gjK1uYKlol7fIahfkPy8czR12QfkjmAIl34EjcFBFaTaZdq5Sz/0TRNepSd
         QBoNF6FuIedohrCO5gkfR09csVT8px5JKemJP8RLLwTnzt/dFfjE0jegtqneSfCusVyV
         NscnMraFrwZ9RfNrdZ371tm5FnLSM3dh48fw87JRa7EiBB8bPWLKFBcUCg1XXo+j4sZZ
         se8al9dnLI614nPTioiF2trEqwBu7SEGS7l8AneCT1W88XvwpPPyU0tvtrfK7/gdaNS3
         ndxq/T+u43p4YEbVT/w+VjEpTp+R+PpDe4e+g87kt+1xNAOBtY1k37aDX7gpCtgr2vuF
         JTIA==
X-Gm-Message-State: AO0yUKUMu9yRn2E3gDy8FRmAk7wavkRRHEJ4KDhakuS6puHA9b+PLO0c
        0eahi+2DUSf0IkKThGw0BOGlhq1FfYZLNte9aIU=
X-Google-Smtp-Source: AK7set9PEnNM5+lFe8SRWo0V5rbiUBCudxT8Q1O2pMeHvat/q7nGBevUPI6NChgGzdYoQQdm9E1nBw==
X-Received: by 2002:a17:906:6055:b0:907:183f:328a with SMTP id p21-20020a170906605500b00907183f328amr5567888ejj.65.1679228859492;
        Sun, 19 Mar 2023 05:27:39 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5b5f:f22b:a0b:559d? ([2a02:810d:15c0:828:5b5f:f22b:a0b:559d])
        by smtp.gmail.com with ESMTPSA id b9-20020a17090630c900b008bc8ad41646sm3155993ejb.157.2023.03.19.05.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 05:27:39 -0700 (PDT)
Message-ID: <850bc37e-c6d1-2381-a851-965a4cbee8a0@linaro.org>
Date:   Sun, 19 Mar 2023 13:27:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RESEND v6 1/2] dt-bindings: soc: starfive: Add StarFive syscon
 doc
Content-Language: en-US
To:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>
References: <20230315055813.94740-1-william.qiu@starfivetech.com>
 <20230315055813.94740-2-william.qiu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315055813.94740-2-william.qiu@starfivetech.com>
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

On 15/03/2023 06:58, William Qiu wrote:
> Add documentation to describe StarFive System Controller Registers.
> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  .../soc/starfive/starfive,jh7110-syscon.yaml  | 41 +++++++++++++++++++
>  MAINTAINERS                                   |  5 +++
>  2 files changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
> new file mode 100644
> index 000000000000..ae7f1d6916af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/starfive/starfive,jh7110-syscon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 SoC system controller
> +
> +maintainers:
> +  - William Qiu <william.qiu@starfivetech.com>
> +
> +description: |
> +  The StarFive JH7110 SoC system controller provides register information such
> +  as offset, mask and shift to configure related modules such as MMC and PCIe.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - starfive,jh7110-aon-syscon
> +          - starfive,jh7110-stg-syscon
> +          - starfive,jh7110-sys-syscon
> +      - const: syscon

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

... or your PLL clock controller was not tested.

Best regards,
Krzysztof

