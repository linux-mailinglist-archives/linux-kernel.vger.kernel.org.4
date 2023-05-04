Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D88C6F6FB4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 18:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjEDQQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 12:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjEDQQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 12:16:29 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D5D1FEC
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 09:16:25 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2ac675d84b5so8496411fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 09:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683216984; x=1685808984;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LigwU+83P/omJYPgtFUAJyYnXKmXjLTOz9cEHCL7Srw=;
        b=BA5ExJqvpUpc4A3AYTNK1oYIAWwsF6QJzh2N5YlEf6/jdAq90Iy+g6dKx1KQKafC5d
         gBo0IGpbK677E77sdWTLKx3Pe3tozSLEUI4T9Sqx2Uqv0ECh66LRO41Dx6QrJ5GTIvD5
         4N4SZIQIBGxP+27PoWKVX1sMFypeucArPeiIIKnjMDLKAoraEbeEdlajiGbawR/8ojm8
         PA+BCZoctVI6mEDuvYVzVhR2uAaXfekf+oITQ4iokkJfE6CXQUynGLBbExexGcs39Rr8
         Hdi5xIE+xBE6gvLrrmJbXh7PtGldtWKlIAWpw9dMIXHNMz5rN2QgMQl777+ohvJOibIz
         6ITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683216984; x=1685808984;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LigwU+83P/omJYPgtFUAJyYnXKmXjLTOz9cEHCL7Srw=;
        b=T799iAN9H7WWl1ei++kPY048quqo1gxnOx9MHm/cRP8RfA+u1Kfpc18fkkkioY8Wp/
         mePembuZYcgNK/9vbrwudsiaXA4PRGSW5IKmkStN1Gw4rBRUPheGY2AFC9X2TUy2CgE1
         PBoUzvpFz9vIySbqvWPSWUxRxU3idTCX3B9h/2EfNR+hM4HQkogZSPnXtDgaH8Y8kgAJ
         Vlzi6y2xSzVezK12u5m7kAogMrsVZgJgQT7Y4OSQEDkilloFNnb+I5bLbchZKZys8QhO
         c1QJ8kPdq8IVFqgj4FVVkG4iSZhaZD16nfdb2PJvoeJauFCpx8WMRIvHAcuTrZdzkIi1
         65Zg==
X-Gm-Message-State: AC+VfDyXn1DZyF8P2IU2rILpJj/Bha909/+DwFMhi3ytk7Ouo0mdJtIY
        xoEUm/Hq6FvB4eVvJREEpbwtLQ==
X-Google-Smtp-Source: ACHHUZ64f4O0foR3Jqs8bOc7BfLHbDu6ypG9tQoA6nLt0E789aqfLK0UdoybsK2T0W35VZRuNS+pGA==
X-Received: by 2002:a05:651c:87:b0:2a8:c374:c0f2 with SMTP id 7-20020a05651c008700b002a8c374c0f2mr1181381ljq.42.1683216983782;
        Thu, 04 May 2023 09:16:23 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id u15-20020a2e9f0f000000b002aa3cff0529sm6266615ljk.74.2023.05.04.09.16.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 09:16:23 -0700 (PDT)
Message-ID: <1d762fc8-c9ce-2ff5-465c-ad016654803c@linaro.org>
Date:   Thu, 4 May 2023 19:16:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V4 2/3] soc: qcom: boot_stat: Add Driver Support for Boot
 Stats
Content-Language: en-GB
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1681742910.git.quic_schowdhu@quicinc.com>
 <2ef76ce292c059c144e559123a9a54201ae2d0cf.1681742910.git.quic_schowdhu@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <2ef76ce292c059c144e559123a9a54201ae2d0cf.1681742910.git.quic_schowdhu@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2023 18:08, Souradeep Chowdhury wrote:
> All of Qualcomm's proprietary Android boot-loaders capture boot time
> stats, like the time when the bootloader started execution and at what
> point the bootloader handed over control to the kernel etc. in the IMEM
> region. This information is captured in a specific format by this driver
> by mapping a structure to the IMEM memory region and then accessing the
> members of the structure to show the information within debugfs file.
> This information is useful in verifying if the existing boot KPIs have
> regressed or not. The information is shown in milliseconds, a sample
> log from sm8450(waipio) device is as follows:-
> 
> /sys/kernel/debug/146aa6b0.boot_stats # cat abl_time
> 17898 ms
> /sys/kernel/debug/146aa6b0.boot_stats # cat pre_abl_time
> 2879 ms
> 
> The Module Power Manager(MPM) sleep counter starts ticking at the PBL
> stage and the timestamp generated by the sleep counter is logged by
> the Qualcomm proprietary bootloader(ABL) at two points-> First when it
> starts execution which is logged here as "pre_abl_time" and the second
> when it is about to load the kernel logged as "abl_time". Documentation
> details are also added in Documentation/ABI/testing/debugfs-driver-bootstat
> 
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> ---
>   Documentation/ABI/testing/debugfs-driver-bootstat |  17 ++++
>   drivers/soc/qcom/Kconfig                          |   9 ++
>   drivers/soc/qcom/Makefile                         |   1 +
>   drivers/soc/qcom/boot_stats.c                     | 101 ++++++++++++++++++++++
>   4 files changed, 128 insertions(+)
>   create mode 100644 Documentation/ABI/testing/debugfs-driver-bootstat
>   create mode 100644 drivers/soc/qcom/boot_stats.c
> 
> diff --git a/Documentation/ABI/testing/debugfs-driver-bootstat b/Documentation/ABI/testing/debugfs-driver-bootstat
> new file mode 100644
> index 0000000..2543029
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-driver-bootstat
> @@ -0,0 +1,17 @@
> +What:		/sys/kernel/debug/...stats/pre_abl_time
> +Date:           April 2023
> +Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> +Description:
> +		This file is used to read the KPI value pre abl time.
> +		It shows the time in milliseconds from the starting
> +		point of PBL to the point when the control shifted
> +		to ABL(Qualcomm proprietary bootloader).
> +
> +What:           /sys/kernel/debug/...stats/abl_time
> +Date:           April 2023
> +Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> +Description:
> +		This file is used to read the KPI value abl time.
> +		It show the duration in milliseconds from the
> +		time control switched to ABL to the point when
> +		the linux kernel started getting loaded.
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index a8f2830..0d2cbd3 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -16,6 +16,15 @@ config QCOM_AOSS_QMP
>   	  subsystems as well as controlling the debug clocks exposed by the Always On
>   	  Subsystem (AOSS) using Qualcomm Messaging Protocol (QMP).
>   
> +config QCOM_BOOTSTAT
> +	tristate "Qualcomm Technologies, Boot Stat driver"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	help
> +	  This option enables driver support for boot stats. Boot stat driver logs
> +	  the kernel bootloader information by accessing the imem region. These
> +	  information are exposed in the form of debugfs files. This is used to
> +	  determine if there is any regression in boot timings.
> +
>   config QCOM_COMMAND_DB
>   	tristate "Qualcomm Command DB"
>   	depends on ARCH_QCOM || COMPILE_TEST
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 6e88da8..bdaa41a 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   CFLAGS_rpmh-rsc.o := -I$(src)
>   obj-$(CONFIG_QCOM_AOSS_QMP) +=	qcom_aoss.o
> +obj-$(CONFIG_QCOM_BOOTSTAT) += boot_stats.o
>   obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
>   obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
>   obj-$(CONFIG_QCOM_CPR)		+= cpr.o
> diff --git a/drivers/soc/qcom/boot_stats.c b/drivers/soc/qcom/boot_stats.c
> new file mode 100644
> index 0000000..7fa8efb
> --- /dev/null
> +++ b/drivers/soc/qcom/boot_stats.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2013-2019, 2021 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +
> +#define TO_MS(timestamp) ((timestamp * 1000) / 32768)

Some of the platforms DTs define 32KHz clock instead of 32.768 KHz What 
should be the divisor in this case?

> +
> +/**
> + *  struct boot_stats - timestamp information related to boot stats
> + *  @abl_start: Time for the starting point of the abl
> + *  @abl_end: Time when the kernel starts loading from abl
> + */
> +struct boot_stats {
> +	u32 abl_start;
> +	u32 abl_end;
> +} __packed;
> +
> +struct bs_data {
> +	struct boot_stats __iomem *b_stats;
> +	struct dentry *dbg_dir;
> +};
> +
> +static int abl_time_show(struct seq_file *seq, void *v)
> +{
> +	struct boot_stats *boot_stats = seq->private;
> +	u32 abl_time = TO_MS(boot_stats->abl_end) - TO_MS(boot_stats->abl_start);
> +
> +	seq_printf(seq, "%u ms\n", abl_time);
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(abl_time);
> +
> +static int pre_abl_time_show(struct seq_file *seq, void *v)
> +{
> +	struct boot_stats *boot_stats = seq->private;
> +
> +	seq_printf(seq, "%u ms\n", TO_MS(boot_stats->abl_start));

It would be better to move the unit to the file name and include just 
the number.

> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(pre_abl_time);
> +
> +static int boot_stats_probe(struct platform_device *pdev)
> +{
> +	struct device *bootstat_dev = &pdev->dev;
> +	struct bs_data *drvdata;
> +
> +	drvdata = devm_kzalloc(bootstat_dev, sizeof(*drvdata), GFP_KERNEL);
> +	platform_set_drvdata(pdev, drvdata);
> +
> +	drvdata->dbg_dir = debugfs_create_dir(dev_name(bootstat_dev), NULL);
> +	if (IS_ERR(drvdata->dbg_dir))
> +		return dev_err_probe(bootstat_dev, -ENOENT, "failed to create debugfs directory");
> +
> +	drvdata->b_stats = devm_of_iomap(bootstat_dev, bootstat_dev->of_node, 0, NULL);
> +	if (!drvdata->b_stats)
> +		return dev_err_probe(bootstat_dev, -ENOMEM, "failed to map imem region\n");
> +
> +	debugfs_create_file("pre_abl_time", 0200, drvdata->dbg_dir,
> +			    drvdata->b_stats, &pre_abl_time_fops);
> +	debugfs_create_file("abl_time", 0200, drvdata->dbg_dir, drvdata->b_stats, &abl_time_fops);
> +
> +	return 0;
> +}
> +
> +void boot_stats_remove(struct platform_device *pdev)
> +{
> +	struct bs_data *drvdata = platform_get_drvdata(pdev);
> +
> +	debugfs_remove_recursive(drvdata->dbg_dir);
> +	iounmap(drvdata->b_stats);
> +}
> +
> +static const struct of_device_id boot_stats_dt_match[] = {
> +	{ .compatible = "qcom,sm8450-bootstats" },

Is it specific to sm8450 only?

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, boot_stats_dt_match);
> +
> +static struct platform_driver boot_stat_driver = {
> +	.probe  = boot_stats_probe,
> +	.remove_new = boot_stats_remove,
> +	.driver = {
> +		.name = "qcom-boot-stats",
> +		.of_match_table = boot_stats_dt_match,
> +	},
> +};
> +module_platform_driver(boot_stat_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm Technologies Inc. Boot Stat driver");
> +MODULE_LICENSE("GPL");

-- 
With best wishes
Dmitry

