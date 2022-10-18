Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F6B602927
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 12:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiJRKMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 06:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiJRKLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 06:11:48 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A4BB44B7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 03:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tS6BWBUrnejx8i/lfHhcT9xT1zy7thoRi0nOLDBaOZE=;
  b=X0bew/e1poIE1jnzYyicDMShwkznn8L5uPNKishaYuVtqphnKEq4bPsa
   vWjlF3ZcEqCD2y8+gqOIUdnjbhoff4cRH10Wm5yBTFZU6e+mr3OHUjjBG
   xgYtbOa1zPVt0e1JCWpnUgCe7h9F5cP9pa32w1UjYxXW6PzDPa0EI+k1l
   8=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,193,1661810400"; 
   d="scan'208";a="31745818"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 12:11:21 +0200
Date:   Tue, 18 Oct 2022 12:11:20 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH] [PATCH] staging: rts5208: merge unnecessary split line
In-Reply-To: <Y0550VcHI8NzFzzf@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
Message-ID: <3f65f367-e07f-5b71-ea7c-4f13c23eca8d@inria.fr>
References: <Y0550VcHI8NzFzzf@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
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

> Fix checkpatch warning by merging unnecessary split line in order to
> avoid ending a line of code with a "(". The resulting code does
> not affect readability and is well within the code-style guidelines

Thanks for the patch.

You don't need the extra [PATCH] in the subject line.

Actually, you don't need the parentheses at all, but that might be a
matter of personal taste.

julia

>
> Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>
> ---
>  drivers/staging/rts5208/sd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
> index d1fafd530c80..4643127a87ca 100644
> --- a/drivers/staging/rts5208/sd.c
> +++ b/drivers/staging/rts5208/sd.c
> @@ -4501,8 +4501,7 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
>  			sd_card->sd_lock_notify = 1;
>  			if (sd_lock_state &&
>  			    (sd_card->sd_lock_status & SD_LOCK_1BIT_MODE)) {
> -				sd_card->sd_lock_status |= (
> -					SD_UNLOCK_POW_ON | SD_SDR_RST);
> +				sd_card->sd_lock_status |= (SD_UNLOCK_POW_ON | SD_SDR_RST);
>  				if (CHK_SD(sd_card)) {
>  					retval = reset_sd(chip);
>  					if (retval != STATUS_SUCCESS) {
> --
> 2.34.1
>
>
>
