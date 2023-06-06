Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F44C723F84
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbjFFKbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236509AbjFFKbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:31:13 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234EFE6B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 03:31:11 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30af0aa4812so5206318f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 03:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686047469; x=1688639469;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xEhOE7EhxiqpNXAVevgISULdlJWzN8eAAWT1TUAi6H0=;
        b=owU15IS9d3m9wkcmISn1Wue3MmtS5RyVmrKCscWGQimBK8eaeLJdjA7kCubuXeZrmE
         sm6CtOfFnwnKaXCsrt6mQVTSZd4ljRwg7dblGcvHU8WfrHjU99mgKnHdshQJPFdR3Vud
         8Er8UxmvAyyPdmfAehXM8oYhrpqzeK5OTxZiOzL8P4E6yO4jc9q+s48DkA0Igc9bmMWc
         APweIQX8z6TfupPuC+YScdeDH4JhV0XcuslUcjOgrOIQh7oTOTYhV20Uh4To/aUFwykd
         aWnWlCkukWhMqg+yAT0ETiR7ynspXI2YwJfMRcTIkQg2KVfDyeTPFpMD/zF3wbqwpYYa
         PTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686047469; x=1688639469;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xEhOE7EhxiqpNXAVevgISULdlJWzN8eAAWT1TUAi6H0=;
        b=UEc+UlflinqcN14AoSxWREfmRJR9UrHOGUPHHmGwul0EgoakHGJ2BRve59ZI0/PXfO
         h/DluEoyvPF12VOF3keT2M3GNwRbVRUKVKJZOAD2y94a0/m3+6zodAwST58b0kT3ezSt
         HMRK1A/lMMKmV3/xEvVGKBYLdS6/p0frTUvWt3643hg5/61c88BPcS9O7U7E/Y/UVYMf
         b+R2+EN+f6kTQEGrp6HxYQoAzSJhURWWzJWzZPzpSTqVbtT3PnJVP6/tc/sy9RM2meCN
         pUhVGq03M6uMflZ4vHChKKNhOecTqPvI6NwFA8CW8pbcnDnbPfy/UjBBLLVn6zOvy9VG
         XSig==
X-Gm-Message-State: AC+VfDyOpyWa/xxWc1enXxl9cGz3sbRHTvR+Mvy2otz/1UEm01PDgm1s
        oFPYvqIcTgOr8bX3RZLG0jYtdQ==
X-Google-Smtp-Source: ACHHUZ7xy1qN0wy7rHCiMLoVjV0D7RfNzNljYGM1u0gFLJjeI1MK6g0q3gP/TnZxyB0dgeIeiSiZsA==
X-Received: by 2002:adf:cc8c:0:b0:307:9f8:4f30 with SMTP id p12-20020adfcc8c000000b0030709f84f30mr1328925wrj.70.1686047469462;
        Tue, 06 Jun 2023 03:31:09 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id m17-20020a5d4a11000000b003048477729asm12289789wrq.81.2023.06.06.03.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 03:31:08 -0700 (PDT)
Message-ID: <20aa1fc7-3844-a565-03a2-e2d8ce6055d5@linaro.org>
Date:   Tue, 6 Jun 2023 11:31:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 4/4] nvmem: core: Expose cells through sysfs
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, Rafael J Wysocki <rafael@kernel.org>
References: <20230605133422.45840-1-miquel.raynal@bootlin.com>
 <20230605133422.45840-5-miquel.raynal@bootlin.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230605133422.45840-5-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for doing this Miquel

Few minor comments below.

