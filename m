Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F243615032
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiKARM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiKARMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:12:24 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB48120B9;
        Tue,  1 Nov 2022 10:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667322738; x=1698858738;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=M09uUlH96GjQ2gzcBJrukqbZG7NTFZEvbSgZORtWBEw=;
  b=W45Kcw7wucYs+3X3p7cfZa5svDg/L9h/Lhsf1KauSGrsmzK8LwLxtj3G
   3ozQ8QLJ3TmFJ9tFgogQ3m0nIAsab9psa7W7AyWg7KoNmXaalFW5W2GYs
   jH/Tob0YP3Pm/aUEBKvnj6er324yQwQy5iygOjuVVygpx1vI0aQ+SdlAM
   HEFA1s89eqvKkS0SnJNbg7q7jzVmKFT+Q4NI/PWqzriE70ysA5tSY64Bh
   2ryl4FBuIs0lKbqreA2Dmi4R9QlFJOgPVm4H90jY06QWfn6KNlNeePiBx
   kfa3Io1395KU8QFW1cEO+M0rKn0sWJyVXy3wb209WuQ8pXsTUI5zvQCLk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="371272971"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="371272971"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:12:18 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="723228446"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="723228446"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.55.64])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:12:14 -0700
Message-ID: <b4796054-bcb3-2775-37ce-86826caade78@intel.com>
Date:   Tue, 1 Nov 2022 19:12:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V5 05/26] mmc: core: Add definitions for SD UHS-II cards
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Jason Lai <jason.lai@genesyslogic.com.tw>
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
 <20221019110647.11076-6-victor.shih@genesyslogic.com.tw>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221019110647.11076-6-victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/22 14:06, Victor Shih wrote:
