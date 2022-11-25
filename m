Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B57638CB4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiKYOtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiKYOtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:49:16 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECC521E11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:49:14 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id s8so7230702lfc.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xNPy40s2BPmi7d6v+ulfkIvVTaVgsEKVuTaAekdgNxg=;
        b=IlJ05o48+8OuRyWJoc3IhN7eIiMk98yN/eF/6MaEBN5+wjylbStpKcIbn5X7QveH7X
         7NXABP5aoGsvaySi86ydt5sCb/KGRm+Dw+ECWZe45Kwl3o8EHW4ZTbDVpymhS0h2qDRn
         GQhkJPEvBOd/ooKkRE02SZVZaG6PSM5wfFBSUQOtjmWRobu3w7gfSyYTdJyJ2rHV+uAL
         zHU8wCDqszwD2nYgLXksic6mmtnsBO6LXcb3dsCZRtBRArGG3dKFPkVqEwwn8XMcimHn
         iq5oe6UMv9y1l/6sjdLod/Kyz1Tg/YCS3oh6IO1Li9jnsybwwtqWTawCA/zQe9KWCq4M
         aICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xNPy40s2BPmi7d6v+ulfkIvVTaVgsEKVuTaAekdgNxg=;
        b=Ah5h1OakcvOg57XA6n8Nmg30beNdUGQTwaAdmSZn1774k8AyjqYh47lPIOj9EO7Rfv
         Pp4lU54cELR8SIKNB7RnYyFqBNArTYGZnLKtZx0lf/2b9+8r5sTxpVF0ZQfZbpMy+GMX
         1k5N++/mJ4cSXJv/mktvEblnexHgqLlsuXuol6iIs924I0ip1jXI/jViHZZf9X3iiE8k
         iH0Eq/pimmwtTSofBOlF1DmiwQlDJeR/Eg93vrvwhql1fztc1k71yIdQ4iSxOuvO+mun
         6LIL0NJynuXU46VcqCpEvL8xobMgDOvHpmA+CXaeRsjne9oEUDBuXAVne2BHTycVlwtt
         lu4w==
X-Gm-Message-State: ANoB5pmIMdY2xA74d6nNEVgB6ibGai/lKGI2gJ5NStAaFCa3VI4ohSUI
        Z7btzl/2kdIQnBOVDCoiLGKCDQ==
X-Google-Smtp-Source: AA0mqf4bce/D1OJeUf4UCKOv4zGJQnRoVTveEJVWArehvP51fU5aC7O5xk7KIGrSeEQmFBAgmaEZpg==
X-Received: by 2002:ac2:51b6:0:b0:4ae:8510:646f with SMTP id f22-20020ac251b6000000b004ae8510646fmr13550031lfk.432.1669387753066;
        Fri, 25 Nov 2022 06:49:13 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v12-20020a056512348c00b004994c190581sm555549lfr.123.2022.11.25.06.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 06:49:12 -0800 (PST)
Message-ID: <ff33d45c-f4ad-49f3-24b6-b15b4af5aa83@linaro.org>
Date:   Fri, 25 Nov 2022 15:49:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 4/4] dt-bindings: soc: samsung: exynos-sysreg: add clocks
 for Exynos850
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Sriranjani P <sriranjani.p@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>
References: <20221125112201.240178-1-krzysztof.kozlowski@linaro.org>
 <20221125112201.240178-4-krzysztof.kozlowski@linaro.org>
 <CAPLW+4nSLP4ZpnzYrOfMu0uOQ0OYnWsnZ=sUppxts6O_3-yYZg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPLW+4nSLP4ZpnzYrOfMu0uOQ0OYnWsnZ=sUppxts6O_3-yYZg@mail.gmail.com>
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

On 25/11/2022 15:38, Sam Protsenko wrote:
> On Fri, 25 Nov 2022 at 05:22, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> Exynos850 has dedicated clock for accessing SYSREGs.  Allow it, even
>> though Linux currently does not enable them and relies on bootloader.
>>
> 
> Not sure if this description is correct. Of course, there is no driver
> for "samsung,exynos850-sysreg" compatible at the moment, so the next
> compatible from the list ("syscon") is used for Exynos850. And
> "syscon" driver (drivers/mfd/syscon.c) actually does control the
> clocks. I remember adding "clocks" property to Exynos850 dts to fix
> actual problem. Also, the "clocks" property is not described in
> Documentation/devicetree/bindings/mfd/syscon.yaml, didn't really check
> if it's ok or it's just missing.
> 
> Other than that comment:
> 
> Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
> 
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Ah, then commit msg is not good. I'll update it and maybe the clocks
should be required for Exynos850?

Best regards,
Krzysztof

