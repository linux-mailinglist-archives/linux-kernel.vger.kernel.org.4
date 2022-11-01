Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C1461503E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiKARMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiKARMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:12:43 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12508186D6;
        Tue,  1 Nov 2022 10:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667322761; x=1698858761;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=ZCkEeuqR8YC45ozsCK+3feVc99hjufKCkoltY2uwWiQ=;
  b=GYNBMMfHwpX8h2nqCFZbynPwaHjkp/zVryu+ePpWaDibIHKYctSxmH1r
   LVTsIXXG6aI3D8uqQ6/OJS6TXnu9kmRPDFkisG8cbqFZ7IECoJOVMn9oe
   8mcpdtBFwpdCc5W0bfo9iA4cTjhB3SlX40Z0KQkBHVYjhJecYuQdk1eMt
   4X6esDv99/Kwwb22znkoMg5wLpyRpddb6F4BOO76/BmlJj26EnIqm5o/H
   +CP9xv4Fgon7xbgNd0uPFQXP8YCPYeLGtYlfRyJeEL+7J1K6uotSPMImh
   2eZcKUVXP6U5ho+endlF7EXWLKWkYyt+35G1k/H9HLjGIz07baLDaDYq8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="288905323"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="288905323"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:12:40 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="723228572"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="723228572"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.55.64])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 10:12:37 -0700
Message-ID: <a9ee1a56-e47d-b4ff-e591-d7341468da4d@intel.com>
Date:   Tue, 1 Nov 2022 19:12:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V5 08/26] mmc: sdhci: add UHS-II related definitions in
 headers
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20221019110647.11076-1-victor.shih@genesyslogic.com.tw>
 <20221019110647.11076-9-victor.shih@genesyslogic.com.tw>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221019110647.11076-9-victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/22 14:06, Victor Shih wrote:
> Add UHS-II related definitions in shdci.h and sdhci-uhs2.h.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---

I hope you don't mind, but some of the names seem a bit long,
or could be more like regular SDHCI equivalents.  Also
BIT() anf GENMASK() could be used more in some cases.  See
comments below.

>  drivers/mmc/host/sdhci-uhs2.h | 210 ++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.h      |  73 +++++++++++-
>  2 files changed, 282 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mmc/host/sdhci-uhs2.h
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> new file mode 100644
> index 000000000000..5610affebdf3
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-uhs2.h
> @@ -0,0 +1,210 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + *  linux/drivers/mmc/host/sdhci-uhs2.h - Secure Digital Host Controller
> + *  Interface driver
> + *
> + * Header file for Host Controller UHS2 related registers and I/O accessors.

I/O accessors?

> + *
> + *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
> + */
> +#ifndef __SDHCI_UHS2_H
> +#define __SDHCI_UHS2_H
> +
> +#include <linux/bits.h>
> +
> +/*
> + * UHS-II Controller registers
> + * 0x74 preset in sdhci.h
> + * 0x80
> + * 0x84-0xB4
> + * 0xB8-0xCF
> + * 0xE0-0xE7
> + */
> +/* UHS2 */

Rather than above, let's just have one simple comment:

/* SDHCI Category B registers : UHS2 only */

> +#define SDHCI_UHS2_BLOCK_SIZE	0x80
> +#define  SDHCI_UHS2_MAKE_BLKSZ(dma, blksz) \
> +	((((dma) & 0x7) << 12) | ((blksz) & 0xFFF))

I would prefer to wrap only lines over 100 columns

> +
> +#define SDHCI_UHS2_BLOCK_COUNT	0x84
> +
> +#define SDHCI_UHS2_CMD_PACKET	0x88
> +#define  SDHCI_UHS2_CMD_PACK_MAX_LEN	20
> +
> +#define SDHCI_UHS2_TRANS_MODE	0x9C
> +#define  SDHCI_UHS2_TRNS_DMA		BIT(0)
> +#define  SDHCI_UHS2_TRNS_BLK_CNT_EN	BIT(1)
> +#define  SDHCI_UHS2_TRNS_DATA_TRNS_WRT	BIT(4)
> +#define  SDHCI_UHS2_TRNS_BLK_BYTE_MODE	BIT(5)
> +#define  SDHCI_UHS2_TRNS_RES_R5		BIT(6)
> +#define  SDHCI_UHS2_TRNS_RES_ERR_CHECK_EN	BIT(7)
> +#define  SDHCI_UHS2_TRNS_RES_INT_DIS	BIT(8)
> +#define  SDHCI_UHS2_TRNS_WAIT_EBSY	BIT(14)
> +#define  SDHCI_UHS2_TRNS_2L_HD		BIT(15)
> +
> +#define SDHCI_UHS2_COMMAND	0x9E

