Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F116F5FEE63
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 15:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiJNNKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 09:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiJNNKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 09:10:25 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C875725B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 06:10:16 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l14-20020a05600c1d0e00b003c6ecc94285so27516wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 06:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+xnO2B5cHjyO/AQiFWnb7UyUibEsrm4oL4Nn9hNakaM=;
        b=YsoYCgV5azIHxnfJ2SUOElWvZzhuE0j4AdRJ1Wc5P/ksheRKHFrzdEj+is+Gn1Bw3a
         zKNA+F8cFfcyrnsl3tdWdCcORs52WlVS5y0Ab+cwXRNfnDoakDWEGMoeX1j1Gea9I0LR
         PwdFVS19SMYsgWrF98txnoidhZdcAVtr2DNI+kyMyUCjS8VdpOPtarmNX+I8+lH8ScWO
         HVQ8B3s6TubxFWEI9WpnZywrRQxaIYsq5dyxWJcaGPJxBCv/TAtRgBO9nnXGu2qcBvBH
         O0w6/eKGvewZrQ/m14AWjCw8alGUqKxRbape1elY8DhhjFjPvcvLu21COJJzFsrSSHox
         xqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+xnO2B5cHjyO/AQiFWnb7UyUibEsrm4oL4Nn9hNakaM=;
        b=i5u9D5ienRghGOo/mPWlpwih7ZpXtrhwwisgL24PuTiotFFFUzoEJJNtfZvLryrtKZ
         qHCcMwG7Ganmw8v0A32v4DyeATUCHKBJzT0Xd7RU4NKTAqyGVoKUBSPl6cCaPfwxGfww
         TrfdX5FeOfl5h6aIB/ux+DQfNgPfKfX8aYAQn41W7LxQVzKZs3WZp+QVpq4LtN/km+28
         y6kNL1I8J+71PkHw55p/myIJAO/OLjhJoChYKcrcIQumeKbb8YvT4t47RgXPYXZ3La3t
         6Vb9T4t8FICoaND8T4gxcfWPdWxsXh9hRn8x3ocJsXf8hJBtRtM/sutgqYq4mC3FKS5l
         neag==
X-Gm-Message-State: ACrzQf1fKQVrUu01D+CfAqkkyB7dI6Rwc7x29CMmFvyumf0SUcKxHbs2
        b385WRQ6Xs9QJ7+kuyCJU2A9scuTYe8KTg==
X-Google-Smtp-Source: AMsMyM57BaI6rSU4GH54qmPjLJHUpirV5Zjo/roVmgVgTAKBm6h97wLIXAGwbhfaYDqfnKxWOUe4OQ==
X-Received: by 2002:a05:600c:19d2:b0:3b4:a4cb:2416 with SMTP id u18-20020a05600c19d200b003b4a4cb2416mr3608821wmq.6.1665753014557;
        Fri, 14 Oct 2022 06:10:14 -0700 (PDT)
Received: from localhost ([2a01:cb19:8ae2:e700:f916:30c4:a44d:8229])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c430700b003b492338f45sm1975893wme.39.2022.10.14.06.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 06:10:13 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Eirin Nya <nyanpasu256@gmail.com>, linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Eirin Nya <nyanpasu256@gmail.com>
Subject: Re: [PATCH V2 1/3] Input: elantech - Remove redundant field
 elantech_data::y_max
In-Reply-To: <20221014111533.908-2-nyanpasu256@gmail.com>
References: <20221014111533.908-1-nyanpasu256@gmail.com>
 <20221014111533.908-2-nyanpasu256@gmail.com>
Date:   Fri, 14 Oct 2022 15:10:12 +0200
Message-ID: <87sfjqzh3f.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 04:15, Eirin Nya <nyanpasu256@gmail.com> wrote:

> elantech_data::y_max is copied from elantech_device_info::y_max, and
> neither is mutated after initialization. So remove the redundant
> variable to prevent future bugs when updating y_max.
>
> Signed-off-by: Eirin Nya <nyanpasu256@gmail.com>

Hi Eirin,

Thank you for v2. I know you're new to kernel development so here is
some more "process feedback".

I've already reviewed this in v1:
https://lore.kernel.org/all/87ilkv7ogc.fsf@mkorpershoek-xps-13-9370.home/

After getting a "Reviewed-by" reply on one of the patches, it is
customary to add that in the commit message footer, if the patch is
unchanged. This encourages reviewers and gives them some credit for
their review :)

This is documented at:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#reviewer-s-statement-of-oversight

To quote the doc:
> Both Tested-by and Reviewed-by tags, once received on mailing list from
> tester or reviewer, should be added by author to the applicable patches
> when sending next versions.

So please, if you have to send a v3 at some point, please add:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Note that it's not needed to send a v3 *JUST* to include the trailers.
The maintainer will pick them up if he decides to merge this.

