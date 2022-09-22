Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4B65E62CC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 14:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbiIVMvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 08:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiIVMvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:51:19 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559BFE7C03
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:51:16 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id c7so10832098ljm.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=AcReqp2gEJDplwIiqlXdRZl1+dQuLiAN6jLoyy64CrI=;
        b=vniiXCPYi2uHVswmxrHaLfifuGnTgh31cEiXXDrVozUBpdvgG1p2hAl0Iuww/tOgJC
         51g7fQ3iDc/taoVV7V4GHA31OjtWbcgJMDX+hUwoS5rCcH8Dl+8Stfx1M/7mE1+2Bd5A
         FS/3RYRQ2KRYMI6qPadyS/zKUJ0TBby48SUTUC1KBsX5KZbvKo+hEWmsvOh2eFQKBdcC
         lOXsuuZFZ01TsN9IObctd00VrMglSMuCMpC2mBh7+57odvkGvsZJc7Hl12+6BMPhz4h0
         VlXKpbLhfEODyJm8qT4XpB00JjoItgQhb2I/QFcMCOxYSwJH/kgC8yWpEJ4swhQZGhR5
         5V7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=AcReqp2gEJDplwIiqlXdRZl1+dQuLiAN6jLoyy64CrI=;
        b=gt6NwcYXVyZdvFQimSZidxh9tw8qTfD8XZ0wBQowlWuAQUU5AGTYXnEldGNvIprI6D
         IPmtHWyq5Sui3+TxLNUfNVcUsnpAYH3Pw9Su8Ei27qO5z2Pq8LV/TqhJ+9+zWpbdXmr5
         NImUErXVEhJISUslhsQefRMtKAjnGFVzPBneY/6Yo3PImJkPQLKYL7x1x2/oPf0Cb7Ql
         KnjSd4AS60IsFNhm49/qeMWjPfzAa0zE9sahx9SOcE+3h8Bvb9I9UiIVXUhQvb6xnvNg
         CCqQKfIFRwaAQj8qC44BGapMSsqopGx+amuKH/VWejYri2CCtIKswgnKqmP/c3Q1fE0q
         UG5w==
X-Gm-Message-State: ACrzQf2wR1XB9QzuTHAMCeflcQCVBo7oBD0WRneAqOnkqbcbdi5wJ69q
        14pwrvf6+gLA7BxX78dma1fM1w==
X-Google-Smtp-Source: AMsMyM6zFmrBuzTnD7uKlfv9Cfe4AuqBZFpoTZEtb1B6RSpxjj2qH9pnzETt4sbwd+x+Txnu7oQFsg==
X-Received: by 2002:a2e:bf0c:0:b0:260:3df:1bce with SMTP id c12-20020a2ebf0c000000b0026003df1bcemr1096075ljr.117.1663851074490;
        Thu, 22 Sep 2022 05:51:14 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k20-20020a2eb754000000b0026c64fd8f0csm845872ljo.71.2022.09.22.05.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 05:51:14 -0700 (PDT)
Message-ID: <98e33290-b571-221a-75cd-386ab39a4819@linaro.org>
Date:   Thu, 22 Sep 2022 14:51:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v1 01/17] dt-bindings: clk: mediatek: Add MT8195 DPI
 clocks
Content-Language: en-US
To:     Guillaume Ranquet <granquet@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Pablo Sun <pablo.sun@mediatek.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org
References: <20220919-v1-0-4844816c9808@baylibre.com>
 <20220919-v1-1-4844816c9808@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220919-v1-1-4844816c9808@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2022 18:55, Guillaume Ranquet wrote:
> From: Pablo Sun <pablo.sun@mediatek.com>
> 
> Expand dt-bindings slot for VDOSYS1 of MT8195.
> This clock is required by the DPI1 hardware
> and is a downstream of the HDMI pixel clock.
> 
> Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

