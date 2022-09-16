Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2655BAE6F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiIPNov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiIPNop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:44:45 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189F025C74;
        Fri, 16 Sep 2022 06:44:40 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28GADlR1032059;
        Fri, 16 Sep 2022 15:44:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=xe7aa58AlbGv8DFUTMT83bvUVMrUXqMK8t3YslHOUOs=;
 b=epTgsIJWnxGrhJG0OpZSv5+zej8whAdrPpZ4LJPOvqUC7bflvfsLwKMcQN7H/k1b1Uj5
 ZscAwmLeYZxCdsFllNO5Ssgk7NDyONN2mShuKWi8EjgZDF4ZQE5VDwGU1UYlF8INj1T/
 /9NJ5Wy4sT8MWXcaDJF7MbZabxXpnXtO35rkvXsO8xztWKIYn9s5uenw4ZvXVuPYAF29
 C7ttqn3kshlBISnapVUoX8lwpudrMKK6Q0dutReAViG8dMKB6dlzp89mtbyOGt0Aqcsy
 GFyAIqZq/Uma5Uzu7wP2WISjgTyP5DfKPHDgPiGNTnpmaOoBCoymVQfz7P+Urs0cU/rh bw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jm8yuwvtf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 15:44:03 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EAEDF10002A;
        Fri, 16 Sep 2022 15:44:01 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E04952309F0;
        Fri, 16 Sep 2022 15:44:01 +0200 (CEST)
Received: from [10.48.1.102] (10.75.127.120) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Fri, 16 Sep
 2022 15:43:59 +0200
Message-ID: <588d5730-4763-ce1d-5e91-1e3973f054f5@foss.st.com>
Date:   Fri, 16 Sep 2022 15:43:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] iio: adc: stm32-adc: add id registers support
Content-Language: en-US
To:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Yannick Brosseau <yannick.brosseau@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20220915135452.1712453-1-olivier.moysan@foss.st.com>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20220915135452.1712453-1-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.120]
X-ClientProxiedBy: GPXDAG2NODE4.st.com (10.75.127.68) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_08,2022-09-16_01,2022-06-22_01
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/22 15:54, Olivier Moysan wrote:
> Add support of identification registers to STM32 ADC.
> 
> By default the ADC hardware instance number is retrieved from
> the compatible configuration data. Get the available ADC number
> per ADC block, from hardware configuration register,
> when this register exists.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>

Hi Olivier,

You can add my:
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks and Best Regards,
Fabrice

