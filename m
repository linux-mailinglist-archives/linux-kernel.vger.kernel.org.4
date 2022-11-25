Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FE96391FF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 00:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiKYXGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 18:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKYXGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 18:06:12 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02A6532F2;
        Fri, 25 Nov 2022 15:06:10 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q7so7816401wrr.8;
        Fri, 25 Nov 2022 15:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:to
         :from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Gdc60uUtAd13JAaaUEwIiBYF4E+nu8yqS9AdF7o+jnQ=;
        b=AUrpT0+NfaeksQBgyKP3rYSU50T/25HC+sM/6mywP7BsKUe1UxI6rpYfR0zFMcYFCu
         VcLJUn99l2QEm1s/XnoSt0727rf4VlftMJGvOmKHNcznGTeNaeImbSdh3RZ0ZMXSWn+Z
         A6QUIQdDDPrSZqPn6pfpgwOlqsKQITdKbit5si2Stii4TVRwyIB7WcLdxaow8HiMCIy2
         xOHD7uzzLZGfWNuP+hBJX4sUZiikMaWezkljc36TMVFs9vZIV1Y3Kijes8NbPZxJrhTb
         lEWDElTovAnfnBJIRaaGiiNblkPq/SmMlgIlbSK0oSzpNWIBMdoz5dq7j93XDed2WINP
         vWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:to
         :from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gdc60uUtAd13JAaaUEwIiBYF4E+nu8yqS9AdF7o+jnQ=;
        b=3yDB7V7fbgE53G/vEr4txz9HZu8w1RVgYbG+YtiA3PNIncbcX+ke/+0cA740x9KH2b
         Q9rmUQn1NqY1sQ5YkhMJVFghPiW8sBvoM97e/NE93gMqQZ9+c0E/7mjamT0zsd0HW8jh
         RhuBQxc3e+eXEAihjQ0l3r5rykK2EnlqWmlbrAdDVRVsJSkzrzWQB5tl4qE7YHzeEVO2
         bZNpyYPcUJweUfiLjTq4lM9IiGQ255Q8GJI/yDUCbhtdjR/DeaR8dzhVx5IZPFx4lXtk
         gnB8Wghld5Cknv0j3yf5qbgslpEQaX98RnJtYAv0RApmbuWVp8GGLc0Ke8UqN+WH6dTX
         SMrg==
X-Gm-Message-State: ANoB5pm2ZApD1Fvi3j/azKneC46tTAaWncSmTnXWnF6fAx1x7IRvo2d0
        wCv6NqfMnmBkZ3NS2WLz/v0=
X-Google-Smtp-Source: AA0mqf4wvOW0HT/jKuLc7rIhiTLutuKXTEab6buMlVq3WtRoiiZn/6riSjNomhIPNGprC1KQlCcQmg==
X-Received: by 2002:a5d:6886:0:b0:238:8896:7876 with SMTP id h6-20020a5d6886000000b0023888967876mr17827996wru.645.1669417569041;
        Fri, 25 Nov 2022 15:06:09 -0800 (PST)
Received: from Ansuel-xps. (93-42-71-18.ip85.fastwebnet.it. [93.42.71.18])
        by smtp.gmail.com with ESMTPSA id m6-20020adfc586000000b002366fb99cdasm4695968wrg.50.2022.11.25.15.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 15:06:08 -0800 (PST)
Message-ID: <63814a60.df0a0220.22f38.b1a4@mx.google.com>
X-Google-Original-Message-ID: <Y4FKX8opRdR2PolN@Ansuel-xps.>
Date:   Sat, 26 Nov 2022 00:06:07 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Marko <robimarko@gmail.com>
Subject: Re: [PATCH] clk: Warn and add workaround on misuse of .parent_data
 with .name only
References: <20221108204918.2805-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108204918.2805-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 09:49:18PM +0100, Christian Marangi wrote:
> By a simple mistake in a .parent_names to .parent_data conversion it was
> found that clk core assume fw_name is always provided with a parent_data
> struct for each parent and never fallback to .name to get parent name even
> if declared.
> 
> This is caused by clk_core_get that only checks for parent .fw_name and
> doesn't handle .name.
> 
> While it's sane to request the dev to correctly do the conversion and
> add both .fw_name and .name in a parent_data struct, it's not sane to
> silently drop parents without a warning.
> 
> Fix this in 2 ways. Add a kernel warning when a wrong implementation is
> used and copy .name in .fw_name in parent map populate function to
> handle clk problems and malfunctions.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Friendly bump for this?

> ---
>  drivers/clk/clk.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 57b83665e5c3..dccd4ea6f692 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -4015,10 +4015,21 @@ static int clk_core_populate_parent_map(struct clk_core *core,
>  			ret = clk_cpy_name(&parent->name, parent_names[i],
>  					   true);
>  		} else if (parent_data) {
> +			const char *parent_name;
> +
>  			parent->hw = parent_data[i].hw;
>  			parent->index = parent_data[i].index;
> +			parent_name = parent_data[i].fw_name;
> +
> +			if (!parent_name && parent_data[i].name) {
> +				WARN(1, "Empty .fw_name with .name in %s's .parent_data. Using .name for .fw_name declaration.\n",
> +				     core->name);
> +				parent_name = parent_data[i].name;
> +			}
> +
>  			ret = clk_cpy_name(&parent->fw_name,
> -					   parent_data[i].fw_name, false);
> +					   parent_name, false);
> +
>  			if (!ret)
>  				ret = clk_cpy_name(&parent->name,
>  						   parent_data[i].name,
> -- 
> 2.37.2
> 

-- 
	Ansuel
