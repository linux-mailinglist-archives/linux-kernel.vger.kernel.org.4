Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4616FB7B2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 21:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbjEHTso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 15:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbjEHTsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 15:48:22 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD68B7693
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 12:46:57 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-50bc5197d33so9457131a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 12:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683575160; x=1686167160;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P9SLT98nYX4tHzoR3lU96jGF4z7D63vU4HdjC2QXDm4=;
        b=QvksD5MxGvRRDYL5Iy0wD0f9V2kLqbAHz0jupDw/V+T4fHuztBQsKGaoGUATrWyB0h
         80+jKeCaGIVMx+E6Yr+jGu7uPiak7B+TKauub/B686SMJs48Iw9Wi2gpwKHsoS+I2NlG
         RlnrovprBkD6Xu8aHs94qsEbG0Rm3GJXLvDbNZ3omhMBjEzbc6fxcA2fFtEjmlALcpZ+
         Yvc+Pfcgtyy3eFVuDRPVjm/RcCjkF+aySot8uiQ4UtmOOU9ehgOmtkXpMzzar0oYiAuL
         KNipbkYGJX2AEqt5jG4OiUtA0kkKoOdm8HLaWWs/SZc69EjC4sQ2NicKtx7Ah6CHinZx
         GtGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683575160; x=1686167160;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P9SLT98nYX4tHzoR3lU96jGF4z7D63vU4HdjC2QXDm4=;
        b=WhAzDerclsgwXospSwSnMurYrcDpJhIsydhNoFKQ/jTfD0jRBhoqgPUSrc4G5lMlqt
         ptVW6ZqAZdF9f3EzbG+vTvl0dMvOYJ0jXpvPTc3X8mfex11fECZmqWBySjEkHkVk1NmP
         ZV8BPtRDBkQO3MNSYGGg6KgwmH9rv97UYvmuv8im0rBXtnl7XUXCuXlnIdsKgwMXmiL0
         LgcdYTz6CXkrtHEiiPPIZSREYC7KbdMiwGPE4oAKRauAhKzgu0aghE3L7se10I/SbjJr
         dIlk0OvzZGSY/+8j7lIiUwFHkEtTm6UOz3eySfjofMvVv4TU4c5QU3L3tXNnM8M7dS1l
         kFgQ==
X-Gm-Message-State: AC+VfDxngw4LpI1JI//Cf7xF1GHXUhwrtu5e1wsm6gZHbe7VexS9dnyr
        r407HivDYLD548CG1VfABpVmWzCPuFL3slu6gt4=
X-Google-Smtp-Source: ACHHUZ4GYeQ4iF7JG9vK4jgm59KVN9C2HUrPFvYI4iCTIht1iURWyuC4Akp3/JzAM9Vt+WJGlCqekA==
X-Received: by 2002:a17:907:6da3:b0:969:9118:a991 with SMTP id sb35-20020a1709076da300b009699118a991mr1565170ejc.42.1683575160431;
        Mon, 08 May 2023 12:46:00 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d19b:4e0f:cfe4:a1ac? ([2a02:810d:15c0:828:d19b:4e0f:cfe4:a1ac])
        by smtp.gmail.com with ESMTPSA id hs32-20020a1709073ea000b009534211cc97sm350807ejc.159.2023.05.08.12.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 12:46:00 -0700 (PDT)
Message-ID: <222ed4ee-4122-7ea8-5d94-69976f247599@linaro.org>
Date:   Mon, 8 May 2023 21:45:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/7] dt-bindings: power: supply: max77658: Add ADI
 MAX77654/58/59 Charger
Content-Language: en-US
To:     Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sre@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Nurettin Bolucu <Nurettin.Bolucu@analog.com>
References: <20230508131045.9399-1-Zeynep.Arslanbenzer@analog.com>
 <20230508131045.9399-3-Zeynep.Arslanbenzer@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230508131045.9399-3-Zeynep.Arslanbenzer@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 15:10, Zeynep Arslanbenzer wrote:
> Add ADI MAX77654/58/59 power supply devicetree document.
> 
> Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> ---
>  .../power/supply/adi,max77658-charger.yaml    | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/adi,max77658-charger.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/adi,max77658-charger.yaml b/Documentation/devicetree/bindings/power/supply/adi,max77658-charger.yaml
> new file mode 100644
> index 000000000000..1b487d82cdbf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/adi,max77658-charger.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/adi,max77658-charger.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Battery charger for MAX77658 PMICs family from ADI
> +
> +maintainers:
> +  - Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> +  - Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> +
> +description: |
> +  This module is part of the MAX77658 MFD device. For more details
> +  see Documentation/devicetree/bindings/mfd/adi,max77658.yaml.
> +
> +  The charger is represented as a sub-node of the PMIC node on the device tree.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,max77654-charger
> +      - adi,max77658-charger
> +      - adi,max77659-charger

What are the differences between them? Driver suggests they are
compatible. Your match data is empty there.

> +
> +  adi,input-current-limit-microamp:
> +    description: Input current limit value.

Your description is an exact copy of property name. That's not helpful.
What do you limit? Total current? Charging current? Top-off current?

You have default value, why it is not here? minimum/maximum?

> +
> +  monitored-battery:
> +    description: >
> +      This property must be a phandle to a node using the format described
> +      in battery.yaml, with the following properties being required:
> +      - constant-charge-current-max-microamp
> +
> +allOf:
> +  - $ref: power-supply.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,max77659-charger
> +
> +    then:
> +      properties:
> +        adi,input-current-limit-microamp: false
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +...

Best regards,
Krzysztof

