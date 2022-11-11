Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4887E6254E0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbiKKIGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbiKKIGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:06:45 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72D267111
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:06:44 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id f37so7227841lfv.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wzW6L/CP3JU9aJ/7P3tpBHL9NLeMlCLd0ZgoofdW2sg=;
        b=cYVJrYL9XyigjwOHwlHdUoJkG5TMEeQF4838kI3k5QlcT9KvRIA+UhIoQo/S+OR3P+
         eV9qOEHeELufeGAFGtQI3S1B1QSigRKaarFe5Y+0vJMRjf/+TX9aPbRIyIHVTzD9V1J8
         rqHcaw02lH++kljs3R950YmqbvSrI9go9SNxpEkSCoTUwdsRD0PQW6R5G1T8x/b/j9JP
         XMnWboMlTXALeqxBl3RQ+0lu+fb3xrqPn0Ch0g1+QP4RUO5sciosCXFkRNPvTiMuYE1b
         M5jD+lb5FSVZEfO1x6fAuWmXZbbzPXrYJBOggWwxBtPjkngiFelZIpUfmGwXp15M8MQ6
         4NCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wzW6L/CP3JU9aJ/7P3tpBHL9NLeMlCLd0ZgoofdW2sg=;
        b=pHL7oYdAsH4dY0NPLIBRyW++J0pHlCkBHokghwIbTkQ2/XFzeUTjsBEY3tp08zg8F+
         qVC016gjfSex4iSavQsTwrpHxzsO1e8o7Myh3w7/iGX/JaqYakmh+Rh296BkaglE7RmN
         N8ONZZ+3zXEwfW6KJkpfgG6h7HKvzjG3oNpeMZzBmoYCCjvNWctwr259+i7VHxZVwFlL
         VIjCX1ykylCif5jX8icwHoPkzMipEogt5BGxtqR+SQnLHb6kr6DBHs0HFVtBnOXWGgRJ
         qJQXcAcGOVGx9BX9XZPO3w7L8c1eq+CMDbyjN8I8uLVJzP5/h4/+8/p0+QNZvzaocCD+
         siOA==
X-Gm-Message-State: ANoB5plFC5p+VZymcbwtROvUU9Tcaaw2ARaE0eRV43GEC3OSQMbaCfdM
        47KNBk/R4+9BJre6MGwJu8NtvA==
X-Google-Smtp-Source: AA0mqf4tCMtx3vml+FOW1qruEVmCpx0ht4ldvgCAFrRLyBWEYVIgX75BwoIHoFoYlw3Mb7FHAmIYCA==
X-Received: by 2002:a05:6512:1295:b0:4ae:ba01:1f48 with SMTP id u21-20020a056512129500b004aeba011f48mr413033lfs.373.1668154003061;
        Fri, 11 Nov 2022 00:06:43 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id s21-20020a056512315500b00485caa0f5dfsm210758lfi.44.2022.11.11.00.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 00:06:42 -0800 (PST)
Message-ID: <8c7629b8-0477-ed62-ff60-3e9625145a17@linaro.org>
Date:   Fri, 11 Nov 2022 09:06:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [Patch v3 0/3] Addition of new compatible for Exynos3250.
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
References: <CGME20221111031707epcas5p29a5647f3617958bff3b4567e44195607@epcas5p2.samsung.com>
 <20221111032337.79219-1-aakarsh.jain@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221111032337.79219-1-aakarsh.jain@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2022 04:23, Aakarsh Jain wrote:
> This patch series adds new compatible for Exynos3250 along with its
> driver variant data for MFC v7 hardware.
> Since,MFC v7 support was added for Exynos5420 and Exynos
> 3250 SoC with same compatible string "samsung,mfc-v7".As
> both SoCs having different hardware properties and having
> same compatible string for both SoCs doesn't seems to be correct.
> So ,new compatible is added for Exynos3250 SOC which will
> differentiate the node properties for both SoCs which
> support MFC v7.
> 
> Changes since v2:
>  - Addressed review comments from Krzysztof Kozlowski[1].


What changed exactly?

> 
> Changes since v1:
>  - Addressed review comments from Marek Szyprowski[2].
>  - Addressed review comments from Krzysztof Kozlowski[3].
>  - Addressed review comments from Tommaso Merciai[4].

What changed exactly?

Best regards,
Krzysztof

