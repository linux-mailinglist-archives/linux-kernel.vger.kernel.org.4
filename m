Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395316029BB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 12:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiJRK6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 06:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiJRK6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 06:58:10 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F302818B08
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 03:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DhhW9pDS4OIkDGz8nA4MNC0iz3jv35bQ4UoWTTmzBcs=;
  b=cBDUqDB8oTbAigCLMxmGNLoHmbgNK9HycxTtEiW0w02hY3iHlUNnA0SA
   f8Y+dqoV99lUyMvV4kVhEo/smd1BmIHxWY9K9RC2iC0jeQYaz/kDsC3gs
   hMSLT1stmNoBWXfU7KU1XqsVCTQCSFKlAhGWqEGKChekA8QNF+XVn7zYK
   o=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,193,1661810400"; 
   d="scan'208";a="31750300"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 12:58:08 +0200
Date:   Tue, 18 Oct 2022 12:58:07 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: rts5208: split long line of code
In-Reply-To: <Y06GBWZe+zF+ddD3@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
Message-ID: <1ccf5640-e95d-5138-5146-c45cf136da2b@inria.fr>
References: <Y06GBWZe+zF+ddD3@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Oct 2022, Tanjuate Brunostar wrote:

> Fix checkpatch warning by splitting up a long line of code, improving
> code readability

It doesn't seem like a great solution to break the expression in the
middle of the ().  You could put the whole right hand side expression on
the next line indented with one tab.

julia


>
> Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> ---
>  drivers/staging/rts5208/sd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
> index 4643127a87ca..6503db5bb874 100644
> --- a/drivers/staging/rts5208/sd.c
> +++ b/drivers/staging/rts5208/sd.c
> @@ -4505,7 +4505,8 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
>  				if (CHK_SD(sd_card)) {
>  					retval = reset_sd(chip);
>  					if (retval != STATUS_SUCCESS) {
> -						sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON | SD_SDR_RST);
> +						sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON |
> +								SD_SDR_RST);
>  						goto sd_execute_write_cmd_failed;
>  					}
>  				}
> --
> 2.34.1
>
>
>
