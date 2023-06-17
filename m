Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26D8733FAB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 10:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjFQIez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 04:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbjFQIes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 04:34:48 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11B2268C
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 01:34:45 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-518b69d5b5dso2231682a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 01:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686990884; x=1689582884;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R9tMBdjqIZVh5xMFV0QwJQYxN41PVS3z0786xtFUCio=;
        b=GGtByog3KOhthRNV5M1kEYEmvybZ9zAphjl6QGgYqy8lpqI7K7QYkgb9S+ZT3vqAyp
         7uaOMPXlJNNYIab++1oBjnX3yy+GJl2Ru6GFye7RmySdke0FhlRMqdg8s87Ozj1DL9LY
         4PLXvPnFsxuZSVdxxKgquwDtMAtBYG/Nwx5RyQhc4/utXStlSBLnWNgpX1fspq4jGrqD
         NLVaWW3goCLBtUkJBmqxd8T+nYzmk9A3xtgcnKNxZ93lKXxB58lv9J8W4z3J502sGl2F
         NJCPciI6KumrwuM6+skn3totzde91K5SZDAgnq6VsyF1uucU5kiphAWyvYvbxvDFvB8R
         Qs2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686990884; x=1689582884;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R9tMBdjqIZVh5xMFV0QwJQYxN41PVS3z0786xtFUCio=;
        b=MVLkKUuxkIEw+qHF4pfMTaW6F97bAu+6D0q2MI0nQvA6t1nhtWxIgSPIyw/PN8EAS4
         sfJG8sc7JRwG4wjxnTbOIeUQz+yT7ToQrq6QexcIBWPsHnOxbku1uHwg9Zj57bHPcgsk
         9L3swSV/EbqEZOfWz5oZ5IZ9tF31wmWDZoRvtw0I3zRcl3mmDfrWp3Uf3N6aZdOeeS6M
         GLQRHjIsyOYaf0qLXp65Pa1DOumqYcpksqDoxFK6cESqsOAY5iADF6qk7PqokWfSIb81
         aWZPYyjf7PrGUWc0iPHHoEwdxG6tstpf8GdzX0XwXq6D/RseTL6/zQizEPFpKZ35KEs5
         bKfg==
X-Gm-Message-State: AC+VfDzPR9UWKKWoaTcTMpTgs8rGr1s+6zgEl59MNw704AuorSXAt+a4
        657AVuOxJpm4Au3T7h6SY5QvFg==
X-Google-Smtp-Source: ACHHUZ6lHdUDCWGM0eh2EcCNQxr3tacLmwtplTIAXb+F+Lg24DHh7RoXOpuBtZ0tOMIZOZvjPkM/IA==
X-Received: by 2002:a17:907:708:b0:97b:956f:e6b5 with SMTP id xb8-20020a170907070800b0097b956fe6b5mr4041319ejb.23.1686990883845;
        Sat, 17 Jun 2023 01:34:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id e27-20020a170906249b00b0098654d3c270sm1587440ejb.52.2023.06.17.01.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jun 2023 01:34:43 -0700 (PDT)
Message-ID: <3cce7711-3e31-2f9b-8be7-36be6ee8a19c@linaro.org>
Date:   Sat, 17 Jun 2023 10:34:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 2/5] phy: realtek: usb: Add driver for the Realtek SoC
 USB 2.0 PHY
Content-Language: en-US
To:     Stanley Chang <stanley_chang@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Douglas Anderson <dianders@chromium.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ray Chi <raychi@google.com>, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20230614092850.21460-1-stanley_chang@realtek.com>
 <20230614092850.21460-2-stanley_chang@realtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230614092850.21460-2-stanley_chang@realtek.com>
Content-Type: text/plain; charset=UTF-8
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

