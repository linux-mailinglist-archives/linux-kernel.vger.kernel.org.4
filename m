Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A128E6A05D8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbjBWKSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbjBWKSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:18:42 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939D443447
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:18:40 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id ck15so41517077edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3/aXgtpRAAmBlOXzSkXhzdZkmLPBehTIrS5g09JIRzo=;
        b=RR/sD/ukR85nWBQeNICDAifane3oP+7Bybn5qjnm19TgMnsrsto6pCq9Pt+E3r13jT
         /P33bRNSNAWwKjnNcsW6fC/qtxrrpIGPOSrGnGIOIPLXAEV1mMSqf4V65f9t1N/tJJvi
         zYpEMUCtAC/DeUFJ9H26EmKrfC1vcBCL1mtGV1E0zOLx/8vGcdRDc/4GaftPQSLkXg5k
         atRKjrpbdKdEG3ljIXHnHMNCAiVnoTnEawL0jNuzzEKBakgXAAtvAb0h38oej3Lepgox
         17UopHUpoBz7rlcmZIh51n1D2eBedl7ret75IOupB17G1j8ueN5xpqjYS4fVjwGgXOoD
         xXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3/aXgtpRAAmBlOXzSkXhzdZkmLPBehTIrS5g09JIRzo=;
        b=bE8B9uOu31SEJLYhmKnN7B3+hl32NoR7ByJ9eCuWZEA+jA5bokKMAvoi8k0aZrc4CN
         z0q9EDCPw3CJG8qPXeobPTOCx+RdgEoXWhJZHpddCWMV/JqG2iVDNh6f9FVxLD1at4Qf
         /hlQOIB5+xfZqAkRBicM5MLkpyOkohvjZ5POOvrEsjHWzx1AjG4hS2zp/dIYK8UK4EWX
         nlembPB7j6gofBIv7wY0XGnOgAN9GK2+zmIE2kk4JeA5GCD+3Xlhdjm7SYBQJjA1ZJX4
         m7dTnt41fXyq625apPeJM1LXvc0IxKXvmogcUNXMHjC7qJAs5aZWyV6AFY5GT2ilJMnQ
         iHCw==
X-Gm-Message-State: AO0yUKVgEECa1fhZdlay6NYjAglpV12N0t//rCScYJVDSOi1gWktyZqx
        FFQNFKkhPLngf1uATo7nhent3Cjfcon/kWof
X-Google-Smtp-Source: AK7set+auc5RST/uYYMVLzBpn9BjsWrPQ8Bb/2gvNFfSEYyoeQt+g8Sqq38q4SabwCeG1Q4hXbGabw==
X-Received: by 2002:aa7:d88c:0:b0:4aa:a4e8:8d5a with SMTP id u12-20020aa7d88c000000b004aaa4e88d5amr11193144edq.33.1677147519115;
        Thu, 23 Feb 2023 02:18:39 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g9-20020a170906348900b008b11ba87bf4sm8288218ejb.209.2023.02.23.02.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 02:18:38 -0800 (PST)
Message-ID: <ace28a97-b43e-4b24-52d0-93bc21263aff@linaro.org>
Date:   Thu, 23 Feb 2023 11:18:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH RFC 1/4] dt-bindings: clock: rename mt7986-clk.h to
 mediatek,mt7986-clk.h
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, linux-clk@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>
References: <cover.1677089171.git.daniel@makrotopia.org>
 <15d718a2d696d29b48668b9ab5531369c537a1e6.1677089171.git.daniel@makrotopia.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <15d718a2d696d29b48668b9ab5531369c537a1e6.1677089171.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2023 19:09, Daniel Golle wrote:
> Rename dt-bindings header file mt7986-clk.h to mediatek,mt7986-clk.h,
> propagate this change also to mt7986a.dtsi which is the only user.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  arch/arm64/boot/dts/mediatek/mt7986a.dtsi                       | 2 +-
>  drivers/clk/mediatek/clk-mt7986-infracfg.c                      | 2 +-
>  drivers/clk/mediatek/clk-mt7986-topckgen.c                      | 2 +-
>  .../dt-bindings/clock/{mt7986-clk.h => mediatek,mt7986-clk.h}   | 0

You cannot have bindings and DTS and drivers mixed together. Which
points to fact - you cannot make such change... Also your commit msg
does not justify "why" you are doing it.

Best regards,
Krzysztof