Please line up all the values.  Also some names could be
shortened.  There are suggestions in the comments below.

> +#define  SDHCI_UHS2_COMMAND_SUB_CMD	0x0004

Please use BIT() and GENMASK() macros here and elsewhere.

Also could keep the name "SDHCI_UHS2_COMMAND" for the
register but abbreviate "COMMAND" to "CMD" for the fields.
SDHCI_COMMAND register does it that way.

> +#define  SDHCI_UHS2_COMMAND_DATA	0x0020
> +#define  SDHCI_UHS2_COMMAND_TRNS_ABORT	0x0040
> +#define  SDHCI_UHS2_COMMAND_CMD12	0x0080
> +#define  SDHCI_UHS2_COMMAND_DORMANT	0x00C0
> +#define  SDHCI_UHS2_COMMAND_PACK_LEN_MASK	GENMASK(12, 8)
> +#define  SDHCI_UHS2_COMMAND_PACK_LEN_SHIFT	8

If possible, please avoid macros for shift value.
Instead use FIELD_GET() and FIELD_PREP(), or even
__bf_shf() if FIELD_GET() and FIELD_PREP() don't
work.

> +
> +#define SDHCI_UHS2_RESPONSE	0xA0
> +#define  SDHCI_UHS2_RESPONSE_MAX_LEN	20
> +
> +#define SDHCI_UHS2_MSG_SELECT	0xB4
> +#define SDHCI_UHS2_MSG_SELECT_CURR	0x0
> +#define SDHCI_UHS2_MSG_SELECT_ONE	0x1
> +#define SDHCI_UHS2_MSG_SELECT_TWO	0x2
> +#define SDHCI_UHS2_MSG_SELECT_THREE	0x3
> +
> +#define SDHCI_UHS2_MSG		0xB8
> +
> +#define SDHCI_UHS2_DEV_INT_STATUS	0xBC
> +
> +#define SDHCI_UHS2_DEV_SELECT	0xBE
> +#define SDHCI_UHS2_DEV_SELECT_DEV_SEL_MASK	GENMASK(3, 0)

Perhaps just SDHCI_UHS2_DEV_SEL_MASK

> +#define SDHCI_UHS2_DEV_SELECT_INT_MSG_EN	BIT(7)

Perhaps just SDHCI_UHS2_DEV_SEL_INT_MSG_EN

> +
> +#define SDHCI_UHS2_DEV_INT_CODE	0xBF
> +
> +#define SDHCI_UHS2_SW_RESET	0xC0
> +#define SDHCI_UHS2_SW_RESET_FULL	0x0001
> +#define SDHCI_UHS2_SW_RESET_SD		0x0002

Please use BIT() macros

> +
> +#define SDHCI_UHS2_TIMER_CTRL	0xC2
> +#define SDHCI_UHS2_TIMER_CTRL_DEADLOCK_SHIFT	4

Please use GENMASK()

> +
> +#define SDHCI_UHS2_ERR_INT_STATUS		0xC4
> +#define SDHCI_UHS2_ERR_INT_STATUS_EN		0xC8
> +#define SDHCI_UHS2_ERR_INT_SIG_EN		0xCC

Let's make those 3 more like regular SDHCI names i.e.

#define SDHCI_UHS2_INT_STATUS			0xC4
#define SDHCI_UHS2_INT_STATUS_ENABLE		0xC8
#define SDHCI_UHS2_INT_SIGNAL_ENABLE		0xCC

