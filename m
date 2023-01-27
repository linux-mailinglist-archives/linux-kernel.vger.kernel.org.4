Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2133E67DB37
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 02:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjA0B0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 20:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjA0B0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 20:26:07 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194A870D4B;
        Thu, 26 Jan 2023 17:26:03 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 7494B5C0135;
        Thu, 26 Jan 2023 20:26:02 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Thu, 26 Jan 2023 20:26:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674782762; x=1674869162; bh=Uyn0GCb5o1
        bYMEPxxSY7qoZaJF2u/eBouvclgqEGYes=; b=rhat66Sh6eYyGObGxIkD/EWNQg
        JKvbUVYX10pRzk9Ged0gEkz0f9LhlTQA1l7TC5/6pMwYp92TfY+2xJs2Q44tadj+
        Ls6riwBS9xH5Eewf7dhMpooVqKwUk10aWzstBs29fQVAKW41xEAxE3mLxFybRSQe
        4spyHFJHPjaT/Arkh6Zkof0Y34QH97vRKb42E8mxtrqNIGzefyZHFemaM0NEDz3K
        rDGnxjuOzQ20qKF2cXltrusbS1pj6mzcjUl+FF8FpGyNUkS0uba4I0hod9cX9skW
        Rhwmqs+W5+OYFtTq2bpWnF3smqzLx0pqFE2SaO5Yymy2KDsllFfsXmDI8Hqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674782762; x=1674869162; bh=Uyn0GCb5o1bYMEPxxSY7qoZaJF2u
        /eBouvclgqEGYes=; b=rAj+HX9Qw8w2KD1Z/zkagCzwp+IvHeUWzcy9RwuQCmk2
        mtJyBbpWJySHgAgBeY3uoAcjxETMLJg18x7063vMHnWUMlO2Iz2g7Ww0gwPqws48
        z5XftvKHknrdl1Q04Tw8hJNZwgtapGrxGQomSemb1ApeGePeWHvt90HvuVXkpmTB
        5gVcfjYK3FVghntv6bLsvlXn6cAmEv1FxV4k394pzYCMCl1LT8KHsAL+vct5b51y
        P9bvygBd851MjrvPdAGpGCgiE2b6Wh7DZ8VZu1T6L0cLqPQnc6cP8sipsKF+KsCe
        hMiQC5Jeb7XsEUXvkej9a93mlq6ud0v/EOMooLonOg==
X-ME-Sender: <xms:KSjTY2eXS2BWDg6iWEiKJEcgNNczN8Ro_DGxrwUtttcN8ujdRIjp8Q>
    <xme:KSjTYwMdIBexrBocVFbDv3P3-Gb6cXl2rENw57Zcbby64zQw2ufVHa8euJWNZjFCT
    rFqtbBTWX_hlZ3Xxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvhedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpeekvdekjeekgfejudffteetgeejkeetteduvedtffdtledutdfhheev
    feetkeeiteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:KSjTY3hk4QJ_1VhEhLWVC_ChfvvqVR_iVhNtrwfejk3O7cHrKiH_zw>
    <xmx:KSjTYz8Dv62T01pmZb6kEUJeppEEGaywzL-_yhMe2QNxl3A09BepQg>
    <xmx:KSjTYyvAlnMElN35EvEaYj32Es1RjatiwgkrnY4DpPuqINly20W48Q>
    <xmx:KijTY8JxJ9GqcebEM87A2J_LH4iu6eikdwlg3wFYO8USb00IlLSaJA>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B5F621700090; Thu, 26 Jan 2023 20:26:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <47d97eb4-cb75-4697-827d-4985012b3c0a@app.fastmail.com>
In-Reply-To: <20230126213123.884125-3-eajames@linux.ibm.com>
References: <20230126213123.884125-1-eajames@linux.ibm.com>
 <20230126213123.884125-3-eajames@linux.ibm.com>
Date:   Fri, 27 Jan 2023 11:55:11 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>, linux-fsi@lists.ozlabs.org
Cc:     linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Alistair Popple" <alistair@popple.id.au>,
        "Joel Stanley" <joel@jms.id.au>, "Jeremy Kerr" <jk@ozlabs.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v3 2/2] fsi: Add IBM I2C Responder virtual FSI master
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eddie,

