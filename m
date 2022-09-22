Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2F95E6605
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbiIVOmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiIVOlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:41:37 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695BB7CB6B;
        Thu, 22 Sep 2022 07:41:34 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id b75so9518178pfb.7;
        Thu, 22 Sep 2022 07:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=q6KbRk2m1xYZBvR/7u7nVMJnoR7EmQt6hZBsYexnNaE=;
        b=KTsP+tBLMc3e/CHRQg2XGERoYb9QVTziRprxvAFmfAq+W7+aJTdq1KfLQ3/Y7hkea+
         oeQJc1ziIjfPvYG9RKrettfU/JdH46FAnlsZbPPr6LUtHE0k1rHO0is4r2QE2j2tZjpt
         OWzknIH+KynJ1JQYprCryuzJAyZ5BaO5R7+FRVH1yf5C6EaLfS6O1AePhamsQAS5GO6w
         iQxIKaCzwJVA5Qnu3/P3nxSJEA7CD34Di2PtIFS8KmsymOKjBQDYJhdsKZoQfnfWzfNo
         SfKFnNNVNuHn9WLbj/Pamvm/Ix4cgmC7Xf7tQ8TyyKo3TN+gBgHQ/NoH9+EHhI16Sb59
         8FSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=q6KbRk2m1xYZBvR/7u7nVMJnoR7EmQt6hZBsYexnNaE=;
        b=tutgY8k2pUitqMbF2Y/NepvES+50Efi+jkZ64lzeYYmuffhd3Om+UpMGX1FGPWIrOf
         qC+FFugupGuiuUpoqGQQMYbW/T1X6CzJ/bTIPcchWwTUTSOfuOA2Irg47a8szx8VsceK
         RMwD9PHY8gOQ4AQIi3yClYfhpBl40m3msxSadpfkwopBY6eK51216dK9sL/21a1A/I4T
         m6Gibztl/7MCIaCwO0q82otc759h8h1AkIF9Jaxqldkc1ZdcwDbG8hLqnLi53nir65zf
         dRvcdc2czY+nJSc69rCdnhOqdkeuZFa4T7QNiWeAur21c2bd+rr5fm8Dy9puYI63XNnq
         7tZg==
X-Gm-Message-State: ACrzQf25KUyC8OOEdtMevjijlwmW3I9Ub/KwVfoPGwhNjhE8JyGgv4+U
        iPXIgN+Ig6hwDKiB15Ewk1Y=
X-Google-Smtp-Source: AMsMyM7XOALut385OymY1NqDV8Y43pxhr/eHcT1DlUxVFedeNu6ysdoJQL/b4fuINth1PmpbUOYHjw==
X-Received: by 2002:a63:c111:0:b0:439:103a:6c31 with SMTP id w17-20020a63c111000000b00439103a6c31mr3300541pgf.149.1663857693731;
        Thu, 22 Sep 2022 07:41:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902e54800b001781a7c28b9sm4116066plf.240.2022.09.22.07.41.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 07:41:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6d84992f-a9d8-d996-dadc-a6948eda0133@roeck-us.net>
Date:   Thu, 22 Sep 2022 07:41:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6] watchdog: add driver for StreamLabs USB watchdog
 device
Content-Language: en-US
To:     Alexey Klimov <klimov.linux@gmail.com>,
        linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, gregkh@linuxfoundation.org,
        oneukum@suse.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, atishp@rivosinc.com,
        atishp@atishpatra.org, yury.norov@gmail.com, aklimov@redhat.com,
        atomlin@redhat.com
