Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B8F645A5C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiLGNGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLGNGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:06:03 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED982AE17;
        Wed,  7 Dec 2022 05:06:00 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 114A36602BB7;
        Wed,  7 Dec 2022 13:05:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670418358;
        bh=m9tJPWs/sCKXUILTGI6rpQdsUo1PI8lzS/z0Su5LkwQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CHgm7gczly3Bcu4sWxIlkrHHKNcDJ9ylcpKI2+VPLIdY3ijvYSZM00NW39cOItD6e
         a6Lx+RsYT9IPMF21GWuRSt21RPioMjKrxoy5rM8veA0ry2jcT8r+oO1o7Efpv9jZUI
         nCrZ4+71rCo8svxPTH18ybc7ybtzlym66XzFTJeAlXfdIu4Cm+MnBZZG8IaCrYeXQo
         S6fGmzzKZMYRrRdMhqjck0Ev/vmW4Iy0vPFlZUgZPkp3w5dDR+hHYc4m/KvMohINy7
         X0SFDYDcj+CG43OCKSS3iNcLikhTOD6rDgXvuUtfIFlWxanYMGmDlsFNpT7MhqnNTz
         oS11ihaRI5Y+w==
Message-ID: <c57af009-6453-db07-6190-69d9247dd50e@collabora.com>
Date:   Wed, 7 Dec 2022 14:05:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v11 2/6] media: chips-media: wave5: Add vpuapi layer
Content-Language: en-US
To:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org, Nas Chung <nas.chung@chipsnmedia.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.com, linux-kernel@vger.kernel.org
References: <20221207121350.66217-1-sebastian.fricke@collabora.com>
 <20221207121350.66217-3-sebastian.fricke@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221207121350.66217-3-sebastian.fricke@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/12/22 13:13, Sebastian Fricke ha scritto:
> From: Nas Chung <nas.chung@chipsnmedia.com>
> 
> Add the vpuapi layer of the wave5 codec driver.
> This layer is used to configure the hardware according
> to the parameters.
> 
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
> ---
>   .../platform/chips-media/wave5/wave5-hw.c     | 3359 +++++++++++++++++
>   .../chips-media/wave5/wave5-regdefine.h       |  743 ++++
>   .../platform/chips-media/wave5/wave5-vdi.c    |  245 ++
>   .../platform/chips-media/wave5/wave5-vdi.h    |   67 +
>   .../platform/chips-media/wave5/wave5-vpuapi.c | 1040 +++++
>   .../platform/chips-media/wave5/wave5-vpuapi.h | 1136 ++++++
>   .../chips-media/wave5/wave5-vpuconfig.h       |   90 +
>   .../chips-media/wave5/wave5-vpuerror.h        |  454 +++
>   .../media/platform/chips-media/wave5/wave5.h  |   94 +
>   9 files changed, 7228 insertions(+)
>   create mode 100644 drivers/media/platform/chips-media/wave5/wave5-hw.c
>   create mode 100644 drivers/media/platform/chips-media/wave5/wave5-regdefine.h
>   create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vdi.c
>   create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vdi.h
>   create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
>   create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
>   create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpuconfig.h
>   create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpuerror.h
>   create mode 100644 drivers/media/platform/chips-media/wave5/wave5.h
> 
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c b/drivers/media/platform/chips-media/wave5/wave5-hw.c
> new file mode 100644
> index 000000000000..25705e61cdb3
> --- /dev/null
> +++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
> @@ -0,0 +1,3359 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> +/*
> + * Wave5 series multi-standard codec IP - wave5 backend logic
> + *
> + * Copyright (C) 2021 CHIPS&MEDIA INC
> + */
> +
> +#include <linux/iopoll.h>
> +#include "wave5-vpu.h"
> +#include "wave5.h"
> +#include "wave5-regdefine.h"
> +
> +#define FIO_TIMEOUT			10000000

FIO_TIMEOUT_US looks better :-)

> +#define FIO_CTRL_READY			BIT(31)
> +#define FIO_CTRL_WRITE			BIT(16)
> +#define VPU_BUSY_CHECK_TIMEOUT		10000000
> +#define QUEUE_REPORT_MASK		0xffff
> +
> +static void wave5_print_reg_err(struct vpu_device *vpu_dev, u32 reg_fail_reason)
> +{
> +	char *caller = __builtin_return_address(0);
> +	struct device *dev = vpu_dev->dev;
> +	u32 reg_val;
> +
> +	switch (reg_fail_reason) {
> +	case WAVE5_SYSERR_QUEUEING_FAIL:
> +		reg_val = vpu_read_reg(vpu_dev, W5_RET_QUEUE_FAIL_REASON);
> +		dev_dbg(dev, "%s: queueing failure: 0x%x\n", caller, reg_val);
> +		break;
> +	case WAVE5_SYSERR_RESULT_NOT_READY:
> +		dev_err(dev, "%s: result not ready: 0x%x\n", caller, reg_fail_reason);
> +		break;
> +	case WAVE5_SYSERR_ACCESS_VIOLATION_HW:
> +		dev_err(dev, "%s: access violation: 0x%x\n", caller, reg_fail_reason);
> +		break;
> +	case WAVE5_SYSERR_WATCHDOG_TIMEOUT:
> +		dev_err(dev, "%s: watchdog timeout: 0x%x\n", caller, reg_fail_reason);
> +		break;
> +	case WAVE5_SYSERR_BUS_ERROR:
> +		dev_err(dev, "%s: bus error: 0x%x\n", caller, reg_fail_reason);
> +		break;
> +	case WAVE5_SYSERR_DOUBLE_FAULT:
> +		dev_err(dev, "%s: double fault: 0x%x\n", caller, reg_fail_reason);
> +		break;
> +	case WAVE5_SYSERR_VPU_STILL_RUNNING:
> +		dev_err(dev, "%s: still running: 0x%x\n", caller, reg_fail_reason);
> +		break;
> +	case WAVE5_SYSERR_VLC_BUF_FULL:
> +		dev_err(dev, "%s: vlc buf full: 0x%x\n", caller, reg_fail_reason);
> +		break;
> +	default:
> +		dev_err(dev, "%s: failure:: 0x%x\n", caller, reg_fail_reason);
> +		break;
> +	}
> +}
> +
> +static int wave5_wait_fio_readl(struct vpu_device *vpu_dev, u32 addr, u32 val)
> +{
> +	u32 ctrl;
> +	int ret;
> +
> +	ctrl = addr & 0xffff;
> +	wave5_vdi_write_register(vpu_dev, W5_VPU_FIO_CTRL_ADDR, ctrl);
> +	ret = read_poll_timeout(wave5_vdi_readl, ctrl, ctrl & FIO_CTRL_READY,
> +				0, FIO_TIMEOUT, false, vpu_dev, W5_VPU_FIO_CTRL_ADDR);
> +	if (ret)
> +		return ret;
> +	if (wave5_vdi_readl(vpu_dev, W5_VPU_FIO_DATA) != val)
> +		return -ETIMEDOUT;

Are you sure that this is a timeout?
if (read_data != expected_data) => invalid data => return -EINVAL ?

> +	return 0;
> +}
> +

