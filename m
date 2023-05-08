Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5403A6FB83A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 22:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjEHUWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 16:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjEHUWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 16:22:35 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50103C3E
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 13:22:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-966287b0f72so446453966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 13:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683577352; x=1686169352;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o9p8sbbgU2nilbnlP81YasUbZB4uSHNla9W07vOiVuk=;
        b=gOTqOEm+mZGsJLVKVNSPiI+wK/x1/Xtnq83AHMG2oQTtLK1OpNmDfXqZvguOX5q9YV
         eeA70G67Q42cbv5efp3n8yR9/4ugw9poDZsYRggTA06kf9klBB+J5BzLapDEr87tEE5C
         QomCbi57zXd0CGCPdUESP3jmTQLXJK9SnWCWmsQ4D42pJrTjatnPLuR3g1uMxxgt8Qsw
         n4duUUfE6yYpDZm2/bCVI5fPai42+6HqtXBAgDJD0MvNOAX0XRls9aEGV83T7nk+ipnP
         aFhIT8F0Tra5O9xXGIJtWLVVOVl+//5XTqe18/e3FR/ronYuYdQYqQoB6HovUge7LeF+
         FJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683577352; x=1686169352;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o9p8sbbgU2nilbnlP81YasUbZB4uSHNla9W07vOiVuk=;
        b=I3Ff/hXhuhd8vJvdkMjKAZAqkgIaE6L5zE5ZsoACwXfPytfjQzVnhT2+/ArRZE/jQJ
         WD4caMroQZWUbmM5h45hLTudcTuuwEP/7AIuizMm7khJQzipgycvSoDHF8eCOkPYAz7C
         J+SsGgp0GYXnYOVczySTzydMGyaK3j+D+199oLhWqKRUQyaqEwkCSgW6MR6KSOoAY8RC
         u43IwyylDwc2Dc7ui4QDXntzvA5u5fXBpLG1ygs1OeVPDlvj5dDg0fJK2Ca0NRxvcqgm
         2U0ClvGOm68W2zz+DNvABGHf+YTzjYbORaZVZIfjypmrK4pZd/pfO9AOrs2DcyzmrSW6
         Wqyw==
X-Gm-Message-State: AC+VfDzdq2iuyTifwY0kC50jZoM56rlPaIcjzcssqBMMIr0nXxUTeZnZ
        oAJYb6guJUJym06OG40Tffe1xg==
X-Google-Smtp-Source: ACHHUZ4YYd7EtlDPU+uVGzoZq9nt0hMyB7x08rbvKeuLpekdrE9lOzpUyueQY8dazhg3/T001VXj8Q==
X-Received: by 2002:a17:907:a41e:b0:965:e556:8f6d with SMTP id sg30-20020a170907a41e00b00965e5568f6dmr10793430ejc.63.1683577352113;
        Mon, 08 May 2023 13:22:32 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d19b:4e0f:cfe4:a1ac? ([2a02:810d:15c0:828:d19b:4e0f:cfe4:a1ac])
        by smtp.gmail.com with ESMTPSA id 13-20020a170906300d00b009659cdb2f98sm402301ejz.23.2023.05.08.13.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 13:22:31 -0700 (PDT)
Message-ID: <f0915bf5-992e-c6eb-e9f5-21980aa3cec0@linaro.org>
Date:   Mon, 8 May 2023 22:22:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/7] power: supply: max77658: Add ADI MAX77654/58/59
 Charger Support
Content-Language: en-US
To:     Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sre@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Nurettin Bolucu <Nurettin.Bolucu@analog.com>
References: <20230508131045.9399-1-Zeynep.Arslanbenzer@analog.com>
 <20230508131045.9399-4-Zeynep.Arslanbenzer@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230508131045.9399-4-Zeynep.Arslanbenzer@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 15:10, Zeynep Arslanbenzer wrote:
> Charger driver for ADI MAX77654/58/59.
> 
> The MAX77654/58/59 charger is Smart Power Selector Li+/Li-Poly Charger.
> 
> Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> ---
>  drivers/power/supply/Kconfig            |   7 +
>  drivers/power/supply/Makefile           |   1 +
>  drivers/power/supply/max77658-charger.c | 844 ++++++++++++++++++++++++
>  3 files changed, 852 insertions(+)
>  create mode 100644 drivers/power/supply/max77658-charger.c
> 

Actually, with small differences (register map differs by few offsets)
this is max77650 charger. Several fields are exactly the same.

Please merge it with existing drivers.

Best regards,
Krzysztof

