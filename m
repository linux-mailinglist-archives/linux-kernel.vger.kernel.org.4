Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDA35F881B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 00:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiJHWNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 18:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJHWN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 18:13:27 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FA330F54;
        Sat,  8 Oct 2022 15:13:25 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id f140so7828930pfa.1;
        Sat, 08 Oct 2022 15:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=YI0HJ5tPvJ1TvzxpwTo7HJCWsrcuv34fHasgM7CRfmo=;
        b=UW/jH3FcFjdmT4iCftASdFBszssRdZ93PU/cor8nyE164CFv7AHRVKXbGE3+gknilC
         Bk7tfjPfUWToyuUQ7kVVTVkN8nKWoQH56eLNR2YjUpDayPAUH2sDQhynA9Gz6MbXn16o
         cDwF3Y9lGF9EA+Wsvg8TikGo6BbYJHvpLQDqCEXsqNQb6EoEui3gJ1cRJH8sjmMQpEAw
         gFTo6hDE5jJQl0If5W1JoTYoyfyG0UwHFOgON+uIG4YjpliLC+m0TWH26t/SApS9+huz
         5wwuAj3dJ+kqbFc19UZc9mubJIbmCOmQ69epUZFMVAABAO+7/WLv5yBrO0xGZ7i8wGMd
         1bRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YI0HJ5tPvJ1TvzxpwTo7HJCWsrcuv34fHasgM7CRfmo=;
        b=MucmiJ6fpN4WxuLXTu3igrh/tuFmWap8aDAexaYJBIP7u7kUugNm8AXuMFdJ0hRh1d
         vkLja9NpFsBqsytayNQ2K1p+HfWozN15P8CCghtR7e5MqsXYoiWlsCE1Jd6GfyTHowwX
         PlUwJYgKxY6UXeo7Dvp/ZMaxKu90rdbvRAKOJuwG4SsWV9HWGL5zGCu6LXbZTSarbzii
         3naVUT6MQHrgpMeaEr6CupE6OvDsAuSzmzPY7iQgSeRX2AQjQrHarKbPVMXr4Kg6wn42
         yKxBqBaf+EPLWwrCybT4Sm3pbTAGle57bYAyD4Osm7dwxASUZ5InvQ2ZCKQy1yM4hoXL
         XQTw==
X-Gm-Message-State: ACrzQf0sscv86PLHxIBmU1SycuNz55EwnNlwpS0cRajqsK1SYtVwOWks
        f/IDV0aszUheqrp1Bx7EodU2K4C65lgSpw==
X-Google-Smtp-Source: AMsMyM759z/1F3HaLemRIQcd+GnBux4LVGCOKPHJq4WiRb+A26ZRegzRkm+baf6PKhkydDmdjpzr6A==
X-Received: by 2002:a63:194b:0:b0:457:7295:8de0 with SMTP id 11-20020a63194b000000b0045772958de0mr10432162pgz.612.1665267205180;
        Sat, 08 Oct 2022 15:13:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i8-20020a170902c94800b0017f5c7d3931sm3801835pla.282.2022.10.08.15.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Oct 2022 15:13:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <16ab4e96-756c-bd00-5275-0d8d03e233fc@roeck-us.net>
