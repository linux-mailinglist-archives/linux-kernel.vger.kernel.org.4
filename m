Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2045A6990E5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjBPKQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjBPKQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:16:41 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D245BAD3A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:16:33 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ky6so3995821ejc.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1PGfu87n+hgkCIk36FgbHQSfTL8/6kgTjaQ8jrg0Ats=;
        b=bdq663wbjD24ghnHeXgGD6EGbUp7AIvfKEgI9DQRcRH9gTESHtdCEP7mLV0Ity05FG
         w4FGwXA2AAgNlrGpqx3XsQ1Iuu6NLZ9JARLR0TeN7DeieQkn+O7X8um2FVzK7ef1/gD3
         15VJYoAEyMSeiyIXTT19pDbBA+N7uD3S6qtoEFuwCyBaUzcqdUdEc63fR4znfYZ3GE/L
         2UU2hdnfjLZ8nL+Qc95XLLi5pBpPPWst/bs1yqMGdxuhHVKKJnBwcmaxqpBKdBKZVINj
         Ry9w0T2HiIqLe66BDEdLRgnJUea1IlHr72mauDYUMNbH6yoVa7js5VulW79HDZyzkfne
         ydEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1PGfu87n+hgkCIk36FgbHQSfTL8/6kgTjaQ8jrg0Ats=;
        b=Jxp8tZxLacKTsn8O9WqncANQC5/PCaxY1J6jA+ciAIAffJKrzaHWOtWRogodO3ZK5V
         kAunGIgTrOD0ARXh1yL7INZslYbMPwB7wZERVTs0Xg5x/gStBWfz8BaU4BENDCRLuEcc
         YRAZAqdh+2PWO7dBSBugeBcSKG2FdPpTlpCGXq+jP2i80lqcM/Q+OoHQ8lTkG4Yt6nK9
         v5T0+NdR9TdsCVGao4G9c0QRMxe34dFQuUNvROm9voPsigsXuNZ/iwNG41bcZMpxvh9q
         7LqcCn2gzXLbc8J4awQixUgUHGZnzCoGlf9A5qLBXQdQ/qjWf532JNyw4ehTQK/YNG19
         Vgbw==
X-Gm-Message-State: AO0yUKW4pPwEKWqNqPi4tZOU2+2q39kyffrgeWPRMfptkPbVqAi6KLZy
        7qnRegyWiTHHXvzz9Eb+W1v7Ng==
X-Google-Smtp-Source: AK7set+Oth8dBTqhGPae0wFBpF8ml/E+UZSUs8kHq7UOo5kVGdEYYpxh2OC2JupksHXkw09jWLt+Vw==
X-Received: by 2002:a17:906:3659:b0:888:94d3:37f5 with SMTP id r25-20020a170906365900b0088894d337f5mr4915515ejb.63.1676542592391;
        Thu, 16 Feb 2023 02:16:32 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k2-20020a50ce42000000b004acbecf091esm624327edj.17.2023.02.16.02.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 02:16:32 -0800 (PST)
Message-ID: <dcdd0a62-8d1f-d9b1-6137-34d9e68313a1@linaro.org>
Date:   Thu, 16 Feb 2023 11:16:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/7] dt-bindings: clock: split qcom,gcc-ipq4019 to
 separate file
Content-Language: en-US
To:     Robert Marko <robert.marko@sartura.hr>, andersson@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr
References: <20230214162325.312057-1-robert.marko@sartura.hr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230214162325.312057-1-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 17:23, Robert Marko wrote:
> Move schema for the GCC on IPQ4019 platform to a separate file to be able
> to allow passing XO and sleep clks directly to GCC.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  .../bindings/clock/qcom,gcc-ipq4019.yaml      | 53 +++++++++++++++++++
>  .../bindings/clock/qcom,gcc-other.yaml        |  2 -
>  2 files changed, 53 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-ipq4019.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq4019.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq4019.yaml
> new file mode 100644
> index 0000000000000..6ebaef2288fa3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq4019.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,gcc-ipq4019.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Global Clock & Reset Controller on IPQ4019
> +
> +maintainers:
> +  - Stephen Boyd <sboyd@kernel.org>
> +  - Taniya Das <tdas@codeaurora.org>
> +  - Robert Marko <robert.markoo@sartura.hr>
> +
> +description: |
> +  Qualcomm global clock control module provides the clocks, resets and power
> +  domains on IPQ4019.
> +
> +  See also:: include/dt-bindings/clock/qcom,gcc-ipq4019.h
> +
> +allOf:
> +  - $ref: qcom,gcc.yaml#
> +
> +properties:
> +  compatible:
> +    const: qcom,gcc-ipq4019
> +
> +  clocks:
> +    items:
> +      - description: board XO clock
> +      - description: sleep clock
> +
> +  clock-names:
> +    items:
> +      - const: xo
> +      - const: sleep_clk
> +
> +required:
> +  - compatible

Aren't the clocks now required? Will it keep working without them?

Best regards,
Krzysztof

