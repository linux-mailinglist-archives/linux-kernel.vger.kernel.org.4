Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6976267BFFC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 23:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjAYWgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 17:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjAYWgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 17:36:52 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2E05A826;
        Wed, 25 Jan 2023 14:36:51 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PLwoEm021489;
        Wed, 25 Jan 2023 22:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=agtSZVu7uPVWIozenYaqIYo4PFEwKQPU86u993qcffQ=;
 b=GuAL3Pz4343ggl200+eSHbIiObPu8Lp1+H5S/4IxzmdBMP30bIHQV2gh7bioOqxh8c5Q
 QG+cdtHUa8TAKIFVXj0SslX+GJMEqHpOabavvvtTxXKY5RgBxVSmzBhaWI9S574JbYrU
 QtcRaAwZPH8GJdA1BSbDDVb2ez5LktsVn/9D/+fBrIjTzhcw9wiutwXH9AmrcM9Gx2NQ
 7RsFdrVuuJ3bfZ28XvosgNMZWZ2gTHTC623jD3nbj9/klF/IsJSH5gK0yQ4KgJoOqqPm
 7XlzQgmopU26SRLQ/ge3a8Nsi3toNYI0ReVY+bQLKz9gAXJOOMETZb3FT4wwxapLwjRA Sg== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nacg23a1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 22:36:37 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PJqamq006949;
        Wed, 25 Jan 2023 22:36:37 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3n87p7gshx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 22:36:36 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PMaZ4N26411674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 22:36:35 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15BF958072;
        Wed, 25 Jan 2023 22:36:35 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4732058073;
        Wed, 25 Jan 2023 22:36:34 +0000 (GMT)
Received: from [9.77.150.21] (unknown [9.77.150.21])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 22:36:34 +0000 (GMT)
Message-ID: <b1ecfea3-f4d9-b674-b438-cc7648894581@linux.ibm.com>
Date:   Wed, 25 Jan 2023 16:36:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] fsi: Add IBM I2C Responder virtual FSI master
Content-Language: en-US
To:     Andrew Jeffery <andrew@aj.id.au>, linux-fsi@lists.ozlabs.org
Cc:     devicetree@vger.kernel.org,
        Alistair Popple <alistair@popple.id.au>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230119174714.1486042-1-eajames@linux.ibm.com>
 <20230119174714.1486042-3-eajames@linux.ibm.com>
 <0cee04d0-434e-4b0c-9c4f-e165bc708372@app.fastmail.com>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <0cee04d0-434e-4b0c-9c4f-e165bc708372@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: X5kJ3w5WYKYFiILf3vslcQY40YQaUdIZ
