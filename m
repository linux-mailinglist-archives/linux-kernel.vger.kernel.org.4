Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40896FB848
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 22:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbjEHU1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 16:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjEHU1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 16:27:42 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA85549C0
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 13:27:40 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-965d2749e2eso662753466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 13:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683577659; x=1686169659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RwPGZohtIhTLGbhGn1RTQacp+p71rXmAWY6DiVDMMUs=;
        b=x2wzcu3gmCYSafwyCmK5QcTKTH9wLDEXlfRKAc49ww8Tktnn3aNTPsqAONIvohovCk
         8zBRwq3uyEJPJCa2ZTfqQZihNWZOM/8e0BtshqY24oRRa1qphO9khA3i28HolsVcIFu9
         tDyTu3ZTWci3Kx+pogen8YxIqDfhCYp094PGsr9YTxe6WstnzsehaBO0HZuEppPuxMVN
         h5ue5n+VbOiK/Z8mYpDtylGAzW4hGzCpbmBknvjD6M9i4nXud1Bje/uVTwesPucCn+2I
         ta7frnzCv1PWXtB1sroJBW7wPC25eHz6fFHlo7Slh20b2GqWgj3C/clzryxeFUvqmwln
         hFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683577659; x=1686169659;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RwPGZohtIhTLGbhGn1RTQacp+p71rXmAWY6DiVDMMUs=;
        b=eOjlDIVqHbspcNwJc9f23yd68eRZW8WJ3xQGYqCeGVUD/uv1Jjw+7XeHvcAfr9la23
         kRjqOaNg5xe7DATczMG+Re9xDz+IDqDpw79ShdsQhnkPRzv019GTQjYbhXIO/yk7r3F4
         BTQrcCUiKZ1GeYJgA1KISKKeImT+eSJTJn3Iqc/0Uw04xhbg6jAu2OyfweA7076PXFa4
         1D76s20Fcqo2PHTRvgFQcwyQXwHxitf8LP6iXARPXMc0hVszyJaaoNs31sjXhqjezZ2r
         TrG2grI9Yp+JQD44nPFpUPDNtati/VAr6nDYHdQ9ly7mB4/3T17n1098+zpkH7fk3le0
         yPIQ==
X-Gm-Message-State: AC+VfDyIxRyCsBGFV12cWRTXukTG9Cm8NRmccFQpih2Bz/5Umhom5dzs
        oQvDA91e0NLSXbb6dhLZ8UkW9g==
X-Google-Smtp-Source: ACHHUZ6hZAM4kdxPqqCWUmLdy8xpkePKc6Yh0uuXCecerl6cvHyj8SdpLKLlZ5RbzXKMZPA6x1SApQ==
X-Received: by 2002:a17:907:d89:b0:966:168d:8c9 with SMTP id go9-20020a1709070d8900b00966168d08c9mr7708879ejc.32.1683577659344;
        Mon, 08 May 2023 13:27:39 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d19b:4e0f:cfe4:a1ac? ([2a02:810d:15c0:828:d19b:4e0f:cfe4:a1ac])
        by smtp.gmail.com with ESMTPSA id w10-20020a170907270a00b00965e9a23f2bsm388691ejk.134.2023.05.08.13.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 13:27:38 -0700 (PDT)
Message-ID: <669ba770-4ee1-e7e3-0692-51e6d6df0229@linaro.org>
Date:   Mon, 8 May 2023 22:27:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] dt-bindings: mmc: brcm,kona-sdhci: convert to YAML
Content-Language: en-US
To:     Stanislav Jakubek <stano.jakubek@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <88c64da50a1af868d8b14054c440e5ff96a63399.1683548624.git.stano.jakubek@gmail.com>
 <a1fd4092b8a31c2ee58a3cd4cca062db13197b45.1683548624.git.stano.jakubek@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a1fd4092b8a31c2ee58a3cd4cca062db13197b45.1683548624.git.stano.jakubek@gmail.com>
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

On 08/05/2023 14:46, Stanislav Jakubek wrote:
> Convert Broadcom Kona family SDHCI controller bindings to DT schema.
> 
> Changes during conversion:
>   - also mark reg and interrupts as required
>   - drop deprecated compatible (it's been deprecated for ~10 years)


> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include "dt-bindings/clock/bcm281xx.h"

Why different than <>? Keep <>.

With above:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

