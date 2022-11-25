Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00F863887D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiKYLSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKYLSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:18:13 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC565233A9;
        Fri, 25 Nov 2022 03:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669375091; x=1700911091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=exPqwwcPvWlmDULPLtKdVviUlO9FBM4xFir3ZuZSLAQ=;
  b=ZTSyUdmhVjkgmqKrvIhtqvr0KildAnt7x8C3GJE6qJutJnMUtxxXN4gw
   F2jhpmB6P+p+bjPyhtjvMrM94hvHZclHJR7plrFnedS455LHDglaPW9tH
   wLJxo3Jq6W6SUCTGX0N1kealjUyYd3Mz+CT9gVtso9iycgLTrJPEcObvr
   81VlKpUAFAfls9GZtQI3ENIp+dSXIhmsUSciCxLMskt5AeIQVSyTyuAf8
   kc4f1loLtSA5QcWrGoiF8y2Zzcgo+ah8URU9dN37evbNgviVUgS64aFlG
   cw4TOJ0jDzPFpU/eZTGMRfYVBEjxT6y6Bg9NDEu1nIYvq0RZcyfcnT6/c
   g==;
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; 
   d="scan'208";a="188642591"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2022 04:18:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 25 Nov 2022 04:18:02 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 25 Nov 2022 04:18:00 -0700
Date:   Fri, 25 Nov 2022 11:17:42 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Walker Chen <walker.chen@starfivetech.com>
CC:     Conor Dooley <conor@kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/4] soc: starfive: Add StarFive JH71XX pmu driver
Message-ID: <Y4CkVnmdEhCsyckH@wendy>
References: <20221118133216.17037-1-walker.chen@starfivetech.com>
 <20221118133216.17037-4-walker.chen@starfivetech.com>
 <Y3giSQ0YccyY2tVk@spud>
 <95b05ac3-31a9-50dc-8eeb-eb3a9f883a6b@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <95b05ac3-31a9-50dc-8eeb-eb3a9f883a6b@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 06:04:59PM +0800, Walker Chen wrote:
> On 2022/11/19 8:24, Conor Dooley wrote:
> > On Fri, Nov 18, 2022 at 09:32:15PM +0800, Walker Chen wrote:

> >> +void starfive_pmu_hw_event_turn_off(u32 mask)
> >> +{
> >> +	pmu_writel(mask, HW_EVENT_TURN_OFF_MASK);
> >> +}
> >> +EXPORT_SYMBOL(starfive_pmu_hw_event_turn_off);
> > 
> > Where are the users for these exports? Also, should they be exported as
> > GPL?
> > 
> > Either way, what is the point of the extra layer of abstraction here
> > around the writel()?
> 
> The two export functions are only prepared for GPU module. But accordint to
>  the latest information, it seems that there is no open source plan for GPU. 
> So the two functions will be drop in next version of patch.

That's a shame!

