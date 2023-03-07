Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BA76AE1F9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjCGOP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjCGOO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:14:57 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34AC888AF;
        Tue,  7 Mar 2023 06:10:59 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id da10so52837841edb.3;
        Tue, 07 Mar 2023 06:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678198232;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nMwIvhw/CtZLY+ptbTUoRQC+a1etWn/yg2z1ztKfgbs=;
        b=NW9cmKnh9Jl40OJEJ5sp+KQCAMPpPXNHX2zc/3+0bNa9wt5dnUK4INlK8tUNbFzXMA
         mLakrIjH0cbSZlFaNJxfINMyjhUH1nezStfay67wWlmbFW4jEwu79M/2e6A0tNOKyShc
         KKvHtU3KLY3eItN5Xel3k02wCCx/vBD6d9oXhqvX15mkl/kmv38TAHKuhiFgZGXKLcF6
         F2Cy2Fy606vuQZPBbTgMv7u2SjMS7AcVRN3HA5e7ylle+8VUgylWlPyEgPvSUng3vVYl
         PwLpSEf8+Z5MB0UzKSiNXE2c7436w0Y54WEY5hSaRxKzSh19B2Z6kPLR0DbB7vhQ7qdV
         iNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678198232;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nMwIvhw/CtZLY+ptbTUoRQC+a1etWn/yg2z1ztKfgbs=;
        b=ZQ6T7NRLOAmIH594KnKoKMQKA5vJrEniBYHjaKyShABIvcj8cp5mYhub3oYAmj4XXh
         I+ddje6/xBzdG0DryynIH1ktNJ0chY2GIrVRhszhFAVgqV2aB5QZlMv3DV55TbDTDoIb
         OixbcUVwCtb3LfQt0kqzM8hF5NJs0ZWoXEaNDoVRBWOG7YHD78KzBhCqADBki8D37boB
         C4BKtFrEPwKUT+Ii69XZEm47A4iHlwZmeOiFWX7tu18EU+Fq0i01mY3ybK9GHy5KJSIZ
         Wr7A3NdeRyi/RB5i8f3bLBLZmE++GicOJCCEVldciWixTFPy1Och6d9gc6MQ+SSG/144
         UB+g==
X-Gm-Message-State: AO0yUKUxEhoIEIpMrH2tNI2dqBOSQyChf85ekadm1T9wFdn11g9nZLGa
        FpO82jYebyMIMuDLtQffL4A=
X-Google-Smtp-Source: AK7set+aBb52NAC13xrM+v54duRdjN0wl3TEwef2LK4yyjd04KNS4pTWCk6cb6N/bBtcul/oU3PbqA==
X-Received: by 2002:a17:906:d0ca:b0:88d:ba89:183a with SMTP id bq10-20020a170906d0ca00b0088dba89183amr17484151ejb.11.1678198232403;
        Tue, 07 Mar 2023 06:10:32 -0800 (PST)
Received: from [192.168.1.10] ([95.43.220.235])
        by smtp.googlemail.com with ESMTPSA id k12-20020a50ce4c000000b004c0459c20f9sm6743662edj.66.2023.03.07.06.10.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Mar 2023 06:10:31 -0800 (PST)
Subject: Re: Motorola Droid 4 -- Stopping charger when battery is full
To:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org,
        martin_rysavy@centrum.cz, phone-devel@vger.kernel.org,
        maemo-leste@lists.dyne.org
References: <ZAcvuP8kmWveLoE/@duo.ucw.cz>
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <ef4409b2-abd8-0eac-f66e-6858c3358cc1@gmail.com>
Date:   Tue, 7 Mar 2023 16:10:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ZAcvuP8kmWveLoE/@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7.03.23 г. 14:36 ч., Pavel Machek wrote:
> Hi!
> 
> I complained that "battery life is very poor" with leste. It seems to
> be combination of several factors.
> 
> 1) I was using very old battery
> 
> 2) My charger is detected as "USB", not as "AC"
> 

And this is because there is no working charger detection in the driver, 
so initial current limit is hard-coded to 500mA.

I was on it, but had to suspend, partially because of 
https://lore.kernel.org/lkml/1668430562-27114-1-git-send-email-ivo.g.dimitrov.75@gmail.com/#r 
, which I will have to fix by other means.

OTOH, I have cpcap-extcon driver around which does charger detection and 
sends the appropriate events, along with cpcap-charger patches that 
properly limit the charger current, however, until the issue in charger 
framework is fixed those are of no use.

Didn't have enough spare time lately to resume the work :(

> 3) Charger was cycling on/off, which was annoying and I often ending
> up dissconnecting the charger
> 
> 4) It probably has a bit higher power consuption than original android
> 
> 5) Android is more aggressive, charges to 4.35V, and allows deeper
> discharge
> 

