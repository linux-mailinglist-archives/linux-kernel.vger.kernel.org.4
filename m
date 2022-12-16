Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F9E64E9D2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 11:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiLPK4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiLPK4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:56:37 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37E02DE9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:56:36 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m29so2681697lfo.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VLuAMovx3wtMwAZuA9wPgXsMxzyrcuLZS+V5UGunqYI=;
        b=M00egMnkPSfthC3etGdifZG9wOqcc/otExoRD7b8l9w3SDvgCzmznQrvNeCzm7UbA6
         juLNxaZd1b6EiCKuuixpeln1Bk3MA8D0zk9e2JIkDjMRIGhVupD9JLSnthwAw8Ka+lRP
         KHkx1wXxvvyE8FkMQPcTSUtLkB9RyrT3e//sYX/UiEVpCJcz1uxN0s0LJMe/LNsgk2Zb
         NuFM1BOIAU/WiSURWLmLiuqIdTEkVkFE8QAnotjxcXD8IcjUpIfqTUzvjFAh+JyfDRae
         hID6tTnjRqbL2decER67YBEEfGq5Vx+US5iT9FFD6yld6Igvb8uiF6UzmQDP2yZN/NVv
         /tog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VLuAMovx3wtMwAZuA9wPgXsMxzyrcuLZS+V5UGunqYI=;
        b=NlgtHMxz9+GAZlBgzeGm5JkERcQY7pIdoXln+f5UlYjTbLUN3t6EGujax2keB6NJf2
         k1E5gqr9mdrHj3qAnhlbaF0q//99waJMpi+mEju1Rjm4JEqQvBDQVsJTPCtT5Y2GcxLp
         Fy1s6ES+sRoUTrPyadvatg0nGfXQVSPU9j/dzagMBx5zcKtBeXaB3HWT9JgBLeH6bLAG
         0hAF0CA89dZVkTquCXMVjP9DVSIJ4tvqo1Jz3UWIdvj33GCNyrPxjJFvvL4eHRCMkPIS
         RZj6df5oBneHba+gOSw912+SnnQXHKm/KpAJtnlnFwJyP9xC32c4UMsxy/IiPmFdhVL6
         W5AQ==
X-Gm-Message-State: ANoB5plw7jjuWwVLgDYLpOOcRYxloCSXEiIYvHKx7QG8lxqL6iaSSOAA
        L+PczyqGMLrOCTDclNEC+rexog==
X-Google-Smtp-Source: AA0mqf5u7uT9Ts0c/ckCortFeduDzB0eX4KG+Bhq+eyVZ8DnJz3m2v99vVWmipTyB9SkJpCfyidiVQ==
X-Received: by 2002:a05:6512:4cb:b0:4b5:6417:43bb with SMTP id w11-20020a05651204cb00b004b5641743bbmr8179726lfq.51.1671188195296;
        Fri, 16 Dec 2022 02:56:35 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id g8-20020a19ee08000000b004b5634f9b9dsm188718lfb.115.2022.12.16.02.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 02:56:34 -0800 (PST)
Message-ID: <324cce2c-ad75-014e-0647-87c9b8e845c5@linaro.org>
Date:   Fri, 16 Dec 2022 11:56:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/4] dt-bindings: power: Add MT8192 ADSP power domain
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ikjoon Jang <ikjn@chromium.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>
References: <20221215120016.26611-1-allen-kh.cheng@mediatek.com>
 <20221215120016.26611-2-allen-kh.cheng@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221215120016.26611-2-allen-kh.cheng@mediatek.com>
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

On 15/12/2022 13:00, Allen-KH Cheng wrote:
> Add power domain ID for the ADSP power partition found on MT8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  include/dt-bindings/power/mt8192-power.h | 1 +

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

