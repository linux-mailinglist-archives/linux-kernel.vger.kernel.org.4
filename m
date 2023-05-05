Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2347D6F826B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjEEMBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjEEMBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:01:05 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F3A30F7
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 05:01:04 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so26370417a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 05:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683288063; x=1685880063;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ImF2e05bvx9rOSM694WfQMcc5pAkGih8DWv7R4NDd7o=;
        b=iEBD9rhAhmMPxThK3WAQLLOD78WyYw9rSTbnihNNsDIB9+5jFZm2YH5e2xvsSoMx15
         rdImbWjsUcaS6ofoD1fTrAh5fO09bDkU8bqiPK6Cm36eXJvJTgkKuipbFis+4azJz8AB
         AGr0fYvODcgwXMHhblGfjR0TnOPsmIUo5O+/LM8aFX2DV3An44CUk0iH7nqH3lIRoA0J
         5EtJLJwtdClhseTFpL6wMz2uqmrHx7S+Z0MHN7xChXdrEf+CU8TaHhlhsF4wdc6vVL8r
         rZ+egU4/CC0WmzMisI2NkNp3c9OcZeHHMiHiYLHQZmUYRtkcMTbu7/sthhIOm5QYXpGT
         YC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683288063; x=1685880063;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ImF2e05bvx9rOSM694WfQMcc5pAkGih8DWv7R4NDd7o=;
        b=GInv01A3SE+EFRyk9c3TuVSQXIVrmAX48pD0xBhH026Hc52rCxwGfGbLfs/8pfXPI+
         jtWwEipW6b67jueUMc3L+ypnQmG4O2nErOGdYCo7qAcCn/hL5faEB+av02fPY0rGzhXv
         rGoRduhCfPzUMgEQ6mRnnPLrut4DUlnvvoWS9/M/a84aFb7cDkRODNu8vJO98aJzbcVr
         AmqgQQA4SOf/GrnVOqT2hjicipgE3ieJ+DpbEUzcQCD74n1s2cT/YTwCDbMr777A06Pt
         vqFnpMmMqZ9pWLPZ30FF5/voiXwMgXT+SOzVUaxSeZRcxelfBH5x4fsBz5J10gxRN6UE
         u65g==
X-Gm-Message-State: AC+VfDyzWslmj4dflpUyipE+NMNm5HR1MY/DRfEkNkTtcfVzehCzs33O
        08JWLgBgDEYHrKtyrdk0bH86RA==
X-Google-Smtp-Source: ACHHUZ61Zi0U9a9Eqc/LVL0YQBE6XIipkFyC5I9H0ci1zC5hVkUNI4oMjeOgUiWAAXmTCg50scaffw==
X-Received: by 2002:a17:907:2d8d:b0:94e:cfd0:ed9f with SMTP id gt13-20020a1709072d8d00b0094ecfd0ed9fmr1914691ejc.26.1683288062833;
        Fri, 05 May 2023 05:01:02 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:52e:24ce:bbc1:127d? ([2a02:810d:15c0:828:52e:24ce:bbc1:127d])
        by smtp.gmail.com with ESMTPSA id jl3-20020a17090775c300b009655eb8be26sm883521ejc.73.2023.05.05.05.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 05:01:02 -0700 (PDT)
Message-ID: <bb3d374d-0dc1-cf15-2458-f294c5ef23fd@linaro.org>
Date:   Fri, 5 May 2023 14:01:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: add binding doc for i.MX
 OCOTP/ELE
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
References: <20230505091733.1819521-1-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230505091733.1819521-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2023 11:17, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> There are two parts of i.MX93 OCOTP, with 1st part Fuse shadow block(fsb),
> 2nd part managed by ELE firmware. This binding doc supports both.

Subject: drop second/last, redundant "binding doc for". The
"dt-bindings" prefix is already stating that these are bindings and
documentation.

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../bindings/nvmem/imx-ocotp-ele.yaml         | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/imx-ocotp-ele.yaml
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp-ele.yaml b/Documentation/devicetree/bindings/nvmem/imx-ocotp-ele.yaml
> new file mode 100644
> index 000000000000..024594a2bcb4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp-ele.yaml

Filename matching compatible style. fsl,imx93-ocotp.yaml


> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/imx-ocotp-ele.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX9 On-Chip OTP Controller (OCOTP)
> +
> +maintainers:
> +  - Peng Fan <peng.fan@nxp.com>
> +
> +allOf:
> +  - $ref: nvmem.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: fsl,imx93-ocotp-fsb
> +          - const: syscon
> +      - items:
> +          - const: fsl,imx93-ocotp-ele
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1

Drop

> +
> +  "#size-cells":
> +    const: 1

Drop

> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible

Also: reg and clocks

> +
> +unevaluatedProperties: false
> +
Best regards,
Krzysztof

