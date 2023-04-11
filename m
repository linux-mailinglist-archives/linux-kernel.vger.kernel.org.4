Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9ED6DCFD0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 04:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjDKCoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 22:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjDKCox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 22:44:53 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B52E2708;
        Mon, 10 Apr 2023 19:44:51 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id 20so8288751plk.10;
        Mon, 10 Apr 2023 19:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681181090; x=1683773090;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tlM+HLhi2gRLnbnVQvV7Sb3IibVcQ8sToyvyxMAW8ic=;
        b=Hk4izD9mz/9qlKuZx+P20GHRICBFVqHqEGygHhdJxe0lw2m7dSsyKLiKagjpBc4/d0
         5N5sSbx4bckcJkvV9RvYgoV1dfqcD/WMNAK+E4SpAxun/mGgZXn28jjgL7F3MXFs+eAc
         C1OwIGEzguCrm+4F/DNy2hoLJoXDYDXydOi79BuUcxOe+rDf5VHZEwHmYkMxYaOA8IH0
         nm81ZeaeEkEk4+E59UNf8OFEiHvHjyKBBUa2gFziAT6Wok0/3SzBz44LtS/PbGlfWktQ
         KNReuCYUMlBOtIpUmLFbiWs4Q73S0kAtdHOHJYageVerLwjdKPUxkdtXudOgayUZAbS4
         n+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681181090; x=1683773090;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tlM+HLhi2gRLnbnVQvV7Sb3IibVcQ8sToyvyxMAW8ic=;
        b=KDgvO4MDXrzG9JFeMfGx6Db97m3lntKLvXTHpYRWE4eR53xUj/g1heJdVCINEvdH95
         lwn4dGlhVxuNxPw4V39XakftgriloTVvQ/ytdIDHgG3kkXNcbBY8rLY+5yXLevVQP/PO
         sYf1tgy8t5qTA10pIwXYHeVHQJ6bMFg9n5y21N+hScUFdbnXXKJmPBhLEwsDglEUu9vH
         A819RF5tiRhFtm7Svkp4jy/AfSHMaEKsRqJizm28/GdGGzcYw4vF1cd5HSa6DItbW/vK
         ulNbWLY0L+Vy+yExtW08H9o87S0dgB0BnKbPM7YopLt7O7I7ONU0SvFfs3tvKXsXGBv9
         kYJw==
X-Gm-Message-State: AAQBX9d859lBkLP4bUsXSHZno7Z7BpP0nGxq/SjBFN9PhLqy1DEFQKSY
        ATNb9FVBg0Mkze6G/kwiOoo=
X-Google-Smtp-Source: AKy350YHu+T/EwBJOIPDAc7mxUJoy2LbnHJrEBc8X6JMBFfN+XuYcjcfq6pKAR9dAph1B8qInYVn9Q==
X-Received: by 2002:a17:90b:1c88:b0:23f:9439:9a27 with SMTP id oo8-20020a17090b1c8800b0023f94399a27mr15793326pjb.20.1681181090183;
        Mon, 10 Apr 2023 19:44:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jo23-20020a170903055700b001a6527f6ad7sm598077plb.85.2023.04.10.19.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 19:44:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <09730359-8731-e21e-3335-bf60ba7f1280@roeck-us.net>
Date:   Mon, 10 Apr 2023 19:44:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     dinh.nguyen@linux.intel.com, linux-hwmon@vger.kernel.org
Cc:     dinguyen@kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230410153314.27127-1-dinh.nguyen@linux.intel.com>
 <20230410153314.27127-3-dinh.nguyen@linux.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 3/5] hwmon: (socfpga) Add hardware monitoring support on
 SoCFPGA platforms
In-Reply-To: <20230410153314.27127-3-dinh.nguyen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/23 08:33, dinh.nguyen@linux.intel.com wrote:
> From: Dinh Nguyen <dinh.nguyen@linux.intel.com>
> 
> The driver supports 64-bit SoCFPGA platforms for temperature and voltage
> reading using the platform's SDM(Secure Device Manager). The driver
> also uses the Stratix10 Service layer driver.
> 
> This driver only supports OF SoCFPGA 64-bit platforms.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Dinh Nguyen <dinh.nguyen@linux.intel.com>
> ---
>   Documentation/hwmon/index.rst                 |   1 +
>   Documentation/hwmon/socfpga-hwmon.rst         |  30 ++
>   drivers/firmware/stratix10-svc.c              |  18 +-