> +#define SDHCI_UHS2_ERR_INT_STATUS_HEADER	BIT(0)
> +#define SDHCI_UHS2_ERR_INT_STATUS_RES		BIT(1)
> +#define SDHCI_UHS2_ERR_INT_STATUS_RETRY_EXP	BIT(2)
> +#define SDHCI_UHS2_ERR_INT_STATUS_CRC		BIT(3)
> +#define SDHCI_UHS2_ERR_INT_STATUS_FRAME		BIT(4)
> +#define SDHCI_UHS2_ERR_INT_STATUS_TID		BIT(5)
> +#define SDHCI_UHS2_ERR_INT_STATUS_UNRECOVER	BIT(7)
> +#define SDHCI_UHS2_ERR_INT_STATUS_EBUSY		BIT(8)
> +#define SDHCI_UHS2_ERR_INT_STATUS_ADMA		BIT(15)
> +#define SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT	BIT(16)
> +#define SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT	BIT(17)
> +#define SDHCI_UHS2_ERR_INT_STATUS_VENDOR	BIT(27)

Again, let's make the interrupt bits above more like regular SDHCI
names i.e.

#define SDHCI_UHS2_INT_HEADER_ERR	BIT(0)
#define SDHCI_UHS2_INT_RES_ERR		BIT(1)
#define SDHCI_UHS2_INT_RETRY_EXP	BIT(2)
#define SDHCI_UHS2_INT_CRC		BIT(3)
#define SDHCI_UHS2_INT_FRAME_ERR	BIT(4)
#define SDHCI_UHS2_INT_TID_ERR		BIT(5)
#define SDHCI_UHS2_INT_UNRECOVERABLE	BIT(7)
#define SDHCI_UHS2_INT_EBUSY_ERR	BIT(8)
#define SDHCI_UHS2_INT_ADMA_ERROR	BIT(15)
#define SDHCI_UHS2_INT_CMD_TIMEOUT	BIT(16)
#define SDHCI_UHS2_INT_DEADLOCK_TIMEOUT	BIT(17)
#define SDHCI_UHS2_INT_VENDOR_ERR	BIT(27)

> +#define SDHCI_UHS2_ERR_INT_STATUS_MASK	\

More like regular SDHCI name

#define SDHCI_UHS2_INT_ERROR_MASK

> +		(SDHCI_UHS2_ERR_INT_STATUS_HEADER |	\
> +		SDHCI_UHS2_ERR_INT_STATUS_RES |		\
> +		SDHCI_UHS2_ERR_INT_STATUS_RETRY_EXP |	\
> +		SDHCI_UHS2_ERR_INT_STATUS_CRC |		\
> +		SDHCI_UHS2_ERR_INT_STATUS_FRAME |	\
> +		SDHCI_UHS2_ERR_INT_STATUS_TID |		\
> +		SDHCI_UHS2_ERR_INT_STATUS_UNRECOVER |	\
> +		SDHCI_UHS2_ERR_INT_STATUS_EBUSY |	\
> +		SDHCI_UHS2_ERR_INT_STATUS_ADMA |	\
> +		SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT |	\
> +		SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT)
> +#define SDHCI_UHS2_ERR_INT_STATUS_CMD_MASK	\

SDHCI_UHS2_INT_CMD_ERR_MASK

> +		(SDHCI_UHS2_ERR_INT_STATUS_HEADER |	\
> +		SDHCI_UHS2_ERR_INT_STATUS_RES |		\
> +		SDHCI_UHS2_ERR_INT_STATUS_FRAME |	\
> +		SDHCI_UHS2_ERR_INT_STATUS_TID |		\
> +		SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT)
> +/* CRC Error occurs during a packet receiving */
> +#define SDHCI_UHS2_ERR_INT_STATUS_DATA_MASK	\

SDHCI_UHS2_INT_DATA_ERR_MASK

> +		(SDHCI_UHS2_ERR_INT_STATUS_RETRY_EXP |	\
> +		SDHCI_UHS2_ERR_INT_STATUS_CRC |		\
> +		SDHCI_UHS2_ERR_INT_STATUS_UNRECOVER |	\
> +		SDHCI_UHS2_ERR_INT_STATUS_EBUSY |	\
> +		SDHCI_UHS2_ERR_INT_STATUS_ADMA |	\
> +		SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT)
> +
> +#define SDHCI_UHS2_SET_PTR	0xE0

"SET" is not clear. "SETTINGS" would be better

> +#define   SDHCI_UHS2_GEN_SET_POWER_LOW		0x0001

Please use BIT() macros

> +#define   SDHCI_UHS2_GEN_SET_N_LANES_POS	8

Please use GENMASK()

Also I would call this SDHCI_UHS2_LANES

