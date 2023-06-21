Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418BE737A91
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 07:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjFUFQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 01:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjFUFQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 01:16:14 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259DF1731
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 22:16:13 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35L5Fjtp101475;
        Wed, 21 Jun 2023 00:15:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1687324545;
        bh=gdSKBAHXME67iDUjjTxgSJdTJzxuz53mF7TqxaI2pts=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=hoV2Ji4ZIz3fMcnfXbQ93fKA+HLTUVF7ZXPPYwD3Cj1wAvpvjujQ04e2vU+NPX42/
         snlgE68tSFQsjpRiy8R6Roa8EvnQDQY0vun9BKZHVC/TlCzAvdJQ8gvvzyyBJ0rgoj
         /MMxGU2pY0V21gYi+Tj7iFlK+oA196lHdo+/3YK8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35L5FiMt052228
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Jun 2023 00:15:45 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Jun 2023 00:15:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Jun 2023 00:15:44 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35L5FigF104638;
        Wed, 21 Jun 2023 00:15:44 -0500
Date:   Wed, 21 Jun 2023 00:15:44 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Udit Kumar <u-kumar1@ti.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>, <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <quic_bjorande@quicinc.com>,
        <arnd@arndb.de>, <krzysztof.kozlowski@linaro.org>,
        <konrad.dybcio@linaro.org>, <geert+renesas@glider.be>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <rafal@milecki.pl>
Subject: Re: [PATCH] arm64: defconfig: Enable K3 RTI Watchdog
Message-ID: <20230621051544.mvxz5hjxhi37eakw@precinct>
References: <20230621051358.3905149-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230621051358.3905149-1-u-kumar1@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:43-20230621, Udit Kumar wrote:
> K3 Family has RTI watchdog. This patch is

For the benefit of others, please provide context of what K3 and RTI
watchdog is.

> needed to enable WDT functions.

Why not a module?

Also please indicate specific products that can benefit with the change.

> 
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 57c6b7bb88d4..4567645abe35 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -686,6 +686,7 @@ CONFIG_UNIPHIER_WATCHDOG=y
>  CONFIG_PM8916_WATCHDOG=m
>  CONFIG_BCM2835_WDT=y
>  CONFIG_BCM7038_WDT=m
> +CONFIG_K3_RTI_WATCHDOG=y
>  CONFIG_MFD_ALTERA_SYSMGR=y
>  CONFIG_MFD_BD9571MWV=y
>  CONFIG_MFD_AXP20X_I2C=y
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
