Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78CF73A255
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjFVN4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjFVN4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:56:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD721BE1;
        Thu, 22 Jun 2023 06:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687442198; x=1718978198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=guLBCHNagrSF/PabhYlAKf6SjWH5LPbx5tv63g5hvE4=;
  b=DuhHf5T+mTZfzmJBcYUYWoPsvSVzYFcD4TOYTkn5GUBWshbsW8VQx+Gx
   z3LhPl733CI+l1wFAra0pZRIOYsC6LPJuUEIYZ9x2Nf6oKfb/LNsPbJlt
   obMoIeXC/Ga6bMYxBOk13ZZhtgHy5gDQ7YwLHg1Zt/3op3uMe/Cwcr9Kw
   9wA84HEDWuuyRGQfOGI37BOkdwOZs0erlV5LTSxzenoxbnT5o7xlZNrVH
   r93pfa49nsJEsvK5Q+VFSlZDenYCk+f7ZjDBRz5KCnuWZj0izxNtwSCMM
   F8wNscfBur7FyJT4lMMMm0sllJiBeLzs4wyrc322pl3BJYVJrcEuY3EC9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="424164558"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="424164558"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 06:20:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="718085080"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="718085080"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jun 2023 06:20:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qCKEf-005lu5-2q;
        Thu, 22 Jun 2023 16:20:29 +0300
Date:   Thu, 22 Jun 2023 16:20:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, beanhuo@micron.com,
        nipun.gupta@amd.com, linus.walleij@linaro.org, mwen@igalia.com,
        bvanassche@acm.org, arnd@arndb.de, ogabbay@kernel.org,
        linux@zary.sk, jacek.lawrynowicz@linux.intel.com,
        geert+renesas@glider.be, benjamin.tissoires@redhat.com,
        masahiroy@kernel.org, yangyicong@hisilicon.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCHv4 2/4] wiegand: add Wiegand bus driver
Message-ID: <ZJRKndTB4HEz/Ztf@smile.fi.intel.com>
References: <20230510162243.95820-1-m.zatovic1@gmail.com>
 <20230510162243.95820-3-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230510162243.95820-3-m.zatovic1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 06:22:41PM +0200, Martin Zaťovič wrote:

This needs much more work. See my comments below.

> Add a bus driver for Wiegand protocol. The bus driver handles
> Wiegand controller and Wiegand device managemement and driver
> matching. The bus driver defines the structures for Wiegand
> controllers and Wiegand devices.
> 
> Wiegand controller structure represents a master and contains
> attributes such as the payload_len for configuring the size
> of a single Wiegand message in bits. It also stores the
> controller attributes defined in the devicetree.
> 
> Each Wiegand controller should be associated with one Wiegand
> device, as Wiegand is typically a point-to-point bus.

Any chance to have a Datasheet: (or Link:) tag to point to the protocol
specifications?

...

> +config WIEGAND
> +        tristate "Wiegand Bus driver"
> +        help
> +	  The "Wiegand Interface" is an asynchronous low-level protocol
> +	  or wiring standard. It is typically used for point-to-point
> +	  communication. The data length of Wiegand messages is not defined,
> +	  so the devices usually default to 26, 36 or 37 bits per message.
> +	  The throughput of Wiegand depends on the selected pulse length and
> +	  the intervals between pulses, in comparison to other busses it
> +	  is generally rather slow.
> +
> +	  Despite its higher age, Wiegand remains widely used in access
> +	  control systems to connect a card swipe mechanism. Such mechanisms
> +	  utilize the Wiegand effect to transfer data from the card to
> +	  the reader.
> +
> +	  Wiegand uses two wires to transmit the data D0 and D1. Both lines
> +	  are initially pulled up. When a bit of value 0 is being transmitted,
> +	  the D0 line is pulled down. Similarly, when a bit of value 1 is being
> +	  transmitted, the D1 line is pulled down.

&You have an indentation issues in all lines above, except the first one.

Should be

config ...
<TAB>tristate
<TAB>help
<TAB><sp><sp>help text

<TAB> — tabulation
<sp> — space

...

> +#include <linux/cdev.h>

+ container_of.h

> +#include <linux/device.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/property.h>
> +#include <linux/slab.h>

+ types.h

> +#include <linux/wiegand.h>

...

> +/**
> + * struct wiegand_device - Wiegand listener device
> + * @dev - drivers structure of the device
> + * @id - unique device id
> + * @controller - Wiegand controller associated with the device
> + * @modalias - Name of the driver to use with this device, or its alias.
> + */
> +struct wiegand_device {
> +	struct device dev;
> +	u8 id;
> +	struct wiegand_controller *controller;
> +	char modalias[WIEGAND_NAME_SIZE];
> +};

