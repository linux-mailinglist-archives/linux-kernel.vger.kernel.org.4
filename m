Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8346009F4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiJQJKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiJQJKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:10:18 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AC622288;
        Mon, 17 Oct 2022 02:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1665997807; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0bJfDcoOH2/Dfhg55MIWlaG3Eyh+d7rLyW2xeWWEQy8=;
        b=CUek5BrHtkLHGNAQvqkzWSKqxJ7U/UHeNfTUWBi+2KPDpcLQJV2UQMEqP6wpPs5x/wdhv8
        brK0Z8OAQUfv+oKnBeqFCY7bQL0XyVc8pRZ6M+ZClv4w/ulqmtg5geb87QYDgGcs62k2DR
        Bet/jnmj2kowe+zsoANpATl4nu1wdwQ=
Date:   Mon, 17 Oct 2022 10:09:56 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 1/4] MIPS: ingenic: add new machine type MACH_JZ4755
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Message-Id: <K44WJR.2LW3IFMAMTV73@crapouillou.net>
In-Reply-To: <20221016150110.3020451-2-lis8215@gmail.com>
References: <20221016150110.3020451-1-lis8215@gmail.com>
        <20221016150110.3020451-2-lis8215@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Siarhei,

Le dim., oct. 16 2022 at 18:01:06 +0300, Siarhei Volkau=20
<lis8215@gmail.com> a =E9crit :
> which is close to jz4725b because it is actually a low price
> successor of the jz4755.
> It has the same MIPS32r1 core with Xburst(R) extension
> MXU version 1 release 2.
>=20
> Signed-off-by: Siarhei Volkau <lis8215@gmail.com>

This patch doesn't really belong in the CGU patchset. It should go=20
through the MIPS tree.

I see why you include it, but you do not need to have the MACH_JZ4755=20
symbol defined anywhere for the "default MACH_JZ4755" to work, it will=20
just default to false until the patchset that adds JZ4755 support is=20
merged in the MIPS tree.

Cheers,
-Paul

> ---
>  arch/mips/ingenic/Kconfig | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/mips/ingenic/Kconfig b/arch/mips/ingenic/Kconfig
> index f595b339a..edd84cf13 100644
> --- a/arch/mips/ingenic/Kconfig
> +++ b/arch/mips/ingenic/Kconfig
> @@ -4,6 +4,7 @@ config MACH_INGENIC_GENERIC
>  	bool
>  	select MACH_INGENIC
>  	select MACH_JZ4740
> +	select MACH_JZ4755
>  	select MACH_JZ4725B
>  	select MACH_JZ4770
>  	select MACH_JZ4780
> @@ -53,6 +54,10 @@ config MACH_JZ4740
>  	bool
>  	select SYS_HAS_CPU_MIPS32_R1
>=20
> +config MACH_JZ4755
> +	bool
> +	select SYS_HAS_CPU_MIPS32_R1
> +
>  config MACH_JZ4770
>  	bool
>  	select MIPS_CPU_SCACHE
> --
> 2.36.1
>=20


