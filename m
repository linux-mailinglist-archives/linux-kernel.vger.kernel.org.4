Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2464E6D903F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbjDFHMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235912AbjDFHMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:12:41 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBEB9ED2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 00:12:37 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id er13so105999614edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 00:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680765156;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FTrXatKj0NAmmO1834Hl1S31qH+Qt0j4GCqY89e5gxg=;
        b=LY4xE+JPncZvDsLtxSZc2wJfU9cG5JbsJL9JC0SDlibUGtjjPIIEvf0ymk4qkFJ/x8
         qPLEBzGacouN9eVQecazNJ3YmVShLtUvT5MS8l6j/iN9c2tNkp7+PKSkhVeo1V+3aATW
         kyofd0CDgVcnNbJD217cGLRHW0Mv6KC5LwyIZB/1qHaf3cWfjHxDi79rAT2U9DuY47hJ
         u3DLKmlHF9w6jiR95Wz4GC9VuN1id0f9D+IzQtcrZ0od3e4BTDMNGbaOKa38fHH8eUgI
         TZwm9jCvc9mc6Nu/PzPwa6loQ5/Pfaj6bJS4vnIxKwfHfw5w/eL2VcFPWBCccV6oXOlf
         BvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680765156;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTrXatKj0NAmmO1834Hl1S31qH+Qt0j4GCqY89e5gxg=;
        b=H+8CEOV1wVj8IswpJXyo3OfVpy/QUuOxUtcHqvR76eo4AP4ykwuLPMkVEWfNvFhg/7
         DEo6GaKftazWwG6f7MRwFQEhTAm35Pwk75jzAC/ZFXbsIHHbMhF/cT0xqrVDNvprx9dE
         M8ntReiPoFeRAoCtOrClNO9j6ZYfDwnbJe3jVftGIOguGbu2vkSXZrhtTimhThzy0DNw
         h9pOGkmUVSSY3Sl/dZdX6DiobFsd3hFBCNq7QQtTgrjviWIOO4oUxNGkIRzRjTdo+R2W
         tCcM4sJYwzlujDfLDzd3OOA9LbIQpXM4h5oTGpTaW2eXC0w8l4ydHp8TKI4wXyxC4A32
         SUVA==
X-Gm-Message-State: AAQBX9dLsiGDkrYfCNquJfHtg/35rWmy4pM+P8Azmh6f/w5KnuUqVK6j
        a9KwjtktT1sx2Qn0dYwB8Qll3Q==
X-Google-Smtp-Source: AKy350ZgaU+GMer0ZyEBurWw1ctBgB8mGAmG9JAzJg+/84ZM71L8/az6M5NBv6240Dzw1N3+MGzZ2Q==
X-Received: by 2002:a17:907:9607:b0:930:3916:df19 with SMTP id gb7-20020a170907960700b009303916df19mr7149830ejc.5.1680765156086;
        Thu, 06 Apr 2023 00:12:36 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id r18-20020a1709063d7200b00934212e973esm394000ejf.198.2023.04.06.00.12.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 00:12:35 -0700 (PDT)
Message-ID: <6a9f041b-1c35-4691-8451-7119cd05ed17@linaro.org>
Date:   Thu, 6 Apr 2023 09:12:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/2] dt-bindings: cisco: document the CrayAR
 compatibles
Content-Language: en-US
To:     Daniel Walker <danielwa@cisco.com>, - <xe-linux-external@cisco.com>
Cc:     Marcin Wierzbicki <mawierzb@cisco.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Walker <dwalker@fifo99.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230405223028.1268141-2-danielwa@cisco.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230405223028.1268141-2-danielwa@cisco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 00:30, Daniel Walker wrote:
> Describe the compatible properties for the Cisco CrayAR SoC.
> 
> Cc: xe-linux-external@cisco.com
> Cc: Marcin Wierzbicki <mawierzb@cisco.com>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>

Please drop the autogenerated scripts/get_maintainer.pl CC-entries from
commit msg. There is no single need to store automated output of
get_maintainers.pl in the git log. It can be easily re-created at any
given time, thus its presence in the git history is redundant and
obfuscates the log.

If you need it for your own patch management purposes, keep it under the
--- separator.

> Signed-off-by: Daniel Walker <dwalker@fifo99.com>
> ---
>  .../devicetree/bindings/arm/cisco/crayar.yaml | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/cisco/crayar.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/cisco/crayar.yaml b/Documentation/devicetree/bindings/arm/cisco/crayar.yaml
> new file mode 100644
> index 000000000000..0ee4e6313ab0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/cisco/crayar.yaml

How many (or not many) platforms do you expect from Cisco? We mostly
have one file per SoC manufacturer.

> @@ -0,0 +1,27 @@
> +# SPDX-License-Identifier: GPL-2.0-only

Dual license.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/cisco/crayar.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cisco CrayAR based Platforms
> +

Best regards,
Krzysztof

