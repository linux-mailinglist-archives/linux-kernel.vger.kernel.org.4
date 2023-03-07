Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693796AE7D8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjCGRC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjCGRCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:02:25 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC89556166
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:58:16 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id by8so13849915ljb.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 08:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678208295;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GYPS6T0GQT0YMU3PoBe/ezLSZBLT3NTyr0o7Ri1kY9k=;
        b=UY5DImM1KYh2Pcll+wLQFh6ZZ9XeQVrzKMzij0we3VeD/meacUUkLWEfu9XdsAnuJH
         fKQqrD56jeBFjR/LND7RB3LfloFCotsIPs72SS+/Y1XbOpal1JNSScf8Av1ucq+KmAj1
         W6g7quXpehwu703Puvoqt1yzFOY2Q6bI99Pk941TcN7pZ04BO9AeA0nG+dzLFbXcSQ7J
         J+Nfx3EJOBf5TgQwRgf5JD4QriI8MifmzZzu5hTSS9oCHSpsv4LePN1LJyReVFhlS3US
         2In1jrqo/YgeTLfhMVZuixBzECuWC9i+7oIEILlaqdmbiQZjAjduVLXjM5/kfp/GJrgt
         JFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678208295;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GYPS6T0GQT0YMU3PoBe/ezLSZBLT3NTyr0o7Ri1kY9k=;
        b=MEAWJ4prXY0qPxvrIOFdzl9U4sFkLblhga57wz3YB7+rwauCOCEExlIV3mYjD3JBYp
         vw28nnIU4nLFgSGnKBl6J0Q952AbFBYf3jsZplUce3HxBclqWu12kkdihyLJpgqi8FkM
         JgHdx4HI6XdVSAaHMAEpGMKMJzNOuOwMP2hXTA+QaZaC9MaCHw9X26JuU5TbBz6it0tG
         0jHB97m7DOWt9NYm4UcicAj9Zxq9yyP6wRbdFxwwXWkFVKReik9ZhIutoxj1d2N1NCgZ
         XY5vu8PWprteXSOW1xa+IaqDRZh0biYCslF1Hp+fP+SMC4mbh8Yiar7f+JUV3lohiUdu
         xUiw==
X-Gm-Message-State: AO0yUKX6xkNQwNNFUiInpWOYsDLSvPBCH9PKUntlV7lIaRK/2HNqXHUU
        1xhOb9oDIQdeRw+LhKlOQ4mVYQ==
X-Google-Smtp-Source: AK7set/BvoPPVaX8qUlMUC5WSo8HDQZFTRScfOMiSPiSx0DvSiUNYFHH9jM3kIhnoq2STd3i6igBVQ==
X-Received: by 2002:a2e:910d:0:b0:295:c39c:d8ab with SMTP id m13-20020a2e910d000000b00295c39cd8abmr4207730ljg.39.1678208295021;
        Tue, 07 Mar 2023 08:58:15 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id l18-20020a2ea312000000b00290716d65dcsm2236391lje.136.2023.03.07.08.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 08:58:14 -0800 (PST)
Message-ID: <d237d1c6-4b07-2f7f-8812-34365e56380b@linaro.org>
Date:   Tue, 7 Mar 2023 18:58:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 6/6] iommu/qcom: Add support for QSMMUv2 and QSMMU-500
 secured contexts
Content-Language: en-GB
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
References: <20221115101122.155440-1-angelogioacchino.delregno@collabora.com>
 <20221115101122.155440-7-angelogioacchino.delregno@collabora.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221115101122.155440-7-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2022 12:11, AngeloGioacchino Del Regno wrote:
> On some SoCs like MSM8956, MSM8976 and others, secure contexts are
> also secured: these get programmed by the bootloader or TZ (as usual)
> but their "interesting" registers are locked out by the hypervisor,
> disallowing direct register writes from Linux and, in many cases,
> completely disallowing the reprogramming of TTBR, TCR, MAIR and other
> registers including, but not limited to, resetting contexts.
> This is referred downstream as a "v2" IOMMU but this is effectively
> a "v2 firmware configuration" instead.
> 
> Luckily, the described behavior of version 2 is effective only on
> secure contexts and not on non-secure ones: add support for that,
> finally getting a completely working IOMMU on at least MSM8956/76.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> [Marijn: Rebased over next-20221111]
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/iommu/arm/arm-smmu/qcom_iommu.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

