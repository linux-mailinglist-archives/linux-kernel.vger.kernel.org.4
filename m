Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1A26660A5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjAKQg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbjAKQgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:36:00 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2A1CD6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 08:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673454956; x=1704990956;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=72PaTYesMW80vMily3JGRP1WXS2H9ylBNLWcZ9UwqQA=;
  b=gfwOMEOKr9YOXT+LRQ4aZVp0CDbcz7ihaLD//WN/fhijCkxCP7bC2f6f
   iJugc6G3Ii0qSGhtl9TOUFJCyB+twWBYwAynJpzVXrpP1dRIt3tuTe9VB
   m3GQ/Q5LWi9DaSJuU4c4iUs+mWIk16RoRRUIrQVpoo1oMmZ/UZ+Wp4qcE
   tSUAZRaj0HjpKGpPp/+xpU8xdcNaWPKcmDDTwwXMYH76/llF/SqdzuQQR
   xcoeLvYigHQ6s0YC+u1dbmFf2+o6UHlCtRsLvYazpSK9xgtnghoI8boI2
   l8fShfH9TJ75Ol5YfP4aqDyRjgjP0KBXeS292aNc7mJ29ReBc4FHptBEo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="324704008"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="324704008"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 08:32:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607408284"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="607408284"
Received: from flobatol-mobl1.amr.corp.intel.com (HELO [10.212.110.208]) ([10.212.110.208])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 08:32:08 -0800
Message-ID: <991ff630-17a7-eef3-1436-e4a905fe0541@linux.intel.com>
Date:   Wed, 11 Jan 2023 08:37:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 02/19] soundwire: amd: Add support for AMD Master driver
Content-Language: en-US
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Cc:     Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Mario.Limonciello@amd.com, Mastan.Katragadda@amd.com,
        arungopal.kondaveeti@amd.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-3-Vijendar.Mukunda@amd.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230111090222.2016499-3-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/23 03:02, Vijendar Mukunda wrote:
> AMD ACP IP block has two soundwire controller devices.

s/controller/manager?

