Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F93D63EEAF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiLALDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiLALCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:02:50 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A53FAD9A1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 03:02:05 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id a7so1431701ljq.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 03:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RWN6d6ee3y7/gjA+RJaHwoAowMMQDgGlpGi4abXfpxU=;
        b=QHFcARpSCZeUlqpgZgIeJB5KzhvZ8mnlgrz6maNkmtHJup7gSx3/GtBWGeriFWj/5t
         5XHsCymS45E+Zl/W2hNAFoZ2YLEcgZVXQTIKKJdRprABj+ODZuac7fWd+tVQNcIzy/le
         f9Jm1F3ApVr2Z8OH24Z/2/r/opM7g4rlOvFY0lwkwzxn5oIyT1vnJVbLK8fVN4K5Z4Wr
         qPF5T3orMBvs6M0B/VDSFzz6rI4aahXbN08pn6GB0ZRm3P5Z8iEH42svHTjTlrvxth74
         BJaOuUl/OGRDD8U9DHQ4Wi1sLsxYCMEAwOigFUng1ELR76awP/ehWOjEuWwpiP+XthAd
         mhYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RWN6d6ee3y7/gjA+RJaHwoAowMMQDgGlpGi4abXfpxU=;
        b=Wk2+fzZMp3zXqDk6FxxlJDaSDNQRYadWW/phRi3WY7ZbSO5KOAGk5cGDOQgbtGNOJC
         +PNjcNgWbEkiILvVIhBTwmBZnGjN65un/pEGaTmlkq09bE5EsH1ajirdkMLvTtOgzEzQ
         oNBg+IVj3Ly7oslIgSqrodTvINo+jFCQbV/5C7STB+oM9qAq2WQ5adVDU77EZaVKrfMK
         +RNN/xQB+53hPj2v8jEVKHqOoBau1EHPP9INs+LVlmX8w/Pp6oYV2PgG3x8+Sj1Tt5w3
         5rx7Jdliz7z7CCmnhf0ri1BezcFYHdRDKxxfhBlgoC3OylhuYZoFek4T33xE1N/TFbNU
         Q38g==
X-Gm-Message-State: ANoB5pkv1vAeIngEVHlU4djp0D1IxgMxOkaMiT644APwwASglaSsZtAD
        pLUMX9WY+avT4gtZyw33mAum0w==
X-Google-Smtp-Source: AA0mqf5O6CJ+qn9YMzGPkZe6b8n6HzYvx5cIKBxDov12bCrrfFFonZ0myxPBBsvAVAmhoKC3veX63w==
X-Received: by 2002:a2e:9b17:0:b0:279:cd10:a511 with SMTP id u23-20020a2e9b17000000b00279cd10a511mr1599538lji.502.1669892523528;
        Thu, 01 Dec 2022 03:02:03 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id g3-20020ac25383000000b00492dba3c85asm606438lfh.220.2022.12.01.03.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 03:02:02 -0800 (PST)
Message-ID: <fb13f339-79c5-96a1-ba4d-bf09da0b6ebd@linaro.org>
Date:   Thu, 1 Dec 2022 12:02:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/9] dt-bindings: serial: add documentation for
 Bouffalolab UART Driver
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20221127132448.4034-1-jszhang@kernel.org>
 <20221127132448.4034-2-jszhang@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221127132448.4034-2-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2022 14:24, Jisheng Zhang wrote:
> Add bindings doc for Bouffalolab UART Driver
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  .../bindings/serial/bouffalolab,uart.yaml     | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/bouffalolab,uart.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/bouffalolab,uart.yaml b/Documentation/devicetree/bindings/serial/bouffalolab,uart.yaml
> new file mode 100644
> index 000000000000..a8293444ca31
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/bouffalolab,uart.yaml

Name the file matching compatible, so bouffalolab,bl808-uart.yaml

> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 Jisheng Zhang <jszhang@kernel.org>
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/bouffalolab,uart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bouffalolab UART Controller
> +
> +maintainers:
> +  - Jisheng Zhang <jszhang@kernel.org>
> +
> +allOf:
> +  - $ref: serial.yaml#
> +
> +properties:
> +  compatible:
> +    const: bouffalolab,bl808-uart

Rob's comments from v1 are applicable. Either fix or respond to them.

> +
> +  reg:
> +    maxItems: 1
> +

Best regards,
Krzysztof

