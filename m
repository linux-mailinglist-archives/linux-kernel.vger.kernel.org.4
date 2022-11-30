Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC93A63DD0A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiK3SVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiK3SUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:20:46 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7338C44B;
        Wed, 30 Nov 2022 10:19:07 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-143ffc8c2b2so3187132fac.2;
        Wed, 30 Nov 2022 10:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cHc8osP6nOL4VANAt9RWDDPr/HPatvzkgz+MmrJXVG0=;
        b=piCufh4dDMgN9f7ueX290rpWBJGUrZGhWgMGeLELZK7v39FcdPAGKLf0pnIM7LvMz+
         k9kDftCEf8eG/UMQXMHk3wRfrIgUr2NRVnC/R6fkUfGvuoMUclkkZ2lJmbVYszrIj1PD
         0qgYUX9Vq9qZMvQYFnKMCXa4/ZslWQGwXEM+IA0vxOFAWwnQel4Cf4WyT7mxWncmaB/f
         oi9uA37dU/N1HiysUCcnwEwrmGAJkVQsim+8oxZEeOg0/vfKzexS16vpl9hEQia4j+nP
         IkncHjOx48EgPMiIheA+jsE6Xcq9FGn/K5MgIwmXQfryP3/Ob08lXYQldbrT/kMFsHxW
         29oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHc8osP6nOL4VANAt9RWDDPr/HPatvzkgz+MmrJXVG0=;
        b=78hb687lurruzDtk6ikZN6SJoUg60WdMB5g0gYXGdJ+31bHbYv/Jdz+JXeC1tCs/Dv
         196ldDjDJ4io+QI2mLrWE4kuE7RnkUwP7QVwfb2uQ6+tXUcpA7YZO9/DY84vlukzgzfU
         //a9vQknUOHKn7mS1ABoH6KN0k6t6WOTZvB2mhjD9BEUeiLhXWKhvdYnuEdyk+70safc
         XAW2ITQ6up2nszJOSBHBvjMo87D6cBKZxbtw/4KG0emAjWyQH/JjmZsGVINvS+kfAK9a
         l3YCdxBRTNmFyFIktsG7RsvAKI6LYqj5twIqltDsp9viCkZU9KDFy1VXlQEUtZD86TwZ
         QjlA==
X-Gm-Message-State: ANoB5pnx4GzxH4mFuWlej1O8hoUirckWOtzbIpY7poex446jEAN7Ktkk
        3cy1LzOAv3r4aIvojoSmTvI=
X-Google-Smtp-Source: AA0mqf5yWODVfTrEp0yAYw9lc9wvPwckTUfPpBTZs1CqM07ZgYyUG1jZo+VSfdIXHFcbqRblv3eMpQ==
X-Received: by 2002:a05:6870:797:b0:12c:e772:2424 with SMTP id en23-20020a056870079700b0012ce7722424mr27851969oab.176.1669832347047;
        Wed, 30 Nov 2022 10:19:07 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t26-20020a05683014da00b0066cb9069e0bsm1228177otq.42.2022.11.30.10.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 10:19:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 30 Nov 2022 10:19:05 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v3 1/4] hwmon: (pmbus/core): Add status byte to regulator
 flag map
Message-ID: <20221130181905.GA2658232@roeck-us.net>
References: <20221130165833.3478555-1-Naresh.Solanki@9elements.com>
 <20221130180642.GA2656856@roeck-us.net>
 <b6f0a393-0715-1541-631d-5b98c0d7b155@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6f0a393-0715-1541-631d-5b98c0d7b155@9elements.com>
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

