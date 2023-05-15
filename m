Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B539702B80
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241181AbjEOL3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238998AbjEOL3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:29:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07043F1;
        Mon, 15 May 2023 04:29:34 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3FEC866031D7;
        Mon, 15 May 2023 12:29:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684150173;
        bh=LalSUny/QCaFULSY0Y9gSNVhlJDeYPhrQGuFROWyytw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KpKmsN5/9J1wHY56LlCOFpCD6W3pBeBcdtaRkSb9eI40rreAuKsiJ7tbFXfrxRJUI
         hQMDZaKki177BFrFuCu88KKfHZHTe70Ef/AqqGDw/18eHlpes2ouOx1TmrFxoHN6eB
         NLL6ceySSM01MGsPrpR4iFJThyppcY1rLJmZSPa8/AvXu3GKSIKlkn5iPfBmIYn6R9
         DsI0IdM6go9YBf8XhbWr4L1rSkeVPMAHvOJjpbFMOr8b1QjvnYvxKbKY4QRrUUcSZl
         8Wn+k9Nrs0KrmZItbJ52hS7gFZLD2g2AJ/ceM1clu9XmOmed2nQj6RwGZBBS4K9R20
         sRiPG+/cHtXOg==
Message-ID: <df8571eb-fba9-0ba7-88d0-1a74114bd73f@collabora.com>
Date:   Mon, 15 May 2023 13:29:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/6] arm64: dts: mediatek: mt8183: Add
 mediatek,gicr-save-quirk
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        wenst@chromium.org, Eddie Huang <eddie.huang@mediatek.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Tinghan Shen <tinghan.shen@mediatek.com>, jwerner@chromium.org,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        yidilin@chromium.org, Seiya Wang <seiya.wang@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20230511150539.6.Ia0b6ebbaa351e3cd67e201355b9ae67783c7d718@changeid>
 <20230511150539.3.I525a2ed4260046d43c885ee1275e91707743df1c@changeid>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230511150539.3.I525a2ed4260046d43c885ee1275e91707743df1c@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/05/23 00:05, Douglas Anderson ha scritto:
> Firmware shipped on mt8183 Chromebooks is affected by the GICR
> save/restore issue as described by the patch ("dt-bindings:
> interrupt-controller: arm,gic-v3: Add quirk for Mediatek SoCs w/
> broken FW"). Add the quirk property.
> 
> Fixes: e526c9bc11f8 ("arm64: dts: Add Mediatek SoC MT8183 and evaluation board dts and Makefile")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 5169779d01df..39545172fce5 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -709,6 +709,7 @@ gic: interrupt-controller@c000000 {
>   			      <0 0x0c400000 0 0x2000>,   /* GICC */
>   			      <0 0x0c410000 0 0x1000>,   /* GICH */
>   			      <0 0x0c420000 0 0x2000>;   /* GICV */
> +			mediatek,gicr-save-quirk;

Nit: Can you please move this after interrupts?

Thanks,
Angelo

>   
>   			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
>   			ppi-partitions {


