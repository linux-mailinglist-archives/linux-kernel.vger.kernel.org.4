Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8515E5C3A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 09:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiIVHUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 03:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiIVHUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 03:20:25 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4B9AA3CF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 00:20:23 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id a10so9956311ljq.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 00:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=l75230f4/Tc4m+TS6iA4e2H4Q+VpG770+Je6OFiVsyM=;
        b=hQ/UL/kN7XbzEXqfO+tmv964OK2GMoUE38JlkbYLqDPJ3sX9aZ7YaBiMAegrLKbyFm
         0lZTvlLYhE4eq+ExfRYlG4w+IguonGImEXN1v7MA9wWCrKgtVqE6SlrQ5VX0NG5E9Y38
         /4BtzZAHXkNvDllPnvs5t7kQv4zT0w0CgLdr2XvTwVocykNzokmm0+yttQvK5fx3Huhi
         zNfdsrW1u+Dk3rWZfo4H2Ndvrr5eoKn1l2tfcmE+E+seNPLEYCzpsjlgaKMuf7tWEqls
         XHvG3Ou2t6CdsQ7XwS5mMARAd0yru57ioABcS+6+ct3Mv211ahTfWMz9T8lmsbob5+7B
         DFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=l75230f4/Tc4m+TS6iA4e2H4Q+VpG770+Je6OFiVsyM=;
        b=GR3CBSnAIXhVn/f3lps3iF5fHivxbrjkn+v2OeerlqP8f6U/52PnAGwtXFLxoZ6130
         s07XRt77cODUO6ZmHhLHUL2M3YBo3e9nZ2K8/CfEzWX81hq4mwZmZixpD5Rptrb6rVUY
         AJopZ+UZWG+9Xxbj/QEEaF34KiJZSAOPQNgLBMuvQGXylHiSXSEPDWjbvU/ndk+HhQGO
         VZv0CqQwtgcS7HEo4WpMA94c2c+Yv/9lCpjxspRCw9wJ0mB0Dxk5h3Cqrr5zzVIq3Vk3
         JGbmz4ciIUEwUR9d0YaaNrSFxDAmK18K9Q5KIWRhIYcHHXL5fK5RR7L9DcMg7NI91fpk
         oYSA==
X-Gm-Message-State: ACrzQf2uJ2uq5pSMTo3DOxfZxhh56Nfajj1LDvnrw8pWa9FlL1ti0pAA
        QUo1pGgBYIsOZbvoBUNvpgOKEg==
X-Google-Smtp-Source: AMsMyM5wVw1kKJjWwk0eAv9vC8nvZTseIqkjOoLB/YN16eVtCyQpO11pitWkmTSeOsIupJQ3U8Qndg==
X-Received: by 2002:a2e:9b17:0:b0:26c:4ede:512c with SMTP id u23-20020a2e9b17000000b0026c4ede512cmr577476lji.529.1663831221961;
        Thu, 22 Sep 2022 00:20:21 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a14-20020a195f4e000000b0048ae316caf0sm805348lfj.18.2022.09.22.00.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 00:20:21 -0700 (PDT)
Message-ID: <e993c25e-f334-e1ca-73f8-58cf141c521e@linaro.org>
Date:   Thu, 22 Sep 2022 09:20:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v1 15/17] dt-bindings: display: mediatek: dpi: Add
 compatible for MediaTek MT8195
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
 <20220919-v1-15-4844816c9808@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220919-v1-15-4844816c9808@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2022 18:56, Guillaume Ranquet wrote:
> Add dt-binding documentation of dpi for MediaTek MT8195 SoC.
> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> index 5bb23e97cf33..2c7ecef54986 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> @@ -24,6 +24,7 @@ properties:
>        - mediatek,mt8183-dpi
>        - mediatek,mt8186-dpi
>        - mediatek,mt8192-dpi
> +      - mediatek,mt8195-dpi
>        - mediatek,mt8195-dp-intf

Aren't these the same?

Best regards,
Krzysztof

