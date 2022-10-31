Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E309613D36
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJaSTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiJaSTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:19:17 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4186F1260C;
        Mon, 31 Oct 2022 11:19:16 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-13bd19c3b68so14319689fac.7;
        Mon, 31 Oct 2022 11:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Han0v1EhipVx7nXZczOxjKPxO/ttPTla8BXRUI4e1t0=;
        b=ZIGCw/I8CRv8qnxHdy2zHqoXF4NhUV92icLrcjFKpOx8SBhmbg+BMqkFQ/BluQ1hnd
         EAemG5Tu7kux/ZPsZMORRotT893ZYH/10qoWz/56otSiQFW9NGEXZdLtVAacJkWtoMQ9
         eJv6J37p/1cxgeoK2j+nmOzfuPv4se9YsSyMDYXYq2xaSq7VhS97r4k3U9FN1clPI53v
         TbdBxI0BuKT/hC7559pb6zYhaLK38kWZxiJJUHBSscyrq5STRZ1VK313T/sRtd9SBVSa
         8qBraYTwhTrkI1WqJspllK2pIlEynjn7zhHrPTyus4LtXb+Qh0P3IFkhNo1sOs32ccHq
         n4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Han0v1EhipVx7nXZczOxjKPxO/ttPTla8BXRUI4e1t0=;
        b=DKITw2xTz0rrw9PoRmd4d50zO9TLo9lvBcHl90T3Aw7TNTQuX8EWpvwCPfDp/vpWf4
         TOFVLjBH4SpTYKdQGJiW61+F1UL1EL4idCRPEEE+QaV9yARQDHkm6iKEuevVkjfxZxwX
         PwuuzPieIzeys918A8S5DL3jRZoxzvEnWfRc/BmnWJFE1wTwS4YDp0DPAwWtrUmdCw8J
         78bLd+eFCIdw8/F5bfEfMJkUt33rbzWm18/CrERk6a4ZHstIBEKb+FU2fcQ+UYE3hy0L
         ZaC1oXmkKmRg/vtHF1yv027tSTmDn5/12XQ1fDxQT5EuXxEmCV3bA6p723ZO1d3bqYj7
         ZRSA==
X-Gm-Message-State: ACrzQf2SHOVi6u2iZfXXoZpV7i38tm2d2Mm4xoENrA6bf6ZfhwA7U/Tc
        AN2SIppBlf9Zd25QAm35GY8egPAI0Rc=
X-Google-Smtp-Source: AMsMyM6ozqYVxjMlPEwFQwgN4h90rZGlLmimbGZJaLGw4qUFywktjtGVa0j6x6mD/1b23gtG6XyHeg==
X-Received: by 2002:a05:6870:e88a:b0:13b:6e13:a9a5 with SMTP id q10-20020a056870e88a00b0013b6e13a9a5mr8230404oan.264.1667240355394;
        Mon, 31 Oct 2022 11:19:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w67-20020acadf46000000b0035770fc6ca9sm2551579oig.16.2022.10.31.11.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 11:19:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 31 Oct 2022 11:19:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>, linux-rtc@vger.kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH] rtc: cros-ec: Limit RTC alarm range if needed
Message-ID: <20221031181913.GA3841664@roeck-us.net>
References: <20221029005400.2712577-1-linux@roeck-us.net>
 <Y2ABnbBGSJGM3gSS@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2ABnbBGSJGM3gSS@mail.local>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 06:10:53PM +0100, Alexandre Belloni wrote:
> Hello,
> 
> On 28/10/2022 17:54:00-0700, Guenter Roeck wrote:
> > RTC chips on some older Chromebooks can only handle alarms less than 24
> > hours in the future. Attempts to set an alarm beyond that range fails.
> > The most severe impact of this limitation is that suspend requests fail
> > if alarmtimer_suspend() tries to set an alarm for more than 24 hours
> > in the future.
> > 
> > Try to set the real-time alarm to just below 24 hours if setting it to
> > a larger value fails to work around the problem. While not perfect, it
> > is better than just failing the call. A similar workaround is already
> > implemented in the rtc-tps6586x driver.
> 
> I'm not super convinced this is actually better than failing the call
> because your are implementing policy in the driver which is bad from a
> user point of view. It would be way better to return -ERANGE and let
> userspace select a better alarm time.

The failing call is from alarmtimer_suspend() which is called during suspend.
It is not from userspace, and userspace has no chance to intervene.

