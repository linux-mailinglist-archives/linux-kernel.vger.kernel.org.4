Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4AA6B1489
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjCHVyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCHVyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:54:31 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D13BC790
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 13:54:28 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t15so33222wrz.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 13:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678312467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a4kuJj+2DsoKUj4iuUzExdIuqEBXNXYnOJeCkp/Nulc=;
        b=xteH1vB8DcBNh4OsWM5/+OA2DWwUsI9dmg9FH01KYx67ln+c2C084u7voH6Jp11O2R
         B7kwFBOv4LaDTHndhAV8rj6+oBz6CguGXKGj3fOgiJA5E5DoAtzx2wz5Ygfsk/1+jqKa
         i59U189yCBgAdnRIFflr55qGPCoh1geG1cuGJsAAaGUQzMjK5cyNyn+Fu9KGsChL72VM
         39OFPYuO8sjoy/3rjzfrHX7IYqRuUeXlo6EGTIptJCTqk1HCBz/TeU01B8pkF3iX0C07
         fLbLauAEMsHIWwjtczUbfNqBgiJBnA9YBBz2/AJK0gAU0YQCa7u1Drm/uyuQPebQhItk
         CYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678312467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4kuJj+2DsoKUj4iuUzExdIuqEBXNXYnOJeCkp/Nulc=;
        b=FVRsz0PhYDXQPqU8+X4SZ+bgRq+VyNYxHz0NFKBUecgN12PguXuW2ihFcEudLjfPaF
         RynKWqVCK3CxexlCTpHEAkVg9fno0zV6PSbdLFuMZDNdvuhIBaiL8tXU6iL4sNlVJzyI
         VW1wbR/0iq79iWkRbofCH34Yjg2BxZuMlwIsXC8SAQ7wkFlLgIMn9v7YV2v9Na0dRRjw
         6yb7tcFjWXSPteN8Twm6abUkndI2mvplSWwOkyPcnLuFxg8X/qzanQdtyihbuijeinex
         pucNhErqoWrHamxQYqsnTWT5TpNc+hB0ajny0IDl4GMKhUA8q9tvdAXHnDjQtR62jKM1
         kk7g==
X-Gm-Message-State: AO0yUKXBHyDhfOZWZNRoN3KBiw6QS4Z8F5vk/OiYZO6GKPstbxIaVZeC
        6WzxzkCZ9DdTC9ngzMM6/SuOjg==
X-Google-Smtp-Source: AK7set8b05iQ9Tw117cexD4WwlF6FJ5eHczy+A61NvI6+oqfAl1e51/ds/xptQeTvjmt2BIEfQDiUw==
X-Received: by 2002:adf:e750:0:b0:2c8:9ab8:85f9 with SMTP id c16-20020adfe750000000b002c89ab885f9mr13372250wrn.40.1678312467277;
        Wed, 08 Mar 2023 13:54:27 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id a7-20020a5d4d47000000b002c5706f7c6dsm16135660wru.94.2023.03.08.13.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 13:54:26 -0800 (PST)
Date:   Wed, 8 Mar 2023 23:54:25 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] soc: qcom: Make the Qualcomm UFS/SDCC ICE a
 dedicated driver
Message-ID: <ZAkEEXHbmxiJf7Fu@linaro.org>
References: <20230214120253.1098426-1-abel.vesa@linaro.org>
 <20230214120253.1098426-2-abel.vesa@linaro.org>
 <Y+3ZyVRowJplzm9t@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+3ZyVRowJplzm9t@sol.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-02-15 23:22:49, Eric Biggers wrote:
> Hi Abel,
> 
> On Tue, Feb 14, 2023 at 02:02:49PM +0200, Abel Vesa wrote:
> > This takes the already existing duplicated support in both ufs-qcom
> > and sdhci-msm drivers and makes it a dedicated driver that can be used
> > by both mentioned drivers. The reason for this is because, staring with
> > SM8550, the ICE IP block is shared between UFS and SDCC, which means we
> > need to probe a dedicated device and share it between those two
> > consumers. So let's add the ICE dedicated driver as a soc driver.
> 
> Thanks for doing this!
> 
> About a year ago there was also a patch (that seems to have been abandoned) by
> Gaurav Kashyap to create an ICE library:
> https://lore.kernel.org/linux-scsi/20211206225725.77512-2-quic_gaurkash@quicinc.com
> 
> That patch just made it a library, not an actual device driver.
> 
> Is it fair to say that the library approach would not be appropriate anymore for
> the reason you mention above: on the latest SoC there's now a single ICE
> instance for both the UFS and eMMC host controllers, instead of one per host
> controller?

Yes, with SM8550, the same ICE instance is shared, therefore, the
library approach is not enough here. New driver is though.

> 
> Will there be any issue with using the dedicated driver on older SoCs that do
> have separate ICE instances?

Nope. You can have separate devicetree nodes for each instance and
they'll probe fine with the v2 of this patchset.

> 
> Also, in both cases, how will the ICE clock be controlled?  Currently the ICE
> clock gets turned on and off by the UFS and eMMC drivers.  I don't see any logic
> in your new driver that turns the clock on and off.

I added clock enablement in v2. We can decide later on if the clocks
need to be disabled and when.

> 
> > +config QCOM_INLINE_CRYPTO_ENGINE
> > +	bool "QCOM UFS & SDCC Inline Crypto Engine driver"
> 
> Shouldn't this be a tristate?

Changed to tristate in v2.

> 
> Also should it really be user-selectable (have a prompt string)?  There's
> already SCSI_UFS_QCOM and MMC_SDHCI_MSM that control the host controller
> drivers, and SCSI_UFS_CRYPTO and MMC_CRYPTO that control the inline encryption
> support for those host controller drivers.  Shouldn't the kconfig just select
> QCOM_INLINE_CRYPTO_ENGINE if 'SCSI_UFS_QCOM && SCSI_UFS_CRYPTO' or
> 'MMC_SDHCI_MSM && MMC_CRYPTO'?  I don't think there's any need to make users
> explicitly select yet another option.

Made it not user-selectable in v2. See v2 for details.

> 
> > diff --git a/drivers/soc/qcom/qcom-ice.c b/drivers/soc/qcom/qcom-ice.c
> > new file mode 100644
> > index 000000000000..40c9adbc2666
> > --- /dev/null
> > +++ b/drivers/soc/qcom/qcom-ice.c
> 
> The directory is already named "qcom", so how about just naming the file
> "ice.c"?

Renamed to ice.c in v2.

> 
> > @@ -0,0 +1,315 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Qualcomm ICE (Inline Crypto Engine) support.
> > + *
> > + * Copyright (c) 2023, Linaro Limited
> > + */
> 
> Can you please keep the copyright statements from the file this is derived from?

Done, in v2.

> 
> > +/* Only one ICE instance is supported currently by HW */
> > +static struct qcom_ice *engine;
> 
> Isn't it very bad practice for drivers to store state in static variables like
> this?  Sure, the SCM calls are global anyway, so multiple ICE instances aren't
> going to be supported regardless.  But surely it isn't necessary to use a static
> variable like this too, since the device private data could be used instead?

Dropped in v2. Used device private date instead.

> 
> > +static bool qcom_ice_check_supported(struct qcom_ice *ice)
> > +{
> > +	u32 regval = qcom_ice_readl(ice, QCOM_ICE_REG_VERSION);
> > +	struct device *dev = ice->dev;
> > +	int major = regval >> 24;
> > +	int minor = (regval >> 16) & 0xFF;
> > +	int step = regval & 0xFFFF;
> > +
> > +	ice->supported = true;
> > +
> > +	/* For now this driver only supports ICE version 3. */
> > +	if (major != 3) {
> > +		dev_warn(dev, "Unsupported ICE version: v%d.%d.%d\n",
> > +			 major, minor, step);
> > +		ice->supported = false;
> > +		goto out;
> > +	}
> > +
> > +	dev_info(dev, "Found QC Inline Crypto Engine (ICE) v%d.%d.%d\n",
> > +		 major, minor, step);
> > +
> > +	/* If fuses are blown, ICE might not work in the standard way. */
> > +	regval = qcom_ice_readl(ice, QCOM_ICE_REG_FUSE_SETTING);
> > +	if (regval & (QCOM_ICE_FUSE_SETTING_MASK |
> > +		      QCOM_ICE_FORCE_HW_KEY0_SETTING_MASK |
> > +		      QCOM_ICE_FORCE_HW_KEY1_SETTING_MASK)) {
> > +		dev_warn(dev, "Fuses are blown; ICE is unusable!\n");
> > +		ice->supported = false;
> > +		goto out;
> > +	}
> > +out:
> > +	return ice->supported;
> > +}
> 
> Is the 'supported' field necessary?  Shouldn't the driver just not bind to the
> device if it doesn't support it?

Dropped in v2.

> 
> > +void qcom_ice_low_power_mode_enable(struct qcom_ice *ice)
> > +{
> 
> Please make functions static whenever possible.


Done, in v2.

> 
> > +/* Poll until all BIST bits are reset */
> > +static int qcom_ice_wait_bist_status(struct qcom_ice *ice)
> > +{
> > +	int count;
> > +	u32 reg;
> > +
> > +	if (!ice)
> > +		return 0;
> > +
> > +	for (count = 0; count < 100; count++) {
> > +		reg = qcom_ice_readl(ice, QCOM_ICE_REG_BIST_STATUS);
> > +		if (!(reg & QCOM_ICE_BIST_STATUS_MASK))
> > +			break;
> > +		udelay(50);
> > +	}
> > +
> > +	if (reg)
> > +		return -ETIMEDOUT;
> > +
> > +	return 0;
> > +}
> 
> The version of this function in drivers/mmc/host/sdhci-msm.c has a better
> comment, and a simpler implementation using readl_poll_timeout().  How about
> using that version of this function?

I agree. Done in v2.

> 
> > +int qcom_ice_resume(struct qcom_ice *ice)
> > +{
> > +	struct device *dev = ice->dev;
> > +	int err;
> > +
> > +	if (!ice)
> > +		return 0;
> 
> The above NULL check occurs after the pointer was already dereferenced.
> 
> Also, why is NULL allowed here anyway?
> 

Actually, if one of the crypto configs are not enabled (MMC or UFS) or
if there is no devicetree phandle to point to an ICE instance, we should
allow the driver to use the API and do nothing if the engine pointer is
NULL. It is more cleaner from consumer driver point of view.

> > +/*
> > + * Program a key into a QC ICE keyslot, or evict a keyslot.  QC ICE requires
> > + * vendor-specific SCM calls for this; it doesn't support the standard way.
> > + */
> > +int qcom_ice_program_key(struct qcom_ice *ice, bool config_enable,
> > +			 u8 crypto_cap_idx, u8 algorithm_id,
> > +			 u8 key_size, const u8 crypto_key[],
> > +			 u8 data_unit_size, int slot)
> > +{
> > +	struct device *dev = ice->dev;
> > +	union {
> > +		u8 bytes[AES_256_XTS_KEY_SIZE];
> > +		u32 words[AES_256_XTS_KEY_SIZE / sizeof(u32)];
> > +	} key;
> > +	int i;
> > +	int err;
> > +
> > +	if (!config_enable)
> > +		return qcom_scm_ice_invalidate_key(slot);
> 
> Can you please make eviction a separate function?  All it needs is the ICE
> instance and the keyslot, not the other parameters.
> 
> Yes, the UFS and eMMC drivers have the program_key method that does both
> programming and eviction, but that doesn't mean this has to do the same.

Done in v2.

> 
> > diff --git a/include/soc/qcom/ice.h b/include/soc/qcom/ice.h
> > new file mode 100644
> > index 000000000000..3ee8add7aeb9
> > --- /dev/null
> > +++ b/include/soc/qcom/ice.h
> > @@ -0,0 +1,61 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (c) 2023, Linaro Limited
> > + */
> > +
> > +#ifndef __QCOM_ICE_H__
> > +#define __QCOM_ICE_H__
> > +
> > +#include <linux/err.h>
> > +
> > +struct qcom_ice {
> > +	struct device *dev;
> > +	struct device_node *np;
> > +	void __iomem *base;
> > +
> > +	struct clk *core_clk;
> > +
> > +	bool supported;
> > +};
> 
> Shouldn't struct qcom_ice be private to the driver?

Nope. If the QCOM_INLINE_CRYPTO_ENGINE is not set, the consumer still
need to be able to call the ICE API (which in this case does really
nothing). Again, this allows the consumer drivers to keep clean of
unnecessary #ifdefs.

> 
> > +enum qcom_ice_crypto_key_size {
> > +	QCOM_ICE_CRYPTO_KEY_SIZE_INVALID	= 0x0,
> > +	QCOM_ICE_CRYPTO_KEY_SIZE_128		= 0x1,
> > +	QCOM_ICE_CRYPTO_KEY_SIZE_192		= 0x2,
> > +	QCOM_ICE_CRYPTO_KEY_SIZE_256		= 0x3,
> > +	QCOM_ICE_CRYPTO_KEY_SIZE_512		= 0x4,
> > +};
> > +
> > +enum qcom_ice_crypto_alg {
> > +	QCOM_ICE_CRYPTO_ALG_AES_XTS		= 0x0,
> > +	QCOM_ICE_CRYPTO_ALG_BITLOCKER_AES_CBC	= 0x1,
> > +	QCOM_ICE_CRYPTO_ALG_AES_ECB		= 0x2,
> > +	QCOM_ICE_CRYPTO_ALG_ESSIV_AES_CBC	= 0x3,
> > +};
> 
> This patch series introduces an implicit assumption that these values match the
> UFS and eMMC algorithm constants.
> 
> The way it worked previously is that the UFS driver explicitly checked that the
> UFS algorithm ID was AES-256-XTS before translating it into
> QCOM_SCM_ICE_CIPHER_AES_256_XTS, and similarly for eMMC.
> 
> Now there are these intermediate QCOM_ICE_CRYPTO_ALG_* constants, and there's no
> explicit validation that they actually match the UFS and eMMC constants.
> 
> Maybe this part should be kept more similar to how it was before, where the
> check for AES-256-XTS happens in the UFS and eMMC drivers?
> 

Done in v2.

> - Eric