On 05/06/2023 14:34, Miquel Raynal wrote:
> The binary content of nvmem devices is available to the user so in the
> easiest cases, finding the content of a cell is rather easy as it is
> just a matter of looking at a known and fixed offset. However, nvmem
> layouts have been recently introduced to cope with more advanced
> situations, where the offset and size of the cells is not known in
> advance or is dynamic. When using layouts, more advanced parsers are
> used by the kernel in order to give direct access to the content of each
> cell, regardless of its position/size in the underlying
> device. Unfortunately, these information are not accessible by users,
> unless by fully re-implementing the parser logic in userland.
> 
> Let's expose the cells and their content through sysfs to avoid these
> situations. Of course the relevant NVMEM sysfs Kconfig option must be
> enabled for this support to be available.
> 
> Not all nvmem devices expose cells. Indeed, the .bin_attrs attribute
> group member will be filled at runtime only when relevant and will
> remain empty otherwise. In this case, as the cells attribute group will
> be empty, it will not lead to any additional folder/file creation.
> 
> Exposed cells are read-only. There is, in practice, everything in the
> core to support a write path, but as I don't see any need for that, I
> prefer to keep the interface simple (and probably safer). The interface
> is documented as being in the "testing" state which means we can later
> add a write attribute if though relevant.
> 
> There is one limitation though: if a layout is built as a module but is
> not properly installed in the system and loaded manually with insmod
> while the nvmem device driver was built-in, the cells won't appear in
> sysfs. But if done like that, the cells won't be usable by the built-in
> kernel drivers anyway.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>   drivers/nvmem/core.c | 128 +++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 124 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 342cd380b420..625e3de273b7 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -325,6 +325,61 @@ static umode_t nvmem_bin_attr_is_visible(struct kobject *kobj,
>   	return nvmem_bin_attr_get_umode(nvmem);
>   }
>   
> +static struct nvmem_cell *nvmem_create_cell(struct nvmem_cell_entry *entry,
> +					    const char *id, int index);
> +
> +static ssize_t nvmem_cell_attr_read(struct file *filp, struct kobject *kobj,
> +				    struct bin_attribute *attr, char *buf,
> +				    loff_t pos, size_t count)
> +{
> +	struct nvmem_cell_entry *entry;
> +	struct nvmem_cell *cell = NULL;
> +	struct nvmem_device *nvmem;
> +	size_t cell_sz, read_len;
> +	struct device *dev;
> +	void *content;
> +
> +	if (attr->private)
> +		dev = attr->private;
I see no point in this, as we do not set any private data for this 
attribute.

How about storing nvmem_cell_entry in private and using it here.
This should also avoid looping for every cell in the follow on code.

> +	else
> +		dev = kobj_to_dev(kobj);

new line here.

> +	nvmem = to_nvmem_device(dev);
> +
> +	mutex_lock(&nvmem_mutex);
> +	list_for_each_entry(entry, &nvmem->cells, node) {
> +		if (strncmp(entry->name, attr->attr.name, XATTR_NAME_MAX))
> +			continue;
> +
> +		cell = nvmem_create_cell(entry, entry->name, 0);

> +		if (IS_ERR(cell)) {
> +			mutex_unlock(&nvmem_mutex);
> +			return PTR_ERR(cell);
> +		}
> +
> +		break;
> +	}
> +	mutex_unlock(&nvmem_mutex);
> +
> +	if (!cell)
> +		return -EINVAL;
> +
> +	content = nvmem_cell_read(cell, &cell_sz);
> +	if (IS_ERR(content)) {
> +		read_len = PTR_ERR(content);
> +		goto destroy_cell;
> +	}
> +
> +	read_len = min_t(unsigned int, cell_sz - pos, count); > +	memcpy(buf, content + pos, read_len);
> +	kfree(content);
> +
> +destroy_cell:
> +	kfree_const(cell->id);
> +	kfree(cell);
> +
> +	return read_len;
> +}
> +
>   /* default read/write permissions */
>   static struct bin_attribute bin_attr_rw_nvmem = {
>   	.attr	= {
> @@ -346,8 +401,14 @@ static const struct attribute_group nvmem_bin_group = {
>   	.is_bin_visible = nvmem_bin_attr_is_visible,
>   };
>   
> +/* Cell attributes will be dynamically allocated */
> +static struct attribute_group nvmem_cells_group = {
> +	.name		= "cells",
> +};
> +
>   static const struct attribute_group *nvmem_dev_groups[] = {
>   	&nvmem_bin_group,
> +	&nvmem_cells_group,
>   	NULL,
>   };
>   
> @@ -406,6 +467,59 @@ static void nvmem_sysfs_remove_compat(struct nvmem_device *nvmem,
>   		device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
>   }
>   
> +static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
> +{
> +	struct bin_attribute **cells_attrs, *attrs;
> +	struct nvmem_cell_entry *entry;
> +	unsigned int ncells = 0, i = 0;
> +	int ret = 0;
> +
> +	mutex_lock(&nvmem_mutex);
> +
> +	if (list_empty(&nvmem->cells))
> +		goto unlock_mutex;
> +
> +	list_for_each_entry(entry, &nvmem->cells, node)
> +		ncells++;

list_count_nodes?

> +
> +	/* Allocate an array of attributes with a sentinel */
> +	cells_attrs = devm_kcalloc(&nvmem->dev, ncells + 1,
> +				   sizeof(struct bin_attribute *), GFP_KERNEL);
> +	if (!cells_attrs) {
> +		ret = -ENOMEM;
> +		goto unlock_mutex;
> +	}
> +
> +	attrs = devm_kcalloc(&nvmem->dev, ncells, sizeof(struct bin_attribute), GFP_KERNEL);
> +	if (!attrs) {
> +		ret = -ENOMEM;
> +		goto unlock_mutex;
> +	}
> +
> +	/* Initialize each attribute to take the name and size of the cell */
> +	list_for_each_entry(entry, &nvmem->cells, node) {
> +		sysfs_bin_attr_init(&attrs[i]);
> +		attrs[i].attr.name = devm_kstrdup(&nvmem->dev, entry->name, GFP_KERNEL);
> +		attrs[i].attr.mode = 0444;
> +		attrs[i].size = entry->bytes;
> +		attrs[i].read = &nvmem_cell_attr_read;
> +		if (!attrs[i].attr.name) {
> +			ret = -ENOMEM;
> +			goto unlock_mutex;
> +		}
> +
> +		cells_attrs[i] = &attrs[i];
> +		i++;
> +	}
> +
> +	nvmem_cells_group.bin_attrs = cells_attrs;
> +
> +unlock_mutex:
> +	mutex_unlock(&nvmem_mutex);
> +
> +	return ret;
> +}
> +
>   #else /* CONFIG_NVMEM_SYSFS */
>   
>   static int nvmem_sysfs_setup_compat(struct nvmem_device *nvmem,
> @@ -976,16 +1090,22 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   	if (rval)
>   		goto err_remove_cells;
>   
> +	rval = nvmem_add_cells_from_layout(nvmem);
> +	if (rval)
> +		goto err_remove_cells;
> +
> +#ifdef CONFIG_NVMEM_SYSFS
> +	rval = nvmem_populate_sysfs_cells(nvmem);
> +	if (rval)
> +		goto err_remove_cells;
> +#endif
> +
>   	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
>   
>   	rval = device_add(&nvmem->dev);
>   	if (rval)
>   		goto err_remove_cells;
>   
> -	rval = nvmem_add_cells_from_layout(nvmem);
> -	if (rval)
> -		goto err_remove_cells;
> -
>   	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
>   
>   	return nvmem;
