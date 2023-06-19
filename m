Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5E1734DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjFSIaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjFSIaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:30:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675CB100;
        Mon, 19 Jun 2023 01:30:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3E6D6144D;
        Mon, 19 Jun 2023 08:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C732C433C8;
        Mon, 19 Jun 2023 08:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687163411;
        bh=eIZI6ptS5tkUzsgX/wDjow3J+YGKEh3sq048gze+kVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r/LMg6qFV2+qi6N8vQgKjVUkMoSyhOvEYY6fV7fNsloqn1HTMl7ngQKS7z5TT3cQI
         GRbeINLl747qcecYs9/eoxQxqj6/cxZYrqoKS6MriKRQi5iyovzgR7ZdJ/obHFjGpT
         IamdPUFka+FU9DL4oYh1SI7rmBKH8TL53TxFRFeMZMW9LHF4A6AC6fN2S9963DM1/p
         NfLGwA7Ox8n/9bqC8odPLCnrP/ZVCBF4zxmEIHO1QpMb8miNRaEYSpyUYo3IFww5/K
         R1LK3+iYZXUagisS2DSFC3Hbp0+jkUvdpYvHz3nx5iFtpHutwNRcRWDHBhSpULII/G
         dsIym3OTTV1uQ==
Date:   Mon, 19 Jun 2023 09:30:05 +0100
From:   Lee Jones <lee@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     broonie@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, vkoul@kernel.org, robh+dt@kernel.org,
        conor+dt@kernel.org, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] mfd: cs42l43: Add support for cs42l43 core driver
Message-ID: <20230619083005.GN3635807@google.com>
References: <20230605125504.2570158-1-ckeepax@opensource.cirrus.com>
 <20230605125504.2570158-4-ckeepax@opensource.cirrus.com>
 <20230615171124.GL3635807@google.com>
 <20230616083404.GR68926@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230616083404.GR68926@ediswmail.ad.cirrus.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2023, Charles Keepax wrote:

> On Thu, Jun 15, 2023 at 06:11:24PM +0100, Lee Jones wrote:
> > On Mon, 05 Jun 2023, Charles Keepax wrote:
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +//
> > > +// CS42L43 I2C driver
> > > +//
> > > +// Copyright (C) 2022-2023 Cirrus Logic, Inc. and
> > > +//                         Cirrus Logic International Semiconductor Ltd.
> > > +
> > 
> > I realise there is some precedent for this already in MFD.
> > 
> > However, I'd rather headers used C style multi-line comments.
> > 
> 
> Apologies but just to be super clear you want this to look like:
> 
> // SPDX-License-Identifier: GPL-2.0
> /*
>  * CS42L43 I2C driver
>  *
>  * Copyright (C) 2022-2023 Cirrus Logic, Inc. and
>  *                         Cirrus Logic International Semiconductor Ltd.
>  */
> 
> Just clarifying since you want to get rid of all the // comments,
> but the SPDX stuff specifically requires one according to
> Documentation/process/license-rules.rst.

Yes please.

> > > +	// I2C is always attached by definition
> > 
> > C please.  And everywhere else.
> > 
> 
> Can do.


> > > +static struct i2c_device_id cs42l43_i2c_id[] = {
> > > +	{ "cs42l43", 0 },
> > > +	{}
> > > +};
> > > +MODULE_DEVICE_TABLE(i2c, cs42l43_i2c_id);
> > 
> > Is this required anymore?
> > 
> 
> I was not aware of it not being required, I think it will still
> be used for the purposes of module naming. Perhaps someone more
> knowledgable than me can comment?

Since this table isn't providing any information which cannot be derived
from the other (OF, ACPI) tables, the I2C subsystem should be able to
obtain it from those sources instead.

> > > +#if IS_ENABLED(CONFIG_MFD_CS42L43_I2C)
> > > +const struct regmap_config cs42l43_i2c_regmap = {
> > > +	.reg_bits		= 32,
> > > +	.reg_stride		= 4,
> > > +	.val_bits		= 32,
> > > +	.reg_format_endian	= REGMAP_ENDIAN_BIG,
> > > +	.val_format_endian	= REGMAP_ENDIAN_BIG,
> > > +
> > > +	.max_register		= CS42L43_MCU_RAM_MAX,
> > > +	.readable_reg		= cs42l43_readable_register,
> > > +	.volatile_reg		= cs42l43_volatile_register,
> > > +	.precious_reg		= cs42l43_precious_register,
> > > +
> > > +	.cache_type		= REGCACHE_RBTREE,
> > > +	.reg_defaults		= cs42l43_reg_default,
> > > +	.num_reg_defaults	= ARRAY_SIZE(cs42l43_reg_default),
> > > +};
> > > +EXPORT_SYMBOL_NS_GPL(cs42l43_i2c_regmap, MFD_CS42L43);
> > > +#endif
> > 
> > We don't tend to like #ifery in C files.
> > 
> > Why is it required?
> > 
> > And why not just put them were they're consumed?
> 
> The trouble is the cs42l43_reg_default array and the array size.
> There is no good way to statically initialise those two fields
> from a single array in both the I2C and SDW modules.

Can you have a little think for another way to solve this please?

> > > +static int cs42l43_soft_reset(struct cs42l43 *cs42l43)
> > > +{
> > > +	static const struct reg_sequence reset[] = {
> > > +		{ CS42L43_SFT_RESET, 0x5A000000 },
> > > +	};
> > > +	unsigned long time;
> > > +
> > > +	dev_dbg(cs42l43->dev, "Soft resetting\n");
> > 
> > How often are you realistically going to enable these?  Can you do
> > without them and just add some printks when debugging?  Seems a shame to
> > dirty the code-base with seldom used / questionably helpful LoC.
> 
> I mean I use them all the time they are very helpful. But yeah I
> can just add them each time I need them its just a pain, but I

Sure, during development.  Now the driver is authored however, how often
are you likely to turn it back on.  Besides, this isn't real debug
information with dynamically obtained values and useful information,
it's a function call trace which can be obtained from other sources,
such as ftrace and the like.

[...]

> > > +	if (ret) {
> > > +		dev_err(cs42l43->dev, "Failed to move to stage 3: %d, 0x%x\n", ret, val);
> > 
> > Stage 3 what?
> > 
> 
> Of the MCU boot.

Please make that clear.  I don't see any documentation or pointers here.

> > Perhaps some simple function headers would help?
> > 
> 
> You mean add some kernel doc for these functions, right? Assuming
> that is what you mean, will do.

I'd suggest not using kernel-doc formatting, but that type of thing,
yes.

-- 
Lee Jones [李琼斯]
