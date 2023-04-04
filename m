Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507FC6D6271
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbjDDNOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbjDDNOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:14:15 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366BE187;
        Tue,  4 Apr 2023 06:13:39 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t4so27521126wra.7;
        Tue, 04 Apr 2023 06:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680614017;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hGuK9yYhbn8CRJkqKEN74LxSRIt47zQq9LwU4qsKrMw=;
        b=FbIlcmeiLekHav2HzzEMn22/eQtS8T4TN9wJvJFDlL7u5oO/HwMOLcumfaWKFU1sPD
         oLoeJZ59dM2EIeKtbbAsXccEX41CCUPSGeGL8hf13rmsPyEg3tZZqrNX42r2ZZFPqgPn
         7p3Eqm3PGFsydLjr1LosEbAOJltoA/waiNUbMlPT5X2ow2u53GMR9HqygdSvgtnY96TV
         BrXiaqInZzAlTEU7s8nkmr16BRSyMpbI0eYkIOOorizunq2bLCwFzz9eQjjEurZ7UsMq
         RVF3rFRaTHXWEYdfa7A657beAwEwLdH5NruoQkLkGd/Z9P4wFIdR3xw99CHKhtVV1Khe
         hj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680614017;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hGuK9yYhbn8CRJkqKEN74LxSRIt47zQq9LwU4qsKrMw=;
        b=U9uduQW13ueWzw57YOEPEuo9fax/5YcmaRBwg/JMHU4DFXiBDm9+W33zIljIdaZEYU
         nggAgeFodqeT6HR1XRg3w+Ako9Vd7i3H66d3cZHB0xdJXpN8PFrJQty6K/jhhGwdpHQy
         +MPdzXJdxE3x8Rn0lXDUwat1/PdN/ojFRq3puFLSVp/lcTO7S0v56IXXqgWX2QHWUSbT
         CLLUWsIovALKP9rjwtojydSR7Jsfa/F7MXArWqlCjjCC3iHIRKNm/qozE6vGVAROB5R3
         OmNAnOL6Y+JtiIFJzeDBhvr6GofLK5UBhyLCjmxpW59WPbZpLMqA/HATtxcXmnJrYc6x
         a6Yg==
X-Gm-Message-State: AAQBX9edMK47o65bmZHLtPNiNYaGJfTAg7wGpgUKrPiX1R4PqRUIqjgX
        xdGdmQO1iWE04tkd7CMeLbM=
X-Google-Smtp-Source: AKy350YvHiybtjhjlcQnyDbNc487cCcyndZu7KLJQgtjYCKPHFEyrifqc+Vd9nnR0MbRCWtDlCaxMw==
X-Received: by 2002:adf:e611:0:b0:2e4:f24e:f5c6 with SMTP id p17-20020adfe611000000b002e4f24ef5c6mr1629151wrm.9.1680614017216;
        Tue, 04 Apr 2023 06:13:37 -0700 (PDT)
Received: from fedora (176-74-132-138.netdatacomm.cz. [176.74.132.138])
        by smtp.gmail.com with ESMTPSA id d9-20020adff849000000b002c56af32e8csm12287206wrq.35.2023.04.04.06.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 06:13:36 -0700 (PDT)
Date:   Tue, 4 Apr 2023 15:13:34 +0200
From:   Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        airlied@redhat.com, dipenp@nvidia.com, treding@nvidia.com,
        mwen@igalia.com, fmdefrancesco@gmail.com, arnd@arndb.de,
        bvanassche@acm.org, ogabbay@kernel.org, axboe@kernel.dk,
        mathieu.poirier@linaro.org, linux@zary.sk, masahiroy@kernel.org,
        yangyicong@hisilicon.com, dan.j.williams@intel.com,
        jacek.lawrynowicz@linux.intel.com, benjamin.tissoires@redhat.com,
        devicetree@vger.kernel.org, furong.zhou@linux.intel.com,
        linus.walleij@linaro.org
