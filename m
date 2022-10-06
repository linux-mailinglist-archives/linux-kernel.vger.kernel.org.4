Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4C95F6333
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiJFJBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiJFJBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:01:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AAD1E3D3;
        Thu,  6 Oct 2022 02:01:33 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C057C66022F7;
        Thu,  6 Oct 2022 10:01:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665046892;
        bh=i/0O2Tekm5frb37+MxpZ8Gl9JZEhrRma2Kk+CGxptVo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Dmlcwi/r8AkCp6UYoeDpwl/7824D2HjeMqCz6rg3o346OQvzo75Lb/zQ2P+vDI3xV
         sc6RX02eX6aEIBUTptcCW+SLbS0WQNUL7X0W7SnyzLoEXGfnRvkbyDkUEzGjS7d+bo
         TSJhrHHcCrlxrZPLN1bpH/tE2chkpYRY7DRfCtxKGmqrfoL2XNQoXkoLxwSlE6splg
         ZlZ4NwpA5GRgLBfdaOtWBTXgeBKZzpC1SK8yz87b/0X7vN8weGPwT4yqv0K8US8uZN
         uiXxUb+OELJcQ63EAAM+EiGhn8Sro2PpsZrtSQ+QAFX/eG++qngsxGnU+y4liBPh0X
         OgHyqXz1lFUuQ==
Message-ID: <17e4cfb0-e423-9cf8-8af1-588aed4481a5@collabora.com>
Date:   Thu, 6 Oct 2022 11:01:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 05/10] dt-bindings: pinctrl: mediatek,pinctrl-mt6795:
 Fix interrupt count
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221005174343.24240-1-y.oudjana@protonmail.com>
 <20221005174343.24240-6-y.oudjana@protonmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221005174343.24240-6-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/10/22 19:43, Yassine Oudjana ha scritto:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> The document currently states a maximum of 1 interrupt, but the DT
> has 2 specified causing a dtbs_check error. Change the limit to 2
> to pass the check and add a minimum limit.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>   .../devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml   | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
> index 73ae6e11410b..483fcdc60487 100644
> --- a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
> @@ -47,7 +47,8 @@ properties:
>   
>     interrupts:
>       description: The interrupt outputs to sysirq.
> -    maxItems: 1
> +    minItems: 2
> +    maxItems: 2
>   
>   # PIN CONFIGURATION NODES
>   patternProperties:

Nice catch.
The right thing to do is...

   interrupts:
     description: The interrupt outputs to sysirq.
     minItems: 1
       - description: EINT interrupt
       - description: EINT event_b interrupt

Cheers,
Angelo
