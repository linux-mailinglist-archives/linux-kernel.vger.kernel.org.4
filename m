Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D2C7430D0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 00:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjF2W5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 18:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjF2W5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 18:57:31 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA302D66;
        Thu, 29 Jun 2023 15:57:29 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-53482b44007so786830a12.2;
        Thu, 29 Jun 2023 15:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688079449; x=1690671449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=//XkPHnuGJf2IOvnDVtpFN7BiCi+0kU3RSXDqWDC4Jc=;
        b=Ci1DOyXZuGKXKi5gnPldNe4WaQlpFnxx09Ku9PatH7c4QZRIkYCPltQUUcRo5QHFAt
         nqpmTTm4acwzrrfwQ8iGWKShzCieA6wfKNPomLDAQG4R8zOafun4sY482vzhcwAMzqfD
         S4YfUuwMgipdNLnrAbla+3zc+ooFjqKRoB2BgIWY05zID8HUp0JhnntjBPyKoa3JICMZ
         vwe70LlAUs2QpjViUhIxH0JDSjVjyp4XYW3d1HrJ1mGzsvOsPtc/QgwlgYV66Vu4tbmk
         x41PpoIEzhxl8aeg+GrRfZxOicPS0Ho+B5qMbTfSSDHk9gNO9qByE+EF4qUox0xYAnak
         bJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688079449; x=1690671449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//XkPHnuGJf2IOvnDVtpFN7BiCi+0kU3RSXDqWDC4Jc=;
        b=RDjriHJIIO7rAzcu54jetgQ9BUIJLICRyLJWkedor1TcbMNTH2PYV2UKE9/ZsaPJEW
         FKZS/MRbl6r0ZUM/xDdrIHBV68vb6z4VaemnVYxJeRin6AvnrVYL4cOqP+JtQDirlii1
         d8+BgPZ9cJsMNTCxq63gIE0IJk5DCqvkRN+dJ8im3tYu6P/OhF1G5G+eB23iFBcoIPVz
         OuYv/popvji2UdNsdJ5NTrTTrNlDv3ccnzfCGfWkFwMYn/7nu48ai8DavQv+SmRC2W3K
         s8gnnyacFQ7TWqzsgCqpo4/cRbv6XxduaVV0LF0ap4zQfhAEm9zOVQPkKfVeKw4rYiyo
         a1MA==
X-Gm-Message-State: AC+VfDxeISWb4uf6aa6SueszeenyJb4dlj5jD5afcKozsEXIh6hO6Bxg
        2L65N57lUdGXxfbHHgfM2Dg=
X-Google-Smtp-Source: ACHHUZ5Qfy2OmteyGVJccAEj/E8sstboiyb2RSM+vxGhgsZwnpLDLcJnurrXjyEVZzrlwSEajJsLgg==
X-Received: by 2002:a05:6a20:414:b0:110:9210:f6ac with SMTP id a20-20020a056a20041400b001109210f6acmr828454pza.37.1688079448908;
        Thu, 29 Jun 2023 15:57:28 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:692a:e33f:89e4:fd27])
        by smtp.gmail.com with ESMTPSA id c4-20020aa781c4000000b00653fe2d527esm8834525pfn.32.2023.06.29.15.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 15:57:28 -0700 (PDT)
Date:   Thu, 29 Jun 2023 15:57:25 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "jingle.wu" <jingle.wu@emc.com.tw>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        phoenix@emc.com.tw, josh.chen@emc.com.tw, dave.wang@emc.com.tw
Subject: Re: [PATCH]  Input: elan_i2c - Implement inhibit/uninhibit functions.
Message-ID: <ZJ4MVbTnBT5sM5XR@google.com>
References: <20230531090340.1035499-1-jingle.wu@emc.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531090340.1035499-1-jingle.wu@emc.com.tw>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jingle,

On Wed, May 31, 2023 at 05:03:40PM +0800, jingle.wu wrote:
>  Add inhibit/uninhibit functions.

You need to provide justification for this change, i.e. explain why you
need this/what is currently not working or working sub-optimally.

