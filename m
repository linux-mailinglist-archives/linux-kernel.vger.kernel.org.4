Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA17632CE2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiKUTTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiKUTTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:19:36 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6AE55A6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:19:35 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id b12so7523692wrn.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xAi8a3PnIsw1PomXHZEK5DhJnyCWSuGYAtIKDL2Vdxg=;
        b=S1d4PAXe/bvFwIlocpNBPJozaI16f1FDVcrsqavt/2ou6oQToHBj54jr2wiS/bRz8s
         J0iZEMBfyhp2aBIbWG2drSKdresl2LFBG3WIBtI38bE4pIGTwwWHC5W4sjqoIKujlYGH
         hcdZVsdPIAXZ8f9gKvPRaSC8yADvpEN4UC/f6NVedUv58qSDkSS54CBCQwHv5fIvhrad
         eoZeQ/fZTxJBvSjPdYrXpXLHfoI2WcZbw4lMB8N/RNrPAj2MNHNeXukFv57W3bwdVd9l
         mV3KbgG+p3PECdLs7RG6C9hItipSH0WBbwYtx/225+Uv7Mrvp60sswV3HcKYzmFqAk4A
         YiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAi8a3PnIsw1PomXHZEK5DhJnyCWSuGYAtIKDL2Vdxg=;
        b=HHduKX4nyaSle+et0TOYHtOJHQdIweUJEqKIEQhP3MpGKtRfqa3B/5iWRWGZAXnOYq
         RXgRJVsBhXgsydpp38i8j/i/QBSPpOuLiJYB31tdeTo7EyZDAzbzbybVK1PDfjC0t7Bk
         2ssdZwcdBkzsWrNVE31bKMdMeyp+Lfjq5nHMh3x1XG2hsl7UAolvnQSxGy5KbuxMYwql
         bY1O2FwhuZ5oDHnClzdHGXyjd70azhNWvGpqX/b7uWj1xtluS+QpPMRu5J8J4n/lfRu3
         Qswih60iEJzdhlNPLKrld3jV2GkfbSI2U+g9n3RQ8ph5H3o0+NsYyPRO50mYebWlyyMU
         KBSA==
X-Gm-Message-State: ANoB5plcmWSH1o55Yle8eNMvxsGYJvPktFDLC8rqNp7JeZaiLTlg1uUO
        +bXyIFHNS6s2wasgXpHO12O89A==
X-Google-Smtp-Source: AA0mqf5p5mVVBPcNPVfslo0MoCa5w1wzbaHVw1TsDG4VhvmXy1UpOVDOMuRzZzAHIUMnIJCBorH+sQ==
X-Received: by 2002:a05:6000:1d97:b0:241:b99a:949f with SMTP id bk23-20020a0560001d9700b00241b99a949fmr11857563wrb.599.1669058373899;
        Mon, 21 Nov 2022 11:19:33 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id m7-20020a05600c4f4700b003b4fe03c881sm21052903wmq.48.2022.11.21.11.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 11:19:33 -0800 (PST)
Date:   Mon, 21 Nov 2022 21:19:31 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH] clk: imx: DRY cleanup of imx_obtain_fixed_clock_hw()
Message-ID: <Y3vPQ4A/hjYHs8vD@linaro.org>
References: <20221113180945.1626061-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221113180945.1626061-1-dario.binacchi@amarulasolutions.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-11-13 19:09:44, Dario Binacchi wrote:
> The imx_obtain_fixed_clock() and imx_obtain_fixed_clock_hw() functions
> behave pretty similarly, DRY and call one from another.
> 
> No functional changes intended.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
>  drivers/clk/imx/clk.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
> index 5582f18dd632..573b1a6ca1dc 100644
> --- a/drivers/clk/imx/clk.c
> +++ b/drivers/clk/imx/clk.c
> @@ -104,9 +104,7 @@ struct clk_hw *imx_obtain_fixed_clock_hw(
>  {
>  	struct clk *clk;
>  
> -	clk = imx_obtain_fixed_clock_from_dt(name);
> -	if (IS_ERR(clk))
> -		clk = imx_clk_fixed(name, rate);
> +	clk = imx_obtain_fixed_clock(name, rate);

NACK here. You're switching to a non "clk_hw" based variant that
should/would be removed in the near future.

In the future, we want the clock providers to not used "clk" based APIs.

Rule is, AFAIR, to use "clk" based APIs in clock consumer drivers only,
while using "clk_hw" based APIs in clock provider drivers only.

Right now, only the imx5 and vf610 clock provider drivers still use the
'clk' based API. Once those are switched to 'clk_hw' based, all the 'clk'
i.MX specific APIs will be removed for good.

>  	return __clk_get_hw(clk);
>  }
>  
> -- 
> 2.32.0
> 
