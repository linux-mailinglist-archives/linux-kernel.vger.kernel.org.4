Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057875BBEAF
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 17:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiIRPbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 11:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiIRPbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 11:31:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAAE1C93E;
        Sun, 18 Sep 2022 08:31:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37616B80E4F;
        Sun, 18 Sep 2022 15:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B26BC433C1;
        Sun, 18 Sep 2022 15:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663515109;
        bh=Urw5zSSjzhlS0NoVxdxjqpzKwEtwDkvTEQpH87UVT2o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cb9sJaqd0vA3K/Tm47XHd5ENC2Z5G4twTD6k8giAGFPwotDcUwQWnCi7ksMMw78+d
         r1UVU1Q5hXUhgGdG6kzNvvHqFiD6UhmkGqACBIVu0JA8lU01KY81evwh8LaXOct8v9
         53VI7t8GtF+fObmJ2LuiAXw2uF2uggNNePt8kchRXrxWnur5sGAtQUEn3g9y6Q7NZz
         PSWTkdt3Xbz34WZQfLXjbX8B6OHomdI5EAR64/hRtyUK3FF1pLN1NFJLeQ1/9iEgrT
         cNYhKH0q+B7rRIbTi/Ccn9l7732aCifYcBjmWOIK1WTkoKnJ/0HTpmVy7AF7Q9Z/A8
         PMKrraxkofVwQ==
Date:   Sun, 18 Sep 2022 16:31:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Yannick Brosseau <yannick.brosseau@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 1/1] iio: adc: stm32-adc: add id registers support
Message-ID: <20220918163151.4dfbb714@jic23-huawei>
In-Reply-To: <588d5730-4763-ce1d-5e91-1e3973f054f5@foss.st.com>
References: <20220915135452.1712453-1-olivier.moysan@foss.st.com>
        <588d5730-4763-ce1d-5e91-1e3973f054f5@foss.st.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sep 2022 15:43:58 +0200
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> On 9/15/22 15:54, Olivier Moysan wrote:
> > Add support of identification registers to STM32 ADC.
> > 
> > By default the ADC hardware instance number is retrieved from
> > the compatible configuration data. Get the available ADC number
> > per ADC block, from hardware configuration register,
> > when this register exists.
> > 
> > Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>  
> 
> Hi Olivier,
> 
> You can add my:
> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Applied to the togreg branch of iio.git and pushed out as testing for 
0-day to see if it can find anything we missed.

Thanks,

Jonathan