> +#define   SDHCI_UHS2_GEN_SET_2L_FD_HD		0x0
> +#define   SDHCI_UHS2_GEN_SET_2D1U_FD		0x2
> +#define   SDHCI_UHS2_GEN_SET_1D2U_FD		0x3
> +#define   SDHCI_UHS2_GEN_SET_2D2U_FD		0x4

#define   SDHCI_UHS2_FD_OR_2L_HD		0 /* 2 lanes */
#define   SDHCI_UHS2_2D1U_FD			2 /* 3 lanes, 2 down, 1 up, full duplex */
#define   SDHCI_UHS2_1D2U_FD			3 /* 3 lanes, 1 down, 2 up, full duplex */
#define   SDHCI_UHS2_2D2U_FD			4 /* 4 lanes, 2 down, 2 up, full duplex */

> +
> +#define   SDHCI_UHS2_PHY_SET_SPEED_POS		6

Please use GENMASK()

> +#define   SDHCI_UHS2_PHY_SET_HIBER_EN		BIT(12)

HIBER -> HIBERNATE

> +#define   SDHCI_UHS2_PHY_SET_N_LSS_SYN_MASK	GENMASK(19, 16)
> +#define   SDHCI_UHS2_PHY_SET_N_LSS_SYN_POS	16
> +#define   SDHCI_UHS2_PHY_SET_N_LSS_DIR_MASK	GENMASK(23, 20)
> +#define   SDHCI_UHS2_PHY_SET_N_LSS_DIR_POS	20
> +
> +#define   SDHCI_UHS2_TRAN_SET_N_FCU_MASK	GENMASK(15, 8)
> +#define   SDHCI_UHS2_TRAN_SET_N_FCU_POS		8
> +#define   SDHCI_UHS2_TRAN_SET_RETRY_CNT_MASK	GENMASK(17, 16)
> +#define   SDHCI_UHS2_TRAN_SET_RETRY_CNT_POS	16
> +
> +#define   SDHCI_UHS2_TRAN_SET_1_N_DAT_GAP_MASK	GENMASK(7, 0)

"_SET_" in the names above is not needed

Also please do not use *_POS macros - use FEILD_GET()
and FIELD_PREP()

> +
> +#define SDHCI_UHS2_HOST_CAPS_PTR	0xE2

To make them shorter, let's change all "SDHCI_UHS2_HOST_CAPS_"
to "SDHCI_UHS2_CAP_"

Also _GEN_ is a bit meaningless in the field names, and no
_SHIFT please