..snip..

> +
> +static int wave5_wait_bus_busy(struct vpu_device *vpu_dev, unsigned int addr)
> +{
> +	u32 gdi_status_check_value = 0x3f;
> +
> +	if (vpu_dev->product_code == WAVE521C_CODE ||
> +	    vpu_dev->product_code == WAVE521_CODE ||
> +	    vpu_dev->product_code == WAVE521E1_CODE)
> +		gdi_status_check_value = 0x00ff1f3f;

#define SOME_VALUE 0x3f
#define ANOTHER_VALUE 0xff1f3f

> +
> +	return wave5_wait_fio_readl(vpu_dev, addr, gdi_status_check_value);
> +}
> +

..snip..

> +
> +static int setup_wave5_properties(struct device *dev)
> +{
> +	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
> +	struct vpu_attr *p_attr = &vpu_dev->attr;
> +	u32 reg_val;
> +	u8 *str;
> +	int ret;
> +	u32 hw_config_def0, hw_config_def1, hw_config_feature, hw_config_rev;
> +
> +	vpu_write_reg(vpu_dev, W5_QUERY_OPTION, GET_VPU_INFO);
> +	vpu_write_reg(vpu_dev, W5_VPU_BUSY_STATUS, 1);
> +	vpu_write_reg(vpu_dev, W5_COMMAND, W5_QUERY);
> +	vpu_write_reg(vpu_dev, W5_VPU_HOST_INT_REQ, 1);
> +	ret = wave5_wait_vpu_busy(vpu_dev, W5_VPU_BUSY_STATUS);
> +	if (ret)
> +		return ret;
> +
> +	if (!vpu_read_reg(vpu_dev, W5_RET_SUCCESS))
> +		return -EIO;
> +
> +	reg_val = vpu_read_reg(vpu_dev, W5_RET_PRODUCT_NAME);
> +	str = (u8 *)&reg_val;
> +	p_attr->product_name[0] = str[3];
> +	p_attr->product_name[1] = str[2];
> +	p_attr->product_name[2] = str[1];
> +	p_attr->product_name[3] = str[0];
> +	p_attr->product_name[4] = 0;
> +
> +	p_attr->product_id = wave5_vpu_get_product_id(vpu_dev);
> +	p_attr->product_version = vpu_read_reg(vpu_dev, W5_RET_PRODUCT_VERSION);
> +	p_attr->fw_version = vpu_read_reg(vpu_dev, W5_RET_FW_VERSION);
> +	p_attr->customer_id = vpu_read_reg(vpu_dev, W5_RET_CUSTOMER_ID);
> +	hw_config_def0 = vpu_read_reg(vpu_dev, W5_RET_STD_DEF0);
> +	hw_config_def1 = vpu_read_reg(vpu_dev, W5_RET_STD_DEF1);
> +	hw_config_feature = vpu_read_reg(vpu_dev, W5_RET_CONF_FEATURE);
> +	hw_config_rev = vpu_read_reg(vpu_dev, W5_RET_CONF_REVISION);
> +
> +	p_attr->support_hevc10bit_enc = (hw_config_feature >> 3) & 1;

This looks like being BIT(3), and the latter is BIT(11)...

#define W5_CONF_FEATURE_HEVC10_ENC	BIT(3)
#define W5_CONF_FEATURE_AVC10_ENC	BIT(11)

p_attr->support_hevc10bit_enc = FIELD_GET(W5_CONF_FEATURE_HEVC10_ENC, 
hw_config_feature);

if (hw_config_rev > W5_REVISION_SOMETHING)
	p_attr->support_avc10bit_enc = FIELD_GET(W5_CONF_FEATURE_AVC10_ENC,
						 hw_config_feature);
else
	p_attr->support_avc10bit_enc = p_attr->support_hevc10bit_enc;


> +	if (hw_config_rev > 167455) //20190321
> +		p_attr->support_avc10bit_enc = (hw_config_feature >> 11) & 1;
> +	else
> +		p_attr->support_avc10bit_enc = p_attr->support_hevc10bit_enc;
> +
> +	p_attr->support_decoders = 0;
> +	p_attr->support_encoders = 0;
> +	if (p_attr->product_id == PRODUCT_ID_521) {
> +		p_attr->support_dual_core = ((hw_config_def1 >> 26) & 0x01);

p_attr->support_dual_core = FIELD_GET(W5_CONF_DEF_HW_DUAL_CORE, hw_config_def1);

....and there are others below, but I think I gave enough examples... :-)

> +		if (p_attr->support_dual_core || hw_config_rev < 206116) {
> +			p_attr->support_decoders = BIT(STD_AVC);
> +			p_attr->support_decoders |= BIT(STD_HEVC);
> +			p_attr->support_encoders = BIT(STD_AVC);
> +			p_attr->support_encoders |= BIT(STD_HEVC);
> +		} else {
> +			p_attr->support_decoders |= (((hw_config_def1 >> 3) & 0x01) << STD_AVC);
> +			p_attr->support_decoders |= (((hw_config_def1 >> 2) & 0x01) << STD_HEVC);
> +			p_attr->support_encoders = (((hw_config_def1 >> 1) & 0x01) << STD_AVC);
> +			p_attr->support_encoders |= ((hw_config_def1 & 0x01) << STD_HEVC);
> +		}
> +	} else if (p_attr->product_id == PRODUCT_ID_511) {
> +		p_attr->support_decoders = BIT(STD_HEVC);
> +		p_attr->support_decoders |= BIT(STD_AVC);
> +	} else if (p_attr->product_id == PRODUCT_ID_517) {
> +		p_attr->support_decoders = (((hw_config_def1 >> 4) & 0x01) << STD_AV1);
> +		p_attr->support_decoders |= (((hw_config_def1 >> 3) & 0x01) << STD_AVS2);
> +		p_attr->support_decoders |= (((hw_config_def1 >> 2) & 0x01) << STD_AVC);
> +		p_attr->support_decoders |= (((hw_config_def1 >> 1) & 0x01) << STD_VP9);
> +		p_attr->support_decoders |= ((hw_config_def1 & 0x01) << STD_HEVC);
> +	}
> +
> +	p_attr->support_backbone = (hw_config_def0 >> 16) & 0x01;
> +	p_attr->support_vcpu_backbone = (hw_config_def0 >> 28) & 0x01;
> +	p_attr->support_vcore_backbone = (hw_config_def0 >> 22) & 0x01;
> +	p_attr->support_dual_core = (hw_config_def1 >> 26) & 0x01;
> +	p_attr->support_endian_mask = BIT(VDI_LITTLE_ENDIAN) |
> +				      BIT(VDI_BIG_ENDIAN) |
> +				      BIT(VDI_32BIT_LITTLE_ENDIAN) |
> +				      BIT(VDI_32BIT_BIG_ENDIAN) |
> +				      (0xffffUL << 16);
> +	p_attr->support_bitstream_mode = BIT(BS_MODE_INTERRUPT) |
> +		BIT(BS_MODE_PIC_END);
> +
> +	return 0;
> +}
> +
> +int wave5_vpu_get_version(struct vpu_device *vpu_dev, u32 *revision)
> +{
> +	u32 reg_val;
> +	int ret;
> +
> +	vpu_write_reg(vpu_dev, W5_QUERY_OPTION, GET_VPU_INFO);
> +	vpu_write_reg(vpu_dev, W5_VPU_BUSY_STATUS, 1);
> +	vpu_write_reg(vpu_dev, W5_COMMAND, W5_QUERY);
> +	vpu_write_reg(vpu_dev, W5_VPU_HOST_INT_REQ, 1);
> +	ret = wave5_wait_vpu_busy(vpu_dev, W5_VPU_BUSY_STATUS);
> +	if (ret) {
> +		dev_err(vpu_dev->dev, "%s: timeout\n", __func__);
> +		return ret;
> +	}
> +
> +	if (!vpu_read_reg(vpu_dev, W5_RET_SUCCESS)) {
> +		dev_err(vpu_dev->dev, "%s: failed\n", __func__);
> +		return -EIO;
> +	}
> +
> +	reg_val = vpu_read_reg(vpu_dev, W5_RET_FW_VERSION);
> +	if (revision)

Move the revision pointer null check at the beginning and return an error
if that happens to be null: it doesn't make a lot of sense to read many
registers before the check as the whole point of this function is to get
the version and return it to that variable.


> +		*revision = reg_val;
> +
> +	return 0;
> +}
> +
> +static void remap_page(struct vpu_device *vpu_dev, dma_addr_t code_base, u32 index)
> +{
> +	u32 remap_size = (W5_REMAP_MAX_SIZE >> 12) & 0x1ff;
> +	u32 reg_val = 0x80000000 | (WAVE5_UPPER_PROC_AXI_ID << 20) | (index << 12) | BIT(11)
> +		| remap_size;
> +
> +	vpu_write_reg(vpu_dev, W5_VPU_REMAP_CTRL, reg_val);
> +	vpu_write_reg(vpu_dev, W5_VPU_REMAP_VADDR, index * W5_REMAP_MAX_SIZE);
> +	vpu_write_reg(vpu_dev, W5_VPU_REMAP_PADDR, code_base + index * W5_REMAP_MAX_SIZE);
> +}
> +

