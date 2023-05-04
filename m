Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AA76F6284
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 02:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjEDAxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 20:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEDAxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 20:53:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FD1118;
        Wed,  3 May 2023 17:53:11 -0700 (PDT)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CE49B66029DE;
        Thu,  4 May 2023 01:53:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683161590;
        bh=Pf9aKXYua5q4lihd+sJeC03bnAklA25fE7ZxJ5TN248=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GKd0Wre/cMxtHs+HjhiiB6yPf21bBk1C4udeK7iSLm2yVHoyspMQ+gVsd7Odb7fOo
         QlfUH86jJ8faThvsiDFlg2e7kmQZ7S0dDx1lkECpZrJiU86XB0feoipLtNRVeeuWpE
         5/X88U7TvQa6FC79cVAUWqnYELHu2NTmC2ai2Be610aJRiITK2b5b+vWLeC15y1ixA
         yqBgOOdkQ1w/SrJDffBYxsfPF+Akmi2b8Ciji9UJXYrk6GNSWPTaP46VLTSfm4asHL
         m/5r1sa3Mx07tLSY0SLgDPddX9lV07b39i6ieZOo3VSxYkyeMmorH0Bsr6NmFvFLzF
         HrqBUUhRpEUUQ==
Date:   Wed, 3 May 2023 20:53:03 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     bchihi@baylibre.com
Cc:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com,
        amergnat@baylibre.com, khilman@baylibre.com
Subject: Re: [PATCH v2 4/5] arm64: dts: mediatek: mt8192: Add thermal nodes
 and thermal zones
Message-ID: <96157fae-2024-4a8d-9ceb-b0d95ee419d4@notapiano>
References: <20230425133052.199767-1-bchihi@baylibre.com>
 <20230425133052.199767-5-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230425133052.199767-5-bchihi@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 03:30:51PM +0200, bchihi@baylibre.com wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add thermal nodes and thermal zones for the mt8192.
> The mt8192 SoC has several hotspots around the CPUs.
> Specify the targeted temperature threshold to apply the mitigation
> and define the associated cooling devices.
> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 454 +++++++++++++++++++++++
>  1 file changed, 454 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 87b91c8feaf96..eb2bd94e0ae86 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
[..]
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu0_alert>;
> +					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								<&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								<&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								<&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;

Just a nit, but it would be nice to have these aligned (same for others below).

In any case,

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