> 
> Thanks and Best Regards,
> Fabrice
> 
> > ---
> >  drivers/iio/adc/stm32-adc-core.c | 59 ++++++++++++++++++++++++++++++--
> >  drivers/iio/adc/stm32-adc-core.h | 31 +++++++++++++++++
> >  2 files changed, 87 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> > index 1ce52af3fe8b..81d5db91c67b 100644
> > --- a/drivers/iio/adc/stm32-adc-core.c
> > +++ b/drivers/iio/adc/stm32-adc-core.c
> > @@ -9,6 +9,7 @@
> >   *
> >   */
> >  
> > +#include <linux/bitfield.h>
> >  #include <linux/clk.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/irqchip/chained_irq.h>
> > @@ -62,6 +63,7 @@ struct stm32_adc_priv;
> >   * @regs:	common registers for all instances
> >   * @clk_sel:	clock selection routine
> >   * @max_clk_rate_hz: maximum analog clock rate (Hz, from datasheet)
> > + * @ipid:	adc identification number
> >   * @has_syscfg: SYSCFG capability flags
> >   * @num_irqs:	number of interrupt lines
> >   * @num_adcs:   maximum number of ADC instances in the common registers
> > @@ -70,6 +72,7 @@ struct stm32_adc_priv_cfg {
> >  	const struct stm32_adc_common_regs *regs;
> >  	int (*clk_sel)(struct platform_device *, struct stm32_adc_priv *);
> >  	u32 max_clk_rate_hz;
> > +	u32 ipid;
> >  	unsigned int has_syscfg;
> >  	unsigned int num_irqs;
> >  	unsigned int num_adcs;
> > @@ -78,6 +81,7 @@ struct stm32_adc_priv_cfg {
> >  /**
> >   * struct stm32_adc_priv - stm32 ADC core private data
> >   * @irq:		irq(s) for ADC block
> > + * @nb_adc_max:		actual maximum number of instance per ADC block
> >   * @domain:		irq domain reference
> >   * @aclk:		clock reference for the analog circuitry
> >   * @bclk:		bus clock common for all ADCs, depends on part used
> > @@ -95,6 +99,7 @@ struct stm32_adc_priv_cfg {
> >   */
> >  struct stm32_adc_priv {
> >  	int				irq[STM32_ADC_MAX_ADCS];
> > +	unsigned int			nb_adc_max;
> >  	struct irq_domain		*domain;
> >  	struct clk			*aclk;
> >  	struct clk			*bclk;
> > @@ -354,7 +359,7 @@ static void stm32_adc_irq_handler(struct irq_desc *desc)
> >  	 * before invoking the interrupt handler (e.g. call ISR only for
> >  	 * IRQ-enabled ADCs).
> >  	 */
> > -	for (i = 0; i < priv->cfg->num_adcs; i++) {
> > +	for (i = 0; i < priv->nb_adc_max; i++) {
> >  		if ((status & priv->cfg->regs->eoc_msk[i] &&
> >  		     stm32_adc_eoc_enabled(priv, i)) ||
> >  		     (status & priv->cfg->regs->ovr_msk[i]))
> > @@ -424,7 +429,7 @@ static void stm32_adc_irq_remove(struct platform_device *pdev,
> >  	int hwirq;
> >  	unsigned int i;
> >  
> > -	for (hwirq = 0; hwirq < STM32_ADC_MAX_ADCS; hwirq++)
> > +	for (hwirq = 0; hwirq < priv->nb_adc_max; hwirq++)
> >  		irq_dispose_mapping(irq_find_mapping(priv->domain, hwirq));
> >  	irq_domain_remove(priv->domain);
> >  
> > @@ -642,6 +647,49 @@ static int stm32_adc_core_switches_probe(struct device *dev,
> >  	return 0;
> >  }
> >  
> > +static int stm32_adc_probe_identification(struct platform_device *pdev,
> > +					  struct stm32_adc_priv *priv)
> > +{
> > +	struct device_node *np = pdev->dev.of_node;
> > +	struct device_node *child;
> > +	const char *compat;
> > +	int ret, count = 0;
> > +	u32 id, val;
> > +
> > +	if (!priv->cfg->ipid)
> > +		return 0;
> > +
> > +	id = FIELD_GET(STM32MP1_IPIDR_MASK,
> > +		       readl_relaxed(priv->common.base + STM32MP1_ADC_IPDR));
> > +	if (id != priv->cfg->ipid) {
> > +		dev_err(&pdev->dev, "Unexpected IP version: 0x%x", id);
> > +		return -EINVAL;
> > +	}
> > +
> > +	for_each_child_of_node(np, child) {
> > +		ret = of_property_read_string(child, "compatible", &compat);
> > +		if (ret)
> > +			continue;
> > +		/* Count child nodes with stm32 adc compatible */
> > +		if (strstr(compat, "st,stm32") && strstr(compat, "adc"))
> > +			count++;
> > +	}
> > +
> > +	val = readl_relaxed(priv->common.base + STM32MP1_ADC_HWCFGR0);
> > +	priv->nb_adc_max = FIELD_GET(STM32MP1_ADCNUM_MASK, val);
> > +	if (count > priv->nb_adc_max) {
> > +		dev_err(&pdev->dev, "Unexpected child number: %d", count);
> > +		return -EINVAL;
> > +	}
> > +
> > +	val = readl_relaxed(priv->common.base + STM32MP1_ADC_VERR);
> > +	dev_dbg(&pdev->dev, "ADC version: %lu.%lu\n",
> > +		FIELD_GET(STM32MP1_MAJREV_MASK, val),
> > +		FIELD_GET(STM32MP1_MINREV_MASK, val));
> > +
> > +	return 0;
> > +}
> > +
> >  static int stm32_adc_probe(struct platform_device *pdev)
> >  {
> >  	struct stm32_adc_priv *priv;
> > @@ -661,6 +709,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
> >  
> >  	priv->cfg = (const struct stm32_adc_priv_cfg *)
> >  		of_match_device(dev->driver->of_match_table, dev)->data;
> > +	priv->nb_adc_max = priv->cfg->num_adcs;
> >  	spin_lock_init(&priv->common.lock);
> >  
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > @@ -703,6 +752,10 @@ static int stm32_adc_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		goto err_pm_stop;
> >  
> > +	ret = stm32_adc_probe_identification(pdev, priv);
> > +	if (ret < 0)
> > +		goto err_hw_stop;
> > +
> >  	ret = regulator_get_voltage(priv->vref);
> >  	if (ret < 0) {
> >  		dev_err(&pdev->dev, "vref get voltage failed, %d\n", ret);
> > @@ -811,8 +864,8 @@ static const struct stm32_adc_priv_cfg stm32mp1_adc_priv_cfg = {
> >  	.clk_sel = stm32h7_adc_clk_sel,
> >  	.max_clk_rate_hz = 36000000,
> >  	.has_syscfg = HAS_VBOOSTER | HAS_ANASWVDD,
> > +	.ipid = STM32MP15_IPIDR_NUMBER,
> >  	.num_irqs = 2,
> > -	.num_adcs = 2,
> >  };
> >  
> >  static const struct of_device_id stm32_adc_of_match[] = {
> > diff --git a/drivers/iio/adc/stm32-adc-core.h b/drivers/iio/adc/stm32-adc-core.h
> > index faedf7a49555..2118ef63843d 100644
> > --- a/drivers/iio/adc/stm32-adc-core.h
> > +++ b/drivers/iio/adc/stm32-adc-core.h
> > @@ -24,6 +24,7 @@
> >   * | 0x300  |         Master & Slave common regs          |
> >   * --------------------------------------------------------
> >   */
> > +/* Maximum ADC instances number per ADC block for all supported SoCs */
> >  #define STM32_ADC_MAX_ADCS		3
> >  #define STM32_ADC_OFFSET		0x100
> >  #define STM32_ADCX_COMN_OFFSET		0x300
> > @@ -105,6 +106,12 @@
> >  /* STM32MP1 - ADC2 instance option register */
> >  #define STM32MP1_ADC2_OR		0xD0
> >  
> > +/* STM32MP1 - Identification registers */
> > +#define STM32MP1_ADC_HWCFGR0		0x3F0
> > +#define STM32MP1_ADC_VERR		0x3F4
> > +#define STM32MP1_ADC_IPDR		0x3F8
> > +#define STM32MP1_ADC_SIDR		0x3FC
> > +
> >  /* STM32H7 - common registers for all ADC instances */
> >  #define STM32H7_ADC_CSR			(STM32_ADCX_COMN_OFFSET + 0x00)
> >  #define STM32H7_ADC_CCR			(STM32_ADCX_COMN_OFFSET + 0x08)
> > @@ -181,6 +188,30 @@ enum stm32h7_adc_dmngt {
> >  /* STM32MP1_ADC2_OR - bit fields */
> >  #define STM32MP1_VDDCOREEN		BIT(0)
> >  
> > +/* STM32MP1_ADC_HWCFGR0 - bit fields */
> > +#define STM32MP1_ADCNUM_SHIFT		0
> > +#define STM32MP1_ADCNUM_MASK		GENMASK(3, 0)
> > +#define STM32MP1_MULPIPE_SHIFT		4
> > +#define STM32MP1_MULPIPE_MASK		GENMASK(7, 4)
> > +#define STM32MP1_OPBITS_SHIFT		8
> > +#define STM32MP1_OPBITS_MASK		GENMASK(11, 8)
> > +#define STM32MP1_IDLEVALUE_SHIFT	12
> > +#define STM32MP1_IDLEVALUE_MASK	GENMASK(15, 12)
> > +
> > +/* STM32MP1_ADC_VERR - bit fields */
> > +#define STM32MP1_MINREV_SHIFT		0
> > +#define STM32MP1_MINREV_MASK		GENMASK(3, 0)
> > +#define STM32MP1_MAJREV_SHIFT		4
> > +#define STM32MP1_MAJREV_MASK		GENMASK(7, 4)
> > +
> > +/* STM32MP1_ADC_IPDR - bit fields */
> > +#define STM32MP1_IPIDR_MASK		GENMASK(31, 0)
> > +
> > +/* STM32MP1_ADC_SIDR - bit fields */
> > +#define STM32MP1_SIDR_MASK		GENMASK(31, 0)
> > +
> > +#define STM32MP15_IPIDR_NUMBER		0x00110005
> > +
> >  /**
> >   * struct stm32_adc_common - stm32 ADC driver common data (for all instances)
> >   * @base:		control registers base cpu addr  

