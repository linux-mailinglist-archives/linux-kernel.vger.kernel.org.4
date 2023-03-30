Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF986CF93A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 04:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjC3Cln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 22:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjC3Cll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 22:41:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4175B88;
        Wed, 29 Mar 2023 19:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=DNWpv8luXIXlXVKr84nw9mRzsN7hWaibZ1L+G88+I/o=; b=dLnxa8W1S+ZkOtGBEkNz3sfFG2
        QC+6zGQf12z1ELTgjwE382iL9xwcjwNc03Ka/OB82Frfp1mKRISwLD0DPw2RNfrWW72WjSEvQwduM
        dKgWjE8foqfn9niJXebCf5JyMK6AxUrP//ff+ZBx9x439Gf/STc4190hMYJOE1dGYuFSxSzi3ipRk
        rrpaBiBj6zPskJAokPB3vLSQybwKc4vnQ4iSi5mFUM6LnozRK8pousTR2O2ljZU41wThS7zhROZL/
        ytZYXO/+ALECwCiYSzc9UCFjAUkF9nwm/47G+gwjhzDWg4UlQd9Sm0arbr7nJVEVtt84XeY0VHUu0
        +QPM+1hg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phiE7-002MsY-1E;
        Thu, 30 Mar 2023 02:41:23 +0000
Message-ID: <2e78dd39-0b1f-6c92-a953-52b005cb707f@infradead.org>
Date:   Wed, 29 Mar 2023 19:41:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] leds: rgb: mt6370: fix CONFIG_LINEAR_RANGES select
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Alice Chen <alice_chen@richtek.com>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230328131222.1390091-1-arnd@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230328131222.1390091-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/28/23 06:11, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> CONFIG_LINEAR_RANGE does not exist, but selecting is silently ignored.
> 
> ERROR: modpost: "linear_range_get_selector_within" [drivers/leds/rgb/leds-mt6370-rgb.ko] undefined!
> 
> Fixes: 55a8a5c16eb3 ("leds: rgb: mt6370: Add MediaTek MT6370 current sink type LED Indicator support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/leds/rgb/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
> index 7d86bb26c54b..360c8679c6e2 100644
> --- a/drivers/leds/rgb/Kconfig
> +++ b/drivers/leds/rgb/Kconfig
> @@ -29,7 +29,7 @@ config LEDS_QCOM_LPG
>  config LEDS_MT6370_RGB
>  	tristate "LED Support for MediaTek MT6370 PMIC"
>  	depends on MFD_MT6370
> -	select LINEAR_RANGE
> +	select LINEAR_RANGES
>  	help
>  	  Say Y here to enable support for MT6370_RGB LED device.
>  	  In MT6370, there are four channel current-sink LED drivers that

-- 
~Randy
