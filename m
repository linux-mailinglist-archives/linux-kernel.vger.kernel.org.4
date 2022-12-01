Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F25063ED92
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiLAKWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiLAKWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:22:31 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FD4442F8
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 02:22:30 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id q7so1334607ljp.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 02:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c2LyWUsrGr+KOW/s9GALL+g5mR7trWF5Joo3KOJ8Ejg=;
        b=hlTG/EbRq6cXGljyfQO0IfWwSOjYdBmZcWFqpYM81+yxsTPVL+vTOMLn5cYFWbJhwT
         /lyJQpmi1IS3x7GWBYlsxXiM4NDtcMB2j7JX4WqxZ3lCyNN+BNfohTgBDJhWl9yiSS2u
         2MdvPLcSAu+u/UXhSqniu8WwVwCe1snHo0JoFm47IyDbjJbniuLlKtCyB3Mvnp6oA+p/
         AAx1Jt/unu6GbkKdQZ40+ef6E3DZQKNkTHTZT4kwFkqzaRupuitRM0QRUQtA997Nfvq5
         /OpZeR02auQr8mrVjfei+iVWbWHLzhc7zi9FQ37SF1VZRLcEFOs+mGUFA7NqzHddIhxd
         TlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2LyWUsrGr+KOW/s9GALL+g5mR7trWF5Joo3KOJ8Ejg=;
        b=RVYlGCihK3zx7h4/sGIOFvXLcpVAc8scUoFbKHUKFyVHGOwblxISYk15yWow0K2vWT
         cPD8jI4qzwMUTaNb1s9j8KRm/56PzxaG0JSk4LOlF53zdGH3nUDMOh3M1r4ogMbLvcA5
         EXnodsd3kKrSEpTkIQx9qpinNpZ3RBpH1/yhKFJ1RT64BY4MgP6cIGtVEYa1S4mpNaYu
         TrN2/mF8tDwogsn314FG+ikZolID/DTvah1rhlPO12bFX5THApfjWxBOUJZbxcDJu1vl
         eY7s0StRRuVBd4eIcjLCCfEjfodt3fUi6MC5Shi0MlE37TeSOiBQAnuoD4coUX9MPEZA
         wLyg==
X-Gm-Message-State: ANoB5pl3/QOigWzWIeMaTfb4t8s6nZn4rhx8YT0GT5dWk7mPpbJu5+rN
        7NSDQ7TedeDJ03EgCy/EGe/vzA==
X-Google-Smtp-Source: AA0mqf7qNngpU6jQSjBPS8ynWLgZ9UQtDWu99NJDaw/LOnYWcE4iGJHPtsDc/ZZjlfMlbIq3g0Q8Lw==
X-Received: by 2002:a05:651c:1a07:b0:277:11ae:d44e with SMTP id by7-20020a05651c1a0700b0027711aed44emr18417888ljb.458.1669890148788;
        Thu, 01 Dec 2022 02:22:28 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v13-20020ac258ed000000b004b48c977d8dsm600398lfo.125.2022.12.01.02.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 02:22:27 -0800 (PST)
Message-ID: <8c1dc14f-e0b1-b5ce-aeef-68c20da5dc63@linaro.org>
Date:   Thu, 1 Dec 2022 11:22:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] arm64: dts: mt8192: Add adsp power domain controller
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>
References: <20221201073328.1559-1-allen-kh.cheng@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221201073328.1559-1-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2022 08:33, Allen-KH Cheng wrote:
> Add adsp power domain controller node for mt8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
> Ref: https://lore.kernel.org/all/2ec80bd8-dfef-d2e6-eb41-6e6088043e33@collabora.com/
>     [Allen-KH Cheng <allen-kh.cheng@mediatek.com>]
> ---
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 8 ++++++++
>  include/dt-bindings/power/mt8192-power.h | 1 +

Bindings are separate patches.

Best regards,
Krzysztof

