Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABFC654579
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 18:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiLVRFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 12:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiLVRFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 12:05:47 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAAEF2;
        Thu, 22 Dec 2022 09:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671728745; x=1703264745;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K2faVlyV/1hDmIMnpX5nmiNOU1D2jzH4XcwX3GG/60E=;
  b=X9OY3ouy+25rV3qMqdsu/Lhg2khsQQ+KtzmXeSAaAVd3marFkGsDkbbn
   ObqrOTJB0+NKgAH2DUG3x8U/m6363XIAbI25oaZDo1jqZ4TF0qjIfGLUD
   oLnzw9M2OF4o1UwpwsOhx2bDta3kz3KttdVF9S2ZB0WOAedZhP2nQPZh9
   hBLyp5AnKFt5o27w8tPpwftYkCHeoErNDljI0/+RfHb65dUSYaunqYslA
   TpoY1VOsrODvRMqd51AId+uLIM61/5HnhLYn/3vd2vW3F2kjAl5jEy0ce
   l+RoSdnlQeP4fvuzzIBNdSd/piSdaw028WT7bFDEGuzHML+adFo5hSsrO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="406410691"
X-IronPort-AV: E=Sophos;i="5.96,266,1665471600"; 
   d="scan'208";a="406410691"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 09:04:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="794175756"
X-IronPort-AV: E=Sophos;i="5.96,266,1665471600"; 
   d="scan'208";a="794175756"
Received: from rpurdy-mobl.amr.corp.intel.com (HELO [10.212.42.91]) ([10.212.42.91])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 09:04:02 -0800
Message-ID: <b0387660-a4a8-d109-0337-034dfc439325@linux.intel.com>
Date:   Thu, 22 Dec 2022 09:53:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH V7 4/5] ASoC: codecs: Aw883xx chip register file, data
 type file and Kconfig Makefile
Content-Language: en-US
To:     wangweidong.a@awinic.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        perex@perex.cz, tiwai@suse.com, ckeepax@opensource.cirrus.com,
        rf@opensource.cirrus.com, peter.ujfalusi@linux.intel.com,
        james.schulman@cirrus.com, flatmax@flatmax.com,
        ryan.lee.analog@gmail.com, jonathan.albrieux@gmail.com,
        tanureal@opensource.cirrus.com, povik+lin@cutebit.org,
        13691752556@139.com, cezary.rojewski@intel.com,
        stephan@gerhold.net, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     duanyibo@awinic.com, zhaolei@awinic.com, liweilei@awinic.com,
        yijiangtao@awinic.com, zhangjianming@awinic.com
References: <20221222123205.106353-1-wangweidong.a@awinic.com>
 <20221222123205.106353-5-wangweidong.a@awinic.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20221222123205.106353-5-wangweidong.a@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +
> +#define PROJECT_NAME_MAX		(24)
> +#define CUSTOMER_NAME_MAX		(16)
> +#define CFG_VERSION_MAX			(4)
> +#define DEV_NAME_MAX			(16)
> +#define PROFILE_STR_MAX			(32)
> +
> +#define ACF_FILE_ID				(0xa15f908)

align on one indentation please

> +
> +enum aw_cfg_hdr_version {
> +	AW_CFG_HDR_VER_0_0_0_1	= 0x00000001,
> +	AW_CFG_HDR_VER_1_0_0_0	= 0x01000000,
> +};
> +

> +struct aw_cfg_hdr {
> +	u32 a_id;				/*acf file ID 0xa15f908*/
> +	char a_project[PROJECT_NAME_MAX];	/*project name*/
> +	char a_custom[CUSTOMER_NAME_MAX];	/*custom name */
> +	char a_version[CFG_VERSION_MAX];	/*author update version*/
> +	u32 a_author_id;			/*author id*/
> +	u32 a_ddt_size;				/*sub section table entry size*/
> +	u32 a_ddt_num;				/*sub section table entry num*/
> +	u32 a_hdr_offset;			/*sub section table offset in file*/
> +	u32 a_hdr_version;			/*sub section table version*/
> +	u32 reserve[3];
> +};

use spaces before and after /* and */

and what's up with the a_ prefix, is this needed?

> +
> +struct aw_cfg_dde {
> +	u32 type;				/*DDE type id*/
> +	char dev_name[DEV_NAME_MAX];
> +	u16 dev_index;				/*dev id*/
> +	u16 dev_bus;				/*dev bus id*/
> +	u16 dev_addr;				/*dev addr id*/
> +	u16 dev_profile;			/*dev profile id*/
> +	u32 data_type;				/*data type id*/
> +	u32 data_size;
> +	u32 data_offset;
> +	u32 data_crc;
> +	u32 reserve[5];

reserved

> +};
> +
> +struct aw_cfg_dde_v_1_0_0_0 {
> +	u32 type;				/*DDE type id*/
> +	char dev_name[DEV_NAME_MAX];
> +	u16 dev_index;				/*dev id*/
> +	u16 dev_bus;				/*dev bus id*/
> +	u16 dev_addr;				/*dev addr id*/
> +	u16 dev_profile;			/*dev profile id*/
> +	u32 data_type;				/*data type id*/
> +	u32 data_size;
> +	u32 data_offset;
> +	u32 data_crc;
> +	char dev_profile_str[PROFILE_STR_MAX];
> +	u32 chip_id;
> +	u32 reserve[4];
> +};
> +
> +struct aw_sec_data_desc {
> +	u32 len;
> +	u8 *data;
> +};
> +
> +struct aw_prof_desc {
> +	u32 id;
> +	u32 prof_st;
> +	char *prf_str;
> +	u32 fw_ver;
> +	struct aw_sec_data_desc sec_desc[AW_DATA_TYPE_MAX];
> +};
> +
> +struct aw_all_prof_info {
> +	struct aw_prof_desc prof_desc[AW_PROFILE_MAX];
> +};
> +
> +struct aw_prof_info {
> +	int count;
> +	int prof_type;
> +	char **prof_name_list;
> +	struct aw_prof_desc *prof_desc;
> +};
> +
> +#endif
> +
> diff --git a/sound/soc/codecs/aw883xx/aw883xx_pid_2049_reg.h b/sound/soc/codecs/aw883xx/aw883xx_pid_2049_reg.h
> new file mode 100644
> index 000000000000..21d1e913db0b
> --- /dev/null
> +++ b/sound/soc/codecs/aw883xx/aw883xx_pid_2049_reg.h
> @@ -0,0 +1,490 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * aw883xx.c --  ALSA SoC AW883XX codec support
> + *
> + * Copyright (c) 2022 AWINIC Technology CO., LTD
> + *
> + * Author: Bruce zhao <zhaolei@awinic.com>
> + */
> +
> +#ifndef __AW883XX_PID_2049_REG_H__
> +#define __AW883XX_PID_2049_REG_H__
> +
> +#define AW_PID_2049_ID_REG				(0x00)
> +#define AW_PID_2049_SYSST_REG			(0x01)
> +#define AW_PID_2049_SYSINT_REG			(0x02)
> +#define AW_PID_2049_SYSINTM_REG			(0x03)
> +#define AW_PID_2049_SYSCTRL_REG			(0x04)
> +#define AW_PID_2049_SYSCTRL2_REG		(0x05)
> +#define AW_PID_2049_I2SCTRL_REG			(0x06)
> +#define AW_PID_2049_I2SCFG1_REG			(0x07)
> +#define AW_PID_2049_I2SCFG2_REG			(0x08)
> +#define AW_PID_2049_HAGCCFG1_REG		(0x09)
> +#define AW_PID_2049_HAGCCFG2_REG		(0x0A)
> +#define AW_PID_2049_HAGCCFG3_REG		(0x0B)
> +#define AW_PID_2049_HAGCCFG4_REG		(0x0C)
> +#define AW_PID_2049_HAGCCFG5_REG		(0x0D)
> +#define AW_PID_2049_HAGCCFG6_REG		(0x0E)
> +#define AW_PID_2049_HAGCCFG7_REG		(0x0F)
> +#define AW_PID_2049_MPDCFG_REG			(0x10)
> +#define AW_PID_2049_PWMCTRL_REG			(0x11)
> +#define AW_PID_2049_I2SCFG3_REG			(0x12)
> +#define AW_PID_2049_DBGCTRL_REG			(0x13)
> +#define AW_PID_2049_HAGCST_REG			(0x20)
> +#define AW_PID_2049_VBAT_REG			(0x21)
> +#define AW_PID_2049_TEMP_REG			(0x22)
> +#define AW_PID_2049_PVDD_REG			(0x23)
> +#define AW_PID_2049_ISNDAT_REG			(0x24)
> +#define AW_PID_2049_VSNDAT_REG			(0x25)
> +#define AW_PID_2049_I2SINT_REG			(0x26)
> +#define AW_PID_2049_I2SCAPCNT_REG		(0x27)
> +#define AW_PID_2049_ANASTA1_REG			(0x28)
> +#define AW_PID_2049_ANASTA2_REG			(0x29)
> +#define AW_PID_2049_ANASTA3_REG			(0x2A)
> +#define AW_PID_2049_ANASTA4_REG			(0x2B)
> +#define AW_PID_2049_TESTDET_REG			(0x2C)
> +#define AW_PID_2049_TESTIN_REG			(0x38)
> +#define AW_PID_2049_TESTOUT_REG			(0x39)
> +#define AW_PID_2049_DSPMADD_REG			(0x40)
> +#define AW_PID_2049_DSPMDAT_REG			(0x41)
> +#define AW_PID_2049_WDT_REG				(0x42)
> +#define AW_PID_2049_ACR1_REG			(0x43)
> +#define AW_PID_2049_ACR2_REG			(0x44)
> +#define AW_PID_2049_ASR1_REG			(0x45)
> +#define AW_PID_2049_ASR2_REG			(0x46)
> +#define AW_PID_2049_DSPCFG_REG			(0x47)
> +#define AW_PID_2049_ASR3_REG			(0x48)
> +#define AW_PID_2049_ASR4_REG			(0x49)
> +#define AW_PID_2049_VSNCTRL1_REG		(0x50)
> +#define AW_PID_2049_ISNCTRL1_REG		(0x51)
> +#define AW_PID_2049_PLLCTRL1_REG		(0x52)
> +#define AW_PID_2049_PLLCTRL2_REG		(0x53)
> +#define AW_PID_2049_PLLCTRL3_REG		(0x54)
> +#define AW_PID_2049_CDACTRL1_REG		(0x55)
> +#define AW_PID_2049_CDACTRL2_REG		(0x56)
> +#define AW_PID_2049_SADCCTRL1_REG		(0x57)
> +#define AW_PID_2049_SADCCTRL2_REG		(0x58)
> +#define AW_PID_2049_CPCTRL1_REG			(0x59)
> +#define AW_PID_2049_BSTCTRL1_REG		(0x60)
> +#define AW_PID_2049_BSTCTRL2_REG		(0x61)
> +#define AW_PID_2049_BSTCTRL3_REG		(0x62)
> +#define AW_PID_2049_BSTCTRL4_REG		(0x63)
> +#define AW_PID_2049_BSTCTRL5_REG		(0x64)
> +#define AW_PID_2049_BSTCTRL6_REG		(0x65)
> +#define AW_PID_2049_BSTCTRL7_REG		(0x66)
> +#define AW_PID_2049_DSMCFG1_REG			(0x67)
> +#define AW_PID_2049_DSMCFG2_REG			(0x68)
> +#define AW_PID_2049_DSMCFG3_REG			(0x69)
> +#define AW_PID_2049_DSMCFG4_REG			(0x6A)
> +#define AW_PID_2049_DSMCFG5_REG			(0x6B)
> +#define AW_PID_2049_DSMCFG6_REG			(0x6C)
> +#define AW_PID_2049_DSMCFG7_REG			(0x6D)
> +#define AW_PID_2049_DSMCFG8_REG			(0x6E)
> +#define AW_PID_2049_TESTCTRL1_REG		(0x70)
> +#define AW_PID_2049_TESTCTRL2_REG		(0x71)
> +#define AW_PID_2049_EFCTRL1_REG			(0x72)
> +#define AW_PID_2049_EFCTRL2_REG			(0x73)
> +#define AW_PID_2049_EFWH_REG			(0x74)
> +#define AW_PID_2049_EFWM2_REG			(0x75)
> +#define AW_PID_2049_EFWM1_REG			(0x76)
> +#define AW_PID_2049_EFWL_REG			(0x77)
> +#define AW_PID_2049_EFRH_REG			(0x78)
> +#define AW_PID_2049_EFRM2_REG			(0x79)
> +#define AW_PID_2049_EFRM1_REG			(0x7A)
> +#define AW_PID_2049_EFRL_REG			(0x7B)
> +#define AW_PID_2049_TM_REG				(0x7C)

indentation is distracting, please pick one.

> +
> +/*
> + * Register Access
> + */
> +enum aw883xx_id {
> +	AW883XX_PID_2049 = 0x2049,
> +};
> +
> +#define AW_PID_2049_REG_MAX				(0x7D)
> +
> +#define REG_NONE_ACCESS					(0)
> +#define REG_RD_ACCESS					(1 << 0)
> +#define REG_WR_ACCESS					(1 << 1)
> +
> +#define AW_PID_2049_VOLUME_STEP_DB		(6 * 8)
> +
> +#define AW_PID_2049_SOFT_RESET_VALUE	(0x55aa)
> +