On 14/06/2023 11:28, Stanley Chang wrote:
> Realtek DHC (digital home center) RTD SoCs support DWC3 XHCI USB
> controller. Added the driver to drive the USB 2.0 PHY transceivers.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
> v3 to v4 change:
>     1. Remove the parameter and non hardware properties from dts.
>        Add the compatible data included the config and parameter.
>     2. Fix the warning for checkpatch with strict.
>     3. Remove useless debug messages.
>     4. Fix the incorrect or useless "if() return" which pointer check.
>     5. Remove the phy power domain control due to we control on other
>        driver.
> v2 to v3 change:
>     1. Broken down into two patches, one for each of USB 2 & 3 PHY.
>     2. Removed parameter v1 support for simplification.
>     3. Use remove_new for driver remove callback.
> v1 to v2 change:
>     1. Move the drivers to drivers/phy/ for generic phy driver
>     2. Use the generic phy driver api to initialize phy
>     3. Use readl/writel to instead phy_read/phy_write directly.
>     4. Use read_poll_timeout() in function utmi_wait_register.
>     5. Revised some coding styles.
>     6. fix the compiler warning for kernel test robot.
> ---

...

> +/* updated disconnect level at page0 */
> +static void update_dc_disconnect_level_at_page0(struct rtk_phy *rtk_phy,
> +						struct phy_parameter *phy_parameter, bool update)
> +{
> +	struct phy_cfg *phy_cfg;
> +	struct phy_reg *phy_reg;
> +	struct phy_data *phy_data_page;
> +	struct phy_data *phy_data;
> +	u8 addr, data;
> +	int offset = 4;
> +	s32 dc_disconnect_mask;
> +	int i;
> +
> +	phy_cfg = rtk_phy->phy_cfg;
> +	phy_reg = &phy_parameter->phy_reg;
> +
> +	/* Set page 0 */
> +	phy_data_page = phy_cfg->page0;
> +	rtk_phy_set_page(phy_reg, 0);
> +
> +	i = page_addr_to_array_index(PAGE0_0XE4);
> +	phy_data = phy_data_page + i;
> +	if (!phy_data->addr) {
> +		phy_data->addr = PAGE0_0XE4;
> +		phy_data->data = rtk_phy_read(phy_reg, PAGE0_0XE4);
> +	}
> +
> +	addr = phy_data->addr;
> +	data = phy_data->data;
> +	dc_disconnect_mask = phy_cfg->dc_disconnect_mask;
> +
> +	if (update)
> +		data = __updated_dc_disconnect_level_page0_0xe4(phy_cfg, phy_parameter, data);
> +	else
> +		data = (data & ~(dc_disconnect_mask << offset)) |
> +			(DEFAULT_DC_DISCONNECTION_VALUE << offset);
> +
> +	if (rtk_phy_write(phy_reg, addr, data))
> +		dev_err(rtk_phy->dev,
> +			"[%s:%d] Error page1 addr=0x%x value=0x%x\n",
> +			__func__, __LINE__,
> +			addr, data);

Is addr a kernel address or any memory (not SFR) address? If so, you
cannot print it.

> +}
> +
> +static u8 __updated_dc_disconnect_level_page1_0xe2(struct phy_cfg *phy_cfg,
> +						   struct phy_parameter *phy_parameter, u8 data)
> +{
> +	u8 val;
> +	s32 __val;
> +	s32 dc_disconnect_mask = phy_cfg->dc_disconnect_mask;
> +
> +	if (phy_cfg->check_efuse_version == CHECK_EFUSE_V1) {
> +		__val = (s32)(data & dc_disconnect_mask)
> +			    + phy_parameter->efuse_usb_dc_dis
> +			    + phy_parameter->disconnection_compensate;
> +	} else { /* for CHECK_EFUSE_V2 or no efuse */
> +		if (phy_parameter->efuse_usb_dc_dis)
> +			__val = (s32)(phy_parameter->efuse_usb_dc_dis +
> +				    phy_parameter->disconnection_compensate);
> +		else
> +			__val = (s32)((data & dc_disconnect_mask) +
> +				    phy_parameter->disconnection_compensate);
> +	}
> +
> +	if (__val > dc_disconnect_mask)
> +		__val = dc_disconnect_mask;
> +	else if (__val < 0)
> +		__val = 0;
> +
> +	val = (data & (~dc_disconnect_mask)) | (__val & dc_disconnect_mask);
> +
> +	return val;
> +}
> +
> +/* updated disconnect level at page1 */
> +static void update_dc_disconnect_level_at_page1(struct rtk_phy *rtk_phy,
> +						struct phy_parameter *phy_parameter, bool update)
> +{
> +	struct phy_cfg *phy_cfg;
> +	struct phy_data *phy_data_page;
> +	struct phy_data *phy_data;
> +	struct phy_reg *phy_reg;
> +	u8 addr, data;
> +	s32 dc_disconnect_mask;
> +	int i;
> +
> +	phy_cfg = rtk_phy->phy_cfg;
> +	phy_reg = &phy_parameter->phy_reg;
> +
> +	/* Set page 1 */
> +	phy_data_page = phy_cfg->page1;
> +	rtk_phy_set_page(phy_reg, 1);
> +
> +	i = page_addr_to_array_index(PAGE1_0XE2);
> +	phy_data = phy_data_page + i;
> +	if (!phy_data->addr) {
> +		phy_data->addr = PAGE1_0XE2;
> +		phy_data->data = rtk_phy_read(phy_reg, PAGE1_0XE2);
> +	}
> +
> +	addr = phy_data->addr;
> +	data = phy_data->data;
> +	dc_disconnect_mask = phy_cfg->dc_disconnect_mask;
> +
> +	if (update)
> +		data = __updated_dc_disconnect_level_page1_0xe2(phy_cfg, phy_parameter, data);
> +	else
> +		data = (data & ~dc_disconnect_mask) | DEFAULT_DC_DISCONNECTION_VALUE;
> +
> +	if (rtk_phy_write(phy_reg, addr, data))
> +		dev_err(rtk_phy->dev,
> +			"[%s:%d] Error page1 addr=0x%x value=0x%x\n",
> +			__func__, __LINE__,
> +			addr, data);

Ditto and in all other places.

> +}
> +
> +static void update_dc_disconnect_level(struct rtk_phy *rtk_phy,
> +				       struct phy_parameter *phy_parameter, bool update)
> +{
> +	struct phy_cfg *phy_cfg = rtk_phy->phy_cfg;
> +
> +	if (phy_cfg->usb_dc_disconnect_at_page0)
> +		update_dc_disconnect_level_at_page0(rtk_phy, phy_parameter, update);
> +	else
> +		update_dc_disconnect_level_at_page1(rtk_phy, phy_parameter, update);
> +}
> +
> +static u8 __update_dc_driving_page0_0xe4(struct phy_cfg *phy_cfg,
> +					 struct phy_parameter *phy_parameter, u8 data)
> +{
> +	s32 driving_compensate = phy_parameter->driving_compensate;
> +	s32 dc_driving_mask = phy_cfg->dc_driving_mask;
> +	s32 __val;
> +	u8 val;

Two variables with the same name. No, it is not readable code.

...

> +static void update_dc_driving_level(struct rtk_phy *rtk_phy,
> +				    struct phy_parameter *phy_parameter)
> +{
> +	struct phy_cfg *phy_cfg;
> +	struct phy_reg *phy_reg;
> +

...
> +
> +static const struct phy_ops ops = {
> +	.init		= rtk_phy_init,
> +	.exit		= rtk_phy_exit,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static void rtk_phy_toggle(struct usb_phy *usb2_phy, bool connect, int port)
> +{
> +	int index = port;
> +	struct rtk_phy *rtk_phy = NULL;
> +
> +	rtk_phy = dev_get_drvdata(usb2_phy->dev);
> +
> +	if (index > rtk_phy->num_phy) {
> +		pr_err("%s %d ERROR! port=%d > num_phy=%d\n",

dev_err

> +		       __func__, __LINE__, index, rtk_phy->num_phy);

all these func and LINE point to poor code quality and poor debugging
practices. These are added dugin development, not for production code,
because error message should be obvious. Your usage of pr_err, func,
LINE and some unprecise messages suggests this is not ready.

Fix all your error messages to be meaningful.

> +		return
> +	}
> +
> +	do_rtk_phy_toggle(rtk_phy, index, connect);
> +}
> +
> +static int rtk_phy_notify_port_status(struct usb_phy *x, int port,
> +				      u16 portstatus, u16 portchange)
> +{
> +	bool connect = false;
> +
> +	pr_debug("%s port=%d portstatus=0x%x portchange=0x%x\n",
> +		 __func__, port, (int)portstatus, (int)portchange);
> +	if (portstatus & USB_PORT_STAT_CONNECTION)
> +		connect = true;
> +
> +	if (portchange & USB_PORT_STAT_C_CONNECTION)
> +		rtk_phy_toggle(x, connect, port);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_DEBUG_FS
> +static struct dentry *create_phy_debug_root(void)
> +{
> +	struct dentry *phy_debug_root;
> +
> +	phy_debug_root = debugfs_lookup("phy", usb_debug_root);
> +	if (!phy_debug_root)
> +		phy_debug_root = debugfs_create_dir("phy", usb_debug_root);
> +
> +	return phy_debug_root;
> +}
> +
> +static int rtk_usb2_parameter_show(struct seq_file *s, void *unused)
> +{
> +	struct rtk_phy *rtk_phy = s->private;
> +	struct phy_cfg *phy_cfg;
> +	int i, index;
> +
> +	phy_cfg = rtk_phy->phy_cfg;
> +
> +	seq_puts(s, "Property:\n");
> +	seq_printf(s, "  check_efuse: %s\n",
> +		   phy_cfg->check_efuse ? "Enable" : "Disable");
> +	seq_printf(s, "  check_efuse_version: %d\n",
> +		   phy_cfg->check_efuse_version);
> +	seq_printf(s, "  efuse_dc_driving_rate: %d\n",
> +		   phy_cfg->efuse_dc_driving_rate);
> +	seq_printf(s, "  dc_driving_mask: 0x%x\n",
> +		   phy_cfg->dc_driving_mask);
> +	seq_printf(s, "  efuse_dc_disconnect_rate: %d\n",
> +		   phy_cfg->efuse_dc_disconnect_rate);
> +	seq_printf(s, "  dc_disconnect_mask: 0x%x\n",
> +		   phy_cfg->dc_disconnect_mask);
> +	seq_printf(s, "  usb_dc_disconnect_at_page0: %s\n",
> +		   phy_cfg->usb_dc_disconnect_at_page0 ? "true" : "false");
> +	seq_printf(s, "  do_toggle: %s\n",
> +		   phy_cfg->do_toggle ? "Enable" : "Disable");
> +	seq_printf(s, "  do_toggle_driving: %s\n",
> +		   phy_cfg->do_toggle_driving ? "Enable" : "Disable");
> +	seq_printf(s, "  driving_updated_for_dev_dis: 0x%x\n",
> +		   phy_cfg->driving_updated_for_dev_dis);
> +	seq_printf(s, "  use_default_parameter: %s\n",
> +		   phy_cfg->use_default_parameter ? "Enable" : "Disable");
> +	seq_printf(s, "  is_double_sensitivity_mode: %s\n",
> +		   phy_cfg->is_double_sensitivity_mode ? "Enable" : "Disable");
> +
> +	for (index = 0; index < rtk_phy->num_phy; index++) {
> +		struct phy_parameter *phy_parameter;
> +		struct phy_reg *phy_reg;
> +		struct phy_data *phy_data_page;
> +
> +		phy_parameter =  &((struct phy_parameter *)rtk_phy->phy_parameter)[index];
> +		phy_reg = &phy_parameter->phy_reg;
> +
> +		seq_printf(s, "PHY %d:\n", index);
> +
> +		seq_puts(s, "Page 0:\n");
> +		/* Set page 0 */
> +		phy_data_page = phy_cfg->page0;
> +		rtk_phy_set_page(phy_reg, 0);
> +
> +		for (i = 0; i < phy_cfg->page0_size; i++) {
> +			struct phy_data *phy_data = phy_data_page + i;
> +			u8 addr = array_index_to_page_addr(i);
> +			u8 data = phy_data->data;
> +			u8 value = rtk_phy_read(phy_reg, addr);
> +
> +			if (phy_data->addr)
> +				seq_printf(s, "  Page 0: addr=0x%x data=0x%02x ==> read value=0x%02x\n",
> +					   addr, data, value);
> +			else
> +				seq_printf(s, "  Page 0: addr=0x%x data=none ==> read value=0x%02x\n",
> +					   addr, value);
> +		}
> +
> +		seq_puts(s, "Page 1:\n");
> +		/* Set page 1 */
> +		phy_data_page = phy_cfg->page1;
> +		rtk_phy_set_page(phy_reg, 1);
> +
> +		for (i = 0; i < phy_cfg->page1_size; i++) {
> +			struct phy_data *phy_data = phy_data_page + i;
> +			u8 addr = array_index_to_page_addr(i);
> +			u8 data = phy_data->data;
> +			u8 value = rtk_phy_read(phy_reg, addr);
> +
> +			if (phy_data->addr)
> +				seq_printf(s, "  Page 1: addr=0x%x data=0x%02x ==> read value=0x%02x\n",
> +					   addr, data, value);
> +			else
> +				seq_printf(s, "  Page 1: addr=0x%x data=none ==> read value=0x%02x\n",
> +					   addr, value);
> +		}
> +
> +		if (phy_cfg->page2_size == 0)
> +			goto out;
> +
> +		seq_puts(s, "Page 2:\n");
> +		/* Set page 2 */
> +		phy_data_page = phy_cfg->page2;
> +		rtk_phy_set_page(phy_reg, 2);
> +
> +		for (i = 0; i < phy_cfg->page2_size; i++) {
> +			struct phy_data *phy_data = phy_data_page + i;
> +			u8 addr = array_index_to_page_addr(i);
> +			u8 data = phy_data->data;
> +			u8 value = rtk_phy_read(phy_reg, addr);
> +
> +			if (phy_data->addr)
> +				seq_printf(s, "  Page 2: addr=0x%x data=0x%02x ==> read value=0x%02x\n",
> +					   addr, data, value);
> +			else
> +				seq_printf(s, "  Page 2: addr=0x%x data=none ==> read value=0x%02x\n",
> +					   addr, value);
> +		}
> +
> +out:
> +		seq_puts(s, "PHY Property:\n");
> +		seq_printf(s, "  efuse_usb_dc_cal: %d\n",
> +			   (int)phy_parameter->efuse_usb_dc_cal);
> +		seq_printf(s, "  efuse_usb_dc_dis: %d\n",
> +			   (int)phy_parameter->efuse_usb_dc_dis);
> +		seq_printf(s, "  inverse_hstx_sync_clock: %s\n",
> +			   phy_parameter->inverse_hstx_sync_clock ? "Enable" : "Disable");
> +		seq_printf(s, "  driving_level: %d\n",
> +			   phy_parameter->driving_level);
> +		seq_printf(s, "  driving_compensate: %d\n",
> +			   phy_parameter->driving_compensate);
> +		seq_printf(s, "  disconnection_compensate: %d\n",
> +			   phy_parameter->disconnection_compensate);
> +	}
> +
> +	return 0;
> +}
> +
> +static int rtk_usb2_parameter_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, rtk_usb2_parameter_show, inode->i_private);
> +}
> +
> +static const struct file_operations rtk_usb2_parameter_fops = {
> +	.open			= rtk_usb2_parameter_open,
> +	.read			= seq_read,
> +	.llseek			= seq_lseek,
> +	.release		= single_release,
> +};
> +
> +static int __get_parameter_at_page(struct seq_file *s,
> +				   struct rtk_phy *rtk_phy,
> +				   struct phy_data *phy_data_page,
> +				   const char *phy_page, const char *phy_addr)
> +{
> +	struct phy_data *phy_data;
> +	u32 addr;
> +	int i, ret;
> +
> +	ret = kstrtouint(phy_addr, 16, &addr);
> +	if (ret < 0) {
> +		pr_err("%s::kstrtouint() failed\n", __func__);
> +		return -EINVAL;
> +	}
> +	i = page_addr_to_array_index(addr);
> +	phy_data = (phy_data_page + i);
> +
> +	if (phy_data->addr)
> +		seq_printf(s, "Now Parameter %s addr 0x%02x = 0x%02x\n",
> +			   phy_page, phy_data->addr, phy_data->data);
> +	else
> +		seq_printf(s, "Now Parameter %s addr 0x%02x is default\n",
> +			   phy_page, addr);
> +
> +	return 0;
> +}
> +
> +static int __set_parameter_at_page(struct rtk_phy *rtk_phy,
> +				   struct phy_reg *phy_reg, struct phy_parameter *phy_parameter,
> +				   struct phy_data *phy_data_page,
> +				   const char *phy_page, const char *phy_addr,
> +				   const char *phy_value)
> +{
> +	struct phy_data *phy_data;
> +	u32 addr, value;
> +	int i, ret;
> +
> +	ret = kstrtouint(phy_addr, 16, &addr);
> +	if (ret < 0)
> +		return -EINVAL;
> +
> +	ret = kstrtouint(phy_value, 16, &value);
> +	if (ret < 0)
> +		return -EINVAL;
> +
> +	i = page_addr_to_array_index(addr);
> +	phy_data = (phy_data_page + i);
> +
> +	if (phy_data->addr) {
> +		phy_data->data = value;
> +	} else {
> +		phy_data->addr = addr;
> +		phy_data->data = value;
> +	}
> +
> +	if (rtk_phy_write(phy_reg, addr, value))
> +		dev_err(rtk_phy->dev,
> +			"[%s:%d] Error: addr=0x%02x value=0x%02x\n",
> +			__func__, __LINE__, addr, value);
> +
> +	return 0;
> +}
> +
> +static int rtk_usb2_set_parameter_show(struct seq_file *s, void *unused)
> +{
> +	const struct file *file = s->file;
> +	const char *file_name = file_dentry(file)->d_iname;
> +	struct dentry *p_dentry = file_dentry(file)->d_parent;
> +	const char *dir_name = p_dentry->d_iname;
> +	struct dentry *pp_dentry = p_dentry->d_parent;
> +	const char *phy_dir_name = pp_dentry->d_iname;
> +	struct rtk_phy *rtk_phy = s->private;
> +	struct phy_cfg *phy_cfg;
> +	struct phy_parameter *phy_parameter = NULL;
> +	int ret = 0;
> +	int index;
> +
> +	for (index = 0; index < rtk_phy->num_phy; index++) {
> +		size_t sz = 30;
> +		char name[30] = {0};
> +
> +		snprintf(name, sz, "phy%d", index);
> +		if (strncmp(name, phy_dir_name, strlen(name)) == 0) {
> +			phy_parameter = &((struct phy_parameter *)rtk_phy->phy_parameter)[index];
> +			break;
> +		}
> +	}
> +
> +	if (!phy_parameter)
> +		return -EINVAL;
> +
> +	phy_cfg = rtk_phy->phy_cfg;
> +
> +	if (strcmp("page0", dir_name) == 0)
> +		ret = __get_parameter_at_page(s, rtk_phy, phy_cfg->page0,
> +					      dir_name, file_name);
> +	else if (strcmp("page1", dir_name) == 0)
> +		ret = __get_parameter_at_page(s, rtk_phy, phy_cfg->page1,
> +					      dir_name, file_name);
> +	else if (strcmp("page2", dir_name) == 0)
> +		ret = __get_parameter_at_page(s, rtk_phy, phy_cfg->page2,
> +					      dir_name, file_name);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	seq_puts(s, "Set phy parameter by following command\n");
> +	seq_printf(s, "echo \"value\" > %s/%s/%s\n",
> +		   phy_dir_name, dir_name, file_name);
> +
> +	return 0;
> +}
> +
> +static int rtk_usb2_set_parameter_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, rtk_usb2_set_parameter_show, inode->i_private);
> +}
> +
> +static ssize_t rtk_usb2_set_parameter_write(struct file *file,
> +					    const char __user *ubuf, size_t count,
> +					    loff_t *ppos)
> +{
> +	const char *file_name = file_dentry(file)->d_iname;
> +	struct dentry *p_dentry = file_dentry(file)->d_parent;
> +	const char *dir_name = p_dentry->d_iname;
> +	struct dentry *pp_dentry = p_dentry->d_parent;
> +	const char *phy_dir_name = pp_dentry->d_iname;
> +	struct seq_file *s = file->private_data;
> +	struct rtk_phy *rtk_phy = s->private;
> +	struct phy_reg *phy_reg;
> +	struct phy_cfg *phy_cfg;
> +	struct phy_parameter *phy_parameter = NULL;
> +	int ret = 0;
> +	char buffer[40] = {0};
> +	int index;
> +
> +	if (copy_from_user(&buffer, ubuf,
> +			   min_t(size_t, sizeof(buffer) - 1, count)))
> +		return -EFAULT;
> +
> +	for (index = 0; index < rtk_phy->num_phy; index++) {
> +		size_t sz = 30;
> +		char name[30] = {0};
> +
> +		snprintf(name, sz, "phy%d", index);
> +		if (strncmp(name, phy_dir_name, strlen(name)) == 0) {
> +			phy_parameter = &((struct phy_parameter *)rtk_phy->phy_parameter)[index];
> +			break;
> +		}
> +	}
> +
> +	if (!phy_parameter)
> +		return -EINVAL;
> +
> +	phy_cfg = rtk_phy->phy_cfg;
> +	phy_reg = &phy_parameter->phy_reg;
> +
> +	if (strcmp("page0", dir_name) == 0) {
> +		rtk_phy_set_page(phy_reg, 0);
> +		ret = __set_parameter_at_page(rtk_phy, phy_reg, phy_parameter,
> +					      phy_cfg->page0, dir_name, file_name, buffer);
> +	} else if (strcmp("page1", dir_name) == 0) {
> +		rtk_phy_set_page(phy_reg, 1);
> +		ret = __set_parameter_at_page(rtk_phy, phy_reg, phy_parameter,
> +					      phy_cfg->page1, dir_name, file_name, buffer);
> +	} else if (strcmp("page2", dir_name) == 0) {
> +		rtk_phy_set_page(phy_reg, 2);
> +		ret = __set_parameter_at_page(rtk_phy, phy_reg, phy_parameter,
> +					      phy_cfg->page2, dir_name, file_name, buffer);
> +	}
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static const struct file_operations rtk_usb2_set_parameter_fops = {
> +	.open			= rtk_usb2_set_parameter_open,
> +	.write			= rtk_usb2_set_parameter_write,

NAK. You just created user interface via debugfs. You cannot. Reading
for some debug is okay, but configuring device via undocumented debugfs
is a source of troubles.

Drop all writes to debugfs.

...

> +
> +static int parse_phy_data(struct rtk_phy *rtk_phy)
> +{
> +	struct device *dev = rtk_phy->dev;
> +	struct device_node *node;

By convention:
s/node/np/

> +	struct phy_cfg *phy_cfg;
> +	struct phy_parameter *phy_parameter;
> +	int ret = 0;
> +	int index;
> +
> +	node = dev->of_node;

Keep it in variable definition.

> +	phy_cfg = rtk_phy->phy_cfg;
> +
> +	rtk_phy->phy_parameter = devm_kzalloc(dev, sizeof(struct phy_parameter) *
> +						rtk_phy->num_phy, GFP_KERNEL);
> +	if (!rtk_phy->phy_parameter)
> +		return -ENOMEM;
> +
> +	for (index = 0; index < rtk_phy->num_phy; index++) {
> +		phy_parameter = &((struct phy_parameter *)rtk_phy->phy_parameter)[index];
> +
> +		phy_parameter->phy_reg.reg_wrap_vstatus = of_iomap(dev->of_node, 0);
> +		phy_parameter->phy_reg.reg_gusb2phyacc0 = of_iomap(dev->of_node, 1) + index;
> +		phy_parameter->phy_reg.vstatus_index = index;
> +
> +		if (of_property_read_bool(node, "realtek,inverse-hstx-sync-clock"))
> +			phy_parameter->inverse_hstx_sync_clock = true;
> +		else
> +			phy_parameter->inverse_hstx_sync_clock = false;
> +
> +		if (of_property_read_u32_index(node, "realtek,driving-level",
> +					       index, &phy_parameter->driving_level))
> +			phy_parameter->driving_level = DEFAULT_DC_DRIVING_VALUE;
> +
> +		if (of_property_read_u32_index(node, "realtek,driving-compensate",
> +					       index, &phy_parameter->driving_compensate))
> +			phy_parameter->driving_compensate = 0;
> +
> +		if (of_property_read_u32_index(node, "realtek,disconnection-compensate",
> +					       index, &phy_parameter->disconnection_compensate))
> +			phy_parameter->disconnection_compensate = 0;
> +
> +		get_phy_data_by_efuse(rtk_phy, phy_parameter, index);
> +
> +		update_dc_driving_level(rtk_phy, phy_parameter);
> +
> +		update_hs_clk_select(rtk_phy, phy_parameter);
> +	}
> +
> +	return ret;
> +}
> +
> +static int rtk_usb2phy_probe(struct platform_device *pdev)
> +{
> +	struct rtk_phy *rtk_phy;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node;
> +	struct phy *generic_phy;
> +	struct phy_provider *phy_provider;
> +	const struct phy_cfg *phy_cfg;
> +	int ret = 0;
> +
> +	phy_cfg = of_device_get_match_data(dev);
> +	if (!phy_cfg) {
> +		dev_err(dev, "phy config are not assigned!\n");
> +		return -EINVAL;
> +	}
> +
> +	rtk_phy = devm_kzalloc(dev, sizeof(*rtk_phy), GFP_KERNEL);
> +	if (!rtk_phy)
> +		return -ENOMEM;
> +
> +	rtk_phy->dev			= &pdev->dev;
> +	rtk_phy->phy.dev		= rtk_phy->dev;
> +	rtk_phy->phy.label		= "rtk-usb2phy";
> +	rtk_phy->phy.notify_port_status = rtk_phy_notify_port_status;
> +
> +	rtk_phy->phy_cfg = devm_kzalloc(dev, sizeof(*phy_cfg), GFP_KERNEL);
> +
> +	memcpy(rtk_phy->phy_cfg, phy_cfg, sizeof(*phy_cfg));
> +
> +	node = dev->of_node;

Drop it. Useless assignment.

> +
> +	if (of_device_is_compatible(node, "realtek,rtd1395-usb2phy-2port"))

No, customize variant with driver_data. Don't embed compatibles in the code.


> +		rtk_phy->num_phy = 2;
> +	else
> +		rtk_phy->num_phy = 1;
> +
> +	ret = parse_phy_data(rtk_phy);
> +	if (ret)
> +		goto err;
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
> +						     of_phy_simple_xlate);
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
> +	dev_dbg(dev, "Probe RTK USB 2.0 PHY (ret=%d)\n", ret);

NAK. I made it pretty clear last time.


This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

> +
> +	return ret;
> +}
> +
> +static void rtk_usb2phy_remove(struct platform_device *pdev)
> +{
> +	struct rtk_phy *rtk_phy = platform_get_drvdata(pdev);
> +
> +	remove_debug_files(rtk_phy);
> +
> +	usb_remove_phy(&rtk_phy->phy);
> +}

...

> +
> +static const struct of_device_id usbphy_rtk_dt_match[] = {
> +	{ .compatible = "realtek,rtd1295-usb2phy", .data = &rtd1295_phy_cfg },
> +	{ .compatible = "realtek,rtd1312c-usb2phy", .data = &rtd1312c_phy_cfg },
> +	{ .compatible = "realtek,rtd1315e-usb2phy", .data = &rtd1315e_phy_cfg },
> +	{ .compatible = "realtek,rtd1319-usb2phy", .data = &rtd1319_phy_cfg },
> +	{ .compatible = "realtek,rtd1319d-usb2phy", .data = &rtd1319d_phy_cfg },
> +	{ .compatible = "realtek,rtd1395-usb2phy", .data = &rtd1395_phy_cfg },
> +	{ .compatible = "realtek,rtd1395-usb2phy-2port", .data = &rtd1395_phy_cfg },
> +	{ .compatible = "realtek,rtd1619-usb2phy", .data = &rtd1619_phy_cfg },
> +	{ .compatible = "realtek,rtd1619b-usb2phy", .data = &rtd1619b_phy_cfg },
> +	{ .compatible = "realtek,usb2phy", .data = &rtk_phy_cfg },

This is now even more suprising. Drop "realtek,usb2phy"

> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, usbphy_rtk_dt_match);
> +
> +static struct platform_driver rtk_usb2phy_driver = {
> +	.probe		= rtk_usb2phy_probe,
> +	.remove_new	= rtk_usb2phy_remove,
> +	.driver		= {
> +		.name	= "rtk-usb2phy",
> +		.owner	= THIS_MODULE,

??? Didn't you base your driver on some really, really ancient code
(like 5 years old)? If so, please don't.

Run coccicenelle/coccicheck, smatch and sparse, to avoid common mistakes.

Best regards,
Krzysztof

