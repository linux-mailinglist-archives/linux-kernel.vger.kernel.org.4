Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A2671223A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 10:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242708AbjEZIa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 04:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242682AbjEZIaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 04:30:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003E613A;
        Fri, 26 May 2023 01:30:19 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8F4076606E83;
        Fri, 26 May 2023 09:30:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685089818;
        bh=gg3PXZMm/8qSIeSloKT4Q2tmhI1GwPnD9NTPJMDIL0Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ul4aYUWqkAaDION+dPRYmOTTBp5YFpvXXgyq8i27Rc6zJGXSjE8nTF3T6QlgArrv5
         XAmtQM35alw/+N0CB2yodcSSG0SFqvv2nfFLB1AqaHUvdUJxSzHiM2cgnnxOLgq/Ol
         hNa1bz9lMwy7CkGX4pjdaQhbmcUAz3D2vpV9usC2GKWRgR11ZV/cUtttBohJdbpTRM
         1uAHsEa9ivaVeBvNnDYLpN9xdeFrDX6+ZinR8aAsXSOSxbmPp3KCWFidy1qdgkj1RY
         sCG9BDkziPRXRGbl1RJb+V+a4kyy6xo0ftJoU9UcxiclAXHpGu/gYLozjGKoHBLgAp
         iEpcqklNY/k1g==
Message-ID: <f3f7df94-74f1-dd41-00d7-0ab4fa2e4d61@collabora.com>
Date:   Fri, 26 May 2023 10:30:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: mediatek: replace unusable
 clock
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230517-fix-clk-index-v2-0-1b686cefcb7e@baylibre.com>
 <20230517-fix-clk-index-v2-1-1b686cefcb7e@baylibre.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230517-fix-clk-index-v2-1-1b686cefcb7e@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/05/23 16:50, Alexandre Mergnat ha scritto:
> The “mcu_pm_bclk_ck_cg” clock is used by co-processors and should not be
> added to the kernel driver, otherwise the CPU just halt and the board is
> rebooted by the wathdog.
> 
> Instead, add the "aes_top0_bclk_ck_cg" missing clock to prevent
> re-shuffling index and then preserve the ABI.

It's still a breakage. Besides, have you tried to add it as CLK_IS_CRITICAL? :-)

Cheers,
Angelo

> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>   include/dt-bindings/clock/mediatek,mt8365-clk.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/clock/mediatek,mt8365-clk.h b/include/dt-bindings/clock/mediatek,mt8365-clk.h
> index f9aff1775810..0a841e7cc1c3 100644
> --- a/include/dt-bindings/clock/mediatek,mt8365-clk.h
> +++ b/include/dt-bindings/clock/mediatek,mt8365-clk.h
> @@ -199,7 +199,7 @@
>   #define CLK_IFR_PWRAP_TMR		46
>   #define CLK_IFR_PWRAP_SPI		47
>   #define CLK_IFR_PWRAP_SYS		48
> -#define CLK_IFR_MCU_PM_BK		49
> +#define CLK_IFR_AES_TOP0_BK		49
>   #define CLK_IFR_IRRX_26M		50
>   #define CLK_IFR_IRRX_32K		51
>   #define CLK_IFR_I2C0_AXI		52
> 