> 
>  Signed-off-by: Jingle.wu <jingle.wu@emc.com.tw>
> ---
>  drivers/input/mouse/elan_i2c_core.c | 207 ++++++++++++++++++++++++++++
>  1 file changed, 207 insertions(+)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index 5f0d75a45c80..4ea57f4c7bd4 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -56,6 +56,7 @@ struct elan_tp_data {
>  	struct input_dev	*input;
>  	struct input_dev	*tp_input; /* trackpoint input node */
>  	struct regulator	*vcc;
> +	struct list_head list;	/* for list of devices needing input handler */
>  
>  	const struct elan_transport_ops *ops;
>  
> @@ -63,6 +64,11 @@ struct elan_tp_data {
>  	struct completion	fw_completion;
>  	bool			in_fw_update;
>  
> +	struct work_struct	lid_work;
> +	bool			lid_switch;
> +	int			lid_value;
> +	bool			in_inhibit;
> +
>  	struct mutex		sysfs_mutex;
>  
>  	unsigned int		max_x;
> @@ -96,6 +102,9 @@ struct elan_tp_data {
>  	u32			quirks;		/* Various quirks */
>  };
>  
> +static struct workqueue_struct *elan_mode_wq;
> +static LIST_HEAD(elan_devices_with_lid_handler);
> +
>  static u32 elan_i2c_lookup_quirks(u16 ic_type, u16 product_id)
>  {
>  	static const struct {
> @@ -329,6 +338,74 @@ static int elan_initialize(struct elan_tp_data *data, bool skip_reset)
>  	return error;
>  }
>  
> +static int elan_reactivate(struct elan_tp_data *data)
> +{
> +	struct device *dev = &data->client->dev;
> +	int error;
> +
> +	error = elan_set_power(data, true);
> +	if (error)
> +		dev_err(dev, "failed to restore power: %d\n", error);
> +
> +	error = data->ops->sleep_control(data->client, false);
> +	if (error) {
> +		dev_err(dev,
> +			"failed to wake device up: %d\n", error);
> +		return error;
> +	}
> +
> +	return error;
> +}
> +
> +static int elan_inhibit(struct input_dev *input_dev)

I would rather you did not call it inhibit/uninhibit because this is not
what it does.

Please split the logic for recalibration from logic of powering on and
off the device. I also hope in the future firmware revisions the
distinction will be more clear (i.e. have a separate method/command to
recalibrate baseline on demand).

> +{
> +	struct elan_tp_data *data = input_get_drvdata(input_dev);
> +	struct i2c_client *client = data->client;
> +	int error;
> +
> +	dev_dbg(&client->dev, "inhibiting\n");
> +	/*
> +	 * We are taking the mutex to make sure sysfs operations are
> +	 * complete before we attempt to bring the device into low[er]
> +	 * power mode.
> +	 */
> +	error = mutex_lock_interruptible(&data->sysfs_mutex);
> +	if (error)
> +		return error;
> +
> +	disable_irq(client->irq);
> +
> +	error = elan_set_power(data, false);
> +	if (error)
> +		enable_irq(client->irq);
> +
> +	data->in_inhibit = true;
> +	mutex_unlock(&data->sysfs_mutex);
> +
> +	return error;
> +}
> +
> +static int elan_uninhibit(struct input_dev *input_dev)
> +{
> +	struct elan_tp_data *data = input_get_drvdata(input_dev);
> +	struct i2c_client *client = data->client;
> +	int error;
> +
> +	dev_dbg(&client->dev, "uninhibiting\n");
> +	error = mutex_lock_interruptible(&data->sysfs_mutex);
> +	if (error)
> +		return error;
> +
> +	error = elan_reactivate(data);
> +	if (error == 0)
> +		enable_irq(client->irq);
> +
> +	data->in_inhibit = false;
> +	mutex_unlock(&data->sysfs_mutex);
> +
> +	return error;
> +}
> +
>  static int elan_query_device_info(struct elan_tp_data *data)
>  {
>  	int error;
> @@ -1187,6 +1264,124 @@ static void elan_disable_regulator(void *_data)
>  	regulator_disable(data->vcc);
>  }
>  
> +static void lid_work_handler(struct work_struct *work)
> +{
> +	struct elan_tp_data *data = container_of(work, struct elan_tp_data,
> +					    lid_work);
> +
> +	if (data->lid_value)
> +		elan_inhibit(data->input);
> +	else
> +		elan_uninhibit(data->input);
> +
> +}
> +
> +static void elan_input_lid_event(struct input_handle *handle, unsigned int type,
> +			     unsigned int code, int value)
> +{
> +	struct elan_tp_data *data, *n;
> +
> +	if (type == EV_SW && code == SW_LID) {
> +		list_for_each_entry_safe(data, n, &elan_devices_with_lid_handler, list) {

Why do you need the "_safe()" variant here?

> +			data->lid_value = value;
> +			queue_work(elan_mode_wq, &data->lid_work);
> +		}
> +	}
> +
> +}
> +
> +struct elan_input_lid {
> +	struct input_handle handle;
> +};
> +
> +static int elan_input_lid_connect(struct input_handler *handler,
> +				struct input_dev *dev,
> +				const struct input_device_id *id)
> +{
> +	struct elan_input_lid *lid;
> +	char *name;
> +	int error;
> +
> +	lid = kzalloc(sizeof(*lid), GFP_KERNEL);
> +	if (!lid)
> +		return -ENOMEM;
> +	name = kasprintf(GFP_KERNEL, "elan-i2c-lid-%s", dev_name(&dev->dev));
> +	if (!name) {
> +		error = -ENOMEM;
> +		goto err_free_lid;
> +	}
> +	lid->handle.dev = dev;
> +	lid->handle.handler = handler;
> +	lid->handle.name = name;
> +	lid->handle.private = lid;
> +	error = input_register_handle(&lid->handle);
> +	if (error)
> +		goto err_free_name;
> +	error = input_open_device(&lid->handle);
> +	if (error)
> +		goto err_unregister_handle;
> +	return 0;
> +err_unregister_handle:
> +	input_unregister_handle(&lid->handle);
> +err_free_name:
> +	kfree(name);
> +err_free_lid:
> +	kfree(lid);
> +	return error;
> +}
> +
> +static void elan_input_lid_disconnect(struct input_handle *handle)
> +{
> +	struct elan_input_lid *lid = handle->private;
> +
> +	input_close_device(handle);
> +	input_unregister_handle(handle);
> +	kfree(handle->name);
> +	kfree(lid);
> +}
> +
> +static const struct input_device_id elan_input_lid_ids[] = {
> +	{
> +		.flags = INPUT_DEVICE_ID_MATCH_EVBIT | INPUT_DEVICE_ID_MATCH_SWBIT,
> +		.evbit = { BIT_MASK(EV_SW) },
> +		.swbit = { [BIT_WORD(SW_LID)] = BIT_MASK(SW_LID) },
> +	},
> +	{ },
> +};
> +
> +static struct input_handler elan_input_lid_handler = {
> +	.event =	elan_input_lid_event,
> +	.connect =	elan_input_lid_connect,
> +	.disconnect =	elan_input_lid_disconnect,
> +	.name =		"elan-i2c-lid",
> +	.id_table =	elan_input_lid_ids,
> +};
> +
> +static int elan_create_lid_handler(struct elan_tp_data *data)
> +{
> +	int error = 0;
> +
> +	elan_mode_wq = create_singlethread_workqueue("elan-i2c-lid");
> +	if (elan_mode_wq == NULL)
> +		return -ENOMEM;
> +	error = input_register_handler(&elan_input_lid_handler);
> +	if (error)
> +		goto remove_wq;
> +
> +	data->lid_switch = true;
> +	INIT_LIST_HEAD(&data->list);
> +	INIT_WORK(&data->lid_work, lid_work_handler);
> +	list_add_tail(&data->list, &elan_devices_with_lid_handler);

It looks like you call elan_create_lid_handler() from elan_probe() which
means it can be called several times (we should not assume there is only
one controller), I do not see it being destroyed in remove() either, so
it will break if you bind/unbind the driver.

I also not sure why you need the list of you have a handler per device.

> +
> +	return 0;
> +
> +remove_wq:
> +	data->lid_switch = false;
> +	destroy_workqueue(elan_mode_wq);
> +	elan_mode_wq = NULL;
> +	return error;
> +}
> +
>  static int elan_probe(struct i2c_client *client)
>  {
>  	const struct elan_transport_ops *transport_ops;
> @@ -1325,6 +1520,10 @@ static int elan_probe(struct i2c_client *client)
>  		}
>  	}
>  
> +	error = elan_create_lid_handler(data);
> +	if (error)
> +		dev_err(dev, "failed to create lid handler: %d\n", error);

Do we need this on _ALL_ devices with ELan controllers, or just certain
ones? If we need this on all devices how did it work before?

> +
>  	return 0;
>  }
>  
> @@ -1334,6 +1533,10 @@ static int elan_suspend(struct device *dev)
>  	struct elan_tp_data *data = i2c_get_clientdata(client);
>  	int ret;
>  
> +	/* Wait for switch on completion */
> +	if (data->lid_switch)
> +		flush_workqueue(elan_mode_wq);
> +
>  	/*
>  	 * We are taking the mutex to make sure sysfs operations are
>  	 * complete before we attempt to bring the device into low[er]
> @@ -1371,6 +1574,10 @@ static int elan_resume(struct device *dev)
>  	struct elan_tp_data *data = i2c_get_clientdata(client);
>  	int error;
>  
> +	/* Wait for switch on completion */
> +	if (data->lid_switch)
> +		flush_workqueue(elan_mode_wq);
> +
>  	if (!device_may_wakeup(dev)) {
>  		error = regulator_enable(data->vcc);
>  		if (error) {
> -- 
> 2.34.1
> 

Thanks.

-- 
Dmitry