> +#define  SDHCI_UHS2_HOST_CAPS_GEN_OFFSET	0
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_DAP_MASK	GENMASK(3, 0)
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_GAP_MASK	GENMASK(7, 4)
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_GAP(gap)	((gap) * 360)
> +#define SDHCI_UHS2_HOST_CAPS_GEN_GAP_SHIFT 4
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_LANE_MASK	GENMASK(13, 8)
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_LANE_SHIFT	8
> +#define    SDHCI_UHS2_HOST_CAPS_GEN_2L_HD_FD	1
> +#define    SDHCI_UHS2_HOST_CAPS_GEN_2D1U_FD	2
> +#define    SDHCI_UHS2_HOST_CAPS_GEN_1D2U_FD	4
> +#define    SDHCI_UHS2_HOST_CAPS_GEN_2D2U_FD	8
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_ADDR_64	BIT(14)
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_BOOT		BIT(15)
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_MASK	GENMASK(17, 16)
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_SHIFT	16
> +#define    SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_RMV	0
> +#define    SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_EMB	1
> +#define    SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_EMB_RMV	2
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_NUM_DEV_MASK		GENMASK(21, 18)
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_NUM_DEV_SHIFT	18
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_MASK	GENMASK(23, 22)
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_SHIFT	22
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_P2P		0
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_RING	1
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_HUB		2
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_HUB_RING	3
> +
> +#define  SDHCI_UHS2_HOST_CAPS_PHY_OFFSET	4
> +#define   SDHCI_UHS2_HOST_CAPS_PHY_REV_MASK		GENMASK(5, 0)
> +#define   SDHCI_UHS2_HOST_CAPS_PHY_RANGE_MASK		GENMASK(7, 6)
> +#define   SDHCI_UHS2_HOST_CAPS_PHY_RANGE_SHIFT		6
> +#define   SDHCI_UHS2_HOST_CAPS_PHY_RANGE_A		0
> +#define   SDHCI_UHS2_HOST_CAPS_PHY_RANGE_B		1
> +#define   SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_SYN_MASK	GENMASK(19, 16)
> +#define   SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_SYN_SHIFT	16
> +#define   SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_DIR_MASK	GENMASK(23, 20)
> +#define   SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_DIR_SHIFT	20
> +#define  SDHCI_UHS2_HOST_CAPS_TRAN_OFFSET	8
> +#define   SDHCI_UHS2_HOST_CAPS_TRAN_LINK_REV_MASK	GENMASK(5, 0)
> +#define   SDHCI_UHS2_HOST_CAPS_TRAN_N_FCU_MASK		GENMASK(15, 8)
> +#define   SDHCI_UHS2_HOST_CAPS_TRAN_N_FCU_SHIFT		8
> +#define   SDHCI_UHS2_HOST_CAPS_TRAN_HOST_TYPE_MASK	GENMASK(18, 16)
> +#define   SDHCI_UHS2_HOST_CAPS_TRAN_HOST_TYPE_SHIFT	16
> +#define   SDHCI_UHS2_HOST_CAPS_TRAN_BLK_LEN_MASK	GENMASK(31, 20)
> +#define   SDHCI_UHS2_HOST_CAPS_TRAN_BLK_LEN_SHIFT	20
> +
> +#define  SDHCI_UHS2_HOST_CAPS_TRAN_1_OFFSET	12
> +#define  SDHCI_UHS2_HOST_CAPS_TRAN_1_N_DATA_GAP_MASK	GENMASK(7, 0)
> +
> +#define SDHCI_UHS2_TEST_PTR	0xE4
> +#define  SDHCI_UHS2_TEST_ERR_HEADER	BIT(0)
> +#define  SDHCI_UHS2_TEST_ERR_RES	BIT(1)
> +#define  SDHCI_UHS2_TEST_ERR_RETRY_EXP	BIT(2)
> +#define  SDHCI_UHS2_TEST_ERR_CRC	BIT(3)
> +#define  SDHCI_UHS2_TEST_ERR_FRAME	BIT(4)
> +#define  SDHCI_UHS2_TEST_ERR_TID	BIT(5)
> +#define  SDHCI_UHS2_TEST_ERR_UNRECOVER	BIT(7)
> +#define  SDHCI_UHS2_TEST_ERR_EBUSY	BIT(8)
> +#define  SDHCI_UHS2_TEST_ERR_ADMA	BIT(15)
> +#define  SDHCI_UHS2_TEST_ERR_RES_TIMEOUT	BIT(16)
> +#define  SDHCI_UHS2_TEST_ERR_DEADLOCK_TIMEOUT	BIT(17)
> +#define  SDHCI_UHS2_TEST_ERR_VENDOR	BIT(27)

The Test register has the same bit fields as the interrupt
registers, so we don't really need them do we?

> +
> +#define SDHCI_UHS2_EMBED_CTRL	0xE6
> +#define SDHCI_UHS2_VENDOR	0xE8

For pointer registers like above 2, let's always name them *_PTR

> +
> +#endif /* __SDHCI_UHS2_H */
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index d750c464bd1e..bbed850241d4 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -43,8 +43,27 @@
>  #define  SDHCI_TRNS_READ	0x10
>  #define  SDHCI_TRNS_MULTI	0x20
>  
> +/*
> + * Defined in Host Version 4.10.

Spec says version 4.0 not version 4.1

> + * 1 - R5 (SDIO)
> + * 0 - R1 (Memory)

Without reading the spec, it is not obvious what the above
means, so please just remove it.

> + */
> +#define  SDHCI_TRNS_RES_TYPE		0x40
> +#define  SDHCI_TRNS_RES_ERR_CHECK	0x80
> +#define  SDHCI_TRNS_RES_INT_DIS		0x0100
> +
>  #define SDHCI_COMMAND		0x0E
>  #define  SDHCI_CMD_RESP_MASK	0x03
> +
> +/*
> + * Host Version 4.10 adds this bit to distinguish a main command or
> + * sub command.
> + * CMD53(SDIO) - main command
> + * CMD52(SDIO) - sub command which doesn't have data block or doesn't
> + * indicate busy.

This isn't very clear.  How about just this instead:

For example with SDIO, CMD52 (sub command) issued during CMD53 (main command)

> + */
> +#define  SDHCI_CMD_SUB_CMD	0x04
> +
>  #define  SDHCI_CMD_CRC		0x08
>  #define  SDHCI_CMD_INDEX	0x10
>  #define  SDHCI_CMD_DATA		0x20
> @@ -60,11 +79,19 @@
>  
>  #define SDHCI_RESPONSE		0x10
>  
> +#define  SDHCI_RESPONSE_CM_TRAN_ABORT_OFFSET	0x10
> +#define  SDHCI_RESPONSE_CM_TRAN_ABORT_SIZE	4
> +#define  SDHCI_RESPONSE_SD_TRAN_ABORT_OFFSET	0x18
> +#define  SDHCI_RESPONSE_SD_TRAN_ABORT_SIZE	8

