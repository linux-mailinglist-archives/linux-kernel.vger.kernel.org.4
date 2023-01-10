Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56F4663D48
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238312AbjAJJvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238299AbjAJJvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:51:06 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4381A07B
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:51:04 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so11358084wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WrQzOa9EiO3FMfIzNKHzQ3EJooWDcByw4FpVYo3LxlU=;
        b=Pp4SFUbS129IGAbhEsVjQoc5E5ovtTjU+hsh6jYN+BKENx/6Xoeqzx3afnbfz451fL
         6L6ab9gLkQb2muLgNIxbPrpeOjIbKXQJaIJOlef9FFG8PE3ObK7GkrBbo+h2dOZnRr+J
         KkDeWrnnCFgWb30BB6JBLG1TFRG36JfGVocEMQ16qDgC94jRBHRZ2sexLDVZSMOMOsMw
         28bygG4Kv2CWUu9mvlnjPN4Tz8CMxPQ0q81BH39BYb6ifOjSjHqW2UCugtHF4tO17wEw
         hTCtVBHthIJ2OYitMOgt8xSSlSPbg5gkDNl34C8TnF6z7OyRShUccMeJhhA2SQtv/MYJ
         SCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WrQzOa9EiO3FMfIzNKHzQ3EJooWDcByw4FpVYo3LxlU=;
        b=imRCMnIujfDhC+lDYc/NBo25hhfnLJ0j3PPbAV1c23e7jQyHYiIbtMlpyfbkfkBF9N
         xq8u0de5R6X+NaAiC3M4cjknKdsddQwyBpXCZH5dT0UrAGrsel03TnHkeDOUmrFcsavJ
         CmJr/T32DPzsJoBQ39Hv9OFZfHshSwgkNOf8TCzpUnXm7QtTC5KX4E/Oj2IEI8DAzyOt
         mHOJbt7t4RGVCi1TAHQoH2tLy4m8HJD8xlVUjkb+1F/sPTSJ2ZCL8edJlICa7+p/Gk2Y
         kv/USHPYZpvwcF/7pgvqXFjtd3OShIfwyUzwYj5N/0yeK79QTTVbb6Mw3cC+qJQm46/T
         /FGQ==
X-Gm-Message-State: AFqh2ko0vkjP0AODnMOxnxf0I03j727f/9/Gwm5cbP/uvr74a1jzXAhj
        2Tlh/JzyZZV/2PJ6iTre/UMeDw==
X-Google-Smtp-Source: AMrXdXtMklGbOTYDwKJIdQhxGy8wSTO8g3hNPyeO13I2MacEos0LoZRtrvbAlFBRnPJOdOR79a3eHA==
X-Received: by 2002:a05:600c:1c21:b0:3cf:9844:7b11 with SMTP id j33-20020a05600c1c2100b003cf98447b11mr58927717wms.23.1673344262653;
        Tue, 10 Jan 2023 01:51:02 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j30-20020a05600c1c1e00b003cfa80443a0sm16128859wms.35.2023.01.10.01.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 01:51:02 -0800 (PST)
Message-ID: <83e7b2b0-1840-bc8b-e657-ab94975b955d@linaro.org>
Date:   Tue, 10 Jan 2023 10:51:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 5/5] MAINTAINERS: Add maintainer of GXP SROM support
Content-Language: en-US
To:     clayc@hpe.com, linux-kernel@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        verdun@hpe.com, nick.hawkins@hpe.com, arnd@arndb.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux@armlinux.org.uk, olof@lixom.net
References: <20230110042533.12894-1-clayc@hpe.com>
 <20230110042533.12894-6-clayc@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230110042533.12894-6-clayc@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2023 05:25, clayc@hpe.com wrote:
> From: Clay Chang <clayc@hpe.com>
> 
> Add Clay Chang as the maintainer of GXP SROM support.

Your commit is not doing it. Nope. Either make proper entry matching
this commit msg or make commit msg reflecting truth.
> 
> Signed-off-by: Clay Chang <clayc@hpe.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea941dc469fa..164571ac1cc5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2279,14 +2279,22 @@ F:	arch/arm/mach-sa1100/jornada720.c
>  ARM/HPE GXP ARCHITECTURE
>  M:	Jean-Marie Verdun <verdun@hpe.com>
>  M:	Nick Hawkins <nick.hawkins@hpe.com>
> +M:	Clay Chang <clayc@hpe.com>


Best regards,
Krzysztof

