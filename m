Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E74727914
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjFHHpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjFHHpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:45:49 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D901FD6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 00:45:44 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-973f78329e3so59180666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 00:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686210342; x=1688802342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ufYzHFAaV21moEWJzL9MVaqjG5CqT34fAjSKPeKfQog=;
        b=MB8IaFhbE8T7TICoVSTaEUS1iIScLxi5b71wJeexJowrN6y8l082gCzR+1nHN0pPnh
         fZg1aBWh7xCT47EtF+lojEHXfHZh1vk2vb7f5NyHMAFa5n7DSPTPtD/AhDtpWJPHtMiV
         fdTw0ANaxzatSwDGImtj+Ka7xEIu0YByDjl3LaKkPfz2KkPTX+DlJW7olVZmg9V88X+P
         hRGal2226ktIzRKMn39UofPTLcQDyHC/j8MGLG5SLAFPfH8cQQhITUikwO6X91pAX0bm
         ed/s4SCU+rz9nO+Vywd3mrcttmbrVRz8NSUposRfqeiV3SZA8YgaK//Ruk+kJI4TZQjm
         hW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686210342; x=1688802342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ufYzHFAaV21moEWJzL9MVaqjG5CqT34fAjSKPeKfQog=;
        b=VW6tct7HUFKL4TBlW77iT+gKKtP6aw7zCpBJTpLyaSwgxIBwSJbI9+Q0cHWcDXtmNU
         u/xNfs90VrgZfoqEBKZAql5YNiMtIVmTi6/5S10qogfUIW5++hG15tw4BBWMROCM9oAm
         05bceJvm1X44u82/+PHmTWJCiaVAbiR+9dJoh/SFPuXeFSFjZwxueN+u0Sp95hrQdg0u
         qhVFCR2nzK9lZoP85p4ZornmQjI+OMXLI3xijc6KONd5/Sz8kiK6WNRHNUd6Im9Ezf9e
         UJbCYusz21chR1l+h/iuMUGheS5cOWHizyXhJIa7kk4RbEOtos5juxnsKk6sIPIaWkSj
         N1GA==
X-Gm-Message-State: AC+VfDyVGI0Ty26+7qZkjAV3/UoNMSFqbNeeMDGXWSgFbhV2y4UxDzQa
        tHxv3kSbM3AnS+iBrzpYkraMur50PwPoUPpDHu4=
X-Google-Smtp-Source: ACHHUZ5mJyQFzBl/4EOYivul5ky9wG17vzVXdF8KJinBMiN8cQpEcD97wNnSmUT0Q8oVMbkSdmSuvQ==
X-Received: by 2002:a17:907:948c:b0:94f:36a0:da45 with SMTP id dm12-20020a170907948c00b0094f36a0da45mr8482435ejc.29.1686210342512;
        Thu, 08 Jun 2023 00:45:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id d16-20020a170906545000b00977c7566ccbsm330622ejp.164.2023.06.08.00.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 00:45:42 -0700 (PDT)
Message-ID: <6ebed84c-2b42-c981-7b3f-e71cc88e4c2c@linaro.org>
Date:   Thu, 8 Jun 2023 09:45:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v12 1/2] spi: add loongson spi bindings
To:     Yinbo Zhu <zhuyinbo@loongson.cn>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230608072819.25930-1-zhuyinbo@loongson.cn>
 <20230608072819.25930-2-zhuyinbo@loongson.cn>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230608072819.25930-2-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2023 09:28, Yinbo Zhu wrote:
> Add the Loongson platform spi binding with DT schema format using
> json-schema.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

The prefix for SPI should be: "spi: dt-bindings: ". In the same time
last "bindings" are redundant.

> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/spi/loongson,ls2k-spi.yaml       | 41 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml b/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
> new file mode 100644
> index 000000000000..423ee851edd5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml

Filename based on compatible.

> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/loongson,ls2k-spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson SPI controller
> +
> +maintainers:
> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - loongson,ls2k1000-spi

No compatibles for other devices? Didn't we have big discussion about this?

https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42

Best regards,
Krzysztof

