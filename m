Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795C96E4077
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjDQHOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjDQHOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:14:47 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDD840F4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:14:42 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2a8b62cfaceso11098301fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681715681; x=1684307681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qvmplmeWZZViivJ6k7o0mHDRxZVRd+V5kZCzqXmgosQ=;
        b=cGArhNbs+C3z/Vu3WgqAMJUuq0kCFijjnIECOnldqG14doMdmYa6Q3gL5tqdnNrJrj
         uZp7+eK+31Tr4ie13kdsucr79iFHZrZpD/xNuGPgT7eHGi6f1h9FAQ8piosWJcPUBOK+
         DA6rivJ3fxxsZVWC6YVaqM/+Rg/QdF8UWlzA7C2ZiWbOjG/pxC4FQbXeKWMBRcrR2YnN
         i6CsJrl3GhP8fUqjeJlrAXUu3qp4ZgzqnDKp++8O6L2DNWDBR4N+fmxa9HPdKMzXzB89
         Bwazya2KTRN/Xks4ZEitiogYfzcEx449jJSfcugj+U2kXEfR0do27U3EA3pPts8UPuy8
         SdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681715681; x=1684307681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qvmplmeWZZViivJ6k7o0mHDRxZVRd+V5kZCzqXmgosQ=;
        b=e8sKS4A8QG0oRT8wEhjHBT+tGeqVytQWWBh7u28ec15ggZApj9+CWMbdsBbecsJcGo
         MaArB8GUEv6YuGm1njc8bGVTvCZpHq0lkB7hmoH2XqEZ3R0FdXszfie+NvTkYbUPUHV1
         lPOA/9oGwF2lF9e42eSA+PU1LMsOfYhFfvQIOnwpMTwqVh3/6m3wMGeSVci0/dIqT1HL
         eE6JeqJ15DYD8y6sBOgnNq6z7h3rhIbQIACywy1yxs+ehsWMVP4wx9SgclxCjzKPO7ew
         yifivjxM7uLLl2OEsOA9ShkOu3wsfM5HqA9Bz6rIlR8l6EFn8LE0AIheGTvEhTUdcLPv
         Mg6w==
X-Gm-Message-State: AAQBX9d8KTM/V8igPBN77PH+25gOaU4pZihECQNoGG63H+rWsIr3IQ2t
        48bgzcAI84YJdH+XLchH5kuyvA==
X-Google-Smtp-Source: AKy350Y1rDmIJ80u4qZE9/DUnaJTTYw5NwNh2dDibzfciHR81re7zzA42dX4O1XrsyXLbNb53UsQIw==
X-Received: by 2002:ac2:44a3:0:b0:4ed:c3c9:cb06 with SMTP id c3-20020ac244a3000000b004edc3c9cb06mr768155lfm.27.1681715680803;
        Mon, 17 Apr 2023 00:14:40 -0700 (PDT)
Received: from [192.168.1.101] (abyk99.neoplus.adsl.tpnet.pl. [83.9.30.99])
        by smtp.gmail.com with ESMTPSA id c15-20020ac2530f000000b004edc3f06f5csm423063lfh.296.2023.04.17.00.14.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 00:14:40 -0700 (PDT)
Message-ID: <ab6d9730-2eae-44c7-a809-b29174acdefc@linaro.org>
Date:   Mon, 17 Apr 2023 09:14:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 2/2] soc: qcom: Introduce RPM master stats driver
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230405-topic-master_stats-v3-0-2cb2ba4f2092@linaro.org>
 <20230405-topic-master_stats-v3-2-2cb2ba4f2092@linaro.org>
 <20230416142055.GA2798@thinkpad>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230416142055.GA2798@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.04.2023 16:20, Manivannan Sadhasivam wrote:
