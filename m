Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B4F6A49EA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjB0Siy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjB0Siw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:38:52 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88850D30C;
        Mon, 27 Feb 2023 10:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677523121; x=1709059121;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XI4+ng0G/han3RQEY/xW6B4U/2rCkKwLGFaf1iDMkc4=;
  b=jvv8W4AW56LDOoIJe0mzh2eqkcIRsAiN8Z4FyBWCFhuZbsrxhYv+Z9xB
   xP5e0n78zVufOU/tlK3BCdO7lmErVpGMvV7lab2HUJwQE+RXS/18ULz7v
   Nymh/x7LLbstXSJ66lX0Q/4WDvL7Hkee+mnsCS6cmj/aXrta8VG0GZQ+x
   x0KjrVR+tbPpv0BzbyZsb0pQuw0MLFOKeknVtyNofGRj6zStXB2TFSVwK
   JSOm2MhnGd4FOZgx4aX+hAemp7ve4skZtp7zI6dlrf7/+2iwfzc8Bl7II
   xGF6QSK7TGLNeboGDe97NDYCbT/Y/SobKqSM4vlPf0rkdIr2yxky0eCit
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="332660739"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="332660739"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 10:38:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="737837214"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="737837214"
Received: from jaidenno-mobl.amr.corp.intel.com (HELO [10.212.85.4]) ([10.212.85.4])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 10:38:32 -0800
Message-ID: <d95d15f3-34c3-32df-1a50-0ebce35bf81f@linux.intel.com>
Date:   Mon, 27 Feb 2023 13:19:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] ASoC: max98363: add soundwire amplifier driver
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?B?4oCcUnlhbg==?= <ryan.lee.analog@gmail.com>,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        krzysztof.kozlowski@linaro.org, rf@opensource.cirrus.com,
        ckeepax@opensource.cirrus.com, herve.codina@bootlin.com,
        wangweidong.a@awinic.com, james.schulman@cirrus.com,
        ajye_huang@compal.corp-partner.google.com, shumingf@realtek.com,
        povik+lin@cutebit.org, flatmax@flatmax.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        ryans.lee@analog.com
References: <20230224010814.504016-1-ryan.lee.analog@gmail.com>
 <0fb47fe7-719b-0773-fc14-3d62d7d33619@linux.intel.com>
 <Y/zsqjOWFKrpDtl8@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <Y/zsqjOWFKrpDtl8@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/27/23 12:47, Mark Brown wrote:
> On Mon, Feb 27, 2023 at 10:17:45AM -0500, Pierre-Louis Bossart wrote:
> 
>>> +static struct reg_default max98363_reg[] = {
>>> +	{MAX98363_R0040_SCP_INIT_STAT_1, 0x00},
>>> +	{MAX98363_R0041_SCP_INIT_MASK_1, 0x00},
>>> +	{MAX98363_R0042_SCP_INIT_STAT_2, 0x00},
>>> +	{MAX98363_R0044_SCP_CTRL, 0x00},
>>> +	{MAX98363_R0045_SCP_SYSTEM_CTRL, 0x00},
>>> +	{MAX98363_R0046_SCP_DEV_NUMBER, 0x00},
>>> +	{MAX98363_R004D_SCP_BUS_CLK, 0x00},
>>> +	{MAX98363_R0050_SCP_DEV_ID_0, 0x21},
>>> +	{MAX98363_R0051_SCP_DEV_ID_1, 0x01},
>>> +	{MAX98363_R0052_SCP_DEV_ID_2, 0x9F},
>>> +	{MAX98363_R0053_SCP_DEV_ID_3, 0x87},
>>> +	{MAX98363_R0054_SCP_DEV_ID_4, 0x08},
>>> +	{MAX98363_R0055_SCP_DEV_ID_5, 0x00},
> 
>> That seems wrong, why would you declare standard registers that are
>> known to the bus and required to be implemented?
> 
> This is the register defaults table, it gets used to initialise the
> register cache and optimise resync after suspend - all this does is
> supply defaults for the cache.  That said...
> 
> I would suggest it's better to not supply defaults for ID registers and
> read them back from the device otherwise things might get confused.

The 'device_id' register is the good counter example: it includes a
'unique_id' field to deal with cases where there are identical devices
on the same link. The unique_id is usually set with board-specific
pin-strapping, so there's no good default value here. In previous Maxim
98373 amplifier configurations the unique IDs were 3 and 7 IIRC. The
codec driver should not, rather shall not, assume any specific value here.

>>> +static const struct regmap_config max98363_sdw_regmap = {
>>> +	.reg_bits = 32,
>>> +	.val_bits = 8,
>>> +	.max_register = MAX98363_R21FF_REV_ID,
>>> +	.reg_defaults  = max98363_reg,
>>> +	.num_reg_defaults = ARRAY_SIZE(max98363_reg),
>>> +	.readable_reg = max98363_readable_register,
>>> +	.volatile_reg = max98363_volatile_reg,
> 
>> I don't see why the SoundWire standard registers are part of regmap?
> 
> ...if there's an issue with the SoundWire core modifying the registers
> directly then the driver would need to mark all the core registers as
> volatile so that they're not cached otherwise there will be collisions.
> Or is it the case that we always need to go via the SoundWire core for
> the generic registers, so they should just never be written at all?

It's really that the SoundWire core will 'own' or take care of all
'standard' programming registers. There is no good reason for a codec
driver to interfere with standard port programming or clock stop. The
bus provides a set of callbacks that can be used for vendor-specific
registers and sequences.

Put differently, SoundWire codec drivers should only deal with
non-standard vendor-specific registers.


> 
>>> +	if (max98363->dvddio) {
>>> +		ret = regulator_enable(max98363->dvddio);
>>> +		if (ret < 0)
>>> +			return ret;
>>> +	}
>>> +
>>> +	if (max98363->vdd) {
>>> +		ret = regulator_enable(max98363->vdd);
>>> +		if (ret < 0)
>>> +			return ret;
>>> +	}
> 
>> that is very very odd. It's the first time we see a SoundWire codec
>> driver that has a power dependency, and it's quite likely that it's too
>> late to enable power resources *AFTER* dealing with all the
>> initialization and enumeration.
> 
>> It's not even clear to me how this device would be enumerated.
> 
>> You'd need to explain what part of the amplifier is controlled by those
>> regulator, otherwise it's impossible to review and understand if the
>> driver does the 'right thing'
> 
> It's also buggy to have regulators treated as optional unless they may
> be physically absent.
