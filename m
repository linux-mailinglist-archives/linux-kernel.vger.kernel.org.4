Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785AA6BD0DF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjCPNbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjCPNbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:31:00 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D841CCDFD;
        Thu, 16 Mar 2023 06:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678973458; x=1710509458;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+Zpj8Sb+pnyGCagQ9rF3soTNB9LI1JvIV1fvrIYPhVQ=;
  b=e45iSF7OL1PLVv4QFUdqujsEs5PH1YGZimSj5sIN4lzYFXq4zd6upJTa
   nwOR8vQRu7j7iuXNj5edcXjEUl4WdtrPs8wLCKSOpaqS4Vy9efvfNPHCW
   1JsBrETHJQFG6ZFgBiN/NDvnqBhMsaeXA7Xp6Fy+9PxJtDsF+Cf8snTZy
   hdl1wuBaiwijCR1OHKyplzYotzK85RIbXJQdYnrX6apybzPrh4HKtwzl+
   bbF9U7AEXhL75Q1E3itIrc5idRo0Kn7yi9XAGPMEWrUwmqsauT5QodEsL
   0q/xAjGvCtM5sgavAF2DR5KAzjXgE5CbC3EqjfCa4lMqtQ6owZa/7AEWG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="317639411"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="317639411"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 06:30:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="744127177"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="744127177"
Received: from trybicki-mobl1.ger.corp.intel.com ([10.252.63.119])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 06:30:48 -0700
Date:   Thu, 16 Mar 2023 15:30:45 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jacky Huang <ychuang570808@gmail.com>
cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH 03/15] mfd: Add the header file of Nuvoton ma35d1 system
 manager
In-Reply-To: <20230315072902.9298-4-ychuang570808@gmail.com>
Message-ID: <4f892951-66-3661-7b96-607a67b13838@linux.intel.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com> <20230315072902.9298-4-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023, Jacky Huang wrote:

> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> The system manager is a set of registers used for power control,
> multi-function pin control, USB phy control, IP reset, and other
> miscellaneous controls. It also contains some registers that
> provide SoC information and status.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  include/linux/mfd/ma35d1-sys.h | 95 ++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 include/linux/mfd/ma35d1-sys.h
> 
> diff --git a/include/linux/mfd/ma35d1-sys.h b/include/linux/mfd/ma35d1-sys.h
> new file mode 100644
> index 000000000000..dcd85231125d
> --- /dev/null
> +++ b/include/linux/mfd/ma35d1-sys.h
> @@ -0,0 +1,95 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2023 Nuvoton Technologies.
> + * Author: Chi-Fen Li <cfli0@nuvoton.com>
> + *
> + * System management control registers of MA35D1 SoC
> + */
> +#ifndef __LINUX_MFD_MA35D1_SYS_H
> +#define __LINUX_MFD_MA35D1_SYS_H
> +
> +#define REG_SYS_PDID		(0x000) /* Product and Device Identifier */
> +#define REG_SYS_PWRONOTP	(0x004) /* Power-on Setting OTP Source */
> +#define REG_SYS_PWRONPIN	(0x008) /* Power-on Setting Pin Source */
> +#define REG_SYS_RSTSTS		(0x010) /* Reset Source Active Status */
> +#define REG_SYS_MISCRFCR	(0x014) /* Miscellaneous Reset Function */
> +#define REG_SYS_RSTDEBCTL	(0x018) /* Reset Pin De-bounce Control */
> +#define REG_SYS_LVRDCR		(0x01C) /* Low Voltage Reset & Detect */
> +#define REG_SYS_IPRST0		(0x020) /* Reset Control Register 0 */
> +#define REG_SYS_IPRST1		(0x024) /* Reset Control Register 1 */
> +#define REG_SYS_IPRST2		(0x028) /* Reset Control Register 2 */
> +#define REG_SYS_IPRST3		(0x02C) /* Reset Control Register 3 */
> +#define REG_SYS_PMUCR		(0x030) /* Power Management Unit Control */
> +#define REG_SYS_DDRCQCSR	(0x034) /* DDR Q Channel Control and Status */
> +#define REG_SYS_PMUIEN		(0x038) /* PMU Interrupt Enable */
> +#define REG_SYS_PMUSTS		(0x03C) /* PMU Status */
> +#define REG_SYS_CA35WRBADR1	(0x040) /* A35 Core 1 Warm-boot Address */
> +#define REG_SYS_CA35WRBPAR1	(0x044) /* A35 Core 1 Warm-boot Parameter */
> +#define REG_SYS_CA35WRBADR2	(0x048) /* A35 Core 2 Warm-boot Address */
> +#define REG_SYS_CA35WRBPAR2	(0x04C) /* A35 Core 2 Warm-boot Parameter */
> +#define REG_SYS_USBPMISCR	(0x060) /* USB PHY Miscellaneous Control */
> +#define REG_SYS_USBP0PCR	(0x064) /* USB Port 0 PHY Control */
> +#define REG_SYS_USBP1PCR	(0x068) /* USB Port 1 PHY Control */
> +#define REG_SYS_MISCFCR0	(0x070) /* Miscellaneous Function Control 0 */
> +#define REG_SYS_MISCFCR1	(0x074) /* Miscellaneous Function Control 1 */
> +#define REG_SYS_MISCIER		(0x078) /* Miscellaneous Interrupt Enable */
> +#define REG_SYS_MISCISR		(0x07C) /* Miscellaneous Interrupt Status */
> +#define REG_SYS_GPA_MFPL	(0x080) /* GPIOA Multi-Function Control LSB */
> +#define REG_SYS_GPA_MFPH	(0x084) /* GPIOA Multi-Function Control MSB */
> +#define REG_SYS_GPB_MFPL	(0x088) /* GPIOB Multi-Function Control LSB */
> +#define REG_SYS_GPB_MFPH	(0x08C) /* GPIOB Multi-Function Control MSB */
> +#define REG_SYS_GPC_MFPL	(0x090) /* GPIOC Multi-Function Control LSB */
> +#define REG_SYS_GPC_MFPH	(0x094) /* GPIOC Multi-Function Control MSB */
> +#define REG_SYS_GPD_MFPL	(0x098) /* GPIOD Multi-Function Control LSB */
> +#define REG_SYS_GPD_MFPH	(0x09C) /* GPIOD Multi-Function Control MSB */
> +#define REG_SYS_GPE_MFPL	(0x0A0) /* GPIOE Multi-Function Control LSB */
> +#define REG_SYS_GPE_MFPH	(0x0A4) /* GPIOE Multi-Function Control MSB */
> +#define REG_SYS_GPF_MFPL	(0x0A8) /* GPIOF Multi-Function Control LSB */
> +#define REG_SYS_GPF_MFPH	(0x0AC) /* GPIOF Multi-Function Control MSB */
> +#define REG_SYS_GPG_MFPL	(0x0B0) /* GPIOG Multi-Function Control LSB */
> +#define REG_SYS_GPG_MFPH	(0x0B4) /* GPIOG Multi-Function Control MSB */
> +#define REG_SYS_GPH_MFPL	(0x0B8) /* GPIOH Multi-Function Control LSB */
> +#define REG_SYS_GPH_MFPH	(0x0BC) /* GPIOH Multi-Function Control MSB */
> +#define REG_SYS_GPI_MFPL	(0x0C0) /* GPIOI Multi-Function Control LSB */
> +#define REG_SYS_GPI_MFPH	(0x0C4) /* GPIOI Multi-Function Control MSB */
> +#define REG_SYS_GPJ_MFPL	(0x0C8) /* GPIOJ Multi-Function Control LSB */
> +#define REG_SYS_GPJ_MFPH	(0x0CC) /* GPIOJ Multi-Function Control MSB */
> +#define REG_SYS_GPK_MFPL	(0x0D0) /* GPIOK Multi-Function Control LSB */
> +#define REG_SYS_GPK_MFPH	(0x0D4) /* GPIOK Multi-Function Control MSB */
> +#define REG_SYS_GPL_MFPL	(0x0D8) /* GPIOL Multi-Function Control LSB */
> +#define REG_SYS_GPL_MFPH	(0x0DC) /* GPIOL Multi-Function Control MSB */
> +#define REG_SYS_GPM_MFPL	(0x0E0) /* GPIOM Multi-Function Control LSB */
> +#define REG_SYS_GPM_MFPH	(0x0E4) /* GPIOM Multi-Function Control MSB */
> +#define REG_SYS_GPN_MFPL	(0x0E8) /* GPION Multi-Function Control LSB */
> +#define REG_SYS_GPN_MFPH	(0x0EC) /* GPION Multi-Function Control MSB */
> +#define REG_SYS_HIRCFTRIM	(0x100) /* HIRC Frequency Trim Value */
> +#define REG_SYS_TSENSRFCR	(0x104) /* Temperature Sensor Control */
> +#define REG_SYS_GMAC0MISCR	(0x108) /* GMAC 0 Miscellaneous Control */
> +#define REG_SYS_GMAC1MISCR	(0x10C) /* GMAC 1 Miscellaneous Control */
> +#define REG_SYS_MACAD0LSR	(0x110) /* MAC Address 0 LSW */
> +#define REG_SYS_MACAD0HSR	(0x114) /* MAC Address 0 HSW */
> +#define REG_SYS_MACAD1LSR	(0x118) /* MAC Address 1 LSW */
> +#define REG_SYS_MACAD1HSR	(0x11C) /* MAC Address 1 HSW */
> +#define REG_SYS_CSDBGCTL	(0x120) /* CoreSight Debug Control */
> +#define REG_SYS_GPAB_MFOS	(0x140) /* GPIOA/B Output Mode Select */
> +#define REG_SYS_GPCD_MFOS	(0x144) /* GPIOC/D Output Mode Select */
> +#define REG_SYS_GPEF_MFOS	(0x148) /* GPIOE/F Output Mode Select */
> +#define REG_SYS_GPGH_MFOS	(0x14C) /* GPIOG/H Output Mode Select */
> +#define REG_SYS_GPIJ_MFOS	(0x150) /* GPIOI/J Output Mode Select */
> +#define REG_SYS_GPKL_MFOS	(0x154) /* GPIOK/L Output Mode Select */
> +#define REG_SYS_GPMN_MFOS	(0x158) /* GPIOM/N Output Mode Select */
> +#define REG_SYS_UID0		(0x180) /* Unique Identifier Word 0 */
> +#define REG_SYS_UID1		(0x184) /* Unique Identifier Word 1 */
> +#define REG_SYS_UID2		(0x188) /* Unique Identifier Word 2 */
> +#define REG_SYS_UCID0		(0x190) /* Unique Customer Identifier 0 */
> +#define REG_SYS_UCID1		(0x194) /* Unique Customer Identifier 1 */
> +#define REG_SYS_UCID2		(0x198) /* Unique Customer Identifier 2 */
> +#define REG_SYS_RLKTZS		(0x1A0) /* TZS Register Lock Control */
> +#define REG_SYS_RLKTZNS		(0x1A4) /* TZNS Register Lock Control */
> +#define REG_SYS_RLKSUBM		(0x1A8) /* SubM Register Lock Control */
> +#define REG_SYS_DPLPASWD	(0x1B0) /* Deployed Password */

Remove the extra set of parenthesis from all those above. Hex numbers are 
easier to read with lowercased letters so please convert them all to 
lowercase.

-- 
 i.