> +DEFINE_IDA(wiegand_controller_ida);

Why not static?

> +static inline void wiegand_device_put(struct wiegand_device *wiegand);
> +static inline struct wiegand_device *to_wiegand_device(struct device *dev);
> +
> +static int wiegand_fopen(struct inode *ino, struct file *filp);
> +static int wiegand_frelease(struct inode *ino, struct file *filp);
> +static ssize_t wiegand_fwrite(struct file *filp, char __user const *buf, size_t len,
> +				loff_t *offset);

Why do you need forward declarations?

...

> +struct wiegand_controller *wiegand_alloc_controller(struct device *dev, unsigned int size,
> +						bool secondary)
> +{
> +	struct wiegand_controller *ctlr;
> +	size_t ctlr_size = ALIGN(sizeof(*ctlr), dma_get_cache_alignment());

> +	if (!dev)
> +		return NULL;

Hmm... Why this check is needed?

> +	ctlr = kzalloc(size + ctlr_size, GFP_KERNEL);

Perhaps you need to use one of the macros from overflow.h.

> +	if (!ctlr)
> +		return NULL;
> +
> +	device_initialize(&ctlr->dev);
> +
> +	ctlr->bus_num = -1;
> +	ctlr->secondary = secondary;
> +	ctlr->dev.parent = dev;
> +	ctlr->dev.release = wiegand_controller_release;
> +
> +	wiegand_controller_set_devdata(ctlr, (void *)ctlr + ctlr_size);
> +
> +	return ctlr;
> +}

...

> +EXPORT_SYMBOL_GPL(wiegand_alloc_controller);

Can we have it namespaced from day 1, please?

...

