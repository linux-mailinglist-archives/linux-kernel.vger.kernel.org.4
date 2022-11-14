Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E3A627776
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbiKNIXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236275AbiKNIXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:23:15 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1A31A3B4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:23:14 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id d6so18013600lfs.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UzuIXzgVBbI4qXY2baaAexD3LrP49vG6Bo5QwNa8cpA=;
        b=YJMlPhqFeNe/En5JSvNaDhA15oD31ZMse9whRM9R5LPwhtsPN/ROaaQ6xqXUhrb+2I
         nmWp6UwRwQEEqEia7NDpwEbD4ooM7Z//wQOI5Ncx/7f4B3ZjU+4w+BSs0JjqjLmiHaxU
         /XJDDRYCathOvQJxVI9v70feKtVRThE/5yYbOLIXtLKNUSa+GOHpVcWxePFgEeo98chV
         mxu4HS6ep/qv/bcQZK2oSyl2dIeCzvwtAPgd9jcwO6GQHGswalz1HzLndib1oZgbAx5h
         RgzkHfIP7KqUOV5OJjAqEQxvmG32uGIDyfAgQyZ+aq41D6+nJ4Mj4fNslZ/xuELk84oL
         PlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UzuIXzgVBbI4qXY2baaAexD3LrP49vG6Bo5QwNa8cpA=;
        b=kjJ2lwK9O9Zl2TGSQIlZfFrabqhFFzVpRkopEOQh/XIKSokgdozddA26hftn5nS8Cx
         Jz/kwSzAlUnXHoai2CRods7SiasI3K7oqSPPHwLlxEBH4/kHrIls9vnrxKcoEQ1H6nzQ
         degncs1sxXTsbfs7LmqR9Bme92TlPVkmeNRfOMoZ+qFQ4vhf53+CuYb8CaQBZOYhfYEP
         hOf8OnTkhVm3h/pgQ3INyu3Ek/51n5KdRCVfyFWRYUSYQLScorVZG26Ex1QARH5HI/SZ
         UahfWmgQyhXr6+HUtn/4SBRPSE4lBgR1U0GKLoC8/MH9FOmBOby2xdF03bZ/mKM2DNPe
         h7SQ==
X-Gm-Message-State: ANoB5pm6eb1E2O32lCrrrd4mehWbdrqnFJULCj6i2eRYE2wbmIVOg5p4
        I/Uc+kj9QazI9cJjLK7U4EKkIg==
X-Google-Smtp-Source: AA0mqf7OUWm5Rtc5riD3KjJncb+wbHHVjUlqyYJCIr+E9i9SC0nA2fTXhPR4SKM4Ub72vdqTFuJ6OQ==
X-Received: by 2002:a05:6512:3f19:b0:4ac:3f87:151f with SMTP id y25-20020a0565123f1900b004ac3f87151fmr4039536lfa.398.1668414192605;
        Mon, 14 Nov 2022 00:23:12 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d9-20020a056512368900b004b373f61a60sm1741674lfs.96.2022.11.14.00.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 00:23:12 -0800 (PST)
Message-ID: <c0dca253-77a0-2a0a-8a03-2a727512eedb@linaro.org>
Date:   Mon, 14 Nov 2022 09:23:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/7] dt-bindings: iommu: qcom,iommu: Document qcom,ctx-num
 property
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robdclark@gmail.com,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        marijn.suijten@somainline.org, kernel@collabora.com,
        luca@z3ntu.xyz, a39.skl@gmail.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20221111135525.204134-1-angelogioacchino.delregno@collabora.com>
 <20221111135525.204134-2-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221111135525.204134-2-angelogioacchino.delregno@collabora.com>
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

On 11/11/2022 14:55, AngeloGioacchino Del Regno wrote:
> Add a new "qcom,ctx-num" property to force an ASID number on IOMMU
> contexts where required.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  Documentation/devicetree/bindings/iommu/qcom,iommu.txt | 1 +

This is already a v2:
https://lore.kernel.org/all/20220527212901.29268-1-konrad.dybcio@somainline.org/

and your v2 was a v3...

Best regards,
Krzysztof

