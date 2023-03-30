Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B196CF94F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 04:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjC3Cy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 22:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjC3CyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 22:54:24 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8CF1FCC;
        Wed, 29 Mar 2023 19:54:23 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32U2sCnT104686;
        Wed, 29 Mar 2023 21:54:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680144852;
        bh=snV3h5n+oQyY+JeaqgOmmoFe9uPNhIeij4jrLvhjrlk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=rm3+BOfjug/f4YKjI/oDHOHTVz0KMAXi2pGeg0PHX0Qt4+92ZpaL/f0UTTU+pWMkM
         KSuZMZkmce+MIgjGiTRgPslpjK+AABBweVIPKkJAIxRipbL/QyF89iwbATfXJP6QRT
         6bbi7y/kh+XGFyukcCo0La2PihDWdH3qp6nw+iNc=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32U2sCCZ009872
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Mar 2023 21:54:12 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 29
 Mar 2023 21:54:11 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 29 Mar 2023 21:54:11 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32U2sBce125113;
        Wed, 29 Mar 2023 21:54:11 -0500
Date:   Wed, 29 Mar 2023 21:54:11 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jai Luthra <j-luthra@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v9 1/6] arm64: defconfig: Enable audio drivers for TI K3
 SoCs
Message-ID: <20230330025411.aecwgll7mhstqzhr@quote>
References: <20230313-mcasp_upstream-v9-0-6d937efe4ec4@ti.com>
 <20230313-mcasp_upstream-v9-1-6d937efe4ec4@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230313-mcasp_upstream-v9-1-6d937efe4ec4@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

$subject: I think you meant to state TLV320AIC3106 is needed for AM62 SK
boards than K3 SoCs ;)

On 16:00-20230329, Jai Luthra wrote:
> TI's K3 platform uses McASP as the digital audio interface on the SoCs.
> AM62x and AM62A based starter kits also use the TLV320AIC3106 codec with
> a 3.5mm jack for analog audio input and output.
> 
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
> ---
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index ca3569261713..aa36792b6822 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -904,6 +904,8 @@ CONFIG_SND_SOC_LPASS_WSA_MACRO=m
>  CONFIG_SND_SOC_LPASS_VA_MACRO=m
>  CONFIG_SND_SOC_LPASS_RX_MACRO=m
>  CONFIG_SND_SOC_LPASS_TX_MACRO=m
> +CONFIG_SND_SOC_DAVINCI_MCASP=m
> +CONFIG_SND_SOC_TLV320AIC3X_I2C=m
>  CONFIG_SND_SIMPLE_CARD=m
>  CONFIG_SND_AUDIO_GRAPH_CARD=m
>  CONFIG_SND_AUDIO_GRAPH_CARD2=m
> 
> -- 
> 2.40.0
> 

please pay attention to savedefconfig output.

Something like this is more appropriate?

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ca3569261713..a13119aecaa1 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -877,6 +877,7 @@ CONFIG_SND_SOC_TEGRA210_AMX=m
 CONFIG_SND_SOC_TEGRA210_ADX=m
 CONFIG_SND_SOC_TEGRA210_MIXER=m
 CONFIG_SND_SOC_TEGRA_AUDIO_GRAPH_CARD=m
+CONFIG_SND_SOC_DAVINCI_MCASP=m
 CONFIG_SND_SOC_AK4613=m
 CONFIG_SND_SOC_ES7134=m
 CONFIG_SND_SOC_ES7241=m
@@ -891,6 +892,7 @@ CONFIG_SND_SOC_SIMPLE_MUX=m
 CONFIG_SND_SOC_TAS2552=m
 CONFIG_SND_SOC_TAS571X=m
 CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
+CONFIG_SND_SOC_TLV320AIC3X_I2C=m
 CONFIG_SND_SOC_WCD9335=m
 CONFIG_SND_SOC_WCD934X=m
 CONFIG_SND_SOC_WM8524=m
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
