Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BD4637B76
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiKXOaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiKXOaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:30:01 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081EA7213E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:30:00 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AOETi5W123967;
        Thu, 24 Nov 2022 08:29:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669300184;
        bh=p3XAYJULHTof+WGSRULAI+1LIPzeKFGM52n9MJzEML0=;
        h=Date:To:CC:References:From:Subject:In-Reply-To;
        b=kbtSR6/2sL6gD8wfTkx7WYMV/gjyUKBlcaH21zborWmCgpFfAiXt5K/Kr1f3Xk3Te
         VmNjr1CFiBJO9SXfPlsAbe98UbywLkOl1HFUWD2dpwKKhdemm4wGYgfEHNC/UTLUyU
         jp5ipwOX2+22yZ8WVZiC8NBQ9xSF20jgw6g2KXyg=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AOETi0A031279
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Nov 2022 08:29:44 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 24
 Nov 2022 08:29:44 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 24 Nov 2022 08:29:44 -0600
Received: from [10.250.233.34] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AOETeX6127539;
        Thu, 24 Nov 2022 08:29:41 -0600
Message-ID: <db869c2f-d34f-1ce5-22f9-634a8454ee79@ti.com>
Date:   Thu, 24 Nov 2022 19:59:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     Nicolas Frayer <nfrayer@baylibre.com>, <nm@ti.com>,
        <kristo@kernel.org>, <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jassisinghbrar@gmail.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <khilman@baylibre.com>, <glaroque@baylibre.com>
References: <20221122202245.449198-1-nfrayer@baylibre.com>
 <20221122202245.449198-2-nfrayer@baylibre.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 1/3] arm64: arch_k3: Removed ti mailbox and sci select
In-Reply-To: <20221122202245.449198-2-nfrayer@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/11/22 1:52 am, Nicolas Frayer wrote:
> In order to build ti mailbox and ti sci as modules,
> remove their automatic selection by ARCH_K3
> 

$Subject: s/Removed/Remove,
s/ti/TI
s/sci/SCI

> Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
> ---
>  arch/arm64/Kconfig.platforms | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 912529ac58b3..5f16eb498dbf 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -126,8 +126,6 @@ config ARCH_K3
>  	select PM_GENERIC_DOMAINS if PM
>  	select MAILBOX
>  	select SOC_TI
> -	select TI_MESSAGE_MANAGER
> -	select TI_SCI_PROTOCOL
>  	select TI_SCI_INTR_IRQCHIP
>  	select TI_SCI_INTA_IRQCHIP
>  	help


Why not use "imply" instead of "select". This should allow TI_SCI*
drivers to be built as modules if required. Would make 2/3 and 3/3
redundant.

Also, note that 1/3, 2/3 and 3/3 have to go through 3 different trees,
so not a great idea to post as a single series.

Regards
Vignesh
