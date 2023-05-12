Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA936700735
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240793AbjELLv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240096AbjELLvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:51:55 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3961044A9;
        Fri, 12 May 2023 04:51:54 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f49bf0223cso30660565e9.1;
        Fri, 12 May 2023 04:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683892312; x=1686484312;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QQHkMWe3qdYU/HmvSBq3YXaycptjgX2aKr/mlQr6WCk=;
        b=Pz0MdPIS8jASWVo90JrB5T/DQ/znfNThW0Bq9CdlI3Gs3RSAhLGRAH4BCFpQFL56bB
         DAe7RLXjAXOEmSjBL2RXfPTvK+GRb8g0S6+5R+SGLkLSj6aDuQL6+F0sKekVnhu0uv6n
         D9iF876dTor6FGYH7KbQDArWwdvawNDjgQeqtLkqyIuAqch2j+thy7hrH4SLzr66N3z/
         Vn3f98GQwPlGUBiEw6u97/kBBqtG7zKGVZoLma4yNLQG/Vypw5nl2hhQOqg1Ab12uiqk
         6+XChRU1ooE2dgXk/gW+TuWZc75nIkI1oSbxmqZhOIqLIKFNZ0zw0YOdpX0BNWXCqxpC
         ZeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683892312; x=1686484312;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QQHkMWe3qdYU/HmvSBq3YXaycptjgX2aKr/mlQr6WCk=;
        b=OcGiL83F520up7wpQsYrVFBHSiUoMLVjEHbRKkpN5W+pTDvqHZUIKahzUZL4er8e2V
         KEF3rZwVv+mVtc36tXxwYTmfk7nm2g6Fb7HZeAVQfFR3KdYnUrKALSqb2mqYFSDia14g
         4auxh+OLhONe1Eo4CrWNLWkW0Noqa3aJiywVLXPMPAMeW1XdPuZu8Y1sE0zYysH/YeyJ
         1Etr4KV8CSRgnUtxpZCMH494dLG8+5vs+6ltwaePy45gXE7m/D1udtH90YzD7pkMk2iQ
         nBxxHiYHghHNW9rWXswjTNalcofj8Ekcex9wDTlJwuSkdVqd5aDmZg19L/JzqrGt+hU4
         5law==
X-Gm-Message-State: AC+VfDyEs+Cyl3Bg5UWi1oltVYHhpkJQP6vvo0O5j9XggSb24czL/buS
        oaAa+iTHaezkQG5ju0QDgjY=
X-Google-Smtp-Source: ACHHUZ6v+ZT8Ft6DgwrE5EvkMuX5vTworuHq1/zgwezLGbuuvX17AEYqdQTqyi79LLu/cP3wGp/E3Q==
X-Received: by 2002:a7b:cbda:0:b0:3f4:2415:617c with SMTP id n26-20020a7bcbda000000b003f42415617cmr12020968wmi.6.1683892312291;
        Fri, 12 May 2023 04:51:52 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id a22-20020a1cf016000000b003f42d8dd7ffsm9013841wmb.19.2023.05.12.04.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 04:51:51 -0700 (PDT)
Message-ID: <8603c2b2-2a5b-48f6-9b08-9b3b518b716b@gmail.com>
Date:   Fri, 12 May 2023 13:51:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] clk: mediatek: mt8365: Fix inverted topclk operations
Content-Language: en-US, ca-ES, es-ES
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>
References: <20230511133226.913600-1-msp@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230511133226.913600-1-msp@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/05/2023 15:32, Markus Schneider-Pargmann wrote:
> The given operations are inverted for the wrong registers which makes
> multiple of the mt8365 hardware units unusable. In my setup at least usb
> did not work.
> 
> Fixed by swapping the operations with the inverted ones.
> 
> Reported-by: Alexandre Mergnat <amergnat@baylibre.com>
> Fixes: 905b7430d3cc ("clk: mediatek: mt8365: Convert simple_gate to mtk_gate clocks")
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/clk/mediatek/clk-mt8365.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
> index 6b4e193f648d..6d785ec5754d 100644
> --- a/drivers/clk/mediatek/clk-mt8365.c
> +++ b/drivers/clk/mediatek/clk-mt8365.c
> @@ -583,15 +583,15 @@ static const struct mtk_gate_regs top2_cg_regs = {
>   
>   #define GATE_TOP0(_id, _name, _parent, _shift)			\
>   	GATE_MTK(_id, _name, _parent, &top0_cg_regs,		\
> -		 _shift, &mtk_clk_gate_ops_no_setclr_inv)
> +		 _shift, &mtk_clk_gate_ops_no_setclr)
>   
>   #define GATE_TOP1(_id, _name, _parent, _shift)			\
>   	GATE_MTK(_id, _name, _parent, &top1_cg_regs,		\
> -		 _shift, &mtk_clk_gate_ops_no_setclr)
> +		 _shift, &mtk_clk_gate_ops_no_setclr_inv)
>   
>   #define GATE_TOP2(_id, _name, _parent, _shift)			\
>   	GATE_MTK(_id, _name, _parent, &top2_cg_regs,		\
> -		 _shift, &mtk_clk_gate_ops_no_setclr)
> +		 _shift, &mtk_clk_gate_ops_no_setclr_inv)
>   
>   static const struct mtk_gate top_clk_gates[] = {
>   	GATE_TOP0(CLK_TOP_CONN_32K, "conn_32k", "clk32k", 10),