> Add support for
> - Master driver probe & remove sequence
> - Helper functions to enable/disable interrupts, Initialize sdw controller,
>   enable sdw pads
> - Master driver sdw_master_ops & port_ops callbacks
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> ---
>  drivers/soundwire/amd_master.c    | 1075 +++++++++++++++++++++++++++++
>  drivers/soundwire/amd_master.h    |  279 ++++++++
>  include/linux/soundwire/sdw_amd.h |   21 +
>  3 files changed, 1375 insertions(+)
>  create mode 100644 drivers/soundwire/amd_master.c
>  create mode 100644 drivers/soundwire/amd_master.h
> 
> diff --git a/drivers/soundwire/amd_master.c b/drivers/soundwire/amd_master.c
> new file mode 100644
> index 000000000000..7e1f618254ac
> --- /dev/null
> +++ b/drivers/soundwire/amd_master.c
> @@ -0,0 +1,1075 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * SoundWire AMD Master driver
> + *
> + * Copyright 2023 Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/soundwire/sdw.h>
> +#include <linux/soundwire/sdw_registers.h>
> +#include <linux/soundwire/sdw_amd.h>
> +#include <linux/wait.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc.h>
> +#include "bus.h"
> +#include "amd_master.h"
> +
> +#define DRV_NAME "amd_sdw_controller"
> +
> +#define to_amd_sdw(b)	container_of(b, struct amd_sdwc_ctrl, bus)
> +
> +static int amd_enable_sdw_pads(struct amd_sdwc_ctrl *ctrl)
> +{
> +	u32 sw_pad_enable_mask;
> +	u32 sw_pad_pulldown_mask;
> +	u32 sw_pad_pulldown_val;
> +	u32 val = 0;
> +
> +	switch (ctrl->instance) {

Goodness no. A controller has one or more masters. It cannot have pins
as described in the SoundWire master specification.

> +	case ACP_SDW0:
> +		sw_pad_enable_mask = AMD_SDW0_PAD_KEEPER_EN_MASK;
> +		sw_pad_pulldown_mask = AMD_SDW0_PAD_PULLDOWN_CTRL_ENABLE_MASK;
> +		break;
> +	case ACP_SDW1:
> +		sw_pad_enable_mask = AMD_SDW1_PAD_KEEPER_EN_MASK;
> +		sw_pad_pulldown_mask = AMD_SDW1_PAD_PULLDOWN_CTRL_ENABLE_MASK;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(ctrl->sdw_lock);
> +	val = acp_reg_readl(ctrl->mmio + ACP_SW_PAD_KEEPER_EN);
> +	val |= sw_pad_enable_mask;
> +	acp_reg_writel(val, ctrl->mmio + ACP_SW_PAD_KEEPER_EN);
> +	mutex_unlock(ctrl->sdw_lock);
> +	usleep_range(1000, 1500);
> +
> +	mutex_lock(ctrl->sdw_lock);
> +	sw_pad_pulldown_val  = acp_reg_readl(ctrl->mmio + ACP_PAD_PULLDOWN_CTRL);
> +	sw_pad_pulldown_val &= sw_pad_pulldown_mask;
> +	acp_reg_writel(sw_pad_pulldown_val, ctrl->mmio + ACP_PAD_PULLDOWN_CTRL);
> +	mutex_unlock(ctrl->sdw_lock);
> +	return 0;
> +}
> +
> +static int amd_init_sdw_controller(struct amd_sdwc_ctrl *ctrl)
> +{
> +	u32 acp_sw_en_reg, acp_sw_en_stat_reg, sw_bus_reset_reg;
> +	u32 val = 0;
> +	u32 timeout = 0;
> +	u32 retry_count = 0;
> +
> +	switch (ctrl->instance) {
> +	case ACP_SDW0:
> +		acp_sw_en_reg = ACP_SW_EN;
> +		acp_sw_en_stat_reg = ACP_SW_EN_STATUS;
> +		sw_bus_reset_reg = ACP_SW_BUS_RESET_CTRL;
> +		break;
> +	case ACP_SDW1:
> +		acp_sw_en_reg = ACP_P1_SW_EN;
> +		acp_sw_en_stat_reg = ACP_P1_SW_EN_STATUS;
> +		sw_bus_reset_reg = ACP_P1_SW_BUS_RESET_CTRL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	acp_reg_writel(AMD_SDW_ENABLE, ctrl->mmio + acp_sw_en_reg);
> +	do {
> +		val = acp_reg_readl(ctrl->mmio + acp_sw_en_stat_reg);
> +		if (val)
> +			break;
> +		usleep_range(10, 50);
> +	} while (retry_count++ < AMD_SDW_STAT_MAX_RETRY_COUNT);
> +
> +	if (retry_count > AMD_SDW_STAT_MAX_RETRY_COUNT)
> +		return -ETIMEDOUT;
> +
> +	/* Sdw Controller reset */
> +	acp_reg_writel(AMD_SDW_BUS_RESET_REQ, ctrl->mmio + sw_bus_reset_reg);
> +	val = acp_reg_readl(ctrl->mmio + sw_bus_reset_reg);
> +	while (!(val & AMD_SDW_BUS_RESET_DONE)) {
> +		val = acp_reg_readl(ctrl->mmio + sw_bus_reset_reg);
> +		if (timeout > AMD_DELAY_LOOP_ITERATION)
> +			break;
> +		usleep_range(1, 5);
> +		timeout++;
> +	}

no test on timeout here to check if the bus was indeed reset?

If you are talking about bus_reset you are referring to a master btw.
The terms bus/master/link are interchangeable. A controller is not
defined in the SoundWire specification, this is part of the DisCo spec
to deal with enumeration when multiple bus/master/link are supported in
the platform.

> +	timeout = 0;
> +	acp_reg_writel(AMD_SDW_BUS_RESET_CLEAR_REQ, ctrl->mmio + sw_bus_reset_reg);
> +	val = acp_reg_readl(ctrl->mmio + sw_bus_reset_reg);
> +	while (val) {
> +		val = acp_reg_readl(ctrl->mmio + sw_bus_reset_reg);
> +		if (timeout > AMD_DELAY_LOOP_ITERATION)
> +			break;
> +		usleep_range(1, 5);
> +		timeout++;
> +	}
> +	if (timeout == AMD_DELAY_LOOP_ITERATION) {
> +		dev_err(ctrl->dev, "Failed to reset SW%x Soundwire Controller\n", ctrl->instance);
> +		return -ETIMEDOUT;
> +	}
> +	retry_count = 0;
> +	acp_reg_writel(AMD_SDW_DISABLE, ctrl->mmio + acp_sw_en_reg);
> +	do {
> +		val = acp_reg_readl(ctrl->mmio + acp_sw_en_stat_reg);
> +		if (!val)
> +			break;
> +		usleep_range(10, 50);
> +	} while (retry_count++ < AMD_SDW_STAT_MAX_RETRY_COUNT);
> +
> +	if (retry_count > AMD_SDW_STAT_MAX_RETRY_COUNT)
> +		return -ETIMEDOUT;
> +	return 0;
> +}
> +
> +static int amd_enable_sdw_controller(struct amd_sdwc_ctrl *ctrl)
> +{
> +	u32 acp_sw_en_reg;
> +	u32 acp_sw_en_stat_reg;
> +	u32 val = 0;
> +	u32 retry_count = 0;
> +
> +	switch (ctrl->instance) {
> +	case ACP_SDW0:
> +		acp_sw_en_reg = ACP_SW_EN;
> +		acp_sw_en_stat_reg = ACP_SW_EN_STATUS;
> +		break;
> +	case ACP_SDW1:
> +		acp_sw_en_reg = ACP_P1_SW_EN;
> +		acp_sw_en_stat_reg = ACP_P1_SW_EN_STATUS;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	acp_reg_writel(AMD_SDW_ENABLE, ctrl->mmio + acp_sw_en_reg);
> +
> +	do {
> +		val = acp_reg_readl(ctrl->mmio + acp_sw_en_stat_reg);
> +		if (val)
> +			break;
> +		usleep_range(10, 50);
> +	} while (retry_count++ < AMD_SDW_STAT_MAX_RETRY_COUNT);
> +
> +	if (retry_count > AMD_SDW_STAT_MAX_RETRY_COUNT)
> +		return -ETIMEDOUT;
> +	return 0;
> +}
> +
> +static int amd_disable_sdw_controller(struct amd_sdwc_ctrl *ctrl)
> +{
> +	u32 clk_resume_ctrl_reg;
> +	u32 acp_sw_en_reg;
> +	u32 acp_sw_en_stat_reg;
> +	u32 val = 0;
> +	u32 retry_count = 0;
> +
> +	switch (ctrl->instance) {
> +	case ACP_SDW0:
> +		acp_sw_en_reg = ACP_SW_EN;
> +		acp_sw_en_stat_reg = ACP_SW_EN_STATUS;
> +		clk_resume_ctrl_reg = ACP_SW_CLK_RESUME_CTRL;
> +		break;
> +	case ACP_SDW1:
> +		acp_sw_en_reg = ACP_P1_SW_EN;
> +		acp_sw_en_stat_reg = ACP_P1_SW_EN_STATUS;
> +		clk_resume_ctrl_reg = ACP_P1_SW_CLK_RESUME_CTRL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	acp_reg_writel(AMD_SDW_DISABLE, ctrl->mmio + acp_sw_en_reg);
> +
> +	/*
> +	 * After invoking controller disable sequence, check whether
> +	 * controller has executed clock stop sequence. In this case,
> +	 * controller should ignore checking enable status register.

again clock stop is a sequence at the master/link/bus level, not the
controller.

> +	 */
> +	val = acp_reg_readl(ctrl->mmio + clk_resume_ctrl_reg);
> +	if (val)
> +		return 0;
> +
> +	do {
> +		val = acp_reg_readl(ctrl->mmio + acp_sw_en_stat_reg);
> +		if (!val)
> +			break;
> +		usleep_range(10, 50);
> +	} while (retry_count++ < AMD_SDW_STAT_MAX_RETRY_COUNT);
> +
> +	if (retry_count > AMD_SDW_STAT_MAX_RETRY_COUNT)
> +		return -ETIMEDOUT;
> +	return 0;
> +}
> +
> +static int amd_enable_sdw_interrupts(struct amd_sdwc_ctrl *ctrl)
> +{
> +	u32 val;
> +	u32 acp_ext_intr_stat, acp_ext_intr_ctrl, acp_sdw_intr_mask;
> +	u32 sw_stat_mask_0to7, sw_stat_mask_8to11, sw_err_intr_mask;
> +
> +	switch (ctrl->instance) {
> +	case ACP_SDW0:
> +		acp_ext_intr_ctrl = ACP_EXTERNAL_INTR_CNTL;

should be renamed and end in CNTL0 if the other is CNTL1

And it's manager anyways, not controller.

> +		acp_sdw_intr_mask = AMD_SDW0_EXT_INTR_MASK;
> +		acp_ext_intr_stat = ACP_EXTERNAL_INTR_STAT;
> +		sw_stat_mask_0to7 = SW_STATE_CHANGE_STATUS_MASK_0TO7;
> +		sw_stat_mask_8to11 = SW_STATE_CHANGE_STATUS_MASK_8TO11;
> +		sw_err_intr_mask = SW_ERROR_INTR_MASK;
> +		break;
> +	case ACP_SDW1:
> +		acp_ext_intr_ctrl = ACP_EXTERNAL_INTR_CNTL1;
> +		acp_sdw_intr_mask = AMD_SDW1_EXT_INTR_MASK;
> +		acp_ext_intr_stat = ACP_EXTERNAL_INTR_STAT1;
> +		sw_stat_mask_0to7 = P1_SW_STATE_CHANGE_STATUS_MASK_0TO7;
> +		sw_stat_mask_8to11 = P1_SW_STATE_CHANGE_STATUS_MASK_8TO11;
> +		sw_err_intr_mask = P1_SW_ERROR_INTR_MASK;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	mutex_lock(ctrl->sdw_lock);
> +	val = acp_reg_readl(ctrl->mmio + acp_ext_intr_ctrl);
> +	val |= acp_sdw_intr_mask;
> +	acp_reg_writel(val, ctrl->mmio + acp_ext_intr_ctrl);
> +	val = acp_reg_readl(ctrl->mmio + acp_ext_intr_ctrl);
> +	mutex_unlock(ctrl->sdw_lock);
> +	dev_dbg(ctrl->dev, "%s: acp_ext_intr_ctrl[0x%x]:0x%x\n", __func__, acp_ext_intr_ctrl, val);
> +	val = acp_reg_readl(ctrl->mmio + acp_ext_intr_stat);
> +	if (val)
> +		acp_reg_writel(val, ctrl->mmio + acp_ext_intr_stat);
> +	acp_reg_writel(AMD_SDW_IRQ_MASK_0TO7, ctrl->mmio + sw_stat_mask_0to7);
> +	acp_reg_writel(AMD_SDW_IRQ_MASK_8TO11, ctrl->mmio + sw_stat_mask_8to11);
> +	acp_reg_writel(AMD_SDW_IRQ_ERROR_MASK, ctrl->mmio + sw_err_intr_mask);
> +	return 0;
> +}
> +

> +static u64 amd_sdwc_send_cmd_get_resp(struct amd_sdwc_ctrl *ctrl, u32 lword, u32 uword)
> +{
> +	u64 resp = 0;
> +	u32 imm_cmd_stat_reg, imm_cmd_uword_reg, imm_cmd_lword_reg;
> +	u32 imm_resp_uword_reg, imm_resp_lword_reg;
> +	u32 resp_lower, resp_high;
> +	u32 sts = 0;
> +	u32 timeout = 0;
> +
> +	switch (ctrl->instance) {
> +	case ACP_SDW0:
> +		imm_cmd_stat_reg = SW_IMM_CMD_STS;
> +		imm_cmd_uword_reg = SW_IMM_CMD_UPPER_WORD;
> +		imm_cmd_lword_reg = SW_IMM_CMD_LOWER_QWORD;
> +		imm_resp_uword_reg = SW_IMM_RESP_UPPER_WORD;
> +		imm_resp_lword_reg = SW_IMM_RESP_LOWER_QWORD;
> +		break;
> +	case ACP_SDW1:
> +		imm_cmd_stat_reg = P1_SW_IMM_CMD_STS;
> +		imm_cmd_uword_reg = P1_SW_IMM_CMD_UPPER_WORD;
> +		imm_cmd_lword_reg = P1_SW_IMM_CMD_LOWER_QWORD;
> +		imm_resp_uword_reg = P1_SW_IMM_RESP_UPPER_WORD;
> +		imm_resp_lword_reg = P1_SW_IMM_RESP_LOWER_QWORD;

naming consistency would be good, the P1 is sometimes a prefix,
sometimes a suffix, sometimes in the middle. Pick one.

> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	sts = acp_reg_readl(ctrl->mmio + imm_cmd_stat_reg);
> +	while (sts & AMD_SDW_IMM_CMD_BUSY) {
> +		sts = acp_reg_readl(ctrl->mmio + imm_cmd_stat_reg);
> +		if (timeout > AMD_SDW_RETRY_COUNT) {
> +			dev_err(ctrl->dev, "SDW%x previous cmd status clear failed\n",
> +				ctrl->instance);
> +			return -ETIMEDOUT;
> +		}
> +		timeout++;
> +	}
> +
> +	timeout = 0;
> +	if (sts & AMD_SDW_IMM_RES_VALID) {
> +		dev_err(ctrl->dev, "SDW%x controller is in bad state\n", ctrl->instance);
> +		acp_reg_writel(0x00, ctrl->mmio + imm_cmd_stat_reg);
> +	}
> +	acp_reg_writel(uword, ctrl->mmio + imm_cmd_uword_reg);
> +	acp_reg_writel(lword, ctrl->mmio + imm_cmd_lword_reg);
> +
> +	sts = acp_reg_readl(ctrl->mmio + imm_cmd_stat_reg);
> +	while (!(sts & AMD_SDW_IMM_RES_VALID)) {
> +		sts = acp_reg_readl(ctrl->mmio + imm_cmd_stat_reg);
> +		if (timeout > AMD_SDW_RETRY_COUNT) {
> +			dev_err(ctrl->dev, "SDW%x cmd response timeout occurred\n", ctrl->instance);
> +			return -ETIMEDOUT;
> +		}
> +		timeout++;
> +	}
> +	resp_high = acp_reg_readl(ctrl->mmio + imm_resp_uword_reg);
> +	resp_lower = acp_reg_readl(ctrl->mmio + imm_resp_lword_reg);
> +	timeout = 0;
> +	acp_reg_writel(AMD_SDW_IMM_RES_VALID, ctrl->mmio + imm_cmd_stat_reg);
> +	while ((sts & AMD_SDW_IMM_RES_VALID)) {
> +		sts = acp_reg_readl(ctrl->mmio + imm_cmd_stat_reg);
> +		if (timeout > AMD_SDW_RETRY_COUNT) {
> +			dev_err(ctrl->dev, "SDW%x cmd status retry failed\n", ctrl->instance);
> +			return -ETIMEDOUT;
> +		}
> +		timeout++;
> +	}
> +	resp = resp_high;
> +	resp = (resp << 32) | resp_lower;
> +	return resp;
> +}
> +
> +static enum sdw_command_response
> +amd_program_scp_addr(struct amd_sdwc_ctrl *ctrl, struct sdw_msg *msg)
> +{
> +	struct sdw_msg scp_msg = {0};
> +	u64 response_buf[2] = {0};
> +	u32 uword = 0, lword = 0;
> +	int nack = 0, no_ack = 0;
> +	int index, timeout = 0;
> +
> +	scp_msg.dev_num = msg->dev_num;
> +	scp_msg.addr = SDW_SCP_ADDRPAGE1;
> +	scp_msg.buf = &msg->addr_page1;
> +	amd_sdwc_ctl_word_prep(&lword, &uword, AMD_SDW_CMD_WRITE, &scp_msg, 0);
> +	response_buf[0] = amd_sdwc_send_cmd_get_resp(ctrl, lword, uword);
> +	scp_msg.addr = SDW_SCP_ADDRPAGE2;
> +	scp_msg.buf = &msg->addr_page2;
> +	amd_sdwc_ctl_word_prep(&lword, &uword, AMD_SDW_CMD_WRITE, &scp_msg, 0);
> +	response_buf[1] = amd_sdwc_send_cmd_get_resp(ctrl, lword, uword);
> +
> +	/* check response the writes */

response to the writes?  after the writes?

> +	for (index = 0; index < 2; index++) {
> +		if (response_buf[index] == -ETIMEDOUT) {
> +			dev_err(ctrl->dev, "Program SCP cmd timeout\n");
> +			timeout = 1;
> +		} else if (!(response_buf[index] & AMD_SDW_MCP_RESP_ACK)) {
> +			no_ack = 1;
> +			if (response_buf[index] & AMD_SDW_MCP_RESP_NACK) {
> +				nack = 1;
> +				dev_err(ctrl->dev, "Program SCP NACK received\n");
> +			}

this is a copy of the cadence_master.c code... With the error added that
this is not for a controller but for a master...

> +		}
> +	}
> +
> +	if (timeout) {
> +		dev_err_ratelimited(ctrl->dev,
> +				    "SCP_addrpage command timeout for Slave %d\n", msg->dev_num);
> +		return SDW_CMD_TIMEOUT;
> +	}
> +
> +	if (nack) {
> +		dev_err_ratelimited(ctrl->dev,
> +				    "SCP_addrpage NACKed for Slave %d\n", msg->dev_num);
> +		return SDW_CMD_FAIL;
> +	}
> +
> +	if (no_ack) {
> +		dev_dbg_ratelimited(ctrl->dev,
> +				    "SCP_addrpage ignored for Slave %d\n", msg->dev_num);
> +		return SDW_CMD_IGNORED;
> +	}
> +	return SDW_CMD_OK;

this should probably become a helper since the response is really the
same as in cadence_master.c

There's really room for optimization and reuse here.

> +}
> +
> +static int amd_prep_msg(struct amd_sdwc_ctrl *ctrl, struct sdw_msg *msg, int *cmd)
> +{
> +	int ret;
> +
> +	if (msg->page) {
> +		ret = amd_program_scp_addr(ctrl, msg);
> +		if (ret) {
> +			msg->len = 0;
> +			return ret;
> +		}
> +	}
> +	switch (msg->flags) {
> +	case SDW_MSG_FLAG_READ:
> +		*cmd = AMD_SDW_CMD_READ;
> +		break;
> +	case SDW_MSG_FLAG_WRITE:
> +		*cmd = AMD_SDW_CMD_WRITE;
> +		break;
> +	default:
> +		dev_err(ctrl->dev, "Invalid msg cmd: %d\n", msg->flags);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}

this is the same code as in cadence_master.c

you just replaced sdw_cnds by amd_sdw_ctrl (which is a mistake) and
cdns->dev by ctrl->dev.

> +
> +static unsigned int _amd_sdwc_xfer_msg(struct amd_sdwc_ctrl *ctrl, struct sdw_msg *msg,
> +				       int cmd, int cmd_offset)
> +{
> +	u64 response = 0;
> +	u32 uword = 0, lword = 0;
> +	int nack = 0, no_ack = 0;
> +	int timeout = 0;
> +
> +	amd_sdwc_ctl_word_prep(&lword, &uword, cmd, msg, cmd_offset);
> +	response = amd_sdwc_send_cmd_get_resp(ctrl, lword, uword);
> +
> +	if (response & AMD_SDW_MCP_RESP_ACK) {
> +		if (cmd == AMD_SDW_CMD_READ)
> +			msg->buf[cmd_offset] = FIELD_GET(AMD_SDW_MCP_RESP_RDATA, response);
> +	} else {
> +		no_ack = 1;
> +		if (response == -ETIMEDOUT) {
> +			timeout = 1;
> +		} else if (response & AMD_SDW_MCP_RESP_NACK) {
> +			nack = 1;
> +			dev_err(ctrl->dev, "Program SCP NACK received\n");
> +		}
> +	}
> +
> +	if (timeout) {
> +		dev_err_ratelimited(ctrl->dev, "command timeout for Slave %d\n", msg->dev_num);
> +		return SDW_CMD_TIMEOUT;
> +	}
> +	if (nack) {
> +		dev_err_ratelimited(ctrl->dev,
> +				    "command response NACK received for Slave %d\n", msg->dev_num);
> +		return SDW_CMD_FAIL;
> +	}
> +
> +	if (no_ack) {
> +		dev_err_ratelimited(ctrl->dev, "command is ignored for Slave %d\n", msg->dev_num);
> +		return SDW_CMD_IGNORED;
> +	}
> +	return SDW_CMD_OK;
> +}
> +
> +static enum sdw_command_response amd_sdwc_xfer_msg(struct sdw_bus *bus, struct sdw_msg *msg)
> +{
> +	struct amd_sdwc_ctrl *ctrl = to_amd_sdw(bus);
> +	int ret, i;
> +	int cmd = 0;
> +
> +	ret = amd_prep_msg(ctrl, msg, &cmd);
> +	if (ret)
> +		return SDW_CMD_FAIL_OTHER;
> +	for (i = 0; i < msg->len; i++) {
> +		ret = _amd_sdwc_xfer_msg(ctrl, msg, cmd, i);
> +		if (ret)
> +			return ret;
> +	}
> +	return SDW_CMD_OK;
> +}
> +
> +static enum sdw_command_response
> +amd_reset_page_addr(struct sdw_bus *bus, unsigned int dev_num)
> +{
> +	struct amd_sdwc_ctrl *ctrl = to_amd_sdw(bus);
> +	struct sdw_msg msg;
> +
> +	/* Create dummy message with valid device number */
> +	memset(&msg, 0, sizeof(msg));
> +	msg.dev_num = dev_num;
> +	return amd_program_scp_addr(ctrl, &msg);
> +}
> +
> +static u32 amd_sdwc_read_ping_status(struct sdw_bus *bus)
> +{
> +	struct amd_sdwc_ctrl *ctrl = to_amd_sdw(bus);
> +	u64 response;
> +	u32 slave_stat = 0;
> +
> +	response = amd_sdwc_send_cmd_get_resp(ctrl, 0, 0);
> +	/* slave status from ping response*/
> +	slave_stat = FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_0_3, response);
> +	slave_stat |= FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_4_11, response) << 8;
> +	dev_dbg(ctrl->dev, "%s: slave_stat:0x%x\n", __func__, slave_stat);
> +	return slave_stat;
> +}
> +
> +static void amd_sdwc_compute_slave_ports(struct sdw_master_runtime *m_rt,
> +					 struct sdw_transport_data *t_data)
> +{
> +	struct sdw_slave_runtime *s_rt = NULL;
> +	struct sdw_port_runtime *p_rt;
> +	int port_bo, sample_int;
> +	unsigned int rate, bps, ch = 0;
> +	unsigned int slave_total_ch;
> +	struct sdw_bus_params *b_params = &m_rt->bus->params;
> +
> +	port_bo = t_data->block_offset;
> +	list_for_each_entry(s_rt, &m_rt->slave_rt_list, m_rt_node) {
> +		rate = m_rt->stream->params.rate;
> +		bps = m_rt->stream->params.bps;
> +		sample_int = (m_rt->bus->params.curr_dr_freq / rate);
> +		slave_total_ch = 0;
> +
> +		list_for_each_entry(p_rt, &s_rt->port_list, port_node) {
> +			ch = sdw_ch_mask_to_ch(p_rt->ch_mask);
> +
> +			sdw_fill_xport_params(&p_rt->transport_params,
> +					      p_rt->num, false,
> +					      SDW_BLK_GRP_CNT_1,
> +					      sample_int, port_bo, port_bo >> 8,
> +					      t_data->hstart,
> +					      t_data->hstop,
> +					      SDW_BLK_PKG_PER_PORT, 0x0);
> +
> +			sdw_fill_port_params(&p_rt->port_params,
> +					     p_rt->num, bps,
> +					     SDW_PORT_FLOW_MODE_ISOCH,
> +					     b_params->s_data_mode);
> +
> +			port_bo += bps * ch;
> +			slave_total_ch += ch;
> +		}
> +
> +		if (m_rt->direction == SDW_DATA_DIR_TX &&
> +		    m_rt->ch_count == slave_total_ch) {
> +			port_bo = t_data->block_offset;
> +		}
> +	}
> +}

ok, this is really bad.

This is a verbatim copy of the same function in
generic_bandwidth_allocation.c

see
https://elixir.bootlin.com/linux/latest/source/drivers/soundwire/generic_bandwidth_allocation.c#L38

You only removed the comments and renamed the function.

Seriously? Why would you do that?

And in addition, this has *NOTHING* to do with the master support.

Programming the ports on peripheral side is something that happens at
the stream level.

I am afraid it's a double NAK, or rather NAK^2 from me here.

> +
> +static int amd_sdwc_compute_params(struct sdw_bus *bus)
> +{
> +	struct sdw_transport_data t_data = {0};
> +	struct sdw_master_runtime *m_rt;
> +	struct sdw_port_runtime *p_rt;
> +	struct sdw_bus_params *b_params = &bus->params;
> +	int port_bo, hstart, hstop, sample_int;
> +	unsigned int rate, bps;
> +
> +	port_bo  = 0;
> +	hstart = 1;
> +	hstop = bus->params.col - 1;
> +	t_data.hstop = hstop;
> +	t_data.hstart = hstart;
> +
> +	list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
> +		rate = m_rt->stream->params.rate;
> +		bps = m_rt->stream->params.bps;
> +		sample_int = (bus->params.curr_dr_freq / rate);
> +		list_for_each_entry(p_rt, &m_rt->port_list, port_node) {
> +			port_bo = (p_rt->num * 64) + 1;
> +			dev_dbg(bus->dev, "p_rt->num=%d hstart=%d hstop=%d port_bo=%d\n",
> +				p_rt->num, hstart, hstop, port_bo);
> +			sdw_fill_xport_params(&p_rt->transport_params, p_rt->num,
> +					      false, SDW_BLK_GRP_CNT_1, sample_int,
> +					      port_bo, port_bo >> 8, hstart, hstop,
> +					      SDW_BLK_PKG_PER_PORT, 0x0);
> +
> +			sdw_fill_port_params(&p_rt->port_params,
> +					     p_rt->num, bps,
> +					     SDW_PORT_FLOW_MODE_ISOCH,
> +					     b_params->m_data_mode);
> +			t_data.hstart = hstart;
> +			t_data.hstop = hstop;
> +			t_data.block_offset = port_bo;
> +			t_data.sub_block_offset = 0;
> +		}
> +		amd_sdwc_compute_slave_ports(m_rt, &t_data);
> +	}
> +	return 0;
> +}

this is a variation on sdw_compute_master_ports() in generic_allocation.c

You would need a lot more comments to convince me that this is
intentional and needed.

> +
> +static int amd_sdwc_port_params(struct sdw_bus *bus, struct sdw_port_params *p_params,
> +				unsigned int bank)
> +{
> +	struct amd_sdwc_ctrl *ctrl = to_amd_sdw(bus);
> +	u32 channel_type, frame_fmt_reg, dpn_frame_fmt;
> +
> +	dev_dbg(ctrl->dev, "%s: p_params->num:0x%x\n", __func__, p_params->num);
> +	switch (ctrl->instance) {
> +	case ACP_SDW0:
> +		channel_type = p_params->num;
> +		break;
> +	case ACP_SDW1:
> +		channel_type = p_params->num + ACP_SDW0_MAX_DAI;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch (channel_type) {
> +	case ACP_SDW0_AUDIO_TX:

you'll have to explain what you mean by 'channel_type'

This looks like the streams that can be supported by this master
implementation, with dailinks for each.

> +		frame_fmt_reg = ACP_SW_AUDIO_TX_FRAME_FORMAT;
> +		break;
> +	case ACP_SDW0_HS_TX:
> +		frame_fmt_reg = ACP_SW_HEADSET_TX_FRAME_FORMAT;
> +		break;
> +	case ACP_SDW0_BT_TX:
> +		frame_fmt_reg = ACP_SW_BT_TX_FRAME_FORMAT;
> +		break;
> +	case ACP_SDW1_BT_TX:
> +		frame_fmt_reg = ACP_P1_SW_BT_TX_FRAME_FORMAT;
> +		break;
> +	case ACP_SDW0_AUDIO_RX:
> +		frame_fmt_reg = ACP_SW_AUDIO_RX_FRAME_FORMAT;
> +		break;
> +	case ACP_SDW0_HS_RX:
> +		frame_fmt_reg = ACP_SW_HEADSET_RX_FRAME_FORMAT;
> +		break;
> +	case ACP_SDW0_BT_RX:
> +		frame_fmt_reg = ACP_SW_BT_RX_FRAME_FORMAT;
> +		break;
> +	case ACP_SDW1_BT_RX:
> +		frame_fmt_reg = ACP_P1_SW_BT_RX_FRAME_FORMAT;
> +		break;
> +	default:
> +		dev_err(bus->dev, "%s:Invalid channel:%d\n", __func__, channel_type);
> +		return -EINVAL;
> +	}
> +	dpn_frame_fmt = acp_reg_readl(ctrl->mmio + frame_fmt_reg);
> +	u32p_replace_bits(&dpn_frame_fmt, p_params->flow_mode, AMD_DPN_FRAME_FMT_PFM);
> +	u32p_replace_bits(&dpn_frame_fmt, p_params->data_mode, AMD_DPN_FRAME_FMT_PDM);
> +	u32p_replace_bits(&dpn_frame_fmt, p_params->bps - 1, AMD_DPN_FRAME_FMT_WORD_LEN);
> +	acp_reg_writel(dpn_frame_fmt, ctrl->mmio + frame_fmt_reg);
> +	return 0;
> +}
> +
> +static int amd_sdwc_transport_params(struct sdw_bus *bus,
> +				     struct sdw_transport_params *params,
> +				     enum sdw_reg_bank bank)
> +{
> +	struct amd_sdwc_ctrl *ctrl = to_amd_sdw(bus);
> +	u32 ssp_counter_reg;
> +	u32 dpn_frame_fmt;
> +	u32 dpn_sampleinterval;
> +	u32 dpn_hctrl;
> +	u32 dpn_offsetctrl;
> +	u32 dpn_lanectrl;
> +	u32 channel_type;
> +	u32 frame_fmt_reg, sample_int_reg, hctrl_dp0_reg;
> +	u32 offset_reg, lane_ctrl_reg;
> +
> +	switch (ctrl->instance) {
> +	case ACP_SDW0:
> +		ssp_counter_reg = ACP_SW_SSP_COUNTER;
> +		channel_type = params->port_num;
> +		break;
> +	case ACP_SDW1:
> +		ssp_counter_reg = ACP_P1_SW_SSP_COUNTER;
> +		channel_type = params->port_num + ACP_SDW0_MAX_DAI;

There's obviously a dependency between SDW0 and SDW1 managers that you
haven't described?

> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	acp_reg_writel(AMD_SDW_SSP_COUNTER_VAL, ctrl->mmio + ssp_counter_reg);
> +	dev_dbg(bus->dev, "%s: p_params->num:0x%x entry channel_type:0x%x\n",
> +		__func__, params->port_num, channel_type);
> +
> +	switch (channel_type) {
> +	case ACP_SDW0_AUDIO_TX:
> +	{
> +		frame_fmt_reg = ACP_SW_AUDIO_TX_FRAME_FORMAT;
> +		sample_int_reg = ACP_SW_AUDIO_TX_SAMPLEINTERVAL;
> +		hctrl_dp0_reg = ACP_SW_AUDIO_TX_HCTRL_DP0;
> +		offset_reg = ACP_SW_AUDIO_TX_OFFSET_DP0;
> +		lane_ctrl_reg = ACP_SW_AUDIO_TX_CHANNEL_ENABLE_DP0;

This is confusing. Is this about enabling a stream or selecting the lane
for this port? Same for all cases.

is this saying that the two cases are handled by the same register -
unlike what is normative for the peripherals where the two concepts are
handeld in DPN_ChannelEn and DPN_LaneCtrl registers?

> +		break;
> +	}
> +	case ACP_SDW0_HS_TX:
> +	{
> +		frame_fmt_reg = ACP_SW_HEADSET_TX_FRAME_FORMAT;
> +		sample_int_reg = ACP_SW_HEADSET_TX_SAMPLEINTERVAL;
> +		hctrl_dp0_reg = ACP_SW_HEADSET_TX_HCTRL;
> +		offset_reg = ACP_SW_HEADSET_TX_OFFSET;
> +		lane_ctrl_reg = ACP_SW_HEADSET_TX_CHANNEL_ENABLE_DP0;
> +		break;
> +	}
> +	case ACP_SDW0_BT_TX:
> +	{
> +		frame_fmt_reg = ACP_SW_BT_TX_FRAME_FORMAT;
> +		sample_int_reg = ACP_SW_BT_TX_SAMPLEINTERVAL;
> +		hctrl_dp0_reg = ACP_SW_BT_TX_HCTRL;
> +		offset_reg = ACP_SW_BT_TX_OFFSET;
> +		lane_ctrl_reg = ACP_SW_BT_TX_CHANNEL_ENABLE_DP0;
> +		break;
> +	}
> +	case ACP_SDW1_BT_TX:
> +	{
> +		frame_fmt_reg = ACP_P1_SW_BT_TX_FRAME_FORMAT;
> +		sample_int_reg = ACP_P1_SW_BT_TX_SAMPLEINTERVAL;
> +		hctrl_dp0_reg = ACP_P1_SW_BT_TX_HCTRL;
> +		offset_reg = ACP_P1_SW_BT_TX_OFFSET;
> +		lane_ctrl_reg = ACP_P1_SW_BT_TX_CHANNEL_ENABLE_DP0;
> +		break;
> +	}
> +	case ACP_SDW0_AUDIO_RX:
> +	{
> +		frame_fmt_reg = ACP_SW_AUDIO_RX_FRAME_FORMAT;
> +		sample_int_reg = ACP_SW_AUDIO_RX_SAMPLEINTERVAL;
> +		hctrl_dp0_reg = ACP_SW_AUDIO_RX_HCTRL_DP0;
> +		offset_reg = ACP_SW_AUDIO_RX_OFFSET_DP0;
> +		lane_ctrl_reg = ACP_SW_AUDIO_RX_CHANNEL_ENABLE_DP0;
> +		break;
> +	}
> +	case ACP_SDW0_HS_RX:
> +	{
> +		frame_fmt_reg = ACP_SW_HEADSET_RX_FRAME_FORMAT;
> +		sample_int_reg = ACP_SW_HEADSET_RX_SAMPLEINTERVAL;
> +		hctrl_dp0_reg = ACP_SW_HEADSET_RX_HCTRL;
> +		offset_reg = ACP_SW_HEADSET_RX_OFFSET;
> +		lane_ctrl_reg = ACP_SW_HEADSET_RX_CHANNEL_ENABLE_DP0;
> +		break;
> +	}
> +	case ACP_SDW0_BT_RX:
> +	{
> +		frame_fmt_reg = ACP_SW_BT_RX_FRAME_FORMAT;
> +		sample_int_reg = ACP_SW_BT_RX_SAMPLEINTERVAL;
> +		hctrl_dp0_reg = ACP_SW_BT_RX_HCTRL;
> +		offset_reg = ACP_SW_BT_RX_OFFSET;
> +		lane_ctrl_reg = ACP_SW_BT_RX_CHANNEL_ENABLE_DP0;
> +		break;
> +	}
> +	case ACP_SDW1_BT_RX:
> +	{
> +		frame_fmt_reg = ACP_P1_SW_BT_RX_FRAME_FORMAT;
> +		sample_int_reg = ACP_P1_SW_BT_RX_SAMPLEINTERVAL;
> +		hctrl_dp0_reg = ACP_P1_SW_BT_RX_HCTRL;
> +		offset_reg = ACP_P1_SW_BT_RX_OFFSET;
> +		lane_ctrl_reg = ACP_P1_SW_BT_RX_CHANNEL_ENABLE_DP0;
> +		break;
> +	}
> +	default:
> +		dev_err(bus->dev, "%s:Invalid channel:%d\n", __func__, channel_type);
> +		return -EINVAL;
> +	}
> +	dpn_frame_fmt = acp_reg_readl(ctrl->mmio + frame_fmt_reg);
> +	u32p_replace_bits(&dpn_frame_fmt, params->blk_pkg_mode, AMD_DPN_FRAME_FMT_BLK_PKG_MODE);
> +	u32p_replace_bits(&dpn_frame_fmt, params->blk_grp_ctrl, AMD_DPN_FRAME_FMT_BLK_GRP_CTRL);
> +	u32p_replace_bits(&dpn_frame_fmt, SDW_STREAM_PCM, AMD_DPN_FRAME_FMT_PCM_OR_PDM);
> +	acp_reg_writel(dpn_frame_fmt, ctrl->mmio + frame_fmt_reg);
> +
> +	dpn_sampleinterval = params->sample_interval - 1;
> +	acp_reg_writel(dpn_sampleinterval, ctrl->mmio + sample_int_reg);
> +
> +	dpn_hctrl = FIELD_PREP(AMD_DPN_HCTRL_HSTOP, params->hstop);
> +	dpn_hctrl |= FIELD_PREP(AMD_DPN_HCTRL_HSTART, params->hstart);
> +	acp_reg_writel(dpn_hctrl, ctrl->mmio + hctrl_dp0_reg);
> +
> +	dpn_offsetctrl = FIELD_PREP(AMD_DPN_OFFSET_CTRL_1, params->offset1);
> +	dpn_offsetctrl |= FIELD_PREP(AMD_DPN_OFFSET_CTRL_2, params->offset2);
> +	acp_reg_writel(dpn_offsetctrl, ctrl->mmio + offset_reg);
> +
> +	dpn_lanectrl = acp_reg_readl(ctrl->mmio + lane_ctrl_reg);
> +	u32p_replace_bits(&dpn_lanectrl, params->lane_ctrl, AMD_DPN_CH_EN_LCTRL);
> +	acp_reg_writel(dpn_lanectrl, ctrl->mmio + lane_ctrl_reg);
> +	return 0;
> +}
> +
> +static int amd_sdwc_port_enable(struct sdw_bus *bus,
> +				struct sdw_enable_ch *enable_ch,
> +				unsigned int bank)
> +{
> +	struct amd_sdwc_ctrl *ctrl = to_amd_sdw(bus);
> +	u32 dpn_ch_enable;
> +	u32 ch_enable_reg, channel_type;
> +
> +	switch (ctrl->instance) {
> +	case ACP_SDW0:
> +		channel_type = enable_ch->port_num;
> +		break;
> +	case ACP_SDW1:
> +		channel_type = enable_ch->port_num + ACP_SDW0_MAX_DAI;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch (channel_type) {
> +	case ACP_SDW0_AUDIO_TX:
> +		ch_enable_reg = ACP_SW_AUDIO_TX_CHANNEL_ENABLE_DP0;

in the function above, I commented on

		lane_ctrl_reg = ACP_SW_AUDIO_TX_CHANNEL_ENABLE_DP0;

This looks really weird. You need to add comments is this is really
intentional.

> +		break;
> +	case ACP_SDW0_HS_TX:
> +		ch_enable_reg = ACP_SW_HEADSET_TX_CHANNEL_ENABLE_DP0;
> +		break;
> +	case ACP_SDW0_BT_TX:
> +		ch_enable_reg = ACP_SW_BT_TX_CHANNEL_ENABLE_DP0;
> +		break;
> +	case ACP_SDW1_BT_TX:
> +		ch_enable_reg = ACP_P1_SW_BT_TX_CHANNEL_ENABLE_DP0;
> +		break;
> +	case ACP_SDW0_AUDIO_RX:
> +		ch_enable_reg = ACP_SW_AUDIO_RX_CHANNEL_ENABLE_DP0;
> +		break;
> +	case ACP_SDW0_HS_RX:
> +		ch_enable_reg = ACP_SW_HEADSET_RX_CHANNEL_ENABLE_DP0;
> +		break;
> +	case ACP_SDW0_BT_RX:
> +		ch_enable_reg = ACP_SW_BT_RX_CHANNEL_ENABLE_DP0;
> +		break;
> +	case ACP_SDW1_BT_RX:
> +		ch_enable_reg = ACP_P1_SW_BT_RX_CHANNEL_ENABLE_DP0;
> +		break;
> +	default:
> +		dev_err(bus->dev, "%s:Invalid channel:%d\n", __func__, channel_type);
> +		return -EINVAL;
> +	}
> +
> +	dpn_ch_enable =  acp_reg_readl(ctrl->mmio + ch_enable_reg);
> +	u32p_replace_bits(&dpn_ch_enable, enable_ch->ch_mask, AMD_DPN_CH_EN_CHMASK);
> +	if (enable_ch->enable)
> +		acp_reg_writel(dpn_ch_enable, ctrl->mmio + ch_enable_reg);
> +	else
> +		acp_reg_writel(0, ctrl->mmio + ch_enable_reg);
> +	return 0;
> +}
> +
> +static int sdw_master_read_amd_prop(struct sdw_bus *bus)
> +{
> +	struct amd_sdwc_ctrl *ctrl = to_amd_sdw(bus);
> +	struct fwnode_handle *link;
> +	struct sdw_master_prop *prop;
> +	u32 quirk_mask = 0;
> +	u32 wake_en_mask = 0;
> +	u32 power_mode_mask = 0;
> +	char name[32];
> +
> +	prop = &bus->prop;
> +	/* Find master handle */
> +	snprintf(name, sizeof(name), "mipi-sdw-link-%d-subproperties", bus->link_id);
> +	link = device_get_named_child_node(bus->dev, name);
> +	if (!link) {
> +		dev_err(bus->dev, "Master node %s not found\n", name);
> +		return -EIO;
> +	}
> +	fwnode_property_read_u32(link, "amd-sdw-enable", &quirk_mask);
> +	if (!(quirk_mask & AMD_SDW_QUIRK_MASK_BUS_ENABLE))
> +		prop->hw_disabled = true;

same quirk as Intel, nice :-)

> +	prop->quirks = SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH |
> +		       SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY;

And here too. Is this really needed or just-copy-pasted?

> +	fwnode_property_read_u32(link, "amd-sdw-wake-enable", &wake_en_mask);
> +	ctrl->wake_en_mask = wake_en_mask;
> +	fwnode_property_read_u32(link, "amd-sdw-power-mode", &power_mode_mask);
> +	ctrl->power_mode_mask = power_mode_mask;
> +	return 0;
> +}
> +

> +static int amd_sdwc_probe(struct platform_device *pdev)

why not use an auxiliary device? we've moved away from platform devices
maybe two years ago.

> +{
> +	const struct acp_sdw_pdata *pdata = pdev->dev.platform_data;
> +	struct resource *res;
> +	struct device *dev = &pdev->dev;
> +	struct sdw_master_prop *prop;
> +	struct sdw_bus_params *params;
> +	struct amd_sdwc_ctrl *ctrl;
> +	int ret;
> +
> +	if (!pdev->dev.platform_data) {
> +		dev_err(&pdev->dev, "platform_data not retrieved\n");
> +		return -ENODEV;
> +	}
> +	ctrl = devm_kzalloc(&pdev->dev, sizeof(struct amd_sdwc_ctrl), GFP_KERNEL);
> +	if (!ctrl)
> +		return -ENOMEM;
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
> +		return -ENOMEM;
> +	}
> +	ctrl->mmio = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +	if (IS_ERR(ctrl->mmio)) {
> +		dev_err(&pdev->dev, "mmio not found\n");
> +		return PTR_ERR(ctrl->mmio);
> +	}
> +	ctrl->instance = pdata->instance;
> +	ctrl->sdw_lock  = pdata->sdw_lock;
> +	ctrl->rows_index = sdw_find_row_index(50);
> +	ctrl->cols_index = sdw_find_col_index(10);
> +
> +	ctrl->dev = dev;
> +	dev_set_drvdata(&pdev->dev, ctrl);
> +
> +	ctrl->bus.ops = &amd_sdwc_ops;
> +	ctrl->bus.port_ops = &amd_sdwc_port_ops;
> +	ctrl->bus.compute_params = &amd_sdwc_compute_params;
> +	ctrl->bus.clk_stop_timeout = 1;
> +	switch (ctrl->instance) {
> +	case ACP_SDW0:
> +		ctrl->num_dout_ports =  AMD_SDW0_MAX_TX_PORTS;
> +		ctrl->num_din_ports = AMD_SDW0_MAX_RX_PORTS;
> +		break;
> +	case ACP_SDW1:
> +		ctrl->num_dout_ports = AMD_SDW1_MAX_TX_PORTS;
> +		ctrl->num_din_ports = AMD_SDW1_MAX_RX_PORTS;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	params = &ctrl->bus.params;
> +	params->max_dr_freq = AMD_SDW_DEFAULT_CLK_FREQ * 2;
> +	params->curr_dr_freq = AMD_SDW_DEFAULT_CLK_FREQ * 2;
> +	params->col = 10;
> +	params->row = 50;
> +
> +	prop = &ctrl->bus.prop;
> +	prop->clk_freq = &amd_sdwc_freq_tbl[0];
> +	prop->mclk_freq = AMD_SDW_BUS_BASE_FREQ;
> +	ctrl->bus.link_id = ctrl->instance;
> +	ret = sdw_bus_master_add(&ctrl->bus, dev, dev->fwnode);
> +	if (ret) {
> +		dev_err(dev, "Failed to register Soundwire controller (%d)\n",

master. the confusion continues.

> +			ret);
> +		return ret;
> +	}
> +	INIT_WORK(&ctrl->probe_work, amd_sdwc_probe_work);
> +	schedule_work(&ctrl->probe_work);
> +	return 0;
> +}
> +
> +static int amd_sdwc_remove(struct platform_device *pdev)
> +{
> +	struct amd_sdwc_ctrl *ctrl = dev_get_drvdata(&pdev->dev);
> +	int ret;
> +
> +	amd_disable_sdw_interrupts(ctrl);
> +	sdw_bus_master_delete(&ctrl->bus);
> +	ret = amd_disable_sdw_controller(ctrl);
> +	return ret;
> +}
> +
> +static struct platform_driver amd_sdwc_driver = {
> +	.probe	= &amd_sdwc_probe,
> +	.remove = &amd_sdwc_remove,
> +	.driver = {
> +		.name	= "amd_sdw_controller",
> +	}
> +};
> +module_platform_driver(amd_sdwc_driver);
> +
> +MODULE_AUTHOR("Vijendar.Mukunda@amd.com");
> +MODULE_DESCRIPTION("AMD soundwire driver");
> +MODULE_LICENSE("GPL v2");

"GPL" is enough

> +enum amd_sdw_channel {
> +	/* SDW0 */
> +	ACP_SDW0_AUDIO_TX = 0,
> +	ACP_SDW0_BT_TX,
> +	ACP_SDW0_HS_TX,
> +	ACP_SDW0_AUDIO_RX,
> +	ACP_SDW0_BT_RX,
> +	ACP_SDW0_HS_RX,
> +	/* SDW1 */
> +	ACP_SDW1_BT_TX,
> +	ACP_SDW1_BT_RX,
> +};

you really need to comment on this. It looks like you've special-cased
manager ports for specific usages? This is perfectly fine in closed
applications, but it's not clear how it might work with headset,
amplifier and mic codec devices.


> diff --git a/include/linux/soundwire/sdw_amd.h b/include/linux/soundwire/sdw_amd.h
> index f0123815af46..5ec39f8c2f2e 100644
> --- a/include/linux/soundwire/sdw_amd.h
> +++ b/include/linux/soundwire/sdw_amd.h
> @@ -10,9 +10,30 @@
>  
>  #define AMD_SDW_CLK_STOP_MODE		1
>  #define AMD_SDW_POWER_OFF_MODE		2
> +#define ACP_SDW0	0
> +#define ACP_SDW1	1
> +#define ACP_SDW0_MAX_DAI	6

is this related to the definition of amd_sdw_channel or the number of
ports available?
>  
>  struct acp_sdw_pdata {
>  	u16 instance;
>  	struct mutex *sdw_lock;
>  };
> +
> +struct amd_sdwc_ctrl {
> +	struct sdw_bus bus;
> +	struct device *dev;
> +	void __iomem *mmio;
> +	struct work_struct probe_work;
> +	struct mutex *sdw_lock;

comment please.

> +	int num_din_ports;
> +	int num_dout_ports;
> +	int cols_index;
> +	int rows_index;
> +	u32 instance;
> +	u32 quirks;
> +	u32 wake_en_mask;
> +	int num_ports;
> +	bool startup_done;

ah this was an Intel definition. Due to power dependencies we had to
split the probe and startup step. Does AMD have a need for this? Is the
SoundWire master IP dependent on DSP boot or something?

> +	u32 power_mode_mask;
> +};
>  #endif
