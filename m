Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E821725DAE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240091AbjFGLwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239831AbjFGLwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:52:44 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBF81BC2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 04:52:40 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9745ba45cd1so954028866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 04:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686138758; x=1688730758;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D24yblh8M2wbDLcZhpK9nT1oK0h4QFEUd0Odb6kt/DI=;
        b=a4DDOHjY61G9Z4sac9Z0dzfj94q0De5RzBh/fz9CDTP8mewT9DANFb1b190UlB5U/u
         g40LnQu/QL+gx1y4L82z6kkqA6WdM+4e6nJcOIpDbS5Tp5gRfB/Tg5gvx832zY08WJIv
         i5a+Etqtd4wx2SxWw1Wr5SZqFvgIqwkpRutVDVEm/NzH6rpOKemG2beYEneZHWIdxp99
         3X5BPL/KnrJq0i7zdVGb7gBq0XGZaKyF1kbOh1wCN+2NT+NR7dlHDlCYNzTAaYg1VaGH
         jp+KILME0G8ei3X8tTNnS1WnxrDloZzDDmReWtbDEzo8YEvDHFNulf9TW8Bx81WHOu1T
         AIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686138758; x=1688730758;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D24yblh8M2wbDLcZhpK9nT1oK0h4QFEUd0Odb6kt/DI=;
        b=MTb7zLy3aLnHOjfE3hWz7WY8dByViiBM9takx2kkjXUSE+Lb/3TH1UJVT6w6hdyoj5
         mxV71fezLnpoOYLgajxhPE1ZtjMTMwwYtQL6VrvILsvWKZt75RAqb3eemechHarhWQ7t
         /9YdbLAUl+vIIKoCu3hJxlDdcvgsV6OqQc1ovdc0axzK/xfrTZqxMNL37haf8w6HbRnR
         TI7i1g34VEUnjXMJq5/jhOQbZgfUZWlskRlTmO3b28Vz8zZi98w4w9NJL+hPVIhLVK/S
         ci0CwJzZWAr0lo0CL3O1R1xemkU45Wu4Io6tKrTnvC3FRgSgD3EJTPPnhqO/oN5UF6Xp
         6oXQ==
X-Gm-Message-State: AC+VfDyIDvYC0nQWKL/9WAA2obrYJcEHKFZ+4E6b6DYQty0YEvC+H6zh
        hUz8t2wKBonQexZXyXDpyESxWw==
X-Google-Smtp-Source: ACHHUZ7+a9+a6QmaEB7QGUtAAB1+s3uUqlYNvSB4b/wGPQPPz4VtqYN6n6u4am6a89nRgPKkgHwWSA==
X-Received: by 2002:a17:907:a424:b0:960:ce5:20c0 with SMTP id sg36-20020a170907a42400b009600ce520c0mr5542571ejc.20.1686138758421;
        Wed, 07 Jun 2023 04:52:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id a23-20020a170906671700b009787b13d1ddsm966631ejp.51.2023.06.07.04.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 04:52:37 -0700 (PDT)
Message-ID: <a9a2f3d0-9580-f027-8ec3-ac6e6bed5ed6@linaro.org>
Date:   Wed, 7 Jun 2023 13:52:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 3/5] phy: realtek: usb: Add driver for the Realtek SoC
 USB 3.0 PHY
Content-Language: en-US
To:     Stanley Chang <stanley_chang@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ray Chi <raychi@google.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20230607062500.24669-1-stanley_chang@realtek.com>
 <20230607062500.24669-3-stanley_chang@realtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230607062500.24669-3-stanley_chang@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 08:24, Stanley Chang wrote:
> Realtek DHC (digital home center) RTD SoCs support DWC3 XHCI USB
> controller. Added the driver to drive the USB 3.0 PHY transceivers.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---


