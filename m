Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B488A6B64EE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 11:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjCLKch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 06:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCLKce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 06:32:34 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5164393A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 03:32:32 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id g18so9810022ljl.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 03:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard.com; s=google; t=1678617150;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eLQy97Os/vM1ufsTtvIaP2ZTcv97YlbjnOo0YHiQAts=;
        b=SbuG4NpNY9xJYzHWwm+wdeMZiXQTJ4ogRNusIKSN583HDJwTouw4jagzUc1rRmhkM8
         mFZYcAMDdkf9hRLq7Ourd188mjK3ag9hLgdtYBjN4kJjrnl7IqalKLO2IH+WGocej+ga
         9aepPBcGdcfNqQiCgJudAwrE0zRuCNEpYOJrNHph56Rf+1Cb5E885Mh3EuA/KnLJHtfD
         mCK455XzJzZyqTiOb1xRfoJkTNK99hwIWjF4W8tlcvL+iA1RbD0PywrgDweMq9wXvBP6
         F5ck/i5tEXnd1Og6GGNXgYhteO7J/O+6NSQZ6ESgNzLwGk0OeNxSwdImuPALYgnBYRTt
         ye2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678617150;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLQy97Os/vM1ufsTtvIaP2ZTcv97YlbjnOo0YHiQAts=;
        b=WPO3nHqR/rQH6Uq/RFa/+HJ9NrXIb3pdm3PDxpgriHXRHV+oXd6RzMENJl851WYj0W
         dSATmtq8oCp4kW3gfQ6GjG154Krpk/rVVuc58/+ZFzzX7fOxd6Jh4RRwoF4xc3LV/h0t
         XCc/M5SvN8oipvGXvjV+hOAu0uI42lkwo395I3t0pLkeeBPhFUcqQLSrnkBnZCvMl6aE
         DkJarMBHyB4P9a5axf6cNApkhB+lz/y/t0Ctn/C0uualm0LBO9GRce28IlzzqyrSNNw2
         QwA0QLOmk3qK9RVBEw/oC6CcpmS++ApXILEZ35VGFiHicYnxQPpXAOHnRw2cPInpUtMA
         FBoA==
X-Gm-Message-State: AO0yUKXElKyUUkZR3yEXz5XP84DStiJxyAhth7UIjgVxjIRwV2QfNsjB
        H3VvniYpnw/VjxrcnciF0lR61g==
X-Google-Smtp-Source: AK7set9q+C8pkXhbky+3mJVFQlPDqkBYkHljwNkwLX/0XJZguJcjYUXvhpr6TX3WZmKWz9dU3SNE0g==
X-Received: by 2002:a05:651c:1546:b0:295:a75b:4df4 with SMTP id y6-20020a05651c154600b00295a75b4df4mr12891719ljp.47.1678617150067;
        Sun, 12 Mar 2023 03:32:30 -0700 (PDT)
Received: from [192.168.1.9] ([78.109.72.44])
        by smtp.googlemail.com with ESMTPSA id m2-20020a2e7102000000b002934febffe4sm615072ljc.128.2023.03.12.03.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 03:32:29 -0700 (PDT)
Message-ID: <1f656224-c926-4411-4a6a-50e7ae41cfb2@wirenboard.com>
Date:   Sun, 12 Mar 2023 13:32:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCHv3 4/4] wiegand: add Wiegand GPIO bitbanged controller
 driver
Content-Language: en-GB
To:     =?UTF-8?Q?Martin_Za=c5=a5ovi=c4=8d?= <m.zatovic1@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        gregkh@linuxfoundation.org, airlied@redhat.com, dipenp@nvidia.com,
        treding@nvidia.com, mwen@igalia.com, fmdefrancesco@gmail.com,
        arnd@arndb.de, bvanassche@acm.org, ogabbay@kernel.org,
        axboe@kernel.dk, mathieu.poirier@linaro.org, linux@zary.sk,
        masahiroy@kernel.org, yangyicong@hisilicon.com,
        dan.j.williams@intel.com, jacek.lawrynowicz@linux.intel.com,
        benjamin.tissoires@redhat.com, devicetree@vger.kernel.org,
        furong.zhou@linux.intel.com, andriy.shevchenko@intel.com,
        linus.walleij@linaro.org
