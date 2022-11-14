Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E19A6276B1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbiKNHuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236039AbiKNHuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:50:03 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3A418E3C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:49:48 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id x21so12058609ljg.10
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pLUcanZpIPDIxYags5evcbs5d8jq/ba7Gm91KfYxHmM=;
        b=q1+u7puqkZtKO0ytMyIuatmp924hrXzJxIhk4WP3Vog1+uZT+JVla/nHxaGcTYv3Ah
         tRDDqdVJIbf7Ep3ivml+zhk+TrxLfaY6AWPVCBwT1xsH1Ux6xZHBavpTkGHUxCQQ50By
         +NeW3lZvYWf/ZlnLt03JMqo9k8/gTTqeeR+6NaV1vxRzBmPjvTJMsy03vzv9WXcQ09CI
         SMOTTB6E1He5fXawjuiCESv6IWVR1aWm7btPCmzzYvpxogR1T4+LXG7jpM48EeC5kXW+
         sny1KX/3IcAmpAP1iURN34zAZ9noQb6hE2x5iUxyE+2Vk47cbyVJW3GpSJV7jEKKbYsd
         KcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pLUcanZpIPDIxYags5evcbs5d8jq/ba7Gm91KfYxHmM=;
        b=chUnXO4JmqbqBMs9Pxu/QzPib8PIFVQ/jkEWWhATc4WOvJsunppemggoxaxEfOIse5
         EFuvs65kBagNHBL9DCcPqSrBgJSIlJKOWmRxBk8RHMAoGeFdNhiO4QhJJBaISCkSAfOD
         t/onKt9jIv/Jh+iOKyLAU9C9Weda+gjd4Chc8nGWUSsyzmAg68GqYGmfC8xNEXNyU+zE
         4etBgh7vshorxUoSAmaoCNvGlFK6T+uRoDTaFVGzbiY8GFHBAIEKkENY9RIWLvmmi/2Q
         yQW4TrVUOFnAXh6pmvPmaJXpZVSR/Rr2a2YLxG4oelH7BSr2F+1iPEXygbS8jofmsObm
         C2gQ==
X-Gm-Message-State: ANoB5pkFiC65nEEekWBZX4jww+mMo9SO8NqcU7V1uQaixW48prSZXdPI
        nZuqMWthevOtnwGzz1YFsSHu+A==
X-Google-Smtp-Source: AA0mqf7+/iFcHz+MUB5JgOVurFgigYpSTd9rLYyoVKgjk4rRNQITNByYGO3a4WL6LigSqBxhDwBkjA==
X-Received: by 2002:a2e:6817:0:b0:278:f852:e75f with SMTP id c23-20020a2e6817000000b00278f852e75fmr2231114lja.433.1668412186494;
        Sun, 13 Nov 2022 23:49:46 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id 19-20020a2eb953000000b002770f7d8dcasm1892940ljs.134.2022.11.13.23.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 23:49:46 -0800 (PST)
Message-ID: <9a374649-3517-98d6-b971-fb054edf9f04@linaro.org>
Date:   Mon, 14 Nov 2022 08:49:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [Patch v4 1/3] media: dt-bindings: s5p-mfc: Add new compatible
 string for Exynos3250 SoC
Content-Language: en-US
To:     Aakarsh Jain <aakarsh.jain@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        stanimir.varbanov@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, andi@etezian.org,
        alim.akhtar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, smitha.t@samsung.com
References: <20221114054655.68090-1-aakarsh.jain@samsung.com>
 <CGME20221114054044epcas5p31658120e6d653d4f56177b70f5583b2a@epcas5p3.samsung.com>
 <20221114054655.68090-2-aakarsh.jain@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221114054655.68090-2-aakarsh.jain@samsung.com>
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

On 14/11/2022 06:46, Aakarsh Jain wrote:
> Since MFC v7 support was present for both Exynos5420 and Exynos3250
> SoC with same compatible string "samsung,mfc-v7". As both SoCs
> having different hardware properties and having same compatible
> string for both SoCs doesn't seems to be correct.
> Add new compatible for Exynos3250 SoC followed by mfc-v7 fallback
> which will differentiate the node properties for both SoCs which 
> support MFC v7.
> 
> Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> Suggested-by: Alim Akhtar <alim.akhtar@samsung.com>
> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

