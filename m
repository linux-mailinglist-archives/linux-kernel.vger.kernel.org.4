Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960545FEE70
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 15:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJNNOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 09:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJNNOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 09:14:11 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EF21CD694
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 06:14:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j7so7527342wrr.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 06:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ttfwpv3od4S8wuyU5OU4GrW6tNlN69ASPbVjG9BX2oE=;
        b=s9kOzNpa4pwS7IERtn9V6HweVHpclzhghK6AmcLrEl3aonb33oHwFFsOosrJFyS9wn
         gfdzCLeSmBiMzMz/2JXXCSG9ntYCI0HN+Nyvhg1k86DqweRrYLCFu2Z5hfoAiBaR3pMb
         F6x+JEtO3Rq3iuP9lk64eXss3GwmNqP24H5dRuK6wXANlzEBpru9GQXYD96RvBs6glm6
         g89xDaJ+1AyzjZa0KLEDr3VeKLvVSTRVGE9pbZnpFlPaUULp3DEwJoAgosZE0UdHKBlE
         bD7tQ57JU1G5kfcJu+3mXS89BDA5V+yMcY62v6s/T6z0azhz/gpwtRMwtsDeUxRJhWrv
         wT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ttfwpv3od4S8wuyU5OU4GrW6tNlN69ASPbVjG9BX2oE=;
        b=zD3u4Qj73GEj48zUHrmCaafbjVk5mALZmhAyeisF3kZBI71dhS2dYrl43NNqSL01lY
         qcuXn41AIu6TSmImcC3cyesH8wUkMbO80eUk4GRCSqxwyFN488NTFU6sgMhUsDXwS1LC
         a74XnvB76agm5QXh1UzdRT2tANNzaD5qql/pl/uv7oFMuwZTzIYGvcAdqdoFp098Z15/
         OeqNR55HapHQtClMmJmq8wBCpRM3NgC+wXc7ZACHWPymzt/Omu0xNYtnayLnJ68Nzi8I
         KLmenWQCYbQ2MjH+FLbgIYdlvsRONv35I+OREatAzyBc8f3cu9VArnlaKEWjitJmInQF
         PUKg==
X-Gm-Message-State: ACrzQf3nMaPvzM7tjsDuze/PuZ1FnJJC1RyUKRTvesBSOR0Udd9pzdBn
        WNgCpDJFHnCxuE005OZWdS0KPg==
X-Google-Smtp-Source: AMsMyM4/cUSu2+HrIIlq1ZDBS5vTlvzzOt2skk2AMy8jVwKHZRSJ8FryPuAOXpGYfGEHQGZAEsn7uQ==
X-Received: by 2002:adf:e549:0:b0:22d:b410:d0ed with SMTP id z9-20020adfe549000000b0022db410d0edmr3518701wrm.633.1665753247976;
        Fri, 14 Oct 2022 06:14:07 -0700 (PDT)
Received: from localhost ([2a01:cb19:8ae2:e700:f916:30c4:a44d:8229])
        by smtp.gmail.com with ESMTPSA id m18-20020a056000009200b0022e0580b7a9sm1915765wrx.17.2022.10.14.06.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 06:14:07 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Eirin Nya <nyanpasu256@gmail.com>, linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Eirin Nya <nyanpasu256@gmail.com>
Subject: Re: [PATCH V2 2/3] Input: elantech - Remove redundant field
 elantech_data::width
In-Reply-To: <20221014111533.908-3-nyanpasu256@gmail.com>
References: <20221014111533.908-1-nyanpasu256@gmail.com>
 <20221014111533.908-3-nyanpasu256@gmail.com>
Date:   Fri, 14 Oct 2022 15:14:06 +0200
Message-ID: <87o7uezgwx.fsf@baylibre.com>
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

> elantech_data::width is copied from elantech_device_info::width, and
> neither is mutated after initialization. So remove the redundant
> variable to prevent future bugs.
>
> Signed-off-by: Eirin Nya <nyanpasu256@gmail.com>

Same remark as for patch v2 1/3: I already reviewed v1.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/input/mouse/elantech.c | 4 +---
>  drivers/input/mouse/elantech.h | 1 -
>  2 files changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 79e31611fc..263779c031 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -691,7 +691,7 @@ static void process_packet_head_v4(struct psmouse *psmouse)
>  	input_report_abs(dev, ABS_MT_POSITION_X, etd->mt[id].x);
>  	input_report_abs(dev, ABS_MT_POSITION_Y, etd->mt[id].y);
>  	input_report_abs(dev, ABS_MT_PRESSURE, pres);
> -	input_report_abs(dev, ABS_MT_TOUCH_MAJOR, traces * etd->width);
> +	input_report_abs(dev, ABS_MT_TOUCH_MAJOR, traces * etd->info.width);
>  	/* report this for backwards compatibility */
>  	input_report_abs(dev, ABS_TOOL_WIDTH, traces);
>  
> @@ -1253,8 +1253,6 @@ static int elantech_set_input_params(struct psmouse *psmouse)
>  		input_abs_set_res(dev, ABS_MT_POSITION_Y, info->y_res);
>  	}
>  
> -	etd->width = width;
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h
> index 1ec004f72d..fb093134ea 100644
> --- a/drivers/input/mouse/elantech.h
> +++ b/drivers/input/mouse/elantech.h
> @@ -180,7 +180,6 @@ struct elantech_data {
>  	unsigned char reg_25;
>  	unsigned char reg_26;
>  	unsigned int single_finger_reports;
> -	unsigned int width;
>  	struct finger_pos mt[ETP_MAX_FINGERS];
>  	unsigned char parity[256];
>  	struct elantech_device_info info;
> -- 
> 2.38.0