It is also not just one userspace application which could request a large
timeout, it is a variety of userspace applications, and not all of them are
written by Google. Some are Android applications. I don't see how it would be
realistic to expect all such applications to fix their code (if that is even
possible - there might be an application which called sleep(100000) or
something equivalent, which works just fine as long as the system is not
suspended.

> Do you have to know in advance which are the "older" chromebooks that
> are affected?

Not sure I understand the question. Technically we know, but the cros_ec
rtc driver doesn't know because the EC doesn't have an API to report the
maximum timeout to the Linux driver. Even if that existed, it would not
help because the rtc API only supports absolute maximum clock values,
not clock offsets relative to the current time. So ultimately there is no
means for an RTC driver to tell the maximum possible alarm timer offset to 
the RTC subsystem, and there is no means for a user such as
alarmtimer_suspend() to obtain the maximum time offset. Does that answer
your question ?

On a side note, I tried an alternate implementation by adding a retry into
alarmtimer_suspend(), where it would request a smaller timeout if the
requested timeout failed. I did not pursue/submit this since it seemed
hacky. To solve that problem, I'd rather discuss extending the RTC API
to provide a maximum offset to its users. Such a solution would probably
be desirable, but that it more longer term and would not solve the
immediate problem.

If you see a better solution, please let me know. Again, the problem
is that alarmtimer_suspend() fails because the requested timeout is too
large.

Thanks,
Guenter

> 
> > 
> > Drop error messages in cros_ec_rtc_get() and cros_ec_rtc_set() since the
> > calling code also logs an error and to avoid spurious error messages if
> > setting the alarm ultimately succeeds.
> > 
> > Cc: Brian Norris <briannorris@chromium.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/rtc/rtc-cros-ec.c | 35 ++++++++++++++++++++---------------
> >  1 file changed, 20 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/rtc/rtc-cros-ec.c b/drivers/rtc/rtc-cros-ec.c
> > index 887f5193e253..a3ec066d8066 100644
> > --- a/drivers/rtc/rtc-cros-ec.c
> > +++ b/drivers/rtc/rtc-cros-ec.c
> > @@ -14,6 +14,8 @@
> >  
> >  #define DRV_NAME	"cros-ec-rtc"
> >  
> > +#define SECS_PER_DAY	(24 * 60 * 60)
> > +
> >  /**
> >   * struct cros_ec_rtc - Driver data for EC RTC
> >   *
> > @@ -43,13 +45,8 @@ static int cros_ec_rtc_get(struct cros_ec_device *cros_ec, u32 command,
> >  	msg.msg.insize = sizeof(msg.data);
> >  
> >  	ret = cros_ec_cmd_xfer_status(cros_ec, &msg.msg);
> > -	if (ret < 0) {
> > -		dev_err(cros_ec->dev,
> > -			"error getting %s from EC: %d\n",
> > -			command == EC_CMD_RTC_GET_VALUE ? "time" : "alarm",
> > -			ret);
> > +	if (ret < 0)
> >  		return ret;
> > -	}
> >  
> >  	*response = msg.data.time;
> >  
> > @@ -59,7 +56,7 @@ static int cros_ec_rtc_get(struct cros_ec_device *cros_ec, u32 command,
> >  static int cros_ec_rtc_set(struct cros_ec_device *cros_ec, u32 command,
> >  			   u32 param)
> >  {
> > -	int ret = 0;
> > +	int ret;
> >  	struct {
> >  		struct cros_ec_command msg;
> >  		struct ec_response_rtc data;
> > @@ -71,13 +68,8 @@ static int cros_ec_rtc_set(struct cros_ec_device *cros_ec, u32 command,
> >  	msg.data.time = param;
> >  
> >  	ret = cros_ec_cmd_xfer_status(cros_ec, &msg.msg);
> > -	if (ret < 0) {
> > -		dev_err(cros_ec->dev, "error setting %s on EC: %d\n",
> > -			command == EC_CMD_RTC_SET_VALUE ? "time" : "alarm",
> > -			ret);
> > +	if (ret < 0)
> >  		return ret;
> > -	}
> > -
> >  	return 0;
> >  }
> >  
> > @@ -190,8 +182,21 @@ static int cros_ec_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> >  
> >  	ret = cros_ec_rtc_set(cros_ec, EC_CMD_RTC_SET_ALARM, alarm_offset);
> >  	if (ret < 0) {
> > -		dev_err(dev, "error setting alarm: %d\n", ret);
> > -		return ret;
> > +		if (ret == -EINVAL && alarm_offset >= SECS_PER_DAY) {
> > +			/*
> > +			 * RTC chips on some older Chromebooks can only handle
> > +			 * alarms up to 24h in the future. Try to set an alarm
> > +			 * below that limit to avoid suspend failures.
> > +			 */
> > +			ret = cros_ec_rtc_set(cros_ec, EC_CMD_RTC_SET_ALARM,
> > +					      SECS_PER_DAY - 1);
> > +		}
> > +
> > +		if (ret < 0) {
> > +			dev_err(dev, "error setting alarm in %u seconds: %d\n",
> > +				alarm_offset, ret);
> > +			return ret;
> > +		}
> >  	}
> >  
> >  	return 0;
> > -- 
> > 2.36.2
> > 
> 
> -- 
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