> +static inline int utmi_wait_register(void __iomem *reg, u32 mask, u32 result)
> +{
> +	int ret;
> +	unsigned int val;
> +
> +	ret = read_poll_timeout(readl, val, ((val & mask) == result),
> +		    PHY_IO_DELAY_US, PHY_IO_TIMEOUT_USEC, false, reg);
> +	if (ret) {
> +		pr_err("%s can't program USB phy\n", __func__);
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rtk_usb_phy3_wait_vbusy(struct reg_addr *regAddr)
> +{
> +	return utmi_wait_register(regAddr->reg_mdio_ctl, USB_MDIO_CTRL_PHY_BUSY, 0);
> +}
> +
> +static u16 rtk_usb_phy_read(struct reg_addr *regAddr, char addr)
> +{
> +	unsigned int regVal;
> +	u32 value;
> +
> +	regVal = (addr << USB_MDIO_CTRL_PHY_ADDR_SHIFT);
> +
> +	writel(regVal, regAddr->reg_mdio_ctl);
> +
> +	rtk_usb_phy3_wait_vbusy(regAddr);
> +
> +	value = readl(regAddr->reg_mdio_ctl);
> +	value = value >> USB_MDIO_CTRL_PHY_DATA_SHIFT;
> +
> +	return (u16)value;
> +}
> +
> +static int rtk_usb_phy_write(struct reg_addr *regAddr, char addr, u16 data)
> +{
> +	unsigned int regVal;
> +
> +	regVal = USB_MDIO_CTRL_PHY_WRITE |
> +		    (addr << USB_MDIO_CTRL_PHY_ADDR_SHIFT) |
> +		    (data << USB_MDIO_CTRL_PHY_DATA_SHIFT);
> +
> +	writel(regVal, regAddr->reg_mdio_ctl);
> +
> +	rtk_usb_phy3_wait_vbusy(regAddr);
> +
> +	return 0;
> +}
> +
> +static void do_rtk_usb3_phy_toggle(struct rtk_usb_phy *rtk_phy, int i,
> +	    bool isConnect)
> +{
> +	struct reg_addr *regAddr;
> +	struct phy_data *phy_data;
> +	struct phy_parameter *phy_parameter;
> +	size_t index;
> +
> +	regAddr = &((struct reg_addr *)rtk_phy->reg_addr)[i];
> +	phy_data = &((struct phy_data *)rtk_phy->phy_data)[i];
> +
> +	if (!phy_data) {
> +		dev_err(rtk_phy->dev, "%s phy_data is NULL!\n", __func__);

???

> +		return;
> +	}
> +
> +	if (!phy_data->do_toggle)
> +		return;
> +
> +	phy_parameter = phy_data->parameter;
> +
> +	index = PHY_ADDR_MAP_ARRAY_INDEX(PHY_ADDR_0x09);
> +
> +	if (index < phy_data->size) {
> +		u8 addr = (phy_parameter + index)->addr;
> +		u16 data = (phy_parameter + index)->data;
> +
> +		if (addr == 0xFF) {
> +			addr = ARRAY_INDEX_MAP_PHY_ADDR(index);
> +			data = rtk_usb_phy_read(regAddr, addr);
> +			(phy_parameter + index)->addr = addr;
> +			(phy_parameter + index)->data = data;
> +		}
> +		mdelay(1);
> +		dev_info(rtk_phy->dev,
> +			    "%s ########## to toggle PHY addr 0x09 BIT(9)\n",
> +			    __func__);
> +		rtk_usb_phy_write(regAddr, addr, data&(~BIT(9)));
> +		mdelay(1);
> +		rtk_usb_phy_write(regAddr, addr, data);
> +	}
> +	dev_info(rtk_phy->dev, "%s ########## PHY addr 0x1f = 0x%04x\n",
> +		    __func__, rtk_usb_phy_read(regAddr, PHY_ADDR_0x1F));

Please drop all simple debug success messages. Linux has already
infrastructure for this.


...

> +	return 0;
> +}
> +
> +static int rtk_usb_phy_init(struct phy *phy)
> +{
> +	struct rtk_usb_phy *rtk_phy = phy_get_drvdata(phy);
> +	int ret = 0;
> +	int i;
> +	unsigned long phy_init_time = jiffies;
> +
> +	if (!rtk_phy) {
> +		pr_err("%s rtk_phy is NULL!\n", __func__);

What? How is this possible?

> +		return -ENODEV;
> +	}
> +
> +	dev_dbg(rtk_phy->dev, "Init RTK USB 3.0 PHY\n");
> +	for (i = 0; i < rtk_phy->phyN; i++)
> +		ret = do_rtk_usb_phy_init(rtk_phy, i);
> +
> +	dev_info(rtk_phy->dev, "Initialized RTK USB 3.0 PHY (take %dms)\n",
> +		    jiffies_to_msecs(jiffies - phy_init_time));

Please drop all simple debug success messages. Linux has already
infrastructure for this.

> +	return ret;
> +}
> +
> +static int rtk_usb_phy_exit(struct phy *phy)
> +{
> +	struct rtk_usb_phy *rtk_phy = phy_get_drvdata(phy);
> +
> +	if (!rtk_phy) {
> +		pr_err("%s rtk_phy is NULL!\n", __func__);
> +		return -ENODEV;
> +	}
> +
> +	dev_dbg(rtk_phy->dev, "Exit RTK USB 3.0 PHY\n");

Please drop all simple debug success messages. Linux has already
infrastructure for this.

> +static void rtk_usb_phy_toggle(struct usb_phy *usb3_phy, bool isConnect, int port)
> +{
> +	int index = port;
> +	struct rtk_usb_phy *rtk_phy = NULL;
> +
> +	if (usb3_phy != NULL && usb3_phy->dev != NULL)
> +		rtk_phy = dev_get_drvdata(usb3_phy->dev);
> +
> +	if (rtk_phy == NULL) {
> +		pr_err("%s ERROR! NO this device\n", __func__);

Your error messages are not helping. No need to shout, no need to handle
some non-existing cases. If this is real case, you have broken driver. I
actually suspect that.

How can you interface with a driver where there is no device?

> +		return;
> +	}
> +
> +	if (index > rtk_phy->phyN) {
> +		pr_err("%s %d ERROR! port=%d > phyN=%d\n",
> +			    __func__, __LINE__, index, rtk_phy->phyN);
> +		return;
> +	}
> +
> +	do_rtk_usb3_phy_toggle(rtk_phy, index, isConnect);
> +}
> +
> +static int rtk_usb_phy_notify_port_status(struct usb_phy *x, int port,
> +	    u16 portstatus, u16 portchange)
> +{
> +	bool isConnect = false;

This is not C++. Don't use camelcase. See Coding style document.

> +
> +	pr_debug("%s port=%d portstatus=0x%x portchange=0x%x\n",
> +		    __func__, port, (int)portstatus, (int)portchange);
> +	if (portstatus & USB_PORT_STAT_CONNECTION)
> +		isConnect = true;
> +

...

> +
> +static int rtk_usb3_set_parameter_show(struct seq_file *s, void *unused)
> +{
> +	struct rtk_usb_phy *rtk_phy = s->private;
> +	const struct file *file = s->file;
> +	const char *file_name = file_dentry(file)->d_iname;
> +	struct dentry *p_dentry = file_dentry(file)->d_parent;
> +	const char *phy_dir_name = p_dentry->d_iname;
> +	int ret, index;
> +	struct phy_data *phy_data = NULL;
> +
> +	for (index = 0; index < rtk_phy->phyN; index++) {
> +		size_t sz = 30;
> +		char name[30] = {0};
> +
> +		snprintf(name, sz, "phy%d", index);
> +		if (strncmp(name, phy_dir_name, strlen(name)) == 0) {
> +			phy_data = &((struct phy_data *)rtk_phy->phy_data)[index];
> +			break;
> +		}
> +	}
> +	if (!phy_data) {
> +		dev_err(rtk_phy->dev,
> +				    "%s: No phy_data for %s/%s\n",
> +				    __func__, phy_dir_name, file_name);

Mess wrapping/indentation. Actually everywhere in the file...

> +		return -EINVAL;
> +	}
> +
> +	ret = __get_parameter_at_page(s, rtk_phy, phy_data->parameter, file_name);
> +	if (ret < 0)
> +		return ret;
> +
> +	seq_puts(s, "Set phy parameter by following command\n");
> +	seq_printf(s, "echo \"value\" > %s/%s\n",
> +		    phy_dir_name, file_name);
> +
> +	return 0;
> +}
> +
> +static int rtk_usb3_set_parameter_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, rtk_usb3_set_parameter_show, inode->i_private);
> +}
> +
> +static ssize_t rtk_usb3_set_parameter_write(struct file *file,
> +		const char __user *ubuf, size_t count, loff_t *ppos)
> +{
> +	const char *file_name = file_dentry(file)->d_iname;
> +	struct dentry *p_dentry = file_dentry(file)->d_parent;
> +	const char *phy_dir_name = p_dentry->d_iname;
> +	struct seq_file		*s = file->private_data;
> +	struct rtk_usb_phy		*rtk_phy = s->private;
> +	struct reg_addr *regAddr = NULL;
> +	struct phy_data *phy_data = NULL;
> +	int ret = 0;
> +	char buffer[40] = {0};
> +	int index;
> +
> +	if (copy_from_user(&buffer, ubuf,
> +		    min_t(size_t, sizeof(buffer) - 1, count)))
> +		return -EFAULT;
> +
> +	for (index = 0; index < rtk_phy->phyN; index++) {
> +		size_t sz = 30;
> +		char name[30] = {0};
> +
> +		snprintf(name, sz, "phy%d", index);
> +		if (strncmp(name, phy_dir_name, strlen(name)) == 0) {
> +			regAddr = &((struct reg_addr *)rtk_phy->reg_addr)[index];
> +			phy_data = &((struct phy_data *)rtk_phy->phy_data)[index];
> +			break;


Where is the ABI documentation for user interface?


> +
> +static inline void create_debug_files(struct rtk_usb_phy *rtk_phy)
> +{
> +	struct dentry *phy_debug_root = NULL;
> +	struct dentry *set_parameter_dir = NULL;
> +
> +	phy_debug_root = create_phy_debug_root();
> +
> +	if (!phy_debug_root) {
> +		dev_err(rtk_phy->dev, "%s Error phy_debug_root is NULL",
> +			    __func__);
> +		return;
> +	}
> +	rtk_phy->debug_dir = debugfs_create_dir(dev_name(rtk_phy->dev),
> +		    phy_debug_root);
> +	if (!rtk_phy->debug_dir) {
> +		dev_err(rtk_phy->dev, "%s Error debug_dir is NULL", __func__);

Are you sure you run checkpatch on this? Error messages on debugfs are
almost always incorrect.

> +		return;
> +	}
> +
> +	if (!debugfs_create_file("parameter", 0444,
> +		    rtk_phy->debug_dir, rtk_phy,
> +		    &rtk_usb3_parameter_fops))
> +		goto file_error;
> +
> +	set_parameter_dir = debugfs_create_dir("set_parameter",
> +		    rtk_phy->debug_dir);
> +	if (set_parameter_dir) {
> +		int index, ret;
> +
> +		for (index = 0; index < rtk_phy->phyN; index++) {
> +			struct dentry *phy_dir;
> +			struct phy_data *phy_data;
> +			size_t sz = 30;
> +			char name[30] = {0};
> +
> +			snprintf(name, sz, "phy%d", index);
> +
> +			phy_data = &((struct phy_data *)rtk_phy->phy_data)[index];
> +
> +			phy_dir = debugfs_create_dir(name, set_parameter_dir);
> +			if (!phy_dir) {
> +				dev_err(rtk_phy->dev,
> +					    "%s Error create folder %s fail\n",
> +					    name, __func__);
> +				goto file_error;
> +			}
> +
> +			ret = create_debug_set_parameter_files(rtk_phy, phy_dir,
> +				    phy_data->size);
> +			if (ret < 0) {
> +				dev_err(rtk_phy->dev,
> +					    "%s Error create files fail\n",
> +					    __func__);
> +				goto file_error;
> +			}
> +		}
> +	}
> +
> +	if (!debugfs_create_file("toggle", 0644, rtk_phy->debug_dir, rtk_phy,
> +		    &rtk_usb3_toggle_fops))
> +		goto file_error;
> +
> +	return;
> +
> +file_error:
> +	debugfs_remove_recursive(rtk_phy->debug_dir);
> +}
> +
> +static inline void remove_debug_files(struct rtk_usb_phy *rtk_phy)
> +{
> +	debugfs_remove_recursive(rtk_phy->debug_dir);
> +}
> +#else
> +static inline void create_debug_files(struct rtk_usb_phy *rtk_phy) { }
> +static inline void remove_debug_files(struct rtk_usb_phy *rtk_phy) { }
> +#endif /* CONFIG_DEBUG_FS */
> +
> +static int __get_phy_parameter_by_efuse(struct rtk_usb_phy *rtk_phy,
> +	    struct phy_data *phy_data, int index)
> +{
> +	u8 value = 0;
> +	struct nvmem_cell *cell;
> +
> +	if (!phy_data->check_efuse)
> +		goto out;
> +
> +	cell = nvmem_cell_get(rtk_phy->dev, "usb_u3_tx_lfps_swing_trim");
> +	if (IS_ERR(cell)) {
> +		dev_warn(rtk_phy->dev,
> +			    "%s failed to get usb_u3_tx_lfps_swing_trim: %ld\n",
> +			    __func__, PTR_ERR(cell));
> +	} else {
> +		unsigned char *buf;
> +		size_t buf_size;
> +
> +		buf = nvmem_cell_read(cell, &buf_size);
> +
> +		value = buf[0] & USB_U3_TX_LFPS_SWING_TRIM_MASK;
> +
> +		dev_dbg(rtk_phy->dev,
> +			    "phy index=%d buf=0x%x buf_size=%d value=0x%x\n",
> +			    index, buf[0], (int)buf_size, value);
> +		kfree(buf);
> +		nvmem_cell_put(cell);
> +	}
> +
> +	if ((value > 0) && (value < 0x8))
> +		phy_data->efuse_usb_u3_tx_lfps_swing_trim = 0x8;
> +	else
> +		phy_data->efuse_usb_u3_tx_lfps_swing_trim = (u8)value;
> +
> +	dev_dbg(rtk_phy->dev, "Get Efuse usb_u3_tx_lfps_swing_trim=0x%x (value=0x%x)\n",
> +		    phy_data->efuse_usb_u3_tx_lfps_swing_trim, value);
> +
> +out:
> +	return 0;
> +}
> +
> +static int __get_phy_parameter(struct device *dev, struct phy_data *phy_data,
> +	    struct device_node *sub_node)
> +{
> +	struct phy_parameter *phy_parameter;
> +	int i, ret = 0;
> +	int data_size, num_cells = 2;
> +
> +	phy_data->size = MAX_USB_PHY_DATA_SIZE;
> +	phy_data->parameter = devm_kzalloc(dev,
> +		    sizeof(struct phy_parameter) * phy_data->size, GFP_KERNEL);
> +	if (!phy_data->parameter)
> +		return -ENOMEM;
> +
> +	if (!of_get_property(sub_node, "realtek,param", &data_size)) {
> +		dev_dbg(dev, "%s No parameter (data_size=%d)\n",
> +			    __func__, data_size);
> +		data_size = 0;
> +	}
> +
> +	if (!data_size)
> +		goto out;
> +
> +	phy_parameter = phy_data->parameter;
> +	/* Set default addr to 0xff for no data case */
> +	for (i = 0; i < phy_data->size; i++)
> +		(phy_parameter + i)->addr = 0xFF;
> +
> +	data_size = data_size / (sizeof(u32) * num_cells);
> +	for (i = 0; i < data_size; i++) {
> +		struct phy_parameter *parameter;
> +		u32 addr, data;
> +		int offset, index;
> +
> +		offset = i * num_cells;
> +
> +		ret = of_property_read_u32_index(sub_node, "realtek,param",
> +			    offset, &addr);
> +		if (ret) {
> +			dev_err(dev, "ERROR: To get param i=%d addr=0x%x\n",
> +				    i, addr);
> +			break;
> +		}
> +
> +		ret = of_property_read_u32_index(sub_node, "realtek,param",
> +			    offset + 1, &data);
> +		if (ret) {
> +			dev_err(dev, "ERROR: To get param i=%d addr=0x%x\n",
> +				    i, data);
> +			break;
> +		}
> +
> +		index = PHY_ADDR_MAP_ARRAY_INDEX(addr);
> +		parameter = (phy_parameter + index);
> +		parameter->addr = (u8)addr;
> +		parameter->data = (u16)data;
> +
> +		dev_dbg(dev, "param index=%d addr=0x%x data=0x%x\n", index,
> +			    parameter->addr, parameter->data);
> +	}
> +
> +out:
> +	return ret;
> +}
> +
> +static int get_phy_parameter(struct rtk_usb_phy *rtk_phy,
> +	    struct device_node *sub_node)
> +{
> +	struct device *dev = rtk_phy->dev;
> +	struct reg_addr *addr;
> +	struct phy_data *phy_data;
> +	int ret = 0;
> +	int index;
> +
> +	if (of_property_read_u32(sub_node, "reg", &index)) {
> +		dev_err(dev, "sub_node without reg\n");
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(dev, "sub_node index=%d\n", index);

Please drop all simple debug success messages. Linux has already
infrastructure for this.

...

> +
> +static int rtk_usb3phy_probe(struct platform_device *pdev)
> +{
> +	struct rtk_usb_phy *rtk_phy;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node;
> +	struct device_node *sub_node;
> +	struct phy *generic_phy;
> +	struct phy_provider *phy_provider;
> +	int ret, phyN;
> +
> +	rtk_phy = devm_kzalloc(dev, sizeof(*rtk_phy), GFP_KERNEL);
> +	if (!rtk_phy)
> +		return -ENOMEM;
> +
> +	rtk_phy->dev			= &pdev->dev;
> +	rtk_phy->phy.dev		= rtk_phy->dev;
> +	rtk_phy->phy.label		= "rtk-usb3phy";
> +	rtk_phy->phy.notify_port_status = rtk_usb_phy_notify_port_status;
> +
> +	if (!dev->of_node) {
> +		dev_err(dev, "%s %d No device node\n", __func__, __LINE__);

How is it even possible? If you do not have device node here, how did it
probe?

> +		ret = -ENODEV;
> +		goto err;
> +	}
> +
> +	node = dev->of_node;
> +
> +	phyN = of_get_child_count(node);
> +	rtk_phy->phyN = phyN;
> +	dev_dbg(dev, "%s phyN=%d\n", __func__, rtk_phy->phyN);

Please drop all simple debug success messages. Linux has already
infrastructure for this.

> +
> +	rtk_phy->reg_addr = devm_kzalloc(dev,
> +		    sizeof(struct reg_addr) * phyN, GFP_KERNEL);
> +	if (!rtk_phy->reg_addr)
> +		return -ENOMEM;
> +
> +	rtk_phy->phy_data = devm_kzalloc(dev,
> +		    sizeof(struct phy_data) * phyN, GFP_KERNEL);
> +	if (!rtk_phy->phy_data)
> +		return -ENOMEM;
> +
> +	for (sub_node = of_get_next_child(node, NULL); sub_node != NULL;
> +		    sub_node = of_get_next_child(node, sub_node)) {
> +		ret = get_phy_parameter(rtk_phy, sub_node);
> +		if (ret) {
> +			dev_err(dev, "%s: get_phy_parameter fail ret=%d\n",
> +				    __func__, ret);
> +			goto err;
> +		}
> +	}
> +
> +	platform_set_drvdata(pdev, rtk_phy);
> +
> +	generic_phy = devm_phy_create(rtk_phy->dev, NULL, &ops);
> +	if (IS_ERR(generic_phy))
> +		return PTR_ERR(generic_phy);
> +
> +	phy_set_drvdata(generic_phy, rtk_phy);
> +
> +	phy_provider = devm_of_phy_provider_register(rtk_phy->dev,
> +				    of_phy_simple_xlate);
> +	if (IS_ERR(phy_provider))
> +		return PTR_ERR(phy_provider);
> +
> +	ret = usb_add_phy_dev(&rtk_phy->phy);
> +	if (ret)
> +		goto err;
> +
> +	create_debug_files(rtk_phy);
> +
> +err:
> +	dev_dbg(&pdev->dev, "Probe RTK USB 3.0 PHY (ret=%d)\n", ret);

Please drop all simple debug success messages. Linux has already
infrastructure for this.

Best regards,
Krzysztof

