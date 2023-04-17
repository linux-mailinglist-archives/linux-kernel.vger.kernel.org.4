Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C2C6E504A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjDQSdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjDQSdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:33:35 -0400
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855CC46A0;
        Mon, 17 Apr 2023 11:33:31 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 19C5B20161;
        Mon, 17 Apr 2023 20:33:29 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hr61X2M0I_RQ; Mon, 17 Apr 2023 20:33:28 +0200 (CEST)
Received: from begin.home (apoitiers-658-1-118-253.w92-162.abo.wanadoo.fr [92.162.65.253])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 69A5720147;
        Mon, 17 Apr 2023 20:33:27 +0200 (CEST)
Received: from samy by begin.home with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1poTfK-005f4r-2Z;
        Mon, 17 Apr 2023 20:33:26 +0200
Date:   Mon, 17 Apr 2023 20:33:26 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>, speakup@linux-speakup.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] speakup: Fix spelling mistake "windo" -> "window"
Message-ID: <20230417183326.ylyd5xpog7dydw55@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>, speakup@linux-speakup.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230417183203.54388-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417183203.54388-1-colin.i.king@gmail.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Ian King, le lun. 17 avril 2023 19:32:03 +0100, a ecrit:
> There is a spelling mistake in a literal string. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  drivers/accessibility/speakup/i18n.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/accessibility/speakup/i18n.c b/drivers/accessibility/speakup/i18n.c
> index d62079b1661f..554bf81f2c1c 100644
> --- a/drivers/accessibility/speakup/i18n.c
> +++ b/drivers/accessibility/speakup/i18n.c
> @@ -31,7 +31,7 @@ static char *speakup_default_msgs[MSG_LAST_INDEX] = {
>  	[MSG_CURSORING_OFF] = "cursoring off",
>  	[MSG_CURSORING_ON] = "cursoring on",
>  	[MSG_HIGHLIGHT_TRACKING] = "highlight tracking",
> -	[MSG_READ_WINDOW] = "read windo",
> +	[MSG_READ_WINDOW] = "read window",
>  	[MSG_READ_ALL] = "read all",
>  	[MSG_EDIT_DONE] = "edit done",
>  	[MSG_WINDOW_ALREADY_SET] = "window already set, clear then reset",
> -- 
> 2.30.2
> 
