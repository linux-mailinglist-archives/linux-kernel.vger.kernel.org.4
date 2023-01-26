Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CDE67D042
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjAZPcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjAZPcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:32:12 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BC613D48
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:32:11 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h12so2138909wrv.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jz1yQJDh82hmVQElGHGWfr/ouKY/iJoAmFgYkVIjURw=;
        b=CWVyglyvdNmFmSjrgGGDhJJYrYauQdQgibOI4/kl+7D0kO8kyPjUmNAkXIfPCdC7Vj
         V80wClnbqrY2beIlkLJ1Vh9QH7V37IgvU0gt34DovVqXLzqm4T6tHoonZs99RCm84zFI
         iJdqw2n16VUyp0dg4ssV6te4UhHXJ5ba4uFJWsAdmziiP5xQ1zhefta8prLOgdyXE8SV
         B7IDYFUur1cKxGe942GwHb0s7sLwII/KYl30pKzd+mNGATpMktX8GNdsCmpFugYegLmt
         asYOdz3+UCsQ4UioAbl3B8S37n3ErYOHlrK7a1QmY0HUEicJiFBWxVYOfoZoylh+ytre
         CMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jz1yQJDh82hmVQElGHGWfr/ouKY/iJoAmFgYkVIjURw=;
        b=09zXiVWM2s5qP9tC35aCMFVGfsiqbXA5QuAYJ9AJJlxc2mBsCgmAzB72PZrWmsI2hH
         rvEWlNGFMZMb8iAzPAwvkXr7fAM41ptTNJDhi6SiasDgBxqlDtvvSLTFCelornDQ9vx1
         hB1uglSxI8xw1AFUAKYxVlmyp2DKJp+nAorfOiChZ9Z1z9xVG/Wtpm/xnYUO1rqY0tx6
         U//6DpucjYlMLSN8ghYZxwyB8xBP9b0hg4aXX7behVusPZgkk3Yl9kbvORe+hTV7+w25
         XzXYRYGcRvWey3bM9DXB3Lz78GCUnKsNaSVjj/KB5IDPNJBYqqMlj8QUz/L1u9Pj3s2E
         n89w==
X-Gm-Message-State: AFqh2kqSPB4Dyyyr5TUo+hEesBWPf83AhuDmyOv45QzopJGwUEXjALcf
        CIRvCVL5HuCmTiprFuaxk6hWIQ==
X-Google-Smtp-Source: AMrXdXvbHP4MU8LW1+p6+/QnuhuohmSQZLuwW60JkdlaAcbwU5Y7GEyF4W4xaywzdk2WMdog6QND6Q==
X-Received: by 2002:a05:6000:1e18:b0:2bd:d782:c2c1 with SMTP id bj24-20020a0560001e1800b002bdd782c2c1mr35767974wrb.24.1674747129636;
        Thu, 26 Jan 2023 07:32:09 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n15-20020a5d598f000000b002bdff778d87sm1865447wri.34.2023.01.26.07.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 07:32:09 -0800 (PST)
Message-ID: <67279d92-7a46-8a55-34d1-03d10369d8f5@linaro.org>
Date:   Thu, 26 Jan 2023 16:32:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 2/6] dt-bindings: clock: mediatek,mt8186-fhctl: Support
 MT6795, MT8173/92/95
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, sboyd@kernel.org
Cc:     mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        edward-jw.yang@mediatek.com, johnson.wang@mediatek.com,
        wenst@chromium.org, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, rex-bc.chen@mediatek.com,
        jose.exposito89@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230126085321.87267-1-angelogioacchino.delregno@collabora.com>
 <20230126085321.87267-3-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230126085321.87267-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2023 09:53, AngeloGioacchino Del Regno wrote:
> MT6795, MT8173, MT8192 and MT8195 support Frequency Hopping: add the
> compatibles for them.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

