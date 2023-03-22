Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6976C44E5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCVI0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCVI0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:26:54 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F205CC12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:26:52 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id eg48so69384994edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679473610;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CAm2veKDXnaGeAZs5U8h5RukZe7XAVK9RQkbxxKLv34=;
        b=r8/Pipy5QlNEsDFHQD4BrpB73OBERqn3qtdPUGj8l7lSpV55RMdCoWheyyi4Qhr0KQ
         WJYSv44eAzVgl6OwoyQcLhG7ubWxeobVfPRra/Aajsp9XM+u7OrFHHobt8QwQCAk/h6N
         JpOxoX4Eyh8JQs9YfrRYJwBx02Jr4UhgX1Femc6LrFz7zMz/f6CKSog9nVqsRPsKsHzT
         giP+VXYLdfnERJnGi3xBdGOX9jvxUigvTlyXLK3Qc6Qtsz1/lEpbwKNWwT739gNoDq2t
         5gq/XagguaqS/pk0ukYTso4e4LffzDPBp0oFGPWYmMqEprqr/hfrYNmtcbUd5qHbTu6a
         5iEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679473610;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CAm2veKDXnaGeAZs5U8h5RukZe7XAVK9RQkbxxKLv34=;
        b=5c0kq6HV6p1niL7R0N4LbnDnKOyO0NhvUn9xJtJAql4MVs45ZJC7jlwwSeZePdroz0
         A1C8VLAq8+HGc4rBFjr/buUsTLsJRFaaz8LMIf0hww6TlNv1U6eUUBaxdbNvKelJS3A/
         OunaxsllU+9Sm5HeqLWCnf1v+tFwnSi/dHycXSJ2BrYCWqZchDu/98itj4a4L5raloCB
         zhi/3R1X2CpXuGBDJV6Ft5g6JVgLjAPxCDt98D4ourAUFcIbdPF71iA/8Y8RNuYq1nXL
         s8ydypBJzWjhvrSadqoIDWv/eVb3IqcHz6vpYcngJf/6fil23QQnP7FVzBVO9Ds/Xyr8
         QkmQ==
X-Gm-Message-State: AO0yUKXnU1gsmJ9jfy/pLEjlvGpagSJ5mrFEzJNsQQf13cy8+A56QPT4
        pRjrbNle4q5FoQJf67G/f2FHUw==
X-Google-Smtp-Source: AK7set9KukcOzPQVlVPh/m1MkqNeqsUvYJeekT3EgmcO6WBovtGPoHfm9Rnb5pcgppW3G3aRSH3mWw==
X-Received: by 2002:a17:906:9bd8:b0:879:ab3:93d1 with SMTP id de24-20020a1709069bd800b008790ab393d1mr5833860ejc.4.1679473610508;
        Wed, 22 Mar 2023 01:26:50 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5050:151b:e755:1c6? ([2a02:810d:15c0:828:5050:151b:e755:1c6])
        by smtp.gmail.com with ESMTPSA id 21-20020a170906319500b008d68d018153sm6783591ejy.23.2023.03.22.01.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 01:26:50 -0700 (PDT)
Message-ID: <a44e363c-c8c3-341d-d794-df2bc1a3d20d@linaro.org>
Date:   Wed, 22 Mar 2023 09:26:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/8] dt-bindings: power: supply: max77658: Add ADI
 MAX77654/58/59 Charger
Content-Language: en-US
To:     Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sre@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     Nurettin.Bolucu@analog.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230322055628.4441-1-Zeynep.Arslanbenzer@analog.com>
 <20230322055628.4441-4-Zeynep.Arslanbenzer@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230322055628.4441-4-Zeynep.Arslanbenzer@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2023 06:56, Zeynep Arslanbenzer wrote:
> Add ADI MAX77654/MAX77658/MAX77659 power supply devicetree document.
> 
> Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> ---
>  .../power/supply/adi,max77658-charger.yaml    | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/adi,max77658-charger.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/adi,max77658-charger.yaml b/Documentation/devicetree/bindings/power/supply/adi,max77658-charger.yaml
> new file mode 100644
> index 000000000000..f140abab969c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/adi,max77658-charger.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/adi,max77658-charger.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Battery charger for MAX77658 PMICs family from ADI.

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Actually you
ignored all of them. Maybe my feedback got lost between the quotes,
maybe you just forgot to apply it. Please go back to the previous
discussion and either implement all requested changes or keep discussing
them.

Thank you.

Best regards,
Krzysztof

