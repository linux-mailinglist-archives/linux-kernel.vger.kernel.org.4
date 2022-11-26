Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA76639388
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 04:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiKZDDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 22:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiKZDDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 22:03:30 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D7B31FB9;
        Fri, 25 Nov 2022 19:03:29 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id D62D45C00A9;
        Fri, 25 Nov 2022 22:03:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 25 Nov 2022 22:03:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669431806; x=
        1669518206; bh=jKSOJ0vxyid9Dgy0Kfkl4AhIBUfl/N9hmjFMfQRINPo=; b=q
        PXMZ5hIYAuBnSwmjB/NX4Ck3RKa87H0XJJI0FlfpxGUATmDHRgV+uwp+1Nz1D4xV
        KTH2F+QzQtmRbLx64+TdkDKwnQ/Xa6td2ZnuZA8HgMvEngtlWjKl7XnzQsCdmQUE
        l1qUl+7eDeXJOv+SmRpnT4I3Jc2Q1LibTXJiQxlZrFRolxpeWt+TZmu+NMqhP0d7
        ivy46xit2C1BEd7QWEh6h9dF9hx8OHxh2ycbigbyb5HXWNurom9MLFhUltApr1rX
        wG8kG8auuxfEGjAtxAbqb+8X9qpa+DZE41N6Dznzz4jyoQwU4D/Pb/ALUL7wyXJg
        LiCCDR3IqZbdf11Z3gIyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669431806; x=
        1669518206; bh=jKSOJ0vxyid9Dgy0Kfkl4AhIBUfl/N9hmjFMfQRINPo=; b=G
        EYWpkgnE3argSfdOn7P1twpFwNNt6V/cIff6vE81EhrJXLDz15sgCVeQ2x7cmliD
        iXTKDMrE67qlBLwHo0qjzSvulJ/bFaedWz3dz3X5o+gsgADK4biwz/kjOXeNFYaT
        3VUcebzQ1ntUEUM9WiOlE80IWXxAKOQ8P6fYpOviXv4fsjqmo/9co0o/u2u4UZni
        fgytkNcZ0H18SE2oBaXUzw5bXFrRvHtAf6mo/qt/c4rxOp6ERc3eF5ffFG+g0Wd0
        5DpYLfmk65owB7WR7EOzDLRoZzFKC9W4dT3miydKiDhU+afZpVkUU1Aq31ASXKgC
        IMmLJRRmb0+OIz9JSMRzg==
X-ME-Sender: <xms:_oGBYxAkH7QyD_I9LVdRD2w3HxJ_udV6-SU22zWva9p1rcLJauGZlQ>
    <xme:_oGBY_jWXhKqW_VLq_Yt_NzMY0oeZMDEaNcft8srZTmvQNJ5CPAsJmeAbXnyJZGny
    M3pmtdRSR9m-vjKAg>
X-ME-Received: <xmr:_oGBY8mvhDuFTCcrLIxJrvJh1psns2OFQqG97Y3rlfB7KsgMwEVQ0T9T0h0nL2r7AFGcMhNhr8CXVSs6UlWkdCf4usOXoHFssrN0DjZW2rESvP7d3P7KHUKpzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieeigdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepjefgfffhudejfedtuedugeeutdetgfeiteffffehjeeugfeuvdeh
    jeetfedtffdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:_oGBY7zanC2IIgmAyyeAq91Vvaub9h-Y78-NIRErClsMlxe4m6k-0A>
    <xmx:_oGBY2TO4UGb7o7Fy8wb1hGhtl--P7vx0ywiIurXKtpi0tajhXCtxQ>
    <xmx:_oGBY-ZUqWnT05Ae0mHjWfaVi_RAuVMO6sEHLqWsq_GKAcpYBoay8Q>
    <xmx:_oGBY9IgT230p5stRfoc8MFB29F4iC9krik7wqeb8HdxRafWtDHVhA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Nov 2022 22:03:25 -0500 (EST)
