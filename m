Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC8D5BC42B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiISITp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiISITh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:19:37 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2AE2700
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:19:35 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x27so12467163lfu.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=cGOksTlx7HPSEJ3tGiKUBW8haHMuXJVe8E31nOF/Xns=;
        b=u9l2LNU0CtHKm3nLxR0sboWaatfqLlHDDYdD0KtG6vgT7rByAJBdDqLIW8xoizWSpI
         JGuIrGSoS+YC8NMafiKedkZhmmi6H/JQYvKgLkyUK/5eayLL6wwCI6JxE9atMQsxVTgs
         bJeBcOaTgwbYtcLzCjy/WdyZxxlMpidrQ35dwPmsE86vsSzlOw5dM7Fc5Q/ZOPz5Fppr
         eGU+rUIJV0ltdyeqopkPtnju4ZyfTrJyvglKK8OnEs9lZOiVZhn9lYqC7UpKFozAe3xL
         IETBbJCmkOd3KzcDUzrmzPfsKEoDZl4iu8gJKe/VB+Bsn87Knwfwnhm5R6FBhOWalmfl
         EILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=cGOksTlx7HPSEJ3tGiKUBW8haHMuXJVe8E31nOF/Xns=;
        b=Ptqy2Fu4UbvQ8OOz5bYb1pFqGbq3ZY9qR3zilJvLkOZ9M4EAalzYDmPyx+uqS2Aikn
         Eo375sK7C8g/Hiuiz8VcOnRLPceiJcqU6z3ml8CVSM3q8g/FiVrAbBVX28PhV4JD8O8t
         Tw0Ktn8VoU6rNbCQSi0y4oszA0bRORDziSjGs6EZH79Uln+7wPebBh8L11mifM17HVPq
         R3Q/7B0SGU8/tJeZ8+JZSSWUbx4MDBucId74pqOowhN034zvjai7ez8HCHxuF5jNfYqq
         PBxEBAF8yjxuJtxLA/STlEHC/OZfULZQOFNL3LBGXTw+poechqrycmm5dkXYDBZrdd4l
         9MzA==
X-Gm-Message-State: ACrzQf1LJS9DiGBh+PtutuLUJvakwGgD5j7KUGoETJ1U5SRARXWMc/co
        Fj3ImTyH3NUf1mzo2IMaRyfhtA==
X-Google-Smtp-Source: AMsMyM4bsPPOk94vI7dWhP43voq8RX38StuUfrTlgpjKh06SgkNvXLTG2zWq+zZzzqFCbHg8+VZQtQ==
X-Received: by 2002:a05:6512:3d9f:b0:497:a108:544f with SMTP id k31-20020a0565123d9f00b00497a108544fmr5478197lfv.688.1663575573570;
        Mon, 19 Sep 2022 01:19:33 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id j20-20020a056512345400b00493014c3d7csm5059793lfr.309.2022.09.19.01.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 01:19:33 -0700 (PDT)
Message-ID: <d28ce676-ed6e-98da-9761-ed46f2fa4a95@linaro.org>
Date:   Mon, 19 Sep 2022 10:19:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/2] stmmac: dwmac-mediatek: add support for mt8188
Content-Language: en-US
To:     Jianguo Zhang <jianguo.zhang@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Biao Huang <biao.huang@mediatek.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220919080410.11270-1-jianguo.zhang@mediatek.com>
 <20220919080410.11270-2-jianguo.zhang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220919080410.11270-2-jianguo.zhang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2022 10:04, Jianguo Zhang wrote:
> Add ethernet support for MediaTek SoCs from mt8188 family.
> As mt8188 and mt8195 have same ethernet design, so private data
> "mt8195_gmac_variant" can be reused for mt8188.
> 
> Signed-off-by: Jianguo Zhang <jianguo.zhang@mediatek.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> index d42e1afb6521..f45be440b6d0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> @@ -720,6 +720,8 @@ static const struct of_device_id mediatek_dwmac_match[] = {
>  	  .data = &mt2712_gmac_variant },
>  	{ .compatible = "mediatek,mt8195-gmac",
>  	  .data = &mt8195_gmac_variant },
> +	{ .compatible = "mediatek,mt8188-gmac",
> +	  .data = &mt8195_gmac_variant },

It's the same. No need for new entry.


Best regards,
Krzysztof
