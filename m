Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88C1602B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiJRMMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJRML6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:11:58 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6D860E3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=p9MaN1cNxzsKmUBSvr1168hWuNPIS4qtuoR7aCQsxpU=;
  b=LxsqxbvGaWIxD/unTRxG5cIthVOf+F9Oz0EHw+V2fmvgfY3dEs0ugeEe
   6ZrqdXw1buEUBzN9RVn7822ZoNopi0TJH2VrYs17gJcQzTgK8dKyzP3hu
   Jf1JOFS+0V68YNc6gPaXky+IrrSdwyiwQHoUuDuFajq/0pUKkrotozZCG
   w=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,193,1661810400"; 
   d="scan'208";a="65739145"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 14:11:55 +0200
Date:   Tue, 18 Oct 2022 14:11:54 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v2] staging: rts5208: split long line of code
In-Reply-To: <Y06Vsr7JVvpPem5T@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
Message-ID: <16a2d3ed-8841-ba37-28cb-7dd727fcae6d@inria.fr>
References: <Y06Vsr7JVvpPem5T@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Oct 2022, Tanjuate Brunostar wrote:

> Fix checkpatch warning by splitting up a long line of code, improving
> code readability
>
> Signed-off-by: Tanjuate Brunostar <tanjubrunostar0@gmail.com>

Acked-by: Julia Lawall <julia.lawall@inria.fr>

> ---
>
> v2: Reorganized the line of code by splitting it where it does not break
> the parenthesis as recommended by Julia Lawall
>
>  drivers/staging/rts5208/sd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
> index 4643127a87ca..74c4f476b3a4 100644
> --- a/drivers/staging/rts5208/sd.c
> +++ b/drivers/staging/rts5208/sd.c
> @@ -4505,7 +4505,8 @@ int sd_execute_write_data(struct scsi_cmnd *srb, struct rtsx_chip *chip)
>  				if (CHK_SD(sd_card)) {
>  					retval = reset_sd(chip);
>  					if (retval != STATUS_SUCCESS) {
> -						sd_card->sd_lock_status &= ~(SD_UNLOCK_POW_ON | SD_SDR_RST);
> +						sd_card->sd_lock_status &=
> +							~(SD_UNLOCK_POW_ON | SD_SDR_RST);
>  						goto sd_execute_write_cmd_failed;
>  					}
>  				}
> --
> 2.34.1
>
>
>
