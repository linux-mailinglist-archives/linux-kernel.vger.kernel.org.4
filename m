Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72AB700B2D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 17:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241754AbjELPQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 11:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241710AbjELPQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 11:16:49 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A400B118
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 08:16:45 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-956ff2399b1so1910090166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 08:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683904604; x=1686496604;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0elWr1R+Lbu4uSHjdUwbYiyi2pqRb78EwFgCeOvv/eU=;
        b=q8o2OnNGlWukcCZPXV9fpJu2HewudTOhzHs3SDhZNBQMgFwFze4y5K5JaUvx6PLtyg
         Md7hYa+5gNQXAor8EejIKi6DLTqTk2GzoGDEmYzo/kWtViQnJ/Y9r2K2PNM9ckTBiDMC
         Tr6N0/qB2KzicoY7CdFKW38P7hdVgjcT1nTZhcRZHOWu+WGY/Gc8n362O4MenoSUcDjc
         mELGsGrjHV1+ixr8zlfC0UqSbM8pULBmDFGpHo6EYjVmj46/nGiJ0nATFY//xU4+lB2I
         UX3AvSQzCddk7mFsq8k/8ReeebqkQ13Mt8Zr/0ePeeq38U7T52O6+28eZOFBg2hIAmv/
         Qp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683904604; x=1686496604;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0elWr1R+Lbu4uSHjdUwbYiyi2pqRb78EwFgCeOvv/eU=;
        b=dtj7hpgeMe7M59pv7sSZakaoqo0W3LK9g7nnbPo5UgTumUpR9H/BqY7UCvC7/5SCJm
         61i/tlasgZLTMq1Jwml/Ye72kh+ET0ZhfdvHFgKAb7UXc9lAYi/KEbyD9qe9MlVE5F+w
         NJszGr99mKY/SffkLpvFZOF3BntF5+EhD7627N7vK9NqJf20HSKzmHNOrZ71B4LlW9Vj
         6l/q94zfGpcrFiDr514M4Wq85yOMmMY0SZqzFp4LMEoPz2oY4AYUKklNBPznXR4Yod6D
         /vUNasgb8/swJ04XQMz/s4gy/QEnODTj0jDBkdvghxWTgtL3pyaTpSxGSEQoodUroyfn
         qygA==
X-Gm-Message-State: AC+VfDwa2TnsDp+KBj75BRzjMphvAvy3qb1vP7lko1GWkHd21M2lgvPW
        mcJt+Im9sHJJaiAHzfxdCrMD7g==
X-Google-Smtp-Source: ACHHUZ6aI9tAe1ZZKEegOnPxIwPK1Y3ZCqloj6+np6DH3w3rewdW2/Bc6XKHsrJrXywVYUvIOPWq5Q==
X-Received: by 2002:a17:907:1c9f:b0:969:bea8:e1c7 with SMTP id nb31-20020a1709071c9f00b00969bea8e1c7mr16446412ejc.37.1683904604048;
        Fri, 12 May 2023 08:16:44 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7ede:fc7b:2328:3883? ([2a02:810d:15c0:828:7ede:fc7b:2328:3883])
        by smtp.gmail.com with ESMTPSA id gx8-20020a1709068a4800b00965ab02b42csm5477239ejc.102.2023.05.12.08.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 08:16:43 -0700 (PDT)
Message-ID: <73438e58-bd96-818d-1f43-5681b0d1a1de@linaro.org>
Date:   Fri, 12 May 2023 17:16:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 06/10] mfd: cs42l43: Add support for cs42l43 core driver
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, broonie@kernel.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        tglx@linutronix.de, maz@kernel.org, linus.walleij@linaro.org,
        vkoul@kernel.org
Cc:     lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
        sanyog.r.kale@intel.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-7-ckeepax@opensource.cirrus.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230512122838.243002-7-ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 14:28, Charles Keepax wrote:
