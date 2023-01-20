Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51EF6748A1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 02:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjATBJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 20:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjATBJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 20:09:28 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438355268;
        Thu, 19 Jan 2023 17:09:23 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id A2F1D5C00E2;
        Thu, 19 Jan 2023 20:09:22 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Thu, 19 Jan 2023 20:09:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674176962; x=1674263362; bh=XIWQy23LCZ
        PR7eA+gkfnWFk7FdpGptPDEhZx29R96r0=; b=peoc4AKuD7qbXSzU9Swbz2oPEh
        nTYdxPH+lOhej6u1OJohYRkAT3w1PmJ5fQ7H5q+q5aKAxJfUj5lxER/nAAZ2bSqm
        PW4IMTVeQDJK/3y/8V+FHJFLlqbSTpjXZFsrINaNonPxGwgpzIV6nceH88346LOj
        +tFTkQ7zZfaHyStCpK+kQ+wIr8riGFbDf1v937ii3p8xdWBUuPUksHOoo600PL09
        6XEbR/NuuZ3cdQ4vIDmcOQVSZaRl7cOOL/qLVXUwLiT2QhJzmL0Sa9pyUR7u3iJG
        vq1PId41pzO42GUFCICnP37yL30yfLbqwcpvptjB+eMPgQqquU3JkzQxfyVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674176962; x=1674263362; bh=XIWQy23LCZPR7eA+gkfnWFk7FdpG
        ptPDEhZx29R96r0=; b=C+9RX5kyoNPgqEd/lKJyxIbqZB2+8qgBxdghSuVwu1+F
        TPH2jNQu6GoxZhKIXaZLXnwqvVJVvP+CxfqpZLNESV2cGrG4agLIcDu+Cs3/v95a
        jEE7vJZW9ogOkadLyyjBmbDiBR2641j8PL+YfKqNbDw/zZ1LQdtfoS47SXTHFfOd
        igO7E/1rly0WpMptPYos92A7lPclgSAWB4dUE7dqSiluCshrWK3vydIsnNLAmEJH
        1SJGTApHB7ed6+TnzCbTIGuzoeWvLDVT+57hn8CnFSQHHZQisk3W6YjmJ8557WeJ
        ywTS6bfTVvuzjcjbwm7rBzrlILPoc5xbjLNOIzdO1A==
X-ME-Sender: <xms:wunJYwpWtf2tEiB9c1J946H8lVjchqLDuRMjLfQ9cINishmbB6L5RQ>
    <xme:wunJY2q6sDblOson-2jNYB8qC33AEp5Kf9OZGgxIqIDw8Hawf_05soposJgKF9uSV
    2S64FcgOPkxVxYRVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudduuddgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpeekvdekjeekgfejudffteetgeejkeetteduvedtffdtledutdfhheev
    feetkeeiteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:wunJY1Pz0s1TxDhejcwc7Rcr-jxMpwHPcj2IVij1LrbzyQ446FCMgw>
    <xmx:wunJY36Y1biHE5ZaBVtBoKO_3WK0ZoSpksaQyvWWbZJzCwNtJiAP6Q>
    <xmx:wunJY_7lXq5c9MUbkREr-oQMC-NYnmCTZo31w4M80sg6QvKbXeSLqw>
    <xmx:wunJYy1yPgXdV91fHcq1qK8lAdFeV8nskX9mQ7cDJwQZJxwfTSkl8Q>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F37071700089; Thu, 19 Jan 2023 20:09:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <0cee04d0-434e-4b0c-9c4f-e165bc708372@app.fastmail.com>
In-Reply-To: <20230119174714.1486042-3-eajames@linux.ibm.com>
References: <20230119174714.1486042-1-eajames@linux.ibm.com>
 <20230119174714.1486042-3-eajames@linux.ibm.com>
Date:   Fri, 20 Jan 2023 11:39:00 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>, linux-fsi@lists.ozlabs.org
Cc:     devicetree@vger.kernel.org,
        "Alistair Popple" <alistair@popple.id.au>,
        linux-kernel@vger.kernel.org, "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 2/2] fsi: Add IBM I2C Responder virtual FSI master
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



On Fri, 20 Jan 2023, at 04:17, Eddie James wrote:
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
> index 000000000000..d19ac96c0a83
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

Is there a reason to use __be64 *data here and not `void *data, size_t
len`? We never actually use it as the declared type internally, only
cast it to __u8 *.

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
> +	if (link || id || (addr & 0xffff0000) || !size || size > 4 || size == 
> 3)

These size constraints are a bit funky. Instead of `!size || size > 4 ||
size == 3` we write `!(size == 1 || size == 2 || size == 4)`?

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
> +	__be32 data[3];
> +	int ret;
> +
> +	if (link || id || (addr & 0xffff0000) || !size || size > 4 || size == 
> 3)

As above

> +		return -EINVAL;
> +
> +	data[1] = 0;
> +	memcpy(&data[1], val, size);
> +	data[0] = i2cr_get_command(I2CR_ADDRESS_CFAM(addr),
> +				   i2cr_check_parity((__force u32)data[1], true));
> +	data[2] = 0;
> +
> +	mutex_lock(&i2cr->lock);
> +
> +	ret = i2c_master_send(i2cr->client, (const char *)data, sizeof(data));
> +	if (ret == sizeof(data)) {
> +		ret = i2cr_check_status(i2cr->client);
> +		if (!ret)
> +			trace_i2cr_write(addr, size, (__force uint32_t)data[1]);

I think we can reduce the amount of __force if we flip the endianness 
of the data variable?

```
u32 data[3];
__be32 cmd_be;

data[1] = 0;
memcpy(&data[1], val, size);
cmd_be = i2cr_get_command(I2CR_ADDRESS_CFAM(addr),
						    i2cr_check_parity(data[1], true));
data[0] = (__force u32)cmd_be;
data[2] = 0;
....
trace_i2cr_write(addr, size, data[1]);
```

?

Or define i2cr_check_parity() and the tracepoint in terms of big-endian?

> +	} else {
> +		trace_i2cr_i2c_error(ret);
> +
> +		if (ret >= 0)
> +			ret = -EIO;
> +	}
> +
> +	mutex_unlock(&i2cr->lock);
> +	return ret;
> +}
> +
> +static int i2cr_probe(struct i2c_client *client)
> +{
> +	struct fsi_master_i2cr *i2cr;
> +	int ret;
> +
> +	i2cr = devm_kzalloc(&client->dev, sizeof(*i2cr), GFP_KERNEL);
> +	if (!i2cr)
> +		return -ENOMEM;
> +
> +	i2cr->master.dev.parent = &client->dev;
> +	i2cr->master.dev.of_node = of_node_get(dev_of_node(&client->dev));
> +
> +	i2cr->master.n_links = 1;
> +	i2cr->master.read = i2cr_read;
> +	i2cr->master.write = i2cr_write;
> +
> +	mutex_init(&i2cr->lock);
> +	i2cr->client = client;
> +
> +	ret = fsi_master_register(&i2cr->master);
> +	if (ret)
> +		return ret;
> +
> +	i2c_set_clientdata(client, i2cr);
> +	return 0;
> +}
> +
> +static int i2cr_remove(struct i2c_client *client)
> +{
> +	struct fsi_master_i2cr *i2cr = i2c_get_clientdata(client);
> +
> +	fsi_master_unregister(&i2cr->master);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id i2cr_i2c_ids[] = {
> +	{ .compatible = "ibm,i2cr", },

This may need an update after discussion on the binding patch.

Andrew
