Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A935A6198AC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiKDOA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiKDOAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:00:53 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1191BB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:00:51 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id c15so3043108qtw.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 07:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cmzAvR0lIiSXry6cPZqB4uuGgBneXPw0E3YJNqsCetg=;
        b=drKyDrdi2zWNQ5CRFQCnCcvvnQd4V/mdpOt+ccqlO9hPIEQb+2rnkJY518Sd/baxw5
         5g9KHW2u0KKYOK4qVZKp++5T5Ng/bKiNVQa5Sl3iw6Dlrn7ZWhL+Q0jM0JbdOHf8JzhM
         +vnI/emIjefNMz4wEQ9M+bAeQKIPxA9kfLSbmKzXDkpgwuME32pl4aA6xRNAq4odslhs
         LILddp/RpIBqiqOIBr+IRvqotY/JjAJ0I83ffFY34uilXyNNc7ZaEVWV8T6JIfWm9U7i
         sLxEg4DL0/UbEeNBmBrdOKnXrRxSYmjDJxXOdONo9I5Z3PC+0y0uPSDPtE3560i5oO0M
         g5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cmzAvR0lIiSXry6cPZqB4uuGgBneXPw0E3YJNqsCetg=;
        b=Jk325n4zjylbD5C+FoTsMQKDFpTGWZnyafpU3fL6cMrDndZLXxtX9cX2C00sSKgANW
         wrghwg4mWDEnpqvN63CGtQGijfZG580KhibDdwe8118esQibCO0sR7w60IZCc1zmMWlQ
         NIIZCqKI3a17389U2TX54vlTfxjXbZLMqej6gFMzq2V777puPjoMpx533bRWpSZv31c3
         83u1R1+XwHaPQkWTsCaRlphyqYpXkKpKfESlQdzANJxXPUNDe1TxhNJNk+FkzdDTx/4L
         bwxN0a/bDDe+p0iuyGoW7aht3y912f2JO6qx38rOzhHRQYiHjxXJkcMj5UiSffqSf5tE
         ufCA==
X-Gm-Message-State: ACrzQf2h2KTAzoSTZn2X8PlfoAStvzqXcAtF5c4PRegTjDwMnZdTyRup
        efPyE3/ARsmYkRDIC2t88/PTNQ==
X-Google-Smtp-Source: AMsMyM4gBq2xeAIqhzmX0+gb9h1/RKuDi4aymI//Q7JJ4bZQoHjK6zELkIrKbU5WV6LAOjqN5fiJHA==
X-Received: by 2002:ac8:5785:0:b0:3a5:71c:53ec with SMTP id v5-20020ac85785000000b003a5071c53ecmr28832382qta.439.1667570450170;
        Fri, 04 Nov 2022 07:00:50 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id f21-20020ac87f15000000b003a5430ee366sm2526283qtk.60.2022.11.04.07.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 07:00:49 -0700 (PDT)
Message-ID: <4bd3afed-f0c7-8479-2e35-f56f542da674@linaro.org>
Date:   Fri, 4 Nov 2022 10:00:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: soc: qcom: Add bindings for Qualcomm
 Ramp Controller
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com
References: <20221104133506.131316-1-angelogioacchino.delregno@collabora.com>
 <20221104133506.131316-2-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221104133506.131316-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2022 09:35, AngeloGioacchino Del Regno wrote:
> Document bindings for the Qualcomm Ramp Controller, found on various
> legacy Qualcomm SoCs.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../soc/qcom/qcom,ramp-controller.yaml        | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,ramp-controller.yaml

Filename based on compatible, so qcom,msm8976-ramp-controller.yaml

> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,ramp-controller.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,ramp-controller.yaml
> new file mode 100644
> index 000000000000..95ce48cfca4e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,ramp-controller.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/qcom/qcom,ramp-controller.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

Drop quotes from both lines above.

> +
> +title: Qualcomm Ramp Controller
> +
> +maintainers:
> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> +
> +description:
> +  The Ramp Controller is used to program the sequence ID for pulse
> +  swallowing, enable sequences and linking Sequence IDs (SIDs) for

s/linking/link/ if I understand the sentence correctly (is used to:
program, enable and link)

> +  the CPU cores on some Qualcomm SoCs.
> +
> +properties:
> +  compatible:
> +    items:

Drop items.

> +      enum:

I also think you did not test it...

> +        - qcom,msm8976-ramp-controller
> +
> +  reg:
> +    maxItems: 1
> +

Best regards,
Krzysztof

