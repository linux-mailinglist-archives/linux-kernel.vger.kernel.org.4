Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8AE6C2B21
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjCUHOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjCUHOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:14:09 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE8F19C47
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:14:06 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id cn12so10255738edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679382845;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RpFiX0kGSU3MmscTQy/8QOp1uiypHFRfPT7CenGfskI=;
        b=Ko+Rzx/RKcfeOZxi63DixRfyGBEy4+A/fIXbxkxRhPs06nPrmJGPpHihuOuyXwR5L/
         V/dbazwfMzfdjgmST5WTYMP2S3uAJduFP2GT9rC7LtmwKIGvgnUWmi3fj1sdGZchqb44
         M2CJKqg9B9qOLH1aEXIc82d7ekklCZPRosH8JvM9+fm9xZf0A75L0U8IxLaL4SALR64/
         e/skkVxYlVo6umq/wqdPTC/8b+W7iqvsAerrF44GiNBhKg9Ln8dGuubYWF/RB1Iw6TGr
         rKzxfJszS6iido/EEu9L2B7iIsrYpHdlVMwqEfKsAsOToaNh3N9Sd5q9ma7dO8JLA1As
         HIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679382845;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RpFiX0kGSU3MmscTQy/8QOp1uiypHFRfPT7CenGfskI=;
        b=2QVGwQBBOsj8begJqCEVKNqCRrRbiHknvl3aGetnOuLsEPiKiUN/z88mF3Bg/vRQw/
         D1TsEHEGhZ3ndA69AGyOMHjpup/K1839gHaEcYNn0uJEBnb9yq29bB/zljypAIjCIf56
         +97k9nmiKnFfih4TGfuVdJs+hEQX9nVooQArdwbaZdWIY3yH92B2YHbx4LrIr/TRIRYb
         KkKX672pk9Il+K56Vw7RDHphc1wC4wr9+uRyQvq/cbDrSTBB7Ym++pXAr0IVs/dkGPhi
         qlZv6jQzRVIDaKypJrJfHu2XNqwhdmF4+2Zmqaat6H281bVZMTGNA4/lAlFZWVItWKvI
         +OLw==
X-Gm-Message-State: AO0yUKWt/6kqghUiQblrGlEINEOkx6aaPcfpr55kU+UpebKoggGP6WMx
        tgZE42vKt66IU0dXZl380GZlXA==
X-Google-Smtp-Source: AK7set8YbhRjK1nsoK2w12o2BUz+XcJUSI/ULYsqTpkQiEwlmX58cny9P9DXEL6QlYFOpF3ZU8MZDQ==
X-Received: by 2002:a17:906:7054:b0:932:4eea:17ce with SMTP id r20-20020a170906705400b009324eea17cemr1584920ejj.39.1679382845028;
        Tue, 21 Mar 2023 00:14:05 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:2142:d8da:5ae4:d817? ([2a02:810d:15c0:828:2142:d8da:5ae4:d817])
        by smtp.gmail.com with ESMTPSA id n15-20020a170906118f00b0092421bf4927sm5458201eja.95.2023.03.21.00.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 00:14:04 -0700 (PDT)
Message-ID: <3f5e01bd-24ee-66cc-1a5d-b3fc09c2a96d@linaro.org>
Date:   Tue, 21 Mar 2023 08:14:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/3] dt-bindings: timer: Add timer for StarFive JH7110
 SoC
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>
References: <20230320135433.144832-1-xingyu.wu@starfivetech.com>
 <20230320135433.144832-2-xingyu.wu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230320135433.144832-2-xingyu.wu@starfivetech.com>
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

On 20/03/2023 14:54, Xingyu Wu wrote:
> Add bindings for the timer on the JH7110 RISC-V SoC
> by StarFive Technology Ltd.
> 
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>  .../bindings/timer/starfive,jh7110-timer.yaml | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/starfive,jh7110-timer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/starfive,jh7110-timer.yaml b/Documentation/devicetree/bindings/timer/starfive,jh7110-timer.yaml
> new file mode 100644
> index 000000000000..24b34618f2c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/starfive,jh7110-timer.yaml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/starfive,jh7110-timer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 Timer

Actually one change is needed - missing blank line.

> +maintainers:
> +  - Xingyu Wu <xingyu.wu@starfivetech.com>
> +  - Samin Guo <samin.guo@starfivetech.com>
> +


Best regards,
Krzysztof