X-Proofpoint-GUID: X5kJ3w5WYKYFiILf3vslcQY40YQaUdIZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_13,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250200
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/19/23 19:09, Andrew Jeffery wrote:
>
> On Fri, 20 Jan 2023, at 04:17, Eddie James wrote:
>> The I2C Responder (I2CR) is an I2C device that translates I2C commands
>> to CFAM or SCOM operations, effectively implementing an FSI master and
>> bus.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   drivers/fsi/Kconfig                    |   9 +
>>   drivers/fsi/Makefile                   |   1 +
>>   drivers/fsi/fsi-master-i2cr.c          | 225 +++++++++++++++++++++++++
>>   include/trace/events/fsi_master_i2cr.h |  96 +++++++++++
>>   4 files changed, 331 insertions(+)
>>   create mode 100644 drivers/fsi/fsi-master-i2cr.c
>>   create mode 100644 include/trace/events/fsi_master_i2cr.h
>>
>> diff --git a/drivers/fsi/Kconfig b/drivers/fsi/Kconfig
>> index e6668a869913..999be82720c5 100644
>> --- a/drivers/fsi/Kconfig
>> +++ b/drivers/fsi/Kconfig
>> @@ -62,6 +62,15 @@ config FSI_MASTER_ASPEED
>>
>>   	 Enable it for your BMC kernel in an OpenPower or IBM Power system.
>>
>> +config FSI_MASTER_I2CR
>> +	tristate "IBM I2C Responder virtual FSI master"
>> +	depends on I2C
>> +	help
>> +	  This option enables a virtual FSI master in order to access a CFAM
>> +	  behind an IBM I2C Responder (I2CR) chip. The I2CR is an I2C device
>> +	  that translates I2C commands to CFAM or SCOM operations, effectively
>> +	  implementing an FSI master and bus.
>> +
>>   config FSI_SCOM
>>   	tristate "SCOM FSI client device driver"
>>   	help
>> diff --git a/drivers/fsi/Makefile b/drivers/fsi/Makefile
>> index da218a1ad8e1..34dbaa1c452e 100644
>> --- a/drivers/fsi/Makefile
>> +++ b/drivers/fsi/Makefile
>> @@ -4,6 +4,7 @@ obj-$(CONFIG_FSI) += fsi-core.o
>>   obj-$(CONFIG_FSI_MASTER_HUB) += fsi-master-hub.o
>>   obj-$(CONFIG_FSI_MASTER_ASPEED) += fsi-master-aspeed.o
>>   obj-$(CONFIG_FSI_MASTER_GPIO) += fsi-master-gpio.o
>> +obj-$(CONFIG_FSI_MASTER_I2CR) += fsi-master-i2cr.o
>>   obj-$(CONFIG_FSI_MASTER_AST_CF) += fsi-master-ast-cf.o
>>   obj-$(CONFIG_FSI_SCOM) += fsi-scom.o
>>   obj-$(CONFIG_FSI_SBEFIFO) += fsi-sbefifo.o
>> diff --git a/drivers/fsi/fsi-master-i2cr.c
>> b/drivers/fsi/fsi-master-i2cr.c
>> new file mode 100644
>> index 000000000000..d19ac96c0a83
>> --- /dev/null
>> +++ b/drivers/fsi/fsi-master-i2cr.c
>> @@ -0,0 +1,225 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (C) IBM Corporation 2023 */
>> +
>> +#include <linux/device.h>
>> +#include <linux/fsi.h>
>> +#include <linux/i2c.h>
>> +#include <linux/module.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/mutex.h>
>> +
>> +#include "fsi-master.h"
>> +
>> +#define CREATE_TRACE_POINTS
>> +#include <trace/events/fsi_master_i2cr.h>
>> +
>> +#define I2CR_ADDRESS_CFAM(a)	((a) >> 2)
>> +#define I2CR_STATUS		0x30001
>> +#define  I2CR_STATUS_ERR	 BIT_ULL(61)
>> +#define I2CR_ERROR		0x30002
>> +
>> +struct fsi_master_i2cr {
>> +	struct fsi_master master;
>> +	struct mutex lock;	/* protect HW access */
>> +	struct i2c_client *client;
>> +};
>> +
>> +static bool i2cr_check_parity(u32 v, bool parity)
>> +{
>> +	u32 i;
>> +
>> +	for (i = 0; i < 32; ++i) {
>> +		if (v & (1 << i))
>> +			parity = !parity;
>> +	}
>> +
>> +	return parity;
>> +}
>> +
>> +static __be32 i2cr_get_command(u32 address, bool parity)
>> +{
>> +	__be32 command;
>> +
>> +	address <<= 1;
>> +
>> +	if (i2cr_check_parity(address, parity))
>> +		address |= 1;
>> +
>> +	command = cpu_to_be32(address);
>> +	trace_i2cr_command((__force uint32_t)command);
>> +
>> +	return command;
>> +}
>> +
>> +static int i2cr_transfer(struct i2c_client *client, u32 address,
>> __be64 *data)
> Is there a reason to use __be64 *data here and not `void *data, size_t
> len`? We never actually use it as the declared type internally, only
> cast it to __u8 *.


Well, its mostly to ensure the user buffer is at least 8 bytes. We have 
to read 8 bytes of data, so passing in a length doesn't really make sense?


