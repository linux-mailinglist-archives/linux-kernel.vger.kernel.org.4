Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5835064E185
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiLOTEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 14:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiLOTET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:04:19 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46144379C8;
        Thu, 15 Dec 2022 11:04:18 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1433ef3b61fso436146fac.10;
        Thu, 15 Dec 2022 11:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2AOozFIty5EkdA/CcLLeXdwtUlPwrAgRICt90mI5rTM=;
        b=H1KE6ri4mnp4XVqEcDY7zPo88mPOJwu9+tz3ObwvnDniqYPKdObUPGSE0KegGKj95G
         dTZao0Ay/oRmjS5TzTCbCA/T0h6ugVBScILe4Neh1DHs4ZyUlCKBx2NLqhaEsUjxr5c2
         bXsGKbuxEN6vgVy5SMkZ+8OpQcdL4gmrkuN61zyaOiP3sEwwJKHAuSbZ3m1JB6LPd/9z
         V+jigdVg3VgdWz0jZCbhubd7COoLQcldUCzMHHD4PI84T09+PSJZZhyvvXNAONd9A3i9
         wLTehUCfWdlxaFueULisgbg/ApB1pA3h8bWGRHC7zk6fUbc8lheF5ZtFwDAJ5J6UdP4p
         IolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AOozFIty5EkdA/CcLLeXdwtUlPwrAgRICt90mI5rTM=;
        b=GXmWLVNjKLZb9dzjWKLGVG3CcmFi76VXQvwMWwVBfNO9hmmOpPlFE7iwrtuqX73SZN
         cKljqVdteBinzHnZW2e0HQPQH+p1nn4GfGw2phL7nAoHlBAW1KxRJUwbq9VD6aBS+sK+
         eDVe60Wk+u4sx7qt1VnmXMz1hwnP88zgDZZLXQTNg80Un68pB0aM2HoilH7L6ee+ypbw
         N3W+Zj9OeDZwGPF9CEVW8eTKCq8p+dmrLolEac+A6G5RvSkbacCNREh8vMLWIGJRnEip
         1Q1FZJS7wczvzM5RBDWlqn6xiXizXLdC5gLU9MkmO1a8H8gjyiyyVoT329SZCGe4LUFp
         D0FQ==
X-Gm-Message-State: ANoB5pk5QiLb6rTHmfMr/qzbxH7JEqAeaiHmUZNrwYFFwG3wSbw+JItg
        ouec0dwn/6adg9YQFIzBz+Y=
X-Google-Smtp-Source: AA0mqf6RRqS2vDRqkGsMPdmpVwGN/Y3NvskbmxxLkZ3lNds8XNOid3RRqWTtN3fJHiMg4NohT5LFPg==
X-Received: by 2002:a05:6870:f10f:b0:144:3cda:a95c with SMTP id k15-20020a056870f10f00b001443cdaa95cmr17884182oac.18.1671131057576;
        Thu, 15 Dec 2022 11:04:17 -0800 (PST)
Received: from neuromancer. ([76.244.6.13])
        by smtp.gmail.com with ESMTPSA id d14-20020a4aaa8e000000b004a0ad937ccdsm97158oon.1.2022.12.15.11.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 11:04:16 -0800 (PST)
Message-ID: <639b6fb0.4a0a0220.f7fcf.0b2f@mx.google.com>
X-Google-Original-Message-ID: <Y5tvrpi7u+MqX7eH@neuromancer.>
Date:   Thu, 15 Dec 2022 13:04:14 -0600
From:   Chris Morgan <macroalpha82@gmail.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH v2] power: supply: rk817: Fix unsigned comparison with
 less than zero
References: <20221214032316.22392-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214032316.22392-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 11:23:16AM +0800, Jiapeng Chong wrote:
> The tmp is defined as u32 type, which results in invalid processing of
> tmp<0 in function rk817_read_or_set_full_charge_on_boot(). Therefore,
> drop the comparison.
> 
> drivers/power/supply/rk817_charger.c:828 rk817_read_or_set_full_charge_on_boot() warn: unsigned 'tmp' is never less than zero.
> drivers/power/supply/rk817_charger.c:788 rk817_read_or_set_full_charge_on_boot() warn: unsigned 'tmp' is never less than zero.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3444
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Looks good to me, thank you.

Tested-by: Chris Morgan <macromorgan@hotmail.com>

> ---
> Changes in v2:
>   -Drop the comparison 'tmp<0'.
> 
>  drivers/power/supply/rk817_charger.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
> index 4f9c1c417916..36f807b5ec44 100644
> --- a/drivers/power/supply/rk817_charger.c
> +++ b/drivers/power/supply/rk817_charger.c
> @@ -785,8 +785,6 @@ rk817_read_or_set_full_charge_on_boot(struct rk817_charger *charger,
>  		regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_Q_PRES_H3,
>  				 bulk_reg, 4);
>  		tmp = get_unaligned_be32(bulk_reg);
> -		if (tmp < 0)
> -			tmp = 0;
>  		boot_charge_mah = ADC_TO_CHARGE_UAH(tmp,
>  						    charger->res_div) / 1000;
>  		/*
> @@ -825,8 +823,6 @@ rk817_read_or_set_full_charge_on_boot(struct rk817_charger *charger,
>  	regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_Q_PRES_H3,
>  			 bulk_reg, 4);
>  	tmp = get_unaligned_be32(bulk_reg);
> -	if (tmp < 0)
> -		tmp = 0;
>  	boot_charge_mah = ADC_TO_CHARGE_UAH(tmp, charger->res_div) / 1000;
>  	regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_OCV_VOL_H,
>  			 bulk_reg, 2);
> -- 
> 2.20.1.7.g153144c
> 
