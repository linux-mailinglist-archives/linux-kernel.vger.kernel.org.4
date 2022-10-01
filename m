Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943765F1B3A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 11:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiJAJYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 05:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJAJYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 05:24:16 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D1516F85F
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 02:24:14 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id f21so3268097lfm.9
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 02:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Fc50t9UKzxVvL8PTyGxChRwbStVHfCHE+ON7VUqmF48=;
        b=mwEtMS1SisCiOhK4RErZSzrbX+Gc4yWIxR7F0fE4iiiX5R76eIU3a6ISIuqTjK2R28
         xvLJ7B+qkhDGoGBonxQ+NQ8n8/8uUrXcuLtm+rmTRojoMdhvG7qpDsOb33ByTudn4OGx
         srZ17+E+GWsPvfcdxh3bFmRAJkNrl655918R8l6+xnR9H/xMRQxRQkIJdfJP02r/8KfW
         rksFHe5OUZCVCQurs2vNcf5xuMJN6geRVfiC8fjQUZPWnigYyviTb3VVG2/e55jsSt0e
         TqdZ1zuh4laI7TgJERHtwFXm5RIEClxuOCIrnLZG/CxNwxFWe/OCoy/g3/gtNuxXxIyi
         B/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Fc50t9UKzxVvL8PTyGxChRwbStVHfCHE+ON7VUqmF48=;
        b=rBtq3ekThXuNsZPN9WlBRlxilhGOkXl9SrZfBrUJyhICQkBwonQ50DJbPESmYNSTCU
         Jhf7SfdCUljDwZLGQ40EKorzf1UvOgf3NxZshLxN42SA7qP/irskA9/jUnR134keQktB
         zOPwSNDeR3HrwnTZxQOJ5UKbeeFPQ2uD0/kbxcYpE4vE1jeLGI9tjfAoKC1iPvagGSuJ
         oRzBmm6B+JVtEDiU/tX/wVe09pbGJw5/CNK3xIwjLgrMKUhp/OsyxikLZ/X/GWsrABwE
         gBNwusfY+vkE9Xp3GQ+dWPsh0akvRW8rVVti4xs2dK+ZQrAADqn/iCB4YdoODU7r0QFi
         4ASA==
X-Gm-Message-State: ACrzQf2oaVIyQTfFlmpjuCq1zQPKuvbluHZhSsnRtdDP7oB59uw+gKh0
        UOlG5FQ7TF40PFjICLU9OshNhA==
X-Google-Smtp-Source: AMsMyM5fLHf7HBsFLnNmQZqpkbQDjqKfKtJE8Duk8BHTPlMZL17v6lNpkm1rlicTGecHpI/zN5iwqw==
X-Received: by 2002:ac2:5928:0:b0:4a2:2819:4fb2 with SMTP id v8-20020ac25928000000b004a228194fb2mr403326lfi.183.1664616252442;
        Sat, 01 Oct 2022 02:24:12 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id f5-20020a056512228500b00492dfcc0e58sm703180lfu.53.2022.10.01.02.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 02:24:11 -0700 (PDT)
Message-ID: <37926f0f-e176-929e-939a-cd43a031e224@linaro.org>
Date:   Sat, 1 Oct 2022 11:24:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/5] dt-bindings: clock: Add QDU1000 and QRU1000 GCC clock
 bindings
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221001030403.27659-1-quic_molvera@quicinc.com>
 <20221001030403.27659-2-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221001030403.27659-2-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2022 05:03, Melody Olvera wrote:
> Add device tree bindings for global clock controller on QDU1000 and
> QRU1000 SoCs.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  .../bindings/clock/qcom,gcc-qdru1000.yaml     |  74 ++++++++
>  include/dt-bindings/clock/qcom,gcc-qdru1000.h | 170 ++++++++++++++++++
>  2 files changed, 244 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-qdru1000.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,gcc-qdru1000.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-qdru1000.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-qdru1000.yaml
> new file mode 100644
> index 000000000000..d92f558d547c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-qdru1000.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,gcc-qdru.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Global Clock & Reset Controller Binding for QDU1000 and QRU1000

Drop "Binding"

> +
> +maintainers:
> +  - Melody Olvera <quic_molvera@quicinc.com>
> +
> +description: |
> +  Qualcomm global clock control module which supports the clocks, resets and
> +  power domains on QDU1000 and QRU1000
> +
> +  See also:
> +  - dt-bindings/clock/qcom,gcc-qdru1000.h

Full path

> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,gcc-qdu1000
> +      - qcom,gcc-qru1000
> +
> +  clocks:
> +    items:
> +      - description: Board XO source
> +      - description: Sleep clock source
> +      - description: PCIE 0 Pipe clock source (Optional clock)

Skip "Optional clock"

> +      - description: PCIE 0 Phy Auxiliary clock source (Optional clock)
> +      - description: USB3 Phy wrapper pipe clock source (Optional clock)
> +    minItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: bi_tcxo
> +      - const: sleep_clk
> +      - const: pcie_0_pipe_clk # Optional clock

Skip "Optional clock"

> +      - const: pcie_0_phy_aux_clk # Optional clock
> +      - const: usb3_phy_wrapper_gcc_usb30_pipe_clk # Optional clock
> +    minItems: 2
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +  - '#reset-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,rpmh.h>
> +    clock-controller@100000 {
> +      compatible = "qcom,gcc-qdu1000";
> +      reg = <0x00100000 0x001f4200>;
> +      clocks = <&rpmhcc RPMH_CXO_CLK>, <&sleep_clk>;
> +      clock-names = "bi_tcxo", "sleep_clk";
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +    };
> +
> +...
> diff --git a/include/dt-bindings/clock/qcom,gcc-qdru1000.h b/include/dt-bindings/clock/qcom,gcc-qdru1000.h
> new file mode 100644
> index 000000000000..cdc5d1a6a007
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,gcc-qdru1000.h
> @@ -0,0 +1,170 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */

Dual license.


Best regards,
Krzysztof

