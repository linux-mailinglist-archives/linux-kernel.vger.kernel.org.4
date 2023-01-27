Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9B767F024
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 22:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjA0VKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 16:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjA0VKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 16:10:49 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6D788CFF;
        Fri, 27 Jan 2023 13:10:47 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RKkX4q009673;
        Fri, 27 Jan 2023 21:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=RTHUssT+dlWyLwkJnkN9hKApxBM962TNZg8ZTAF9qhM=;
 b=jz5+jy5CsleI9FR3KLd9Z8zj015J7nGj41cIveddAMJa3+h0/L+o6K5czD/8mIJhpSan
 eyflOR2FPEYgM0W25EEXSAaUDI4q23hmZtJ6vLOpo4evUXb9Asni6GPStevWFCGdjGrk
 fKFY6XTu68DYg8CM4gDEgpW+uuhtpUGNNF3R3x0AWHXBKusJyiqDfm/b8Wns08tm+Xf8
 kl56qttkDkGS4dnjla/xuUwIygXTtoN193he5d37JK99YqvqpHwRMI810GTNj+Rq3oqW
 uLYS1+ts/32dPUaA5f5Q299nKccR5ubwK08B7MNSY6p3BCsNRM95DG5fYlXoCy0W4dmy DQ== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncm3tb07k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 21:10:27 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30RHfcGN012705;
        Fri, 27 Jan 2023 21:10:26 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3n87p84cbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 21:10:26 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30RLAP6L53674252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 21:10:25 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09EC258051;
        Fri, 27 Jan 2023 21:10:25 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B271A58060;
        Fri, 27 Jan 2023 21:10:23 +0000 (GMT)
Received: from [9.160.191.74] (unknown [9.160.191.74])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jan 2023 21:10:23 +0000 (GMT)
Message-ID: <66cc9917-ec82-27f1-1c29-0595c6c60f0a@linux.ibm.com>
Date:   Fri, 27 Jan 2023 15:10:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 2/2] fsi: Add IBM I2C Responder virtual FSI master
Content-Language: en-US
To:     Andrew Jeffery <andrew@aj.id.au>, linux-fsi@lists.ozlabs.org
Cc:     linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alistair Popple <alistair@popple.id.au>,
        Joel Stanley <joel@jms.id.au>, Jeremy Kerr <jk@ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230126213123.884125-1-eajames@linux.ibm.com>
 <20230126213123.884125-3-eajames@linux.ibm.com>
 <47d97eb4-cb75-4697-827d-4985012b3c0a@app.fastmail.com>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <47d97eb4-cb75-4697-827d-4985012b3c0a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ndfnR16DIfVhcru2NNGlkZYKnDNL_nJJ
X-Proofpoint-ORIG-GUID: ndfnR16DIfVhcru2NNGlkZYKnDNL_nJJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_12,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270189
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/26/23 19:25, Andrew Jeffery wrote:
> Hi Eddie,
>
> On Fri, 27 Jan 2023, at 08:01, Eddie James wrote:
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
>> index 000000000000..0eadc9b26063
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
>> +	if (link || id || (addr & 0xffff0000) || !(size == 1 || size == 2 ||
>> size == 4))
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
>> +	struct {
>> +		__be32 command;
>> +		u32 val;
>> +		u32 rsvd;
>> +	} __packed data = { 0, 0, 0 };
>> +	int ret;
>> +
>> +	if (link || id || (addr & 0xffff0000) || !(size == 1 || size == 2 ||
>> size == 4))
>> +		return -EINVAL;
>> +
>> +	memcpy(&data.val, val, size);
> Still nervous about endian mixups here given the buffers in val tend to
> be pointers to big-endian values but data.val is native-endian (likely
> little-endian). It probably doesn't matter functionally given we pass
> the pointer to the packed struct through i2c_master_send(), but do the
> values come out right in the trace data?
>
> What do you think about adding some commentary outlining the value
> representations to help with confidence here?


Yea, this is still not the cleanest. I'll either add comments or rework 
it a little bit. I have reworked the trace functions to get rid of any 
casting too.


>
>> +	data.command = i2cr_get_command(I2CR_ADDRESS_CFAM(addr),
>> +					i2cr_check_parity(data.val, true));
>> +
>> +	mutex_lock(&i2cr->lock);
>> +
>> +	ret = i2c_master_send(i2cr->client, (const char *)&data,
>> sizeof(data));
>> +	if (ret == sizeof(data)) {
>> +		ret = i2cr_check_status(i2cr->client);
>> +		if (!ret)
>> +			trace_i2cr_write(addr, size, data.val);
>> +	} else {
>> +		trace_i2cr_i2c_error(ret);
>> +
>> +		if (ret >= 0)
>> +			ret = -EIO;
>> +	}
> The i2cr_transfer() call in i2cr_check_status() can error but that
> won't be traced. Is that intentional? What about this instead?


i2cr_transfer itself traces on i2c error, so we should be covered? In 
your snippet below, you'll get an "i2cr_i2c_error" trace even for a 
failed status check, which isn't my intention for that function.


Thanks for the review!

Eddie


>
> ret = i2c_master_send(...)
> if (ret == sizeof(data)) {
>      ret = i2cr_check_status(i2cr->client);
> } else {
>      ret = -EIO;
> }
>
> if (ret) {
>      trace_i2cr_i2c_error(ret);
> } else {
>      trace_i2cr_write(addr, size, data.val);
> }
>
> Cheers,
>
> Andrew
