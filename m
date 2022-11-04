Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A304F619A21
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbiKDOfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiKDOeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:34:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86E1303F9;
        Fri,  4 Nov 2022 07:32:25 -0700 (PDT)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 27C756602966;
        Fri,  4 Nov 2022 14:32:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667572344;
        bh=E4RBBVSKwbPJ3/jKWf+eXG57O7vMDBSJ35AS7H0Ljbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jeuVh2DVCbj48QLsyqPk0UlTG4g5jUtsZVTT7fIxGVydicFOoGlOPyrS5gnFT0nPo
         LpBCTbhTj1LpaWTW2Ux4O65DBImV53rBsVD/RBwMtGWqx/0pzzklwZ7to9Cvpxj0Uu
         PtypyCcUSER01jNIkvI8TsEnwJ5N5YIQPZFQg8dc7WpWlx+lS0iqBS3t5GyVzTYLIF
         oa+sm0Mt8Up0nDQuGSQ76snc1jnKVRJZx4lX7We4Jb4eoptVOZbSR2j3o61DvZKSRR
         e6M6xmncOl+xB5XV3/Ffe2bpqO3Yr2glsnZoRJ9jepVw+jH1uxAZ/+J6t9F+C31U1W
         mG5rMI9OoRMGQ==
Date:   Fri, 4 Nov 2022 10:32:19 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v4 4/7] arm64: dts: mediatek: mt8516: Fix the watchdog
 node name
Message-ID: <20221104143219.aiwfezso7r72yg7q@notapiano>
References: <20221104020701.24134-1-allen-kh.cheng@mediatek.com>
 <20221104020701.24134-5-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221104020701.24134-5-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 10:06:58AM +0800, Allen-KH Cheng wrote:
> The proper name is 'watchdog', not 'toprgu'.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8516.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8516.dtsi b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> index d1b67c82d761..fff59dc1b4d7 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> @@ -202,7 +202,7 @@
>  			#clock-cells = <1>;
>  		};
>  
> -		toprgu: toprgu@10007000 {
> +		toprgu: watchdog@10007000 {

I think you missed my comment about renaming the label as well on the previous
version.

>  			compatible = "mediatek,mt8516-wdt",
>  				     "mediatek,mt6589-wdt";
>  			reg = <0 0x10007000 0 0x1000>;
> -- 
> 2.18.0
> 
