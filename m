Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC5B6014AA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiJQRU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJQRU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:20:56 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D4A642C2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:20:53 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id de14so7820660qvb.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d8KFvXWXk+yHpFJT0KTXsfMVjC6a7dZVFBnEd/ZjfUI=;
        b=wf/PwgJ+34F7/B0pCzFjaKHZmmo9BpTXsHL/cr3KMWfaitH5BdFvQnDtuQJn8txoHT
         J0m4i7BCubMwdI8Sb8A8D/kWG4s5Gr66h1DeBNFd8NU3UCHm0N21AMI/nczPyaaPmizi
         v2Ger7sY7Bks0BYMqmBl0gWu+UYdbcKA2xB9e6ze+eNLcElnazUc7foBOURKeeIZPHO7
         4AYmUj1SmNorM8nI1dG9t7z1ZSQnpfcge2nZYjS4UZc0mds6hIUy3+49uQzG7TXIRsFS
         5ZTp/KB18Qe1dy6g62cTgPwbGMwFD7dc1xyQFagDirmlVJdOpEPiRie2a6vsl6mpxp5q
         k7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d8KFvXWXk+yHpFJT0KTXsfMVjC6a7dZVFBnEd/ZjfUI=;
        b=gtShY7il7wU9XZm+jVjQ0FidIZ2PiNO21j9coR0ihmf5iWG3RHpHAcA4dlxGUySskd
         sNpY6i+doQNB0ZHOE0Wwwuvn5gE+KWij5Ws3kOpFZjMcj8HcSPQkjjYlIaDI0koaBoUM
         M4SKNDJwQw8NCjymTFXSL3tHbtHobsHjCVT48Fm9IdRp8kMNTX7qIFvb8MeCxUeFyrK2
         VtPoOLgMeN7ssp4bJ2aHL31YpAUemceG6lD7zPtKmSc68LXpkGQRW6tsjh7lD0y1/NQi
         nsiCDfuCCCBisCUIS39WzMwEURkO7Bd78g0rHbwWv21FFl6jTRoFnbqogC2oLbw9P79O
         U1Ag==
X-Gm-Message-State: ACrzQf0WphlQueo7xdGn08H52CCQrawsl9Rfaer/iSjCwhhCaTThylZK
        eUAOIct4c6rSN6K22sW1UvKRx20JmFRXPA==
X-Google-Smtp-Source: AMsMyM6/3ZjXIrE4Qn/bdGiyrsjypB6R/Ooht83aXja1DRa3oM95NXtfLHU3Qi+LnuCL5VdxoSK15Q==
X-Received: by 2002:a0c:9a4c:0:b0:4b1:d3ef:85cc with SMTP id q12-20020a0c9a4c000000b004b1d3ef85ccmr9242276qvd.105.1666027252384;
        Mon, 17 Oct 2022 10:20:52 -0700 (PDT)
Received: from [10.101.5.247] ([148.59.24.28])
        by smtp.gmail.com with ESMTPSA id bv8-20020a05622a0a0800b0038b684a1642sm246319qtb.32.2022.10.17.10.20.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 10:20:51 -0700 (PDT)
Message-ID: <d6642028-3fb9-4e39-a349-666625dabb9d@linaro.org>
Date:   Mon, 17 Oct 2022 13:20:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 10/15] dt-bindings: phy: qcom,qmp-pcie: add sc8280xp
 bindings
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221017145328.22090-1-johan+linaro@kernel.org>
 <20221017145328.22090-11-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221017145328.22090-11-johan+linaro@kernel.org>
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

On 17/10/2022 10:53, Johan Hovold wrote:
> Add bindings for the PCIe QMP PHYs found on SC8280XP.
> 
> The PCIe2 and PCIe3 controllers and PHYs on SC8280XP can be used in
> 4-lane mode or as separate controllers and PHYs in 2-lane mode (e.g. as
> PCIe2A and PCIe2B).
> 
> The configuration for a specific system can be read from a TCSR register.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../bindings/phy/qcom,qmp-pcie-phy.yaml       | 163 ++++++++++++++++++
>  1 file changed, 163 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
> new file mode 100644
> index 000000000000..82da95eaa9d6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml

Filename based on compatible, so for example:

qcom,sc8280xp-qmp-pcie-phy.yaml


> @@ -0,0 +1,163 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/qcom,qmp-pcie-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm QMP PHY controller (PCIe)
> +
> +maintainers:
> +  - Vinod Koul <vkoul@kernel.org>
> +
> +description:
> +  QMP PHY controller supports physical layer functionality for a number of
> +  controllers on Qualcomm chipsets, such as, PCIe, UFS, and USB.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sc8280xp-qmp-gen3x1-pcie-phy
> +      - qcom,sc8280xp-qmp-gen3x2-pcie-phy
> +      - qcom,sc8280xp-qmp-gen3x4-pcie-phy
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +
> +  clocks:
> +    maxItems: 6
> +
> +  clock-names:
> +    items:
> +      - const: aux
> +      - const: cfg_ahb
> +      - const: ref
> +      - const: rchng
> +      - const: pipe
> +      - const: pipediv2
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: phy
> +
> +  vdda-phy-supply: true
> +
> +  vdda-pll-supply: true
> +
> +  qcom,4ln-config-sel:
> +    description: 4-lane configuration as TCSR syscon phandle, register offset
> +                 and bit number
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      maxItems: 3

You have only one phandle, so you need to describe the items and limit
their number, like here:

https://elixir.bootlin.com/linux/v5.18-rc1/source/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml#L42

This allows you to skip most of property description.

> +
> +  "#clock-cells":
> +    const: 0
> +
> +  clock-output-names:
> +    maxItems: 1
> +
> +  "#phy-cells":
> +    const: 0

Best regards,
Krzysztof

