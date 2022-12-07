Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA39A6452ED
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 05:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiLGEMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 23:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiLGEMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 23:12:05 -0500
X-Greylist: delayed 1219 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Dec 2022 20:12:04 PST
Received: from gateway32.websitewelcome.com (gateway32.websitewelcome.com [192.185.145.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E7B55CA6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 20:12:04 -0800 (PST)
Received: from atl1wswcm03.websitewelcome.com (unknown [50.6.129.164])
        by atl3wswob03.websitewelcome.com (Postfix) with ESMTP id A1843E370
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 03:51:44 +0000 (UTC)
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTP
        id 2lTBprp5cHV9c2lTDpK9YH; Wed, 07 Dec 2022 03:51:44 +0000
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IGd+S9iKxc/QWHPNM22V3DTZnmHuJbTeEl2S7KOPdTg=; b=FEyxXrPQoS41HvKRTptp5udgOA
        1Jehj7dxZeCrCfAz5Rv2nM7i+RFlmSrFvPg7wtq/Q2Xt0EnzQAT169YLZG5QiOuaE7WpJLN2CVY20
        txwCl9rEia9p0pCPTeIjaSigqdGRSoY9IqW+iDTCgLbq5y5WdlnespgorHtjqQb3GkDcggMRceKhk
        DpmSM3Oz1sfb1C83wfN8I0sfyGYj2/AWmcsauiRyZlABHNdsAJgR6IhoTUG7vJGQePC7reFFKNEG/
        hyg24qzH/2FpjtiYl0OcCYHqxRM8CJLB1A32SVqMT+ac79JEz6ptifOteSmNULVtinIHC62zcplaB
        GtS+QRcQ==;
Received: from [106.203.57.45] (port=20281 helo=[192.168.40.42])
        by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <saravanan@linumiz.com>)
        id 1p2lTA-001bAN-KR;
        Wed, 07 Dec 2022 03:51:40 +0000
Message-ID: <6773256d-2842-fadc-1222-f76e0b495eda@linumiz.com>
Date:   Wed, 7 Dec 2022 04:51:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 3/4] hwmon: (pmbus/mpq7932) Add a support for mpq7932
 Power Management IC
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, jdelvare@suse.com,
        marten.lindahl@axis.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221201044643.1150870-1-saravanan@linumiz.com>
 <20221201044643.1150870-4-saravanan@linumiz.com>
 <00de62b2-51dc-2a72-6659-3425d5e1b72c@roeck-us.net>
Content-Language: en-US
From:   Saravanan Sekar <saravanan@linumiz.com>
In-Reply-To: <00de62b2-51dc-2a72-6659-3425d5e1b72c@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 106.203.57.45
X-Source-L: No
X-Exim-ID: 1p2lTA-001bAN-KR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.40.42]) [106.203.57.45]:20281
X-Source-Auth: saravanan@linumiz.com
X-Email-Count: 1
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDaAaZ6DHAkmc23jz6CA+vCQRUQYyMTDX/oBXNHkEwlS/ywgz29mI/1NEBptwZSVkohFvGXfFXmBkWz9M9xTUKSxpS7SO91SUZ1qKxhp2WB0i7ylzx+e
 /9dxJBRdqlYigk1ODnzZr0m5TxYDj98rgjn2HLYArll44tUQ0/iTBRAVxauBYKg86Yq+hl8AftG40EnVEbF5bhoNxYqKHBV2vjk=
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/22 16:34, Guenter Roeck wrote:
> On 11/30/22 20:46, Saravanan Sekar wrote:
>> The MPQ7932 is a power management IC designed to operate from 5V buses to
>> power a variety of Advanced driver-assistance system SOCs. Six integrated
>> buck converters with hardware monitoring capability powers a variety of
>> target rails configurable over PMBus interface.
>>
>> Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
>> ---
>>   drivers/hwmon/pmbus/Kconfig   |  10 +++
>>   drivers/hwmon/pmbus/Makefile  |   1 +
>>   drivers/hwmon/pmbus/mpq7932.c | 144 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 155 insertions(+)
>>   create mode 100644 drivers/hwmon/pmbus/mpq7932.c
>>
>> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
>> index 89668af67206..4a1538949a73 100644
>> --- a/drivers/hwmon/pmbus/Kconfig
>> +++ b/drivers/hwmon/pmbus/Kconfig
>> @@ -317,6 +317,16 @@ config SENSORS_MP5023
>>         This driver can also be built as a module. If so, the module will
>>         be called mp5023.
>> +config SENSORS_MPQ7932
>> +    tristate "MPS MPQ7932"
> 
> As written, a dependency on REGULATOR is missing. However, we want the 
> driver
> enabled even if CONFIG_REGULATOR is not enabled. I would suggest to 
> follow the
> approach used by other drivers: add a second configuration option
> SENSORS_MPQ7932_REGULATOR which depends on SENSORS_MPQ7932 and REGULATOR
> and enables regulator functionality, and use that in the driver to
> make regulator support optional.
> 

