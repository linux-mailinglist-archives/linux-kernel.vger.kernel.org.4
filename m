Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445DC6FEDB5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 10:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbjEKIPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 04:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbjEKIP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 04:15:27 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3756444A9;
        Thu, 11 May 2023 01:15:21 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 725FA82B9;
        Thu, 11 May 2023 16:15:13 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 11 May
 2023 16:15:13 +0800
Received: from [192.168.120.57] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 11 May
 2023 16:15:12 +0800
Message-ID: <51981900-6447-8a77-1522-66b1ac0563c5@starfivetech.com>
Date:   Thu, 11 May 2023 16:15:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RESEND v3 2/2] pwm: starfive: Add PWM driver support
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hal Feng <hal.feng@starfivetech.com>
References: <20230321055228.105945-1-william.qiu@starfivetech.com>
 <20230321055228.105945-3-william.qiu@starfivetech.com>
 <ZC7U3MzdUX_TcA75@orome>
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <ZC7U3MzdUX_TcA75@orome>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/6 22:19, Thierry Reding wrote:
> On Tue, Mar 21, 2023 at 01:52:28PM +0800, William Qiu wrote:
>> Add Pulse Width Modulation driver support for StarFive
>> JH7110 soc.
> 
> s/soc/SoC/
> 
>> 
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> ---
>>  MAINTAINERS                    |   7 +
>>  drivers/pwm/Kconfig            |  10 ++
>>  drivers/pwm/Makefile           |   1 +
>>  drivers/pwm/pwm-starfive-ptc.c | 245 +++++++++++++++++++++++++++++++++
>>  4 files changed, 263 insertions(+)
>>  create mode 100644 drivers/pwm/pwm-starfive-ptc.c
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ac151975d0d3..efe1811f9501 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19929,6 +19929,13 @@ F:	drivers/pinctrl/starfive/pinctrl-starfive-jh71*
>>  F:	include/dt-bindings/pinctrl/pinctrl-starfive-jh7100.h
>>  F:	include/dt-bindings/pinctrl/starfive,jh7110-pinctrl.h
>> 
>> +STARFIVE JH71X0 PWM DRIVERS
>> +M:	William Qiu <william.qiu@starfivetech.com>
>> +M:	Hal Feng <hal.feng@starfivetech.com>
>> +S:	Supported
>> +F:	Documentation/devicetree/bindings/pwm/starfive,jh7110-pwm.yaml
>> +F:	drivers/pwm/pwm-starfive-ptc.c
>> +
>>  STARFIVE JH71X0 RESET CONTROLLER DRIVERS
>>  M:	Emil Renner Berthing <kernel@esmil.dk>
>>  M:	Hal Feng <hal.feng@starfivetech.com>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index dae023d783a2..2307a0099994 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -536,6 +536,16 @@ config PWM_SPRD
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called pwm-sprd.
>> 
>> +config PWM_STARFIVE_PTC
>> +	tristate "StarFive PWM PTC support"
>> +	depends on OF
>> +	depends on COMMON_CLK
> 
> You probably want HAS_IOMEM here as well, otherwise this will likely
> fail to build on some architectures.
> 
>> +	help
>> +	  Generic PWM framework driver for StarFive SoCs.
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called pwm-starfive-ptc.
>> +
>>  config PWM_STI
>>  	tristate "STiH4xx PWM support"
>>  	depends on ARCH_STI || COMPILE_TEST
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index 7bf1a29f02b8..577f69904baa 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -49,6 +49,7 @@ obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
>>  obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
>>  obj-$(CONFIG_PWM_SPEAR)		+= pwm-spear.o
>>  obj-$(CONFIG_PWM_SPRD)		+= pwm-sprd.o
>> +obj-$(CONFIG_PWM_STARFIVE_PTC)	+= pwm-starfive-ptc.o
>>  obj-$(CONFIG_PWM_STI)		+= pwm-sti.o
>>  obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
>>  obj-$(CONFIG_PWM_STM32_LP)	+= pwm-stm32-lp.o
>> diff --git a/drivers/pwm/pwm-starfive-ptc.c b/drivers/pwm/pwm-starfive-ptc.c
>> new file mode 100644
>> index 000000000000..239df796d240
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-starfive-ptc.c
>> @@ -0,0 +1,245 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * PWM driver for the StarFive JH7110 SoC
>> + *
>> + * Copyright (C) 2018 StarFive Technology Co., Ltd.
>> + */
>> +
>> +#include <dt-bindings/pwm/pwm.h>
> 
> You don't use anything from this, nor should you. Just drop it.
> 
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pwm.h>
>> +#include <linux/slab.h>
>> +#include <linux/clk.h>
>> +#include <linux/reset.h>
>> +#include <linux/io.h>
> 
> These should be in alphabetic order.
> 
>> +
>> +/* how many parameters can be transferred to ptc */
>> +#define OF_PWM_N_CELLS			3
> 
> You use this exactly once, so this definition is useless.
> 
>> +
>> +/* PTC Register offsets */
>> +#define REG_RPTC_CNTR			0x0
>> +#define REG_RPTC_HRC			0x4
>> +#define REG_RPTC_LRC			0x8
>> +#define REG_RPTC_CTRL			0xC
> 
> These seem to have been replaced by the REG_PTC_RPTC_* definitions
> below. Pick one and drop the other.
> 
>> +/* Bit for PWM clock */
>> +#define BIT_PWM_CLOCK_EN		31
>> +
>> +/* Bit for clock gen soft reset */
>> +#define BIT_CLK_GEN_SOFT_RESET		13
> 
> These two bit definitions seem to be completely unused.
> 
>> +
>> +#define NS_PER_SECOND			1000000000
> 
> Use the standard NSEC_PER_SEC.
> 
>> +
>> +/*
>> + * Access PTC register (cntr hrc lrc and ctrl),
>> + * need to replace PWM_BASE_ADDR
>> + */
>> +#define REG_PTC_BASE_ADDR_SUB(base, N)	\
>> +((base) + (((N) > 3) ? (((N) % 4) * 0x10 + (1 << 15)) : ((N) * 0x10)))
>> +#define REG_PTC_RPTC_CNTR(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N))
>> +#define REG_PTC_RPTC_HRC(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N) + 0x4)
>> +#define REG_PTC_RPTC_LRC(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N) + 0x8)
>> +#define REG_PTC_RPTC_CTRL(base, N)	(REG_PTC_BASE_ADDR_SUB(base, N) + 0xC)
>> +
>> +/* PTC_RPTC_CTRL */
>> +#define PTC_EN      BIT(0)
>> +#define PTC_ECLK    BIT(1)
>> +#define PTC_NEC     BIT(2)
>> +#define PTC_OE      BIT(3)
>> +#define PTC_SIGNLE  BIT(4)
>> +#define PTC_INTE    BIT(5)
>> +#define PTC_INT     BIT(6)
>> +#define PTC_CNTRRST BIT(7)
>> +#define PTC_CAPTE   BIT(8)
>> +
>> +struct starfive_pwm_ptc_device {
>> +	struct pwm_chip		chip;
>> +	struct clk		*clk;
>> +	struct reset_control	*rst;
>> +	void __iomem		*regs;
>> +	int			irq;
>> +	unsigned int		approx_freq;/*pwm apb clock frequency*/
> 
> No need for aligning these with tabs. Single space is enough for each of
> these.
> 
> Also, you're dealing with potentially large numbers here, so best to
> make the approx_freq unsigned long or perhaps even u64.
> 
>> +};
>> +
>> +static inline
>> +struct starfive_pwm_ptc_device *chip_to_starfive_ptc(struct pwm_chip *c)
>> +{
>> +	return container_of(c, struct starfive_pwm_ptc_device, chip);
>> +}
>> +
>> +static int starfive_pwm_ptc_get_state(struct pwm_chip *chip,
>> +				       struct pwm_device *dev,
>> +				       struct pwm_state *state)
>> +{
>> +	struct starfive_pwm_ptc_device *pwm = chip_to_starfive_ptc(chip);
>> +	u32 data_lrc, data_hrc;
>> +	u32 pwm_clk_ns = 0;
>> +
>> +	data_lrc = ioread32(REG_PTC_RPTC_LRC(pwm->regs, dev->hwpwm));
>> +	data_hrc = ioread32(REG_PTC_RPTC_HRC(pwm->regs, dev->hwpwm));
> 
> Why ioread32()? It doesn't look like this is getting used in some sort
> of I/O port setup, so you probably want readl()/writel() instead.
> 
>> +
>> +	pwm_clk_ns = NS_PER_SECOND / pwm->approx_freq;
>> +
>> +	state->period = data_lrc * pwm_clk_ns;
>> +	state->duty_cycle = data_hrc * pwm_clk_ns;
> 
> Again, you want data_lrc, data_hrc and pwm_clk_ns to be unsigned long
> or u64 to avoid overflow.
> 
>> +	state->polarity = PWM_POLARITY_NORMAL;
>> +	state->enabled = 1;
> 
> So these cannot be turned off? You seem to emulate enabled = false by
> setting duty cycle to 0 in starfive_pwm_ptc_apply(), so it's probably
> best to mirror that here.
> 
>> +
>> +	return 0;
>> +}
>> +
>> +static int starfive_pwm_ptc_apply(struct pwm_chip *chip,
>> +				  struct pwm_device *dev,
>> +				  struct pwm_state *state)
>> +{
>> +	struct starfive_pwm_ptc_device *pwm = chip_to_starfive_ptc(chip);
>> +	u32 data_hrc = 0;
>> +	u32 data_lrc = 0;
>> +	u32 period_data = 0;
>> +	u32 duty_data = 0;
> 
> Some of these can be condensed into a single line.
> 
>> +	s64 multi = pwm->approx_freq;
>> +	s64 div = NS_PER_SECOND;
> 
> NSEC_PER_SEC
> 
>> +	void __iomem *reg_addr;
>> +
>> +	if (state->duty_cycle > state->period)
>> +		state->duty_cycle = state->period;
>> +
>> +	while (multi % 10 == 0 && div % 10 == 0 && multi > 0 && div > 0) {
>> +		multi /= 10;
>> +		div /= 10;
>> +	}
>> +
>> +	period_data = (u32)(state->period * multi / div);
> 
> You're doing 64-bit multiplications and divisions here, which will
> likely trigger a build error on some platforms (typically 32-bit ARM).
> You should look using at the various helpers in linux/math64.h.
> 
>> +	if (abs(period_data * div / multi - state->period)
>> +	    > abs((period_data + 1) * div / multi - state->period) ||
>> +	    (state->period > 0 && period_data == 0))
>> +		period_data += 1;
> 
> We typically write this as period_data++;
> 
>> +
>> +	if (state->enabled) {
>> +		duty_data = (u32)(state->duty_cycle * multi / div);
>> +		if (abs(duty_data * div / multi - state->duty_cycle)
>> +			> abs((duty_data + 1) * div / multi - state->duty_cycle) ||
>> +			(state->duty_cycle > 0 && duty_data == 0))
>> +			duty_data += 1;
> 
> Same here. You may also want to create temporary variables for those
> abs() parameters (or the result) to make this a bit more readable.
> 
>> +	} else {
>> +		duty_data = 0;
>> +	}
>> +
>> +	if (state->polarity == PWM_POLARITY_NORMAL)
>> +		data_hrc = period_data - duty_data;
>> +	else
>> +		data_hrc = duty_data;
> 
> That's not how we do polarity inversion. If you need period - duty for
> normal polarity, that probably indicates that your PWM supports inverse
> polarity natively. Furthermore the above seems to only consider the
> output power when reversing polarity, which is not correct. If you need
> this for the likes of pwm-fan, then you should look at inverting the
> polarity in those drivers.
> 
>> +
>> +	data_lrc = period_data;
>> +
>> +	reg_addr = REG_PTC_RPTC_HRC(pwm->regs, dev->hwpwm);
>> +	iowrite32(data_hrc, reg_addr);
>> +
>> +	reg_addr = REG_PTC_RPTC_LRC(pwm->regs, dev->hwpwm);
>> +	iowrite32(data_lrc, reg_addr);
>> +
>> +	reg_addr = REG_PTC_RPTC_CNTR(pwm->regs, dev->hwpwm);
>> +	iowrite32(0, reg_addr);
>> +
>> +	reg_addr = REG_PTC_RPTC_CTRL(pwm->regs, dev->hwpwm);
>> +	iowrite32(PTC_EN | PTC_OE, reg_addr);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct pwm_ops starfive_pwm_ptc_ops = {
>> +	.get_state	= starfive_pwm_ptc_get_state,
>> +	.apply		= (void *)starfive_pwm_ptc_apply,
> 
> Why do you need to cast this? Also, drop the extra padding.
> 
>> +	.owner		= THIS_MODULE,
>> +};
>> +
>> +static int starfive_pwm_ptc_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct starfive_pwm_ptc_device *pwm;
>> +	struct pwm_chip *chip;
>> +	int ret;
>> +
>> +	pwm = devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
>> +	if (!pwm)
>> +		return -ENOMEM;
>> +
>> +	chip = &pwm->chip;
>> +	chip->dev = dev;
>> +	chip->ops = &starfive_pwm_ptc_ops;
>> +	chip->npwm = 8;
>> +
>> +	chip->of_pwm_n_cells = OF_PWM_N_CELLS;
> 
> Simply use the literal "3" here. It's sufficiently clear from the
> context what this means, so it's not a "magic" value or anything.
> 
>> +	chip->base = -1;
> 
> This is no longer needed.
> 
>> +
>> +	pwm->regs = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(pwm->regs))
>> +		return dev_err_probe(dev, PTR_ERR(pwm->regs),
>> +					"Unable to map IO resources\n");
> 
> The string on the second line should be aligned with "dev" from the
> first line. Same for the errors below.
> 
>> +
>> +	pwm->clk = devm_clk_get(dev, NULL);
>> +	if (IS_ERR(pwm->clk))
>> +		return dev_err_probe(dev, PTR_ERR(pwm->clk),
>> +					"Unable to get pwm clock\n");
>> +
>> +	pwm->rst = devm_reset_control_get_exclusive(dev, NULL);
>> +	if (IS_ERR(pwm->rst))
>> +		return dev_err_probe(dev, PTR_ERR(pwm->rst),
>> +					"Unable to get pwm reset\n");
>> +
>> +	ret = clk_prepare_enable(pwm->clk);
>> +	if (ret) {
>> +		dev_err(dev,
>> +			"Failed to enable pwm clock, %d\n", ret);
> 
> s/pwm/PWM/ in the strings above. And why not use dev_err_probe() here as
> well?
> 
>> +		return ret;
>> +	}
>> +
>> +	reset_control_deassert(pwm->rst);
>> +
>> +	pwm->approx_freq = (unsigned int)clk_get_rate(pwm->clk);
> 
> Drop the cast. It's not needed.
> 
>> +	if (!pwm->approx_freq)
>> +		dev_err(dev, "get pwm apb clock rate failed.\n");
> 
> Don't you want to make this fatal? If not, you'll end up dividing by
> zero in ->get_state(). Also, you may want to reword the error message to
> be more in line with the others in this function. Perhaps something
> like:
> 
> 	dev_err(dev, "failed to get APB clock rate\n");
> 
>> +
>> +	ret = devm_pwmchip_add(dev, chip);
>> +	if (ret < 0) {
>> +		dev_err(dev, "cannot register PTC: %d\n", ret);
>> +		clk_disable_unprepare(pwm->clk);
> 
> Maybe reset_control_assert() here as well?
> 
>> +		return ret;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, pwm);
>> +
>> +	return 0;
>> +}
>> +
>> +static int starfive_pwm_ptc_remove(struct platform_device *dev)
>> +{
>> +	struct starfive_pwm_ptc_device *pwm = platform_get_drvdata(dev);
>> +	struct pwm_chip *chip = &pwm->chip;
>> +
>> +	pwmchip_remove(chip);
> 
> No need for the temporary variable, you can pass &pwm->chip directly to
> pwmchip_remove().
> 
>> +
>> +	return 0;
>> +}
> 
> You may want to use the ->remove_new() callback instead since the error
> code return is misleading.
> 
> Although, I just noticed that you use devm_pwmchip_add(), so there
> should be no need for the remove callback at all.
> 
> Thierry
> 
>> +
>> +static const struct of_device_id starfive_pwm_ptc_of_match[] = {
>> +	{ .compatible = "starfive,jh7110-pwm" },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, starfive_pwm_ptc_of_match);
>> +
>> +static struct platform_driver starfive_pwm_ptc_driver = {
>> +	.probe = starfive_pwm_ptc_probe,
>> +	.remove = starfive_pwm_ptc_remove,
>> +	.driver = {
>> +		.name = "pwm-starfive-ptc",
>> +		.of_match_table = starfive_pwm_ptc_of_match,
>> +	},
>> +};
>> +module_platform_driver(starfive_pwm_ptc_driver);
>> +
>> +MODULE_AUTHOR("Jenny Zhang <jenny.zhang@starfivetech.com>");
>> +MODULE_AUTHOR("Hal Feng <hal.feng@starfivetech.com>");
>> +MODULE_DESCRIPTION("StarFive PWM PTC driver");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.34.1
>> 
Hi Thierry,

I'm sorry to bother you. I wonder if you have seen the previous email.
Regarding the realization of polarity inversion, I wonder if you have
any suggestions for me.
Thanks for taking time to give useful suggestions.

Best regards,
William
