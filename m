Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267FB5BD4F0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 20:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiISSwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 14:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiISSwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 14:52:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D89474F9;
        Mon, 19 Sep 2022 11:52:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C97DB81C77;
        Mon, 19 Sep 2022 18:52:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA087C433C1;
        Mon, 19 Sep 2022 18:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663613567;
        bh=JOyL5K3R0pkuI91FVBSM3RBsiKf6umeMWzuCrM4BNNE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YpsOZXp3+O2C6CRnrV2Dr6ouNYoswa+XWf5iRj5pfMcFNNAJ9Y0mYvxEjoR6nDsS4
         xCO5PzECHQbDpzHupaxYldMVW7xoFFAVAflWg/4dBFnGsbwFGf3q3hZoJYWqeC8PKt
         ekyxTC3XeRSmCt+xzq7CcraaKHRrg80YfIkF3MA1ytx9dd5nSzUkFzVGokmrCkn0BR
         JLWluZ75bKidKHn2Fy1mith1Tq6iWRojI163rVC3wC3/p0Pq2Jza/sulWM83CjTB5Q
         poJy9DVu5ItFNFddqDwxjtC+eX355hc3Eq1fQzabwhAUpuab8pnTzol6YKdjIX/jJ+
         KV303wAhh3itQ==
Received: by mail-ed1-f47.google.com with SMTP id z2so598184edi.1;
        Mon, 19 Sep 2022 11:52:47 -0700 (PDT)
X-Gm-Message-State: ACrzQf2gx0EVdxOYCI8wTB/dJgmiLeeYUrDW8jopksDWu7nlLkX9npCc
        F8e6jAb/rBmOCAcf/oWgucykKNsSPWMJK2/IwwA=
X-Google-Smtp-Source: AMsMyM7PYN7AvN4VHg32FZ8g+Moe6Pj9E4dz1bfXEAP85QXTPLOkgA/KWb9H5frB2qNwmM0eewtV68wH7atpbvZoPkg=
X-Received: by 2002:a05:6402:11d4:b0:452:a97c:cd36 with SMTP id
 j20-20020a05640211d400b00452a97ccd36mr17078119edw.53.1663613566067; Mon, 19
 Sep 2022 11:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220831032915.87297-1-zhounan@nfschina.com>
In-Reply-To: <20220831032915.87297-1-zhounan@nfschina.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 19 Sep 2022 11:52:34 -0700
X-Gmail-Original-Message-ID: <CAPhsuW64vLfGUGOPjnQx-D7=qh7yFL=yvfWUTPn7teCegLeZaQ@mail.gmail.com>
Message-ID: <CAPhsuW64vLfGUGOPjnQx-D7=qh7yFL=yvfWUTPn7teCegLeZaQ@mail.gmail.com>
Subject: Re: [PATCH] dm: Fix spelling mistake in comments
To:     zhoun <zhounan@nfschina.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 8:30 PM zhoun <zhounan@nfschina.com> wrote:
>
> From: zhounan <zhounan@nfschina.com>
>
> Fix spelling of dones't in comments.
>
> Signed-off-by: zhounan <zhounan@nfschina.com>

Please use your full name in the commit log. Also, please update the commit
message with more specific information, like:

md: Fix spelling mistake in comments of r5l_log

Fix spelling of "dones't" in comments.

Thanks,
Song

> ---
>  drivers/md/raid5-cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
> index f4e1cc1ece43..683fd4adde17 100644
> --- a/drivers/md/raid5-cache.c
> +++ b/drivers/md/raid5-cache.c
> @@ -125,7 +125,7 @@ struct r5l_log {
>                                          * reclaimed.  if it's 0, reclaim spaces
>                                          * used by io_units which are in
>                                          * IO_UNIT_STRIPE_END state (eg, reclaim
> -                                        * dones't wait for specific io_unit
> +                                        * doesn't wait for specific io_unit
>                                          * switching to IO_UNIT_STRIPE_END
>                                          * state) */
>         wait_queue_head_t iounit_wait;
> --
> 2.27.0
>