Hello Guenter,

I need clarification or confirmation from you before V3.

Here is my view, communication to MPQ7932 PMIC chip is based on pmbus 
specification.

Now the conflict is that we have pmbus directory under hwmon subsystem, 
if pmbus spec implementation would have been separate like i2c-smbus 
then we can implement chip driver in regulator subsystem which access pmbus.

pmbus_core does supports regulator framework PMBUS_REGUALTOR and I 
believe it is valid MPQ7932 driver implantation under pmbus directory.

Kindly suggest to remove pmbus dependency on hwmon and proceed further.


>> +    help
>> +      If you say yes here you get six integrated buck converter 
>> regulator
>> +      with hardware monitoring functionality support for power 
>> management
>> +      IC MPS MPQ7932.
> 
> That description is more appropriate for the second configuration option.
> Primarily one gets hardware monitoring support for the chip.
> 
>> +
>> +      This driver can also be built as a module. If so, the module will
>> +      be called mpq7932.
>> +
>>   config SENSORS_PIM4328
>>       tristate "Flex PIM4328 and compatibles"
>>       help
>> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
>> index 0002dbe22d52..28a534629cc3 100644
>> --- a/drivers/hwmon/pmbus/Makefile
>> +++ b/drivers/hwmon/pmbus/Makefile
>> @@ -34,6 +34,7 @@ obj-$(CONFIG_SENSORS_MAX8688)    += max8688.o
>>   obj-$(CONFIG_SENSORS_MP2888)    += mp2888.o
>>   obj-$(CONFIG_SENSORS_MP2975)    += mp2975.o
>>   obj-$(CONFIG_SENSORS_MP5023)    += mp5023.o
>> +obj-$(CONFIG_SENSORS_MPQ7932_REGULATOR) += mpq7932.o
>>   obj-$(CONFIG_SENSORS_PLI1209BC)    += pli1209bc.o
>>   obj-$(CONFIG_SENSORS_PM6764TR)    += pm6764tr.o
>>   obj-$(CONFIG_SENSORS_PXE1610)    += pxe1610.o
>> diff --git a/drivers/hwmon/pmbus/mpq7932.c 
>> b/drivers/hwmon/pmbus/mpq7932.c
>> new file mode 100644
>> index 000000000000..3747d7862afd
>> --- /dev/null
>> +++ b/drivers/hwmon/pmbus/mpq7932.c
>> @@ -0,0 +1,144 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0+
> 
> The SPDX license must be in the first line and be a C++ style comment.
> Please run checkpatch --strict and fix what it reports (including the
> various continuation line misalignments and unnecessary empty lines).
> 
>> + *
>> + * mpq7932.c  - regulator driver for mps mpq7932
>> + * Copyright 2022 Monolithic Power Systems, Inc
> 
> This is a hwmon driver with optional regulator functionality.
> 
>> + *
>> + * Author: Saravanan Sekar <saravanan@linumiz.com>
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/i2c.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/pmbus.h>
>> +#include "pmbus.h"
>> +
>> +#define MPQ7932_BUCK_UV_MIN        206250
>> +#define MPQ7932_UV_STEP            6250
>> +#define MPQ7932_N_VOLTAGES        0xFF
>> +#define MPQ7932_NUM_PAGES        6
>> +
>> +#define MPQ7932_TON_DELAY        0x60
>> +#define MPQ7932_VOUT_STARTUP_SLEW    0xA3
>> +#define MPQ7932_VOUT_SHUTDOWN_SLEW    0xA5
>> +#define MPQ7932_VOUT_SLEW_MASK        GENMASK(1, 0)
>> +#define MPQ7932_TON_DELAY_MASK        GENMASK(4, 0)
> 
> Please include the appropriate include file defining GENMASK.
> 
>> +
>> +struct mpq7932_data {
>> +    struct pmbus_driver_info info;
>> +    struct pmbus_platform_data pdata;
>> +};
>> +
>> +static struct regulator_desc mpq7932_regulators_desc[] = {
>> +    PMBUS_REGULATOR_STEP("buck", 0, MPQ7932_N_VOLTAGES,
>> +                MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
>> +    PMBUS_REGULATOR_STEP("buck", 1, MPQ7932_N_VOLTAGES,
>> +                MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
>> +    PMBUS_REGULATOR_STEP("buck", 2, MPQ7932_N_VOLTAGES,
>> +                MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
>> +    PMBUS_REGULATOR_STEP("buck", 3, MPQ7932_N_VOLTAGES,
>> +                MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
>> +    PMBUS_REGULATOR_STEP("buck", 4, MPQ7932_N_VOLTAGES,
>> +                MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
>> +    PMBUS_REGULATOR_STEP("buck", 5, MPQ7932_N_VOLTAGES,
>> +                MPQ7932_UV_STEP, MPQ7932_BUCK_UV_MIN),
>> +};
>> +
>> +static int mpq7932_write_word_data(struct i2c_client *client, int 
>> page, int reg,
>> +                   u16 word)
>> +{
>> +
>> +    switch (reg) {
>> +    case PMBUS_VOUT_COMMAND:
> 
> This needs a comment explaining why it is needed.
> 
>> +        return pmbus_write_byte_data(client, page, reg, (u8)word);
> 
> word should be clamped to [0, 255], not cut off.
> 
>> +
>> +    default:
>> +        return -ENODATA;
>> +    }
>> +}
>> +
>> +static int mpq7932_read_word_data(struct i2c_client *client, int page,
>> +                  int phase, int reg)
>> +{
>> +
>> +    switch (reg) {
>> +    case PMBUS_MFR_VOUT_MIN:
>> +        return 0;
>> +
>> +    case PMBUS_MFR_VOUT_MAX:
>> +        return MPQ7932_N_VOLTAGES;
> 
> The above need comments. Also, MPQ7932_N_VOLTAGES is inappropriate. This 
> is not the
> number of voltages, it is the maximum voltage. Even if the values happen 
> to be the
> same, the content is different.
> 
> Also, with PMBUS_MFR_VOUT_MIN=0 and PMBUS_MFR_VOUT_MAX=0xff, the number 
> of voltages
> would actually be 256, not 255.
> 
>> +
>> +    case PMBUS_READ_VOUT:
>> +        return pmbus_read_byte_data(client, page, PMBUS_VOUT_COMMAND);
>> +
> Needs same comment as above.
> 
>> +    default:
>> +        return -ENODATA;
>> +    }
>> +}
>> +
>> +static int mpq7932_probe(struct i2c_client *client)
>> +{
>> +    struct mpq7932_data *data;
>> +    struct pmbus_driver_info *info;
>> +    struct device *dev = &client->dev;
>> +    int i;
>> +
>> +    if (!i2c_check_functionality(client->adapter,
>> +                     I2C_FUNC_SMBUS_READ_WORD_DATA))
> 
> Unnecessary check. This code doesn't use it, and pmbus_do_probe()
> does its own check.
> 
>> +        return -ENODEV;
>> +
>> +    data = devm_kzalloc(&client->dev, sizeof(struct mpq7932_data),
> 
> Use dev.
> 
>> +                GFP_KERNEL);
>> +    if (!data)
>> +        return -ENOMEM;
>> +
>> +    info = &data->info;
>> +    info->pages = MPQ7932_NUM_PAGES;
>> +    info->num_regulators = ARRAY_SIZE(mpq7932_regulators_desc);
>> +    info->reg_desc = mpq7932_regulators_desc;
>> +    info->format[PSC_VOLTAGE_OUT] = direct;
>> +    info->m[PSC_VOLTAGE_OUT] = 160;
>> +    info->b[PSC_VOLTAGE_OUT] = -33;
>> +    for (i = 0; i < info->pages; i++) {
>> +        info->func[i] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
>> +                | PMBUS_HAVE_STATUS_TEMP;
> 
> I think I already asked: Is this really all telemetry supported by the 
> chip ?
> I keep asking because that would be highly unusual.
> 

Yes, only the above.

Thanks,
Saravanan

>> +    }
>> +
>> +    info->read_word_data = mpq7932_read_word_data;
>> +    info->write_word_data = mpq7932_write_word_data;
>> +
>> +    data->pdata.flags = PMBUS_NO_CAPABILITY;
>> +    dev->platform_data = &data->pdata;
>> +
>> +    return pmbus_do_probe(client, info);
>> +}
>> +
>> +static const struct of_device_id mpq7932_of_match[] = {
>> +    { .compatible = "mps,mpq7932"},
>> +    {},
>> +};
>> +MODULE_DEVICE_TABLE(of, mpq7932_of_match);
>> +
>> +static const struct i2c_device_id mpq7932_id[] = {
>> +    { "mpq7932", },
>> +    { },
>> +};
>> +MODULE_DEVICE_TABLE(i2c, mpq7932_id);
>> +
>> +static struct i2c_driver mpq7932_regulator_driver = {
>> +    .driver = {
>> +        .name = "mpq7932",
>> +        .of_match_table = mpq7932_of_match,
>> +    },
>> +    .probe_new = mpq7932_probe,
>> +    .id_table = mpq7932_id,
>> +};
>> +module_i2c_driver(mpq7932_regulator_driver);
>> +
>> +MODULE_AUTHOR("Saravanan Sekar <saravanan@linumiz.com>");
>> +MODULE_DESCRIPTION("MPQ7932 PMIC regulator driver");
>> +MODULE_LICENSE("GPL");
>> +MODULE_IMPORT_NS(PMBUS);
> 
