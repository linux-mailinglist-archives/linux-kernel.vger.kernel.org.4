Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76F962593B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbiKKLUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiKKLUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:20:34 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2D568C52;
        Fri, 11 Nov 2022 03:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668165632; x=1699701632;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=OeAy6uXUdYiUlmCVbGW3Mp0P+eIkGdfdoy7T+VKHRK0=;
  b=Xjy4BEFISASquA8971VV3BhZ5OP1vF5j3jEXFJoCCuyekoWgkCQDxWNC
   BZ+xjsKKhi2vyGsrKVT/6moFz2arUqOhFeSgA+xTpc62LLq3UBl+ftE/7
   bvsAo/XHohwhmIsHNNaoadEJh4Qx7nfdBMgYTkgagNg5TZ2I+sRj/GudB
   P18/lThSlhCQijFyFnaSZLTxDFKC0PCQprTCR2/g22yTx2vq8KmN3xMv4
   D3/75f/JezCBaaGfSmMg51uLvlXDNY5Mgp/lo0OVWgrLZQQKD/ydu5dQb
   doSfc7+PJFx+P9YRE7876cFPtTJMG2nh6PjmIKyhja3rvt6NNY9JWcR/0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="373710728"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="373710728"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 03:20:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="882735329"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="882735329"
Received: from iglushko-mobl1.ger.corp.intel.com ([10.249.44.68])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 03:20:24 -0800
Date:   Fri, 11 Nov 2022 13:20:18 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Xu Yilun <yilun.xu@intel.com>
cc:     linux-fpga@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/12] mfd: intel-m10-bmc: Downscope SPI related
 defines
In-Reply-To: <Y24WDyIPO7NRa8Vg@yilunxu-OptiPlex-7050>
Message-ID: <93a358e-d590-ae2b-32bc-bdefb58c6bac@linux.intel.com>
References: <20221108144305.45424-1-ilpo.jarvinen@linux.intel.com> <20221108144305.45424-8-ilpo.jarvinen@linux.intel.com> <Y24WDyIPO7NRa8Vg@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1983861248-1668165431=:1606"
Content-ID: <b336f86-5d1-4193-8f16-233d4255faff@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1983861248-1668165431=:1606
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <44af8bb0-5b11-bb5e-11c8-77b34941aefd@linux.intel.com>

On Fri, 11 Nov 2022, Xu Yilun wrote:

> On 2022-11-08 at 16:43:00 +0200, Ilpo J�rvinen wrote:
> > Move SPI related defines to per interface from the global header. This
> 
> These definitions are not for SPI, maybe more precisely like "SPI based
> board definitions".
> 
> > makes it harder to shoot oneself into foot.
> 
> Maybe better to use plain text in commit message.

Ok, I'll try to incorporate your suggestions.

> > Some bitfield defs are also moved to intel-m10-bmc-core which seems
> > more appropriate for them.
> 
> I'm still not clear about the motivation of these movements. For example:
> 
> We move the MAC registers in core, then should we also move sec update
> registers in sec update driver?

I'd actually prefer to do exactly as you suggest for sec update defines 
too but it didn't feel like their move would fit well into this patch 
series.

> We move the DOORBELL reg addr out, but keep DOORBELL reg fields in
> header file, seems make harder for people to get the whole picture.

Those reg fields are common between boards, no? Unlike the DOORBELL reg 
addr whose value depends on which interface the board is based on?

The point of this move is that this header file would without this split
give a _wrong_ "whole picture" if it keeps the defines that are not
shared for all boards but vary per interface.

But if you still insist, I can of course drop this patch. It's in no way
absolutely necessary even if I personnally think it's useful to downscope
defines (but I can understand there might be different opinions such as 
the one you stated above).

-- 
 i.


> > Reviewed-by: Russ Weight <russell.h.weight@intel.com>
> > Signed-off-by: Ilpo J�rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/mfd/intel-m10-bmc-core.c  | 11 ++++++++
> >  drivers/mfd/intel-m10-bmc-spi.c   | 39 +++++++++++++++++++++++++
> >  include/linux/mfd/intel-m10-bmc.h | 47 -------------------------------
> >  3 files changed, 50 insertions(+), 47 deletions(-)
> > 
> > diff --git a/drivers/mfd/intel-m10-bmc-core.c b/drivers/mfd/intel-m10-bmc-core.c
> > index 51b78b868235..50a4ec758bdb 100644
> > --- a/drivers/mfd/intel-m10-bmc-core.c
> > +++ b/drivers/mfd/intel-m10-bmc-core.c
> > @@ -12,6 +12,17 @@
> >  #include <linux/mfd/intel-m10-bmc.h>
> >  #include <linux/module.h>
> >  
> > +/* Register fields of system registers */
> > +#define M10BMC_MAC_BYTE4		GENMASK(7, 0)
> > +#define M10BMC_MAC_BYTE3		GENMASK(15, 8)
> > +#define M10BMC_MAC_BYTE2		GENMASK(23, 16)
> > +#define M10BMC_MAC_BYTE1		GENMASK(31, 24)
> > +#define M10BMC_MAC_BYTE6		GENMASK(7, 0)
> > +#define M10BMC_MAC_BYTE5		GENMASK(15, 8)
> > +#define M10BMC_MAC_COUNT		GENMASK(23, 16)
> > +#define M10BMC_VER_MAJOR_MSK		GENMASK(23, 16)
> > +#define M10BMC_VER_PCB_INFO_MSK		GENMASK(31, 24)
> > +
> >  static ssize_t bmc_version_show(struct device *dev,
> >  				struct device_attribute *attr, char *buf)
> >  {
> > diff --git a/drivers/mfd/intel-m10-bmc-spi.c b/drivers/mfd/intel-m10-bmc-spi.c
> > index e3b2edb8bc07..4a7a16d9f8d6 100644
> > --- a/drivers/mfd/intel-m10-bmc-spi.c
> > +++ b/drivers/mfd/intel-m10-bmc-spi.c
> > @@ -13,6 +13,45 @@
> >  #include <linux/regmap.h>
> >  #include <linux/spi/spi.h>
> >  
> > +#define M10BMC_LEGACY_BUILD_VER		0x300468
> > +#define M10BMC_SYS_BASE			0x300800
> > +#define M10BMC_SYS_END			0x300fff
> > +#define M10BMC_FLASH_BASE		0x10000000
> > +#define M10BMC_FLASH_END		0x1fffffff
> > +#define M10BMC_MEM_END			M10BMC_FLASH_END
> > +
> > +#define M10BMC_STAGING_BASE		0x18000000
> > +
> > +/* Register offset of system registers */
> > +#define NIOS2_FW_VERSION		0x0
> > +#define M10BMC_MAC_LOW			0x10
> > +#define M10BMC_MAC_HIGH			0x14
> > +#define M10BMC_TEST_REG			0x3c
> > +#define M10BMC_BUILD_VER		0x68
> > +#define M10BMC_VER_LEGACY_INVALID	0xffffffff
> > +
> > +/* Secure update doorbell register, in system register region */
> > +#define M10BMC_DOORBELL			0x400
> > +
> > +/* Authorization Result register, in system register region */
> > +#define M10BMC_AUTH_RESULT		0x404
> > +
> > +/* Addresses for security related data in FLASH */
> > +#define BMC_REH_ADDR	0x17ffc004
> > +#define BMC_PROG_ADDR	0x17ffc000
> > +#define BMC_PROG_MAGIC	0x5746
> > +
> > +#define SR_REH_ADDR	0x17ffd004
> > +#define SR_PROG_ADDR	0x17ffd000
> > +#define SR_PROG_MAGIC	0x5253
> > +
> > +#define PR_REH_ADDR	0x17ffe004
> > +#define PR_PROG_ADDR	0x17ffe000
> > +#define PR_PROG_MAGIC	0x5250
> > +
> > +/* Address of 4KB inverted bit vector containing staging area FLASH count */
> > +#define STAGING_FLASH_COUNT	0x17ffb000
> > +
> >  static const struct regmap_range m10bmc_regmap_range[] = {
> >  	regmap_reg_range(M10BMC_LEGACY_BUILD_VER, M10BMC_LEGACY_BUILD_VER),
> >  	regmap_reg_range(M10BMC_SYS_BASE, M10BMC_SYS_END),
> > diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> > index 860408aa8db3..ed920f76d3c8 100644
> > --- a/include/linux/mfd/intel-m10-bmc.h
> > +++ b/include/linux/mfd/intel-m10-bmc.h
> > @@ -15,39 +15,8 @@ enum m10bmc_type {
> >  	M10_N5010,
> >  };
> >  
> > -#define M10BMC_LEGACY_BUILD_VER		0x300468
> > -#define M10BMC_SYS_BASE			0x300800
> > -#define M10BMC_SYS_END			0x300fff
> > -#define M10BMC_FLASH_BASE		0x10000000
> > -#define M10BMC_FLASH_END		0x1fffffff
> > -#define M10BMC_MEM_END			M10BMC_FLASH_END
> > -
> > -#define M10BMC_STAGING_BASE		0x18000000
> >  #define M10BMC_STAGING_SIZE		0x3800000
> >  
> > -/* Register offset of system registers */
> > -#define NIOS2_FW_VERSION		0x0
> > -#define M10BMC_MAC_LOW			0x10
> > -#define M10BMC_MAC_BYTE4		GENMASK(7, 0)
> > -#define M10BMC_MAC_BYTE3		GENMASK(15, 8)
> > -#define M10BMC_MAC_BYTE2		GENMASK(23, 16)
> > -#define M10BMC_MAC_BYTE1		GENMASK(31, 24)
> > -#define M10BMC_MAC_HIGH			0x14
> > -#define M10BMC_MAC_BYTE6		GENMASK(7, 0)
> > -#define M10BMC_MAC_BYTE5		GENMASK(15, 8)
> > -#define M10BMC_MAC_COUNT		GENMASK(23, 16)
> > -#define M10BMC_TEST_REG			0x3c
> > -#define M10BMC_BUILD_VER		0x68
> > -#define M10BMC_VER_MAJOR_MSK		GENMASK(23, 16)
> > -#define M10BMC_VER_PCB_INFO_MSK		GENMASK(31, 24)
> > -#define M10BMC_VER_LEGACY_INVALID	0xffffffff
> > -
> > -/* Secure update doorbell register, in system register region */
> > -#define M10BMC_DOORBELL			0x400
> > -
> > -/* Authorization Result register, in system register region */
> > -#define M10BMC_AUTH_RESULT		0x404
> > -
> >  /* Doorbell register fields */
> >  #define DRBL_RSU_REQUEST		BIT(0)
> >  #define DRBL_RSU_PROGRESS		GENMASK(7, 4)
> > @@ -108,22 +77,6 @@ enum m10bmc_type {
> >  #define RSU_COMPLETE_INTERVAL_MS	1000
> >  #define RSU_COMPLETE_TIMEOUT_MS		(40 * 60 * 1000)
> >  
> > -/* Addresses for security related data in FLASH */
> > -#define BMC_REH_ADDR	0x17ffc004
> > -#define BMC_PROG_ADDR	0x17ffc000
> > -#define BMC_PROG_MAGIC	0x5746
> > -
> > -#define SR_REH_ADDR	0x17ffd004
> > -#define SR_PROG_ADDR	0x17ffd000
> > -#define SR_PROG_MAGIC	0x5253
> > -
> > -#define PR_REH_ADDR	0x17ffe004
> > -#define PR_PROG_ADDR	0x17ffe000
> > -#define PR_PROG_MAGIC	0x5250
> > -
> > -/* Address of 4KB inverted bit vector containing staging area FLASH count */
> > -#define STAGING_FLASH_COUNT	0x17ffb000
> > -
> >  /**
> >   * struct m10bmc_csr_map - Intel MAX 10 BMC CSR register map
> >   */
> > -- 
> > 2.30.2
> > 
> 
--8323329-1983861248-1668165431=:1606--
