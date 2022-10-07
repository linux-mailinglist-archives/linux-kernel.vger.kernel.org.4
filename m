Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3435F7917
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 15:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJGNfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 09:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiJGNfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 09:35:38 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAEC9D51B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 06:35:34 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b4so7369366wrs.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 06:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JplDCaPdcpXfop1zb7dVxKPrP4e+os7PmJQXzlx7wCo=;
        b=flc9tV3iMOC8TfetLbTT2j8mQyS5wRTjK0EwEH9vjMD+FD35yMTwlZ5IXeBe77kbA+
         NFpgip93XtId5kSzqsgNaf7YnS9/GfZAIRbs4grhqDxUfv3bEcxtbtIMLCACXDqNLFA1
         KxaOJlj2U3Ma9F7FXZfRuSqSOTdYjofIBLNoA/FeP9aZ3izTzbZDTbHRAB7exR/2lxev
         LMswoGrSTD/quyClc4sUW7x7JGcHuZE1DcIXbOlkkMsSNjs5B2/e14kO4l3wfIhMTZSn
         VVFDHA0IoVqmQSyBJdv4aaU/lHeojgyyuRHlGBUUzsEAcyO95YB0W/OlBVt2aUg9F74J
         sjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JplDCaPdcpXfop1zb7dVxKPrP4e+os7PmJQXzlx7wCo=;
        b=17dOSj1OQuqikLxqtf0bOHdxCVE6gE+ruXZKyuZwtpbLa4FW4JufNCXNa7zjrFEL7O
         8T7waInzvyylI2M9vfwJE2xoEy5YF5lj/FudVjy1+w/iLxbECv+DGfN8jKryqljWjEam
         FhG8W5xOFcq3MV/mBPXdJOzyiKw4gvj0NMXfp/PclLlzcYoRcBjUV0Nh25wETE9AgNkf
         HfZiRtE+r+c+RMfY/LwmxJGvoURxZF9FQomcpsN+MAH1wrWeq9gXKaLvngWGrdFZCHb2
         AgMsl0xY2zWSN6TvNHjRZQDPyve3M1MiAe48/PlE5yV/+Fj7p3KLHPW/askjCsyV2MNH
         t9Lw==
X-Gm-Message-State: ACrzQf2TSdMz7cySc0vbXAtGqXBp2SFHewjE3YvAYKcEnbCax0gYbahd
        fr4aE83DD/GaUiFPgy6cjTCMyy6sHn2oxA==
X-Google-Smtp-Source: AMsMyM65pNVwULiHDFr2eV6y7VReXSdQyfBqvSHWuh/61HSW/y0sk3hbc7VMwJq3hwgVZ2MD+1UAIQ==
X-Received: by 2002:a5d:5a05:0:b0:22e:5b81:c295 with SMTP id bq5-20020a5d5a05000000b0022e5b81c295mr3273956wrb.588.1665149733086;
        Fri, 07 Oct 2022 06:35:33 -0700 (PDT)
Received: from localhost ([2a01:cb19:85e6:1900:5f1e:d910:dd1e:5b09])
        by smtp.gmail.com with ESMTPSA id fc19-20020a05600c525300b003a342933727sm8375178wmb.3.2022.10.07.06.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 06:35:32 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Eirin Nya <nyanpasu256@gmail.com>, linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Input: Remove redundant field elantech_data::width
In-Reply-To: <20220929082119.22112-3-nyanpasu256@gmail.com>
References: <20220929082119.22112-1-nyanpasu256@gmail.com>
 <20220929082119.22112-3-nyanpasu256@gmail.com>
Date:   Fri, 07 Oct 2022 15:35:31 +0200
Message-ID: <87fsfz7o4c.fsf@mkorpershoek-xps-13-9370.home>
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

On Thu, Sep 29, 2022 at 01:21, Eirin Nya <nyanpasu256@gmail.com> wrote:

> elantech_data::width is copied from elantech_device_info::width, and
> neither is mutated after initialization. So remove the redundant
> variable to prevent future bugs.
>
> Signed-off-by: Eirin Nya <nyanpasu256@gmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

ps: please consider using the proper subject line for input subsystem if
you need to send again.

It should be "Input: elantech - Remove redundant field elantech_data::width"

$ git log --oneline drivers/input/mouse/elantech.c shows:
1d72d9f960cc Input: elantech - fix stack out of bound access in elantech_change_report_id()
be896bd3b72b Input: elantench - fix misreporting trackpoint coordinates
9d383e96448d Input: elantech - Prepare a complete software node for the device

(this is a minor remark, so no need to send a v2 to just change the
subject line)

Cheers
Mattijs

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
> 2.37.3
