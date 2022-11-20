Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC89E63138B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 12:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiKTLHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 06:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiKTLHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 06:07:00 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DBD920BC
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 03:06:59 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id z24so11732023ljn.4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 03:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xIr2q8Y2l+wilwdG0V6wIg0brdQLEMLT5ARBL9F/arc=;
        b=s9Qk4HhV4hMqLWoMFAqH4DkqhT7EWeeGt8eAonfz3fDKDAEAe7KjNF8GzBmZWtptKX
         3AkHh52nyS3Ui6E139WNcvaQC628YYRJZK5H2Dbe2LWM9ZN6SGmGIQV/RxBUgQ24i5dh
         MbFndQV9XMgtMaXLQMFPgCvlNwofOuheQGUECN+7sAGkmcevaf3Wyeucn/Ze1EqhOr6x
         ExI5DjPrw1imJSwGyy63qdIvqsRX5Xyi8HN7c9BQ1qYc7WaYlAi0STLprYtyc00BYBPs
         uyMDSvchCzrK0FQiytuvn+mOLwzIoPcmt7zgne7OBfJ8WWziK39wdbB2t80V3AGrYaGO
         q+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xIr2q8Y2l+wilwdG0V6wIg0brdQLEMLT5ARBL9F/arc=;
        b=hoWKqWIJNr+xDGSJ4ccrTSzHI8cPZhV96BcjQZ37KuSZcxLUOk49hXH89zuUtSFzWj
         z3lXM8Bl9LoVOE2t1I3x0+mhcRbHv10u6J/xUhn7hmAV17+Sd5E83drjK5BDD8tslYAx
         gf7ydmEG9lE9lVr/BEqcfVnXy/dkVw3l/da+TBd7V++2GEnfaAAjRw7ixK7T4ExFYjY/
         l3lWG/Rr5/Ps6po2T/fqNbjrs5YvfnQf0i4PYu3zGI8NZrqgRIp069uiELNe9JkkDrSe
         xXWJqBKQT8RCKLpKDDUZY8PhgQz+1a+NnexPpQhKz+7Im8e4olDxmtXpMKo9/lipgVHp
         voSw==
X-Gm-Message-State: ANoB5pm6q3jFXyAoxYBuHMwYRQaQ+0CL1vMkDRIlij8veg1BWRrJfZqG
        wGRE2RoNzVygy/l+p5nadPnmxQ==
X-Google-Smtp-Source: AA0mqf75UpkAwQi9ELawua28y4bhVc60FdGeiYcnfraxXNA39l6f9Cpw28z4XHJjdnuBGAELXXh36g==
X-Received: by 2002:a2e:990b:0:b0:277:5a8:91c8 with SMTP id v11-20020a2e990b000000b0027705a891c8mr4137786lji.173.1668942417657;
        Sun, 20 Nov 2022 03:06:57 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q29-20020ac25a1d000000b00497aa190523sm1511887lfn.248.2022.11.20.03.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 03:06:56 -0800 (PST)
Message-ID: <a5afd699-64a5-4034-88d2-95035e08c9c7@linaro.org>
Date:   Sun, 20 Nov 2022 12:06:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 1/2] dt-bindings: clock: Add QDU1000 and QRU1000 GCC
 clocks
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221118181826.28269-1-quic_molvera@quicinc.com>
 <20221118181826.28269-2-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221118181826.28269-2-quic_molvera@quicinc.com>
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

On 18/11/2022 19:18, Melody Olvera wrote:
> Add device tree bindings for global clock controller on QDU1000 and
> QRU1000 SoCs.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  .../bindings/clock/qcom,gcc-qdu1000.yaml      |  70 ++++++++
>  include/dt-bindings/clock/qcom,gcc-qdu1000.h  | 170 ++++++++++++++++++
>  2 files changed, 240 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-qdu1000.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,gcc-qdu1000.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-qdu1000.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-qdu1000.yaml
> new file mode 100644
> index 000000000000..90935a6795ee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-qdu1000.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,gcc-qdu1000.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Global Clock & Reset Controller for QDU1000 and QRU1000
> +
> +allOf:
> +  - $ref: qcom,gcc.yaml#
> +
> +maintainers:
> +  - Melody Olvera <quic_molvera@quicinc.com>
> +
> +description: |
> +  Qualcomm global clock control module which supports the clocks, resets and
> +  power domains on QDU1000 and QRU1000

Keep the same style as existing files. They were cleaned up recently.

> +
> +  See also:
> +  - include/dt-bindings/clock/qcom,gcc-qdu1000.h

Keep the same style, so missing '::', drop '- '.

> +
> +properties:
> +  compatible:
> +    items:
> +      - const: qcom,gcc-qdu1000

SM8550 is coming with proper style of compatible, so let's do the same
also here: qcom,qdu1000-gcc
(and file name matching it)


> +      - const: syscon

I don't see usage of it as syscon. Which parts of GCC are needed for whom?

> +
> +  clocks:
> +    items:
> +      - description: Board XO source
> +      - description: Sleep clock source
> +      - description: PCIE 0 Pipe clock source
> +      - description: PCIE 0 Phy Auxiliary clock source
> +      - description: USB3 Phy wrapper pipe clock source
> +    minItems: 2

Same question as for SM8550 - why inputs are flexible? Either you have
these or you do not.

> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +  '#power-domain-cells':
> +    const: 1

Missing ref to gcc.yaml. Drop all properties provided by gcc.yaml.

> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - '#clock-cells'
> +  - '#reset-cells'

Drop these required by gcc.yaml.



Best regards,
Krzysztof

