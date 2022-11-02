Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209A1615C29
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 07:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiKBGS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 02:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiKBGSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 02:18:24 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F4A25C7B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 23:18:22 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l6so15328152pjj.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 23:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h0d5aCVPRTVrfRa+Qu4ZFoByM5Lhhf9AZF5J+3bpC/M=;
        b=Ny0gpAJSShyPpcJLqRwRbmw/0WJGjqpn49vntdcZHq0u3pzx/+RdHFQceVu20fS8nx
         tinZ6IROpAZf7Za60oNA0P6u3bnXF4qH7i992xR6iRShZx34GoVp34iaS7DRD2IAyA0Z
         9ZcJtm2ElTzRurp4D3yNxJ3so5ql3vgeoZ8f0AhOcc8UYcWqXbuww3eFhDFV4qe8ZAvr
         caoWdfjuzhzdPwXtJc0y1Pb5SmsJTlUjWSvwjBPltx3qwSqh/X4ZJ/f8eF3lp+o86e4x
         yDkU4jJXb1tYVJjffaT7scKPIN4IYyWgDmBFLBMt5gLNWL4pFQrQqcFCNMyyIMeGHXeR
         bfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0d5aCVPRTVrfRa+Qu4ZFoByM5Lhhf9AZF5J+3bpC/M=;
        b=HK30yOzAhtnx20Ni0mNszFyZ262ofBfZqnRPCGxxy8kHpH/nh3p7LvtyE5eC2rplUd
         AD6Nq4zQ/irKyGNYN3EIJcOjQMCzjAi9XcYz5hnbYHSXDz4pMAya/yFAS2LgK/GgpaaM
         y0VCiCpbngLEpzMJXdshsPpNeF6YeXO319faZLDKLnx5B9WDaw/13sCwNbova3pdQJSY
         P8QSJ5Pa2i36ua0tMGW+BQdl6AjYsRoG0LyYBxBvN91aB1TYbYixwhEh0xmP7SII6gA+
         gw5wPs2ewDxXr8TlTSP0JcUTgJoIQ1k6FZug9tEGxz2CduKN6tAQB1VGJ08zsgf1tdYm
         3bbA==
X-Gm-Message-State: ACrzQf0N3gFi5PxGoY0+FIe4UC938QLcgWUFEqLsHyo6dc4lw6FXwsod
        uKMTPt/zLBgEt/S5W6t/TWr+CQ==
X-Google-Smtp-Source: AMsMyM7tdx3msXcDSRjzengMv7BnjG3CokZXlPZh9RQr5YedHUAgqS+vzQiPxXN9ulEJ1GVtVzG0qA==
X-Received: by 2002:a17:903:444:b0:187:428:1317 with SMTP id iw4-20020a170903044400b0018704281317mr23080646plb.151.1667369901803;
        Tue, 01 Nov 2022 23:18:21 -0700 (PDT)
Received: from localhost ([122.172.84.80])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b00186a6b63525sm7401974plg.120.2022.11.01.23.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 23:18:21 -0700 (PDT)
Date:   Wed, 2 Nov 2022 11:48:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] cpufreq: apple-soc: Add new driver to control
 Apple SoC CPU P-states
Message-ID: <20221102061819.dyl5ah6qffntqieh@vireshk-i7>
References: <20221024043925.25379-1-marcan@marcan.st>
 <20221024043925.25379-5-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024043925.25379-5-marcan@marcan.st>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-10-22, 13:39, Hector Martin wrote:
> diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
> +struct apple_soc_cpufreq_info {
> +	u64 max_pstate;
> +	u64 cur_pstate_mask;
> +	u64 cur_pstate_shift;
> +};
> +
> +struct apple_cpu_priv {
> +	struct device *cpu_dev;
> +	void __iomem *reg_base;
> +	const struct apple_soc_cpufreq_info *info;
> +};
> +
> +static struct cpufreq_driver apple_soc_cpufreq_driver;
> +
> +const struct apple_soc_cpufreq_info soc_t8103_info = {

static ? For other instances too.

> +	.max_pstate = 15,
> +	.cur_pstate_mask = APPLE_DVFS_STATUS_CUR_PS_T8103,
> +	.cur_pstate_shift = APPLE_DVFS_STATUS_CUR_PS_SHIFT_T8103,
> +};
> +
> +const struct apple_soc_cpufreq_info soc_t8112_info = {
> +	.max_pstate = 31,
> +	.cur_pstate_mask = APPLE_DVFS_STATUS_CUR_PS_T8112,
> +	.cur_pstate_shift = APPLE_DVFS_STATUS_CUR_PS_SHIFT_T8112,
> +};
> +
> +const struct apple_soc_cpufreq_info soc_default_info = {
> +	.max_pstate = 15,
> +	.cur_pstate_mask = 0, /* fallback */
> +};
> +
> +static const struct of_device_id apple_soc_cpufreq_of_match[] = {
> +	{
> +		.compatible = "apple,t8103-cluster-cpufreq",
> +		.data = &soc_t8103_info,
> +	},
> +	{

Isn't the preferred way for this is "}, {" instead ?

I couldn't find this in Coding Guidelines, but somehow remember that
to be the preferred format.

> +		.compatible = "apple,t8112-cluster-cpufreq",
> +		.data = &soc_t8112_info,
> +	},
> +	{
> +		.compatible = "apple,cluster-cpufreq",
> +		.data = &soc_default_info,
> +	},
> +	{}
> +};
> +
> +static unsigned int apple_soc_cpufreq_get_rate(unsigned int cpu)
> +{
> +	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
> +	struct apple_cpu_priv *priv = policy->driver_data;
> +	unsigned int pstate;
> +	unsigned int i;

Merge these two ?

> +
> +	if (priv->info->cur_pstate_mask) {
> +		u64 reg = readq_relaxed(priv->reg_base + APPLE_DVFS_STATUS);
> +
> +		pstate = (reg & priv->info->cur_pstate_mask) >>  priv->info->cur_pstate_shift;
> +	} else {
> +		/*
> +		 * For the fallback case we might not know the layout of DVFS_STATUS,
> +		 * so just use the command register value (which ignores boost limitations).
> +		 */
> +		u64 reg = readq_relaxed(priv->reg_base + APPLE_DVFS_CMD);
> +
> +		pstate = FIELD_GET(APPLE_DVFS_CMD_PS1, reg);
> +	}
> +
> +	for (i = 0; policy->freq_table[i].frequency != CPUFREQ_TABLE_END; i++)

You may want to use, cpufreq_for_each_valid_entry(), or some other
generic iterator here.

> +		if (policy->freq_table[i].driver_data == pstate)
> +			return policy->freq_table[i].frequency;
> +
> +	dev_err(priv->cpu_dev, "could not find frequency for pstate %d\n",
> +		pstate);
> +	return 0;
> +}
> +
> +static int apple_soc_cpufreq_set_target(struct cpufreq_policy *policy,
> +					unsigned int index)
> +{
> +	struct apple_cpu_priv *priv = policy->driver_data;
> +	unsigned int pstate = policy->freq_table[index].driver_data;
> +	u64 reg;
> +
> +	/* Fallback for newer SoCs */
> +	if (index > priv->info->max_pstate)
> +		index = priv->info->max_pstate;
> +
> +	if (readq_poll_timeout_atomic(priv->reg_base + APPLE_DVFS_CMD, reg,
> +				      !(reg & APPLE_DVFS_CMD_BUSY), 2,
> +				      APPLE_DVFS_TRANSITION_TIMEOUT)) {
> +		return -EIO;
> +	}
> +
> +	reg &= ~(APPLE_DVFS_CMD_PS1 | APPLE_DVFS_CMD_PS2);
> +	reg |= FIELD_PREP(APPLE_DVFS_CMD_PS1, pstate);
> +	reg |= FIELD_PREP(APPLE_DVFS_CMD_PS2, pstate);
> +	reg |= APPLE_DVFS_CMD_SET;
> +
> +	writeq_relaxed(reg, priv->reg_base + APPLE_DVFS_CMD);
> +
> +	return 0;
> +}
> +
> +static unsigned int apple_soc_cpufreq_fast_switch(struct cpufreq_policy *policy,
> +						  unsigned int target_freq)
> +{
> +	if (apple_soc_cpufreq_set_target(policy, policy->cached_resolved_idx) < 0)
> +		return 0;
> +
> +	return policy->freq_table[policy->cached_resolved_idx].frequency;
> +}
> +
> +static int apple_soc_cpufreq_find_cluster(struct cpufreq_policy *policy,
> +					  void __iomem **reg_base,
> +					  const struct apple_soc_cpufreq_info **info)
> +{
> +	struct of_phandle_args args;
> +	const struct of_device_id *match;
> +	int ret = 0;
> +
> +	ret = of_perf_domain_get_sharing_cpumask(policy->cpu, "performance-domains",
> +						 "#performance-domain-cells",
> +						 policy->cpus, &args);
> +	if (ret < 0)
> +		return ret;
> +
> +	match = of_match_node(apple_soc_cpufreq_of_match, args.np);
> +	of_node_put(args.np);
> +	if (!match)
> +		return -ENODEV;
> +
> +	*info = match->data;
> +
> +	*reg_base = of_iomap(args.np, 0);
> +	if (IS_ERR(*reg_base))
> +		return PTR_ERR(*reg_base);
> +
> +	return 0;
> +}
> +
> +static struct freq_attr *apple_soc_cpufreq_hw_attr[] = {
> +	&cpufreq_freq_attr_scaling_available_freqs,
> +	NULL,
> +	NULL,
> +};
> +
> +static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
> +{
> +	int ret, i;
> +	unsigned int transition_latency;
> +	void __iomem *reg_base;
> +	struct device *cpu_dev;
> +	struct apple_cpu_priv *priv;
> +	const struct apple_soc_cpufreq_info *info;
> +	struct cpufreq_frequency_table *freq_table;
> +
> +	cpu_dev = get_cpu_device(policy->cpu);
> +	if (!cpu_dev) {
> +		pr_err("failed to get cpu%d device\n", policy->cpu);
> +		return -ENODEV;
> +	}
> +
> +	ret = dev_pm_opp_of_add_table(cpu_dev);
> +	if (ret < 0) {
> +		dev_err(cpu_dev, "%s: failed to add OPP table: %d\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	ret = apple_soc_cpufreq_find_cluster(policy, &reg_base, &info);
> +	if (ret) {
> +		dev_err(cpu_dev, "%s: failed to get cluster info: %d\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	ret = dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);

Why do you need this ? The OPP core should be able to find this
information by itself in your case AFAIU. The OPP core will refer
"operating-points-v2 = <&pcluster_opp>" and find that the cores are
related.

> +	if (ret) {
> +		dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n", __func__, ret);
> +		goto out_iounmap;
> +	}
> +
> +	ret = dev_pm_opp_get_opp_count(cpu_dev);
> +	if (ret <= 0) {
> +		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");

Why would this happen in your case ?

> +		ret = -EPROBE_DEFER;
> +		goto out_free_opp;
> +	}
> +
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		ret = -ENOMEM;
> +		goto out_free_opp;
> +	}
> +
> +	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
> +	if (ret) {
> +		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
> +		goto out_free_priv;
> +	}
> +
> +	/* Get OPP levels (p-state indexes) and stash them in driver_data */
> +	for (i = 0; freq_table[i].frequency != CPUFREQ_TABLE_END; i++) {
> +		unsigned long rate = freq_table[i].frequency * 1000;
> +		struct dev_pm_opp *opp = dev_pm_opp_find_freq_floor(cpu_dev, &rate);

Shouldn't you use dev_pm_opp_find_freq_exact() here ?

-- 
viresh
