Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8C46C3C5B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjCUU7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCUU7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:59:18 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBEF2CC75;
        Tue, 21 Mar 2023 13:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9q3c6DZ84qERaYxwpBLMMZMDxJrnwUpqZmpXF6Hs6ks=;
  b=nqFkP6g7VrkH6F9TIZQuEyi4wfkMDquj8ZeBCPqQE62fZzKFPB/t3ip8
   O58YVcqMbnHQV7IEILZ/MbN+HnYPzihOvUaByrZiJeE4f0O8FcpchHgoR
   s1ZX/QVdcpKsZUgfS4zT5u/gLNi9II2BsXIWw0vikJ4H7ZVgfLR+aap4O
   s=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,279,1673910000"; 
   d="scan'208";a="50854107"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 21:59:14 +0100
Date:   Tue, 21 Mar 2023 21:59:13 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, vireshk@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: greybus: remove unnecessary blank line
In-Reply-To: <20230321181725.8691-1-eng.mennamahmoud.mm@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2303212158170.2919@hadrien>
References: <20230321181725.8691-1-eng.mennamahmoud.mm@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Mar 2023, Menna Mahmoud wrote:

> Remove unnecessary blank line before struct as reported
> by checkpatch:
>
> " CHECK: Please don't use multiple blank lines "
>
> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
> ---
> change in v2:
> 	add patches that have same edit in sigle patch.
> ---
>  drivers/staging/greybus/greybus_authentication.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/staging/greybus/greybus_authentication.h b/drivers/staging/greybus/greybus_authentication.h
> index 7edc7295b7ab..48b4a9794d3c 100644
> --- a/drivers/staging/greybus/greybus_authentication.h
> +++ b/drivers/staging/greybus/greybus_authentication.h
> @@ -41,7 +41,6 @@
>  #define CAP_AUTH_RESULT_CR_NO_KEY	0x03
>  #define CAP_AUTH_RESULT_CR_SIG_FAIL	0x04
>
> -
>  /* IOCTL support */
>  struct cap_ioc_get_endpoint_uid {
>  	__u8			uid[8];
> --
> 2.34.1
>
>
> From 6f56ebcda89f91cdfe6e64c0707dc476ebc1e819 Mon Sep 17 00:00:00 2001
> From: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
> Date: Tue, 21 Mar 2023 00:03:32 +0200
> Subject: [PATCH v2 2/2] staging: greybus: remove unnecessary blank line

This doesn't look right.  If you put two changes in a single message, you
shouldn't repeat the log message etc.  Use git log -p to look at what
others have done.

julia

>
> Remove unnecessary blank line before struct as reported
> by checkpatch:
>
> " CHECK: Please don't use multiple blank lines "
>
> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
> ---
> change in v2:
>         add patches that have same edit in sigle patch.
> ---
>  drivers/staging/greybus/pwm.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
> index 3fda172239d2..26d39e08c3b6 100644
> --- a/drivers/staging/greybus/pwm.c
> +++ b/drivers/staging/greybus/pwm.c
> @@ -24,7 +24,6 @@ struct gb_pwm_chip {
>  #define pwm_chip_to_gb_pwm_chip(chip) \
>  	container_of(chip, struct gb_pwm_chip, chip)
>
> -
>  static int gb_pwm_count_operation(struct gb_pwm_chip *pwmc)
>  {
>  	struct gb_pwm_count_response response;
> --
> 2.34.1
>
>
>