> On Fri, Apr 14, 2023 at 01:37:18PM +0200, Konrad Dybcio wrote:
>> Introduce a driver to query and expose detailed, per-subsystem (as opposed
>> to the existing qcom_stats driver which exposes SoC-wide data) about low
>> power mode states of a given RPM master. That includes the APSS (ARM),
>> MPSS (modem) and other remote cores, depending on the platform
>> configuration.
>>
>> This is a vastly cleaned up and restructured version of a similar
>> driver found in msm-5.4.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/soc/qcom/Kconfig            |  11 +++
>>  drivers/soc/qcom/Makefile           |   1 +
>>  drivers/soc/qcom/rpm_master_stats.c | 160 ++++++++++++++++++++++++++++++++++++
>>  3 files changed, 172 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index a491718f8064..e597799e8121 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -135,6 +135,17 @@ config QCOM_RMTFS_MEM
>>  
>>  	  Say y here if you intend to boot the modem remoteproc.
>>  
>> +config QCOM_RPM_MASTER_STATS
>> +	tristate "Qualcomm RPM Master stats"
>> +	depends on ARCH_QCOM || COMPILE_TEST
>> +	help
>> +	  The RPM Master sleep stats driver provides detailed per-subsystem
>> +	  sleep/wake data, read from the RPM message RAM. It can be used to
>> +	  assess whether all the low-power modes available are entered as
>> +	  expected or to check which part of the SoC prevents it from sleeping.
>> +
>> +	  Say y here if you intend to debug or monitor platform sleep.
>> +
>>  config QCOM_RPMH
>>  	tristate "Qualcomm RPM-Hardened (RPMH) Communication"
>>  	depends on ARCH_QCOM || COMPILE_TEST
>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>> index 0f43a88b4894..7349371fdea1 100644
>> --- a/drivers/soc/qcom/Makefile
>> +++ b/drivers/soc/qcom/Makefile
>> @@ -14,6 +14,7 @@ obj-$(CONFIG_QCOM_QMI_HELPERS)	+= qmi_helpers.o
>>  qmi_helpers-y	+= qmi_encdec.o qmi_interface.o
>>  obj-$(CONFIG_QCOM_RAMP_CTRL)	+= ramp_controller.o
>>  obj-$(CONFIG_QCOM_RMTFS_MEM)	+= rmtfs_mem.o
>> +obj-$(CONFIG_QCOM_RPM_MASTER_STATS)	+= rpm_master_stats.o
>>  obj-$(CONFIG_QCOM_RPMH)		+= qcom_rpmh.o
>>  qcom_rpmh-y			+= rpmh-rsc.o
>>  qcom_rpmh-y			+= rpmh.o
>> diff --git a/drivers/soc/qcom/rpm_master_stats.c b/drivers/soc/qcom/rpm_master_stats.c
>> new file mode 100644
>> index 000000000000..73080c92bf89
>> --- /dev/null
>> +++ b/drivers/soc/qcom/rpm_master_stats.c
>> @@ -0,0 +1,160 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2012-2020, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2023, Linaro Limited
>> + *
>> + * This driver supports what is known as "Master Stats v2", which seems to be
>> + * the only version which has ever shipped, all the way from 2013 to 2023.
> 
> It'd better to mention "Qualcomm downstream" in the somewhere above comment to
> make it clear for users.
Ack

> 
>> + */
>> +
>> +#include <linux/debugfs.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/platform_device.h>
>> +
>> +struct master_stats_data {
>> +	void __iomem *base;
>> +	const char *label;
>> +};
>> +
>> +struct rpm_master_stats {
>> +	uint32_t active_cores;
>> +	uint32_t num_shutdowns;
>> +	uint64_t shutdown_req;
>> +	uint64_t wakeup_idx;
>> +	uint64_t bringup_req;
>> +	uint64_t bringup_ack;
>> +	uint32_t wakeup_reason; /* 0 = "rude wakeup", 1 = scheduled wakeup */
>> +	uint32_t last_sleep_trans_dur;
>> +	uint32_t last_wake_trans_dur;
>> +
>> +	/* Per-subsystem (*not necessarily* SoC-wide) XO shutdown stats */
>> +	uint32_t xo_count;
>> +	uint64_t xo_last_enter;
>> +	uint64_t last_exit;
>> +	uint64_t xo_total_dur;
> 
> Why can't you use u64, u32?
Brain derp!

> 
> Also, sort these members as below:
> 
> u64
> u32
No, it's the way this data is structured in the
memory and we copy it as a whole.

> 
>> +};
>> +
>> +static int master_stats_show(struct seq_file *s, void *unused)
>> +{
>> +	struct master_stats_data *d = s->private;
>> +	struct rpm_master_stats stat;
>> +
>> +	memcpy_fromio(&stat, d->base, sizeof(stat));
>> +
>> +	seq_printf(s, "%s:\n", d->label);
>> +
>> +	seq_printf(s, "\tLast shutdown @ %llu\n", stat.shutdown_req);
>> +	seq_printf(s, "\tLast bringup req @ %llu\n", stat.bringup_req);
>> +	seq_printf(s, "\tLast bringup ack @ %llu\n", stat.bringup_ack);
>> +	seq_printf(s, "\tLast wakeup idx: %llu\n", stat.wakeup_idx);
>> +	seq_printf(s, "\tLast XO shutdown enter @ %llu\n", stat.xo_last_enter);
>> +	seq_printf(s, "\tLast XO shutdown exit @ %llu\n", stat.last_exit);
>> +	seq_printf(s, "\tXO total duration: %llu\n", stat.xo_total_dur);
>> +	seq_printf(s, "\tLast sleep transition duration: %u\n", stat.last_sleep_trans_dur);
>> +	seq_printf(s, "\tLast wake transition duration: %u\n", stat.last_wake_trans_dur);
>> +	seq_printf(s, "\tXO shutdown count: %u\n", stat.xo_count);
>> +	seq_printf(s, "\tWakeup reason: 0x%x\n", stat.wakeup_reason);
>> +	seq_printf(s, "\tShutdown count: %u\n", stat.num_shutdowns);
>> +	seq_printf(s, "\tActive cores bitmask: 0x%x\n", stat.active_cores);
>> +
>> +	return 0;
>> +}
>> +DEFINE_SHOW_ATTRIBUTE(master_stats);
>> +
>> +static int master_stats_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *msgram_np;
>> +	struct master_stats_data *d;
> 
> "d" is not a good choice for a local variable (might be OK above but definitely
> not here)
Sure, I can change it.

