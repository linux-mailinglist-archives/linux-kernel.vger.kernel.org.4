Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF701747CE5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjGEGRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjGEGRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:17:12 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D426710EC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 23:17:10 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b69ed7d050so101721671fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 23:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688537829; x=1691129829;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=90vFHFNv8Z4EnqFJciqEXi399O0ahUbhYDsrlxPDfUA=;
        b=ZmcAsyvfEgsv3Kwm+U6DlC5Ix5sl36izoQPtKwWwQXUXXk9e96NWXqqiH/MdmdOQ68
         6Y+kREJdwA7kgrbS+bngxnH+GlQfk/5CvT4xdIbRB8j0e9JsV5KwoLN4h3w4XeVrPOZ9
         gyopY24vIoXs2o/zSgUQJO189T7kUPedathiv/f1g4jMjrWmJTTsrwIuoM36YCk4epoK
         3qtnWlIf12SBeOj7oQ1uxCrRsUkLVuE1VzzGPYF/nditBmMYJ2kca1xN+Xl3xlpwHCJd
         iF0A6izZqoI/LQL0dwhehqI/cgJnzGT/EjBz3nXouh5WwOSXCIM9ILveifP2hrDqEh7P
         CbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688537829; x=1691129829;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=90vFHFNv8Z4EnqFJciqEXi399O0ahUbhYDsrlxPDfUA=;
        b=EIrXH2/mNJTK6abjQw+5N4cnX+0FYT0Wy34Q56b2w8xsZAsT27YBG0e+yD0/CUdds4
         La+pBH+veNEn163Ao+3D4raIrxd1wV5E+9fLpPNURwo/fMamYZA8SWo/rLLCjxAjtkxb
         LVKGM9z6jkAsm8y7Wmds07CCpFagHNrf4tPVcK1IT+GcYtOp2+4RrcS9djZwqaDpLDd5
         KN/OtXU9e6As/pZYOOjPYYCKqefylVHF9/0o2A3PMz/saqP0qBlh7DDyxgxbngS7qu79
         QJy1Uea4+ZOF+UpJQshiF+k0mqD17jXsmNwiVrGJLalgHi3rPbCDK62mBNPH6wtHefM4
         UB0g==
X-Gm-Message-State: ABy/qLagIn0pi9xCRLI18Kh3IZcUcBT6GE80dVHdoLGqZfKMNGZtpsj8
        lIgdg/2xgboe5Xm2XJMhkjJWag==
X-Google-Smtp-Source: APBJJlFEGjzSwAu/PuXg2rA//CTojQCgKRBCyvzFiOBPJoQUTeMenTuSrLxZqCx2g7wC+7Wnju1qjA==
X-Received: by 2002:a2e:6a0f:0:b0:2b6:cf18:77e0 with SMTP id f15-20020a2e6a0f000000b002b6cf1877e0mr10155024ljc.48.1688537829112;
        Tue, 04 Jul 2023 23:17:09 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id r19-20020aa7cfd3000000b0051e06693590sm4552748edy.91.2023.07.04.23.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 23:17:08 -0700 (PDT)
Message-ID: <d339d413-5242-0d5a-96f6-c2f670e5e5dc@linaro.org>
Date:   Wed, 5 Jul 2023 08:17:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V7 1/2] dt-bindings: firmware: bootstats: Add the dtschema
Content-Language: en-US
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1688533340.git.quic_schowdhu@quicinc.com>
 <b3105990e021a71039f621e6c4e70ab05fb348fa.1688533340.git.quic_schowdhu@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b3105990e021a71039f621e6c4e70ab05fb348fa.1688533340.git.quic_schowdhu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2023 07:32, Souradeep Chowdhury wrote:
> Add the device tree bindings for boot stats. This has 2 properties
> pre-abl-time and abl-time which records the timestamps for boot
> stats.
> 
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> Link: https://lore.kernel.org/linux-arm-kernel/7d397e67-5d56-4975-98af-1ac9746c07f4@app.fastmail.com/
> ---
>  .../bindings/firmware/qcom,bootstats.yaml     | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/qcom,bootstats.yaml
> 
> diff --git a/Documentation/devicetree/bindings/firmware/qcom,bootstats.yaml b/Documentation/devicetree/bindings/firmware/qcom,bootstats.yaml
> new file mode 100644
> index 000000000000..22e697524058
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/qcom,bootstats.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/qcom,bootstats.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Boot Stats

This explains nothing...

> +
> +maintainers:
> +  - Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> +
> +description: |

Drop |

> +    Qualcomm's proprietary Android boot-loaders capture boot time

Wrong indentation.

> +    stats, like the time when the bootloader started execution and
> +    at what point the bootloader handed over control to the kernel.
> +    This is captured in the unit of ms in devicetree property.
> +
> +properties:
> +  pre-abl-time:
> +    description: The property to store the starting point of abl in ms.

String instead of ms? No, this is the craziest idea I saw recently. Use
-ms suffix.

> +    $ref: /schemas/types.yaml#/definitions/string-array
> +
> +  abl-time:
> +    description: The property to store the duration of abl in ms.
> +    $ref: /schemas/types.yaml#/definitions/string-array

I have no clue what this entire binding is about. Nothing can bind to
it, no usage explained. Properties are not used to "store the duration".
This does not look like suitable for DT, drop entire binding.

> +
> +required:
> +  - pre-abl-time
> +  - abl-time
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    bootstats {
> +        pre-abl-time="17627";
> +        abl-time="26748";

Missing spaces. Open existing DTS and look at existing coding style.

Best regards,
Krzysztof

