Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29BF638DFA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiKYP7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 10:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiKYP7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:59:08 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97B91EAFF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:59:07 -0800 (PST)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 5187D1B001C5;
        Fri, 25 Nov 2022 17:59:00 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1669391940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WB7foQQL/Dk5LZAj1aKx/3cAkEF/z3UAEifYPWTvHLc=;
        b=nhM6AE3+K5BpRENYDYJW1OH3BLlKWaAsfXlFLFqMb5ysg8ft/7xhuJBc5WjG1CC+SkJJ8C
        GSXDaUZdsJjbpaguq8/7cbT+K5DfGVCjy9+inQkkTzQ8GidV3sO07ej/1OoGbfgl147YIA
        ASbx+Y5oFOAgKqdEH2iJb0F5L/OXKWl4IdQ4YNhvh12pF+j+TP1FTctrZR/DmEOwDzF5rB
        fjLICcWyc7qvCTGm2Qur7JcuxrDJkgLouep19/sC2Has05f7DZsplo5YwlElbPCVZLUWkf
        ktagjYixJrOLqH/YMRZ7xoEuXg/RiL1yL6qAuBWtpcUX67aTfjHiGCcp+v4c0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1669391940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WB7foQQL/Dk5LZAj1aKx/3cAkEF/z3UAEifYPWTvHLc=;
        b=ZFG1f6NikbWqRzblWiopcWIj83Cvpj0mpNNElHuXL4hH9PnXKNEkNW3knM0JjnezOZ/R2p
        MmlQBwpxIU5C/0KlPqKs3+IAwLGaOtJiNh51CscSGeeHu+6Dm0/yB2A/WvBBcesTo/G8oM
        BUaT45eG9CQKKvo5Xe1VP+Tp0YOOIVn2n+v+f6DHlOM/MVF6HBZxfv6PfEq9FzOA6btGOR
        tDndWcsu2J+/MBaroE1xa0XG+eVYbJXvka9j8APTGDQ3b8I+h/+JuU/SGeAliEjQHfi72j
        dFKsrtMI3AgridFOA7iJjPLkC1SbLVreSSKV2ZtMTUq2HDyeH6GWlST0fi7n8g==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1669391940; a=rsa-sha256;
        cv=none;
        b=Whh2clDAltkNBCmcHZsbA9PsmOK7yOFUjzOg7Lf8agQzStAap+KmEnKshb9dBPlR0TAT3u
        ccHpm0fvTPCuQCNX6XNElAbi+mTqyhXNXeFDO8NOLM5j15sLgQBuysvrwMmKtruxluHAZI
        7uAypiPNvfc2ZAm+SSPSsAsZ2GGgNAPmOkOmVE5jwdwXkBK+/R5F7CQ1+uqheFcYgqPZWg
        wMZYnuuie1WHEOo/t1INFLcIYLqKuSYPQixrGIN2l1XVA5L2/M1hNa00ly41o798tMlNk/
        rVjlzWHfaY5eAkKmoedqSeyaM1f4OLNERe5TNSNi3b8TEJBemnzmG079PputBQ==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id F28E6634C92;
        Fri, 25 Nov 2022 17:58:59 +0200 (EET)
Date:   Fri, 25 Nov 2022 17:58:59 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     shravan kumar <shravan.chippa@microchip.com>
Cc:     paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jacopo Mondi <jacopo@jmondi.org>
Subject: Re: [PATCH v5 3/6] media: i2c: imx334: hblank set function modify
Message-ID: <Y4DmQ8DftK9/WLXM@valkosipuli.retiisi.eu>
References: <20221125050807.1857479-1-shravan.chippa@microchip.com>
 <20221125050807.1857479-4-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125050807.1857479-4-shravan.chippa@microchip.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shravan,

Thanks for the patch.

On Fri, Nov 25, 2022 at 10:38:04AM +0530, shravan kumar wrote:
> From: Shravan Chippa <shravan.chippa@microchip.com>
> 
> -If we one modes hblank will not change and it is readonly
> -If we have multipull modes and if we do mode switch, hblank value will
> change and __v4l2_ctrl_s_ctrl() returns error, so modified
> function from __v4l2_ctrl_s_ctrl() to __v4l2_ctrl_modify_range()
> will updated all values max, min default it is not showing any error
> while changing the mode and update value

I think the commit message needs some more work.

> 
> Suggested-by: Jacopo Mondi <jacopo@jmondi.org>
> Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> ---
>  drivers/media/i2c/imx334.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c
> index acc9f9f15e47..d3bb62c162b3 100644
> --- a/drivers/media/i2c/imx334.c
> +++ b/drivers/media/i2c/imx334.c
> @@ -382,7 +382,8 @@ static int imx334_update_controls(struct imx334 *imx334,
>  	if (ret)
>  		return ret;
>  
> -	ret = __v4l2_ctrl_s_ctrl(imx334->hblank_ctrl, mode->hblank);
> +	ret = __v4l2_ctrl_modify_range(imx334->hblank_ctrl, IMX334_REG_MIN,
> +				       IMX334_REG_MAX, 1, mode->hblank);

I'd use mode->hblank for all the three values. This won't be settable by
the user anyway.

I wonder if IMX334_REG_MAX is correct as it would appear to require 20
bits, not 16, to store the value.

>  	if (ret)
>  		return ret;
>  

-- 
Kind regards,

Sakari Ailus
