Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828055F78F8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 15:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiJGN2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 09:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiJGN2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 09:28:24 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675BAD8EE0
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 06:28:22 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a10so7286518wrm.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 06:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+NhJXIBatYo7vmxUfSCkvyd6QtE5/cJnLsB7ZobvAfI=;
        b=ofe98FyuQKGMglUfrhbthGpSUXbPUQ3ihQ0ni94nCqilwncChj9IHcMPPndQi27NU6
         V8CKg5T0BBxGdAhe9q6OAu6lfdIlcpmzZ4lDH/yzGEUsInuDbpnCkjJ4tNcRFrNHguAl
         0LddeJnGmItnob4p4+pVBwOCNDDual2xxrNTpAZhxTs1NybDTBlw5JU+0N3F8Cq6/UcH
         J74xPT8lRpjTriYM6j37S2m1PWMnwhqiA4ViiazUzRmKkPaQZ4CLLwVvd9ogeCX2y/au
         1Gj+Q1MkKAxuxS4RQl7mIL7Ca1tuKqwLfzIDihwS2WBDtIWfYMzLFxHLjjmijR+77B5o
         7mFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+NhJXIBatYo7vmxUfSCkvyd6QtE5/cJnLsB7ZobvAfI=;
        b=CmhUhZYPDRgBzieoXuwGE2EOtiFafXZLWpS7pAEXYcRzhW2MDtpL+GslcH1LB2adjk
         n7F9bqkmz7plcEiPMh8xyYGgYVV87KtvZxUpUtNqtUxmfJ0RnZDpm/icOR460ziCm4sa
         aTo5ZvKCvQdrwxT13J3zBULQXYDc90GElQ6EH+Gs9lQVZontGKU7FZrZLiINIdlXdjJX
         5373nFqf1wp9R2FNq9HbD9jNC4MaIc6fWBI/xe+dCQUgEQlQO0tbzuT3XeiYnzJ3M2ZI
         gwAWNX0V7CpRHCTkCYUkCnTGNOzGoByv9gMdf1jN4K1+GhZgnQm5ZDITl9bJ4PFjEJA9
         AazQ==
X-Gm-Message-State: ACrzQf2yUvXxokCPRMg1ttI+YqXIqZ5kC4w/GwnhOy2MXXW1ya8c3/K7
        /RS88Sfr2zogmBeg86Eih/eMCA==
X-Google-Smtp-Source: AMsMyM7KHRjsb7VNPG1/2OrIL453nCw6i8GA+IY9RFDjEsotOk3ij3/WI8siVeGN6kTiY75pM8s+CQ==
X-Received: by 2002:a5d:6d08:0:b0:22c:cf20:387d with SMTP id e8-20020a5d6d08000000b0022ccf20387dmr3288288wrq.518.1665149300416;
        Fri, 07 Oct 2022 06:28:20 -0700 (PDT)
Received: from localhost ([2a01:cb19:85e6:1900:5f1e:d910:dd1e:5b09])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d6805000000b002285f73f11dsm2585914wru.81.2022.10.07.06.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 06:28:19 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Eirin Nya <nyanpasu256@gmail.com>, linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Input: Remove redundant field elantech_data::y_max
In-Reply-To: <20220929082119.22112-2-nyanpasu256@gmail.com>
References: <20220929082119.22112-1-nyanpasu256@gmail.com>
 <20220929082119.22112-2-nyanpasu256@gmail.com>
Date:   Fri, 07 Oct 2022 15:28:19 +0200
Message-ID: <87ilkv7ogc.fsf@mkorpershoek-xps-13-9370.home>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eirin,

Thank you for your patch.

On Thu, Sep 29, 2022 at 01:21, Eirin Nya <nyanpasu256@gmail.com> wrote:

> elantech_data::y_max is copied from elantech_device_info::y_max, and
> neither is mutated after initialization. So remove the redundant
> variable to prevent future bugs when updating y_max.
>
> Signed-off-by: Eirin Nya <nyanpasu256@gmail.com>
> ---
>  drivers/input/mouse/elantech.c | 17 ++++++++---------
>  drivers/input/mouse/elantech.h |  1 -
>  2 files changed, 8 insertions(+), 10 deletions(-)

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

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
> 2.37.3