Date:   Sat, 8 Oct 2022 15:13:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] watchdog: Add tracing events for the most usual
 watchdog events
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-watchdog@vger.kernel.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org
References: <20221008174602.3972859-1-u.kleine-koenig@pengutronix.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221008174602.3972859-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/22 10:46, Uwe Kleine-König wrote:
> To simplify debugging which process touches a watchdog and when, add
> tracing events for .start(), .set_timeout(), .ping() and .stop().
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes since v2 sent with Message-Id:
> 20221004091950.3419662-1-u.kleine-koenig@pengutronix.de:
> 
>   - Reorder events in the header to have all DEFINE_EVENTS near their
>     DECLARE_EVENT_CLASS.
> 
> Changes since (implict) v1 sent with Message-Id:
> 20220930144935.3373366-1-u.kleine-koenig@pengutronix.de:
> 
>   - Make use of DECLARE_EVENT_CLASS as {requ,sugg}ested by Steven.
> 
>   MAINTAINERS                      |  1 +
>   drivers/watchdog/watchdog_core.c |  4 ++
>   drivers/watchdog/watchdog_dev.c  | 12 +++++-
>   include/trace/events/watchdog.h  | 66 ++++++++++++++++++++++++++++++++
>   4 files changed, 81 insertions(+), 2 deletions(-)
>   create mode 100644 include/trace/events/watchdog.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 72b9654f764c..507de599116b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21890,6 +21890,7 @@ F:	Documentation/watchdog/
>   F:	drivers/watchdog/
>   F:	include/linux/watchdog.h
>   F:	include/uapi/linux/watchdog.h
> +F:	include/trace/events/watchdog.h
>   
>   WHISKEYCOVE PMIC GPIO DRIVER
>   M:	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> index 3fe8a7edc252..c777a612d932 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -38,6 +38,9 @@
>   
>   #include "watchdog_core.h"	/* For watchdog_dev_register/... */
>   
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/watchdog.h>
> +
>   static DEFINE_IDA(watchdog_ida);
>   
>   static int stop_on_reboot = -1;
> @@ -163,6 +166,7 @@ static int watchdog_reboot_notifier(struct notifier_block *nb,
>   			int ret;
>   
>   			ret = wdd->ops->stop(wdd);
> +			trace_watchdog_stop(wdd, ret);
>   			if (ret)
>   				return NOTIFY_BAD;
>   		}
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 54903f3c851e..3323309c913c 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -47,6 +47,8 @@
>   #include "watchdog_core.h"
>   #include "watchdog_pretimeout.h"
>   
> +#include <trace/events/watchdog.h>
> +
>   /* the dev_t structure to store the dynamically allocated watchdog devices */
>   static dev_t watchdog_devt;
>   /* Reference to watchdog device behind /dev/watchdog */
> @@ -157,10 +159,13 @@ static int __watchdog_ping(struct watchdog_device *wdd)
>   
>   	wd_data->last_hw_keepalive = now;
>   
> -	if (wdd->ops->ping)
> +	if (wdd->ops->ping) {
>   		err = wdd->ops->ping(wdd);  /* ping the watchdog */
> -	else
> +		trace_watchdog_ping(wdd, err);
> +	} else {
>   		err = wdd->ops->start(wdd); /* restart watchdog */
> +		trace_watchdog_start(wdd, err);
> +	}
>   
>   	if (err == 0)
>   		watchdog_hrtimer_pretimeout_start(wdd);
> @@ -259,6 +264,7 @@ static int watchdog_start(struct watchdog_device *wdd)
>   		}
>   	} else {
>   		err = wdd->ops->start(wdd);
> +		trace_watchdog_start(wdd, err);
>   		if (err == 0) {
>   			set_bit(WDOG_ACTIVE, &wdd->status);
>   			wd_data->last_keepalive = started_at;
> @@ -297,6 +303,7 @@ static int watchdog_stop(struct watchdog_device *wdd)
>   	if (wdd->ops->stop) {
>   		clear_bit(WDOG_HW_RUNNING, &wdd->status);
>   		err = wdd->ops->stop(wdd);
> +		trace_watchdog_stop(wdd, err);
>   	} else {
>   		set_bit(WDOG_HW_RUNNING, &wdd->status);
>   	}
> @@ -369,6 +376,7 @@ static int watchdog_set_timeout(struct watchdog_device *wdd,
>   
>   	if (wdd->ops->set_timeout) {
>   		err = wdd->ops->set_timeout(wdd, timeout);
> +		trace_watchdog_set_timeout(wdd, timeout, err);
>   	} else {
>   		wdd->timeout = timeout;
>   		/* Disable pretimeout if it doesn't fit the new timeout */
> diff --git a/include/trace/events/watchdog.h b/include/trace/events/watchdog.h
> new file mode 100644
> index 000000000000..beb9bb3424c8
> --- /dev/null
> +++ b/include/trace/events/watchdog.h
> @@ -0,0 +1,66 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM watchdog
> +
> +#if !defined(_TRACE_WATCHDOG_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_WATCHDOG_H
> +
> +#include <linux/watchdog.h>
> +#include <linux/tracepoint.h>
> +
> +DECLARE_EVENT_CLASS(watchdog_template,
> +
> +	TP_PROTO(struct watchdog_device *wdd, int err),
> +
> +	TP_ARGS(wdd, err),
> +
> +	TP_STRUCT__entry(
> +		__field(int, id)
> +		__field(int, err)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->id = wdd->id;
> +		__entry->err = err;
> +	),
> +
> +	TP_printk("watchdog%d err=%d", __entry->id, __entry->err)
> +);
> +
> +DEFINE_EVENT(watchdog_template, watchdog_start,
> +	TP_PROTO(struct watchdog_device *wdd, int err),
> +	TP_ARGS(wdd, err));
> +
> +DEFINE_EVENT(watchdog_template, watchdog_ping,
> +	TP_PROTO(struct watchdog_device *wdd, int err),
> +	TP_ARGS(wdd, err));
> +
> +DEFINE_EVENT(watchdog_template, watchdog_stop,
> +	TP_PROTO(struct watchdog_device *wdd, int err),
> +	TP_ARGS(wdd, err));
> +
> +TRACE_EVENT(watchdog_set_timeout,
> +
> +	TP_PROTO(struct watchdog_device *wdd, unsigned int timeout, int err),
> +
> +	TP_ARGS(wdd, timeout, err),
> +
> +	TP_STRUCT__entry(
> +		__field(int, id)
> +		__field(unsigned int, timeout)
> +		__field(int, err)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->id = wdd->id;
> +		__entry->timeout = timeout;
> +		__entry->err = err;
> +	),
> +
> +	TP_printk("watchdog%d timeout=%u err=%d", __entry->id, __entry->timeout, __entry->err)
> +);
> +
> +#endif /* !defined(_TRACE_WATCHDOG_H) || defined(TRACE_HEADER_MULTI_READ) */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> 
> base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f

