Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7155B3130
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiIIIAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiIIH7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:59:43 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4A72CE04
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:59:15 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id s10so242512ljp.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 00:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ffJDJLXz/yzwZQ2DKmnKWl6OWAzq8nCfRYuV0HB+NMk=;
        b=GeRYE3sSRQAq/+OLNbiJtAOLbM9XV0f00I+m+B6EcfwQiQRVNGpsqR/EurBsI3hn72
         4gzyR2FD2o7x+p0MfCO6LFryVha/FPHXFj9WroOChVs9nVB3J0jCQpWKwAa3fk9OZ53s
         Lt3Tvy08r7p6X6wKZxeTOp+kZMjws0t9M6GoFwuhS/GvsmDNXxLhGqHTM3MaTLrFqSq+
         8Z1oAEfQRJjPy+1ouiNjL0ww2Y1E5mfO56SM2gRBoqILjps8Pf1676Dkn0Hm6h49Jkkj
         qTo1CQtX+rNHpOIruDVvIdkc85MAd68pRB77sunmTwvGqdlqs5VM+Ty7po+96/+6PeMX
         rbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ffJDJLXz/yzwZQ2DKmnKWl6OWAzq8nCfRYuV0HB+NMk=;
        b=srb7t/pKz4C5BjvNlqRWHneGS6gOyUtqRQMoBbfxs8YJ1gQfwVeenR/JytWzlDhR2/
         a9nSndQdJ86o+HVr4oi+DzVgL1cH8Tca53dMp/cb9VYeEO+IC19zYLurQLwEBpM0TO8X
         3iGsuiw95V93KH5vJlHO1V5ywNl0HXfffku2qQUeBvWPQRlKU79dEEAGiiSU2PsvY/2T
         w3RMLRetsenyliRdzzz/yU6ZlURQVlX7yxlHviHnYwkq++Vv0+M5+lvF2XD1lcsLqjZq
         /+MlGhNTCCYoAnVmgnSNoK23n44e2F2VNowvEkav63QP7q86hhhs4WNdlGxAbmc5b7O6
         IHWA==
X-Gm-Message-State: ACgBeo25I6g9BlYOERPZT3GdatcOxlfLJRL15FeqBNuMsQJAPPs9Db4i
        hy/mI8o0AUF1dkpKSkE8w7uxakvME8bvog==
X-Google-Smtp-Source: AA6agR52OFVa+ktPZDO+qgN/DSvk0bsijOkKngfrrvDrXhnk2k1lAmzEHS2UVMO2OlcNveUJ4nn4eA==
X-Received: by 2002:a2e:b608:0:b0:26a:d179:8ecd with SMTP id r8-20020a2eb608000000b0026ad1798ecdmr2864266ljn.405.1662710353294;
        Fri, 09 Sep 2022 00:59:13 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id c6-20020a19e346000000b0048af4dc964asm177635lfk.73.2022.09.09.00.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 00:59:12 -0700 (PDT)
Message-ID: <932d68ce-0c14-3fda-8247-f5fe34b2f8b0@linaro.org>
Date:   Fri, 9 Sep 2022 09:59:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 2/4] dt-bindings: remoteproc: qcom: Convert wcnss
 documentation to YAML
Content-Language: en-US
To:     Sireesh Kodali <sireeshkodali1@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     bjorn.andersson@linaro.org, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220908184925.2714098-1-sireeshkodali1@gmail.com>
 <20220908184925.2714098-3-sireeshkodali1@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220908184925.2714098-3-sireeshkodali1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2022 20:49, Sireesh Kodali wrote:
> This is a direct conversion of the existing txt documentation to YAML.
> It is in preparation for the addition of pronto-v3 to the docs. This
> patch doesn't document any of the existing subnodes/properties that are
> not documented in the existing txt file. That is done in a separate
> patch.
> 
> Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
> ---
>  .../bindings/remoteproc/qcom,wcnss-pil.yaml   | 263 ++++++++++++++++++
>  1 file changed, 263 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> new file mode 100644
> index 000000000000..bc18139fdb91
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
> @@ -0,0 +1,263 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/remoteproc/qcom,wcnss-pil.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm WCNSS Peripheral Image Loader
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>

Use email from maintainers entry.

> +
> +description:
> +  This document defines the binding for a component that loads and boots
> +  firmware on the Qualcomm WCNSS core.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,riva-pil
> +      - qcom,pronto-v1-pil
> +      - qcom,pronto-v2-pil
> +
> +  reg:
> +    maxItems: 3
> +    description:
> +      The base address and size of the CCU, DXE and PMU register blocks
> +
> +  reg-names:
> +    items:
> +      - const: ccu
> +      - const: dxe
> +      - const: pmu
> +
> +  interrupts:
> +    minItems: 2
> +    maxItems: 5
> +
> +  interrupt-names:
> +    minItems: 2
> +    items:
> +      - const: wdog
> +      - const: fatal
> +      - const: ready
> +      - const: handover
> +      - const: stop-ack
> +
> +  firmware-name:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Relative firmware image path for the WCNSS core. Defaults to
> +      "wcnss.mdt".
> +
> +  vddpx-supply:
> +    description:
> +      PX regulator to be held on behalf of the booting of the WCNSS core
> +
> +  vddmx-supply:
> +    description:
> +      MX regulator to be held on behalf of the booting of the WCNSS core.
> +
> +  vddcx-supply:
> +    description:
> +      CX regulator to be held on behalf of the booting of the WCNSS core.
> +
> +  power-domains:
> +    maxItems: 2
> +
> +  power-domain-names:
> +    items:
> +      - const: cx
> +      - const: mx
> +
> +  qcom,smem-states:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      States used by the AP to signal the WCNSS core that it should shutdown
> +    items:
> +      - description: Stop the modem
> +
> +  qcom,smem-state-names:
> +    description: The names of the state bits used for SMP2P output
> +    items:
> +      - const: stop
> +
> +  memory-region:
> +    maxItems: 1
> +    description: reserved-memory for the WCNSS core
> +
> +  smd-edge:
> +    $ref: /schemas/remoteproc/qcom,smd-edge.yaml#
> +    description:
> +      Qualcomm Shared Memory subnode which represents communication edge,
> +      channels and devices related to the ADSP.
> +
> +  iris:
> +    type: object
> +    description:
> +      The iris subnode of the WCNSS PIL is used to describe the attached RF module
> +      and its resource dependencies.
> +
additionalProperties false on this level.

> +    properties:
> +      compatible:
> +        enum:
> +          - qcom,wcn3620
> +          - qcom,wcn3660
> +          - qcom,wcn3660b
> +          - qcom,wcn3680
> +
> +      clocks:
> +        minItems: 1
> +        items:
> +          - description: XO clock
> +          - description: RF clock
> +
> +      clock-names:
> +        minItems: 1
> +        items:
> +          - const: xo
> +          - const: rf
> +
> +      vddxo-supply:
> +        description:
> +          Reference to the regulator to be held on behalf of the booting WCNSS
> +          core
> +
> +      vddrfa-supply:
> +        description:
> +          Reference to the regulator to be held on behalf of the booting WCNSS
> +          core
> +
> +      vddpa-supply:
> +        description:
> +          Reference to the regulator to be held on behalf of the booting WCNSS
> +          core
> +
> +      vdddig-supply:

Best regards,
Krzysztof
