Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6B767A054
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbjAXRlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbjAXRl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:41:29 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C44816AD1;
        Tue, 24 Jan 2023 09:41:27 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id o66so13985952oia.6;
        Tue, 24 Jan 2023 09:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8ydFUJItBWc/AMtAyV9ZEnzm28LgFKe3PpQLrpwct8=;
        b=C6ewiz1LVi5kHwEB3G4KA65kAXWJBVx/ZksLKI4ktDUjmsdh/BSNTj4wjLpus9E3lJ
         c3DklRIMHe1IXOovu5/HWRC/a463QEaijKWwTi76F0XtLDwGZ1E1l3yrkdwnFNwigtd8
         p4Bia08qu6usJcetKFvl3cOFtvjAzVcc9hTNBLOzzUwxs1WvHDR3gWV2OGVknNRgsV2Z
         aS40GgL/NTZkFsqvYnfH6K3yB9AbT+2u3G4n2L13PKijtCeCBUwbN7evs7lHqzNJdrEo
         2gn/iEMi7f3/IZZKndXU9k0R4/EfpUo/uwQN0x9iQtJ9MAW4RbtM+L7U3rHNQTajinM3
         2Ung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8ydFUJItBWc/AMtAyV9ZEnzm28LgFKe3PpQLrpwct8=;
        b=ePYogJWYRB80WK2fZ3Ct9LXRqzcT0lUTDkhhYv1Hs3v8go0vkSZ1tqlumPdxaRIg5v
         nDICiBPh4JvnZpdHT6hoKaIW4xWPDAFIxr7M5cYNcKl8o7Kl+NQ2bujHUXdhFafdNifa
         5NUrY3BRZGu5WpqFJAls9vxhqiZqiyj8c523ViVT3kPgAa4e5urlV4wrfdKrwCHnVGTU
         MS97mgRwTGkwkvk4rDAskzaZvKBG/oTtPSCvUh70eTQak1myiEi9P4IC5sPmn1PMRuyg
         Wtaenbtm3UvMsONpPalM9Mo/x9bucVHjVtPp3k9AGDaaEe2Jg8JUlVdx3c+s0gzebxAl
         T8bg==
X-Gm-Message-State: AFqh2kq0wcQp0X6EVd/ioTO5iQ0zKtVFTVo7zJpTI0ZDUfvs6iFKS4uV
        jVcXhH2p7f2Cx68wTVLY4kk=
X-Google-Smtp-Source: AMrXdXuWGNwWh7EpfcRER4u6FJLlluXzbjv0RmuvU+G5GZgcCXVW8XULmL6fGuA1e08DishPWGQb/A==
X-Received: by 2002:aca:3402:0:b0:36a:3a8a:212d with SMTP id b2-20020aca3402000000b0036a3a8a212dmr10952624oia.45.1674582086921;
        Tue, 24 Jan 2023 09:41:26 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u81-20020aca6054000000b0036cbde661ecsm1241962oib.54.2023.01.24.09.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 09:41:26 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 24 Jan 2023 09:41:24 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] hwmon: (pmbus/tda38640) Add driver for Infineon
 TDA38640 Voltage Regulator
Message-ID: <20230124174124.GA563936@roeck-us.net>
References: <20230124144847.423129-1-Naresh.Solanki@9elements.com>
 <20230124144847.423129-2-Naresh.Solanki@9elements.com>
 <94176a1b-f9ad-b096-fc39-5e333f4eb09f@linaro.org>
 <7de492aa-8622-b0d3-f932-2e8d7dcb8704@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7de492aa-8622-b0d3-f932-2e8d7dcb8704@9elements.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 08:44:18PM +0530, Naresh Solanki wrote:
> 
> 
> On 24-01-2023 08:39 pm, Krzysztof Kozlowski wrote:
> > On 24/01/2023 15:48, Naresh Solanki wrote:
> > > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > 
> > > Add the pmbus driver for the Infineon TDA38640 voltage regulator.
> > > 
> > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > > ---
> > 
> > (...)
> > 
> > > +
> > > +#include <linux/err.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/init.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/regulator/driver.h>
> > > +#include "pmbus.h"
> > > +
> > > +static const struct regulator_desc __maybe_unused tda38640_reg_desc[] = {
> > > +	PMBUS_REGULATOR("vout", 0),
> > > +};
> > > +
> > > +static struct pmbus_driver_info tda38640_info = {
> > > +	.pages = 1,
> > > +	.format[PSC_VOLTAGE_IN] = linear,
> > > +	.format[PSC_VOLTAGE_OUT] = linear,
> > > +	.format[PSC_CURRENT_OUT] = linear,
> > > +	.format[PSC_CURRENT_IN] = linear,
> > > +	.format[PSC_POWER] = linear,
> > > +	.format[PSC_TEMPERATURE] = linear,
> > > +
> > > +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
> > > +	    | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
> > > +	    | PMBUS_HAVE_IIN
> > > +	    | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
> > > +	    | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
> > > +	    | PMBUS_HAVE_POUT | PMBUS_HAVE_PIN,
> > > +#if IS_ENABLED(CONFIG_SENSORS_TDA38640_REGULATOR)
> > > +	.num_regulators = 1,
> > > +	.reg_desc = tda38640_reg_desc,
> > > +#endif
> > > +};
> > > +
> > > +static int tda38640_probe(struct i2c_client *client)
> > > +{
> > > +	return pmbus_do_probe(client, &tda38640_info);
> > > +}
> > > +
> > > +static const struct i2c_device_id tda38640_id[] = {
> > > +	{"tda38640", 0},
> > > +	{}
> > > +};
> > > +MODULE_DEVICE_TABLE(i2c, tda38640_id);
> > > +
> > > +static const struct of_device_id __maybe_unused tda38640_of_match[] = {
> > > +	{ .compatible = "infineon,tda38640"},
> > > +	{ },
> > > +};
> > > +MODULE_DEVICE_TABLE(of, tda38640_of_match);
> > 
> > No improvements here. Do not send new version without solving the
> > feedback (or finishing the discussion). Its usage is still missing in
> > your i2c_driver.
> I realized I missed reference to tda38640_of_match below.
> 
> static struct i2c_driver tda38640_driver = {
>         .driver = {
>                    .name = "tda38640",
>                    .of_match_table = of_match_ptr(tda38640_of_match),
>                    },

Column alignment also looks off. I would expect tabs only, like

	.driver = {
		.name = "tda38640",
		.of_match_table = of_match_ptr(tda38640_of_match),
	},

Guenter

>         .probe_new = tda38640_probe,
>         .id_table = tda38640_id,
> };
> 
> Will fix that.
> > 
> > Best regards,
> > Krzysztof
> > 
> Thanks,
> Naresh