> ---
>  drivers/iio/adc/stm32-adc-core.c | 59 ++++++++++++++++++++++++++++++--
>  drivers/iio/adc/stm32-adc-core.h | 31 +++++++++++++++++
>  2 files changed, 87 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> index 1ce52af3fe8b..81d5db91c67b 100644
> --- a/drivers/iio/adc/stm32-adc-core.c
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -9,6 +9,7 @@
>   *
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/interrupt.h>
>  #include <linux/irqchip/chained_irq.h>
> @@ -62,6 +63,7 @@ struct stm32_adc_priv;
>   * @regs:	common registers for all instances
>   * @clk_sel:	clock selection routine
>   * @max_clk_rate_hz: maximum analog clock rate (Hz, from datasheet)
> + * @ipid:	adc identification number
>   * @has_syscfg: SYSCFG capability flags
>   * @num_irqs:	number of interrupt lines
>   * @num_adcs:   maximum number of ADC instances in the common registers
> @@ -70,6 +72,7 @@ struct stm32_adc_priv_cfg {
>  	const struct stm32_adc_common_regs *regs;
>  	int (*clk_sel)(struct platform_device *, struct stm32_adc_priv *);
>  	u32 max_clk_rate_hz;
> +	u32 ipid;
>  	unsigned int has_syscfg;
>  	unsigned int num_irqs;
>  	unsigned int num_adcs;
> @@ -78,6 +81,7 @@ struct stm32_adc_priv_cfg {
>  /**
>   * struct stm32_adc_priv - stm32 ADC core private data
>   * @irq:		irq(s) for ADC block
> + * @nb_adc_max:		actual maximum number of instance per ADC block
>   * @domain:		irq domain reference
>   * @aclk:		clock reference for the analog circuitry
>   * @bclk:		bus clock common for all ADCs, depends on part used
> @@ -95,6 +99,7 @@ struct stm32_adc_priv_cfg {
>   */
>  struct stm32_adc_priv {
>  	int				irq[STM32_ADC_MAX_ADCS];
> +	unsigned int			nb_adc_max;
>  	struct irq_domain		*domain;
>  	struct clk			*aclk;
>  	struct clk			*bclk;
> @@ -354,7 +359,7 @@ static void stm32_adc_irq_handler(struct irq_desc *desc)
>  	 * before invoking the interrupt handler (e.g. call ISR only for
>  	 * IRQ-enabled ADCs).
>  	 */
> -	for (i = 0; i < priv->cfg->num_adcs; i++) {
> +	for (i = 0; i < priv->nb_adc_max; i++) {
>  		if ((status & priv->cfg->regs->eoc_msk[i] &&
>  		     stm32_adc_eoc_enabled(priv, i)) ||
>  		     (status & priv->cfg->regs->ovr_msk[i]))
> @@ -424,7 +429,7 @@ static void stm32_adc_irq_remove(struct platform_device *pdev,
>  	int hwirq;
>  	unsigned int i;
>  
> -	for (hwirq = 0; hwirq < STM32_ADC_MAX_ADCS; hwirq++)
> +	for (hwirq = 0; hwirq < priv->nb_adc_max; hwirq++)
>  		irq_dispose_mapping(irq_find_mapping(priv->domain, hwirq));
>  	irq_domain_remove(priv->domain);
>  
> @@ -642,6 +647,49 @@ static int stm32_adc_core_switches_probe(struct device *dev,
>  	return 0;
>  }
>  
> +static int stm32_adc_probe_identification(struct platform_device *pdev,
> +					  struct stm32_adc_priv *priv)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *child;
> +	const char *compat;
> +	int ret, count = 0;
> +	u32 id, val;
> +
> +	if (!priv->cfg->ipid)
> +		return 0;
> +
> +	id = FIELD_GET(STM32MP1_IPIDR_MASK,
> +		       readl_relaxed(priv->common.base + STM32MP1_ADC_IPDR));
> +	if (id != priv->cfg->ipid) {
> +		dev_err(&pdev->dev, "Unexpected IP version: 0x%x", id);
> +		return -EINVAL;
> +	}
> +
> +	for_each_child_of_node(np, child) {
> +		ret = of_property_read_string(child, "compatible", &compat);
> +		if (ret)
> +			continue;
> +		/* Count child nodes with stm32 adc compatible */
> +		if (strstr(compat, "st,stm32") && strstr(compat, "adc"))
> +			count++;
> +	}
> +
> +	val = readl_relaxed(priv->common.base + STM32MP1_ADC_HWCFGR0);
> +	priv->nb_adc_max = FIELD_GET(STM32MP1_ADCNUM_MASK, val);
> +	if (count > priv->nb_adc_max) {
> +		dev_err(&pdev->dev, "Unexpected child number: %d", count);
> +		return -EINVAL;
> +	}
> +
> +	val = readl_relaxed(priv->common.base + STM32MP1_ADC_VERR);
> +	dev_dbg(&pdev->dev, "ADC version: %lu.%lu\n",
> +		FIELD_GET(STM32MP1_MAJREV_MASK, val),
> +		FIELD_GET(STM32MP1_MINREV_MASK, val));
> +
> +	return 0;
> +}
> +
>  static int stm32_adc_probe(struct platform_device *pdev)
>  {
>  	struct stm32_adc_priv *priv;
> @@ -661,6 +709,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  
>  	priv->cfg = (const struct stm32_adc_priv_cfg *)
>  		of_match_device(dev->driver->of_match_table, dev)->data;
> +	priv->nb_adc_max = priv->cfg->num_adcs;
>  	spin_lock_init(&priv->common.lock);
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -703,6 +752,10 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_pm_stop;
>  
> +	ret = stm32_adc_probe_identification(pdev, priv);
> +	if (ret < 0)
> +		goto err_hw_stop;
> +
>  	ret = regulator_get_voltage(priv->vref);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "vref get voltage failed, %d\n", ret);
> @@ -811,8 +864,8 @@ static const struct stm32_adc_priv_cfg stm32mp1_adc_priv_cfg = {
>  	.clk_sel = stm32h7_adc_clk_sel,
>  	.max_clk_rate_hz = 36000000,
>  	.has_syscfg = HAS_VBOOSTER | HAS_ANASWVDD,
> +	.ipid = STM32MP15_IPIDR_NUMBER,
>  	.num_irqs = 2,
> -	.num_adcs = 2,
>  };
>  
>  static const struct of_device_id stm32_adc_of_match[] = {
> diff --git a/drivers/iio/adc/stm32-adc-core.h b/drivers/iio/adc/stm32-adc-core.h
> index faedf7a49555..2118ef63843d 100644
> --- a/drivers/iio/adc/stm32-adc-core.h
> +++ b/drivers/iio/adc/stm32-adc-core.h
> @@ -24,6 +24,7 @@
>   * | 0x300  |         Master & Slave common regs          |
>   * --------------------------------------------------------
>   */
> +/* Maximum ADC instances number per ADC block for all supported SoCs */
>  #define STM32_ADC_MAX_ADCS		3
>  #define STM32_ADC_OFFSET		0x100
>  #define STM32_ADCX_COMN_OFFSET		0x300
> @@ -105,6 +106,12 @@
>  /* STM32MP1 - ADC2 instance option register */
>  #define STM32MP1_ADC2_OR		0xD0
>  
> +/* STM32MP1 - Identification registers */
> +#define STM32MP1_ADC_HWCFGR0		0x3F0
> +#define STM32MP1_ADC_VERR		0x3F4
> +#define STM32MP1_ADC_IPDR		0x3F8
> +#define STM32MP1_ADC_SIDR		0x3FC
> +
>  /* STM32H7 - common registers for all ADC instances */
>  #define STM32H7_ADC_CSR			(STM32_ADCX_COMN_OFFSET + 0x00)
>  #define STM32H7_ADC_CCR			(STM32_ADCX_COMN_OFFSET + 0x08)
> @@ -181,6 +188,30 @@ enum stm32h7_adc_dmngt {
>  /* STM32MP1_ADC2_OR - bit fields */
>  #define STM32MP1_VDDCOREEN		BIT(0)
>  
> +/* STM32MP1_ADC_HWCFGR0 - bit fields */
> +#define STM32MP1_ADCNUM_SHIFT		0
> +#define STM32MP1_ADCNUM_MASK		GENMASK(3, 0)
> +#define STM32MP1_MULPIPE_SHIFT		4
> +#define STM32MP1_MULPIPE_MASK		GENMASK(7, 4)
> +#define STM32MP1_OPBITS_SHIFT		8
> +#define STM32MP1_OPBITS_MASK		GENMASK(11, 8)
> +#define STM32MP1_IDLEVALUE_SHIFT	12
> +#define STM32MP1_IDLEVALUE_MASK	GENMASK(15, 12)
> +
> +/* STM32MP1_ADC_VERR - bit fields */
> +#define STM32MP1_MINREV_SHIFT		0
> +#define STM32MP1_MINREV_MASK		GENMASK(3, 0)
> +#define STM32MP1_MAJREV_SHIFT		4
> +#define STM32MP1_MAJREV_MASK		GENMASK(7, 4)
> +
> +/* STM32MP1_ADC_IPDR - bit fields */
> +#define STM32MP1_IPIDR_MASK		GENMASK(31, 0)
> +
> +/* STM32MP1_ADC_SIDR - bit fields */
> +#define STM32MP1_SIDR_MASK		GENMASK(31, 0)
> +
> +#define STM32MP15_IPIDR_NUMBER		0x00110005
> +
>  /**
>   * struct stm32_adc_common - stm32 ADC driver common data (for all instances)
>   * @base:		control registers base cpu addr
