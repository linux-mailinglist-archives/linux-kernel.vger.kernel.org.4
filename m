Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CECA621833
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbiKHP0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbiKHP0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:26:40 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5B957B7D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 07:26:38 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h9so21582632wrt.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 07:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TvR80LVdsscm0xWlfFqvwa6kHBrxAgN8E99bgym/lJo=;
        b=J3PDOPYVI7z5KJUAMp6886HfsZb7DXUof/VnIwz777seMY66yrJDKyKGUdqPY+6lwO
         NIpIQXOAVVZ2hF1//paiF4CVkVQX15ntXWQrBKsuRzdynVRgqPTBU/4caQ/U1h+tBn/R
         wknXkAzfYmcxyANKMUwA/fsZlcoRks8JggoysodzqAw8xLRcOtJ0qyC9bhKIa47MLIYD
         qOI3pn6cX3M4dW96Xffc1byO7bc3wYfUefruS6/RLQmVKOAI3I96s4lluYD9q2ohsAZG
         qw70YuI4jQGtROnIYxwgoxichwM6p/+ufqMO11svF0tYzNt0kzdmflRL1FxxDuP7+Sdl
         TrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TvR80LVdsscm0xWlfFqvwa6kHBrxAgN8E99bgym/lJo=;
        b=FZUa4sgAOye6CAbOdh8gaEJsKX3PFonmrqWUqb9bVFvJLOOteS8aUe7n/IjLycM0dA
         G6l+sj5mk7GXW4u4q80Y624U0v2iMBRR1uGlaRBM240sa7ggCUMHwsD4IqL4rArRQ/uR
         MvMYAi0OommqWDRdf2ghkECsDYisPpdT25n2QbF/MPkxINEganxBoxlYFIaVfVSQtl7c
         f1vPiKMERMV9Bz/NbLT62NdDTGBykr0OJWPpfr7MX263VrmOYlgRmKqTDDOiixNbWWuh
         HBQrxkn/SDJ+K41FCF3l5GNrjaVnodbPcz8uOxvXblsI9uLzEhuP54bXRLrDXcimb4RT
         60Yg==
X-Gm-Message-State: ACrzQf0gX0HLfKX5EIBxM3kNfrMRf77do+2mPqai6Iw1vYu58PmrpXG/
        jB45o1zWKb5AD4XHeSKCGM8y
X-Google-Smtp-Source: AMsMyM7e6GzNHw6noG4Qd92Gw20xjFP9RHVMX37w1xF2ibdF9F2SUqIM1P7HqesxoQo03Io2IBnnKg==
X-Received: by 2002:a5d:48ce:0:b0:236:e7d2:f5f0 with SMTP id p14-20020a5d48ce000000b00236e7d2f5f0mr25767131wrs.172.1667921197242;
        Tue, 08 Nov 2022 07:26:37 -0800 (PST)
Received: from thinkpad ([117.207.25.46])
        by smtp.gmail.com with ESMTPSA id k186-20020a1ca1c3000000b003cf4d99fd2asm11502430wme.6.2022.11.08.07.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 07:26:36 -0800 (PST)
Date:   Tue, 8 Nov 2022 20:56:25 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     viresh.kumar@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        rafael@kernel.org, robh+dt@kernel.org, johan@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 3/3] cpufreq: qcom-hw: Add CPU clock provider support
Message-ID: <20221108152625.GB88842@thinkpad>
References: <20221102090818.65321-1-manivannan.sadhasivam@linaro.org>
 <20221102090818.65321-4-manivannan.sadhasivam@linaro.org>
 <20221107223055.k6bc7bp7djww5lxg@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221107223055.k6bc7bp7djww5lxg@builder.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 04:30:55PM -0600, Bjorn Andersson wrote:
> On Wed, Nov 02, 2022 at 02:38:18PM +0530, Manivannan Sadhasivam wrote:
> > Qcom CPUFreq hardware (EPSS/OSM) controls clock and voltage to the CPU
> > cores. But this relationship is not represented with the clk framework
> > so far.
> > 
> > So, let's make the qcom-cpufreq-hw driver a clock provider. This makes the
> > clock producer/consumer relationship cleaner and is also useful for CPU
> > related frameworks like OPP to know the frequency at which the CPUs are
> > running.
> > 
> > The clock frequency provided by the driver is for each frequency domain.
> > We cannot get the frequency of each CPU core because, not all platforms
> > support per-core DCVS feature.
> > 
> > Also the frequency supplied by the driver is the actual frequency that
> > comes out of the EPSS/OSM block after the DCVS operation. This frequency is
> > not same as what the CPUFreq framework has set but it is the one that gets
> > supplied to the CPUs after throttling by LMh.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/cpufreq/qcom-cpufreq-hw.c | 43 +++++++++++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> > index 5e0598730a04..5b5f9a4d1466 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> > @@ -4,6 +4,7 @@
> >   */
> >  
> >  #include <linux/bitfield.h>
> > +#include <linux/clk-provider.h>
> >  #include <linux/cpufreq.h>
> >  #include <linux/init.h>
> >  #include <linux/interconnect.h>
> > @@ -54,6 +55,7 @@ struct qcom_cpufreq_data {
> >  	bool cancel_throttle;
> >  	struct delayed_work throttle_work;
> >  	struct cpufreq_policy *policy;
> > +	struct clk_hw cpu_clk;
> >  
> >  	bool per_core_dcvs;
> >  
> > @@ -615,8 +617,20 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
> >  	.ready		= qcom_cpufreq_ready,
> >  };
> >  
> > +static unsigned long qcom_cpufreq_hw_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
> > +{
> > +	struct qcom_cpufreq_data *data = container_of(hw, struct qcom_cpufreq_data, cpu_clk);
> > +
> > +	return qcom_lmh_get_throttle_freq(data) / HZ_PER_KHZ;
> 
> Shouldn't this just be qcom_lmh_get_throttle_freq()? So that we get a
> value in Hz.
> 

Right.

> 
> I presume you got the division from qcom_lmh_dcvs_notify(), where
> throttled_freq seems to supposed to be in kHz when passed to
> topology_update_thermal_pressure(), as it contains a division by 1000
> and a comment that it takes us to units of MHz.
> 
> But it's not clear what the frequency unit for freq_qos_update_request()
> would be - but it's a 31 bit value, so better hope it's kHz there as
> well(?)
> 

No, I think it is better to use Hz. Let me fix it in next revision.

Thanks,
Mani

> Regards,
> Bjorn
> 
> > +}
> > +
> > +static const struct clk_ops qcom_cpufreq_hw_clk_ops = {
> > +	.recalc_rate = qcom_cpufreq_hw_recalc_rate,
> > +};
> > +
> >  static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
> >  {
> > +	struct clk_hw_onecell_data *clk_data;
> >  	struct device *dev = &pdev->dev;
> >  	struct device *cpu_dev;
> >  	struct clk *clk;
> > @@ -659,8 +673,16 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
> >  
> >  	qcom_cpufreq.soc_data = of_device_get_match_data(dev);
> >  
> > +	clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, num_domains), GFP_KERNEL);
> > +	if (!clk_data)
> > +		return -ENOMEM;
> > +
> > +	clk_data->num = num_domains;
> > +
> >  	for (i = 0; i < num_domains; i++) {
> >  		struct qcom_cpufreq_data *data = &qcom_cpufreq.data[i];
> > +		struct clk_init_data init = {};
> > +		const char *clk_name;
> >  		struct resource *res;
> >  		void __iomem *base;
> >  
> > @@ -672,6 +694,27 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
> >  
> >  		data->base = base;
> >  		data->res = res;
> > +
> > +		/* Register CPU clock for each frequency domain */
> > +		clk_name = devm_kasprintf(dev, GFP_KERNEL, "qcom_cpufreq%d", i);
> > +		init.name = clk_name;
> > +		init.flags = CLK_GET_RATE_NOCACHE;
> > +		init.ops = &qcom_cpufreq_hw_clk_ops;
> > +		data->cpu_clk.init = &init;
> > +
> > +		ret = devm_clk_hw_register(dev, &data->cpu_clk);
> > +		if (ret < 0) {
> > +			dev_err(dev, "Failed to register Qcom CPUFreq clock\n");
> > +			return ret;
> > +		}
> > +
> > +		clk_data->hws[i] = &data->cpu_clk;
> > +	}
> > +
> > +	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_data);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Failed to add Qcom CPUFreq clock provider\n");
> > +		return ret;
> >  	}
> >  
> >  	ret = cpufreq_register_driver(&cpufreq_qcom_hw_driver);
> > -- 
> > 2.25.1
> > 

-- 
மணிவண்ணன் சதாசிவம்