> +struct wiegand_controller *devm_wiegand_alloc_controller(struct device *dev, unsigned int size,
> +							bool secondary)
> +{
> +	struct wiegand_controller *ctlr, **ptr;
> +
> +	ptr = devres_alloc(devm_wiegand_release_controller, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return NULL;
> +
> +	ctlr = wiegand_alloc_controller(dev, size, secondary);
> +	if (ctlr) {
> +		ctlr->devm_allocated = true;
> +		*ptr = ctlr;
> +		devres_add(dev, ptr);
> +	} else {
> +		devres_free(ptr);
> +	}

Please, use devm_add_action_or_reset().

> +	return ctlr;
> +}

> +/**
> + * register_wiegand_device - allocates and registers a new Wiegand device
> + * @ctlr: controller structure to attach device to
> + * @nc: devicetree node for the device

Have you run kernel doc validator?
And it's not device tree only anymore, use word "firmware" instead.

> + */

...

> +	wiegand = wiegand_alloc_device(ctlr);
> +	if (!wiegand) {

> +		dev_err(&ctlr->dev, "wiegad_device alloc error for %pOF\n", fwnode);

We don't print an error messages for -ENOMEM.

> +		ret = -ENOMEM;
> +		goto err_out;

Are you sure we need to put the device in this case? When it will be not NULL here?

> +	}

> +	fwnode_handle_get(fwnode);
> +	wiegand->dev.fwnode = fwnode;

Not sure why you need a bumped reference, but in any case the problematic
is the second line. Please, avoid dereferencing fwnode in struct device.
Use respective APIs, here is device_set_node().

> +	ret = wiegand_add_device(wiegand);
> +	if (ret) {
> +		dev_err(&ctlr->dev, "wiegand_device register error %pOF\n", fwnode);
> +		goto err_node_put;
> +	}
> +
> +	/* check if more devices are connected to the bus */
> +	if (ctlr->device_count > 1)
> +		dev_warn(&ctlr->dev, "Wiegand is a point-to-point bus, it is advised to only connect one device per Wiegand bus. The devices may not communicate using the same pulse length, format or else.\n");
> +
> +	return wiegand;
> +
> +err_node_put:
> +	fwnode_handle_put(fwnode);
> +err_out:
> +	wiegand_device_put(wiegand);
> +	return ERR_PTR(ret);

...

> +static void register_wiegand_devices(struct wiegand_controller *ctlr)
> +{
> +	struct wiegand_device *wiegand;
> +	struct fwnode_handle *fwnode;

> +	if (!ctlr->dev.fwnode)
> +		return;

This is a dup, which is implied already by the below for_each call.

> +	fwnode_for_each_available_child_node(ctlr->dev.fwnode, fwnode) {
> +		wiegand = register_wiegand_device(ctlr, fwnode);
> +		if (IS_ERR(wiegand))
> +			dev_warn(&ctlr->dev, "failed to create wiegand device for %pOF\n", fwnode);

You are using wrong specifier for fwnode. PLease, fix it everywhere.

> +	}
> +}

...

> +static void wiegand_controller_parse_property(struct device *dev, const char *prop_name,
> +				       u32 *cur_val_p, u32 def_val, bool use_def)
> +{
> +	int ret;
> +
> +	ret = device_property_read_u32(dev, prop_name, cur_val_p);
> +	if ((ret && use_def) || *cur_val_p == 0)
> +		*cur_val_p = def_val;
> +
> +	dev_dbg(dev, "%s: %u\n", prop_name, *cur_val_p);

Why do we need this message? What for?

> +}

> +#define USE_DEFAULT_VAL 1

Redundant. hence redundant second parameter to the above call.

...

> +static void wiegand_controller_parse_properties(struct wiegand_controller *ctlr)
> +{
> +	wiegand_controller_parse_property(&ctlr->dev, "pulse-len-us", &ctlr->pulse_len,
> +					  50, USE_DEFAULT_VAL);
> +	wiegand_controller_parse_property(&ctlr->dev, "interval-len-us", &ctlr->interval_len,
> +					  2000, USE_DEFAULT_VAL);
> +	wiegand_controller_parse_property(&ctlr->dev, "frame-gap-us", &ctlr->frame_gap,
> +					  2000, USE_DEFAULT_VAL);

Default make more sense from group parsing, like I²C core does for timings.

> +}

...

> +int wiegand_register_controller(struct wiegand_controller *ctlr)
> +{
> +	struct device *dev = ctlr->dev.parent;
> +	int status, id;

> +	if (!dev)
> +		return -ENODEV;

Why?

> +	status = wiegand_controller_check_ops(ctlr);
> +	if (status)
> +		return status;
> +
> +	id = ida_alloc(&wiegand_controller_ida, GFP_KERNEL);
> +	if (WARN(id < 0, "couldn't get an id\n"))

Is it really needs to be WARN()?

> +		return id;
> +	ctlr->bus_num = id;

> +	dev_set_name(&ctlr->dev, "wiegand%u", ctlr->bus_num);

No check?

> +	ctlr->miscdev.name = kasprintf(GFP_KERNEL, "wiegand1");
> +	if (!ctlr->miscdev.name)
> +		return -ENOMEM;

...

> +free_bus_id:

out_free_bus_id:

> +	ida_free(&wiegand_controller_ida, ctlr->bus_num);
> +	misc_deregister(&ctlr->miscdev);
> +	kfree(ctlr->miscdev.name);
> +	return status;
> +}

...

> +static inline void wiegand_device_put(struct wiegand_device *wiegand)

And where is the corresponding get()?

> +{
> +	if (wiegand)
> +		put_device(&wiegand->dev);

> +	if (wiegand->controller->cleanup)
> +		wiegand->controller->cleanup(wiegand);

Dup of wiegand_cleanup().

> +}

...

> +static int wiegand_dev_set_name(struct wiegand_device *wiegand, u8 id)
> +{
> +	int ret = dev_set_name(&wiegand->dev, "%s.%u", dev_name(&wiegand->controller->dev), id);
> +	return ret;

	return dev_set_name(...); ?

> +}

...

> +int wiegand_setup(struct wiegand_device *wiegand)
> +{
> +	int status = 0;

Redundant assignment, see below.

> +	if (wiegand->controller->setup) {
> +		status = wiegand->controller->setup(wiegand);
> +		if (status) {
> +			dev_err(&wiegand->controller->dev, "failed to setup device: %d\n", status);

In all such cases you may make the code neater with

	struct device *ctrl_dev = &wiegand->controller->dev;

Also consider

	struct ... *ctrl = wiegand->controller;
	struct device *ctrl_dev = &controller->dev;

> +			return status;
> +		}
> +	}

> +	return status;

Here it's always 0, right?

	return 0;

> +}

...

> +void wiegand_unregister_device(struct wiegand_device *wiegand)
> +{
> +	if (!wiegand)
> +		return;

> +	if (wiegand->dev.fwnode)

Yet another dup conditional, implied by fwnode API.

> +		fwnode_handle_put(wiegand->dev.fwnode);

> +	fwnode_remove_software_node(wiegand->dev.fwnode);

Where this has come from? Leftover from some copy'n'paste?

> +	device_del(&wiegand->dev);
> +	wiegand_cleanup(wiegand);
> +	put_device(&wiegand->dev);
> +}

...

> +static ssize_t wiegand_get_user_data(struct wiegand_controller *ctlr, char __user const *buf,
> +					  size_t len)
> +{
> +	int i;
> +	char data_buffer[WIEGAND_MAX_PAYLEN_BYTES];
> +
> +	if (len > WIEGAND_MAX_PAYLEN_BYTES)
> +		return -EBADMSG;
> +
> +	if (copy_from_user(&data_buffer[0], buf, WIEGAND_MAX_PAYLEN_BYTES))

&data_buffer[0] --> data_buffer

> +		return -EFAULT;
> +
> +	for (i = 0; i < len; i++)
> +		bitmap_set_value8(ctlr->data_bitmap, data_buffer[i], i * 8);
> +
> +	return len;
> +}

I'm wondering why you can't use bitmap_parse_user() with the respective format?
Or even bitmap_parselist_user() (if you feel like this would be better, I feel
like not really, but who knows).

...

> +static ssize_t wiegand_fwrite(struct file *filp, char __user const *buf, size_t len,
> +				loff_t *offset)
> +{
> +	int ret;
> +	struct wiegand_controller *ctlr = filp->private_data;
> +	u32 msg_length = ctlr->payload_len;
> +
> +	if (!buf || len == 0 || DIV_ROUND_UP(msg_length, 8) > len)

BITS_TO_BYTES()

> +		return -EINVAL;
> +
> +	ret = wiegand_get_user_data(ctlr, buf, len);
> +	if (ret < 0)
> +		return ret;
> +
> +	ctlr->transfer_message(ctlr);
> +
> +	return len;
> +}

...

> +static int wiegand_fopen(struct inode *ino, struct file *filp)
> +{
> +	int ret;
> +	struct wiegand_controller *ctlr = container_of(filp->f_op, struct wiegand_controller, fops);
> +
> +	filp->private_data = ctlr;
> +
> +	mutex_lock(&ctlr->file_lock);
> +
> +	if ((filp->f_flags & O_ACCMODE) == O_RDONLY || (filp->f_flags & O_ACCMODE) == O_RDWR) {
> +		dev_err(ctlr->miscdev.this_device, "device is write only\n");
> +		ret = -EIO;
> +		goto err;
> +	}
> +
> +	mutex_unlock(&ctlr->file_lock);
> +
> +	return 0;
> +err:

err_unlock:

> +	mutex_unlock(&ctlr->file_lock);

> +	mutex_destroy(&ctlr->file_lock);

Huh?!

> +	return ret;
> +}

...

> +	return (strcmp(wiegand_dev->modalias, drv->name) == 0);

Outer parentheses are redundant.

...

> +static int wiegand_probe(struct device *dev)
> +{
> +	struct wiegand_device *wiegand = to_wiegand_device(dev);
> +	const struct wiegand_driver *wdrv = to_wiegand_driver(dev->driver);

> +	if (wdrv->probe)

Shouldn't this be a mandatory callback? Or i.o.w. can you elaborate the use
case with probe == NULL?

> +		return wdrv->probe(wiegand);
> +
> +	return 0;
> +}

...

> +static int __init wiegand_init(void)
> +{
> +	int ret;
> +
> +	ret = bus_register(&wiegand_bus_type);
> +	if (ret < 0) {
> +		pr_err("Wiegand bus registration failed: %d\n", ret);

> +		return ret;
> +	}
> +
> +	return 0;

	return ret;

> +}

...

> +postcore_initcall_sync(wiegand_init);

Move it closer to the callback itself.

...


> +#ifndef H_LINUX_INCLUDE_LINUX_WIEGAND_H
> +#define H_LINUX_INCLUDE_LINUX_WIEGAND_H

container_of.h

> +#include <linux/device.h>
> +#include <linux/miscdevice.h>

> +#include <linux/mod_devicetable.h>

Not sure it's in use.

> +#include <linux/mutex.h>

types.h

> +#define WIEGAND_NAME_SIZE 32
> +#define WIEGAND_MAX_PAYLEN_BYTES 256

> +extern struct bus_type wiegand_type;

So, extern or static? Please, be consistent.

...

> +	struct file_operations fops;

Missing header for this data type.

...

> +#define wiegand_primary_get_devdata(_ctlr) wiegand_controller_get_devdata(_ctlr)
> +#define wiegand_primary_set_devdata(_ctlr, _data) wiegand_controller_set_devdata(_ctlr, _data)

Why not _data --> data?

...

> +extern void wiegand_unregister_device(struct wiegand_device *wiegand);
> +extern struct wiegand_controller *wiegand_device_get_controller(struct wiegand_device *dev);
> +
> +extern int wiegand_send_message(struct wiegand_device *wiegand, unsigned long *msg_bmp, u8 bitlen);

...and so on...

Drop extern from the function declarations.

...

> +/* Wiegand driver section  */

Single space is enough.

-- 
With Best Regards,
Andy Shevchenko