Message-ID: <3ee22b0e-2010-1cf6-bca8-3c803d73d7f9@sholland.org>
Date:   Fri, 25 Nov 2022 21:03:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiko Stuebner <heiko@sntech.de>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20221125040112.18160-1-samuel@sholland.org>
 <20221125040112.18160-3-samuel@sholland.org>
 <20221126002243.37b1034d@slackpad.lan>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v4 2/4] regulator: sun20i: Add Allwinner D1 LDOs driver
In-Reply-To: <20221126002243.37b1034d@slackpad.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

On 11/25/22 18:22, Andre Przywara wrote:
> On Thu, 24 Nov 2022 22:01:10 -0600
> Samuel Holland <samuel@sholland.org> wrote:
> 
> Hi Samuel,
> 
>> D1 contains two pairs of LDOs, "analog" LDOs and "system" LDOs. They are
>> similar and can share a driver, but only the system LDOs have a DT
>> binding defined so far.
>>
>> The system LDOs have a single linear range. The voltage step is not an
>> integer, so a custom .list_voltage is needed to get the rounding right.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>> Changes in v4:
>>  - Drop the analog LDOs until the codec binding is ready
>>
>> Changes in v3:
>>  - Adjust control flow in sun20i_regulator_get_regmap() for clarity
>>
>> Changes in v2:
>>  - Use decimal numbers for .n_voltages instead of field widths
>>  - Get the regmap from the parent device instead of a property/phandle
>>
>>  drivers/regulator/Kconfig            |   8 ++
>>  drivers/regulator/Makefile           |   1 +
>>  drivers/regulator/sun20i-regulator.c | 150 +++++++++++++++++++++++++++
>>  3 files changed, 159 insertions(+)
>>  create mode 100644 drivers/regulator/sun20i-regulator.c
>>
>> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
>> index 070e4403c6c2..8480532114c1 100644
>> --- a/drivers/regulator/Kconfig
>> +++ b/drivers/regulator/Kconfig
>> @@ -1280,6 +1280,14 @@ config REGULATOR_STW481X_VMMC
>>  	  This driver supports the internal VMMC regulator in the STw481x
>>  	  PMIC chips.
>>  
>> +config REGULATOR_SUN20I
>> +	tristate "Allwinner D1 internal LDOs"
>> +	depends on ARCH_SUNXI || COMPILE_TEST
>> +	select MFD_SYSCON
>> +	default ARCH_SUNXI
>> +	help
>> +	  This driver supports the internal LDOs in the Allwinner D1 SoC.
>> +
>>  config REGULATOR_SY7636A
>>  	tristate "Silergy SY7636A voltage regulator"
>>  	depends on MFD_SY7636A
>> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
>> index 5962307e1130..8e9b5a21123d 100644
>> --- a/drivers/regulator/Makefile
>> +++ b/drivers/regulator/Makefile
>> @@ -150,6 +150,7 @@ obj-$(CONFIG_REGULATOR_STM32_VREFBUF) += stm32-vrefbuf.o
>>  obj-$(CONFIG_REGULATOR_STM32_PWR) += stm32-pwr.o
>>  obj-$(CONFIG_REGULATOR_STPMIC1) += stpmic1_regulator.o
>>  obj-$(CONFIG_REGULATOR_STW481X_VMMC) += stw481x-vmmc.o
>> +obj-$(CONFIG_REGULATOR_SUN20I) += sun20i-regulator.o
>>  obj-$(CONFIG_REGULATOR_SY7636A) += sy7636a-regulator.o
>>  obj-$(CONFIG_REGULATOR_SY8106A) += sy8106a-regulator.o
>>  obj-$(CONFIG_REGULATOR_SY8824X) += sy8824x.o
>> diff --git a/drivers/regulator/sun20i-regulator.c b/drivers/regulator/sun20i-regulator.c
>> new file mode 100644
>> index 000000000000..031bcc3dee50
>> --- /dev/null
>> +++ b/drivers/regulator/sun20i-regulator.c
>> @@ -0,0 +1,150 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +//
>> +// Copyright (c) 2021-2022 Samuel Holland <samuel@sholland.org>
>> +//
>> +
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/regulator/driver.h>
>> +
>> +#define SUN20I_SYS_LDO_CTRL_REG		0x150
>> +
>> +struct sun20i_regulator_data {
>> +	const struct regulator_desc	*descs;
>> +	unsigned int			ndescs;
>> +};
>> +
>> +/* regulator_list_voltage_linear() modified for the non-integral uV_step. */
>> +static int sun20i_d1_system_ldo_list_voltage(struct regulator_dev *rdev,
>> +					     unsigned int selector)
>> +{
>> +	const struct regulator_desc *desc = rdev->desc;
>> +	unsigned int uV;
>> +
>> +	if (selector >= desc->n_voltages)
>> +		return -EINVAL;
>> +
>> +	uV = desc->min_uV + (desc->uV_step * selector);
>> +
>> +	/* Produce correctly-rounded absolute voltages. */
>> +	return uV + ((selector + 1 + (desc->min_uV % 4)) / 3);
>> +}
>> +
>> +static const struct regulator_ops sun20i_d1_system_ldo_ops = {
>> +	.list_voltage		= sun20i_d1_system_ldo_list_voltage,
>> +	.map_voltage		= regulator_map_voltage_ascend,
>> +	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
>> +	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
>> +};
>> +
>> +static const struct regulator_desc sun20i_d1_system_ldo_descs[] = {
>> +	{
>> +		.name		= "ldoa",
>> +		.supply_name	= "ldo-in",
>> +		.of_match	= "ldoa",
>> +		.ops		= &sun20i_d1_system_ldo_ops,
>> +		.type		= REGULATOR_VOLTAGE,
>> +		.owner		= THIS_MODULE,
>> +		.n_voltages	= 32,
>> +		.min_uV		= 1600000,
>> +		.uV_step	= 13333, /* repeating */
> 
> So while I see that those values are probably the closest we can with a
> simple linear algorithm, they first two values seem to be slightly off
> from those values in the manual:
> sel diff algor  manual
>  0:   7 (1.600 - 1.593)
>  1:   6 (1.613 - 1.607)
> Oddly enough the rest of the values are spot on.
> I don't know if this really matters, or if the LDOs are actually
> accurate enough to that level of precision, or if it's a manual bug, or
> if we really care at all, but it might warrant some comment, I guess?
> I just got triggered by the min value not being the first value in the
> list.

Whoops, I did the math based on the default 1.8 V and after some spot
checks assumed the range was linear. I should have noticed this.

Conveniently, LDOB is unused on most boards, so I can measure the range
directly. The INA219 I'm using gives me a 4 mV LSB in its most precise
mode, which I'm averaging to get 2 mV precision.

reg     measure manual  diff
============================
0x00:   1.160   1.167   -7
0x08:   1.266   1.273   -7
0x09:   1.280   1.287   -7
0x0a:   1.292   1.300   -8
0x0b:   1.306   1.313   -7
0x0c:   1.320   1.327   -7
0x0d:   1.332   1.340   -8
0x0e:   1.346   1.353   -7
0x0f:   1.360   1.367   -7
0x10:   1.372   1.380   -8
0x18:   1.480   1.487   -7
0x1c:   1.532   1.540   -8
0x1d:   1.546   1.553   -7
0x1e:   1.560   1.567   -7
0x1f:   1.572   1.580   -8
0x20:   1.586   1.593   -7 <<
0x21:   1.600   1.607   -7 <<
0x22:   1.620   1.627   -7 <<
0x23:   1.632   1.640   -8 <<
0x24:   1.646   1.653   -7
0x25:   1.660   1.667   -7
0x26:   1.672   1.680   -8
0x27:   1.686   1.693   -7
0x28:   1.700   1.707   -7
0x30:   1.806   1.813   -7
0x38:   1.912   1.920   -8
0x3e:   1.992   2.000   -8
0x3f:   2.006   2.013   -7

So it looks like the LDOs are accurate, and the manual is quite correct.

I'm willing to blame the constant offset on my crude test setup.

>> +		.vsel_reg	= SUN20I_SYS_LDO_CTRL_REG,
>> +		.vsel_mask	= GENMASK(7, 0),
>> +	},
>> +	{
>> +		.name		= "ldob",
>> +		.supply_name	= "ldo-in",
>> +		.of_match	= "ldob",
>> +		.ops		= &sun20i_d1_system_ldo_ops,
>> +		.type		= REGULATOR_VOLTAGE,
>> +		.owner		= THIS_MODULE,
>> +		.n_voltages	= 64,
>> +		.min_uV		= 1166666,
>> +		.uV_step	= 13333, /* repeating */
> 
> For LDOB it seems to be worse, as the second half is constantly off by
> what looks like 6.666mV:
> sel diff algor  manual
> ...
> 32:   0 (1.593 - 1.593)
> 33:   0 (1.607 - 1.607)
> 34:  -7 (1.620 - 1.627)
> 35:  -7 (1.633 - 1.64)
> 36:  -6 (1.647 - 1.653)
> ...
> 63:  -6 (2.007 - 2.013)
> The first half is correct, though. Closer inspection reveals that
> everything with bit 5 set is exactly the same as LDOA. Maybe we can use
> that to our advantage?

Since I already have a custom .list_voltage implementation, I think the
simplest solution is:

	if (uV >= 1620000)
		uV += 7000;

or similar to get the rounding right.

Regards,
Samuel

> Cheers,
> Andre
> 
>> +		.vsel_reg	= SUN20I_SYS_LDO_CTRL_REG,
>> +		.vsel_mask	= GENMASK(15, 8),
>> +	},
>> +};
>> +
>> +static const struct sun20i_regulator_data sun20i_d1_system_ldos = {
>> +	.descs	= sun20i_d1_system_ldo_descs,
>> +	.ndescs	= ARRAY_SIZE(sun20i_d1_system_ldo_descs),
>> +};
>> +
>> +static struct regmap *sun20i_regulator_get_regmap(struct device *dev)
>> +{
>> +	struct regmap *regmap;
>> +
>> +	/*
>> +	 * First try the syscon interface. The system control device is not
>> +	 * compatible with "syscon", so fall back to getting the regmap from
>> +	 * its platform device. This is ugly, but required for devicetree
>> +	 * backward compatibility.
>> +	 */
>> +	regmap = syscon_node_to_regmap(dev->parent->of_node);
>> +	if (!IS_ERR(regmap))
>> +		return regmap;
>> +
>> +	regmap = dev_get_regmap(dev->parent, NULL);
>> +	if (regmap)
>> +		return regmap;
>> +
>> +	return ERR_PTR(-EPROBE_DEFER);
>> +}
>> +
>> +static int sun20i_regulator_probe(struct platform_device *pdev)
>> +{
>> +	const struct sun20i_regulator_data *data;
>> +	struct device *dev = &pdev->dev;
>> +	struct regulator_config config;
>> +	struct regmap *regmap;
>> +
>> +	data = of_device_get_match_data(dev);
>> +	if (!data)
>> +		return -EINVAL;
>> +
>> +	regmap = sun20i_regulator_get_regmap(dev);
>> +	if (IS_ERR(regmap))
>> +		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to get regmap\n");
>> +
>> +	config = (struct regulator_config) {
>> +		.dev	= dev,
>> +		.regmap	= regmap,
>> +	};
>> +
>> +	for (unsigned int i = 0; i < data->ndescs; ++i) {
>> +		const struct regulator_desc *desc = &data->descs[i];
>> +		struct regulator_dev *rdev;
>> +
>> +		rdev = devm_regulator_register(dev, desc, &config);
>> +		if (IS_ERR(rdev))
>> +			return PTR_ERR(rdev);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id sun20i_regulator_of_match[] = {
>> +	{
>> +		.compatible = "allwinner,sun20i-d1-system-ldos",
>> +		.data = &sun20i_d1_system_ldos,
>> +	},
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, sun20i_regulator_of_match);
>> +
>> +static struct platform_driver sun20i_regulator_driver = {
>> +	.probe	= sun20i_regulator_probe,
>> +	.driver	= {
>> +		.name		= "sun20i-regulator",
>> +		.of_match_table	= sun20i_regulator_of_match,
>> +	},
>> +};
>> +module_platform_driver(sun20i_regulator_driver);
>> +
>> +MODULE_AUTHOR("Samuel Holland <samuel@sholland.org>");
>> +MODULE_DESCRIPTION("Allwinner D1 internal LDO driver");
>> +MODULE_LICENSE("GPL");
> 

