Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEC86A3C2C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 09:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjB0IRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 03:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjB0IR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 03:17:29 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693D01C5B6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:17:28 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r18so5248779wrx.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SXjvdSe0Xoy2F99alaan33seTEDoFO78h4PoWaqWgOY=;
        b=Lz4+9beKVbWGlNZ6JCP58x/xj/5GDQnJ5jCtQqyk+1Udl9BuMfMaqAUXJVrX2gGAWA
         H22mr9hUSs6gxP/dkX1KUIEXR3e6LG214vFsWVbuboi5zufMdpFYmshF4cwGF2NV4H0z
         qvRYWIvNKBbfobB6eeUdLDOkT0LAjGmu4KvfNxDHTvEse8d28/WUysicQIdl0aApCADF
         7J5mfxUFaThBrPciFhRLWq5t5tVGNN5vOglz34rOh4yJx5jBo9GxMZZyWytU9fihJRsn
         kOaZr0OIMAaAjnSkR9viY0q+ix5LePgu5IImhO7Rk0mYSW/eBZNbsSAZBts88SH9xCWR
         xHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SXjvdSe0Xoy2F99alaan33seTEDoFO78h4PoWaqWgOY=;
        b=Jn6WUFUuUd/01lqqeAasDhpH7lcDbcjMsFJAumh+fEXpwrOhHwssXjZNTKBPdNd+l6
         gBcFkkmCSlU4VEH9YqHvWDeT5Xx3zLrrPbUBFLYOAObKNEuGLn0/Kax9wx5+0YtAdRuq
         cmMc571WNOGrz0QsEh42FvR3aP+Pn2eqblL9ZctH0vEoPG8RslogWQvKvZbYT7J1W7kJ
         tOEAGcyFiYiNm5noXkHsfwhbCN+XRhA3e0EIetEhEXv6t8mtEv21wwBrGpucDY2mMxeM
         7UZiZHx0w6tpJ5C6P+WsuMqc7MEcEZnPWLpAwQ/fNetgwpN2mZn5yYhJMY1KqpDq517X
         MMEQ==
X-Gm-Message-State: AO0yUKWCyngt8n5fRhi7USwWVUTpLhxikABfbNfxOcWEcg2Vfx/8BOqh
        5JjsgsiiuS/WY8buNDv5D7n5Lw==
X-Google-Smtp-Source: AK7set+LGhJeW/YV/Plyh6BkEVwsi5ztKVwgCyYUJRw0gktnM8wdTkBmFtmQU+S6gcfBUUuXp8EDLg==
X-Received: by 2002:a5d:58ea:0:b0:2c7:d56:7d72 with SMTP id f10-20020a5d58ea000000b002c70d567d72mr13130426wrd.19.1677485846867;
        Mon, 27 Feb 2023 00:17:26 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c4-20020adffb04000000b002c70bfe505esm6324326wrr.82.2023.02.27.00.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 00:17:26 -0800 (PST)
Message-ID: <481a732d-8867-b811-e96c-caf43d08e9f9@linaro.org>
Date:   Mon, 27 Feb 2023 09:17:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/4] dt-bindings: reset: Add MediaTek MT6735 reset
 bindings
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Daniel Golle <daniel@makrotopia.org>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
References: <20230225094246.261697-1-y.oudjana@protonmail.com>
 <20230225094246.261697-3-y.oudjana@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230225094246.261697-3-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/2023 10:42, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add reset definitions for the main reset controllers of MT6735 (infracfg
> and pericfg).
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  MAINTAINERS                                   |  4 ++-
>  .../reset/mediatek,mt6735-infracfg.h          | 31 +++++++++++++++++++
>  .../reset/mediatek,mt6735-pericfg.h           | 31 +++++++++++++++++++
>  3 files changed, 65 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/reset/mediatek,mt6735-infracfg.h
>  create mode 100644 include/dt-bindings/reset/mediatek,mt6735-pericfg.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5323f71c48fb..f617042790ee 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13101,7 +13101,7 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>  F:	drivers/mmc/host/mtk-sd.c
>  
> -MEDIATEK MT6735 CLOCK DRIVERS
> +MEDIATEK MT6735 CLOCK & RESET DRIVERS

You just added this line in previous patch. Don't add code which
immediately you fix.



Best regards,
Krzysztof

