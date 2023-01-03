Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA3E65C533
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238304AbjACRkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238253AbjACRkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:40:12 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC91C10FFF;
        Tue,  3 Jan 2023 09:40:08 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-14ffd3c5b15so26041927fac.3;
        Tue, 03 Jan 2023 09:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMNfeSjCh0BfCORHZrZEG9uctt5EKtuv6ubYw+95YrQ=;
        b=fm71vNWnwQQHOfPakKRsYfmPoBLDYAw3ctA/PF+HT9ICdhbnGIQNYGMmkUw9GyAuHg
         IbZTvYgBweMemgOW43AYk1BY/ymFH7gCsd8OEcatJ8MMhGny8fORmKvanUBGMwXQzmHy
         LN5dc7a9M8rWUEdVNM8DKA3Vw6H4GWxTv28Uh6wRXE1KcNplob7d7q0G33Tm3PjaYNXR
         ARIdwd1tF3UX6QmqdRPxhqG9CQpP1Q9Q9ItfCiOSFdHSreFl9V1NSSMo6zKIT9VRkPpi
         7Css/CDwbSFotuEUqQwCx0eSikbL/KFSw9N/ZnudxBZRodEXH/iyv2goEofDbqquEyM1
         REEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMNfeSjCh0BfCORHZrZEG9uctt5EKtuv6ubYw+95YrQ=;
        b=IvdDxr+Q/AXLZzMil6Zmk8I3I8c57pgi5J6kepGovcCIh/FFgfuZbncDlP+ugPdoPr
         qpnHCGxcsFYrAn1SihpLyP94DEEZz/OuvKnmpRaxxTb8CatKlgYBiKhaezHNVxUyoZXV
         VJDIFMQg5EJdOp0KDnfGpynm7RNf78EPh1672ATuXzPkZXirzI2+m2oIWglrqUZKLJtD
         PRRIhIXyU4pyb9vEylpHuDK0JCAqsTdgkmoq4HNev2UOyF7DUZXJqIXiDEUW1Ri5tBzy
         MRXsnlQQz2SkSiIOpEc7nSV18dGnUpQFGX2X0Nw/gCOtRRKo+DeNljiuYEo4sgrgnwil
         ZH1A==
X-Gm-Message-State: AFqh2kqldeF7dy2MNzoCDxIvZ5EgkqAule3DSe9CMo3Ppj7MUcmRkOO2
        KaDGQs3EEwx2Itzxw/foR9mrUSQzB8A=
X-Google-Smtp-Source: AMrXdXtC7utx+3MwR6P3tvbWfL40qQV0qB9AIJ2x6aWpB+sMLmruy2V+jnlYzmuedmnBhvyrf2IDVQ==
X-Received: by 2002:a05:6870:cd04:b0:13b:8098:d195 with SMTP id qk4-20020a056870cd0400b0013b8098d195mr19013960oab.27.1672767607277;
        Tue, 03 Jan 2023 09:40:07 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n38-20020a05687055a600b0013b9ee734dcsm14450344oao.35.2023.01.03.09.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 09:40:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 3 Jan 2023 09:40:04 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH RESEND v6 1/5] hwmon: (pmbus/core): Add interrupt support
Message-ID: <20230103174004.GA202902@roeck-us.net>
References: <20221214080715.2700442-1-Naresh.Solanki@9elements.com>
 <20221229144012.GA21213@roeck-us.net>
 <ecdf887d-d2c8-d9d4-ab19-3b30ee1d4607@9elements.com>
 <20230103122656.GB190111@roeck-us.net>
 <dc604c81-b447-3bc0-18c3-13e03ba56c40@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc604c81-b447-3bc0-18c3-13e03ba56c40@9elements.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 08:56:59PM +0530, Naresh Solanki wrote:
> Hi Guenter
> 
> On 03-01-2023 05:56 pm, Guenter Roeck wrote:
> > On Tue, Jan 03, 2023 at 12:18:49PM +0530, Naresh Solanki wrote:
> > > Hi Guenter,
> > > 
> > > On 29-12-2022 08:10 pm, Guenter Roeck wrote:
> > > > On Wed, Dec 14, 2022 at 09:07:11AM +0100, Naresh Solanki wrote:
> > > > > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > > 
> > > > > Implement PMBUS irq handler.
> > > > > 
> > > > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > > > 
> > > > $ scripts/checkpatch.pl --strict index.html
> > > > CHECK: Blank lines aren't necessary after an open brace '{'
> > > > #131: FILE: drivers/hwmon/pmbus/pmbus_core.c:3088:
> > > > +	for (i = 0; i < data->info->pages; i++) {
> > > > +
> > > > 
> > > > CHECK: Alignment should match open parenthesis
> > > > #183: FILE: drivers/hwmon/pmbus/pmbus_core.c:3140:
> > > > +	ret = devm_request_threaded_irq(dev, client->irq, NULL, pmbus_fault_handler,
> > > > +			      0, "pmbus-irq", data);
> > > > 
> > > > CHECK: Please use a blank line after function/struct/union/enum declarations
> > > > #197: FILE: drivers/hwmon/pmbus/pmbus_core.c:3154:
> > > >    }
> > > > +static int pmbus_irq_setup(struct i2c_client *client, struct pmbus_data *data)
> > > > 
> > > > total: 0 errors, 0 warnings, 3 checks, 109 lines checked
> > > > 
> > > > NOTE: For some of the reported defects, checkpatch may be able to
> > > >         mechanically convert to the typical style using --fix or --fix-inplace.
> > > > 
> > > > index.html has style problems, please review.
> > > > 
> > > > Please run checkpatch --strict on your patches.
> > > > Also see Documentation/hwmon/submitting-patches.rst.
> > > I will take care of these errors in the updated version.
> > > > 
> > > > > ---
> > > > >    drivers/hwmon/pmbus/pmbus.h      |  2 +-
> > > > >    drivers/hwmon/pmbus/pmbus_core.c | 84 ++++++++++++++++++++++++++++++++
> > > > >    2 files changed, 85 insertions(+), 1 deletion(-)
> > > > > 
> > > > > 
> > > > > base-commit: 364ffd2537c44cb6914ff5669153f4a86fffad29
> > > > > 
> > > > > diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
> > > > > index 10fb17879f8e..6b2e6cf93b19 100644
> > > > > --- a/drivers/hwmon/pmbus/pmbus.h
> > > > > +++ b/drivers/hwmon/pmbus/pmbus.h
> > > > > @@ -26,7 +26,7 @@ enum pmbus_regs {
> > > > >    	PMBUS_CAPABILITY		= 0x19,
> > > > >    	PMBUS_QUERY			= 0x1A,
> > > > > -
> > > > > +	PMBUS_SMBALERT_MASK		= 0x1B,
> > > > >    	PMBUS_VOUT_MODE			= 0x20,
> > > > >    	PMBUS_VOUT_COMMAND		= 0x21,
> > > > >    	PMBUS_VOUT_TRIM			= 0x22,
> > > > > diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> > > > > index 95e95783972a..244fd2597252 100644
> > > > > --- a/drivers/hwmon/pmbus/pmbus_core.c
> > > > > +++ b/drivers/hwmon/pmbus/pmbus_core.c
> > > > > @@ -3072,11 +3072,89 @@ static int pmbus_regulator_register(struct pmbus_data *data)
> > > > >    	return 0;
> > > > >    }
> > > > > +
> > > > > +static int pmbus_write_smbalert_mask(struct i2c_client *client, u8 page, u8 reg, u8 val)
> > > > > +{
> > > > > +	return pmbus_write_word_data(client, page, PMBUS_SMBALERT_MASK, reg | (val << 8));
> > > > > +}
> > > > > +
> > > > > +static irqreturn_t pmbus_fault_handler(int irq, void *pdata)
> > > > > +{
> > > > > +	struct pmbus_data *data = pdata;
> > > > > +	struct i2c_client *client = to_i2c_client(data->dev);
> > > > > +	int i, status;
> > > > > +
> > > > > +	for (i = 0; i < data->info->pages; i++) {
> > > > > +
> > > > > +		mutex_lock(&data->update_lock);
> > > > > +		status = pmbus_read_status_word(client, i);
> > > > > +		if (status < 0) {
> > > > > +			mutex_unlock(&data->update_lock);
> > > > > +			return status;
> > > > > +		}
> > > > > +
> > > > > +		if (status & ~(PB_STATUS_OFF | PB_STATUS_BUSY | PB_STATUS_POWER_GOOD_N))
> > > > > +			pmbus_clear_fault_page(client, i);
> > > > > +
> > > > > +		mutex_unlock(&data->update_lock);
> > > > > +	}
> > > > > +
> > > > > +	return IRQ_HANDLED;
> > > > > +}
> > > > > +
> > > > > +static int pmbus_irq_setup(struct i2c_client *client, struct pmbus_data *data)
> > > > > +{
> > > > > +	struct device *dev = &client->dev;
> > > > > +	const struct pmbus_regulator_status_category *cat;
> > > > > +	const struct pmbus_regulator_status_assoc *bit;
> > > > > +	int i, j, err, ret, func;
> > > > > +	u8 mask;
> > > > > +
> > > > > +	for (i = 0; i < data->info->pages; i++) {
> > > > > +		func = data->info->func[i];
> > > > > +
> > > > > +		for (j = 0; j < ARRAY_SIZE(pmbus_regulator_flag_map); j++) {
> > > > > +			cat = &pmbus_regulator_flag_map[j];
> > > > > +			if (!(func & cat->func))
> > > > > +				continue;
> > > > > +			mask = 0;
> > > > > +			for (bit = cat->bits; bit->pflag; bit++)
> > > > > +				mask |= bit->pflag;
> > > > > +
> > > > > +			err = pmbus_write_smbalert_mask(client, i, cat->reg, ~mask);
> > > > > +			if (err)
> > > > > +				dev_err(dev, "Failed to set smbalert for reg 0x%02x\n",	cat->reg);
> > > > 
> > > > This concerns me. It might mean that the chip does not support
> > > > PMBUS_SMBALERT_MASK. If so, there would be lots of error messages.
> > > After going through the PMBus specification, it appears that this should not
> > > be an issue unless there is a violation of the specification.
> > 
> > PMBus chips have lots of issues which violate the specification.
> > Have a look at the various drivers and the workarounds implemented there.
> > You'll need to check if the command/register is supported before using it.
> > Also, if you want to keep the error message, make it dev_err_once().
> > 
> > Either case, an error is an error, not to be ignored. An error here
> > should result in an error abort.
> Yes, I agree that PMBus chips can have issues that violate the
> specification, and that it is important to check whether a command or
> register is supported before using it.
> I have noticed that many drivers use the PMBUS_HAVE_* flags to expose the
> presence of specific registers, and I think it would be a good idea to add a
> PMBUS_HAVE_SMBALERT flag as well, so that drivers for supported chips can
> use it to determine whether they should set up an IRQ handler or not. If
> PMBUS_HAVE_SMBALERT is set, then the IRQ handler should be set up, otherwise
> it should be ignored.
> Will this approach be right?

Not really. PMBUS_HAVE_ flags are intended to indicate sensor register
support, not to indicate compliance problems. What you'd be looking for
would be the flags in struct pmbus_platform_data. However, those are only
intended to be used if registers/commands can not be auto-detected or if
doing so causes problems. See include/linux/pmbus.h for details.
Unless there is reason to believe that chips are misbehaving when trying
to read from or to set PMBUS_SMBALERT_MASK, we should stick with auto-
detection. After all, that is what pmbus_check_{status,byte,word}_register()
functions are for.

Thanks,
Guenter