We can't charge to 4.35 without knowing the type of the battery, 
unfortunately 
https://lore.kernel.org/all/1667332425-12536-1-git-send-email-ivo.g.dimitrov.75@gmail.com/T/#t 
didn't make it, for reasons unknown to me.

Yes, we have that in leste kernel, but I am getting sick of supporting 
out-of-tree patches, so I don't really want to build userspace on kernel 
features that are not upstream, if possible.

Also, some guys have concerns about charging (and keeping it charged) 
@4.35, because of the possibly reduced battery life.

> According to my measurements "CPCAP_REG_CRM_FET_OVRD |
> CPCAP_REG_CRM_FET_CTRL" results in battery discharding and 0A drawn
> frmo the USB.  "CPCAP_REG_CRM_FET_OVRD" is phone powered from USB,
> with battery more or less disconnected (<12mA), which is what we want
> in battery full situation.
> 

What will happen if phone needs to draw more than N mA (N is the set 
charger current limit)?

> Second problem was that phone never really stayed in "battery full",
> immediately exiting it.
> 
> This should solve both issues (plus it enables a lot of
> debugging).
> 

Thanks and regards,
Ivo

> Best regards,
> 								Pavel
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
> index 8bd1abe246cc..af268fc87fbf 100644
> --- a/drivers/power/supply/cpcap-charger.c
> +++ b/drivers/power/supply/cpcap-charger.c
> @@ -10,6 +10,7 @@
>    * Copyright (C) 2009-2010 Motorola, Inc.
>    */
>   
> +#define DEBUG
>   #include <linux/atomic.h>
>   #include <linux/init.h>
>   #include <linux/module.h>
> @@ -410,8 +411,7 @@ static int cpcap_charger_disable(struct cpcap_charger_ddata *ddata)
>   	int error;
>   
>   	error = regmap_update_bits(ddata->reg, CPCAP_REG_CRM, 0x3fff,
> -				   CPCAP_REG_CRM_FET_OVRD |
> -				   CPCAP_REG_CRM_FET_CTRL);
> +				   CPCAP_REG_CRM_FET_OVRD);
>   	if (error)
>   		dev_err(ddata->dev, "%s failed with %i\n", __func__, error);
>   
> @@ -686,8 +686,11 @@ static void cpcap_usb_detect(struct work_struct *work)
>   	if (error)
>   		return;
>   
> +	dev_dbg(ddata->dev, "%d %d %d %d\n", s.chrg_det, s.chrgcurr1, s.chrgcurr2, s.vbusvld);
> +
>   	/* Just init the state if a charger is connected with no chrg_det set */
>   	if (!s.chrg_det && s.chrgcurr1 && s.vbusvld) {
> +	  printk("Just init -- not chrg_det\n");
>   		cpcap_charger_update_state(ddata,
>   					   POWER_SUPPLY_STATUS_NOT_CHARGING);
>   
> @@ -699,6 +702,7 @@ static void cpcap_usb_detect(struct work_struct *work)
>   	 * charged to 4.35V by Android. Try again in 10 minutes.
>   	 */
>   	if (cpcap_charger_get_charge_voltage(ddata) > ddata->voltage) {
> +	  printk("Battery overcharged, wait\n");
>   		cpcap_charger_disconnect(ddata,
>   					 POWER_SUPPLY_STATUS_NOT_CHARGING,
>   					 HZ * 60 * 10);
> @@ -713,14 +717,24 @@ static void cpcap_usb_detect(struct work_struct *work)
>   			break;
>   		new_state = POWER_SUPPLY_STATUS_FULL;
>   
> +		printk("No current -> we are done\n");
> +
>   		if (s.chrgcurr1 && s.vbusvld) {
>   			cpcap_charger_disconnect(ddata, new_state, HZ * 5);
>   			return;
>   		}
>   		break;
>   	case POWER_SUPPLY_STATUS_FULL:
> +		if (s.vbusvld) {
> +			printk("Full, stay full\n");
> +			schedule_delayed_work(&ddata->detect_work, HZ * 10);
> +			return;
> +		}
>   		if (!s.chrgcurr2)
>   			break;
> +
> +		printk("Full but we need to do something\n");
> +
>   		if (s.vbusvld)
>   			new_state = POWER_SUPPLY_STATUS_NOT_CHARGING;
>   		else
> @@ -762,6 +776,7 @@ static void cpcap_usb_detect(struct work_struct *work)
>   		if (!delayed_work_pending(&ddata->ramp_work))
>   			schedule_delayed_work(&ddata->ramp_work, HZ/20);
>   	} else {
> +	  printk("No feeding bus, disabling\n");
>   		ddata->set_current = 0;
>   		error = cpcap_charger_disable(ddata);
>   		if (error)
> 
