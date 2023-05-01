Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2EF6F2BDF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 03:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjEABc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 21:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjEABcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 21:32:25 -0400
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E00F7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 18:32:23 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id C9D642014C;
        Mon,  1 May 2023 03:32:20 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TEH3NvUQEhpT; Mon,  1 May 2023 03:32:20 +0200 (CEST)
Received: from begin (lfbn-bor-1-1163-184.w92-158.abo.wanadoo.fr [92.158.138.184])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 2A1F020146;
        Mon,  1 May 2023 03:32:20 +0200 (CEST)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1ptIOp-00EpS0-2S;
        Mon, 01 May 2023 03:32:19 +0200
Date:   Mon, 1 May 2023 03:32:19 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Mushahid Hussain <mushi.shar@gmail.com>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>, speakup@linux-speakup.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] accessibility: use C99 array init
Message-ID: <20230501013219.e4ekzxgoequdlmsu@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Mushahid Hussain <mushi.shar@gmail.com>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>, speakup@linux-speakup.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230501001617.9152-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501001617.9152-1-rdunlap@infradead.org>
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

Randy Dunlap, le dim. 30 avril 2023 17:16:17 -0700, a ecrit:
> Use C99 array initializer syntax for consistency with other array
> initializers around it and to eliminate a sparse warning:
> 
> drivers/accessibility/speakup/main.c:1290:26: sparse: warning: obsolete array initializer, use C99 syntax
> 
> Fixes: f43241aafedb ("accessibility: speakup: Specify spk_vars among module parameters")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Mushahid Hussain <mushi.shar@gmail.com>
> Cc: William Hubbs <w.d.hubbs@gmail.com>
> Cc: Chris Brannon <chris@the-brannons.com>
> Cc: Kirk Reiser <kirk@reisers.ca>
> Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Cc: speakup@linux-speakup.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Thanks!

> ---
>  drivers/accessibility/speakup/main.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/drivers/accessibility/speakup/main.c b/drivers/accessibility/speakup/main.c
> --- a/drivers/accessibility/speakup/main.c
> +++ b/drivers/accessibility/speakup/main.c
> @@ -1287,7 +1287,7 @@ static struct var_t spk_vars[NB_ID] = {
>  	[PUNC_LEVEL_ID] = { PUNC_LEVEL, .u.n = {NULL, 1, 0, 4, 0, 0, NULL} },
>  	[READING_PUNC_ID] = { READING_PUNC, .u.n = {NULL, 1, 0, 4, 0, 0, NULL} },
>  	[CURSOR_TIME_ID] = { CURSOR_TIME, .u.n = {NULL, 120, 50, 600, 0, 0, NULL} },
> -	[SAY_CONTROL_ID] { SAY_CONTROL, TOGGLE_0},
> +	[SAY_CONTROL_ID] = { SAY_CONTROL, TOGGLE_0},
>  	[SAY_WORD_CTL_ID] = {SAY_WORD_CTL, TOGGLE_0},
>  	[NO_INTERRUPT_ID] = { NO_INTERRUPT, TOGGLE_0},
>  	[KEY_ECHO_ID] = { KEY_ECHO, .u.n = {NULL, 1, 0, 2, 0, 0, NULL} },
> 
