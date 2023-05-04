Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BDD6F62F8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 04:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjEDCiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 22:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEDCiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 22:38:17 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D321B0
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 19:38:12 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id EA42224DE83;
        Thu,  4 May 2023 10:38:10 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 4 May
 2023 10:38:11 +0800
Received: from [192.168.125.87] (183.27.99.121) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 4 May
 2023 10:38:10 +0800
Message-ID: <307a7656-df3d-2e67-d07b-c5a2941c145b@starfivetech.com>
Date:   Thu, 4 May 2023 10:38:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] reset: starfive: select AUXILIARY_BUS
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-kernel@vger.kernel.org>
CC:     Emil Renner Berthing <kernel@esmil.dk>,
        Arnd Bergmann <arnd@arndb.de>
References: <20230502102050.1418417-1-p.zabel@pengutronix.de>
Content-Language: en-US
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <20230502102050.1418417-1-p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.99.121]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2023 12:20:50 +0200, Philipp Zabel wrote:
> CONFIG_AUXILIARY_BUS is not a user-visible symbol, replace 'depends on'
> with 'select'.
> 
> Cc: Emil Renner Berthing <kernel@esmil.dk>
> Cc: Hal Feng <hal.feng@starfivetech.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Reviewed-by: Hal Feng <hal.feng@starfivetech.com>

> ---
>  drivers/reset/starfive/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/starfive/Kconfig b/drivers/reset/starfive/Kconfig
> index 1fa706a2c3dc..d832339f61bc 100644
> --- a/drivers/reset/starfive/Kconfig
> +++ b/drivers/reset/starfive/Kconfig
> @@ -13,7 +13,8 @@ config RESET_STARFIVE_JH7100
>  
>  config RESET_STARFIVE_JH7110
>  	bool "StarFive JH7110 Reset Driver"
> -	depends on AUXILIARY_BUS && CLK_STARFIVE_JH7110_SYS
> +	depends on CLK_STARFIVE_JH7110_SYS
> +	select AUXILIARY_BUS
>  	select RESET_STARFIVE_JH71X0
>  	default ARCH_STARFIVE
>  	help