> The CS42L43 is an audio CODEC with integrated MIPI SoundWire interface
> (Version 1.2.1 compliant), I2C, SPI, and I2S/TDM interfaces designed
> for portable applications. It provides a high dynamic range, stereo
> DAC for headphone output, two integrated Class D amplifiers for
> loudspeakers, and two ADCs for wired headset microphone input or
> stereo line input. PDM inputs are provided for digital microphones.
> 
> The MFD component registers and initialises the device and provides
> PM/system power management.
> 

Thank you for your patch. There is something to discuss/improve.

> +static const char * const cs42l43_core_supplies[] = {
> +	"VDD_A", "VDD_IO", "VDD_CP",
> +};
> +
> +static const char * const cs42l43_parent_supplies[] = { "VDD_AMP" };
> +
> +static const struct mfd_cell cs42l43_devs[] = {
> +	{ .name = "cs42l43-pinctrl", },
> +	{ .name = "cs42l43-irq", },
> +	{ .name = "cs42l43-spi", },
> +	{
> +		.name = "cs42l43-codec",
> +		.parent_supplies = cs42l43_parent_supplies,
> +		.num_parent_supplies = ARRAY_SIZE(cs42l43_parent_supplies),
> +	},
> +};
> +
> +static int cs42l43_soft_reset(struct cs42l43 *cs42l43)
> +{
> +	static const struct reg_sequence reset[] = {
> +		{ CS42L43_SFT_RESET, 0x5A000000 },
> +	};
> +	unsigned long time;
> +
> +	dev_dbg(cs42l43->dev, "Soft resetting\n");

Drop simple debug statements for function entry/exit. There are other
tools in kernel to do such debugging.

> +
> +	reinit_completion(&cs42l43->device_detach);
> +
> +	/* apply cache only as the device will also fall off the soundwire bus */
> +	regcache_cache_only(cs42l43->regmap, true);
> +	regmap_multi_reg_write_bypassed(cs42l43->regmap, reset, ARRAY_SIZE(reset));
> +
> +	msleep(20);
> +
> +	if (cs42l43->sdw) {
> +		time = wait_for_completion_timeout(&cs42l43->device_detach,
> +						   msecs_to_jiffies(100));
> +		if (!time) {
> +			dev_err(cs42l43->dev, "Timed out waiting for device detach\n");
> +			return -ETIMEDOUT;
> +		}
> +	}
> +
> +	return -EAGAIN;
> +}
> +
> +static int cs42l43_wait_for_attach(struct cs42l43 *cs42l43)
> +{
> +	unsigned long time;
> +
> +	if (!cs42l43->attached) {
> +		time = wait_for_completion_timeout(&cs42l43->device_attach,
> +						   msecs_to_jiffies(500));
> +		if (!time) {
> +			dev_err(cs42l43->dev, "Timed out waiting for device re-attach\n");
> +			return -ETIMEDOUT;
> +		}
> +	}
> +
> +	regcache_cache_only(cs42l43->regmap, false);
> +
> +	// Must enable OSC_DIV before doing any SoundWire reads
> +	if (cs42l43->sdw)
> +		regmap_write(cs42l43->regmap, CS42L43_OSC_DIV_SEL, 0x1);
> +
> +	return 0;
> +}
> +
> +static int cs42l43_mcu_stage_2_3(struct cs42l43 *cs42l43, bool shadow)
> +{
> +	unsigned int need_reg = CS42L43_NEED_CONFIGS;
> +	unsigned int val;
> +	int ret;
> +
> +	dev_dbg(cs42l43->dev, "Moving firmware to stage 3\n");

Drop simple debug statements for function entry/exit. There are other
tools in kernel to do such debugging.

> +
> +	if (shadow)
> +		need_reg = CS42L43_FW_SH_BOOT_CFG_NEED_CONFIGS;
> +
> +	regmap_write(cs42l43->regmap, need_reg, 0x0);
> +
> +	ret = regmap_read_poll_timeout(cs42l43->regmap, CS42L43_BOOT_STATUS,
> +				       val, (val == 3), 5000, 20000);
> +	if (ret) {
> +		dev_err(cs42l43->dev, "Failed to move to stage 3: %d, 0x%x\n", ret, val);
> +		return ret;
> +	}
> +
> +	return -EAGAIN;
> +}
> +
> +static int cs42l43_mcu_stage_3_2(struct cs42l43 *cs42l43)
> +{
> +	dev_dbg(cs42l43->dev, "Returning firmware to stage 2\n");
> +
> +	regmap_write(cs42l43->regmap, CS42L43_FW_CTRL_NEED_CONFIGS,
> +		     CS42L43_FW_PATCH_NEED_CFG_MASK);
> +	regmap_write(cs42l43->regmap, CS42L43_FW_CTRL_HAVE_CONFIGS, 0x0);
> +
> +	return cs42l43_soft_reset(cs42l43);
> +}
> +
> +static int cs42l43_mcu_disable(struct cs42l43 *cs42l43)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	dev_dbg(cs42l43->dev, "Disabling firmware\n");