On Wed, Nov 30, 2022 at 11:42:32PM +0530, Naresh Solanki wrote:
> Hi,
> 
> On 30-11-2022 11:36 pm, Guenter Roeck wrote:
> > On Wed, Nov 30, 2022 at 05:58:28PM +0100, Naresh Solanki wrote:
> > > Add PMBus status byte to regulator flag map.
> > > 
> > > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > > 
> > > ---
> > > Changes:
> > > - Remove status input
> > 
> > Not really.
> > 
> This was about PMBUS_STATUS_INPUT & not STATUS_BYTE
> > > - Add comment for PMBUS status byte.
> > > ---
> > >   drivers/hwmon/pmbus/pmbus_core.c | 20 +++++++++++---------
> > >   1 file changed, 11 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> > > index 95e95783972a..a7b4ae0f1f3b 100644
> > > --- a/drivers/hwmon/pmbus/pmbus_core.c
> > > +++ b/drivers/hwmon/pmbus/pmbus_core.c
> > > @@ -2751,7 +2751,16 @@ struct pmbus_regulator_status_category {
> > >   };
> > >   static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] = {
> > > -	{
> > > +	{	/* STATUS byte is always present. */
> > > +		.func = -1,
> > > +		.reg = PMBUS_STATUS_BYTE,
> > > +		.bits = (const struct pmbus_regulator_status_assoc[]) {
> > > +			{ PB_STATUS_IOUT_OC,   REGULATOR_ERROR_OVER_CURRENT },
> > > +			{ PB_STATUS_VOUT_OV,   REGULATOR_ERROR_REGULATION_OUT },
> > > +			{ PB_STATUS_VIN_UV,    REGULATOR_ERROR_UNDER_VOLTAGE },
> > 
> > Still there.
> > 
> STATUS_INPUT remove & STATUS_BYTE retained.

You added a check for PB_STATUS_VIN_UV which reports an input failure
which was not reported before. You do so silently without mentioning the
change in the description. In the change log you claim "Remove status input".
Yet, the above adds reporting on an input voltage error. Maybe the
change log was supposed to refer to the input status register, but that
doesn't mean you can silently add a check for PB_STATUS_VIN_UV.

Guenter

> > > +			{ },
> > > +		},
> > > +	}, {
> > >   		.func = PMBUS_HAVE_STATUS_VOUT,
> > >   		.reg = PMBUS_STATUS_VOUT,
> > >   		.bits = (const struct pmbus_regulator_status_assoc[]) {
> > > @@ -2768,6 +2777,7 @@ static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] =
> > >   			{ PB_IOUT_OC_WARNING,    REGULATOR_ERROR_OVER_CURRENT_WARN },
> > >   			{ PB_IOUT_OC_FAULT,      REGULATOR_ERROR_OVER_CURRENT },
> > >   			{ PB_IOUT_OC_LV_FAULT,   REGULATOR_ERROR_OVER_CURRENT },
> > > +			{ PB_POUT_OP_FAULT,      REGULATOR_ERROR_FAIL },
> > 
> > Please document your changes in the description. There are two functional
> > changes hidden under "Add PMBus status byte to regulator flag map".
> > That is inappropriate. Those, as I have pointed out, should be separate
> > patches.
> My bad. I kept this change in this patch. Will remove this from this patch.
> > 
> > Guenter
> > 
> > >   			{ },
> > >   		},
> > >   	}, {
> > > @@ -2834,14 +2844,6 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
> > >   		if (status & PB_STATUS_POWER_GOOD_N)
> > >   			*flags |= REGULATOR_ERROR_REGULATION_OUT;
> > >   	}
> > > -	/*
> > > -	 * Unlike most other status bits, PB_STATUS_{IOUT_OC,VOUT_OV} are
> > > -	 * defined strictly as fault indicators (not warnings).
> > > -	 */
> > > -	if (status & PB_STATUS_IOUT_OC)
> > > -		*flags |= REGULATOR_ERROR_OVER_CURRENT;
> > > -	if (status & PB_STATUS_VOUT_OV)
> > > -		*flags |= REGULATOR_ERROR_REGULATION_OUT;
> > >   	/*
> > >   	 * If we haven't discovered any thermal faults or warnings via
> > > 
> > > base-commit: 9494c53e1389b120ba461899207ac8a3aab2632c
> > > -- 
> > > 2.37.3
> > > 
> 
> Regards,
> Naresh
