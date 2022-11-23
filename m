Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C84663634B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236822AbiKWPWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236185AbiKWPVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:21:50 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C78063BAD;
        Wed, 23 Nov 2022 07:21:49 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id t19-20020a9d7753000000b0066d77a3d474so11387720otl.10;
        Wed, 23 Nov 2022 07:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4aoLHgFE05riq4cmWmfmiT+Ki6XAw13WHmlMKR+7aRQ=;
        b=FIYqM2Z4zwJkd03cpZExtLXs5D1EcfVfgDi3wMib43kPB9h2immK0hfK6fkkeHo4Vk
         TQKdVEI1YB2me/wkf6fCRFIWhRWI3rLYQaoLoRgUB16YDck5XXxim6rYlrAFr9oz7fNL
         3lDvd8XxA9Xv3uSCXIG8QuprUR794x5W8tS9mgQtBmc5AgUxHKhBSiQOVWekB7Unut1h
         2lY8Mu3WyCGJrY5cKTbd6XYkk+DPzMm3ANgc/h/F8b6CXAchJF4XYtCqpsBWewSuSMDi
         m8xQtks+78XXRnWu1aDcUIl8TBFPJUpSaEHE75WhpWiNGxMgAFAJiz98+HI7A8kZwB6Z
         pnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4aoLHgFE05riq4cmWmfmiT+Ki6XAw13WHmlMKR+7aRQ=;
        b=UI7VD19P9v+82zQAonkAzhGOS9cn+3c0cfCvYQNiA/qO8wN8S3cmoYYAdRUdaLK5XT
         Ja3Db8jlGk6hvLdqhe2uXNFdyOyqYqNq5uhZ+CAQQI2uZYwiKTpjg/oVK5LyXjUAwLCG
         7PoGbQYVWNxpDtgIsd400A4S+ma7wVO727k3v8ZNScvgIAzpA8zZf2e62GFPAWPKOwTE
         PwVwZJJNIXS8zXhQmqORqzDp4I+DH5jHnbT82f0Hd2gNv3lXPcmiQNbpSMR9OFhStd9n
         WS9dhk2jPr7X5kSXoHQ7QDqcsM0yf8DKSwZBpfkg8jodR35p4+Yed7iHjrUbGYyoB2Zc
         NcZw==
X-Gm-Message-State: ANoB5pl/7m4Qk6kFvvYc19Llt8WXM6tLS5mzPz/gXgTFCoUKuWbGOXJB
        JLx15oxbNr9isOEC2oxtJCU=
X-Google-Smtp-Source: AA0mqf6j3JfOqMGcXTRxGtsdc4OmDhJ+STJS3nrH05Ko1b+ciKHvjsbwSDRblJz5KBqDhemfYIO3AA==
X-Received: by 2002:a9d:4c84:0:b0:66b:34bd:772b with SMTP id m4-20020a9d4c84000000b0066b34bd772bmr15089714otf.276.1669216908871;
        Wed, 23 Nov 2022 07:21:48 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id el33-20020a056870f6a100b0013bc95650c8sm9263267oab.54.2022.11.23.07.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 07:21:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <979b192d-7011-680e-0e0d-d70519bec2b1@roeck-us.net>
Date:   Wed, 23 Nov 2022 07:21:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [v4 3/5] dt-bindings: hwmon: Add bindings for aspeed tach
 controller
Content-Language: en-US
To:     Billy Tsai <billy_tsai@aspeedtech.com>, jdelvare@suse.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        joel@jms.id.au, andrew@aj.id.au, lee@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        corbet@lwn.net, p.zabel@pengutronix.de,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
 <20221123061635.32025-4-billy_tsai@aspeedtech.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221123061635.32025-4-billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/22 22:16, Billy Tsai wrote:
> Add the aspeed tach device bindings which should be the child-node of
> pwm-tach mfd.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>   .../bindings/hwmon/aspeed,ast2600-tach.yaml   | 36 +++++++++++++++++++
>   1 file changed, 36 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
> new file mode 100644
> index 000000000000..f42114f8e3c2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2021 Aspeed, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/aspeed,ast2600-tach.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed Ast2600 Tach controller
> +
> +maintainers:
> +  - Billy Tsai <billy_tsai@aspeedtech.com>
> +
> +description: |
> +  The Aspeed Tach controller can support upto 16 fan input.
> +  This module is part of the ast2600-pwm-tach multi-function device. For more
> +  details see ../mfd/aspeed,ast2600-pwm-tach.yaml.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-tach
> +patternProperties:
> +  "^fan@[a-z0-9]+$":
> +    type: object
> +    properties:
> +      reg:
> +        description:
> +          The tach channel used for this node.
> +        maxItems: 1
> +    required:
> +      - reg
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false

I am not a devicetree expert, but I have to say I find it confusing that
there is no clear explanation that this is for a single fan channel
which is really a child of aspeed,ast2600-tach. An example might be
helpful.

Guenter