Drop simple debug statements for function entry/exit. There are other
tools in kernel to do such debugging.

> +
> +	regmap_write(cs42l43->regmap, CS42L43_FW_CTRL_MM_MCU_CFG_REG, 0xF05AA50F);
> +	regmap_write(cs42l43->regmap, CS42L43_FW_CTRL_MM_CTRL_SELECTION, 0x1);
> +	regmap_write(cs42l43->regmap, CS42L43_MCU_SW_INTERRUPT, CS42L43_CONTROL_IND_MASK);
> +	regmap_write(cs42l43->regmap, CS42L43_MCU_SW_INTERRUPT, 0);
> +
> +	ret = regmap_read_poll_timeout(cs42l43->regmap, CS42L43_SOFT_INT_SHADOW, val,
> +				       (val & CS42L43_CONTROL_APPLIED_INT_MASK),
> +				       5000, 20000);
> +	if (ret) {
> +		dev_err(cs42l43->dev, "Failed to disable firmware: %d, 0x%x\n", ret, val);
> +		return ret;
> +	}
> +
> +	/* Soft reset to clear any register state the firmware left behind */
> +	return cs42l43_soft_reset(cs42l43);
> +}
> +
> +struct cs42l43_patch_header {
> +	__le16 version;
> +	__le16 size;
> +	u8 reserved;
> +	u8 secure;
> +	__le16 bss_size;
> +	__le32 apply_addr;
> +	__le32 checksum;
> +	__le32 sha;
> +	__le16 swrev;
> +	__le16 patchid;
> +	__le16 ipxid;
> +	__le16 romver;
> +	__le32 load_addr;
> +} __packed;

Put all structs together at the top.