These are UHS2 registers, so I would expect them in
sdhci-uhs2.h.  We don't put register sizes, and for
8-byte registers we add "_1" for the upper 4-bytes.
i.e.

#define SDHCI_UHS2_CM_TRAN_RESP		0x10
#define SDHCI_UHS2_SD_TRAN_RESP		0x18
#define SDHCI_UHS2_SD_TRAN_RESP_1	0x1C

> +
>  #define SDHCI_BUFFER		0x20
>  
>  #define SDHCI_PRESENT_STATE	0x24
>  #define  SDHCI_CMD_INHIBIT	0x00000001
>  #define  SDHCI_DATA_INHIBIT	0x00000002
> +
> +#define  SDHCI_DATA_HIGH_LVL_MASK	0x000000F0

"HIGH" is not that clear.  Instead, what about:

	SDHCI_DAT_4_TO_7_LVL_MASK

> +
>  #define  SDHCI_DOING_WRITE	0x00000100
>  #define  SDHCI_DOING_READ	0x00000200
>  #define  SDHCI_SPACE_AVAILABLE	0x00000400
> @@ -80,6 +107,13 @@
>  #define   SDHCI_DATA_0_LVL_MASK	0x00100000
>  #define  SDHCI_CMD_LVL		0x01000000
>  

/* Host Version 4.10 */

> +#define  SDHCI_HOST_REGULATOR_STABLE	0x02000000
> +#define  SDHCI_CMD_NOT_ISSUE_ERR	0x08000000

Please change:
	ISSUE -> ISSUED

> +#define  SDHCI_SUB_CMD_STATUS		0x10000000

> +#define  SDHCI_UHS2_IN_DORMANT_STATE	0x20000000
> +#define  SDHCI_UHS2_LANE_SYNC		0x40000000
> +#define  SDHCI_UHS2_IF_DETECT		0x80000000
> +
>  #define SDHCI_HOST_CONTROL	0x28
>  #define  SDHCI_CTRL_LED		0x01
>  #define  SDHCI_CTRL_4BITBUS	0x02
> @@ -100,6 +134,11 @@
>  #define  SDHCI_POWER_300	0x0C
>  #define  SDHCI_POWER_330	0x0E
>  
> +/* VDD2 - UHS2 */

Please be more explicit here:

/* VDD2 power on/off and voltage select (UHS2) */

> +#define  SDHCI_VDD2_POWER_ON		0x10
> +#define  SDHCI_VDD2_POWER_180		0xA0
> +#define  SDHCI_VDD2_POWER_120		0x80

Last 3 values could be lined up with further above.

> +
>  #define SDHCI_BLOCK_GAP_CONTROL	0x2A
>  
>  #define SDHCI_WAKE_UP_CONTROL	0x2B
> @@ -110,7 +149,7 @@
>  #define SDHCI_CLOCK_CONTROL	0x2C
>  #define  SDHCI_DIVIDER_SHIFT	8
>  #define  SDHCI_DIVIDER_HI_SHIFT	6
> -#define  SDHCI_DIV_MASK	0xFF
> +#define  SDHCI_DIV_MASK		0xFF
>  #define  SDHCI_DIV_MASK_LEN	8
>  #define  SDHCI_DIV_HI_MASK	0x300
>  #define  SDHCI_PROG_CLOCK_MODE	0x0020
> @@ -139,6 +178,10 @@
>  #define  SDHCI_INT_CARD_REMOVE	0x00000080
>  #define  SDHCI_INT_CARD_INT	0x00000100
>  #define  SDHCI_INT_RETUNE	0x00001000
> +
> +/* Host Version 4.10 */
> +#define  SDHCI_INT_FX_EVENT	0x00002000
> +
>  #define  SDHCI_INT_CQE		0x00004000
>  #define  SDHCI_INT_ERROR	0x00008000
>  #define  SDHCI_INT_TIMEOUT	0x00010000
> @@ -152,6 +195,9 @@
>  #define  SDHCI_INT_AUTO_CMD_ERR	0x01000000
>  #define  SDHCI_INT_ADMA_ERROR	0x02000000
>  
> +/* Host Version 4.0 */
> +#define  SDHCI_INT_RESPONSE_ERROR	0x08000000