Changes outside the hwmon subsystem need to be in a separate patch.

>   drivers/hwmon/Kconfig                         |  11 +
>   drivers/hwmon/Makefile                        |   1 +
>   drivers/hwmon/socfpga-hwmon.c                 | 406 ++++++++++++++++++
>   include/linux/firmware/intel/stratix10-smc.h  |  34 ++
>   .../firmware/intel/stratix10-svc-client.h     |   6 +
>   8 files changed, 506 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/hwmon/socfpga-hwmon.rst
>   create mode 100644 drivers/hwmon/socfpga-hwmon.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index f1fe75f596a5..9db4e1537481 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -196,6 +196,7 @@ Hardware Monitoring Kernel Drivers
>      smsc47b397
>      smsc47m192
>      smsc47m1
> +   socfpga-hwmon
>      sparx5-temp
>      stpddc60
>      sy7636a-hwmon
> diff --git a/Documentation/hwmon/socfpga-hwmon.rst b/Documentation/hwmon/socfpga-hwmon.rst
> new file mode 100644
> index 000000000000..f6565c83cf40
> --- /dev/null
> +++ b/Documentation/hwmon/socfpga-hwmon.rst
> @@ -0,0 +1,30 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +Kernel driver socfpga-hwmon
> +===========================
> +
> +Supported chips:
> +
> + * Intel Stratix10
> + * Intel Agilex
> + * Intel N5X
> +
> +Author: Dinh Nguyen <dinh.nguyen@linux.intel.com>
> +
> +Description
> +-----------
> +
> +This driver supports hardware monitoring for 64-Bit SoCFPGA and eASIC devices
> +based around the Secure Device Manager and Stratix 10 Service layer.
> +
> +The following sensor types are supported:
> +
> +  * temperature
> +  * voltage
> +
> +Usage Notes
> +-----------
> +
> +The driver relies on a device tree node to enumerate support present on the
> +specific device. See Documentation/devicetree/bindings/hwmon/intel,socfpga-hwmon.yaml
> +for details of the device-tree node.
> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
> index bde1f543f529..cc1b8b441c37 100644
> --- a/drivers/firmware/stratix10-svc.c
> +++ b/drivers/firmware/stratix10-svc.c
> @@ -340,6 +340,8 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
>   	case COMMAND_RSU_MAX_RETRY:
>   	case COMMAND_RSU_DCMF_STATUS:
>   	case COMMAND_FIRMWARE_VERSION:
> +	case COMMAND_HWMON_READTEMP:
> +	case COMMAND_HWMON_READVOLT:
>   		cb_data->status = BIT(SVC_STATUS_OK);
>   		cb_data->kaddr1 = &res.a1;
>   		break;
> @@ -517,7 +519,17 @@ static int svc_normal_to_secure_thread(void *data)
>   			a1 = (unsigned long)pdata->paddr;
>   			a2 = 0;
>   			break;
> -
> +		/* for HWMON */
> +		case COMMAND_HWMON_READTEMP:
> +			a0 = INTEL_SIP_SMC_HWMON_READTEMP;
> +			a1 = pdata->arg[0];
> +			a2 = 0;
> +			break;
> +		case COMMAND_HWMON_READVOLT:
> +			a0 = INTEL_SIP_SMC_HWMON_READVOLT;
> +			a1 = pdata->arg[0];
> +			a2 = 0;
> +			break;
>   		/* for polling */
>   		case COMMAND_POLL_SERVICE_STATUS:
>   			a0 = INTEL_SIP_SMC_SERVICE_COMPLETED;
> @@ -1182,6 +1194,10 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
>   	chans[2].name = SVC_CLIENT_FCS;
>   	spin_lock_init(&chans[2].lock);
>   
> +	chans[3].ctrl = controller;
> +	chans[3].name = SVC_CLIENT_HWMON;
> +	spin_lock_init(&chans[3].lock);
> +
>   	list_add_tail(&controller->node, &svc_ctrl);
>   	platform_set_drvdata(pdev, controller);
>   
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 5b3b76477b0e..c7c978acfece 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1875,6 +1875,17 @@ config SENSORS_SMSC47M192
>   	  This driver can also be built as a module. If so, the module
>   	  will be called smsc47m192.
>   
> +config SENSORS_SOCFPGA
> +	tristate "SoCFPGA Hardware monitoring features"
> +	depends on INTEL_STRATIX10_SERVICE
> +	depends on OF || COMPILE_TEST
> +	help
> +	  If you say yes here you get support for the temperature and
> +	  voltage sensors of 64-bit SoCFPGA devices.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called socfpga-hwmon.
> +
>   config SENSORS_SMSC47B397
>   	tristate "SMSC LPC47B397-NC"
>   	depends on !PPC
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 88712b5031c8..c04c0b2578a4 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -193,6 +193,7 @@ obj-$(CONFIG_SENSORS_SMPRO)	+= smpro-hwmon.o
>   obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc47b397.o
>   obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
>   obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
> +obj-$(CONFIG_SENSORS_SOCFPGA)	+= socfpga-hwmon.o
>   obj-$(CONFIG_SENSORS_SPARX5)	+= sparx5-temp.o
>   obj-$(CONFIG_SENSORS_STTS751)	+= stts751.o
>   obj-$(CONFIG_SENSORS_SY7636A)	+= sy7636a-hwmon.o
> diff --git a/drivers/hwmon/socfpga-hwmon.c b/drivers/hwmon/socfpga-hwmon.c
> new file mode 100644
> index 000000000000..636e6e269578
> --- /dev/null
> +++ b/drivers/hwmon/socfpga-hwmon.c
> @@ -0,0 +1,406 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SoCFPGA hardware monitoring features
> + *
> + * Copyright (c) 2023 Intel Corporation. All rights reserved
> + */
> +#include <linux/arm-smccc.h>
> +#include <linux/hwmon.h>
> +#include <linux/firmware/intel/stratix10-svc-client.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/units.h>
> +
> +#define HWMON_TIMEOUT	msecs_to_jiffies(SVC_HWMON_REQUEST_TIMEOUT_MS)
> +
> +/*
> + * When bit 31 is set, an error condition has been detected in the
> + * temperature sensor.
> + */
> +#define ETEMP_ERROR			BIT(31)
> +/*
> + * Selected temperature sensor channel is currently inactive.
> + * Ensure that the tile where the TSD is located is actively in use.
> + */
> +#define ETEMP_INACTIVE			0x0
> +/*
> + * Selected temperature sensor channel returned a value that is not the
> + * latest reading. Try retrieve the temperature reading again.
> + */
> +#define ETEMP_TOO_OLD			0x1
> +/*
> + * Selected temperature sensor channel is invalid for the device. Ignore
> + * the returned data because the temperature sensor channel location is
> + * invalid.
> + */
> +/* > + * System is corrupted or failed to respond.
> + */
> +#define ETEMP_TIMEOUT			0x3
> +#define ETEMP_CORRUPT			0x4
> +/*
> + * Communication mechanism is busy.
> + */
> +#define ETEMP_BUSY			0x5
> +/*
> + * System is corrupted or failed to respond.
> + */
> +#define ETEMP_NOT_INITIALIZED		0xFF
> +
> +#define SOCFPGA_HWMON_MAXSENSORS	16
> +
> +/**
> + * struct socfpga_hwmon_chan - channel input parameters.
> + * @n : Number of channels.
> + * @value: value read from the chip.
> + * @names: names array from DTS labels.
> + * @chan: channel array.
> + *
> + * The structure represents either the voltage or temperature information
> + * for the hwmon channels.
> + */
> +struct socfpga_hwmon_chan {
> +	unsigned int n;
> +	int value;
> +	const char *names[SOCFPGA_HWMON_MAXSENSORS];
> +	u32 chan[SOCFPGA_HWMON_MAXSENSORS];
> +};
> +
> +struct socfpga_hwmon_priv {
> +	struct stratix10_svc_client client;
> +	struct stratix10_svc_client_msg msg;
> +	struct stratix10_svc_chan *chan;
> +	struct completion completion;
> +	struct mutex lock;
> +	struct socfpga_hwmon_chan temperature;
> +	struct socfpga_hwmon_chan voltage;
> +};
> +
> +enum hwmon_type_op {
> +	SOCFPGA_HWMON_TYPE_TEMP,
> +	SOCFPGA_HWMON_TYPE_VOLT,
> +	SOCFPGA_HWMON_TYPE_MAX

Unused define

> +};
> +
> +static const char *const hwmon_types_str[] = { "temperature", "voltage" };
> +
> +static umode_t socfpga_is_visible(const void *dev,
> +				  enum hwmon_sensor_types type,
> +				  u32 attr, int chan)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +	case hwmon_in:
> +		return 0444;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static void socfpga_smc_callback(struct stratix10_svc_client *client,
> +					  struct stratix10_svc_cb_data *data)
> +{
> +	struct socfpga_hwmon_priv *priv = client->priv;
> +	struct arm_smccc_res *res = data->kaddr1;
> +
> +	if (data->status == BIT(SVC_STATUS_OK))	{
> +		if (priv->msg.command == COMMAND_HWMON_READTEMP)
> +			priv->temperature.value = res->a0;
> +		else
> +			priv->voltage.value = res->a0;
> +	} else
> +		dev_err(client->dev, "%s returned 0x%lX\n", __func__, res->a0);
> +

Missing { } in else branch. Please run checkpatch --strict and fix
continuation line alignment issues as well as unbalanced if/else
reports.

> +	complete(&priv->completion);
> +}
> +
> +static int socfpga_hwmon_send(struct socfpga_hwmon_priv *priv)
> +{
> +	int ret;
> +
> +	priv->client.receive_cb = socfpga_smc_callback;
> +
> +	ret = stratix10_svc_send(priv->chan, &priv->msg);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!wait_for_completion_timeout(&priv->completion, HWMON_TIMEOUT)) {
> +		dev_err(priv->client.dev, "SMC call timeout!\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int socfpga_hwmon_err_to_errno(struct socfpga_hwmon_priv *priv)
> +{
> +	int value = priv->temperature.value;
> +
> +	if (!(value & ETEMP_ERROR))
> +		return 0;
> +

This is odd. int is normally 32 bit, this function is called from
socfpga_read() for temperatures, which presumably are defined
as "signed 32-bit fixed point binary". That means that negative
temperatures would be treated as errors. Please verify.

> +	dev_err(priv->client.dev, "temperature sensor code 0x%08x\n", value);
> +

Please don't clog the log with such messages.

> +	value &= ~ETEMP_ERROR;
> +	switch (value) {
> +	case ETEMP_NOT_PRESENT:
> +		return -ENOENT;
> +	case ETEMP_CORRUPT:
> +	case ETEMP_NOT_INITIALIZED:
> +		return -ENODATA;
> +	case ETEMP_BUSY:
> +		return -EBUSY;
> +	case ETEMP_INACTIVE:
> +	case ETEMP_TIMEOUT:
> +	case ETEMP_TOO_OLD:
> +		return -EAGAIN;
> +	default:
> +		/* Unknown error */
> +		return -EINVAL;

Should be -EIO.

> +	}
> +}
> +
> +static int socfpga_read(struct device *dev, enum hwmon_sensor_types type,
> +			u32 attr, int chan, long *val)
> +{
> +	struct socfpga_hwmon_priv *priv = dev_get_drvdata(dev);
> +	int ret;
> +
> +	mutex_lock(&priv->lock);
> +	reinit_completion(&priv->completion);
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		priv->msg.arg[0] = BIT_ULL(priv->temperature.chan[chan]);
> +		priv->msg.command = COMMAND_HWMON_READTEMP;
> +		if (socfpga_hwmon_send(priv))
> +			goto status_done;
> +
> +		ret = socfpga_hwmon_err_to_errno(priv);
> +		if (ret)
> +			break;
> +		/*
> +		 * The Temperature Sensor IP core returns the Celsius
> +		 * temperature value in signed 32-bit fixed point binary
> +		 * format, with eight bits below binary point.
> +		 */
> +		*val = (priv->temperature.value * MILLIDEGREE_PER_DEGREE) / 256;
> +		break;
> +	case hwmon_in: /* Read voltage */

Pointless comment

> +		priv->msg.arg[0] = BIT_ULL(priv->voltage.chan[chan]);
> +		priv->msg.command = COMMAND_HWMON_READVOLT;
> +		if (socfpga_hwmon_send(priv))
> +			goto status_done;
> +

No error check for voltage sensors ?
Also, unless I am missing something, the error bailout leaves ret
undefined.

> +		/*
> +		 * The Voltage Sensor IP core returns the sampled voltage
> +		 * in unsigned 32-bit fixed point binary format, with 16 bits
> +		 * below binary point.
> +		 */
> +		*val = (priv->voltage.value * MILLIVOLT_PER_VOLT) / 65536;
> +		break;
> +	default:
> +		ret = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +status_done:
> +	stratix10_svc_done(priv->chan);
> +	mutex_unlock(&priv->lock);
> +	return ret;
> +}
> +
> +static int socfpga_read_string(struct device *dev,
> +			       enum hwmon_sensor_types type, u32 attr,
> +			       int chan, const char **str)
> +{
> +	struct socfpga_hwmon_priv *priv = dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_in:
> +		*str = priv->voltage.names[chan];
> +		return 0;
> +	case hwmon_temp:
> +		*str = priv->temperature.names[chan];
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static const struct hwmon_ops socfpga_ops = {
> +	.is_visible = socfpga_is_visible,
> +	.read = socfpga_read,
> +	.read_string = socfpga_read_string,
> +};
> +
> +static const struct hwmon_channel_info *socfpga_info[] = {
> +	HWMON_CHANNEL_INFO(temp,
> +		HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
> +		HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
> +		HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
> +		HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
> +		HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
> +		HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
> +		HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
> +		HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL),
> +	HWMON_CHANNEL_INFO(in,
> +		HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
> +		HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
> +		HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
> +		HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
> +		HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
> +		HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
> +		HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
> +		HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info socfpga_chip_info = {
> +	.ops = &socfpga_ops,
> +	.info = socfpga_info,
> +};
> +
> +static int socfpga_add_channel(struct device *dev,  const char *type,
> +				u32 val, const char *label,
> +				struct socfpga_hwmon_priv *priv)
> +{
> +	int type_index;
> +	struct socfpga_hwmon_chan *p;
> +
> +	type_index = match_string(hwmon_types_str, ARRAY_SIZE(hwmon_types_str), type);
> +	switch (type_index) {
> +	case SOCFPGA_HWMON_TYPE_TEMP:
> +		p = &priv->temperature;
> +		break;
> +	case SOCFPGA_HWMON_TYPE_VOLT:
> +		p = &priv->voltage;
> +		break;
> +	default:
> +		return -ENODATA;
> +	}
> +	if (p->n >= SOCFPGA_HWMON_MAXSENSORS)
> +		return -ENOSPC;
> +
> +	p->names[p->n] = label;
> +	p->chan[p->n] = val;
> +	p->n++;
> +
> +	return 0;
> +}
> +
> +static int socfpga_probe_child_from_dt(struct device *dev,
> +				       struct device_node *child,
> +				       struct socfpga_hwmon_priv *priv)
> +{
> +	struct device_node *grandchild;
> +	const char *label;
> +	const char *type;
> +	u32 val;
> +	int ret;
> +
> +	if (of_property_read_string(child, "name", &type))
> +		return dev_err_probe(dev, -EINVAL, "No type for %pOF\n", child);
> +
> +	for_each_child_of_node(child, grandchild) {
> +		ret = of_property_read_u32(grandchild, "reg", &val);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "missing reg property of %pOF\n",
> +					     grandchild);
> +
> +		ret = of_property_read_string(grandchild, "label", &label);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "missing label propoerty of %pOF\n",
> +					     grandchild);
> +		ret = socfpga_add_channel(dev, type, val, label, priv);
> +		if (ret == -ENOSPC)
> +			return dev_err_probe(dev, ret, "too many channels, only %d supported\n",
> +					     SOCFPGA_HWMON_MAXSENSORS);
> +	}
> +	return 0;
> +}
> +
> +static int socfpga_probe_from_dt(struct device *dev,
> +				 struct socfpga_hwmon_priv *priv)
> +{
> +	const struct device_node *np = dev->of_node;
> +	struct device_node *child;
> +	int ret = 0;
> +
> +	for_each_child_of_node(np, child) {
> +		ret = socfpga_probe_child_from_dt(dev, child, priv);
> +		if (ret)
> +			break;
> +	}
> +	of_node_put(child);
> +
> +	return ret;
> +}
> +
> +static int socfpga_hwmon_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device *hwmon_dev;
> +	struct socfpga_hwmon_priv *priv;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->client.dev = dev;
> +	priv->client.priv = priv;
> +
> +	ret = socfpga_probe_from_dt(dev, priv);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Unable to probe from device tree\n");
> +
> +	mutex_init(&priv->lock);
> +	init_completion(&priv->completion);
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev, "socfpgahwmon",
> +							 priv,
> +							 &socfpga_chip_info,
> +							 NULL);
> +	if (IS_ERR(hwmon_dev))
> +		return PTR_ERR(hwmon_dev);
> +
> +	priv->chan = stratix10_svc_request_channel_byname(&priv->client,
> +					SVC_CLIENT_HWMON);

This is racy: hwmon attributes exist here, and priv->chan may be accessed before
it is set.

> +	if (IS_ERR(priv->chan))
> +		return dev_err_probe(dev, PTR_ERR(priv->chan),
> +				     "couldn't get service channel %s\n",
> +				     SVC_CLIENT_RSU);
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	return 0;
> +}
> +
> +static int socfpga_hwmon_remove(struct platform_device *pdev)
> +{
> +	struct socfpga_hwmon_priv *priv = platform_get_drvdata(pdev);
> +
> +	stratix10_svc_free_channel(priv->chan);

This releases the channel before the hwmon device is released.
Another race condition.

> +	return 0;
> +}
> +
> +static const struct of_device_id socfpga_of_match[] = {
> +	{ .compatible = "intel,socfpga-hwmon" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, socfpga_of_match);
> +
> +static struct platform_driver socfpga_hwmon_driver = {
> +	.driver = {
> +		.name = "socfpga-hwmon",
> +		.of_match_table = socfpga_of_match,
> +	},
> +	.probe = socfpga_hwmon_probe,
> +	.remove = socfpga_hwmon_remove,
> +};
> +module_platform_driver(socfpga_hwmon_driver);
> +
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_DESCRIPTION("SoCFPGA hardware monitoring features");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
> index a718f853d457..b944ec4b2b2f 100644
> --- a/include/linux/firmware/intel/stratix10-smc.h
> +++ b/include/linux/firmware/intel/stratix10-smc.h
> @@ -595,4 +595,38 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
>   #define INTEL_SIP_SMC_FCS_GET_PROVISION_DATA \
>   	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_GET_PROVISION_DATA)
>   
> +/**
> + * Request INTEL_SIP_SMC_HWMON_READTEMP
> + * Sync call to request temperature
> + *
> + * Call register usage:
> + * a0 Temperature Channel
> + * a1-a7 not used
> + *
> + * Return status
> + * a0 INTEL_SIP_SMC_STATUS_OK
> + * a1 Temperature Value
> + * a2-a3 not used
> + */
> +#define INTEL_SIP_SMC_FUNCID_HWMON_READTEMP 32
> +#define INTEL_SIP_SMC_HWMON_READTEMP \
> +	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_HWMON_READTEMP)
> +
> +/**
> + * Request INTEL_SIP_SMC_HWMON_READVOLT
> + * Sync call to request voltage
> + *
> + * Call register usage:
> + * a0 Voltage Channel
> + * a1-a7 not used
> + *
> + * Return status
> + * a0 INTEL_SIP_SMC_STATUS_OK
> + * a1 Voltage Value
> + * a2-a3 not used
> + */
> +#define INTEL_SIP_SMC_FUNCID_HWMON_READVOLT 33
> +#define INTEL_SIP_SMC_HWMON_READVOLT \
> +	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_HWMON_READVOLT)
> +
>   #endif
> diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
> index 0c16037fd08d..343970dcc2d2 100644
> --- a/include/linux/firmware/intel/stratix10-svc-client.h
> +++ b/include/linux/firmware/intel/stratix10-svc-client.h
> @@ -11,10 +11,12 @@
>    *
>    * fpga: for FPGA configuration
>    * rsu: for remote status update
> + * hwmon: for hardware monitoring (voltage and temperature)
>    */
>   #define SVC_CLIENT_FPGA			"fpga"
>   #define SVC_CLIENT_RSU			"rsu"
>   #define SVC_CLIENT_FCS			"fcs"
> +#define SVC_CLIENT_HWMON		"hwmon"
>   
>   /*
>    * Status of the sent command, in bit number
> @@ -70,6 +72,7 @@
>   #define SVC_RSU_REQUEST_TIMEOUT_MS              300
>   #define SVC_FCS_REQUEST_TIMEOUT_MS		2000
>   #define SVC_COMPLETED_TIMEOUT_MS		30000
> +#define SVC_HWMON_REQUEST_TIMEOUT_MS		300
>   
>   struct stratix10_svc_chan;
>   
> @@ -164,6 +167,9 @@ enum stratix10_svc_command_code {
>   	COMMAND_FCS_RANDOM_NUMBER_GEN,
>   	/* for general status poll */
>   	COMMAND_POLL_SERVICE_STATUS = 40,
> +	/* for HWMON */
> +	COMMAND_HWMON_READTEMP,
> +	COMMAND_HWMON_READVOLT,
>   	/* Non-mailbox SMC Call */
>   	COMMAND_SMC_SVC_VERSION = 200,
>   };

