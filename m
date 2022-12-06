Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA26644BCC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiLFSd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiLFSdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:33:33 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88537D138;
        Tue,  6 Dec 2022 10:30:50 -0800 (PST)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C7D386602B2C;
        Tue,  6 Dec 2022 18:30:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670351447;
        bh=w/xHJDdu02/REEs8caf9Uw8W1mhWaHk5rVGr0//60Zo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ep06ChAedJWVSn2zpjJ0IJMFrhCxHQYnRhZFEkmeTFqrRAw3vRUPqqjd4Ab2ZMgiT
         cw+GZNqNoheTh69hmJGerSj1l6Yy3CIeKIXeo/KbJJ9TlRl7xymnlQ0sqzyieJ01Yw
         By+P3TeIGGTHk9uTRAH+1nSixfbBRgv0nMYILrpt2hAz65HSrMogG0pDUDRvfpkRW0
         wiTZ9qRVOsGt0MlWjPh/T9ROZTJ/11x1/QO4MdHymwGDDbILzkT3akgnjgmNFxjr5f
         q7nZtYwkNNhLUmmApe6pCwPyPgOsLB8cD5jd3Ve9AOJTO93QSlNAPEc6nbJ3WpdCuS
         4QpDjWhec/GHA==
Date:   Tue, 6 Dec 2022 15:30:37 -0300
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, wenst@chromium.org,
        miles.chen@mediatek.com, rex-bc.chen@mediatek.com,
        chun-jie.chen@mediatek.com, jose.exposito89@gmail.com,
        drinkcat@chromium.org, weiyi.lu@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v3 01/10] arm64: dts: mt8183: Fix Mali GPU clock
Message-ID: <20221206183037.3jnssar4yxcx5hpb@notapiano>
References: <20220927101128.44758-1-angelogioacchino.delregno@collabora.com>
 <20220927101128.44758-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220927101128.44758-2-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 12:11:19PM +0200, AngeloGioacchino Del Regno wrote:
> From: Chen-Yu Tsai <wenst@chromium.org>
> 
> The actual clock feeding into the Mali GPU on the MT8183 is from the
> clock gate in the MFGCFG block, not CLK_TOP_MFGPLL_CK from the TOPCKGEN
> block, which itself is simply a pass-through placeholder for the MFGPLL
> in the APMIXEDSYS block.
> 
> Fix the hardware description with the correct clock reference.
> 
> Fixes: a8168cebf1bc ("arm64: dts: mt8183: Add node for the Mali GPU")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Hi,

it seems that while all other patches on this series were applied by Chen-Yu
through the clk tree, this commit never made it to the mediatek tree.

As a result, MT8183-based machines (or at least mt8183-kukui-jacuzzi, where I
tested on) currently hang during boot not only on next, but also on mainline,
v6.1-rc8. With this commit applied I've confirmed that the machine boots fine
again.

Matthias, could you please apply this commit and make sure it makes its way to
v6.1? Given the Fixes tag it should eventually make its way there anyway, but if
still possible would be good to have it fixed right from v6.1.

Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index a70b669c49ba..402136bfd535 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -1678,7 +1678,7 @@ gpu: gpu@13040000 {
>  				<GIC_SPI 278 IRQ_TYPE_LEVEL_LOW>;
>  			interrupt-names = "job", "mmu", "gpu";
>  
> -			clocks = <&topckgen CLK_TOP_MFGPLL_CK>;
> +			clocks = <&mfgcfg CLK_MFG_BG3D>;
>  
>  			power-domains =
>  				<&spm MT8183_POWER_DOMAIN_MFG_CORE0>,
> -- 
> 2.37.2
> 
> 
> 
