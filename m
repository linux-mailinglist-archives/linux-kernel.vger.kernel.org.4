Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F00E683602
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 20:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjAaTFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 14:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbjAaTFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:05:16 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB43C15574
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:05:14 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so11423494wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YQzlHN8C5ytWD4LQULKZ+tnaW8K03J/011gZ4O7NdVs=;
        b=vCbZXJ1rfzjUa5dN6FIKKkiKpeHVetK+tl7KKoqgwlPzhIQ+UooJsZ52A07VqUzGhI
         PJ/6mVq88orxv5VJp5e5tzGnvj9cFS60KWJ18od5UR7/vEeUBXdhv0vyhLqaQZRLXCMQ
         uD47GtMt8lSE5DwKzPOC7UlS6DFuVg4W8xpcaLIYCa2/Gi3T5pc0mzoBfgmioYHbqmuL
         u1Mhz/7QY8cdU7eqyRmLLuvbKNU+hisKc/y/0Bum6ax/mXOQfnxLrtO7C5L0oS/gqeqs
         0xS9f4N9A/3ZJTazAFLOK1X3o9xxTp/ag8mf8SnlzqJewKo0rBk6KQOqzJCSqfo/+Gep
         4tow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQzlHN8C5ytWD4LQULKZ+tnaW8K03J/011gZ4O7NdVs=;
        b=vbVu3WY8vFIWa8Uv8Li4s31i2d/e+4f6pbnNLDW4qTSqhD9nqwmw31LcBHrAZlat4M
         u5zljtIZQ/HKKQJOj4IAdk46P1C5Ongu1s5L6n8TmBgwYx9hUYBito0T7PzZ7zsheBCV
         5O5Bau29kccPCpvJFGChum9/XSsMjxIfQP6iAayieMo7nq4xf0Hv4OD72fLlDOkmaAcX
         liGpG2pREGF9Pd/TzQ2Kas0u8UzYJpH3UltOfQjBSYdzhwoyXRmwHf7R6QShdo2067u2
         eyG1wA1C1rD1rd1mQPh7ZzgRJfETFrtEi6xnItg6tKBbMjSt+4OmnalTZeAIY8w0s1rf
         YK4Q==
X-Gm-Message-State: AO0yUKW/z5s+zMbNO3SQjL2tcIXyblltvKgPJjWYLAUYmZPrbDMBhrHC
        W8E+C/9UUkFquZTLuP6lgi7H5w==
X-Google-Smtp-Source: AK7set+5BxSdzoPJgFTWK/Vh/UjrLFnT0l09EhoYMylWE8EAIswQxOqOvmFqGb/av2JpjnJH/tykmQ==
X-Received: by 2002:a1c:7210:0:b0:3dc:46e8:982 with SMTP id n16-20020a1c7210000000b003dc46e80982mr13857728wmc.19.1675191913320;
        Tue, 31 Jan 2023 11:05:13 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c358900b003dc1f466a25sm21001542wmq.25.2023.01.31.11.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 11:05:12 -0800 (PST)
Message-ID: <2a237ca0-15cd-b86c-7d9b-32014370d9dd@linaro.org>
Date:   Tue, 31 Jan 2023 20:04:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/3] dt-bindings: net: bluetooth: Add NXP bluetooth
 support
Content-Language: en-US
To:     Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        alok.a.tiwari@oracle.com, hdanton@sina.com,
        ilpo.jarvinen@linux.intel.com
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-serial@vger.kernel.org, amitkumar.karwar@nxp.com,
        rohit.fule@nxp.com, sherry.sun@nxp.com
References: <20230130180504.2029440-1-neeraj.sanjaykale@nxp.com>
 <20230130180504.2029440-3-neeraj.sanjaykale@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230130180504.2029440-3-neeraj.sanjaykale@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2023 19:05, Neeraj Sanjay Kale wrote:
> Add binding document for generic and legacy NXP bluetooth
> chipsets.
> 
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
> v2: Resolved dt_binding_check errors. (Rob Herring)
> v2: Modified description, added specific compatibility devices,
> corrected indentations. (Krzysztof Kozlowski)
> ---
>  .../bindings/net/bluetooth/nxp-bluetooth.yaml | 40 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/bluetooth/nxp-bluetooth.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp-bluetooth.yaml
> new file mode 100644
> index 000000000000..9c8a25396b49
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/bluetooth/nxp-bluetooth.yaml


Filename based on family of devices or compatible (assuming it is
correct): nxp,w8987-bt.yaml

Hyphen is not a correct separator between vendor prefix and device name.

> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/bluetooth/nxp-bluetooth.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP Bluetooth chips
> +
> +description:
> +  This binding describes UART-attached NXP bluetooth chips.


This is description of binding. So in description of binding for NXP
bluetooth chips you say that it describes NXP bluetooth chips. I don't
think it's useful. Describe the hardware instead.

> +
> +maintainers:
> +  - Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,w8987-bt
> +      - nxp,w8997-bt
> +      - nxp,w9098-bt
> +      - nxp,iw416-bt
> +      - nxp,iw612-bt

Why "bt" suffix? Are these chips coming with other functions?


Best regards,
Krzysztof