References: <20220917030534.363192-1-klimov.linux@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220917030534.363192-1-klimov.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/22 20:05, Alexey Klimov wrote:
> Driver supports StreamLabs usb watchdog device. The device plugs
> into 9-pin usb header and connects to reset pins and reset button
> pins on desktop PC.
> 
> USB commands used to communicate with device were reverse
> engineered using usbmon.
> 
> Signed-off-by: Alexey Klimov <klimov.linux@gmail.com>
> ---
> 
> Changes since v5:
> 	-- moved to semaphore lock: down_killable()/up();
> 	If I have to go with down_timeout() option, then
> 	I am not sure which timeout value to use, apart
> 	from maximum or current timeout from device;
> 	-- implemented {pre,post}_reset methods (thanks, Oliver!);
> 	-- back to the version where buffer is a part of
> 	struct streamlabs_wdt and now also ____cacheline_aligned;
> 	-- watchdog_start() in probe instead of watchdog_stop();
> 	-- added watchdog_stop_on_reboot() in probe;
> 	-- other comments from Guenter.
> 
> Previous version:
> https://lore.kernel.org/linux-usb/CALW4P+LmMJAm=3PWQfiEgYS7d_q0M0rdSJVhpZw9x9w3fQQMRA@mail.gmail.com/T/
> 
> 
>   MAINTAINERS                       |   6 +
>   drivers/watchdog/Kconfig          |  15 ++
>   drivers/watchdog/Makefile         |   1 +
>   drivers/watchdog/streamlabs_wdt.c | 412 ++++++++++++++++++++++++++++++
>   4 files changed, 434 insertions(+)
>   create mode 100644 drivers/watchdog/streamlabs_wdt.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 936490dcc97b..e56fd4d636d1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19480,6 +19480,12 @@ W:	http://www.stlinux.com
>   F:	Documentation/networking/device_drivers/ethernet/stmicro/
>   F:	drivers/net/ethernet/stmicro/stmmac/
> 
> +STREAMLABS USB WATCHDOG DRIVER
> +M:	Alexey Klimov <klimov.linux@gmail.com>
> +L:	linux-watchdog@vger.kernel.org
> +S:	Maintained
> +F:	drivers/watchdog/streamlabs_wdt.c
> +
>   SUN3/3X
>   M:	Sam Creasey <sammy@sammy.net>
>   S:	Maintained
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 9295492d24f7..8baf53fef3cc 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -2180,6 +2180,21 @@ config USBPCWATCHDOG
> 
>   	  Most people will say N.
> 
> +config USB_STREAMLABS_WATCHDOG
> +	tristate "StreamLabs USB watchdog driver"
> +	depends on USB
> +	help
> +	  This is the driver for the USB Watchdog dongle from StreamLabs.
> +	  If you correctly connect reset pins to motherboard Reset pin and
> +	  to Reset button then this device will simply watch your kernel to make
> +	  sure it doesn't freeze, and if it does, it reboots your computer
> +	  after a certain amount of time.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called streamlabs_wdt.
> +
> +	  Most people will say N. Say yes or M if you want to use such usb device.
> +
>   config KEEMBAY_WATCHDOG
>   	tristate "Intel Keem Bay SoC non-secure watchdog"
>   	depends on ARCH_KEEMBAY || (ARM64 && COMPILE_TEST)
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index cdeb119e6e61..afc6fdc1b4d9 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -33,6 +33,7 @@ obj-$(CONFIG_WDTPCI) += wdt_pci.o
> 
>   # USB-based Watchdog Cards
>   obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.o
> +obj-$(CONFIG_USB_STREAMLABS_WATCHDOG) += streamlabs_wdt.o
> 
>   # ALPHA Architecture
> 
> diff --git a/drivers/watchdog/streamlabs_wdt.c b/drivers/watchdog/streamlabs_wdt.c
> new file mode 100644
> index 000000000000..cc4f48f1fd36
> --- /dev/null
> +++ b/drivers/watchdog/streamlabs_wdt.c
> @@ -0,0 +1,412 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * StreamLabs USB Watchdog driver
> + *
> + * Copyright (c) 2016-2017,2022 Alexey Klimov <klimov.linux@gmail.com>
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <linux/usb.h>
> +#include <linux/watchdog.h>
> +#include <asm/byteorder.h>
> +
> +/*
> + * USB Watchdog device from Streamlabs:
> + * https://www.stream-labs.com/products/devices/watch-dog/
> + *
> + * USB commands have been reverse engineered using usbmon.
> + */
> +
> +#define DRIVER_AUTHOR "Alexey Klimov <klimov.linux@gmail.com>"
> +#define DRIVER_DESC "StreamLabs USB watchdog driver"
> +#define DRIVER_NAME "usb_streamlabs_wdt"
> +
> +MODULE_AUTHOR(DRIVER_AUTHOR);
> +MODULE_DESCRIPTION(DRIVER_DESC);
> +MODULE_LICENSE("GPL");
> +
> +#define USB_STREAMLABS_WATCHDOG_VENDOR	0x13c0
> +#define USB_STREAMLABS_WATCHDOG_PRODUCT	0x0011
> +
> +/*
> + * one buffer is used for communication, however transmitted message is only
> + * 32 bytes long
> + */
> +#define BUFFER_TRANSFER_LENGTH	32
> +#define BUFFER_LENGTH		64
> +#define USB_TIMEOUT		350	/* 350 ms */
> +
> +#define STREAMLABS_CMD_START	0xaacc
> +#define STREAMLABS_CMD_STOP	0xbbff
> +
> +/* timeout values are taken from windows program */
> +#define STREAMLABS_WDT_MIN_TIMEOUT	1
> +#define STREAMLABS_WDT_MAX_TIMEOUT	46
> +
> +struct streamlabs_wdt {
> +	struct watchdog_device wdt_dev;
> +	struct usb_interface *intf;
> +	/* Serialises usb communication with a device */
> +	struct semaphore lock;
> +	__le16 buffer[BUFFER_LENGTH] ____cacheline_aligned;
> +};
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
> +			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +/* USB call wrappers to send and receive messages to/from the device. */
> +static int usb_streamlabs_send_msg(struct usb_device *usbdev, __le16 *buf)
> +{
> +	int retval;
> +	int size;
> +
> +	retval = usb_interrupt_msg(usbdev, usb_sndintpipe(usbdev, 0x02),
> +				   buf, BUFFER_TRANSFER_LENGTH,
> +				   &size, USB_TIMEOUT);
> +
> +	if (retval)
> +		return retval;
> +
> +	if (size != BUFFER_TRANSFER_LENGTH)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int usb_streamlabs_get_msg(struct usb_device *usbdev, __le16 *buf)
> +{
> +	int retval;
> +	int size;
> +
> +	retval = usb_interrupt_msg(usbdev, usb_rcvintpipe(usbdev, 0x81),
> +				   buf, BUFFER_LENGTH,
> +				   &size, USB_TIMEOUT);
> +
> +	if (retval)
> +		return retval;
> +
> +	if (size != BUFFER_LENGTH)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +/*
> + * This function is used to check if watchdog timeout in the received buffer
> + * matches the timeout passed from watchdog subsystem.
> + */
> +static int usb_streamlabs_wdt_check_timeout(__le16 *buf, unsigned long timeout)
> +{
> +	if (buf[3] != cpu_to_le16(timeout))
> +		return -EPROTO;
> +
> +	return 0;
> +}
> +
> +static int usb_streamlabs_wdt_check_response(u8 *buf)
> +{
> +	/*
> +	 * If watchdog device understood the command it will acknowledge
> +	 * with values 1,2,3,4 at indexes 10, 11, 12, 13 in response message
> +	 * when response treated as 8bit message.
> +	 */
> +	if (buf[10] != 1 || buf[11] != 2 || buf[12] != 3 || buf[13] != 4)
> +		return -EPROTO;
> +
> +	return 0;
> +}
> +
> +/*
> + * This function is used to check if watchdog command in the received buffer
> + * matches the command passed to the device.
> + */
> +static int usb_streamlabs_wdt_check_command(__le16 *buf, u16 cmd)
> +{
> +	if (buf[0] != cpu_to_le16(cmd))
> +		return -EPROTO;
> +
> +	return 0;
> +}
> +
> +static int usb_streamlabs_wdt_validate_response(__le16 *buf, u16 cmd,
> +						unsigned long timeout_msec)
> +{
> +	int retval;
> +
> +	retval = usb_streamlabs_wdt_check_response((u8 *)buf);
> +	if (retval)
> +		return retval;
> +
> +	retval = usb_streamlabs_wdt_check_command(buf, cmd);
> +	if (retval)
> +		return retval;
> +
> +	return usb_streamlabs_wdt_check_timeout(buf, timeout_msec);
> +}
> +
> +static void usb_streamlabs_wdt_prepare_buf(__le16 *buf, u16 cmd,
> +					   unsigned long timeout_msec)
> +{
> +	memset(buf, 0, BUFFER_LENGTH);
> +
> +	buf[0] = cpu_to_le16(cmd);
> +	buf[1] = cpu_to_le16(0x8000);
> +	buf[3] = cpu_to_le16(timeout_msec);
> +}
> +
> +static int __usb_streamlabs_wdt_cmd(struct streamlabs_wdt *wdt, u16 cmd)
> +{
> +	struct usb_device *usbdev;
> +	unsigned long timeout_msec;
> +	/* how many times to re-try getting the state of the device */
> +	unsigned int retry_counter = 10;
> +	int retval;
> +
> +	if (unlikely(!wdt->intf))
> +		return -ENODEV;
> +
> +	usbdev = interface_to_usbdev(wdt->intf);
> +	timeout_msec = wdt->wdt_dev.timeout * MSEC_PER_SEC;
> +
> +	usb_streamlabs_wdt_prepare_buf(wdt->buffer, cmd, timeout_msec);
> +
> +	/* send command to watchdog */
> +	retval = usb_streamlabs_send_msg(usbdev, wdt->buffer);
> +	if (retval)
> +		return retval;
> +
> +	/*
> +	 * Transition from one state to another in this device
> +	 * doesn't happen immediately, especially stopping the device
> +	 * is not observed on the first reading of the response.
> +	 * Plus to avoid potentially stale response message in the device
> +	 * we keep reading the state of the device until we see:
> +	 * -- that device recognised the sent command;
> +	 * -- the received state (started or stopped) matches the state
> +	 * that was requested;
> +	 * -- the timeout passed matches the timeout value read from
> +	 * the device.
> +	 * Keep retrying 10 times and if watchdog device doesn't respond
> +	 * correctly as expected we bail out and return an error.
> +	 */
> +	do {
> +		retval = usb_streamlabs_get_msg(usbdev, wdt->buffer);
> +		if (retval)
> +			break;
> +
> +		retval = usb_streamlabs_wdt_validate_response(wdt->buffer, cmd,
> +							      timeout_msec);
> +	} while (retval && retry_counter--);
> +
> +	return retry_counter ? retval : -EIO;
> +}
> +
> +static int usb_streamlabs_wdt_cmd(struct streamlabs_wdt *streamlabs_wdt, u16 cmd)
> +{
> +	int retval;
> +
> +	retval = down_killable(&streamlabs_wdt->lock);
> +	if (retval)
> +		return retval;
> +	retval = __usb_streamlabs_wdt_cmd(streamlabs_wdt, cmd);
> +	up(&streamlabs_wdt->lock);
> +
> +	return retval;
> +}
> +
> +static int usb_streamlabs_wdt_start(struct watchdog_device *wdt_dev)
> +{
> +	struct streamlabs_wdt *streamlabs_wdt = watchdog_get_drvdata(wdt_dev);
> +
> +	return usb_streamlabs_wdt_cmd(streamlabs_wdt, STREAMLABS_CMD_START);
> +}
> +
> +static int usb_streamlabs_wdt_stop(struct watchdog_device *wdt_dev)
> +{
> +	struct streamlabs_wdt *streamlabs_wdt = watchdog_get_drvdata(wdt_dev);
> +
> +	return usb_streamlabs_wdt_cmd(streamlabs_wdt, STREAMLABS_CMD_STOP);
> +}
> +
> +static const struct watchdog_info streamlabs_wdt_ident = {
> +	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
> +	.identity	= DRIVER_NAME,
> +};
> +
> +static const struct watchdog_ops usb_streamlabs_wdt_ops = {
> +	.owner	= THIS_MODULE,
> +	.start	= usb_streamlabs_wdt_start,
> +	.stop	= usb_streamlabs_wdt_stop,
> +};
> +
> +static int usb_streamlabs_wdt_probe(struct usb_interface *intf,
> +				    const struct usb_device_id *id)
> +{
> +	struct usb_device *usbdev = interface_to_usbdev(intf);
> +	struct streamlabs_wdt *streamlabs_wdt;
> +	int retval;
> +
> +	/*
> +	 * USB IDs of this device appear to be weird/unregistered. Hence, do
> +	 * an additional check on product and manufacturer.
> +	 * If there is similar device in the field with same values then
> +	 * there is stop command in probe() below that checks if the device
> +	 * behaves as a watchdog.
> +	 */
> +	if (!usbdev->product || !usbdev->manufacturer ||
> +	    strncmp(usbdev->product, "USBkit", 6) ||
> +	    strncmp(usbdev->manufacturer, "STREAM LABS", 11))
> +		return -ENODEV;
> +
> +	streamlabs_wdt = devm_kzalloc(&intf->dev, sizeof(struct streamlabs_wdt),
> +				      GFP_KERNEL);
> +	if (!streamlabs_wdt)
> +		return -ENOMEM;
> +
> +	sema_init(&streamlabs_wdt->lock, 1);
> +
> +	streamlabs_wdt->wdt_dev.info = &streamlabs_wdt_ident;
> +	streamlabs_wdt->wdt_dev.ops = &usb_streamlabs_wdt_ops;
> +	streamlabs_wdt->wdt_dev.timeout = STREAMLABS_WDT_MAX_TIMEOUT;
> +	streamlabs_wdt->wdt_dev.max_timeout = STREAMLABS_WDT_MAX_TIMEOUT;
> +	streamlabs_wdt->wdt_dev.min_timeout = STREAMLABS_WDT_MIN_TIMEOUT;
> +	streamlabs_wdt->wdt_dev.parent = &intf->dev;
> +
> +	streamlabs_wdt->intf = intf;
> +	usb_set_intfdata(intf, &streamlabs_wdt->wdt_dev);
> +	watchdog_set_drvdata(&streamlabs_wdt->wdt_dev, streamlabs_wdt);
> +	watchdog_set_nowayout(&streamlabs_wdt->wdt_dev, nowayout);
> +	watchdog_stop_on_reboot(&streamlabs_wdt->wdt_dev);
> +
> +	retval = usb_streamlabs_wdt_start(&streamlabs_wdt->wdt_dev);
> +	if (retval)
> +		return -ENODEV;
> +	set_bit(WDOG_HW_RUNNING, &streamlabs_wdt->wdt_dev.status);
> +
> +	retval = devm_watchdog_register_device(&intf->dev,
> +					       &streamlabs_wdt->wdt_dev);
> +	if (retval) {
> +		dev_err(&intf->dev, "failed to register watchdog device\n");
> +		return retval;
> +	}
> +
> +	dev_info(&intf->dev, "StreamLabs USB watchdog driver loaded.\n");
> +	return 0;
> +}
> +
> +static int usb_streamlabs_wdt_suspend(struct usb_interface *intf,
> +				      pm_message_t message)
> +{
> +	struct streamlabs_wdt *streamlabs_wdt = usb_get_intfdata(intf);
> +
> +	if (watchdog_active(&streamlabs_wdt->wdt_dev))
> +		return usb_streamlabs_wdt_stop(&streamlabs_wdt->wdt_dev);
> +
> +	return 0;
> +}
> +
> +static int usb_streamlabs_wdt_resume(struct usb_interface *intf)
> +{
> +	struct streamlabs_wdt *streamlabs_wdt = usb_get_intfdata(intf);
> +
> +	if (watchdog_active(&streamlabs_wdt->wdt_dev))
> +		return usb_streamlabs_wdt_start(&streamlabs_wdt->wdt_dev);
> +
> +	return 0;
> +}
> +
> +static void usb_streamlabs_wdt_disconnect(struct usb_interface *intf)
> +{
> +	struct streamlabs_wdt *streamlabs_wdt = usb_get_intfdata(intf);
> +	int retval;
> +
> +	retval = down_killable(&streamlabs_wdt->lock);
> +	if (retval) {
> +		dev_warn(&intf->dev,
> +			 "failed to acquire semaphore in disconnect\n");
> +		return;
> +	}
> +
> +	/*
> +	 * If disconnect happens via sysfs or on rmmod, then try to stop
> +	 * the watchdog. In case of physical detachment of the device this call
> +	 * will fail but we continue.
> +	 */
> +	if (!nowayout)
> +		__usb_streamlabs_wdt_cmd(streamlabs_wdt, STREAMLABS_CMD_STOP);
> +
> +	/* Stop sending (new) messages to the device */
> +	streamlabs_wdt->intf = NULL;
> +	up(&streamlabs_wdt->lock);
> +}
> +
> +static int usb_streamlabs_wdt_pre_reset(struct usb_interface *intf)
> +{
> +	struct streamlabs_wdt *streamlabs_wdt = usb_get_intfdata(intf);
> +	int retval;
> +
> +	retval = down_killable(&streamlabs_wdt->lock);
> +	if (retval) {
> +		dev_warn(&intf->dev,
> +			 "failed to acquire semaphore in pre_reset\n");
> +		return retval;
> +	}
> +
> +	if (watchdog_active(&streamlabs_wdt->wdt_dev)) {
> +		retval =  __usb_streamlabs_wdt_cmd(streamlabs_wdt,
> +						   STREAMLABS_CMD_STOP);
> +		/*
> +		 * If ->pre_reset() callback fails, the ->disconnect()
> +		 * callback will be called. To let it work we should

should -> need to ?

It isn't really optional, or am I missing something ?

Also, is that the only condition where post_reset will never be called ?
How about some other disconnect condition experienced after pre_reset(),
even if pre_reset() itself was successful ? Or a shutdown after the call
to pre_reset() ?

> +		 * unlock semaphore here.
> +		 */
> +		if (retval)
> +			up(&streamlabs_wdt->lock);
> +	}
> +
> +	return retval;
> +}
> +
> +static int usb_streamlabs_wdt_post_reset(struct usb_interface *intf)
> +{
> +	struct streamlabs_wdt *streamlabs_wdt = usb_get_intfdata(intf);
> +	int retval = 0;
> +
> +	/* FIXME: potential race here, watchdog_active() check is unreliable? */

You'll need to handle that here.

> +	if (watchdog_active(&streamlabs_wdt->wdt_dev))
> +		retval = __usb_streamlabs_wdt_cmd(streamlabs_wdt,
> +						  STREAMLABS_CMD_START);
> +
> +	up(&streamlabs_wdt->lock);
> +
> +	return retval;
> +}
> +
> +static const struct usb_device_id usb_streamlabs_wdt_device_table[] = {
> +	{ USB_DEVICE(USB_STREAMLABS_WATCHDOG_VENDOR, USB_STREAMLABS_WATCHDOG_PRODUCT) },
> +	{ }	/* Terminating entry */
> +};
> +
> +MODULE_DEVICE_TABLE(usb, usb_streamlabs_wdt_device_table);
> +
> +static struct usb_driver usb_streamlabs_wdt_driver = {
> +	.name		= DRIVER_NAME,
> +	.probe		= usb_streamlabs_wdt_probe,
> +	.disconnect	= usb_streamlabs_wdt_disconnect,
> +	.suspend	= usb_streamlabs_wdt_suspend,
> +	.resume		= usb_streamlabs_wdt_resume,
> +	.reset_resume	= usb_streamlabs_wdt_resume,
> +	.pre_reset	= usb_streamlabs_wdt_pre_reset,
> +	.post_reset	= usb_streamlabs_wdt_post_reset,
> +	.id_table	= usb_streamlabs_wdt_device_table,
> +	.soft_unbind	= 1,
> +};
> +
> +module_usb_driver(usb_streamlabs_wdt_driver);
> --
> 2.37.2
> 

