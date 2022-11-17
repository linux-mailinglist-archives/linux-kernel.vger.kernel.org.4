Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F70462D5E5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239385AbiKQJIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239698AbiKQJIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:08:12 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED737701B8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:08:08 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id a15so1872271ljb.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YJmwEeDCZ7aVqLSslRbn+/l8usV2WQUBIb4DD7rqeRE=;
        b=RdHAiOmt853MjlGknYSMShC2oWEHquoYcIYQW6hjq+tAPXph15iccsRdl4mVfofFBx
         EH78FTsw1oP/833JHYm/E4tHAEJO9Sp/YNBvmpolJaxX9TM9HXtdXJ9LXk9DcRzxhMnO
         kiMQtkN0h/4s5tAAweOHjXCZOhunLyDANjWshAkorw7P7tJQ1oJHkjGfK03W499S9wMQ
         GVFim4oY7z1DBugG3ovT+BOqMl90jfsYAwHxtR/peotFcbDW8o4YEmrEvUEbYyb8eCei
         DSRSLDbg9Qjs3QqbE7wcY1Kzqe2v+SalRPq3zXD69/NDYhYsUxTEouVq2QYMObPruT9B
         3how==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YJmwEeDCZ7aVqLSslRbn+/l8usV2WQUBIb4DD7rqeRE=;
        b=mOPJHElxjgZ2RRn8ZPKngLRysmfVLIVvfoIOGgvP+9ezQFQn7bSd1OsQJPSJmhxdIW
         iPFSCl7Ub7I91EfUDMcb1Ln8aDa5kVfZarkf/CiqiJkQsqZnXyPKA6Adpj978V+wTyi0
         Mk9iCC0d9oUjftI98H3Hfm3JUr5D8it3nwGFnuHaV1L+BBNIPMVuaKCX/sLduzkys7pE
         mWZ8eErpEqG9kGmdbDoQql2tH1honeOb8uOJgGAucklvR0zXz6+NzVQBvkHL3cTfJX+2
         lBENXkoR0b9W/qxw1eA4SUKbvSqUv9+M4/7cR+RdFyspSrDunDEZM612vfnKpRrlSrST
         tLiA==
X-Gm-Message-State: ANoB5pl/1aqt63g/2Pleetm7OQ1gHRcJYZWK+ceH41l59scZqr2vsWQB
        1eY+7OsIhMT4GJRPXt9HGrbHaA==
X-Google-Smtp-Source: AA0mqf52rV8dFYDZNPA9BZ6hrWw3ne9D0FBtvdmUOP65It1xWXsCFjQDXMrqEMXn4Tw1lyrg/pm4/Q==
X-Received: by 2002:a2e:b54f:0:b0:276:ff0c:b7d1 with SMTP id a15-20020a2eb54f000000b00276ff0cb7d1mr706909ljn.164.1668676087215;
        Thu, 17 Nov 2022 01:08:07 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d14-20020a056512368e00b00494706193adsm51540lfs.208.2022.11.17.01.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 01:08:06 -0800 (PST)
Message-ID: <c298fd71-22e9-98c5-14c6-88b078687b3d@linaro.org>
Date:   Thu, 17 Nov 2022 10:08:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/9] dt-bindings: clock: Add SM8550 GCC clock bindings
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20221116104716.2583320-1-abel.vesa@linaro.org>
 <20221116104716.2583320-2-abel.vesa@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221116104716.2583320-2-abel.vesa@linaro.org>
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

On 16/11/2022 11:47, Abel Vesa wrote:
> Add device tree bindings for global clock controller on SM8550 SoCs.

Subject: drop second, redundant "bindings".

> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../bindings/clock/qcom,gcc-sm8550.yaml       |  88 +++++++
>  include/dt-bindings/clock/qcom,gcc-sm8550.h   | 231 ++++++++++++++++++
>  2 files changed, 319 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sm8550.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,gcc-sm8550.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sm8550.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8550.yaml
> new file mode 100644
> index 000000000000..a2468167c8ab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8550.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,gcc-sm8550.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Global Clock & Reset Controller Binding for SM8550

You need to base on recent bindings. See commit ece3c3198182a1.

> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +
> +description: |
> +  Qualcomm global clock control module which supports the clocks, resets and
> +  power domains on SM8550

Ditto

> +
> +  See also:
> +  - dt-bindings/clock/qcom,gcc-sm8550.h

Ditto

> +
> +properties:
> +  compatible:
> +    const: qcom,sm8550-gcc
> +
> +  clocks:
> +    items:
> +      - description: Board XO source
> +      - description: Sleep clock source
> +      - description: PCIE 0 Pipe clock source (Optional clock)

Drop "(Optional clock)"

> +      - description: PCIE 1 Pipe clock source (Optional clock)
> +      - description: PCIE 1 Phy Auxiliary clock source (Optional clock)
> +      - description: UFS Phy Rx symbol 0 clock source (Optional clock)
> +      - description: UFS Phy Rx symbol 1 clock source (Optional clock)
> +      - description: UFS Phy Tx symbol 0 clock source (Optional clock)
> +      - description: USB3 Phy wrapper pipe clock source (Optional clock)
> +    minItems: 2

This does not look correct. Why clocks of GCC are inputs clocks to GCC?

> +
> +  clock-names:
> +    items:
> +      - const: bi_tcxo
> +      - const: sleep_clk
> +      - const: pcie_0_pipe_clk # Optional clock
> +      - const: pcie_1_pipe_clk # Optional clock
> +      - const: pcie_1_phy_aux_clk # Optional clock
> +      - const: ufs_phy_rx_symbol_0_clk # Optional clock
> +      - const: ufs_phy_rx_symbol_1_clk # Optional clock
> +      - const: ufs_phy_tx_symbol_0_clk # Optional clock
> +      - const: usb3_phy_wrapper_gcc_usb30_pipe_clk # Optional clock
> +    minItems: 2
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +  '#power-domain-cells':
> +    const: 1
> +
> +  reg:
> +    maxItems: 1

Drop all duplicated properties and use qcom,gcc.yaml. See commit
842b4ca1cb8cf54

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +  - '#reset-cells'
> +  - '#power-domain-cells'

Drop redundant entries.

> +
> +allOf:
> +  - $ref: qcom,gcc.yaml#
> +

Best regards,
Krzysztof

