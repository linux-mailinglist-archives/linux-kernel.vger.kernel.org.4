Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685346C1501
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjCTOnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjCTOm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:42:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BDE4EC7;
        Mon, 20 Mar 2023 07:42:53 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D410D660212C;
        Mon, 20 Mar 2023 14:42:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679323372;
        bh=1PCOMoENo5QV1yJfjTv1LPzClFUUYLNo+EJ9cnM0EJU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fQA6F6bYqkFXmYuOYjx5Fou2CI4BblLmcXlfoMWjrjA2/B6OGqG1Pq285ZJHu5fOQ
         XjjDmuyiqgA5Oc+0+zkcfn6WY3A7k0RvYOfHrw3FPhjSufylFiVpC7uqMpWybRWfrp
         87iJx1ywBEZr1SpucGKR76fu82VIniQ0u0wKtTp4SkWXZl4LllksBxZrMhcjOSu5fi
         Z8ndbUKPhGeGRwOeRNrJ8HAaXVUN4qDqiYBk21V6RE3hcD5UAqrGzo6mC7aZuhxOGF
         XW8VmJ+tN+mYOS7nxL6FKvenceibyx2cVcQLOK6rj5fbpcU5hMqF5+1Xmz9zoGJB+w
         fi4Ee8x+a9IEw==
Message-ID: <01964ce6-7a91-a86e-6ae0-73ab177ba01a@collabora.com>
Date:   Mon, 20 Mar 2023 15:42:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ARM: mediatek: Remove unused configs MACH_MT6592 and
 MACH_MT6592
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230320132634.17331-1-lukas.bulwahn@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230320132634.17331-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/03/23 14:26, Lukas Bulwahn ha scritto:
> Commit ad8a221e1f49 ("ARM: mediatek: Add config options for mediatek SoCs.")
> adds four configs MACH_MT6592, MACH_MT6592, MACH_MT8127 and MACH_MT8127 for
> foreseen future use in the MediaTek pinctrl driver. As of now, nine years

........

> after that commit, the configs MACH_MT8127 and MACH_MT8127 are used for
> that purpose, but tconfigs MACH_MT6592 and MACH_MT6592 have not been used.
> 
> Remove the unused configs MACH_MT6592 and MACH_MT6592.

I say that there's some confusion in the commit description... :-)

Please fix.

Thanks,
Angelo

> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>   arch/arm/mach-mediatek/Kconfig | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
> index 35a3430c7942..521af13a79d8 100644
> --- a/arch/arm/mach-mediatek/Kconfig
> +++ b/arch/arm/mach-mediatek/Kconfig
> @@ -15,14 +15,6 @@ config MACH_MT2701
>   	bool "MediaTek MT2701 SoCs support"
>   	default ARCH_MEDIATEK
>   
> -config MACH_MT6589
> -	bool "MediaTek MT6589 SoCs support"
> -	default ARCH_MEDIATEK
> -
> -config MACH_MT6592
> -	bool "MediaTek MT6592 SoCs support"
> -	default ARCH_MEDIATEK
> -
>   config MACH_MT7623
>   	bool "MediaTek MT7623 SoCs support"
>   	default ARCH_MEDIATEK


