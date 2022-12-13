Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C538C64B79C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235680AbiLMOmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236015AbiLMOl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:41:56 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE1720F46;
        Tue, 13 Dec 2022 06:41:53 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1447c7aa004so12742187fac.11;
        Tue, 13 Dec 2022 06:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FuEKi0VnOQUsKHoOQOgQF50mkQ6y9olLpEzMEEkEWg4=;
        b=cEiLIlWa6q0nwGilFxKwjnpUQXWSljM5XnvM0FBYhemRx3qhKcXv/hT9tlsvFuuOkY
         W3EUkbeV1x0RmaWDxr8GbkEtPualvYttaJd8iJy+dIJERFLlhXe44Ltbgl4Yp8n20YWh
         yuAns/mX3/7BJw8g0jCw+haHu9PXHUSpSjhbJ6lo+0Ii6g+YwowgN/hnmnLwLxM4unZk
         y48veynoCeBMku85dre7n5S4Btc7XdE/hoV2gYqWdfwOexF/hBDqnRFWLMKZ1aYjBjhj
         CG/LhYkluC8YfP8n2WBozwSJ3fHkyG1GSdr/I18u7x69GdP8CFqaag15v9inmsVJKCug
         cBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuEKi0VnOQUsKHoOQOgQF50mkQ6y9olLpEzMEEkEWg4=;
        b=ENZxtDhVIioNikSAOEf0x3Zxu2Im+4Q7aSexNOgBpIU4t5lk6Qm90pOygPUmgGK0mx
         WK5TCs1FwoGiraq+y1exieVxrSKso2K+xVenKjROTXTmuEvlhcL78hHqvIzzxOwYMuzM
         tYBpnGKt/mZYOeMHkDUBOALIkAKfaqxspibJ3Q5VpncTQDVRI5QHVG8q6wnaksRsXhm8
         ldpaXrAP3NHqc/jRMJxKEuUT5M4ze6208/e53vSxwdUsKSifyocHZxOn24YmOXArqagP
         zt6pYc5HeYGy1bLk0kz0gK6IIorGk8xmlUR4tPcRLTQMK2weOnWbQe2qvo4/BKCHtdF0
         +UNg==
X-Gm-Message-State: ANoB5pkoc4yoiGXbP3pwcF2KSzZOctI7H3KCaFLYqsQRsh3g96DB6gZF
        Jre6o4zeqHJrCY6b+H0bSzmgnASWBrc=
X-Google-Smtp-Source: AA0mqf6INb0zoS2n+cWjh2uH8ymCkIOBrCuP9CcA83Mb+xA8Dr/UJ2ibYIadGPdJFNJUf+P/Vz4sKg==
X-Received: by 2002:a05:6870:ac0e:b0:144:ccaf:2fa3 with SMTP id kw14-20020a056870ac0e00b00144ccaf2fa3mr11645757oab.42.1670942513264;
        Tue, 13 Dec 2022 06:41:53 -0800 (PST)
Received: from wintermute.localhost.fail (76-244-6-13.lightspeed.rcsntx.sbcglobal.net. [76.244.6.13])
        by smtp.gmail.com with ESMTPSA id p39-20020a056870832700b0011dca1bd2cdsm1547210oae.0.2022.12.13.06.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 06:41:52 -0800 (PST)
Date:   Tue, 13 Dec 2022 08:41:50 -0600
From:   Chris Morgan <macroalpha82@gmail.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] power: supply: rk817: Fix unsigned comparison with less
 than zero
Message-ID: <Y5iPLhDse826uE8O@wintermute.localhost.fail>
References: <20221213101904.42260-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213101904.42260-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 06:19:04PM +0800, Jiapeng Chong wrote:
> The tmp is defined as u32 type, which results in invalid processing of
> tmp<0 in function rk817_read_or_set_full_charge_on_boot(). Therefore,
> change the tmp type to int.

Good catch, but I'm wondering if we shouldn't just drop the comparison
to less than zero? If I'm not mistaken get_unaligned_be32() only
returns unsigned integers anyway, right?

Assuming my understanding is right, we'll just drop the comparison.
Otherwise, this would be the appropriate fix.

Thank you for catching this!
Chris

> 
> drivers/power/supply/rk817_charger.c:828 rk817_read_or_set_full_charge_on_boot() warn: unsigned 'tmp' is never less than zero.
> drivers/power/supply/rk817_charger.c:788 rk817_read_or_set_full_charge_on_boot() warn: unsigned 'tmp' is never less than zero.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3444
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/power/supply/rk817_charger.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
> index 4f9c1c417916..7eefbcc0a4e9 100644
> --- a/drivers/power/supply/rk817_charger.c
> +++ b/drivers/power/supply/rk817_charger.c
> @@ -731,8 +731,8 @@ rk817_read_or_set_full_charge_on_boot(struct rk817_charger *charger,
>  {
>  	struct rk808 *rk808 = charger->rk808;
>  	u8 bulk_reg[4];
> -	u32 boot_voltage, boot_charge_mah, tmp;
> -	int ret, reg, off_time;
> +	u32 boot_voltage, boot_charge_mah;
> +	int ret, reg, off_time, tmp;
>  	bool first_boot;
>  
>  	/*
> -- 
> 2.20.1.7.g153144c
> 
