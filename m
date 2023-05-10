Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342D16FDF00
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbjEJNrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236415AbjEJNrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:47:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8919AAD39
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 06:47:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0EDD6381E
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 13:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911D2C433EF;
        Wed, 10 May 2023 13:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683726395;
        bh=3GjhoX4bF6VCAA2AtN1OJqutmXtat1UBNKfMLA+2m9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LNAgmiwWCBMjQOeTCVtpqtje3qIfZLzLPCS1/7SuOZj3+MP8NSw4BKm0ajwGQ6q7Q
         niULOOcMC84Ep3/rGT0KtvMKPIKdUA5vCV1lPl6M8dZkWQYt+v/Pr5vlbDltUf6w4L
         pr63n51ohI5fooFxWDu6UUG2yB6AB0HhpQsPXLrIUJgdU4PzpN0MqiNe9knMLfiNiy
         vZyutlMlJ+k852HJkOAej6EFToyV+QehCrDHspOkPS/q6rNx7LPNRT995k7Lalh2Kf
         LT+szEi7hYptA5guDjdAFtM4tx1c656DVHaIQNHjUM3RKTgBlWmKEvnr4bm1V37jdR
         hI2VuxGDCwnvQ==
Date:   Wed, 10 May 2023 14:46:31 +0100
From:   Lee Jones <lee@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: max5970: Rename driver and remove wildcard
Message-ID: <20230510134631.GD8963@google.com>
References: <20230427113046.3971425-1-Naresh.Solanki@9elements.com>
 <27b26cb4-14b2-57c2-7b57-167ca17b6a15@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27b26cb4-14b2-57c2-7b57-167ca17b6a15@9elements.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 May 2023, Naresh Solanki wrote:

> Hi Lee,
> 
> I hope this email finds you well. I am writing to inquire about the status
> of my patch.
> 
> The purpose of this patch set was to rename the driver to remove the
> wildcard and make it specific to avoid confusion with different similar
> devices. I want to emphasize that this patch set does not include any
> functional changes.
> 
> I would appreciate it if you could kindly provide an update on the status.
> Please let me know if there is anything else you need from my end to help
> move things forward.
> 
> Thank you for your time and attention.

Please refrain from top-posting.

If you think your patch has fallen through the gaps (it hasn't) please
submit a [RESEND].

The merge-window has been open for the last 2 weeks.  I'm just ramping
up again on my backlog.

I'll get to you soon.

> On 27-04-2023 05:00 pm, Naresh Solanki wrote:
> > The previous version of this driver included wildcards in file names
> > and descriptions. This patch renames the driver to only support MAX5970
> > and MAX5978, which are the only chips that the driver actually supports.
> > 
> > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > ---
> >   drivers/mfd/Kconfig                        |  4 ++--
> >   drivers/mfd/simple-mfd-i2c.c               | 18 +++++++++---------
> >   include/linux/mfd/{max597x.h => max5970.h} | 16 ++++++++--------
> >   3 files changed, 19 insertions(+), 19 deletions(-)
> >   rename include/linux/mfd/{max597x.h => max5970.h} (92%)
> > 
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index e90463c4441c..71231388e03c 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -266,8 +266,8 @@ config MFD_MADERA_SPI
> >   	  Support for the Cirrus Logic Madera platform audio SoC
> >   	  core functionality controlled via SPI.
> > -config MFD_MAX597X
> > -	tristate "Maxim 597x power switch and monitor"
> > +config MFD_MAX5970
> > +	tristate "Maxim 5970/5978 power switch and monitor"
> >   	depends on (I2C && OF)
> >   	select MFD_SIMPLE_MFD_I2C
> >   	help
> > diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> > index 20782b4dd172..1f1c007560d8 100644
> > --- a/drivers/mfd/simple-mfd-i2c.c
> > +++ b/drivers/mfd/simple-mfd-i2c.c
> > @@ -72,22 +72,22 @@ static const struct simple_mfd_data silergy_sy7636a = {
> >   	.mfd_cell_size = ARRAY_SIZE(sy7636a_cells),
> >   };
> > -static const struct mfd_cell max597x_cells[] = {
> > -	{ .name = "max597x-regulator", },
> > -	{ .name = "max597x-iio", },
> > -	{ .name = "max597x-led", },
> > +static const struct mfd_cell max5970_cells[] = {
> > +	{ .name = "max5970-regulator", },
> > +	{ .name = "max5970-iio", },
> > +	{ .name = "max5970-led", },
> >   };
> > -static const struct simple_mfd_data maxim_max597x = {
> > -	.mfd_cell = max597x_cells,
> > -	.mfd_cell_size = ARRAY_SIZE(max597x_cells),
> > +static const struct simple_mfd_data maxim_max5970 = {
> > +	.mfd_cell = max5970_cells,
> > +	.mfd_cell_size = ARRAY_SIZE(max5970_cells),
> >   };
> >   static const struct of_device_id simple_mfd_i2c_of_match[] = {
> >   	{ .compatible = "kontron,sl28cpld" },
> >   	{ .compatible = "silergy,sy7636a", .data = &silergy_sy7636a},
> > -	{ .compatible = "maxim,max5970", .data = &maxim_max597x},
> > -	{ .compatible = "maxim,max5978", .data = &maxim_max597x},
> > +	{ .compatible = "maxim,max5970", .data = &maxim_max5970},
> > +	{ .compatible = "maxim,max5978", .data = &maxim_max5970},
> >   	{}
> >   };
> >   MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);
> > diff --git a/include/linux/mfd/max597x.h b/include/linux/mfd/max5970.h
> > similarity index 92%
> > rename from include/linux/mfd/max597x.h
> > rename to include/linux/mfd/max5970.h
> > index a850b2e02e6a..762a7d40c843 100644
> > --- a/include/linux/mfd/max597x.h
> > +++ b/include/linux/mfd/max5970.h
> > @@ -7,25 +7,25 @@
> >    * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
> >    */
> > -#ifndef _MFD_MAX597X_H
> > -#define _MFD_MAX597X_H
> > +#ifndef _MFD_MAX5970_H
> > +#define _MFD_MAX5970_H
> >   #include <linux/regmap.h>
> >   #define MAX5970_NUM_SWITCHES 2
> >   #define MAX5978_NUM_SWITCHES 1
> > -#define MAX597X_NUM_LEDS     4
> > +#define MAX5970_NUM_LEDS     4
> > -struct max597x_data {
> > +struct max5970_data {
> >   	int num_switches;
> >   	u32 irng[MAX5970_NUM_SWITCHES];
> >   	u32 mon_rng[MAX5970_NUM_SWITCHES];
> >   	u32 shunt_micro_ohms[MAX5970_NUM_SWITCHES];
> >   };
> > -enum max597x_chip_type {
> > -	MAX597x_TYPE_MAX5978 = 1,
> > -	MAX597x_TYPE_MAX5970,
> > +enum max5970_chip_type {
> > +	TYPE_MAX5978 = 1,
> > +	TYPE_MAX5970,
> >   };
> >   #define MAX5970_REG_CURRENT_L(ch)		(0x01 + (ch) * 4)
> > @@ -93,4 +93,4 @@ enum max597x_chip_type {
> >   #define MAX_REGISTERS			0x49
> >   #define ADC_MASK			0x3FF
> > -#endif				/* _MFD_MAX597X_H */
> > +#endif				/* _MFD_MAX5970_H */
> > 
> > base-commit: b4c288cfd2f84c44994330c408e14645d45dee5b

-- 
Lee Jones [李琼斯]