> Add UHS-II specific data structures for commands and defines for
> registers, as described in Part 1 UHS-II Addendum Version 1.01.
> 
> UHS-II related definitions are listed below:
>   1. UHS-II card capability: sd_uhs2_caps{}
>   2. UHS-II configuration: sd_uhs2_config{}
>   3. UHS-II Command structure: uhs2_command{}
>   4. UHS-II register I/O address and register field definitions: sd_uhs2.h
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
> 
> Updates in V5:
>  - Added UHS2 interfaces in mmc_host_ops: host.h
>  - Added UHS2 VDD2 power supply in mmc_supply: host.h
>  - Added UHS2-specific OCR and UHS2 VDD2 max current in mmc_host: host.h
>  - Added definition of UHS2 VDD2 1.65v-1.95v in mmc_host: host.h
>  - Added flags/MMC_UHS2_SUPPORT/MMC_UHS2_2L_HD in mmc_host: host.h
> ---
>  include/linux/mmc/card.h    |  42 +++++-
>  include/linux/mmc/core.h    |  13 ++
>  include/linux/mmc/host.h    |  70 +++++++++-
>  include/linux/mmc/sd_uhs2.h | 263 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 386 insertions(+), 2 deletions(-)
>  create mode 100644 include/linux/mmc/sd_uhs2.h
> 
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 4a42f31b7bb0..d638a2c689cf 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -190,6 +190,13 @@ struct sd_switch_caps {
>  #define SD_MAX_CURRENT_400	(1 << SD_SET_CURRENT_LIMIT_400)
>  #define SD_MAX_CURRENT_600	(1 << SD_SET_CURRENT_LIMIT_600)
>  #define SD_MAX_CURRENT_800	(1 << SD_SET_CURRENT_LIMIT_800)
> +	unsigned int		sd4_curr_limit;
> +#define SD4_SET_POWER_LIMIT_0_72W	0
> +#define SD4_SET_POWER_LIMIT_1_44W	1
> +#define SD4_SET_POWER_LIMIT_2_16W	2
> +#define SD4_SET_POWER_LIMIT_2_88W	3
> +#define SD4_SET_POWER_LIMIT_1_80W	4
> +#define SD4_SET_POWER_NO_CHANGE		(-1)
>  };
>  
>  struct sd_ext_reg {
> @@ -213,7 +220,35 @@ struct sd_ext_reg {
>  
>  struct sd_uhs2_config {
>  	u32			node_id;
> -	/* TODO: Extend with more register configs. */
> +
> +	u32			dap;
> +	u32			gap;
> +	u32			n_fcu;
> +	u32			maxblk_len;
> +	u8			n_lanes;
> +	u8			dadr_len;
> +	u8			app_type;
> +	u8			phy_minor_rev;
> +	u8			phy_major_rev;
> +	u8			can_hibernate;
> +	u8			n_lss_sync;
> +	u8			n_lss_dir;
> +	u8			link_minor_rev;
> +	u8			link_major_rev;
> +	u8			dev_type;
> +	u8			n_data_gap;
> +
> +	u32			n_fcu_set;
> +	u32			maxblk_len_set;
> +	u8			n_lanes_set;
> +	u8			speed_range_set;
> +	u8			n_lss_sync_set;
> +	u8			n_lss_dir_set;
> +	u8			n_data_gap_set;
> +	u8			pwrctrl_mode_set;
> +	u8			max_retry_set;
> +
> +	u8			cfg_complete;
>  };
>  
>  struct sdio_cccr {
> @@ -323,6 +358,9 @@ struct mmc_card {
>  	struct sd_ext_reg	ext_perf;	/* SD extension reg for PERF */
>  
>  	struct sd_uhs2_config	uhs2_config;	/* SD UHS-II config */
> +	u8			uhs2_state;	/* SD UHS-II states */
> +#define MMC_UHS2_INITIALIZED	BIT(1)
> +#define MMC_UHS2_SPEED_B	BIT(2)
>  
>  	unsigned int		sdio_funcs;	/* number of SDIO functions */
>  	atomic_t		sdio_funcs_probed; /* number of probed SDIO funcs */
> @@ -364,4 +402,6 @@ bool mmc_card_is_blockaddr(struct mmc_card *card);
>  #define mmc_card_sdio(c)	((c)->type == MMC_TYPE_SDIO)
>  #define mmc_card_sd_combo(c)	((c)->type == MMC_TYPE_SD_COMBO)
>  
> +#define mmc_card_can_poweroff_notify(c)	((c)->ext_power.feature_support & SD_EXT_POWER_OFF_NOTIFY)
> +
>  #endif /* LINUX_MMC_CARD_H */
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 6efec0b9820c..2a0581d87706 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -23,6 +23,14 @@ enum mmc_blk_status {
>  	MMC_BLK_NEW_REQUEST,
>  };
>  
> +struct uhs2_command {
> +	u16	header;
> +	u16	arg;
> +	__be32	*payload;
> +	u32	payload_len;
> +	u32	packet_len;
> +};
> +
>  struct mmc_command {
>  	u32			opcode;
>  	u32			arg;
> @@ -109,6 +117,11 @@ struct mmc_command {
>  	unsigned int		busy_timeout;	/* busy detect timeout in ms */
>  	struct mmc_data		*data;		/* data segment associated with cmd */
>  	struct mmc_request	*mrq;		/* associated request */
> +
> +	struct uhs2_command	*uhs2_cmd;	/* UHS2 command */
> +	u8			*uhs2_resp;	/* UHS2 native cmd resp */
> +	u8			uhs2_resp_len;	/* UHS2 native cmd resp len */
> +	u8			uhs2_tmode0_flag; /* UHS2 transfer mode flag */
>  };
>  
>  struct mmc_data {
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 895bcf7f80b7..249a9414ad10 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -16,6 +16,7 @@
>  #include <linux/mmc/pm.h>
>  #include <linux/dma-direction.h>
>  #include <linux/blk-crypto-profile.h>
> +#include <linux/mmc/sd_uhs2.h>
>  
>  struct mmc_ios {
>  	unsigned int	clock;			/* clock rate */
> @@ -96,7 +97,48 @@ struct mmc_clk_phase_map {
>  };
>  
>  struct sd_uhs2_caps {
> -	/* TODO: Add UHS-II capabilities for the host. */
> +	u32	dap;
> +	u32	gap;
> +	u32	group_desc;
> +	u32	maxblk_len;
> +	u32	n_fcu;
> +	u8	n_lanes;
> +	u8	addr64;
> +	u8	card_type;
> +	u8	phy_rev;
> +	u8	speed_range;
> +	u8	can_hibernate;
> +	u8	n_lss_sync;
> +	u8	n_lss_dir;
> +	u8	link_rev;
> +	u8	host_type;
> +	u8	n_data_gap;
> +
> +	u32	maxblk_len_set;
> +	u32	n_fcu_set;
> +	u8	n_lanes_set;
> +	u8	n_lss_sync_set;
> +	u8	n_lss_dir_set;
> +	u8	n_data_gap_set;
> +	u8	max_retry_set;
> +};
> +
> +struct sd_uhs2_ios {
> +	bool		is_2L_HD_mode;
> +	bool		is_APP_CMD;
> +	unsigned int	power_delay_ms;		/* waiting for stable power */
> +};
> +
> +enum sd_uhs2_operation {
> +	UHS2_PHY_INIT = 0,
> +	UHS2_SET_CONFIG,
> +	UHS2_ENABLE_INT,
> +	UHS2_DISABLE_INT,
> +	UHS2_ENABLE_CLK,
> +	UHS2_DISABLE_CLK,
> +	UHS2_CHECK_DORMANT,
> +	UHS2_SET_SPEED_B,
> +	UHS2_POST_ATTACH_SD,
>  };
>  
>  struct mmc_host;
> @@ -231,6 +273,20 @@ struct mmc_host_ops {
>  
>  	/* Initialize an SD express card, mandatory for MMC_CAP2_SD_EXP. */
>  	int	(*init_sd_express)(struct mmc_host *host, struct mmc_ios *ios);
> +
> +	/* UHS2 interfaces */
> +	int	(*uhs2_detect_init)(struct mmc_host *host);

Never called?

> +	int	(*uhs2_set_reg)(struct mmc_host *host, enum sd_uhs2_operation act);

Never called?

> +	int (*uhs2_disable_clk)(struct mmc_host *host);

Never called?

> +	int (*uhs2_enable_clk)(struct mmc_host *host);

Never called?

> +
> +	/*
> +	 * The uhs2_control callback is used to execute SD UHS-II specific
> +	 * operations. It's mandatory to implement for hosts that supports the
> +	 * SD UHS-II interface (MMC_CAP2_SD_UHS2). Expected return values are a
> +	 * negative errno in case of a failure or zero for success.
> +	 */
> +	int	(*uhs2_control)(struct mmc_host *host, enum sd_uhs2_operation op);
>  };
>  
>  struct mmc_cqe_ops {
> @@ -323,6 +379,7 @@ struct mmc_pwrseq;
>  
>  struct mmc_supply {
>  	struct regulator *vmmc;		/* Card power supply */
> +	struct regulator *vmmc2;	/* UHS2 VDD2 power supply */
>  	struct regulator *vqmmc;	/* Optional Vccq supply */
>  	struct regulator *vqmmc2;	/* Optional supply for phy */
>  };
> @@ -344,10 +401,12 @@ struct mmc_host {
>  	u32			ocr_avail_sdio;	/* SDIO-specific OCR */
>  	u32			ocr_avail_sd;	/* SD-specific OCR */
>  	u32			ocr_avail_mmc;	/* MMC-specific OCR */
> +	u32			ocr_avail_uhs2; /* UHS2-specific OCR */
>  	struct wakeup_source	*ws;		/* Enable consume of uevents */
>  	u32			max_current_330;
>  	u32			max_current_300;
>  	u32			max_current_180;
> +	u32			max_current_180_vdd2; /* UHS2 vdd2 max curt. */
>  
>  #define MMC_VDD_165_195		0x00000080	/* VDD voltage 1.65 - 1.95 */
>  #define MMC_VDD_20_21		0x00000100	/* VDD voltage 2.0 ~ 2.1 */
> @@ -366,6 +425,7 @@ struct mmc_host {
>  #define MMC_VDD_33_34		0x00200000	/* VDD voltage 3.3 ~ 3.4 */
>  #define MMC_VDD_34_35		0x00400000	/* VDD voltage 3.4 ~ 3.5 */
>  #define MMC_VDD_35_36		0x00800000	/* VDD voltage 3.5 ~ 3.6 */
> +#define MMC_VDD2_165_195	0x00000080	/* UHS2 VDD2 1.65 ~ 1.95 */
>  
>  	u32			caps;		/* Host capabilities */
>  
> @@ -443,7 +503,12 @@ struct mmc_host {
>  #endif
>  #define MMC_CAP2_ALT_GPT_TEGRA	(1 << 28)	/* Host with eMMC that has GPT entry at a non-standard location */
>  
> +	int flags;
> +#define MMC_UHS2_SUPPORT	(1 << 0)

MMC_UHS2_SUPPORT is getting mixed up with MMC_UHS2_INITIALIZED.
Both have the same value, but MMC_UHS2_SUPPORT is for
host->flags and MMC_UHS2_INITIALIZED is for card->uhs2_state

Please use the correct flag with the correct variable.

> +#define MMC_UHS2_2L_HD		(1 << 2)

MMC_UHS2_2L_HD does not seem to be used. Is it needed?

> +
>  	struct sd_uhs2_caps	uhs2_caps;	/* Host UHS-II capabilities */
> +	struct sd_uhs2_ios	uhs2_ios;	/* Host UHS-II capabilities */
>  
>  	int			fixed_drv_type;	/* fixed driver type for non-removable media */
>  
> @@ -695,4 +760,7 @@ int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
>  int mmc_send_abort_tuning(struct mmc_host *host, u32 opcode);
>  int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
>  
> +#define mmc_uhs2_2L_HD_mode(h)	((h)->uhs2_ios.is_2L_HD_mode)
> +#define mmc_uhs2_APP_cmd(h)	((h)->uhs2_ios.is_APP_CMD)
> +
>  #endif /* LINUX_MMC_HOST_H */
> diff --git a/include/linux/mmc/sd_uhs2.h b/include/linux/mmc/sd_uhs2.h
> new file mode 100644
> index 000000000000..8fcf702cf4a5
> --- /dev/null
> +++ b/include/linux/mmc/sd_uhs2.h
> @@ -0,0 +1,263 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Header file for UHS-II packets, Host Controller registers and I/O
> + * accessors.
> + *
> + *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
> + */
> +#ifndef LINUX_MMC_UHS2_H
> +#define LINUX_MMC_UHS2_H
> +
> +/* LINK Layer definition */
> +/*
> + * UHS2 Header:
> + * Refer to UHS-II Addendum Version 1.02 Figure 5-2, the format of CCMD Header is described below:
> + *      bit [3:0]  : DID(Destination ID = Node ID of UHS2 card)
> + *      bit [6:4]  : TYP(Packet Type)
> + *                   000b: CCMD(Control command packet)
> + *                   001b: DCMD(Data command packet)
> + *                   010b: RES(Response packet)
> + *                   011b: DATA(Data payload packet)
> + *                   111b: MSG(Message packet)
> + *                   Others: Reserved
> + *      bit [7]    : NP(Native Packet)
> + *      bit [10:8] : TID(Transaction ID)
> + *      bit [11]   : Reserved
> + *      bit [15:12]: SID(Source ID 0: Node ID of Host)
> + *
> + * Broadcast CCMD issued by Host is represented as DID=SID=0.
> + */
> +/*
> + * UHS2 Argument:
> + * Refer to UHS-II Addendum Version 1.02 Figure 6-5, the format of CCMD Argument is described below:
> + *      bit [3:0]  : MSB of IOADR
> + *      bit [5:4]  : PLEN(Payload Length)
> + *                   00b: 0 byte
> + *                   01b: 4 bytes
> + *                   10b: 8 bytes
> + *                   11b: 16 bytes
> + *      bit [6]    : Reserved
> + *      bit [7]    : R/W(Read/Write)
> + *                   0: Control read command
> + *                   1: Control write command
> + *      bit [15:8] : LSB of IOADR
> + *
> + * I/O Address specifies the address of register in UHS-II I/O space accessed by CCMD.
> + * The unit of I/O Address is 4 Bytes. It is transmitted in MSB first, LSB last.
> + */
> +#define UHS2_NATIVE_PACKET_POS	7
> +#define UHS2_NATIVE_PACKET	(1 << UHS2_NATIVE_PACKET_POS)
> +
> +#define UHS2_PACKET_TYPE_POS	4
> +#define UHS2_PACKET_TYPE_CCMD	(0 << UHS2_PACKET_TYPE_POS)
> +#define UHS2_PACKET_TYPE_DCMD	(1 << UHS2_PACKET_TYPE_POS)
> +#define UHS2_PACKET_TYPE_RES	(2 << UHS2_PACKET_TYPE_POS)
> +#define UHS2_PACKET_TYPE_DATA	(3 << UHS2_PACKET_TYPE_POS)
> +#define UHS2_PACKET_TYPE_MSG	(7 << UHS2_PACKET_TYPE_POS)
> +
> +#define UHS2_DEST_ID_MASK	0x0F
> +#define UHS2_DEST_ID		0x1
> +
> +#define UHS2_SRC_ID_POS		12
> +#define UHS2_SRC_ID_MASK	0xF000
> +
> +#define UHS2_TRANS_ID_POS	8
> +#define UHS2_TRANS_ID_MASK	0x0700
> +
> +/* UHS2 MSG */
> +#define UHS2_MSG_CTG_POS	5
> +#define UHS2_MSG_CTG_LMSG	0x00
> +#define UHS2_MSG_CTG_INT	0x60
> +#define UHS2_MSG_CTG_AMSG	0x80
> +
> +#define UHS2_MSG_CTG_FCREQ	0x00
> +#define UHS2_MSG_CTG_FCRDY	0x01
> +#define UHS2_MSG_CTG_STAT	0x02
> +
> +#define UHS2_MSG_CODE_POS			8
> +#define UHS2_MSG_CODE_FC_UNRECOVER_ERR		0x8
> +#define UHS2_MSG_CODE_STAT_UNRECOVER_ERR	0x8
> +#define UHS2_MSG_CODE_STAT_RECOVER_ERR		0x1
> +
> +/* TRANS Layer definition */
> +
> +/* Native packets*/
> +#define UHS2_NATIVE_CMD_RW_POS	7
> +#define UHS2_NATIVE_CMD_WRITE	(1 << UHS2_NATIVE_CMD_RW_POS)
> +#define UHS2_NATIVE_CMD_READ	(0 << UHS2_NATIVE_CMD_RW_POS)
> +
> +#define UHS2_NATIVE_CMD_PLEN_POS	4
> +#define UHS2_NATIVE_CMD_PLEN_4B		(1 << UHS2_NATIVE_CMD_PLEN_POS)
> +#define UHS2_NATIVE_CMD_PLEN_8B		(2 << UHS2_NATIVE_CMD_PLEN_POS)
> +#define UHS2_NATIVE_CMD_PLEN_16B	(3 << UHS2_NATIVE_CMD_PLEN_POS)
> +
> +#define UHS2_NATIVE_CCMD_GET_MIOADR_MASK	0xF00
> +#define UHS2_NATIVE_CCMD_MIOADR_MASK		0x0F
> +
> +#define UHS2_NATIVE_CCMD_LIOADR_POS		8
> +#define UHS2_NATIVE_CCMD_GET_LIOADR_MASK	0x0FF
> +
> +#define UHS2_CCMD_DEV_INIT_COMPLETE_FLAG	BIT(11)
> +#define UHS2_DEV_INIT_PAYLOAD_LEN		1
> +#define UHS2_DEV_INIT_RESP_LEN			6
> +#define UHS2_DEV_ENUM_PAYLOAD_LEN		1
> +#define UHS2_DEV_ENUM_RESP_LEN			8
> +#define UHS2_CFG_WRITE_PAYLOAD_LEN		2
> +#define UHS2_CFG_WRITE_PHY_SET_RESP_LEN		4
> +#define UHS2_CFG_WRITE_GENERIC_SET_RESP_LEN	5
> +#define UHS2_GO_DORMANT_PAYLOAD_LEN		1
> +
> +/*
> + * UHS2 Argument:
> + * Refer to UHS-II Addendum Version 1.02 Figure 6-8, the format of DCMD Argument is described below:
> + *      bit [3:0]  : Reserved
> + *      bit [6:3]  : TMODE(Transfer Mode)
> + *                   bit 3: DAM(Data Access Mode)
> + *                   bit 4: TLUM(TLEN Unit Mode)
> + *                   bit 5: LM(Length Mode)
> + *                   bit 6: DM(Duplex Mode)
> + *      bit [7]    : R/W(Read/Write)
> + *                   0: Control read command
> + *                   1: Control write command
> + *      bit [15:8] : Reserved
> + *
> + * I/O Address specifies the address of register in UHS-II I/O space accessed by CCMD.
> + * The unit of I/O Address is 4 Bytes. It is transmitted in MSB first, LSB last.
> + */
> +#define UHS2_DCMD_DM_POS		6
> +#define UHS2_DCMD_2L_HD_MODE		(1 << UHS2_DCMD_DM_POS)
> +#define UHS2_DCMD_LM_POS		5
> +#define UHS2_DCMD_LM_TLEN_EXIST		(1 << UHS2_DCMD_LM_POS)
> +#define UHS2_DCMD_TLUM_POS		4
> +#define UHS2_DCMD_TLUM_BYTE_MODE	(1 << UHS2_DCMD_TLUM_POS)
> +#define UHS2_NATIVE_DCMD_DAM_POS	3
> +#define UHS2_NATIVE_DCMD_DAM_IO		(1 << UHS2_NATIVE_DCMD_DAM_POS)
> +
> +/*
> + * Per UHS2 spec, DCMD payload should be MSB first. There may be
> + * two types of data be assembled to MSB:
> + * 1. TLEN: Input block size for single read/write and number of blocks
> + * for multiple read/write to calculate TLEN as MSB first per spec.
> + * 2. SD command argument.
> + */
> +static inline __be32 uhs2_dcmd_convert_msb(u32 input)
> +{
> +	u32 ret = 0;
> +
> +	ret = ((input & 0xFF) << 24) |
> +		(((input >> 8) & 0xFF) << 16) |
> +		(((input >> 16) & 0xFF) << 8) |
> +		((input >> 24) & 0xFF);
> +	return cpu_to_be32(ret);
> +}
> +
> +#define UHS2_RES_NACK_POS	7
> +#define UHS2_RES_NACK_MASK	(0x1 << UHS2_RES_NACK_POS)
> +
> +#define UHS2_RES_ECODE_POS	4
> +#define UHS2_RES_ECODE_MASK	0x7
> +#define UHS2_RES_ECODE_COND	1
> +#define UHS2_RES_ECODE_ARG	2
> +#define UHS2_RES_ECODE_GEN	3
> +
> +/* IOADR of device registers */
> +#define UHS2_IOADR_GENERIC_CAPS		0x00
> +#define UHS2_IOADR_PHY_CAPS		0x02
> +#define UHS2_IOADR_LINK_CAPS		0x04
> +#define UHS2_IOADR_RSV_CAPS		0x06
> +#define UHS2_IOADR_GENERIC_SETTINGS	0x08
> +#define UHS2_IOADR_PHY_SETTINGS		0x0A
> +#define UHS2_IOADR_LINK_SETTINGS	0x0C
> +#define UHS2_IOADR_PRESET		0x40
> +
> +/* SD application packets */
> +#define UHS2_SD_CMD_INDEX_POS	8
> +
> +#define UHS2_SD_CMD_APP_POS	14
> +#define UHS2_SD_CMD_APP		(1 << UHS2_SD_CMD_APP_POS)
> +
> +/* UHS-II Device Registers */
> +#define UHS2_DEV_CONFIG_REG	0x000
> +
> +/* General Caps and Settings registers */
> +#define UHS2_DEV_CONFIG_GEN_CAPS	(UHS2_DEV_CONFIG_REG + 0x000)
> +#define UHS2_DEV_CONFIG_N_LANES_POS	8
> +#define UHS2_DEV_CONFIG_N_LANES_MASK	0x3F
> +#define UHS2_DEV_CONFIG_2L_HD_FD	0x1
> +#define UHS2_DEV_CONFIG_2D1U_FD		0x2
> +#define UHS2_DEV_CONFIG_1D2U_FD		0x4
> +#define UHS2_DEV_CONFIG_2D2U_FD		0x8
> +#define UHS2_DEV_CONFIG_DADR_POS	14
> +#define UHS2_DEV_CONFIG_DADR_MASK	0x1
> +#define UHS2_DEV_CONFIG_APP_POS		16
> +#define UHS2_DEV_CONFIG_APP_MASK	0xFF
> +#define UHS2_DEV_CONFIG_APP_SD_MEM	0x1
> +
> +#define UHS2_DEV_CONFIG_GEN_SET			(UHS2_DEV_CONFIG_REG + 0x008)
> +#define UHS2_DEV_CONFIG_GEN_SET_N_LANES_POS	8
> +#define UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD	0x0
> +#define UHS2_DEV_CONFIG_GEN_SET_2D1U_FD		0x2
> +#define UHS2_DEV_CONFIG_GEN_SET_1D2U_FD		0x3
> +#define UHS2_DEV_CONFIG_GEN_SET_2D2U_FD		0x4
> +#define UHS2_DEV_CONFIG_GEN_SET_CFG_COMPLETE	BIT(31)
> +
> +/* PHY Caps and Settings registers */
> +#define UHS2_DEV_CONFIG_PHY_CAPS	(UHS2_DEV_CONFIG_REG + 0x002)
> +#define UHS2_DEV_CONFIG_PHY_MINOR_MASK	0xF
> +#define UHS2_DEV_CONFIG_PHY_MAJOR_POS	4
> +#define UHS2_DEV_CONFIG_PHY_MAJOR_MASK	0x3
> +#define UHS2_DEV_CONFIG_CAN_HIBER_POS	15
> +#define UHS2_DEV_CONFIG_CAN_HIBER_MASK	0x1
> +#define UHS2_DEV_CONFIG_PHY_CAPS1	(UHS2_DEV_CONFIG_REG + 0x003)
> +#define UHS2_DEV_CONFIG_N_LSS_SYN_MASK	0xF
> +#define UHS2_DEV_CONFIG_N_LSS_DIR_POS	4
> +#define UHS2_DEV_CONFIG_N_LSS_DIR_MASK	0xF
> +
> +#define UHS2_DEV_CONFIG_PHY_SET			(UHS2_DEV_CONFIG_REG + 0x00A)
> +#define UHS2_DEV_CONFIG_PHY_SET_SPEED_POS	6
> +#define UHS2_DEV_CONFIG_PHY_SET_SPEED_A		0x0
> +#define UHS2_DEV_CONFIG_PHY_SET_SPEED_B		0x1
> +
> +/* LINK-TRAN Caps and Settings registers */
> +#define UHS2_DEV_CONFIG_LINK_TRAN_CAPS		(UHS2_DEV_CONFIG_REG + 0x004)
> +#define UHS2_DEV_CONFIG_LT_MINOR_MASK		0xF
> +#define UHS2_DEV_CONFIG_LT_MAJOR_POS		4
> +#define UHS2_DEV_CONFIG_LT_MAJOR_MASK		0x3
> +#define UHS2_DEV_CONFIG_N_FCU_POS		8
> +#define UHS2_DEV_CONFIG_N_FCU_MASK		0xFF
> +#define UHS2_DEV_CONFIG_DEV_TYPE_POS		16
> +#define UHS2_DEV_CONFIG_DEV_TYPE_MASK		0x7
> +#define UHS2_DEV_CONFIG_MAX_BLK_LEN_POS		20
> +#define UHS2_DEV_CONFIG_MAX_BLK_LEN_MASK	0xFFF
> +#define UHS2_DEV_CONFIG_LINK_TRAN_CAPS1		(UHS2_DEV_CONFIG_REG + 0x005)
> +#define UHS2_DEV_CONFIG_N_DATA_GAP_MASK		0xFF
> +
> +#define UHS2_DEV_CONFIG_LINK_TRAN_SET		(UHS2_DEV_CONFIG_REG + 0x00C)
> +#define UHS2_DEV_CONFIG_LT_SET_MAX_BLK_LEN	0x200
> +#define UHS2_DEV_CONFIG_LT_SET_MAX_RETRY_POS	16
> +
> +/* Preset register */
> +#define UHS2_DEV_CONFIG_PRESET	(UHS2_DEV_CONFIG_REG + 0x040)
> +
> +#define UHS2_DEV_INT_REG	0x100
> +
> +#define UHS2_DEV_STATUS_REG	0x180
> +
> +#define UHS2_DEV_CMD_REG		0x200
> +#define UHS2_DEV_CMD_FULL_RESET		(UHS2_DEV_CMD_REG + 0x000)
> +#define UHS2_DEV_CMD_GO_DORMANT_STATE	(UHS2_DEV_CMD_REG + 0x001)
> +#define UHS2_DEV_CMD_DORMANT_HIBER	BIT(7)
> +#define UHS2_DEV_CMD_DEVICE_INIT	(UHS2_DEV_CMD_REG + 0x002)
> +#define UHS2_DEV_INIT_COMPLETE_FLAG	BIT(11)
> +#define UHS2_DEV_CMD_ENUMERATE		(UHS2_DEV_CMD_REG + 0x003)
> +#define UHS2_DEV_CMD_TRANS_ABORT	(UHS2_DEV_CMD_REG + 0x004)
> +
> +#define UHS2_RCLK_MAX	52000000
> +#define UHS2_RCLK_MIN	26000000
> +
> +struct sd_uhs2_wait_active_state_data {
> +	struct mmc_host *host;
> +	struct mmc_command *cmd;
> +};
> +
> +#endif /* LINUX_MMC_UHS2_H */

