Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C8E6C445B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 08:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjCVHuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 03:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjCVHui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:50:38 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488305B416
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 00:50:36 -0700 (PDT)
Received: from [192.168.0.2] (unknown [95.90.235.137])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1F2BA61CC40F9;
        Wed, 22 Mar 2023 08:50:33 +0100 (CET)
Message-ID: <59886f87-c277-5917-a521-5893ab75acee@molgen.mpg.de>
Date:   Wed, 22 Mar 2023 08:50:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ARM: npcm: remove select of non-existant ERRATA
Content-Language: en-US
To:     Rouven Czerwinski <r.czerwinski@pengutronix.de>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Russell King <linux@armlinux.org.uk>, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendan.higgins@linux.dev>
References: <20230316204749.19902-1-r.czerwinski@pengutronix.de>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230316204749.19902-1-r.czerwinski@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Rouven,


Thank you for your patch.

Am 16.03.23 um 21:47 schrieb Rouven Czerwinski:

There is a small typo in the commit message summary/title: 
non-exist*e*nt. Maybe also mention the errata number:

ARM: npcm: Remove select of non-existent ARM_ERRATA_794072

> config ARCH_NPCM7XX selects ARM_ERRATA_794072, however this config
> option does not exist since the workaround for the errata requires
> secure mode access which needs to be run by the bootloader or firmware
> since linux can't determine whether it is running in secure mode.

Please add a Fixes: tag.

> Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
> ---
>   arch/arm/mach-npcm/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-npcm/Kconfig b/arch/arm/mach-npcm/Kconfig
> index 63b42a19d1b8..d933e8abb50f 100644
> --- a/arch/arm/mach-npcm/Kconfig
> +++ b/arch/arm/mach-npcm/Kconfig
> @@ -30,7 +30,6 @@ config ARCH_NPCM7XX
>   	select ARM_ERRATA_764369 if SMP
>   	select ARM_ERRATA_720789
>   	select ARM_ERRATA_754322
> -	select ARM_ERRATA_794072
>   	select PL310_ERRATA_588369
>   	select PL310_ERRATA_727915
>   	select MFD_SYSCON

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