> 
>> +	struct dentry *dent, *root;
>> +	struct resource res;
>> +	int count, i, ret;
>> +
>> +	count = of_property_count_strings(dev->of_node, "qcom,master-names");
>> +	if (count < 0)
>> +		return count;
>> +
>> +	d = devm_kzalloc(dev, count * sizeof(*d), GFP_KERNEL);
>> +	if (!d)
>> +		return -ENOMEM;
>> +
>> +	root = debugfs_create_dir("rpm_master_stats", NULL);
> 
> It's better to use "qcom_rpm_master_stats".
Ack

> 
>> +	platform_set_drvdata(pdev, root);
>> +
>> +	for (i = 0; i < count; i++) {
>> +		msgram_np = of_parse_phandle(dev->of_node, "qcom,rpm-msg-ram", i);
>> +		if (!msgram_np) {
>> +			debugfs_remove_recursive(root);
>> +			return dev_err_probe(dev, -EINVAL,
> 
> -ENODEV
Ack

> 
>> +					     "Couldn't parse MSG RAM phandle idx %d", i);
>> +		}
>> +
>> +		/*
>> +		 * Purposefully skip devm_platform helpers as we're using a
>> +		 * shared resource.
>> +		 */
>> +		ret = of_address_to_resource(msgram_np, 0, &res);
> 
> Missing of_node_put() here due to of_parse_phandle().
Ack

> 
>> +		if (ret < 0) {
>> +			debugfs_remove_recursive(root);
>> +			return ret;
>> +		}
>> +
>> +		d[i].base = devm_ioremap(dev, res.start, resource_size(&res));
>> +		if (IS_ERR(d[i].base)) {
>> +			debugfs_remove_recursive(root);
>> +			return dev_err_probe(dev, -EINVAL,
>> +					     "Could not map the MSG RAM slice idx %d!\n", i);
>> +		}
>> +
>> +		ret = of_property_read_string_index(dev->of_node, "qcom,master-names", i,
>> +						    &d[i].label);
>> +		if (ret < 0) {
>> +			debugfs_remove_recursive(root);
>> +			return dev_err_probe(dev, ret,
>> +					     "Could not read name idx %d!\n", i);
>> +		}
>> +
>> +		/*
>> +		 * Generally it's not advised to fail on debugfs errors, but this
>> +		 * driver's only job is exposing data therein.
>> +		 */
>> +		dent = debugfs_create_file(d[i].label, 0444, root,
>> +					   &d[i], &master_stats_fops);
>> +		if (!dent) {
> 
> Don't check for NULL, instead use IS_ERR() if you really care about error
> checking here.
"This function will return a pointer to a dentry if
it succeeds. This pointer must be passed to the
debugfs_remove function when the file is to be removed
(no automatic cleanup happens if your module is unloaded,
you are responsible here.) If an error occurs, NULL will
be returned."

> 
>> +			debugfs_remove_recursive(root);
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	device_set_pm_not_required(dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static void master_stats_remove(struct platform_device *pdev)
>> +{
>> +	struct dentry *root = platform_get_drvdata(pdev);
>> +
>> +	debugfs_remove_recursive(root);
>> +}
>> +
>> +static const struct of_device_id rpm_master_table[] = {
>> +	{ .compatible = "qcom,rpm-master-stats" },
>> +	{ },
>> +};
>> +
>> +static struct platform_driver master_stats_driver = {
>> +	.probe = master_stats_probe,
>> +	.remove_new = master_stats_remove,
>> +	.driver = {
>> +		.name = "rpm_master_stats",
>> +		.of_match_table = rpm_master_table,
>> +	},
>> +};
>> +module_platform_driver(master_stats_driver);
>> +
>> +MODULE_DESCRIPTION("RPM Master Statistics driver");
> 
> Qualcomm RPM Master Statistics driver
Ack

Konrad
> 
> - Mani
> 
>> +MODULE_LICENSE("GPL");
>>
>> -- 
>> 2.40.0
>>
> 