>
>> +{
>> +	struct i2c_msg msgs[2];
>> +	__be32 command;
>> +	int ret;
>> +
>> +	command = i2cr_get_command(address, true);
>> +	msgs[0].addr = client->addr;
>> +	msgs[0].flags = 0;
>> +	msgs[0].len = sizeof(command);
>> +	msgs[0].buf = (__u8 *)&command;
>> +	msgs[1].addr = client->addr;
>> +	msgs[1].flags = I2C_M_RD;
>> +	msgs[1].len = sizeof(*data);
>> +	msgs[1].buf = (__u8 *)data;
>> +
>> +	ret = i2c_transfer(client->adapter, msgs, 2);
>> +	if (ret == 2)
>> +		return 0;
>> +
>> +	trace_i2cr_i2c_error(ret);
>> +
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return -EIO;
>> +}
>> +
>> +static int i2cr_check_status(struct i2c_client *client)
>> +{
>> +	__be64 status_be = 0;
>> +	u64 status;
>> +	int ret;
>> +
>> +	ret = i2cr_transfer(client, I2CR_STATUS, &status_be);
>> +	if (ret)
>> +		return ret;
>> +
>> +	status = be64_to_cpu(status_be);
>> +	if (status & I2CR_STATUS_ERR) {
>> +		__be64 error_be = 0;
>> +		u64 error;
>> +
>> +		i2cr_transfer(client, I2CR_ERROR, &error_be);
>> +		error = be64_to_cpu(error_be);
>> +		trace_i2cr_status_error(status, error);
>> +		dev_err(&client->dev, "status:%016llx error:%016llx\n", status,
>> error);
>> +		return -EREMOTEIO;
>> +	}
>> +
>> +	trace_i2cr_status(status);
>> +	return 0;
>> +}
>> +
>> +static int i2cr_read(struct fsi_master *master, int link, uint8_t id,
>> uint32_t addr, void *val,
>> +		     size_t size)
>> +{
>> +	struct fsi_master_i2cr *i2cr = container_of(master, struct
>> fsi_master_i2cr, master);
>> +	__be64 data = 0;
>> +	int ret;
>> +
>> +	if (link || id || (addr & 0xffff0000) || !size || size > 4 || size ==
>> 3)
> These size constraints are a bit funky. Instead of `!size || size > 4 ||
> size == 3` we write `!(size == 1 || size == 2 || size == 4)`?


Good idea, thanks.


>
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&i2cr->lock);
>> +
>> +	ret = i2cr_transfer(i2cr->client, I2CR_ADDRESS_CFAM(addr), &data);
>> +	if (ret)
>> +		goto unlock;
>> +
>> +	ret = i2cr_check_status(i2cr->client);
>> +	if (ret)
>> +		goto unlock;
>> +
>> +	trace_i2cr_read(addr, size, (__force uint32_t)data);
>> +	memcpy(val, &data, size);
>> +
>> +unlock:
>> +	mutex_unlock(&i2cr->lock);
>> +	return ret;
>> +}
>> +
>> +static int i2cr_write(struct fsi_master *master, int link, uint8_t id,
>> uint32_t addr,
>> +		      const void *val, size_t size)
>> +{
>> +	struct fsi_master_i2cr *i2cr = container_of(master, struct
>> fsi_master_i2cr, master);
>> +	__be32 data[3];
>> +	int ret;
>> +
>> +	if (link || id || (addr & 0xffff0000) || !size || size > 4 || size ==
>> 3)
> As above
>
>> +		return -EINVAL;
>> +
>> +	data[1] = 0;
>> +	memcpy(&data[1], val, size);
>> +	data[0] = i2cr_get_command(I2CR_ADDRESS_CFAM(addr),
>> +				   i2cr_check_parity((__force u32)data[1], true));
>> +	data[2] = 0;
>> +
>> +	mutex_lock(&i2cr->lock);
>> +
>> +	ret = i2c_master_send(i2cr->client, (const char *)data, sizeof(data));
>> +	if (ret == sizeof(data)) {
>> +		ret = i2cr_check_status(i2cr->client);
>> +		if (!ret)
>> +			trace_i2cr_write(addr, size, (__force uint32_t)data[1]);
> I think we can reduce the amount of __force if we flip the endianness
> of the data variable?
>
> ```
> u32 data[3];
> __be32 cmd_be;
>
> data[1] = 0;
> memcpy(&data[1], val, size);
> cmd_be = i2cr_get_command(I2CR_ADDRESS_CFAM(addr),
> 						    i2cr_check_parity(data[1], true));
> data[0] = (__force u32)cmd_be;
> data[2] = 0;
> ....
> trace_i2cr_write(addr, size, data[1]);
> ```
>
> ?
>
> Or define i2cr_check_parity() and the tracepoint in terms of big-endian?


I think I'll define a struct with the command as __be32 and the data as 
u32. That should clean it up.


>
>> +	} else {
>> +		trace_i2cr_i2c_error(ret);
>> +
>> +		if (ret >= 0)
>> +			ret = -EIO;
>> +	}
>> +
>> +	mutex_unlock(&i2cr->lock);
>> +	return ret;
>> +}
>> +
>> +static int i2cr_probe(struct i2c_client *client)
>> +{
>> +	struct fsi_master_i2cr *i2cr;
>> +	int ret;
>> +
>> +	i2cr = devm_kzalloc(&client->dev, sizeof(*i2cr), GFP_KERNEL);
>> +	if (!i2cr)
>> +		return -ENOMEM;
>> +
>> +	i2cr->master.dev.parent = &client->dev;
>> +	i2cr->master.dev.of_node = of_node_get(dev_of_node(&client->dev));
>> +
>> +	i2cr->master.n_links = 1;
>> +	i2cr->master.read = i2cr_read;
>> +	i2cr->master.write = i2cr_write;
>> +
>> +	mutex_init(&i2cr->lock);
>> +	i2cr->client = client;
>> +
>> +	ret = fsi_master_register(&i2cr->master);
>> +	if (ret)
>> +		return ret;
>> +
>> +	i2c_set_clientdata(client, i2cr);
>> +	return 0;
>> +}
>> +
>> +static int i2cr_remove(struct i2c_client *client)
>> +{
>> +	struct fsi_master_i2cr *i2cr = i2c_get_clientdata(client);
>> +
>> +	fsi_master_unregister(&i2cr->master);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id i2cr_i2c_ids[] = {
>> +	{ .compatible = "ibm,i2cr", },
> This may need an update after discussion on the binding patch.


Yep.


Thanks for the review!

Eddie


>
> Andrew
