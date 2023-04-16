Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CEA6E3929
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 16:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjDPOVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 10:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjDPOVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 10:21:03 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682412684
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 07:21:02 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id w11so23023862plp.13
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 07:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681654862; x=1684246862;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SXO7rlFhBShZ/ZQnEUK9JdwypninSK4l6l9LhoVLfzU=;
        b=Cx67P2ULWTbipJr2C+cTLc5DhQJrBwd7KUfMDzWiB1x4elWxTsblbi8AJMxxibcIsg
         W8FVukWsn2mGsirj6ddn2ZP+ggzCqwOQycXJ+JsQEZwnnGE9LOlo/iroRANP/7hw77j8
         ADRiakkLS7Sc/2GVGdiDuCSqtc9BDFjJ4/6pl/BsrrNOMJ3I9xlp1ZQOgjBz2tcyrRCJ
         dhNUnFyBJp+UzNPhtCLuAzCRa/xAdx0xF6oqzkc+OENeh5iyogUZ/Wh6nKszurmiXzCR
         xq05jwTo4ARFGSkEC8twEvsaKwCQI26Acrs4N2d9TU5jmBXysZDLbM7M3KpcHuzbS/1v
         vRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681654862; x=1684246862;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SXO7rlFhBShZ/ZQnEUK9JdwypninSK4l6l9LhoVLfzU=;
        b=igQjhNHVKHEwk85oWCyP8YhWw4vJf03SX65xiLYvDFJda2nYT/xtMTVs/MLmbQSSvu
         EcQPCgZKFL8HsvccrD3rPETpEwDFT0Yjix/Wptq5A3Bkqlp9EXYCM+pmO1ATJL3tKTFT
         bD35u3228Ip8QNqa8YnfeJzfFxTilH91V30K6gI4lJZ4o6gQgFsRP1Hu7lH3Fxa4pArQ
         fRR+dFMtQ0orj/ySsTY0xU56JA3SoBr6PWGmNMRnZIfcTPlgnYGi/TACyB5m8XPpOzeL
         M30eCMRAXgLfBphJPWNL2XbX/MceO/itMt9YteMzJiYpQ6Kr/Mz/JOXlsVo21+0i3g8/
         IDJg==
X-Gm-Message-State: AAQBX9dP24s6ktbsIWcdtyXAhKMafO49P+zsGMuQCox47u+F9Iwf+N9g
        Soj75nTXNzPc7aY104W767hf
X-Google-Smtp-Source: AKy350YBR0PJ2nnMsUy1giv8SpCxczTuTFkoRUgnd58ijEEEoPfHogR8UI0e91mq/xCRDIqIIEMZcw==
X-Received: by 2002:a17:90a:4e85:b0:247:4186:69ba with SMTP id o5-20020a17090a4e8500b00247418669bamr8064961pjh.31.1681654861716;
        Sun, 16 Apr 2023 07:21:01 -0700 (PDT)
Received: from thinkpad ([220.158.158.124])
        by smtp.gmail.com with ESMTPSA id 20-20020a630f54000000b004fc1d91e695sm5398335pgp.79.2023.04.16.07.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 07:21:01 -0700 (PDT)
Date:   Sun, 16 Apr 2023 19:50:55 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] soc: qcom: Introduce RPM master stats driver
Message-ID: <20230416142055.GA2798@thinkpad>
References: <20230405-topic-master_stats-v3-0-2cb2ba4f2092@linaro.org>
 <20230405-topic-master_stats-v3-2-2cb2ba4f2092@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230405-topic-master_stats-v3-2-2cb2ba4f2092@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 01:37:18PM +0200, Konrad Dybcio wrote:
> Introduce a driver to query and expose detailed, per-subsystem (as opposed
> to the existing qcom_stats driver which exposes SoC-wide data) about low
> power mode states of a given RPM master. That includes the APSS (ARM),
> MPSS (modem) and other remote cores, depending on the platform
> configuration.
> 
> This is a vastly cleaned up and restructured version of a similar
> driver found in msm-5.4.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/soc/qcom/Kconfig            |  11 +++
>  drivers/soc/qcom/Makefile           |   1 +
>  drivers/soc/qcom/rpm_master_stats.c | 160 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 172 insertions(+)
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index a491718f8064..e597799e8121 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -135,6 +135,17 @@ config QCOM_RMTFS_MEM
>  
>  	  Say y here if you intend to boot the modem remoteproc.
>  
> +config QCOM_RPM_MASTER_STATS
> +	tristate "Qualcomm RPM Master stats"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	help
> +	  The RPM Master sleep stats driver provides detailed per-subsystem
> +	  sleep/wake data, read from the RPM message RAM. It can be used to
> +	  assess whether all the low-power modes available are entered as
> +	  expected or to check which part of the SoC prevents it from sleeping.
> +
> +	  Say y here if you intend to debug or monitor platform sleep.
> +
>  config QCOM_RPMH
>  	tristate "Qualcomm RPM-Hardened (RPMH) Communication"
>  	depends on ARCH_QCOM || COMPILE_TEST
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 0f43a88b4894..7349371fdea1 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_QCOM_QMI_HELPERS)	+= qmi_helpers.o
>  qmi_helpers-y	+= qmi_encdec.o qmi_interface.o
>  obj-$(CONFIG_QCOM_RAMP_CTRL)	+= ramp_controller.o
>  obj-$(CONFIG_QCOM_RMTFS_MEM)	+= rmtfs_mem.o
> +obj-$(CONFIG_QCOM_RPM_MASTER_STATS)	+= rpm_master_stats.o
>  obj-$(CONFIG_QCOM_RPMH)		+= qcom_rpmh.o
>  qcom_rpmh-y			+= rpmh-rsc.o
>  qcom_rpmh-y			+= rpmh.o
> diff --git a/drivers/soc/qcom/rpm_master_stats.c b/drivers/soc/qcom/rpm_master_stats.c
> new file mode 100644
> index 000000000000..73080c92bf89
> --- /dev/null
> +++ b/drivers/soc/qcom/rpm_master_stats.c
> @@ -0,0 +1,160 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2012-2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023, Linaro Limited
> + *
> + * This driver supports what is known as "Master Stats v2", which seems to be
> + * the only version which has ever shipped, all the way from 2013 to 2023.

It'd better to mention "Qualcomm downstream" in the somewhere above comment to
make it clear for users.

> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +
> +struct master_stats_data {
> +	void __iomem *base;
> +	const char *label;
> +};
> +
> +struct rpm_master_stats {
> +	uint32_t active_cores;
> +	uint32_t num_shutdowns;
> +	uint64_t shutdown_req;
> +	uint64_t wakeup_idx;
> +	uint64_t bringup_req;
> +	uint64_t bringup_ack;
> +	uint32_t wakeup_reason; /* 0 = "rude wakeup", 1 = scheduled wakeup */
> +	uint32_t last_sleep_trans_dur;
> +	uint32_t last_wake_trans_dur;
> +
> +	/* Per-subsystem (*not necessarily* SoC-wide) XO shutdown stats */
> +	uint32_t xo_count;
> +	uint64_t xo_last_enter;
> +	uint64_t last_exit;
> +	uint64_t xo_total_dur;

Why can't you use u64, u32?

Also, sort these members as below:

u64
u32

> +};
> +
> +static int master_stats_show(struct seq_file *s, void *unused)
> +{
> +	struct master_stats_data *d = s->private;
> +	struct rpm_master_stats stat;
> +
> +	memcpy_fromio(&stat, d->base, sizeof(stat));
> +
> +	seq_printf(s, "%s:\n", d->label);
> +
> +	seq_printf(s, "\tLast shutdown @ %llu\n", stat.shutdown_req);
> +	seq_printf(s, "\tLast bringup req @ %llu\n", stat.bringup_req);
> +	seq_printf(s, "\tLast bringup ack @ %llu\n", stat.bringup_ack);
> +	seq_printf(s, "\tLast wakeup idx: %llu\n", stat.wakeup_idx);
> +	seq_printf(s, "\tLast XO shutdown enter @ %llu\n", stat.xo_last_enter);
> +	seq_printf(s, "\tLast XO shutdown exit @ %llu\n", stat.last_exit);
> +	seq_printf(s, "\tXO total duration: %llu\n", stat.xo_total_dur);
> +	seq_printf(s, "\tLast sleep transition duration: %u\n", stat.last_sleep_trans_dur);
> +	seq_printf(s, "\tLast wake transition duration: %u\n", stat.last_wake_trans_dur);
> +	seq_printf(s, "\tXO shutdown count: %u\n", stat.xo_count);
> +	seq_printf(s, "\tWakeup reason: 0x%x\n", stat.wakeup_reason);
> +	seq_printf(s, "\tShutdown count: %u\n", stat.num_shutdowns);
> +	seq_printf(s, "\tActive cores bitmask: 0x%x\n", stat.active_cores);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(master_stats);
> +
> +static int master_stats_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *msgram_np;
> +	struct master_stats_data *d;

"d" is not a good choice for a local variable (might be OK above but definitely
not here)

> +	struct dentry *dent, *root;
> +	struct resource res;
> +	int count, i, ret;
> +
> +	count = of_property_count_strings(dev->of_node, "qcom,master-names");
> +	if (count < 0)
> +		return count;
> +
> +	d = devm_kzalloc(dev, count * sizeof(*d), GFP_KERNEL);
> +	if (!d)
> +		return -ENOMEM;
> +
> +	root = debugfs_create_dir("rpm_master_stats", NULL);

It's better to use "qcom_rpm_master_stats".

> +	platform_set_drvdata(pdev, root);
> +
> +	for (i = 0; i < count; i++) {
> +		msgram_np = of_parse_phandle(dev->of_node, "qcom,rpm-msg-ram", i);
> +		if (!msgram_np) {
> +			debugfs_remove_recursive(root);
> +			return dev_err_probe(dev, -EINVAL,

-ENODEV

> +					     "Couldn't parse MSG RAM phandle idx %d", i);
> +		}
> +
> +		/*
> +		 * Purposefully skip devm_platform helpers as we're using a
> +		 * shared resource.
> +		 */
> +		ret = of_address_to_resource(msgram_np, 0, &res);

Missing of_node_put() here due to of_parse_phandle().

> +		if (ret < 0) {
> +			debugfs_remove_recursive(root);
> +			return ret;
> +		}
> +
> +		d[i].base = devm_ioremap(dev, res.start, resource_size(&res));
> +		if (IS_ERR(d[i].base)) {
> +			debugfs_remove_recursive(root);
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Could not map the MSG RAM slice idx %d!\n", i);
> +		}
> +
> +		ret = of_property_read_string_index(dev->of_node, "qcom,master-names", i,
> +						    &d[i].label);
> +		if (ret < 0) {
> +			debugfs_remove_recursive(root);
> +			return dev_err_probe(dev, ret,
> +					     "Could not read name idx %d!\n", i);
> +		}
> +
> +		/*
> +		 * Generally it's not advised to fail on debugfs errors, but this
> +		 * driver's only job is exposing data therein.
> +		 */
> +		dent = debugfs_create_file(d[i].label, 0444, root,
> +					   &d[i], &master_stats_fops);
> +		if (!dent) {

Don't check for NULL, instead use IS_ERR() if you really care about error
checking here.

> +			debugfs_remove_recursive(root);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	device_set_pm_not_required(dev);
> +
> +	return 0;
> +}
> +
> +static void master_stats_remove(struct platform_device *pdev)
> +{
> +	struct dentry *root = platform_get_drvdata(pdev);
> +
> +	debugfs_remove_recursive(root);
> +}
> +
> +static const struct of_device_id rpm_master_table[] = {
> +	{ .compatible = "qcom,rpm-master-stats" },
> +	{ },
> +};
> +
> +static struct platform_driver master_stats_driver = {
> +	.probe = master_stats_probe,
> +	.remove_new = master_stats_remove,
> +	.driver = {
> +		.name = "rpm_master_stats",
> +		.of_match_table = rpm_master_table,
> +	},
> +};
> +module_platform_driver(master_stats_driver);
> +
> +MODULE_DESCRIPTION("RPM Master Statistics driver");

Qualcomm RPM Master Statistics driver

- Mani

> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.40.0
> 

-- 
மணிவண்ணன் சதாசிவம்