On Fri, 27 Jan 2023, at 08:01, Eddie James wrote:
> The I2C Responder (I2CR) is an I2C device that translates I2C commands
> to CFAM or SCOM operations, effectively implementing an FSI master and
> bus.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/fsi/Kconfig                    |   9 +
>  drivers/fsi/Makefile                   |   1 +
>  drivers/fsi/fsi-master-i2cr.c          | 225 +++++++++++++++++++++++++
>  include/trace/events/fsi_master_i2cr.h |  96 +++++++++++
>  4 files changed, 331 insertions(+)
>  create mode 100644 drivers/fsi/fsi-master-i2cr.c
>  create mode 100644 include/trace/events/fsi_master_i2cr.h
>
> diff --git a/drivers/fsi/Kconfig b/drivers/fsi/Kconfig
> index e6668a869913..999be82720c5 100644
> --- a/drivers/fsi/Kconfig
> +++ b/drivers/fsi/Kconfig
> @@ -62,6 +62,15 @@ config FSI_MASTER_ASPEED
> 
>  	 Enable it for your BMC kernel in an OpenPower or IBM Power system.
> 
> +config FSI_MASTER_I2CR
> +	tristate "IBM I2C Responder virtual FSI master"
> +	depends on I2C
> +	help
> +	  This option enables a virtual FSI master in order to access a CFAM
> +	  behind an IBM I2C Responder (I2CR) chip. The I2CR is an I2C device
> +	  that translates I2C commands to CFAM or SCOM operations, effectively
> +	  implementing an FSI master and bus.
> +
>  config FSI_SCOM
>  	tristate "SCOM FSI client device driver"
>  	help
> diff --git a/drivers/fsi/Makefile b/drivers/fsi/Makefile
> index da218a1ad8e1..34dbaa1c452e 100644
> --- a/drivers/fsi/Makefile
> +++ b/drivers/fsi/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_FSI) += fsi-core.o
>  obj-$(CONFIG_FSI_MASTER_HUB) += fsi-master-hub.o
>  obj-$(CONFIG_FSI_MASTER_ASPEED) += fsi-master-aspeed.o
>  obj-$(CONFIG_FSI_MASTER_GPIO) += fsi-master-gpio.o
> +obj-$(CONFIG_FSI_MASTER_I2CR) += fsi-master-i2cr.o
>  obj-$(CONFIG_FSI_MASTER_AST_CF) += fsi-master-ast-cf.o
>  obj-$(CONFIG_FSI_SCOM) += fsi-scom.o
>  obj-$(CONFIG_FSI_SBEFIFO) += fsi-sbefifo.o
> diff --git a/drivers/fsi/fsi-master-i2cr.c 
> b/drivers/fsi/fsi-master-i2cr.c
> new file mode 100644
> index 000000000000..0eadc9b26063
> --- /dev/null
> +++ b/drivers/fsi/fsi-master-i2cr.c
> @@ -0,0 +1,225 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) IBM Corporation 2023 */
> +
> +#include <linux/device.h>
> +#include <linux/fsi.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +
> +#include "fsi-master.h"
> +
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/fsi_master_i2cr.h>
> +
> +#define I2CR_ADDRESS_CFAM(a)	((a) >> 2)
> +#define I2CR_STATUS		0x30001
> +#define  I2CR_STATUS_ERR	 BIT_ULL(61)
> +#define I2CR_ERROR		0x30002
> +
> +struct fsi_master_i2cr {
> +	struct fsi_master master;
> +	struct mutex lock;	/* protect HW access */
> +	struct i2c_client *client;
> +};
> +
> +static bool i2cr_check_parity(u32 v, bool parity)
> +{
> +	u32 i;
> +
> +	for (i = 0; i < 32; ++i) {
> +		if (v & (1 << i))
> +			parity = !parity;
> +	}
> +
> +	return parity;
> +}
> +
> +static __be32 i2cr_get_command(u32 address, bool parity)
> +{
> +	__be32 command;
> +
> +	address <<= 1;
> +
> +	if (i2cr_check_parity(address, parity))
> +		address |= 1;
> +
> +	command = cpu_to_be32(address);
> +	trace_i2cr_command((__force uint32_t)command);
> +
> +	return command;
> +}
> +
> +static int i2cr_transfer(struct i2c_client *client, u32 address, 
> __be64 *data)
> +{
> +	struct i2c_msg msgs[2];
> +	__be32 command;
> +	int ret;
> +
> +	command = i2cr_get_command(address, true);
> +	msgs[0].addr = client->addr;
> +	msgs[0].flags = 0;
> +	msgs[0].len = sizeof(command);
> +	msgs[0].buf = (__u8 *)&command;
> +	msgs[1].addr = client->addr;
> +	msgs[1].flags = I2C_M_RD;
> +	msgs[1].len = sizeof(*data);
> +	msgs[1].buf = (__u8 *)data;
> +
> +	ret = i2c_transfer(client->adapter, msgs, 2);
> +	if (ret == 2)
> +		return 0;
> +
> +	trace_i2cr_i2c_error(ret);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return -EIO;
> +}
> +
> +static int i2cr_check_status(struct i2c_client *client)
> +{
> +	__be64 status_be = 0;
> +	u64 status;
> +	int ret;
> +
> +	ret = i2cr_transfer(client, I2CR_STATUS, &status_be);
> +	if (ret)
> +		return ret;
> +
> +	status = be64_to_cpu(status_be);
> +	if (status & I2CR_STATUS_ERR) {
> +		__be64 error_be = 0;
> +		u64 error;
> +
> +		i2cr_transfer(client, I2CR_ERROR, &error_be);
> +		error = be64_to_cpu(error_be);
> +		trace_i2cr_status_error(status, error);
> +		dev_err(&client->dev, "status:%016llx error:%016llx\n", status, 
> error);
> +		return -EREMOTEIO;
> +	}
> +
> +	trace_i2cr_status(status);
> +	return 0;
> +}
> +
> +static int i2cr_read(struct fsi_master *master, int link, uint8_t id, 
> uint32_t addr, void *val,
> +		     size_t size)
> +{
> +	struct fsi_master_i2cr *i2cr = container_of(master, struct 
> fsi_master_i2cr, master);
> +	__be64 data = 0;
> +	int ret;
> +
> +	if (link || id || (addr & 0xffff0000) || !(size == 1 || size == 2 || 
> size == 4))
> +		return -EINVAL;
> +
> +	mutex_lock(&i2cr->lock);
> +
> +	ret = i2cr_transfer(i2cr->client, I2CR_ADDRESS_CFAM(addr), &data);
> +	if (ret)
> +		goto unlock;
> +
> +	ret = i2cr_check_status(i2cr->client);
> +	if (ret)
> +		goto unlock;
> +
> +	trace_i2cr_read(addr, size, (__force uint32_t)data);
> +	memcpy(val, &data, size);
> +
> +unlock:
> +	mutex_unlock(&i2cr->lock);
> +	return ret;
> +}
> +
> +static int i2cr_write(struct fsi_master *master, int link, uint8_t id, 
> uint32_t addr,
> +		      const void *val, size_t size)
> +{
> +	struct fsi_master_i2cr *i2cr = container_of(master, struct 
> fsi_master_i2cr, master);
> +	struct {
> +		__be32 command;
> +		u32 val;
> +		u32 rsvd;
> +	} __packed data = { 0, 0, 0 };
> +	int ret;
> +
> +	if (link || id || (addr & 0xffff0000) || !(size == 1 || size == 2 || 
> size == 4))
> +		return -EINVAL;
> +
> +	memcpy(&data.val, val, size);

Still nervous about endian mixups here given the buffers in val tend to 
be pointers to big-endian values but data.val is native-endian (likely 
little-endian). It probably doesn't matter functionally given we pass 
the pointer to the packed struct through i2c_master_send(), but do the 
values come out right in the trace data?

What do you think about adding some commentary outlining the value 
representations to help with confidence here?

> +	data.command = i2cr_get_command(I2CR_ADDRESS_CFAM(addr),
> +					i2cr_check_parity(data.val, true));
> +
> +	mutex_lock(&i2cr->lock);
> +
> +	ret = i2c_master_send(i2cr->client, (const char *)&data, 
> sizeof(data));
> +	if (ret == sizeof(data)) {
> +		ret = i2cr_check_status(i2cr->client);
> +		if (!ret)
> +			trace_i2cr_write(addr, size, data.val);
> +	} else {
> +		trace_i2cr_i2c_error(ret);
> +
> +		if (ret >= 0)
> +			ret = -EIO;
> +	}

The i2cr_transfer() call in i2cr_check_status() can error but that 
won't be traced. Is that intentional? What about this instead?

ret = i2c_master_send(...)
if (ret == sizeof(data)) {
    ret = i2cr_check_status(i2cr->client);
} else {
    ret = -EIO;
}

if (ret) {
    trace_i2cr_i2c_error(ret);
} else {
    trace_i2cr_write(addr, size, data.val);
}

Cheers,

Andrew