> +
> +static void cs42l43_mcu_load_firmware(const struct firmware *firmware, void *context)
> +{
> +	struct cs42l43 *cs42l43 = context;
> +	struct cs42l43_patch_header *hdr;
> +	unsigned int loadaddr, val;
> +	int ret;
> +
> +	if (!firmware) {
> +		dev_err(cs42l43->dev, "Failed to load firmware\n");
> +		cs42l43->firmware_error = -ENODEV;
> +		goto err;
> +	}
> +
> +	dev_dbg(cs42l43->dev, "Updating firmware\n");

Drop simple debug statements for function entry/exit. There are other
tools in kernel to do such debugging.

> +
> +	hdr = (void *)&firmware->data[0];

Aren't you dropping here const? Why? That's not recommended programming.


> +	loadaddr = le32_to_cpu(hdr->load_addr);
> +
> +	if (le16_to_cpu(hdr->version) != 0x3) {
> +		dev_err(cs42l43->dev, "Bad firmware file format: %d\n", hdr->version);
> +		cs42l43->firmware_error = -EINVAL;
> +		goto err_release;
> +	}
> +
> +	regmap_write(cs42l43->regmap, CS42L43_PATCH_START_ADDR, loadaddr);
> +	regmap_bulk_write(cs42l43->regmap, loadaddr + 0x100000,
> +			  &firmware->data[0], firmware->size / sizeof(u32));
> +
> +	regmap_write(cs42l43->regmap, CS42L43_MCU_SW_INTERRUPT, CS42L43_PATCH_IND_MASK);
> +	regmap_write(cs42l43->regmap, CS42L43_MCU_SW_INTERRUPT, 0);
> +
> +	ret = regmap_read_poll_timeout(cs42l43->regmap, CS42L43_SOFT_INT_SHADOW, val,
> +				       (val & CS42L43_PATCH_APPLIED_INT_MASK),
> +				       5000, 500000);
> +	if (ret) {
> +		dev_err(cs42l43->dev, "Failed to update firmware: %d, 0x%x\n", ret, val);
> +		cs42l43->firmware_error = ret;
> +		goto err_release;
> +	}
> +
> +err_release:
> +	release_firmware(firmware);
> +err:
> +	complete(&cs42l43->firmware_download);
> +}
> +
> +static int cs42l43_mcu_update_step(struct cs42l43 *cs42l43)
> +{
> +	unsigned int mcu_rev, bios_rev, boot_status, secure_cfg;
> +	bool patched, shadow;
> +	int ret;
> +
> +	// Clear any stale software interrupt bits
> +	regmap_read(cs42l43->regmap, CS42L43_SOFT_INT, &mcu_rev);
> +
> +	ret = regmap_read(cs42l43->regmap, CS42L43_BOOT_STATUS, &boot_status);
> +	if (ret) {
> +		dev_err(cs42l43->dev, "Failed to read boot status: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_read(cs42l43->regmap, CS42L43_MCU_SW_REV, &mcu_rev);
> +	if (ret) {
> +		dev_err(cs42l43->dev, "Failed to read firmware revision: %d\n", ret);
> +		return ret;
> +	}
> +
> +	bios_rev = ((mcu_rev & CS42L43_BIOS_MAJOR_REV_MASK) << 12) |
> +		   ((mcu_rev & CS42L43_BIOS_MINOR_REV_MASK) << 4) |
> +		   ((mcu_rev & CS42L43_BIOS_SUBMINOR_REV_MASK) >> 8);
> +	mcu_rev = ((mcu_rev & CS42L43_FW_MAJOR_REV_MASK) << 12) |
> +		  ((mcu_rev & CS42L43_FW_MINOR_REV_MASK) << 4) |
> +		  ((mcu_rev & CS42L43_FW_SUBMINOR_REV_MASK) >> 8);
> +
> +	patched = mcu_rev >= 0x2105 || bios_rev > 0x0000;
> +	shadow = mcu_rev >= 0x2200;
> +
> +	ret = regmap_read(cs42l43->regmap, CS42L43_BOOT_CONTROL, &secure_cfg);
> +	if (ret) {
> +		dev_err(cs42l43->dev, "Failed to read security settings: %d\n", ret);
> +		return ret;
> +	}
> +
> +	cs42l43->hw_lock = secure_cfg & CS42L43_LOCK_HW_STS_MASK;
> +
> +	if (!patched && cs42l43->hw_lock) {
> +		dev_err(cs42l43->dev, "Unpatched secure device\n");
> +		return -EPERM;
> +	}
> +
> +	dev_dbg(cs42l43->dev, "Firmware(0x%x) in boot stage %d\n", mcu_rev, boot_status);
> +
> +	switch (boot_status) {
> +	case 2:
> +		if (!patched) {
> +			ret = request_firmware_nowait(THIS_MODULE, FW_ACTION_UEVENT,
> +						      "cs42l43.bin", cs42l43->dev,
> +						      GFP_KERNEL, cs42l43,
> +						      cs42l43_mcu_load_firmware);
> +			if (ret) {
> +				dev_err(cs42l43->dev, "Failed to request firmware: %d\n", ret);
> +				return ret;
> +			}
> +
> +			wait_for_completion(&cs42l43->firmware_download);
> +
> +			if (cs42l43->firmware_error)
> +				return cs42l43->firmware_error;
> +
> +			return -EAGAIN;
> +		} else {
> +			return cs42l43_mcu_stage_2_3(cs42l43, shadow);
> +		}
> +	case 3:
> +		if (patched)
> +			return cs42l43_mcu_disable(cs42l43);
> +		else
> +			return cs42l43_mcu_stage_3_2(cs42l43);
> +	case 4:
> +		return 0;
> +	default:
> +		dev_err(cs42l43->dev, "Invalid boot status: %d\n", boot_status);
> +		return -EINVAL;
> +	}
> +}
> +
> +static int cs42l43_mcu_update(struct cs42l43 *cs42l43)
> +{
> +	const int update_retries = 5;
> +	int i, ret;
> +
> +	for (i = 0; i < update_retries; i++) {
> +		ret = cs42l43_mcu_update_step(cs42l43);
> +		if (ret != -EAGAIN)
> +			return ret;
> +
> +		ret = cs42l43_wait_for_attach(cs42l43);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	dev_err(cs42l43->dev, "Failed retrying update\n");
> +	return -ETIMEDOUT;
> +}
> +
> +static void cs42l43_boot_work(struct work_struct *work)
> +{
> +	struct cs42l43 *cs42l43 = container_of(work, struct cs42l43, boot_work);
> +	unsigned int devid, revid, otp;
> +	int ret;
> +
> +	dev_dbg(cs42l43->dev, "Boot work running\n");

Drop simple debug statements for function entry/exit. There are other
tools in kernel to do such debugging.

> +
> +	ret = cs42l43_wait_for_attach(cs42l43);
> +	if (ret)
> +		goto err;
> +
> +	if (cs42l43->sdw)
> +		cs42l43->irq = cs42l43->sdw->irq;
> +
> +	ret = regmap_read(cs42l43->regmap, CS42L43_DEVID, &devid);
> +	if (ret) {
> +		dev_err(cs42l43->dev, "Failed to read devid: %d\n", ret);
> +		goto err;
> +	}
> +
> +	switch (devid) {
> +	case 0x42a43:
> +		break;
> +	default:
> +		dev_err(cs42l43->dev, "Unrecognised devid: 0x%06x\n", devid);
> +		goto err;
> +	}
> +
> +	ret = regmap_read(cs42l43->regmap, CS42L43_REVID, &revid);
> +	if (ret) {
> +		dev_err(cs42l43->dev, "Failed to read rev: %d\n", ret);
> +		goto err;
> +	}
> +
> +	ret = regmap_read(cs42l43->regmap, CS42L43_OTP_REVISION_ID, &otp);
> +	if (ret) {
> +		dev_err(cs42l43->dev, "Failed to read otp rev: %d\n", ret);
> +		goto err;
> +	}
> +
> +	dev_info(cs42l43->dev,
> +		 "devid: 0x%06x, rev: 0x%02x, otp: 0x%02x\n", devid, revid, otp);
> +
> +	ret = cs42l43_mcu_update(cs42l43);
> +	if (ret)
> +		goto err;
> +
> +	ret = regmap_register_patch(cs42l43->regmap, cs42l43_reva_patch,
> +				    ARRAY_SIZE(cs42l43_reva_patch));
> +	if (ret) {
> +		dev_err(cs42l43->dev, "Failed to apply register patch: %d\n", ret);
> +		goto err;
> +	}
> +
> +	pm_runtime_mark_last_busy(cs42l43->dev);
> +	pm_runtime_put_autosuspend(cs42l43->dev);
> +
> +	ret = devm_mfd_add_devices(cs42l43->dev, PLATFORM_DEVID_NONE,
> +				   cs42l43_devs, ARRAY_SIZE(cs42l43_devs),

I don't why adding devices is not in probe. They use the same regmap
right? So there will be no problem in probing them from MFD probe.

> +				   NULL, 0, NULL);
> +	if (ret) {
> +		dev_err(cs42l43->dev, "Failed to add subdevices: %d\n", ret);
> +		goto err;
> +	}
> +
> +	dev_dbg(cs42l43->dev, "Successfully initialised\n");

Drop simple debug statements for function entry/exit. There are other
tools in kernel to do such debugging.

> +
> +	return;
> +
> +err:
> +	pm_runtime_put_sync(cs42l43->dev);
> +	cs42l43_dev_remove(cs42l43);
> +}
> +
> +static int cs42l43_power_up(struct cs42l43 *cs42l43)
> +{
> +	int ret;
> +
> +	ret = regulator_enable(cs42l43->vdd_p);
> +	if (ret) {
> +		dev_err(cs42l43->dev, "Failed to enable VDD_P: %d\n", ret);
> +		return ret;
> +	}
> +
> +	usleep_range(50, 100); /* VDD_P must be on for 50uS before any other supply */
> +
> +	gpiod_set_value_cansleep(cs42l43->reset, 1);
> +
> +	ret = regulator_bulk_enable(CS42L43_N_SUPPLIES, cs42l43->core_supplies);
> +	if (ret) {
> +		dev_err(cs42l43->dev, "Failed to enable core supplies: %d\n", ret);
> +		goto err_reset;
> +	}
> +
> +	ret = regulator_enable(cs42l43->vdd_d);
> +	if (ret) {
> +		dev_err(cs42l43->dev, "Failed to enable VDD_D: %d\n", ret);
> +		goto err_core_supplies;
> +	}
> +
> +	usleep_range(1000, 2000);
> +
> +	dev_dbg(cs42l43->dev, "Powered up\n");
> +
> +	return 0;
> +
> +err_core_supplies:
> +	regulator_bulk_disable(CS42L43_N_SUPPLIES, cs42l43->core_supplies);
> +err_reset:
> +	gpiod_set_value_cansleep(cs42l43->reset, 0);
> +	regulator_disable(cs42l43->vdd_p);
> +
> +	return ret;
> +}
> +
> +static int cs42l43_power_down(struct cs42l43 *cs42l43)
> +{
> +	int ret;
> +
> +	ret = regulator_disable(cs42l43->vdd_d);
> +	if (ret) {
> +		dev_err(cs42l43->dev, "Failed to disable VDD_D: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regulator_bulk_disable(CS42L43_N_SUPPLIES, cs42l43->core_supplies);
> +	if (ret) {
> +		dev_err(cs42l43->dev, "Failed to disable core supplies: %d\n", ret);
> +		return ret;
> +	}
> +
> +	gpiod_set_value_cansleep(cs42l43->reset, 0);
> +
> +	ret = regulator_disable(cs42l43->vdd_p);
> +	if (ret) {
> +		dev_err(cs42l43->dev, "Failed to disable VDD_P: %d\n", ret);
> +		return ret;
> +	}
> +
> +	dev_dbg(cs42l43->dev, "Powered down\n");

Drop simple debug statements for function entry/exit. There are other
tools in kernel to do such debugging.

> +
> +	return 0;
> +}
> +
> +int cs42l43_dev_probe(struct cs42l43 *cs42l43)
> +{
> +	int i, ret;
> +
> +	dev_set_drvdata(cs42l43->dev, cs42l43);
> +
> +	mutex_init(&cs42l43->pll_lock);
> +	init_completion(&cs42l43->device_attach);
> +	init_completion(&cs42l43->device_detach);
> +	init_completion(&cs42l43->firmware_download);
> +	INIT_WORK(&cs42l43->boot_work, cs42l43_boot_work);
> +
> +	regcache_cache_only(cs42l43->regmap, true);
> +
> +	cs42l43->reset = devm_gpiod_get_optional(cs42l43->dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(cs42l43->reset)) {
> +		ret = PTR_ERR(cs42l43->reset);
> +		dev_err(cs42l43->dev, "Failed to get reset: %d\n", ret);

return dev_err_probe

In other places as well

> +		return ret;
> +	}
> +
> +	cs42l43->vdd_p = devm_regulator_get(cs42l43->dev, "VDD_P");

Why these are not part of bulk get?

> +	if (IS_ERR(cs42l43->vdd_p)) {
> +		ret = PTR_ERR(cs42l43->vdd_p);
> +		dev_err(cs42l43->dev, "Failed to get VDD_P: %d\n", ret);
> +		return ret;
> +	}
> +
> +	cs42l43->vdd_d = devm_regulator_get(cs42l43->dev, "VDD_D");
> +	if (IS_ERR(cs42l43->vdd_d)) {
> +		ret = PTR_ERR(cs42l43->vdd_d);
> +		dev_err(cs42l43->dev, "Failed to get VDD_D: %d\n", ret);
> +		return ret;
> +	}
> +
> +	BUILD_BUG_ON(ARRAY_SIZE(cs42l43_core_supplies) != CS42L43_N_SUPPLIES);
> +
> +	for (i = 0; i < CS42L43_N_SUPPLIES; i++)
> +		cs42l43->core_supplies[i].supply = cs42l43_core_supplies[i];
> +
> +	ret = devm_regulator_bulk_get(cs42l43->dev, CS42L43_N_SUPPLIES,
> +				      cs42l43->core_supplies);
> +	if (ret) {
> +		dev_err(cs42l43->dev, "Failed to get core supplies: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = cs42l43_power_up(cs42l43);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_set_autosuspend_delay(cs42l43->dev, 250);
> +	pm_runtime_use_autosuspend(cs42l43->dev);
> +	pm_runtime_set_active(cs42l43->dev);
> +	pm_runtime_get_noresume(cs42l43->dev);
> +	pm_runtime_enable(cs42l43->dev);
> +
> +	queue_work(system_long_wq, &cs42l43->boot_work);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cs42l43_dev_probe, MFD_CS42L43);
> +
> +void cs42l43_dev_remove(struct cs42l43 *cs42l43)
> +{
> +	pm_runtime_disable(cs42l43->dev);
> +	cs42l43_power_down(cs42l43);
> +}
> +EXPORT_SYMBOL_NS_GPL(cs42l43_dev_remove, MFD_CS42L43);
> +
> +static int __maybe_unused cs42l43_suspend(struct device *dev)
> +{
> +	struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
> +	int ret;
> +
> +	dev_dbg(cs42l43->dev, "System suspend\n");

Drop simple debug statements. There are other tools in kernel to do such
debugging.

> +
> +	/*
> +	 * Don't care about being resumed here, but we do want force_resume to
> +	 * always trigger an actual resume, so that register state for the
> +	 * MCU/GPIOs is returned as soon as possible after system resume
> +	 */
> +	pm_runtime_get_noresume(dev);
> +
> +	ret = pm_runtime_force_suspend(dev);
> +	if (ret) {
> +		dev_err(cs42l43->dev, "Failed to force suspend: %d\n", ret);
> +		return ret;
> +	}
> +
> +	pm_runtime_put_noidle(dev);
> +
> +	ret = cs42l43_power_down(cs42l43);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused cs42l43_resume(struct device *dev)
> +{
> +	struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
> +	int ret;
> +
> +	dev_dbg(cs42l43->dev, "System resume\n");

Ditto

> +
> +	ret = cs42l43_power_up(cs42l43);
> +	if (ret)
> +		return ret;
> +
> +	ret = pm_runtime_force_resume(dev);
> +	if (ret) {
> +		dev_err(cs42l43->dev, "Failed to force resume: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused cs42l43_runtime_suspend(struct device *dev)
> +{
> +	struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
> +
> +	dev_dbg(cs42l43->dev, "Runtime suspend\n");

Ditto

> +
> +	/*
> +	 * Whilst we don't power the chip down here, going into runtime
> +	 * suspend lets the SoundWire bus power down, which means we can't
> +	 * communicate with the device any more.
> +	 */
> +	regcache_cache_only(cs42l43->regmap, true);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused cs42l43_runtime_resume(struct device *dev)
> +{
> +	struct cs42l43 *cs42l43 = dev_get_drvdata(dev);
> +	unsigned int reset_canary;
> +	int ret;
> +
> +	dev_dbg(cs42l43->dev, "Runtime resume\n");
> +

Ditto


Best regards,
Krzysztof