> ---
>  drivers/input/mouse/elantech.c | 17 ++++++++---------
>  drivers/input/mouse/elantech.h |  1 -
>  2 files changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index ece97f8c6a..79e31611fc 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -360,7 +360,7 @@ static void elantech_report_absolute_v1(struct psmouse *psmouse)
>  		input_report_abs(dev, ABS_X,
>  			((packet[1] & 0x0c) << 6) | packet[2]);
>  		input_report_abs(dev, ABS_Y,
> -			etd->y_max - (((packet[1] & 0x03) << 8) | packet[3]));
> +			etd->info.y_max - (((packet[1] & 0x03) << 8) | packet[3]));
>  	}
>  
>  	input_report_key(dev, BTN_TOOL_FINGER, fingers == 1);
> @@ -435,7 +435,7 @@ static void elantech_report_absolute_v2(struct psmouse *psmouse)
>  		 * byte 4:  .   .   .   .  y11 y10 y9  y8
>  		 * byte 5: y7  y6  y5  y4  y3  y2  y1  y0
>  		 */
> -		y1 = etd->y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
> +		y1 = etd->info.y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
>  
>  		pres = (packet[1] & 0xf0) | ((packet[4] & 0xf0) >> 4);
>  		width = ((packet[0] & 0x30) >> 2) | ((packet[3] & 0x30) >> 4);
> @@ -450,7 +450,7 @@ static void elantech_report_absolute_v2(struct psmouse *psmouse)
>  		 */
>  		x1 = (((packet[0] & 0x10) << 4) | packet[1]) << 2;
>  		/* byte 2: ay7 ay6 ay5 ay4 ay3 ay2 ay1 ay0 */
> -		y1 = etd->y_max -
> +		y1 = etd->info.y_max -
>  			((((packet[0] & 0x20) << 3) | packet[2]) << 2);
>  		/*
>  		 * byte 3:  .   .  by8 bx8  .   .   .   .
> @@ -458,7 +458,7 @@ static void elantech_report_absolute_v2(struct psmouse *psmouse)
>  		 */
>  		x2 = (((packet[3] & 0x10) << 4) | packet[4]) << 2;
>  		/* byte 5: by7 by8 by5 by4 by3 by2 by1 by0 */
> -		y2 = etd->y_max -
> +		y2 = etd->info.y_max -
>  			((((packet[3] & 0x20) << 3) | packet[5]) << 2);
>  
>  		/* Unknown so just report sensible values */
> @@ -579,7 +579,7 @@ static void elantech_report_absolute_v3(struct psmouse *psmouse,
>  		 * byte 4:  .   .   .   .  y11 y10 y9  y8
>  		 * byte 5: y7  y6  y5  y4  y3  y2  y1  y0
>  		 */
> -		y1 = etd->y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
> +		y1 = etd->info.y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
>  		break;
>  
>  	case 2:
> @@ -593,7 +593,7 @@ static void elantech_report_absolute_v3(struct psmouse *psmouse,
>  			 * byte 4:   .    .    .    .  ay11 ay10 ay9  ay8
>  			 * byte 5: ay7  ay6  ay5  ay4  ay3  ay2  ay1  ay0
>  			 */
> -			etd->mt[0].y = etd->y_max -
> +			etd->mt[0].y = etd->info.y_max -
>  				(((packet[4] & 0x0f) << 8) | packet[5]);
>  			/*
>  			 * wait for next packet
> @@ -605,7 +605,7 @@ static void elantech_report_absolute_v3(struct psmouse *psmouse,
>  		x1 = etd->mt[0].x;
>  		y1 = etd->mt[0].y;
>  		x2 = ((packet[1] & 0x0f) << 8) | packet[2];
> -		y2 = etd->y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
> +		y2 = etd->info.y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
>  		break;
>  	}
>  
> @@ -681,7 +681,7 @@ static void process_packet_head_v4(struct psmouse *psmouse)
>  		return;
>  
>  	etd->mt[id].x = ((packet[1] & 0x0f) << 8) | packet[2];
> -	etd->mt[id].y = etd->y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
> +	etd->mt[id].y = etd->info.y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
>  	pres = (packet[1] & 0xf0) | ((packet[4] & 0xf0) >> 4);
>  	traces = (packet[0] & 0xf0) >> 4;
>  
> @@ -1253,7 +1253,6 @@ static int elantech_set_input_params(struct psmouse *psmouse)
>  		input_abs_set_res(dev, ABS_MT_POSITION_Y, info->y_res);
>  	}
>  
> -	etd->y_max = y_max;
>  	etd->width = width;
>  
>  	return 0;
> diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h
> index 571e6ca11d..1ec004f72d 100644
> --- a/drivers/input/mouse/elantech.h
> +++ b/drivers/input/mouse/elantech.h
> @@ -180,7 +180,6 @@ struct elantech_data {
>  	unsigned char reg_25;
>  	unsigned char reg_26;
>  	unsigned int single_finger_reports;
> -	unsigned int y_max;
>  	unsigned int width;
>  	struct finger_pos mt[ETP_MAX_FINGERS];
>  	unsigned char parity[256];
> -- 
> 2.38.0