Subject: Re: [PATCHv3 2/4] wiegand: add Wiegand bus driver
Message-ID: <ZCwifu6yxUikt42i@fedora>
References: <20230301142835.19614-1-m.zatovic1@gmail.com>
 <20230301142835.19614-3-m.zatovic1@gmail.com>
 <Y/98GqIPgMyPLRi3@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y/98GqIPgMyPLRi3@smile.fi.intel.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 06:23:54PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 01, 2023 at 03:28:33PM +0100, Martin Zaťovič wrote:
> > Add a bus driver for Wiegand protocol. The bus driver handles
> > Wiegand controller and Wiegand device managemement and driver
> > matching. The bus driver defines the structures for Wiegand
> > controllers and Wiegand devices.
> > 
> > Wiegand controller structure represents a master and contains
> > attributes such as the payload_len for configuring the size
> > of a single Wiegand message in bits. It also stores the
> > controller attributes defined in the devicetree.
> > 
> > Each Wiegand controller should be associated with one Wiegand
> > device, as Wiegand is typically a point-to-point bus.
> 
> ...
> 
> > +#include <linux/device.h>
> > +#include <linux/dmaengine.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/property.h>
> > +#include <linux/slab.h>
> > +#include <linux/wiegand.h>
> > +
> > +static struct bus_type wiegand_bus_type;
> 
> > +static DEFINE_IDR(wiegand_controller_idr);
> 
> Why not IDA or even xarray?
> 
> ...
> 
> > +static DEFINE_MUTEX(board_lock);
> 
> Or locks need a good description for what they are.
> 
> ...
> 
> > +static void devm_wiegand_release_controller(struct device *dev, void *ctlr)
> > +{
> > +	wiegand_controller_put(*(struct wiegand_controller **)ctlr);
> > +}
> 
> This is not used in the following function, so can be moved closer to its user.
> 
> ...
> 
> > +struct wiegand_controller *devm_wiegand_alloc_controller(struct device *dev, unsigned int size,
> > +							bool slave)
> > +{
> > +	struct wiegand_controller **ptr, *ctlr;
> > +
> > +	ptr = devres_alloc(devm_wiegand_release_controller, sizeof(*ptr), GFP_KERNEL);
> > +	if (!ptr)
> > +		return NULL;
> > +
> > +	ctlr = wiegand_alloc_controller(dev, size, slave);
> > +	if (ctlr) {
> > +		ctlr->devm_allocated = true;
> > +		*ptr = ctlr;
> > +		devres_add(dev, ptr);
> > +	} else {
> > +		devres_free(ptr);
> > +	}
> > +
> > +	return ctlr;
> 
> Can this utilize devm_add_action_or_reset()?
> 
> > +}
> 
> ...
> 
> > +/**
> > + * of_register_wiegand_device - allocates and registers a new Wiegand device based on devicetree
> 
> NAK for OF only code. New, esp. bus, code must be agnostic. We have all means
> for that.

In one of the previous versions of this patch series, there was also the possibility to instantiate
the device from another driver. I have been told, that this is not the way to go anymore, unless
there is a very specific reason for that. I did not find such reason, so I have removed this suport.

The only other device instantiating method I could think of is ACPI, however I believe it would be
just dead code no one would use, as the Wiegand interface is not normally used on non-embedded
devices. This is the point Evgeny Boger argued for as well. Is there any other device instantiating
method I am not aware of, that would be suitable for this bus?
 
> register_wiegand_device() or similar name.
> 
> > + * node
> > + * @ctlr: controller structure to attach device to
> > + * @nc: devicetree node for the device
> > + */
> > +static struct wiegand_device *of_register_wiegand_device(struct wiegand_controller *ctlr,
> 
> Ditto.
> 
> > +							struct device_node *nc)
> 
> struct fwnode_handle *fwnode
> 
> > +{
> > +	struct wiegand_device *wiegand;
> > +	int rc;
> > +
> > +	wiegand = wiegand_alloc_device(ctlr);
> > +	if (!wiegand) {
> > +		dev_err(&ctlr->dev, "wiegad_device alloc error for %pOF\n", nc);
> > +		rc = -ENOMEM;
> > +		goto err_out;
> > +	}
> 
> > +	of_node_get(nc);
> > +	wiegand->dev.of_node = nc;
> > +	wiegand->dev.fwnode = of_fwnode_handle(nc);
> 
> 	device_set_node(&wiegand->dev, fwnode_handle_get(fwnode));
> 
> > +	rc = wiegand_add_device(wiegand);
> > +	if (rc) {
> > +		dev_err(&ctlr->dev, "wiegand_device register error %pOF\n", nc);
> > +		goto err_of_node_put;
> > +	}
> > +
> > +	/* check if more devices are connected to the bus */
> > +	if (ctlr->device_count > 1)
> > +		dev_warn(&ctlr->dev, "Wiegand is a point-to-point bus, it is advised to only connect one device per Wiegand bus. The devices may not communicate using the same pulse length, format or else.\n");
> > +
> > +	return wiegand;
> > +
> > +err_of_node_put:
> > +	of_node_put(nc);
> > +err_out:
> > +	wiegand_dev_put(wiegand);
> > +	return ERR_PTR(rc);
> > +}
> > +
> > +/**
> > + * of_register_wiegand_devices - creates a wiegand device for all children of a controller
> > + * devicetree node
> > + * @ctlr: controller structure to check
> > + */
> > +static void of_register_wiegand_devices(struct wiegand_controller *ctlr)
> > +{
> > +	struct wiegand_device *wiegand;
> > +	struct device_node *nc;
> > +
> > +	if (!ctlr->dev.of_node)
> > +		return;
> > +
> > +	for_each_available_child_of_node(ctlr->dev.of_node, nc) {
> > +		if (of_node_test_and_set_flag(nc, OF_POPULATED))
> > +			continue;
> > +		wiegand = of_register_wiegand_device(ctlr, nc);
> > +		if (IS_ERR(wiegand)) {
> > +			dev_warn(&ctlr->dev, "Failed to create wiegand device for %pOF\n", nc);
> > +			of_node_clear_flag(nc, OF_POPULATED);
> > +		}
> > +	}
> 
> No way. Use agnostic approach. See above for some suggestions.
> 
> > +}
> 
> ...
> 
> > +	if (!dev)
> > +		return -ENODEV;
> 
> When is it true and why is it a problem?
> 
> > +	if (ctlr->dev.of_node) {
> > +		id = of_alias_get_id(ctlr->dev.of_node, "wiegand");
> 
> Why? What does this bring to us and why it's so important?
> 
> > +		if (id > 0) {
> > +			ctlr->bus_num = id;
> > +			mutex_lock(&board_lock);
> > +			id = idr_alloc(&wiegand_controller_idr, ctlr, ctlr->bus_num,
> > +					ctlr->bus_num + 1, GFP_KERNEL);
> > +			mutex_unlock(&board_lock);
> > +			if (WARN(id < 0, "couldn't get idr"))
> > +				return id == -ENOSPC ? -EBUSY : id;
> 
> Why rewriting error code?
> 
> > +		}
> > +		device_property_read_u32(&ctlr->dev, "pulse-len-us", &ctlr->pulse_len);
> > +		device_property_read_u32(&ctlr->dev, "interval-len-us", &ctlr->interval_len);
> > +		device_property_read_u32(&ctlr->dev, "frame-gap-us", &ctlr->frame_gap);
> > +	}
> > +	if (ctlr->bus_num < 0) {
> > +		first_dynamic = of_alias_get_highest_id("wiegand");
> > +		if (first_dynamic < 0)
> > +			first_dynamic = 0;
> > +		else
> > +			first_dynamic++;
> > +
> > +		mutex_lock(&board_lock);
> > +		id = idr_alloc(&wiegand_controller_idr, ctlr, first_dynamic,
> > +								0, GFP_KERNEL);
> > +		mutex_unlock(&board_lock);
> > +		if (WARN(id < 0, "couldn't get idr\n"))
> > +			return id;
> > +		ctlr->bus_num = id;
> > +	}
> > +
> > +	if (ctlr->pulse_len == 0) {
> > +		dev_warn(&ctlr->dev, "pulse_len is not initialized, setting the default value 50us\n");
> > +		ctlr->pulse_len = 50;
> > +	}
> > +	if (ctlr->interval_len == 0) {
> > +		dev_warn(&ctlr->dev, "interval_len is not initialized, setting the default value 2000us\n");
> > +		ctlr->interval_len = 2000;
> > +	}
> > +	if (ctlr->frame_gap == 0) {
> > +		dev_warn(&ctlr->dev, "frame_gap is not initialized, setting the default value 2000us\n");
> > +		ctlr->frame_gap = 2000;
> > +	}
> 
> Why warnings? Can't it survive without them? (See, for example, how I²C
> controllers get timings).
> 
> > +	dev_set_name(&ctlr->dev, "wiegand%u", ctlr->bus_num);
> > +	ctlr->device_count = 0;
> > +
> > +	status = device_add(&ctlr->dev);
> > +	if (status < 0)
> > +		goto free_bus_id;
> > +
> > +	of_register_wiegand_devices(ctlr);
> > +
> > +	return status;
> > +
> > +free_bus_id:
> > +	mutex_lock(&board_lock);
> > +	idr_remove(&wiegand_controller_idr, ctlr->bus_num);
> > +	mutex_unlock(&board_lock);
> > +	return status;
> > +}
> 
> ...
> 
> > +int devm_wiegand_register_controller(struct device *dev, struct wiegand_controller *ctlr)
> > +{
> > +	struct wiegand_controller **ptr;
> > +	int ret;
> > +
> > +	ptr = devres_alloc(devm_wiegand_unregister, sizeof(*ptr), GFP_KERNEL);
> > +	if (!ptr)
> > +		return -ENOMEM;
> > +
> > +	ret = wiegand_register_controller(ctlr);
> > +	if (!ret) {
> > +		*ptr = ctlr;
> > +		devres_add(dev, ptr);
> > +	} else {
> > +		devres_free(ptr);
> > +	}
> 
> devm_add_action_or_reset() ?
> 
> > +	return ret;
> > +}
> 
> ...
> 
> > +struct wiegand_device *wiegand_alloc_device(struct wiegand_controller *ctlr)
> > +{
> > +	struct wiegand_device *wiegand;
> > +
> > +	if (!wiegand_controller_get(ctlr))
> > +		return NULL;
> 
> Is it important to be called before pure memory allocation? The reference
> counting on the existing resource is less failure prone, right?
> 
> > +	wiegand = kzalloc(sizeof(*wiegand), GFP_KERNEL);
> > +	if (!wiegand) {
> > +		wiegand_controller_put(ctlr);
> > +		return NULL;
> > +	}
> > +
> > +	wiegand->controller = ctlr;
> > +	wiegand->dev.parent = &ctlr->dev;
> > +	wiegand->dev.bus = &wiegand_bus_type;
> > +	wiegand->dev.release = wieganddev_release;
> > +
> > +	device_initialize(&wiegand->dev);
> > +	return wiegand;
> > +}
> 
> ...
> 
> > +static void wiegand_dev_set_name(struct wiegand_device *wiegand, u8 id)
> > +{
> > +	dev_set_name(&wiegand->dev, "%s.%u", dev_name(&wiegand->controller->dev), id);
> 
> Why error is ignored?
> 
> > +}
> 
> ...
> 
> > +	if (wiegand->dev.of_node) {
> > +		of_node_clear_flag(wiegand->dev.of_node, OF_POPULATED);
> > +		of_node_put(wiegand->dev.of_node);
> > +	}
> 
> fwnode APIs, please.
> 
> ...
> 
> > +static int wiegand_probe(struct device *dev)
> > +{
> > +	struct wiegand_device *wiegand = to_wiegand_device(dev);
> > +	const struct wiegand_driver *wdrv = to_wiegand_driver(dev->driver);
> > +	int ret = 0;
> > +
> > +	if (wdrv->probe)
> > +		ret = wdrv->probe(wiegand);
> > +
> > +	return ret;
> 
> Hmm... this is just
> 
> 	if (wdrv->probe)
> 		return wdrv->probe(wiegand);
> 
> 	return 0;
> 
> > +}
> 
> ...
> 
> > +	if (wdrv->driver.of_match_table) {
> > +		const struct of_device_id *of_id;
> > +
> > +		for (of_id = wdrv->driver.of_match_table; of_id->compatible[0];
> > +			of_id++) {
> > +			const char *of_name;
> > +
> > +			/* remove vendor prefix */
> > +			of_name = strnchr(of_id->compatible,
> > +						sizeof(of_id->compatible), ',');
> > +			if (of_name)
> > +				of_name++;
> > +			else
> > +				of_name = of_id->compatible;
> > +
> > +			if (wdrv->driver.name) {
> > +				if (strcmp(wdrv->driver.name, of_name) == 0)
> > +					continue;
> > +			}
> > +
> > +			pr_warn("Wiegand driver %s has no device_id for %s\n",
> > +				wdrv->driver.name, of_id->compatible);
> > +		}
> > +	}
> 
> This looks like very much of a repetition of the existing code somewhere.
> 
> ...
> 
> > +/**
> > + * struct wiegand_device - Wiegand listener device
> > + * @dev - drivers structure of the device
> > + * @id - unique device id
> > + * @controller - Wiegand controller associated with the device
> > + * @modalias - Name of the driver to use with this device, or its alias.
> > + */
> > +struct wiegand_device {
> > +	struct device dev;
> > +	u8 id;
> > +	struct wiegand_controller *controller;
> > +	char modalias[WIEGAND_NAME_SIZE];
> > +};
> 
> Wondering if this can be made an opaque pointer instead.
> 
> ...
> 
> > +/**
> > + * struct wiegand_controller - Wiegand master or slave interface
> > + * @dev - Device interface of the controller
> > + * @list - Link with the global wiegand_controller list
> > + * @bus_num - Board-specific identifier for Wiegand controller
> > + * @pulse_len: length of the low pulse in usec; defaults to 50us
> > + * @interval_len: length of a whole bit (both the pulse and the high phase) in usec;
> > + * defaults to 2000us
> > + * @frame_gap: length of the last bit of a frame (both the pulse and the high phase) in usec;
> > + * defaults to interval_len
> > + * device_count - Counter of devices connected to the same Wiegand bus(controller).
> > + * devm_allocated - Whether the allocation of this struct is devres-managed
> > + * slave - Whether the controller is a slave(receives data).
> > + * transfer_message - Send a message on the bus.
> > + * setup - Setup a device.
> > + * cleanup - Cleanup after a device.
> 
> At some point you lost the grip on @ key button.
> 
> > + */
> 
> ...
> 
> > +struct wiegand_driver {
> > +	const struct wiegand_device_id *id_table;
> > +	int (*probe)(struct wiegand_device *wiegand);
> > +	void (*remove)(struct wiegand_device *wiegand);
> 
> > +	struct device_driver driver;
> 
> Making it first may save a few assembly instructions in pointer arithmetics.
> Check if I'm right with bloat-o-meter (you will need a user of this data type,
> of course).
> 
> > +};
> 
> ...
> 
> > +		driver_unregister(&wdrv->driver);
> 
> Yep, here and...
> 
> > +	return drv ? container_of(drv, struct wiegand_driver, driver) : NULL;
> 
> ...here you will save code bytes.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
