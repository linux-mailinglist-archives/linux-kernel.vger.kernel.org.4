Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3244F5B86F0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 13:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiINLDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiINLDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:03:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2BD3AE7D;
        Wed, 14 Sep 2022 04:03:37 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 923B3660201C;
        Wed, 14 Sep 2022 12:03:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663153416;
        bh=+Kc1BTT+7JR7Q+bC90Z/3uuTzcHyB9pkIgoBxNhmiu4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=N6O6LPhipnVjR2hh/zZWKYkmyGNGkuXp5l0vo0pB4OkNjt2PcguMhAjSTzYag8LDd
         zmzBnk5vdQ0V7FplA3myBJmalejHMuPTCT9FN5OtPyDTpPk7ZLt2W/VR7PvccCeXCB
         FcTiGcpJfmBJRupnyxzaJIh/uP93zh+oeel3kmYpcTUZDpU3bUY6GLtyLMjaOzDHvY
         Qtbyu4NhFIWvmJwfWJRzNdMmW48eBEykqGQVyOs0DtC+MIKIfVFn4vo9bU8/oqI6UI
         InmhwT+tZrEd5DG8650i21+i6CZe2ijeBhG89DA6GPA81kppd64vnu/uL/qYV9SmDB
         Yiqmyms4mDk0w==
Message-ID: <aa144d4e-dd9f-2ead-9ab5-e519dfab7709@collabora.com>
Date:   Wed, 14 Sep 2022 13:03:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] dt-bindings: mfd: mt6370: fix the indentation in the
 example
Content-Language: en-US
To:     cy_huang <u0084500@gmail.com>, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
Cc:     cy_huang@richtek.com, chiaen_wu@richtek.com,
        alice_chen@richtek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1663143803-28660-1-git-send-email-u0084500@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1663143803-28660-1-git-send-email-u0084500@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/09/22 10:23, cy_huang ha scritto:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Fix the indentation in the binding example. There're two redudant space
> charactors need to be removed.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>

This commit needs a Fixes tag, please add it:

Fixes: 76f52f815f1a ("dt-bindings: mfd: Add MediaTek MT6370")

Regards,
Angelo

> ---
>   Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
> index 410e2d4..250484d 100644
> --- a/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
> @@ -119,7 +119,7 @@ examples:
>         #address-cells = <1>;
>         #size-cells = <0>;
>   
> -        pmic@34 {
> +      pmic@34 {
>           compatible = "mediatek,mt6370";
>           reg = <0x34>;
>           wakeup-source;
> 


