Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25907638E05
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 17:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiKYQCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 11:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiKYQCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 11:02:10 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0464A9CD;
        Fri, 25 Nov 2022 08:02:10 -0800 (PST)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id E37A91B001B1;
        Fri, 25 Nov 2022 18:02:07 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1669392127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=amZ2eNZc2IpuqO8I2HCrrqLSq4BbWLC0jk8j44kBK9Y=;
        b=DTZYuachhszqpEc+6ONz8datk3/lknTJCArIScEO58r8PTZf0vUCNMepM2LaJEXBZwQkPg
        FYRFrL05FgHZ4gCmdTvovKNbGQNSWGB1n2DtpHiR51+TEAJvPUd0bpANbuiqoi75f8LOkA
        ayXIJYpWamIjDff2brT9GphXwJREOcmS+WioP29Rch2keASVCpokmDQJOG8jCYM79xc/Ft
        w1CObIsvOshzWSOpgpOmYAnHhxLGHCvvmNXZxEEVbImojXViiEaXc7hqMQILu1nbHTBMi7
        /oT7BPZPvMz0zVYibIQOrKL+iUSG6A4ZWdX5CT1JPv6F/WDUenOePgLGzPM7sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1669392127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=amZ2eNZc2IpuqO8I2HCrrqLSq4BbWLC0jk8j44kBK9Y=;
        b=Bg6IZ6DdVr1Ehr8PaSI157FLXKYhciJWLXQO3AenqtyoheN8UYEEcjsOMIG3rnKPAFyVZo
        7Jy8hWaDq1iw3lTG+Ksv8+A9iK0/rFqspyQ8YF8LYU8BZkFSC7AdRWmZg3S06ABVuaeNJc
        /hqCJjFNVetnZhHPxkrfZjnoSzPpc38nvd36wu9X+2ZMCXBQHFd3z4uSsbUXzmzXOKsomy
        XV4qCJBhVM/Qcjj5YrkRzmQJckRjotkvsmb2i+wZ5E2lBo34PZpE+TjtJqzedHITf17FlB
        8aLQmMwaKTpcuH7sZf3reL2pFGal+0Z+bEY4JOARKIyQ6+ifFGDCMOBw518U+A==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1669392127; a=rsa-sha256;
        cv=none;
        b=eiEevxM7wH5rbfV20Qcerzvyd+b02zroz8NCmmeuIE1aPIugxTkDaNu87mZJszweqSoALv
        3gIkAHXylXJtOmTsnMBROCcWEx/F05Bq6IlZgsoO3yR0710yNcIoL5c3IrfEaG3PeiTHz9
        j8NK2womqJSNm+paDVi2AZ6jPgauQFYRs0rrerlITS3dMuCAjhoBuMVLcjKDEJoakCzSw8
        otD3do2D3V2sT7jayHLehBNtgwVMftZcYcg9hAYvog9sEEIqJ0j1cGZS/fJmLE0XtGiqqk
        CzNW1QXfYmn6S4pj3lE78RIvABWHfHTJuYEvaJoRvq1rFGesfgqSIPoTlbDLng==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 8C68C634C92;
        Fri, 25 Nov 2022 18:02:07 +0200 (EET)
Date:   Fri, 25 Nov 2022 18:02:07 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     shravan kumar <shravan.chippa@microchip.com>
Cc:     paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/6] media: i2c: imx334: add default values in
 3840x2160@60 array
Message-ID: <Y4Dm//xBeYBijT4d@valkosipuli.retiisi.eu>
References: <20221125050807.1857479-1-shravan.chippa@microchip.com>
 <20221125050807.1857479-5-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125050807.1857479-5-shravan.chippa@microchip.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shravan,

On Fri, Nov 25, 2022 at 10:38:05AM +0530, shravan kumar wrote:
> From: Shravan Chippa <shravan.chippa@microchip.com>
> 
> -If we have only one mode there is no need to update camera
> reset(default) values when we initialize the camera

How is this related to the patch?

> 
> -If we have mutipull modes in this case we need all value to
> write while camera initializing, so i will not effect other modes
> while shifting dynamically
> 
> -All default values for 3840x2160@60 updated becouse if we change
> the mode we will not be able to recover the values, so add in
> mode_3840x2160_regs[] array

Please remove dashes in front of the paragrahs and use period in the end of
sentences.

Are these registers' values specific to this mode or are they different on
different modes?

> 
> Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> ---
>  drivers/media/i2c/imx334.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c
> index d3bb62c162b3..cd41df56ab7d 100644
> --- a/drivers/media/i2c/imx334.c
> +++ b/drivers/media/i2c/imx334.c
> @@ -166,6 +166,7 @@ static const struct imx334_reg mode_3840x2160_regs[] = {
>  	{0x3288, 0x21},
>  	{0x328a, 0x02},
>  	{0x302c, 0x3c},
> +	{0x302d, 0x00},
>  	{0x302e, 0x00},
>  	{0x302f, 0x0f},
>  	{0x3076, 0x70},
> @@ -240,7 +241,26 @@ static const struct imx334_reg mode_3840x2160_regs[] = {
>  	{0x3794, 0x7a},
>  	{0x3796, 0xa1},
>  	{0x3e04, 0x0e},
> +	{0x319e, 0x00},
>  	{0x3a00, 0x01},
> +	{0x3A18, 0xBF},
> +	{0x3A19, 0x00},
> +	{0x3A1A, 0x67},
> +	{0x3A1B, 0x00},
> +	{0x3A1C, 0x6F},
> +	{0x3A1D, 0x00},
> +	{0x3A1E, 0xD7},
> +	{0x3A1F, 0x01},
> +	{0x3A20, 0x6F},
> +	{0x3A21, 0x00},
> +	{0x3A22, 0xCF},
> +	{0x3A23, 0x00},
> +	{0x3A24, 0x6F},
> +	{0x3A25, 0x00},
> +	{0x3A26, 0xB7},
> +	{0x3A27, 0x00},
> +	{0x3A28, 0x5F},
> +	{0x3A29, 0x00},
>  };
>  
>  /* Supported sensor mode configurations */

-- 
Kind regards,

Sakari Ailus