References: <20230301142835.19614-1-m.zatovic1@gmail.com>
 <20230301142835.19614-5-m.zatovic1@gmail.com>
From:   Evgeny Boger <boger@wirenboard.com>
Organization: Wiren Board
In-Reply-To: <20230301142835.19614-5-m.zatovic1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/23 17:28, Martin Zaťovič wrote:
> This controller formats the data to a Wiegand format and bit-bangs
> the message on devicetree defined GPIO lines.
>
> Several attributes need to be defined in the devicetree in order
> for this driver to work, namely the data-hi-gpios, data-lo-gpios,
> pulse-len, frame-gap and interval-len. These attributes are
> documented in the devicetree bindings documentation files.
>
> The driver creates a dev file for writing messages on the bus.
> It also creates a sysfs file to control the payload length of
> messages(in bits). If a message is shorter than the set payload
> length, it will be discarded. On the other hand, if a message is
> longer, the additional bits will be stripped off.
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
> ---
>   .../ABI/testing/sysfs-driver-wiegand-gpio     |   9 +
>   MAINTAINERS                                   |   2 +
>   drivers/wiegand/Kconfig                       |   8 +
>   drivers/wiegand/Makefile                      |   1 +
>   drivers/wiegand/wiegand-gpio.c                | 316 ++++++++++++++++++
>   5 files changed, 336 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-driver-wiegand-gpio
>   create mode 100644 drivers/wiegand/wiegand-gpio.c
>
> diff --git a/Documentation/ABI/testing/sysfs-driver-wiegand-gpio b/Documentation/ABI/testing/sysfs-driver-wiegand-gpio
> new file mode 100644
> index 000000000000..be2246880a83
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-wiegand-gpio
> @@ -0,0 +1,9 @@
> +What:		/sys/devices/platform/.../wiegand-gpio-attributes/payload_len
> +Date:		January 2023
> +Contact:	Martin Zaťovič <m.zatovic1@gmail.com>
> +Description:
> +		Read/set the payload length of messages sent by Wiegand GPIO
> +		bit-banging controller in bits. The default value is 26, as
> +		that is the most widely-used length of Wiegand messages.
> +		Controller will only send messages of at least the set length
> +		and it will strip off bits of longer messages.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 91e573466d6b..eeeb343ee91c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22522,7 +22522,9 @@ F:	include/linux/wiegand.h
>   WIEGAND GPIO BITBANG DRIVER
>   M:	Martin Zaťovič <m.zatovic1@gmail.com>
>   S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-driver-wiegand-gpio
>   F:	Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml
> +F:	drivers/wiegand/wiegand-gpio.c
>   
>   WIIMOTE HID DRIVER
>   M:	David Rheinsberg <david.rheinsberg@gmail.com>
> diff --git a/drivers/wiegand/Kconfig b/drivers/wiegand/Kconfig
> index d6b63250e80b..d3a6c773c767 100644
> --- a/drivers/wiegand/Kconfig
> +++ b/drivers/wiegand/Kconfig
> @@ -18,3 +18,11 @@ config WIEGAND
>   	  are initially pulled up. When a bit of value 0 is being transmitted,
>   	  the D0 line is pulled down. Similarly, when a bit of value 1 is being
>   	  transmitted, the D1 line is pulled down.
> +
> +config WIEGAND_GPIO
> +	tristate "GPIO-based wiegand master (write only)"
> +	depends on WIEGAND
> +	help
> +	  This GPIO bitbanging Wiegand controller uses the libgpiod library to
> +	  utilize GPIO lines for sending Wiegand data. Userspace may access
> +	  the Wiegand GPIO interface via a dev entry.
> diff --git a/drivers/wiegand/Makefile b/drivers/wiegand/Makefile
> index d17ecb722c6e..ddf697e21088 100644
> --- a/drivers/wiegand/Makefile
> +++ b/drivers/wiegand/Makefile
> @@ -1 +1,2 @@
>   obj-$(CONFIG_WIEGAND)			+= wiegand.o
> +obj-$(CONFIG_WIEGAND_GPIO)		+= wiegand-gpio.o
> diff --git a/drivers/wiegand/wiegand-gpio.c b/drivers/wiegand/wiegand-gpio.c
> new file mode 100644
> index 000000000000..e67a30a1c5ae
> --- /dev/null
> +++ b/drivers/wiegand/wiegand-gpio.c
> @@ -0,0 +1,316 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/poll.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/wiegand.h>
> +
> +#define WIEGAND_MAX_PAYLEN_BYTES 256
> +
> +struct wiegand_gpio {
> +	struct device *dev;
> +	struct wiegand_controller *ctlr;
> +	struct miscdevice misc_dev;
> +	struct mutex mutex;
> +	struct gpio_desc *gpio_data_hi;
> +	struct gpio_desc *gpio_data_lo;
> +	struct file_operations fops;
> +	u8 data[WIEGAND_MAX_PAYLEN_BYTES];
maybe use bitmap for this?
> +};
> +
> +struct wiegand_gpio_instance {
> +	struct wiegand_gpio *dev;
> +	unsigned long flags;
> +};
> +
> +static ssize_t store_ulong(u32 *val, const char *buf, size_t size, unsigned long max)
> +{
> +	int rc;
> +	u32 new;
> +
> +	rc = kstrtou32(buf, 0, &new);
> +	if (rc)
> +		return rc;
> +
> +	if (max != 0 && new > max)
> +		return -EINVAL;
> +
> +	*val = new;
> +	return size;
> +}
> +
> +/*
> + * Attribute file for setting payload length of Wiegand messages.
> + */
> +ssize_t payload_len_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct wiegand_gpio *wiegand_gpio = dev_get_drvdata(dev);
> +	struct wiegand_controller *ctlr = wiegand_gpio->ctlr;
> +
> +	return sysfs_emit(buf, "%u\n", ctlr->payload_len);
> +}
> +
> +ssize_t payload_len_store(struct device *dev, struct device_attribute *attr, const char *buf,
> +			size_t count)
> +{
> +	struct wiegand_gpio *wiegand_gpio = dev_get_drvdata(dev);
> +	struct wiegand_controller *ctlr = wiegand_gpio->ctlr;
> +
> +	return store_ulong(&(ctlr->payload_len), buf, count, WIEGAND_MAX_PAYLEN_BYTES * 8);
> +}
> +DEVICE_ATTR_RW(payload_len);
> +
> +static struct attribute *wiegand_gpio_attrs[] = {
> +	&dev_attr_payload_len.attr,
> +	NULL,
> +};
> +
> +ATTRIBUTE_GROUPS(wiegand_gpio);
> +
> +/*
> + * To send a bit of value 1 following the wiegand protocol, one must set
> + * the wiegand_data_hi to low for the duration of pulse. Similarly to send
> + * a bit of value 0, the wiegand_data_lo is set to low for pulse duration.
> + * This way the two lines are never low at the same time.
> + */
> +void wiegand_gpio_send_bit(struct wiegand_gpio *wiegand_gpio, bool value, bool last)
> +{
> +	u32 pulse_len = wiegand_gpio->ctlr->pulse_len;
> +	u32 interval_len = wiegand_gpio->ctlr->interval_len;
> +	u32 frame_gap = wiegand_gpio->ctlr->frame_gap;
> +	struct gpio_desc *gpio = value ? wiegand_gpio->gpio_data_hi : wiegand_gpio->gpio_data_lo;
> +
> +	gpiod_set_value_cansleep(gpio, 0);
> +	udelay(pulse_len);
> +	gpiod_set_value_cansleep(gpio, 1);
> +
> +	if (last)
> +		udelay(frame_gap - pulse_len);
> +	else
> +		udelay(interval_len - pulse_len);
> +}
> +
> +/* This function is used for writing from file in dev directory */
> +static int wiegand_gpio_write_by_bits(struct wiegand_gpio *wiegand_gpio, u16 bitlen)
> +{
> +	size_t i;
> +	bool bit_value, is_last_bit;
> +
> +	for (i = 0; i < bitlen; i++) {
> +		bit_value = ((wiegand_gpio->data[i / 8] >> (7 - (i % 8))) & 0x01);
> +		is_last_bit = (i + 1) == bitlen;
> +		wiegand_gpio_send_bit(wiegand_gpio, bit_value, is_last_bit);
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t wiegand_gpio_get_user_data(struct wiegand_gpio *wiegand_gpio, char __user const *buf,
> +					  size_t len)
> +{
> +	size_t rc;
> +
> +	if (len > WIEGAND_MAX_PAYLEN_BYTES)
> +		return -EBADMSG;
> +
> +	rc = copy_from_user(&wiegand_gpio->data[0], buf, WIEGAND_MAX_PAYLEN_BYTES);
> +	if (rc < 0)
> +		return rc;
> +
> +	return len;
> +}
> +
> +static int wiegand_gpio_frelease(struct inode *ino, struct file *filp)
> +{
> +	struct wiegand_gpio_instance *info = filp->private_data;
> +	struct wiegand_gpio *wiegand_gpio = info->dev;
> +
> +	mutex_lock(&wiegand_gpio->mutex);
> +	info->flags = 0;
> +	mutex_unlock(&wiegand_gpio->mutex);
> +
> +	kfree(info);
> +
> +	return 0;
> +}
> +
> +static ssize_t wiegand_gpio_fwrite(struct file *filp, char __user const *buf, size_t len,
> +				loff_t *offset)
> +{
> +	struct wiegand_gpio_instance *info = filp->private_data;
> +	struct wiegand_gpio *wiegand_gpio = info->dev;
> +	u32 msg_length = wiegand_gpio->ctlr->payload_len;
> +	int rc;
> +
> +	if (buf == NULL || len == 0 || len * 8 < msg_length)
> +		return -EINVAL;
> +
> +	rc = wiegand_gpio_get_user_data(wiegand_gpio, buf, len);
> +	if (rc < 0)
> +		return rc;
> +
> +	wiegand_gpio_write_by_bits(wiegand_gpio, msg_length);
> +
> +	return len;
> +}
> +
> +static int wiegand_gpio_fopen(struct inode *ino, struct file *filp)
> +{
> +	int rc;
> +	struct wiegand_gpio_instance *info;
> +	struct wiegand_gpio *wiegand_gpio = container_of(filp->f_op, struct wiegand_gpio, fops);
> +
> +	mutex_lock(&wiegand_gpio->mutex);
> +
> +	if ((filp->f_flags & O_ACCMODE) == O_RDONLY || (filp->f_flags & O_ACCMODE) == O_RDWR) {
> +		dev_err(wiegand_gpio->dev, "Device is write only\n");
> +		rc = -EIO;
> +		goto err;
> +	}
> +
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info) {
> +		rc = -ENOMEM;
> +		goto err;
> +	}
> +
> +	info->dev = wiegand_gpio;
> +	info->flags = filp->f_flags;
> +	mutex_unlock(&wiegand_gpio->mutex);
> +
> +	filp->private_data = info;
> +
> +	return 0;
> +err:
> +	mutex_unlock(&wiegand_gpio->mutex);
> +	return rc;
> +}
> +
> +/* This function is used by device drivers */
> +int wiegand_gpio_transfer_message(struct wiegand_device *dev, u8 *message, u8 msg_bitlen)
> +{
> +	struct wiegand_controller *ctlr = dev->controller;
> +	struct wiegand_gpio *wiegand_gpio = wiegand_master_get_devdata(ctlr);
> +	u8 msg_bytelength = (msg_bitlen % 8) ? (msg_bitlen / 8) + 1 : (msg_bitlen / 8);
> +
> +	memcpy(wiegand_gpio->data, message, msg_bytelength);
> +	wiegand_gpio_write_by_bits(wiegand_gpio, msg_bitlen);
> +
> +	return 0;
> +}
> +
> +static int wiegand_gpio_request(struct device *dev, struct wiegand_gpio *wiegand_gpio)
> +{
> +	/* Get GPIO lines using device tree bindings. */
> +	wiegand_gpio->gpio_data_lo = devm_gpiod_get(dev, "data-lo", GPIOD_OUT_HIGH);
> +	if (IS_ERR(wiegand_gpio->gpio_data_lo))
> +		return PTR_ERR(wiegand_gpio->gpio_data_lo);
> +
> +	wiegand_gpio->gpio_data_hi = devm_gpiod_get(dev, "data-hi", GPIOD_OUT_HIGH);
> +	return PTR_ERR_OR_ZERO(wiegand_gpio->gpio_data_hi);
> +}
> +
> +static int wiegand_gpio_probe(struct platform_device *device)
> +{
> +	int status;
> +	struct wiegand_controller *master;
> +	struct wiegand_gpio *wiegand_gpio;
> +	struct device *dev = &device->dev;
> +
> +	master = devm_wiegand_alloc_master(dev, sizeof(*wiegand_gpio));
> +	if (!master)
> +		return -ENOMEM;
> +
> +	if (dev->of_node)
> +		master->dev.of_node = device->dev.of_node;
> +
> +	if (status)
> +		return status;
> +
> +	master->transfer_message = &wiegand_gpio_transfer_message;
> +	master->payload_len = 26; /* set standard 26-bit format */
> +
> +	wiegand_gpio = wiegand_master_get_devdata(master);
> +	wiegand_gpio->ctlr = master;
> +	wiegand_gpio->fops.owner = THIS_MODULE;
> +	wiegand_gpio->fops.open = wiegand_gpio_fopen;
> +	wiegand_gpio->fops.release = wiegand_gpio_frelease;
> +	wiegand_gpio->fops.write = wiegand_gpio_fwrite;
> +
> +	platform_set_drvdata(device, wiegand_gpio);
> +
> +	master->bus_num = device->id;
> +	wiegand_gpio->dev = dev;
> +
> +	mutex_init(&wiegand_gpio->mutex);
> +
> +	status = wiegand_gpio_request(dev, wiegand_gpio);
> +	if (status) {
> +		dev_err(wiegand_gpio->dev, "failed at requesting GPIOs\n");
> +		return status;
> +	}
> +
> +	status = gpiod_direction_output(wiegand_gpio->gpio_data_hi, 1);
> +	status |= gpiod_direction_output(wiegand_gpio->gpio_data_lo, 1);
> +	if (status) {
> +		dev_err(wiegand_gpio->dev, "failed to set GPIOs direction\n");
> +		return status;
> +	}
> +
> +	status = devm_wiegand_register_master(dev, master);
> +	if (status) {
> +		dev_err(wiegand_gpio->dev, "failed to register master\n");
> +		return status;
> +	}
> +
> +	wiegand_gpio->misc_dev.name = kasprintf(GFP_KERNEL, "wiegand-gpio%u", master->bus_num);
> +	wiegand_gpio->misc_dev.minor = MISC_DYNAMIC_MINOR;
> +	wiegand_gpio->misc_dev.fops = &wiegand_gpio->fops;
> +
> +	status = misc_register(&wiegand_gpio->misc_dev);
> +	if (status) {
> +		dev_err(wiegand_gpio->dev, "couldn't register misc device\n");
> +		return status;
> +	}
> +	wiegand_gpio->misc_dev.parent = wiegand_gpio->dev;
> +
> +	device_create_file(dev, &dev_attr_payload_len);
As far as I understand, Wiegand GPIO bit-banged driver is just one of 
the many possible driver implementations. I can imagine having dedicated 
hardware to send Wiegand messages. So it seems a little strange to have 
chardev API implemented in the bit-banged driver and not in the core, so 
it's common for all possible driver implementations.

> +	dev->groups = wiegand_gpio_groups;
> +
> +	return status;
> +}
> +
> +static int wiegand_gpio_remove(struct platform_device *device)
> +{
> +	struct wiegand_gpio *wiegand_gpio = platform_get_drvdata(device);
> +
> +	misc_deregister(&wiegand_gpio->misc_dev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id wiegand_gpio_dt_idtable[] = {
> +	{ .compatible = "wiegand-gpio", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, wiegand_gpio_dt_idtable);
> +
> +static struct platform_driver wiegand_gpio_driver = {
> +	.driver = {
> +		.name	= "wiegand-gpio",
> +		.of_match_table = wiegand_gpio_dt_idtable,
> +	},
> +	.probe		= wiegand_gpio_probe,
> +	.remove		= wiegand_gpio_remove,
> +};
> +
> +module_platform_driver(wiegand_gpio_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Wiegand write-only driver realized by GPIOs");
> +MODULE_AUTHOR("Martin Zaťovič <m.zatovic1@gmail.com>");

-- 
Kind regards,
Evgeny Boger
CTO @ Wiren Board