..snip..

> +
> +int wave5_vpu_build_up_dec_param(struct vpu_instance *inst,
> +				 struct dec_open_param *param)
> +{
> +	int ret;
> +	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
> +	u32 bs_endian;
> +	struct dma_vpu_buf *sram_vb;
> +	struct vpu_device *vpu_dev = inst->dev;
> +
> +	p_dec_info->cycle_per_tick = 256;
> +	switch (inst->std) {
> +	case W_HEVC_DEC:
> +		p_dec_info->seq_change_mask = SEQ_CHANGE_ENABLE_ALL_HEVC;
> +		break;
> +	case W_VP9_DEC:
> +		p_dec_info->seq_change_mask = SEQ_CHANGE_ENABLE_ALL_VP9;
> +		break;
> +	case W_AVS2_DEC:
> +		p_dec_info->seq_change_mask = SEQ_CHANGE_ENABLE_ALL_AVS2;
> +		break;
> +	case W_AVC_DEC:
> +		p_dec_info->seq_change_mask = SEQ_CHANGE_ENABLE_ALL_AVC;
> +		break;
> +	case W_AV1_DEC:
> +		p_dec_info->seq_change_mask = SEQ_CHANGE_ENABLE_ALL_AV1;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (vpu_dev->product == PRODUCT_ID_517)

Another switch would be good here.

> +		p_dec_info->vb_work.size = WAVE517_WORKBUF_SIZE;
> +	else if (vpu_dev->product == PRODUCT_ID_521)
> +		p_dec_info->vb_work.size = WAVE521DEC_WORKBUF_SIZE;
> +	else if (vpu_dev->product == PRODUCT_ID_511)
> +		p_dec_info->vb_work.size = WAVE521DEC_WORKBUF_SIZE;
> +
> +	ret = wave5_vdi_allocate_dma_memory(inst->dev, &p_dec_info->vb_work);
> +	if (ret)
> +		return ret;
> +
> +	vpu_write_reg(inst->dev, W5_CMD_DEC_VCORE_INFO, 1);
> +
> +	sram_vb = &vpu_dev->sram_buf;
> +	p_dec_info->sec_axi_info.buf_base = sram_vb->daddr;
> +	p_dec_info->sec_axi_info.buf_size = sram_vb->size;
> +
> +	wave5_vdi_clear_memory(inst->dev, &p_dec_info->vb_work);
> +
> +	vpu_write_reg(inst->dev, W5_ADDR_WORK_BASE, p_dec_info->vb_work.daddr);
> +	vpu_write_reg(inst->dev, W5_WORK_SIZE, p_dec_info->vb_work.size);
> +
> +	vpu_write_reg(inst->dev, W5_CMD_DEC_BS_START_ADDR, p_dec_info->stream_buf_start_addr);
> +	vpu_write_reg(inst->dev, W5_CMD_DEC_BS_SIZE, p_dec_info->stream_buf_size);
> +
> +	/* NOTE: when endian mode is 0, SDMA reads MSB first */
> +	bs_endian = wave5_vdi_convert_endian(inst->dev, param->stream_endian);
> +	bs_endian = (~bs_endian & VDI_128BIT_ENDIAN_MASK);
> +	vpu_write_reg(inst->dev, W5_CMD_BS_PARAM, bs_endian);
> +	vpu_write_reg(inst->dev, W5_CMD_EXT_ADDR, (param->pri_axprot << 20) |
> +			(param->pri_axcache << 16) | param->pri_ext_addr);
> +	vpu_write_reg(inst->dev, W5_CMD_NUM_CQ_DEPTH_M1, (COMMAND_QUEUE_DEPTH - 1));
> +	vpu_write_reg(inst->dev, W5_CMD_ERR_CONCEAL, (param->error_conceal_unit << 2) |
> +			(param->error_conceal_mode));
> +
> +	wave5_bit_issue_command(inst, W5_CREATE_INSTANCE);
> +	// check QUEUE_DONE

Please be consistent in comments format. Use C-style comments.

> +	ret = wave5_wait_vpu_busy(inst->dev, W5_VPU_BUSY_STATUS);
> +	if (ret) {
> +		dev_warn(inst->dev->dev, "command: 'W5_CREATE_INSTANCE' timed out\n");
> +		goto free_vb_work;
> +	}
> +
> +	// Check if we were able to add the parameters into the VCPU QUEUE
> +	if (!vpu_read_reg(inst->dev, W5_RET_SUCCESS)) {
> +		ret = -EIO;
> +		goto free_vb_work;
> +	}
> +
> +	p_dec_info->product_code = vpu_read_reg(inst->dev, W5_PRODUCT_NUMBER);
> +
> +	return 0;
> +free_vb_work:
> +	wave5_vdi_free_dma_memory(vpu_dev, &p_dec_info->vb_work);
> +	return ret;
> +}
> +

..snip..

> +
> +static void wave5_get_dec_seq_result(struct vpu_instance *inst, struct dec_initial_info *info)
> +{
> +	u32 reg_val, sub_layer_info;
> +	u32 profile_compatibility_flag;
> +	u32 output_bit_depth_minus8;
> +	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
> +
> +	p_dec_info->stream_rd_ptr = wave5_vpu_dec_get_rd_ptr(inst);
> +	info->rd_ptr = p_dec_info->stream_rd_ptr;
> +
> +	p_dec_info->frame_display_flag = vpu_read_reg(inst->dev, W5_RET_DEC_DISP_IDC);
> +
> +	reg_val = vpu_read_reg(inst->dev, W5_RET_DEC_PIC_SIZE);
> +	info->pic_width = ((reg_val >> 16) & 0xffff);
> +	info->pic_height = (reg_val & 0xffff);
> +	info->min_frame_buffer_count = vpu_read_reg(inst->dev, W5_RET_DEC_NUM_REQUIRED_FB);
> +	info->frame_buf_delay = vpu_read_reg(inst->dev, W5_RET_DEC_NUM_REORDER_DELAY);
> +
> +	reg_val = vpu_read_reg(inst->dev, W5_RET_DEC_CROP_LEFT_RIGHT);
> +	info->pic_crop_rect.left = (reg_val >> 16) & 0xffff;
> +	info->pic_crop_rect.right = reg_val & 0xffff;
> +	reg_val = vpu_read_reg(inst->dev, W5_RET_DEC_CROP_TOP_BOTTOM);
> +	info->pic_crop_rect.top = (reg_val >> 16) & 0xffff;
> +	info->pic_crop_rect.bottom = reg_val & 0xffff;
> +
> +	info->f_rate_numerator = vpu_read_reg(inst->dev, W5_RET_DEC_FRAME_RATE_NR);
> +	info->f_rate_denominator = vpu_read_reg(inst->dev, W5_RET_DEC_FRAME_RATE_DR);
> +
> +	reg_val = vpu_read_reg(inst->dev, W5_RET_DEC_COLOR_SAMPLE_INFO);
> +	info->luma_bitdepth = reg_val & 0xf;
> +	info->chroma_bitdepth = (reg_val >> 4) & 0xf;
> +	info->chroma_format_idc = (reg_val >> 8) & 0xf;
> +	info->aspect_rate_info = (reg_val >> 16) & 0xff;

Bitfield macros would make this way more readable.

> +	info->is_ext_sar = ((info->aspect_rate_info == 255) ? true : false);
> +	/* [0:15] - vertical size, [16:31] - horizontal size */
> +	if (info->is_ext_sar)
> +		info->aspect_rate_info = vpu_read_reg(inst->dev, W5_RET_DEC_ASPECT_RATIO);
> +	info->bit_rate = vpu_read_reg(inst->dev, W5_RET_DEC_BIT_RATE);
> +
> +	sub_layer_info = vpu_read_reg(inst->dev, W5_RET_DEC_SUB_LAYER_INFO);
> +	info->max_temporal_layers = (sub_layer_info >> 8) & 0x7;
> +
> +	reg_val = vpu_read_reg(inst->dev, W5_RET_DEC_SEQ_PARAM);
> +	info->level = reg_val & 0xff;
> +	profile_compatibility_flag = (reg_val >> 12) & 0xff;
> +	info->profile = (reg_val >> 24) & 0x1f;
> +	info->tier = (reg_val >> 29) & 0x01;
> +	output_bit_depth_minus8 = (reg_val >> 30) & 0x03;
> +
> +	if (inst->std == W_HEVC_DEC) {
> +		/* guessing profile */
> +		if (!info->profile) {
> +			if ((profile_compatibility_flag & 0x06) == 0x06)
> +				info->profile = HEVC_PROFILE_MAIN; /* main profile */

main/main10 profile comments are stating the obvious, please remove them.

> +			else if ((profile_compatibility_flag & 0x04) == 0x04)
> +				info->profile = HEVC_PROFILE_MAIN10; /* main10 profile */
> +			else if ((profile_compatibility_flag & 0x08) == 0x08)
> +				/* main still picture profile */
> +				info->profile = HEVC_PROFILE_STILLPICTURE;
> +			else
> +				info->profile = HEVC_PROFILE_MAIN; /* for old version HM */
> +		}
> +
> +	} else if (inst->std == W_AVS2_DEC) {
> +		if (info->luma_bitdepth == 10 && output_bit_depth_minus8 == 2)
> +			info->output_bit_depth = 10;
> +		else
> +			info->output_bit_depth = 8;
> +
> +	} else if (inst->std == W_AVC_DEC) {
> +		info->profile = (reg_val >> 24) & 0x7f;
> +	}
> +
> +	info->vlc_buf_size = vpu_read_reg(inst->dev, W5_RET_VLC_BUF_SIZE);
> +	info->param_buf_size = vpu_read_reg(inst->dev, W5_RET_PARAM_BUF_SIZE);
> +	p_dec_info->vlc_buf_size = info->vlc_buf_size;
> +	p_dec_info->param_buf_size = info->param_buf_size;
> +}
> +

..snip..

> +
> +static u32 calculate_table_size(u32 bit_depth, u32 frame_width, u32 frame_height, u32 ot_bg_width)
> +{
> +	u32 bgs_width = ((bit_depth > 8) ? 256 : 512);
> +	u32 comp_frame_width = ALIGN(ALIGN(frame_width, 16) + 16, 16);
> +	u32 ot_frame_width = ALIGN(comp_frame_width, ot_bg_width);
> +
> +	// sizeof_offset_table()
> +	u32 ot_bg_height = 32;
> +	u32 bgs_height = BIT(14) / bgs_width / ((bit_depth > 8) ? 2 : 1);

Please, no magic BIT(x) usage: add a definition for that bit.

> +	u32 comp_frame_height = ALIGN(ALIGN(frame_height, 4) + 4, bgs_height);
> +	u32 ot_frame_height = ALIGN(comp_frame_height, ot_bg_height);
> +
> +	return (ot_frame_width / 16) * (ot_frame_height / 4) * 2;
> +}
> +

..snip..

> +
> +int wave5_vpu_decode(struct vpu_instance *inst, struct dec_param *option, u32 *fail_res)
> +{
> +	u32 mode_option = DEC_PIC_NORMAL, bs_option, reg_val;
> +	u32 force_latency = 0;
> +	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
> +	struct dec_open_param *p_open_param = &p_dec_info->open_param;
> +	int ret;
> +

switch (option->skipframe_mode) {
case ...
...
default:
	break;
};

if (p_dec_info->thumbnail_mode) {
	mode_option = DEC_PIC_W_THUMBNAIL;
	if (mode_option != DEC_PIC_NORMAL)
		... do something: as I read the code, this is not a supported case.
}

^^^^ this should improve the flow.

> +	if (p_dec_info->thumbnail_mode) {
> +		mode_option = DEC_PIC_W_THUMBNAIL;
> +	} else if (option->skipframe_mode) {
> +		switch (option->skipframe_mode) {
> +		case WAVE_SKIPMODE_NON_IRAP:
> +			mode_option = SKIP_NON_IRAP;
> +			force_latency = 1;
> +			break;
> +		case WAVE_SKIPMODE_NON_REF:
> +			mode_option = SKIP_NON_REF_PIC;
> +			break;
> +		default:
> +			// skip mode off
> +			break;
> +		}
> +	}
> +
> +	// set disable reorder
> +	if (!p_dec_info->reorder_enable)
> +		force_latency = 1;
> +
> +	/* set attributes of bitstream buffer controller */
> +	bs_option = 0;

You don't have to initialize this variable at all, as you're either writing twice
or failing.

> +	switch (p_open_param->bitstream_mode) {
> +	case BS_MODE_INTERRUPT:
> +		bs_option = BSOPTION_ENABLE_EXPLICIT_END;
> +		break;
> +	case BS_MODE_PIC_END:
> +		bs_option = BSOPTION_ENABLE_EXPLICIT_END;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +

..snip..

> +
> +int wave5_vpu_re_init(struct device *dev, u8 *fw, size_t size)
> +{
> +	struct vpu_buf *common_vb;
> +	dma_addr_t code_base, temp_base;
> +	dma_addr_t old_code_base, temp_size;
> +	u32 code_size;
> +	u32 reg_val;
> +	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
> +
> +	common_vb = &vpu_dev->common_mem;
> +
> +	code_base = common_vb->daddr;
> +	/* ALIGN TO 4KB */
> +	code_size = (WAVE5_MAX_CODE_BUF_SIZE & ~0xfff);
> +	if (code_size < size * 2)
> +		return -EINVAL;
> +	temp_base = common_vb->daddr + WAVE5_TEMPBUF_OFFSET;
> +	temp_size = WAVE5_TEMPBUF_SIZE;
> +
> +	old_code_base = vpu_read_reg(vpu_dev, W5_VPU_REMAP_PADDR);
> +
> +	if (old_code_base != code_base + W5_REMAP_INDEX1 * W5_REMAP_MAX_SIZE) {

Put the contents of this branch into another function maybe?

	if (old_code_base != code_base + W5_REMAP_INDEX1 * W5_REMAP_MAX_SIZE) {
		ret = do_that_vpu_init_flow(things);
		if (ret)
			return ret;
	}


	return setup_wave5_properties(dev);
};

Alternatively, invert the conditional and use a goto, but I personally don't
really like using gotos unless it's *totally* necessary.

> +		int ret;
> +		struct dma_vpu_buf *sram_vb;
> +
> +		ret = wave5_vdi_write_memory(vpu_dev, common_vb, 0, fw, size,
> +					     VDI_128BIT_LITTLE_ENDIAN);
> +		if (ret < 0) {
> +			dev_err(vpu_dev->dev,
> +				"VPU init, Writing firmware to common buffer, fail: %d\n", ret);
> +			return ret;
> +		}
> +
> +		vpu_write_reg(vpu_dev, W5_PO_CONF, 0);
> +
> +		ret = wave5_vpu_reset(dev, SW_RESET_ON_BOOT);
> +		if (ret < 0) {
> +			dev_err(vpu_dev->dev, "VPU init, Resetting the VPU, fail: %d\n", ret);
> +			return ret;
> +		}
> +
> +		remap_page(vpu_dev, code_base, W5_REMAP_INDEX0);
> +		remap_page(vpu_dev, code_base, W5_REMAP_INDEX1);
> +
> +		vpu_write_reg(vpu_dev, W5_ADDR_CODE_BASE, code_base);
> +		vpu_write_reg(vpu_dev, W5_CODE_SIZE, code_size);
> +		vpu_write_reg(vpu_dev, W5_CODE_PARAM, (WAVE5_UPPER_PROC_AXI_ID << 4) | 0);
> +		vpu_write_reg(vpu_dev, W5_ADDR_TEMP_BASE, temp_base);
> +		vpu_write_reg(vpu_dev, W5_TEMP_SIZE, temp_size);
> +
> +		vpu_write_reg(vpu_dev, W5_HW_OPTION, 0);
> +
> +		reg_val = (WAVE5_PROC_AXI_EXT_ADDR & 0xFFFF);
> +		wave5_fio_writel(vpu_dev, W5_BACKBONE_PROC_EXT_ADDR, reg_val);
> +		reg_val = ((WAVE5_PROC_AXI_AXPROT & 0x7) << 4) |
> +			(WAVE5_PROC_AXI_AXCACHE & 0xF);
> +		wave5_fio_writel(vpu_dev, W5_BACKBONE_AXI_PARAM, reg_val);
> +		reg_val = ((WAVE5_SEC_AXI_AXPROT & 0x7) << 20) |
> +			((WAVE5_SEC_AXI_AXCACHE & 0xF) << 16) |
> +			(WAVE5_SEC_AXI_EXT_ADDR & 0xFFFF);
> +		vpu_write_reg(vpu_dev, W5_SEC_AXI_PARAM, reg_val);
> +
> +		/* interrupt */
> +		// encoder
> +		reg_val = BIT(INT_WAVE5_ENC_SET_PARAM);
> +		reg_val |= BIT(INT_WAVE5_ENC_PIC);
> +		reg_val |= BIT(INT_WAVE5_BSBUF_FULL);
> +		// decoder
> +		reg_val |= BIT(INT_WAVE5_INIT_SEQ);
> +		reg_val |= BIT(INT_WAVE5_DEC_PIC);
> +		reg_val |= BIT(INT_WAVE5_BSBUF_EMPTY);
> +		vpu_write_reg(vpu_dev, W5_VPU_VINT_ENABLE, reg_val);
> +
> +		reg_val = vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG0);
> +		if ((reg_val >> 16) & 1) {
> +			reg_val = ((WAVE5_PROC_AXI_ID << 28) |
> +					(WAVE5_PRP_AXI_ID << 24) |
> +					(WAVE5_FBD_Y_AXI_ID << 20) |
> +					(WAVE5_FBC_Y_AXI_ID << 16) |
> +					(WAVE5_FBD_C_AXI_ID << 12) |
> +					(WAVE5_FBC_C_AXI_ID << 8) |
> +					(WAVE5_PRI_AXI_ID << 4) |
> +					WAVE5_SEC_AXI_ID);
> +			wave5_fio_writel(vpu_dev, W5_BACKBONE_PROG_AXI_ID, reg_val);
> +		}
> +
> +		sram_vb = &vpu_dev->sram_buf;
> +
> +		vpu_write_reg(vpu_dev, W5_ADDR_SEC_AXI, sram_vb->daddr);
> +		vpu_write_reg(vpu_dev, W5_SEC_AXI_SIZE, sram_vb->size);
> +		vpu_write_reg(vpu_dev, W5_VPU_BUSY_STATUS, 1);
> +		vpu_write_reg(vpu_dev, W5_COMMAND, W5_INIT_VPU);
> +		vpu_write_reg(vpu_dev, W5_VPU_REMAP_CORE_START, 1);
> +
> +		ret = wave5_wait_vpu_busy(vpu_dev, W5_VPU_BUSY_STATUS);
> +		if (ret) {
> +			dev_err(vpu_dev->dev, "VPU reinit(W5_VPU_REMAP_CORE_START) timeout\n");
> +			return ret;
> +		}
> +
> +		reg_val = vpu_read_reg(vpu_dev, W5_RET_SUCCESS);
> +		if (!reg_val) {
> +			u32 reason_code = vpu_read_reg(vpu_dev, W5_RET_FAIL_REASON);
> +
> +			wave5_print_reg_err(vpu_dev, reason_code);
> +			return -EIO;
> +		}
> +	}
> +
> +	return setup_wave5_properties(dev);
> +}
> +

..snip..

> +
> +int wave5_vpu_reset(struct device *dev, enum sw_reset_mode reset_mode)
> +{
> +	u32 val = 0;
> +	int ret = 0;
> +	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
> +	struct vpu_attr *p_attr = &vpu_dev->attr;
> +	// VPU doesn't send response. force to set BUSY flag to 0.
> +	vpu_write_reg(vpu_dev, W5_VPU_BUSY_STATUS, 0);
> +
> +	if (reset_mode == SW_RESET_SAFETY) {
> +		ret = wave5_vpu_sleep_wake(dev, true, NULL, 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	val = vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG0);
> +	if ((val >> 16) & 0x1)
> +		p_attr->support_backbone = true;

bitfield macros ftw.

> +	if ((val >> 22) & 0x1)
> +		p_attr->support_vcore_backbone = true;
> +	if ((val >> 28) & 0x1)
> +		p_attr->support_vcpu_backbone = true;
> +
> +	val = vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG1);
> +	if ((val >> 26) & 0x1)
> +		p_attr->support_dual_core = true;
> +


..snip..

> +static void wave5_set_enc_crop_info(u32 codec, struct enc_wave_param *param, int rot_mode,
> +				    int src_width, int src_height)
> +{
> +	int aligned_width = (codec == W_HEVC_ENC) ? ALIGN(src_width, 32) : ALIGN(src_width, 16);
> +	int aligned_height = (codec == W_HEVC_ENC) ? ALIGN(src_height, 32) : ALIGN(src_height, 16);
> +	int pad_right, pad_bot;
> +	int crop_right, crop_left, crop_top, crop_bot;
> +	int prp_mode = rot_mode >> 1; // remove prp_enable bit
> +
> +	if (codec == W_HEVC_ENC &&
> +	    (!rot_mode || prp_mode == 14)) // prp_mode 14 : hor_mir && ver_mir && rot_180
> +		return;
> +
> +	pad_right = aligned_width - src_width;
> +	pad_bot = aligned_height - src_height;
> +
> +	if (param->conf_win_right > 0)
> +		crop_right = param->conf_win_right + pad_right;
> +	else
> +		crop_right = pad_right;
> +
> +	if (param->conf_win_bot > 0)
> +		crop_bot = param->conf_win_bot + pad_bot;
> +	else
> +		crop_bot = pad_bot;
> +
> +	crop_top = param->conf_win_top;
> +	crop_left = param->conf_win_left;
> +
> +	param->conf_win_top = crop_top;
> +	param->conf_win_left = crop_left;
> +	param->conf_win_bot = crop_bot;
> +	param->conf_win_right = crop_right;
> +
> +	if (prp_mode == 1 || prp_mode == 15) {

#define PRP_MODE_SOMETHING 1
#define PRP_MODE_SOMETHING_ELSE 2

or use an enumeration... otherwise it's not really understandable...

> +		param->conf_win_top = crop_right;
> +		param->conf_win_left = crop_top;
> +		param->conf_win_bot = crop_left;
> +		param->conf_win_right = crop_bot;
> +	} else if (prp_mode == 2 || prp_mode == 12) {
> +		param->conf_win_top = crop_bot;
> +		param->conf_win_left = crop_right;
> +		param->conf_win_bot = crop_top;
> +		param->conf_win_right = crop_left;
> +	} else if (prp_mode == 3 || prp_mode == 13) {
> +		param->conf_win_top = crop_left;
> +		param->conf_win_left = crop_bot;
> +		param->conf_win_bot = crop_right;
> +		param->conf_win_right = crop_top;
> +	} else if (prp_mode == 4 || prp_mode == 10) {
> +		param->conf_win_top = crop_bot;
> +		param->conf_win_bot = crop_top;
> +	} else if (prp_mode == 8 || prp_mode == 6) {
> +		param->conf_win_left = crop_right;
> +		param->conf_win_right = crop_left;
> +	} else if (prp_mode == 5 || prp_mode == 11) {
> +		param->conf_win_top = crop_left;
> +		param->conf_win_left = crop_top;
> +		param->conf_win_bot = crop_right;
> +		param->conf_win_right = crop_bot;
> +	} else if (prp_mode == 7 || prp_mode == 9) {
> +		param->conf_win_top = crop_right;
> +		param->conf_win_left = crop_bot;
> +		param->conf_win_bot = crop_left;
> +		param->conf_win_right = crop_top;
> +	}
> +}
> +
> +int wave5_vpu_enc_init_seq(struct vpu_instance *inst)
> +{
> +	u32 reg_val = 0, rot_mir_mode, fixed_cu_size_mode = 0x7;
> +	struct enc_info *p_enc_info = &inst->codec_info->enc_info;
> +	struct enc_open_param *p_open_param = &p_enc_info->open_param;
> +	struct enc_wave_param *p_param = &p_open_param->wave_param;
> +	int ret;
> +
> +	if (inst->dev->product != PRODUCT_ID_521)
> +		return -EINVAL;
> +
> +	/*==============================================*/
> +	/* OPT_CUSTOM_GOP */
> +	/*==============================================*/

Comments like these are usually like

	/*
	 * OPT_CUSTOM_GOP
	 *
	 * SET_PARAM + CUSTOM_GOP
	 * only when... blah
	 */

> +	/*
> +	 * SET_PARAM + CUSTOM_GOP
> +	 * only when gop_preset_idx == custom_gop, custom_gop related registers should be set
> +	 */

..snip..

> +}
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> new file mode 100644
> index 000000000000..1b3ffb737925
> --- /dev/null
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
> @@ -0,0 +1,1136 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
> +/*
> + * Wave5 series multi-standard codec IP - helper definitions
> + *
> + * Copyright (C) 2021 CHIPS&MEDIA INC
> + */
> +
> +#ifndef VPUAPI_H_INCLUDED
> +#define VPUAPI_H_INCLUDED
> +
> +#include <linux/kfifo.h>
> +#include <linux/idr.h>
> +#include <media/v4l2-device.h>
> +#include <media/v4l2-mem2mem.h>
> +#include <media/v4l2-ctrls.h>
> +#include "wave5-vpuerror.h"
> +#include "wave5-vpuconfig.h"
> +#include "wave5-vdi.h"
> +
> +enum product_id {
> +	PRODUCT_ID_521,
> +	PRODUCT_ID_511,
> +	PRODUCT_ID_517,
> +	PRODUCT_ID_NONE,
> +};
> +
> +struct vpu_attr;
> +
> +enum vpu_instance_type {
> +	VPU_INST_TYPE_DEC = 0,

The default for the first enum entry is always zero, and the next one will always
be 1, 2, 3, 4.....

.....so you don't need to assign any number.

> +	VPU_INST_TYPE_ENC = 1
> +};
> +
> +enum vpu_instance_state {
> +	VPU_INST_STATE_NONE = 0,
> +	VPU_INST_STATE_OPEN = 1,
> +	VPU_INST_STATE_INIT_SEQ = 2,
> +	VPU_INST_STATE_PIC_RUN = 3,
> +	VPU_INST_STATE_STOP = 4

ditto

> +};
> +
> +#define WAVE5_MAX_FBS 32
> +
> +#define MAX_REG_FRAME (WAVE5_MAX_FBS * 2)
> +
> +#define WAVE5_DEC_HEVC_BUF_SIZE(_w, _h) (DIV_ROUND_UP(_w, 64) * DIV_ROUND_UP(_h, 64) * 256 + 64)
> +#define WAVE5_DEC_AVC_BUF_SIZE(_w, _h) ((((ALIGN(_w, 256) / 16) * (ALIGN(_h, 16) / 16)) + 16) * 80)
> +#define WAVE5_DEC_VP9_BUF_SIZE(_w, _h) (((ALIGN(_w, 64) * ALIGN(_h, 64)) >> 2))
> +#define WAVE5_DEC_AVS2_BUF_SIZE(_w, _h) (((ALIGN(_w, 64) * ALIGN(_h, 64)) >> 5))
> +// AV1 BUF SIZE : MFMV + segment ID + CDF probs table + film grain param Y+ film graim param C
> +#define WAVE5_DEC_AV1_BUF_SZ_1(_w, _h)	\
> +	(((ALIGN(_w, 64) / 64) * (ALIGN(_h, 64) / 64) * 512) + 41984 + 8192 + 4864)
> +#define WAVE5_DEC_AV1_BUF_SZ_2(_w1, _w2, _h)	\
> +	(((ALIGN(_w1, 64) / 64) * 256 + (ALIGN(_w2, 256) / 64) * 128) * (ALIGN(_h, 64) / 64))
> +
> +#define WAVE5_FBC_LUMA_TABLE_SIZE(_w, _h) (ALIGN(_h, 64) * ALIGN(_w, 256) / 32)
> +#define WAVE5_FBC_CHROMA_TABLE_SIZE(_w, _h) (ALIGN((_h), 64) * ALIGN((_w) / 2, 256) / 32)
> +#define WAVE5_ENC_AVC_BUF_SIZE(_w, _h) (ALIGN(_w, 64) * ALIGN(_h, 64) / 32)
> +#define WAVE5_ENC_HEVC_BUF_SIZE(_w, _h) (ALIGN(_w, 64) / 64 * ALIGN(_h, 64) / 64 * 128)
> +
> +/*
> + * common struct and definition
> + */
> +enum cod_std {
> +	STD_AVC = 0,
> +	STD_VC1 = 1,
> +	STD_MPEG2 = 2,
> +	STD_MPEG4 = 3,
> +	STD_H263 = 4,
> +	STD_DIV3 = 5,
> +	STD_RV = 6,
> +	STD_AVS = 7,

and same here, so that becomes

	.....
	STD_AVS,
	STD_RESERVED,
	STD_THO,


> +	STD_THO = 9 > +	STD_VP3 = 10,
> +	STD_VP8 = 11,
> +	STD_HEVC = 12,
> +	STD_VP9 = 13,
> +	STD_AVS2 = 14,

STD_RESERVED2, (which will be 15)...

> +	STD_AV1 = 16,
> +	STD_MAX
> +};
> +
> +enum wave_std {
> +	W_HEVC_DEC = 0x00,
> +	W_HEVC_ENC = 0x01,
> +	W_AVC_DEC = 0x02,
> +	W_AVC_ENC = 0x03,
> +	W_VP9_DEC = 0x16,
> +	W_AVS2_DEC = 0x18,
> +	W_AV1_DEC = 0x1A,
> +	STD_UNKNOWN = 0xFF
> +};
> +
> +enum SET_PARAM_OPTION {

Lowercase names for enums please.

> +	OPT_COMMON = 0, /* SET_PARAM command option for encoding sequence */
> +	OPT_CUSTOM_GOP = 1, /* SET_PARAM command option for setting custom GOP */
> +	OPT_CUSTOM_HEADER = 2, /* SET_PARAM command option for setting custom VPS/SPS/PPS */
> +	OPT_VUI = 3, /* SET_PARAM command option for encoding VUI */
> +	OPT_CHANGE_PARAM = 0x10,
> +};
> +
> +enum DEC_PIC_HDR_OPTION {
> +	INIT_SEQ_NORMAL = 0x01,
> +	INIT_SEQ_W_THUMBNAIL = 0x11,
> +};
> +
> +enum DEC_PIC_OPTION {
> +	DEC_PIC_NORMAL = 0x00, /* it is normal mode of DEC_PIC command */
> +	DEC_PIC_W_THUMBNAIL = 0x10, /* thumbnail mode (skip non-IRAP without reference reg) */
> +	SKIP_NON_IRAP = 0x11, /* it skips to decode non-IRAP pictures */
> +	SKIP_NON_REF_PIC = 0x13
> +};
> +


There's probably more, but starting with that is surely something :-)


Regards,
Angelo