Could be shorter:

SDHCI_INT_RESPONSE_ERROR -> SDHCI_INT_RESP_ERR

> +
>  #define  SDHCI_INT_NORMAL_MASK	0x00007FFF
>  #define  SDHCI_INT_ERROR_MASK	0xFFFF8000
>  
> @@ -178,6 +224,9 @@
>  #define  SDHCI_AUTO_CMD_END_BIT	0x00000008
>  #define  SDHCI_AUTO_CMD_INDEX	0x00000010
>  
> +/* Host Version 4.10 */
> +#define  SDHCI_ACMD_RESPONSE_ERROR	0x0020

Could be shorter:

SDHCI_ACMD_RESPONSE_ERROR -> SDHCI_AUTO_CMD_RESP_ERR

> +
>  #define SDHCI_HOST_CONTROL2		0x3E
>  #define  SDHCI_CTRL_UHS_MASK		0x0007
>  #define   SDHCI_CTRL_UHS_SDR12		0x0000
> @@ -186,6 +235,7 @@
>  #define   SDHCI_CTRL_UHS_SDR104		0x0003
>  #define   SDHCI_CTRL_UHS_DDR50		0x0004
>  #define   SDHCI_CTRL_HS400		0x0005 /* Non-standard */
> +#define   SDHCI_CTRL_UHS_2		0x0007 /* UHS-2 */

We are using UHS2 in other places, so do it here too:

SDHCI_CTRL_UHS_2 -> SDHCI_CTRL_UHS2

Also the comment /* UHS-2 */ is not needed

>  #define  SDHCI_CTRL_VDD_180		0x0008
>  #define  SDHCI_CTRL_DRV_TYPE_MASK	0x0030
>  #define   SDHCI_CTRL_DRV_TYPE_B		0x0000
> @@ -194,9 +244,12 @@
>  #define   SDHCI_CTRL_DRV_TYPE_D		0x0030
>  #define  SDHCI_CTRL_EXEC_TUNING		0x0040
>  #define  SDHCI_CTRL_TUNED_CLK		0x0080
> +#define  SDHCI_CTRL_UHS2_INTERFACE_EN	0x0100 /* UHS-2 */

Already have "SDHCI_CTRL_PRESET_VAL_ENABLE" so let's
spell out ENABLE here too.

SDHCI_CTRL_UHS2_INTERFACE_EN -> SDHCI_CTRL_UHS2_ENABLE

Also the comment /* UHS-2 */ is not needed

> +#define  SDHCI_CTRL_ADMA2_LEN_MODE	0x0400
>  #define  SDHCI_CMD23_ENABLE		0x0800
>  #define  SDHCI_CTRL_V4_MODE		0x1000
>  #define  SDHCI_CTRL_64BIT_ADDR		0x2000
> +#define  SDHCI_CTRL_ASYNC_INT_EN	0x4000

Ditto

SDHCI_CTRL_ASYNC_INT_EN -> SDHCI_CTRL_ASYNC_INT_ENABLE

>  #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
>  
>  #define SDHCI_CAPABILITIES	0x40
> @@ -219,11 +272,13 @@
>  #define  SDHCI_CAN_VDD_180	0x04000000
>  #define  SDHCI_CAN_64BIT_V4	0x08000000
>  #define  SDHCI_CAN_64BIT	0x10000000
> +#define  SDHCI_CAN_ASYNC_INT	0x20000000
>  
>  #define SDHCI_CAPABILITIES_1	0x44
>  #define  SDHCI_SUPPORT_SDR50	0x00000001
>  #define  SDHCI_SUPPORT_SDR104	0x00000002
>  #define  SDHCI_SUPPORT_DDR50	0x00000004
> +#define  SDHCI_SUPPORT_UHS2	0x00000008 /* UHS-2 support */

