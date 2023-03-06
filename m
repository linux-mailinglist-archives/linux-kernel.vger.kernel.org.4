Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21026AC4F3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 16:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjCFP2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 10:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjCFP2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 10:28:34 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4634ED9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 07:28:14 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m6so13256551lfq.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 07:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678116492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=My1MFXSD/RWeKCEqSJZ9TX01DdnzJtrMv7kbrxpycI4=;
        b=Ymb5/WI4gW9yBplYiAuQmNp4N4SodHb4uZk6ZUxx+RZs7ew9PDJE/0mgtAbuhqBi5D
         WkWK6zrEy+v6ecFJcYvc52rHLuMmLMgubaWjFa0MLdlPpJiolqfa0N5JnVdDS0PV8Obz
         G9j7Lk+Lg/T1BYlGFETEoI5liD3S3ujz7Hszlol8PnZJ7rRdh+xQ+b1UC1CZP7zOFGFw
         59iyTMrK+ZWKqDIKlgXGiXDSwnOLkyoyn/Dc9lbytn/jsI+DcEB25xbZP4MfLv9fBjja
         y+WHx6Baj0UHvp10YMReenk4y4Y0OELP0UGR45wYFHsypZOM+7Col5a9/Bgjl4hEjacU
         CRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678116492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=My1MFXSD/RWeKCEqSJZ9TX01DdnzJtrMv7kbrxpycI4=;
        b=uXWkoNrqz22LP3SM5V6jJx3N7TmlwAuVvPYNkZi4u/OpW0pCIS5doXK0QVmoAuYfKg
         wqIgyFoavNMLZMjpdaNQHtrgogLPcx5hD6/NpONzeGch8cymW2d1ShVmZD4uq+XBOSK/
         DL5jLfhCyOtcusPZIP1gKn/C7A7hIFAHclI+IgT57bckgSlFUKXJBOcTmqMYb1myr1Oe
         xnW78UvaaMLwOSXyxZ/5TtbBhymclZBoows3wSCW7O5uaC72dBgjbFs0XlKE00gOYuXM
         AO6DnWRB0tJVYsVuSk60G4v0qvs6Jg0M+CfcOMfKxZqtygGO1u2y1EJb/Etj4hPVKYQT
         OZiQ==
X-Gm-Message-State: AO0yUKWgr0r2rPEYFnw+5GFnzk1SRKmtmQsMaWcKWPJbqlybQWwpJ6RV
        uaeCDcR+L2ZJACM51/1PG+c=
X-Google-Smtp-Source: AK7set8QknUUjBPaJJUkVEulRaDql/56Ncy5gJ4sSLp6mFoFQ470mVFeJDp9hdw1jnhsTrNCM/AN9Q==
X-Received: by 2002:ac2:4a65:0:b0:4dc:8215:5524 with SMTP id q5-20020ac24a65000000b004dc82155524mr2553337lfp.31.1678116492513;
        Mon, 06 Mar 2023 07:28:12 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id a18-20020ac25212000000b004d813ec9b47sm1666020lfl.132.2023.03.06.07.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 07:28:11 -0800 (PST)
Date:   Mon, 6 Mar 2023 18:28:10 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Kang Chen <void0red@gmail.com>
Cc:     jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntb_tool: check null return of devm_kcalloc in
 tool_init_mws
Message-ID: <20230306152810.ptb622tfhoxehhdc@mobilestation>
References: <20230226055743.2522819-1-void0red@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230226055743.2522819-1-void0red@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 01:57:43PM +0800, Kang Chen wrote:
> devm_kcalloc may fails, tc->peers[pidx].outmws might be null
> and will cause null pointer dereference later.
> 
> Signed-off-by: Kang Chen <void0red@gmail.com>

Please add the fixes tag:
Fixes: 7f46c8b3a552 ("NTB: ntb_tool: Add full multi-port NTB API support")
so the patch could be noticeable by the stable kernel maintainers.

Other than that looks good.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

* Please don't forget to add the Rb-tags on v2.

-Serge(y)

> ---
>  drivers/ntb/test/ntb_tool.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index 5ee0afa62..eeeb4b1c9 100644
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -998,6 +998,8 @@ static int tool_init_mws(struct tool_ctx *tc)
>  		tc->peers[pidx].outmws =
>  			devm_kcalloc(&tc->ntb->dev, tc->peers[pidx].outmw_cnt,
>  				   sizeof(*tc->peers[pidx].outmws), GFP_KERNEL);
> +		if (tc->peers[pidx].outmws == NULL)
> +			return -ENOMEM;
>  
>  		for (widx = 0; widx < tc->peers[pidx].outmw_cnt; widx++) {
>  			tc->peers[pidx].outmws[widx].pidx = pidx;
> -- 
> 2.34.1
> 
> 