> >> +static int starfive_pmu_get_state(struct starfive_power_dev *pmd, bool *is_on)
> >> +{
> >> +	struct starfive_pmu *pmu = pmd->power;
> >> +
> >> +	if (!pmd->mask) {
> >> +		*is_on = false;
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	*is_on = __raw_readl(pmu->base + CURR_POWER_MODE) & pmd->mask;
> > 
> > Is there a specific reason that you are using the __raw variants here
> > (and elsewhere) in the driver?
> 
> Will use unified function '__raw_readl' and '__raw_writel'

No no, I want to know *why* you are using the __raw accessors here. My
understanding was that __raw variants are unbarriered & unordered with
respect to other io accesses.

I do notice that the bcm driver you mentioned uses the __raw variants,
but only __raw variants - whereas you use readl() which is ordered and
barriered & __raw_readl().

Is there a reason why you would not use readl() or readl_relaxed()?

> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int starfive_pmu_set_state(struct starfive_power_dev *pmd, bool on)
> >> +{
> >> +	struct starfive_pmu *pmu = pmd->power;
> >> +	unsigned long flags;
> >> +	uint32_t val;
> >> +	uint32_t mode;
> >> +	uint32_t encourage_lo;
> >> +	uint32_t encourage_hi;
> >> +	bool is_on;
> >> +	int ret;
> >> +
> >> +	if (!pmd->mask)
> >> +		return -EINVAL;
> >> +
> >> +	if (is_on == on) {
> >> +		dev_info(pmu->pdev, "pm domain [%s] is already %sable status.\n",
> >> +				pmd->genpd.name, on ? "en" : "dis");
> > 
> > Am I missing something here: you've just declared is_on, so it must be
> > false & therefore this check is all a little pointless? The check just
> > becomes if (false == on) which I don't think is what you're going for
> > here? Or did I miss something obvious?
> 
> Sorry, indeed I missed several lines of code. It should be witten like this:
> 	ret = jh71xx_pmu_get_state(pmd, &is_on);
>         if (ret) {
>                 dev_dbg(pmu->pdev, "unable to get current state for %s\n",
>                         pmd->genpd.name);
>                 return ret;
>         }

Heh, this looks more sane :)

> 
>         if (is_on == on) {
>                 dev_dbg(pmu->pdev, "pm domain [%s] is already %sable status.\n",
>                         pmd->genpd.name, on ? "en" : "dis");
>                 return 0;
>         }
> 
> > 
> >> +		return 0;
> >> +	}
> >> +
> >> +	spin_lock_irqsave(&pmu->lock, flags);
> >> +
> >> +	if (on) {
> >> +		mode = SW_TURN_ON_POWER_MODE;
> >> +		encourage_lo = SW_MODE_ENCOURAGE_EN_LO;
> >> +		encourage_hi = SW_MODE_ENCOURAGE_EN_HI;
> >> +	} else {
> >> +		mode = SW_TURN_OFF_POWER_MODE;
> >> +		encourage_lo = SW_MODE_ENCOURAGE_DIS_LO;
> >> +		encourage_hi = SW_MODE_ENCOURAGE_DIS_HI;
> >> +	}
> >> +
> >> +	__raw_writel(pmd->mask, pmu->base + mode);
> >> +
> >> +	/* write SW_ENCOURAGE to make the configuration take effect */
> >> +	__raw_writel(SW_MODE_ENCOURAGE_ON, pmu->base + SW_ENCOURAGE);
> > 
> > Is register "sticky"? IOW, could you set it in probe and leave this mode
> > always on? Or does it need to be set every time you want to use this
> > feature?
> 
> These power domain registers need to be set by other module according to the
> specific situation. 
> For example some power domains should be turned off via System PM mechanism
> when system goes to sleep, 
> and then they are turned on when system resume.

I was just wondering if SW_MODE_ENCOURAGE_ON would retain it's value
during operation or if it had to be written every time. It's fine if
that's not the case.

> >> +	__raw_writel(encourage_lo, pmu->base + SW_ENCOURAGE);
> >> +	__raw_writel(encourage_hi, pmu->base + SW_ENCOURAGE);
> >> +
> >> +	spin_unlock_irqrestore(&pmu->lock, flags);
> >> +
> >> +	if (on) {
> >> +		ret = readl_poll_timeout_atomic(pmu->base + CURR_POWER_MODE, val,
> >> +						val & pmd->mask, DELAY_US,
> >> +						TIMEOUT_US);
> >> +		if (ret) {
> >> +			dev_err(pmu->pdev, "%s: failed to power on\n", pmd->genpd.name);
> >> +			return -ETIMEDOUT;
> >> +		}
> >> +	} else {
> >> +		ret = readl_poll_timeout_atomic(pmu->base + CURR_POWER_MODE, val,
> >> +						!(val & pmd->mask), DELAY_US,
> >> +						TIMEOUT_US);
> > 
> > Could you not just decide the 3rd arg outside of the readl_poll..() and
> > save on duplicating the wait logic here?
> 
> Seems that the readl_poll..() can only be called in two cases 
> because the CURR_POWER_MODE register is read to val and then operation with mask every time.
> 

I'm sorry, I completely forgot that read*_poll..() actually not actually
a function. Please ignore this comment!

> >> +static int starfive_pmu_probe(struct platform_device *pdev)
> >> +{
> >> +	struct device *dev = &pdev->dev;
> >> +	struct device_node *np = dev->of_node;
> >> +	const struct starfive_pmu_data *entry, *table;
> >> +	struct starfive_pmu *pmu;
> >> +	unsigned int i;
> >> +	uint8_t max_bit = 0;
> >> +	int ret;
> >> +
> >> +	pmu = devm_kzalloc(dev, sizeof(*pmu), GFP_KERNEL);
> >> +	if (!pmu)
> >> +		return -ENOMEM;
> >> +
> >> +	pmu_base = pmu->base = devm_platform_ioremap_resource(pdev, 0);
> >> +	if (IS_ERR(pmu->base))
> >> +		return PTR_ERR(pmu->base);
> >> +
> >> +	/* initialize pmu interrupt  */
> >> +	pmu->irq = platform_get_irq(pdev, 0);
> >> +	if (pmu->irq < 0)
> >> +		return pmu->irq;
> >> +
> >> +	ret = devm_request_irq(dev, pmu->irq, starfive_pmu_interrupt,
> >> +			       0, pdev->name, pmu);
> >> +	if (ret)
> >> +		dev_err(dev, "request irq failed.\n");
> >> +
> >> +	table = of_device_get_match_data(dev);
> >> +	if (!table)
> >> +		return -EINVAL;
> >> +
> >> +	pmu->pdev = dev;
> >> +	pmu->genpd_data.num_domains = 0;
> >> +	i = 0;
> >> +	for (entry = table; entry->name; entry++) {
> >> +		max_bit = max(max_bit, entry->bit);
> >> +		i++;
> >> +	}
> > 
> > This looks like something that could be replaced by the functions in
> > linux/list.h, no? Same below.
> 
> Nowadays other platforms on linux mainline mostly write in this way or write like this: 
> 	for (i = 0; i < num; i++) {
> 		...
> 		pm_genpd_init(&pmd[i]->genpd, NULL, !is_on);
> 	}

That's not what this specific bit of code is doing though, right? You're
walking jh7110_power_domains to find the highest bit. I was looking at what
some other drivers do, and took a look at drivers/soc/qcom/rpmhpd.c
where they know the size of this struct at compile time & so can do
store the number of power domains in the match data. If you did that,
you could use a loop like the one other platforms use.

> >> +	if (!pmu->genpd)
> >> +		return -ENOMEM;
> >> +
> >> +	pmu->genpd_data.domains = pmu->genpd;
> >> +
> >> +	i = 0;
> >> +	for (entry = table; entry->name; entry++) {

And it's the same here. By now, you should know how many power domains
you have, no?

Anyways, as I said before I don't know much about this power domain
stuff, it's just that these two loops seem odd.

> >> +		struct starfive_power_dev *pmd = &pmu->dev[i];
> >> +		bool is_on;
> >> +
> >> +		pmd->power = pmu;
> >> +		pmd->mask = BIT(entry->bit);
> >> +		pmd->genpd.name = entry->name;
> >> +		pmd->genpd.flags = entry->flags;
> >> +
> >> +		ret = starfive_pmu_get_state(pmd, &is_on);
> >> +		if (ret)
> >> +			dev_warn(dev, "unable to get current state for %s\n",
> >> +				 pmd->genpd.name);

> >> +static const struct starfive_pmu_data jh7110_power_domains[] = {
> > 
> > Is this driver jh7110 only or actually jh71XX? Have you just started out
> > by implementing one SoC both intend to support both?
> 
> JH7110 is our first SoC, probably the next generation of SoC jh7120 still
> use this controller driver.
> Maybe now the naming for JH71XX is not very suitable.

Right. My question was more about if this supported the JH7100 too, but
I saw from your answer to Emil that it won't. I don't have a preference
as to whether you call it jh71xx or jh7110, I'll leave that up to
yourselves and Emil. This particular struct should still be called
`jh7110_power_domains` though since it is particular to this SoC, no
matter what you end up calling the file etc.

> > I don't know /jack/ about power domain stuff, so I can barely review
> > this at all sadly.

> Thank you for taking the time to review the code, you helped me a lot.
> Thank you so much.

No worries, looking forward to getting my board :)