Please remove the comment - the name says it all.

>  #define  SDHCI_DRIVER_TYPE_A	0x00000010
>  #define  SDHCI_DRIVER_TYPE_C	0x00000020
>  #define  SDHCI_DRIVER_TYPE_D	0x00000040
> @@ -232,19 +287,28 @@
>  #define  SDHCI_RETUNING_MODE_MASK		GENMASK(15, 14)
>  #define  SDHCI_CLOCK_MUL_MASK			GENMASK(23, 16)
>  #define  SDHCI_CAN_DO_ADMA3	0x08000000
> +#define  SDHCI_SUPPORT_VDD2_180	0x10000000 /* UHS-2 1.8V VDD2 */

Better to be like VDD bit names i.e.

SDHCI_SUPPORT_VDD2_180 -> SDHCI_CAN_VDD2_180

> +#define  SDHCI_RSVD_FOR_VDD2    0x20000000 /* Rsvd for future VDD2 */

Please drop SDHCI_RSVD_FOR_VDD2

>  #define  SDHCI_SUPPORT_HS400	0x80000000 /* Non-standard */
>  
>  #define SDHCI_MAX_CURRENT		0x48
> +#define SDHCI_MAX_CURRENT_1		0x4C

Let's put SDHCI_MAX_CURRENT_1 just above
SDHCI_MAX_CURRENT_VDD2_180_MASK

>  #define  SDHCI_MAX_CURRENT_LIMIT	GENMASK(7, 0)
>  #define  SDHCI_MAX_CURRENT_330_MASK	GENMASK(7, 0)
>  #define  SDHCI_MAX_CURRENT_300_MASK	GENMASK(15, 8)
>  #define  SDHCI_MAX_CURRENT_180_MASK	GENMASK(23, 16)
> +#define  SDHCI_MAX_CURRENT_VDD2_180_MASK	GENMASK(7, 0) /* UHS2 */
>  #define   SDHCI_MAX_CURRENT_MULTIPLIER	4
>  
>  /* 4C-4F reserved for more max current */
>  
>  #define SDHCI_SET_ACMD12_ERROR	0x50
> +/* Host Version 4.10 */
> +#define SDHCI_SET_ACMD_RESPONSE_ERROR	0x20

This isn't being used is it?  Then let's leave it out.

>  #define SDHCI_SET_INT_ERROR	0x52
> +/* Host Version 4.10 */
> +#define SDHCI_SET_INT_TUNING_ERROR	0x0400
> +#define SDHCI_SET_INT_RESPONSE_ERROR	0x0800

These aren't being used are they?  Then let's leave them out.

>  
>  #define SDHCI_ADMA_ERROR	0x54
>  
> @@ -262,10 +326,16 @@
>  #define SDHCI_PRESET_FOR_SDR104        0x6C
>  #define SDHCI_PRESET_FOR_DDR50 0x6E
>  #define SDHCI_PRESET_FOR_HS400 0x74 /* Non-standard */
> +
> +/* TODO: 0x74 is used for UHS2 in 4.10. How about HS400? */
> +/* UHS2 */

A host controller cannot be using it for both at the same time.
The drivers should be able to sort it out if needed. For now,
just remove your comments.

> +#define SDHCI_PRESET_FOR_UHS2  0x74
>  #define SDHCI_PRESET_DRV_MASK		GENMASK(15, 14)
>  #define SDHCI_PRESET_CLKGEN_SEL		BIT(10)
>  #define SDHCI_PRESET_SDCLK_FREQ_MASK	GENMASK(9, 0)
>  
> +#define SDHCI_ADMA3_ADDRESS	0x78
> +
>  #define SDHCI_SLOT_INT_STATUS	0xFC
>  
>  #define SDHCI_HOST_VERSION	0xFE
> @@ -659,6 +729,7 @@ struct sdhci_ops {
>  	void	(*request_done)(struct sdhci_host *host,
>  				struct mmc_request *mrq);
>  	void    (*dump_vendor_regs)(struct sdhci_host *host);
> +	void	(*dump_uhs2_regs)(struct sdhci_host *host);

Please move this to patch "mmc: sdhci-uhs2: dump UHS-II registers"

>  };
>  
>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS

