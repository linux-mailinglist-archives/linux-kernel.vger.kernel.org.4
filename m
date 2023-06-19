Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76610734EB7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjFSIyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjFSIxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:53:55 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC0D12F;
        Mon, 19 Jun 2023 01:53:04 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35J7BilH019508;
        Mon, 19 Jun 2023 03:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=KN9bBN5Pb+ea0O+RR7lKadXIEdNIzwB4JEpMI+Jsp+0=;
 b=EFsqCWA9qKYnaxOm4+hukqHEiCwIR7bjxK4iKkUWRROOXZ2Qu6dLy2E+DKd36HWfLBT0
 xbXU6hhv6fyVlJM0COQfqbx2dNkcqIe5jbQK1+kmOXJBICfLdymQ7DmZksoCtJ7D5Jtk
 2YLMzYdOJ34rZp3s7nnFvtqj5MtDX53K/q5HLlHr8/35BFw9YuUaqdjHgSkBJcrbGQIg
 DbtudSRF4TC9I8MP4tvAgTwh78dOVbnROKYcA6vk6iAwfbilRPZo9VjGzMUaafWQ5s6M
 cSgNVv+7vDC11iW+JM3HN8X+RpSIalS533HYitJp69xtHNgwHI865l8qOAWdP73VylHr 7g== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3r9a809knw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 03:52:46 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Mon, 19 Jun
 2023 09:52:44 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Mon, 19 Jun 2023 09:52:44 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 800B611AA;
        Mon, 19 Jun 2023 08:52:44 +0000 (UTC)
Date:   Mon, 19 Jun 2023 08:52:44 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lee Jones <lee@kernel.org>
CC:     <broonie@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linus.walleij@linaro.org>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>, <lgirdwood@gmail.com>,
        <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/6] mfd: cs42l43: Add support for cs42l43 core driver
Message-ID: <20230619085244.GU68926@ediswmail.ad.cirrus.com>
References: <20230605125504.2570158-1-ckeepax@opensource.cirrus.com>
 <20230605125504.2570158-4-ckeepax@opensource.cirrus.com>
 <20230615171124.GL3635807@google.com>
 <20230616083404.GR68926@ediswmail.ad.cirrus.com>
 <20230619083005.GN3635807@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230619083005.GN3635807@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: yH0bMObXJlRVCdEL-QCa-N4rlQtwNX-w
X-Proofpoint-GUID: yH0bMObXJlRVCdEL-QCa-N4rlQtwNX-w
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 09:30:05AM +0100, Lee Jones wrote:
> On Fri, 16 Jun 2023, Charles Keepax wrote:
> > On Thu, Jun 15, 2023 at 06:11:24PM +0100, Lee Jones wrote:
> > > On Mon, 05 Jun 2023, Charles Keepax wrote:
> > > > +static struct i2c_device_id cs42l43_i2c_id[] = {
> > > > +	{ "cs42l43", 0 },
> > > > +	{}
> > > > +};
> > > > +MODULE_DEVICE_TABLE(i2c, cs42l43_i2c_id);
> > > 
> > > Is this required anymore?
> > > 
> > 
> > I was not aware of it not being required, I think it will still
> > be used for the purposes of module naming. Perhaps someone more
> > knowledgable than me can comment?
> 
> Since this table isn't providing any information which cannot be derived
> from the other (OF, ACPI) tables, the I2C subsystem should be able to
> obtain it from those sources instead.
> 

Sorry I literally just sent a v4 then saw this email. I will test
removing this table and send a v5.

> > > > +#if IS_ENABLED(CONFIG_MFD_CS42L43_I2C)
> > > > +const struct regmap_config cs42l43_i2c_regmap = {
> > > > +	.reg_bits		= 32,
> > > > +	.reg_stride		= 4,
> > > > +	.val_bits		= 32,
> > > > +	.reg_format_endian	= REGMAP_ENDIAN_BIG,
> > > > +	.val_format_endian	= REGMAP_ENDIAN_BIG,
> > > > +
> > > > +	.max_register		= CS42L43_MCU_RAM_MAX,
> > > > +	.readable_reg		= cs42l43_readable_register,
> > > > +	.volatile_reg		= cs42l43_volatile_register,
> > > > +	.precious_reg		= cs42l43_precious_register,
> > > > +
> > > > +	.cache_type		= REGCACHE_RBTREE,
> > > > +	.reg_defaults		= cs42l43_reg_default,
> > > > +	.num_reg_defaults	= ARRAY_SIZE(cs42l43_reg_default),
> > > > +};
> > > > +EXPORT_SYMBOL_NS_GPL(cs42l43_i2c_regmap, MFD_CS42L43);
> > > > +#endif
> > > 
> > > We don't tend to like #ifery in C files.
> > > 
> > > Why is it required?
> > > 
> > > And why not just put them were they're consumed?
> > 
> > The trouble is the cs42l43_reg_default array and the array size.
> > There is no good way to statically initialise those two fields
> > from a single array in both the I2C and SDW modules.
> 
> Can you have a little think for another way to solve this please?
> 

I will have another go at it, if memory serves the vague options
were:

1) this approach
2) some sort of horrible #include to put the defaults array in
both modules, although I would really prefer to avoid this one.
3) dynamically allocate the regmap_configs so those two fields
can be filled in with non-static data.

If I fail to come up with an option 4 would you prefer 1 or 3?
Well or 2 but I really would prefer not to do 2.

> > > Perhaps some simple function headers would help?
> > You mean add some kernel doc for these functions, right? Assuming
> > that is what you mean, will do.
> 
> I'd suggest not using kernel-doc formatting, but that type of thing,
> yes.

Ok I will remove the kernel doc bits for v5.

Thanks,
Charles
