Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19B77497D1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 10:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjGFI6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 04:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjGFI6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 04:58:17 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C707E1BCA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 01:58:15 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99342a599e9so54197266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 01:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688633894; x=1691225894;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fayqxLh/vco+SYInwt83ea7CX6FUWQU2usKrCQ013+k=;
        b=SUHGYVGhzR4ydLLC3EczqM7/h6WyxuOP9FR5zKpzrxTsJrLh66qKsFCYMxex/QcrLA
         NL1nUlWdl/RfC8wWgtBQ8KNBsAo260fgTZiWgFlMcI87P2w/8QIco1+PtLz/axGfoTm+
         eBfGmx37NrrgCwr5DHiABlwgUon4P+36PgEuG0ZrDSjrWRh1XmZsU76R9A0bQKCd6jPK
         46+5Y2uagL6AOS32r/MpE47o2Yfr0kJF+UPbjFWGtQs9apRKiwsjRvRP8AoCuJirPihn
         5/FRjQH7uPix9qG760X2c+BNfCqk8NyGfgotPYQ3W++7bMUU3RnKKPHZzMHDkioQhZj4
         YL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688633894; x=1691225894;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fayqxLh/vco+SYInwt83ea7CX6FUWQU2usKrCQ013+k=;
        b=aiBS4KdaG2BywM97Bf2BqdKsR5tUYauQcb8YjS4YgmU0wLEZEDVT39t+8sa2LYnfRq
         ++xp8bgM+dmIHp6ABMX/dCcQhqaX2RrtIHxPUwAP4JiRYAeFcpvn/IE4NA94A9T5ybJq
         XLjBNHime7/2udN9EXYNSZKuoz1cwe8zm3orTFh0bpaJIzKisxZpJiEQeDivITLNMhJr
         a6yUEspROUT8VxOIbll/e9stYlBdM7dneu7AkEITI4/93Yr+DXmlk4I0R0D8hmkPOEV3
         p6l6/EnqtRn/EQzg6psqXe1L9J5kntd4C5SmJnuNP9oaSXVWSJdjcfHhdXqt6pf6nKj/
         IaUg==
X-Gm-Message-State: ABy/qLbiXVGDlg/8IwdpQOv45ymtq1eMZVecGdWw2mDMx/yZDbf0yEtT
        67OGRAAA1j1RJ2LsFf9TCFB57g==
X-Google-Smtp-Source: APBJJlFNHTYQWRHtROnOOty5+ELFvyo8/ZudrjTKHz8SF9FuZHky+aDb2X3o5VvOCjMOU5wiKluKFg==
X-Received: by 2002:a17:906:7a5e:b0:992:b8b6:6bcd with SMTP id i30-20020a1709067a5e00b00992b8b66bcdmr979075ejo.16.1688633894307;
        Thu, 06 Jul 2023 01:58:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id e9-20020a1709067e0900b0099236e3f270sm542442ejr.58.2023.07.06.01.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 01:58:13 -0700 (PDT)
Message-ID: <464fdef5-f43c-a7b2-66d2-bf558a6ee2c7@linaro.org>
Date:   Thu, 6 Jul 2023 10:58:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2,1/2] dt-bindings: display: mediatek: dp: Add compatible
 for MediaTek MT8188
Content-Language: en-US
To:     Shuijing Li <shuijing.li@mediatek.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, jitao.shi@mediatek.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230706021425.31735-1-shuijing.li@mediatek.com>
 <20230706021425.31735-2-shuijing.li@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230706021425.31735-2-shuijing.li@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2023 04:14, Shuijing Li wrote:
> Add dt-binding documentation of dp-tx for MediaTek MT8188 SoC.
> 
> Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
> Changes in v2:
> add a mediatek,mt8188-edp-tx compatible per suggestion from the previous thread:
> https://lore.kernel.org/lkml/c4a4a900-c80d-b110-f10e-7fa2dae8b7b5@collabora.com/
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

