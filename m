Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913326F0013
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 06:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242784AbjD0EL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 00:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239435AbjD0EL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 00:11:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466D32D71;
        Wed, 26 Apr 2023 21:11:55 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33R2cJsg016944;
        Thu, 27 Apr 2023 04:11:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=8kUH5h4/cL3cxcgQKpNam/JMS/SVACTS4Qlo/YCgyd8=;
 b=afWyogPIZhoyvSzZACCw7WE2xiemLnk0zi+9GvR4R66ZKJ4nx9bTZMO8MhzmyuDqXxMN
 YqEhBA6EMJV4dE47QW4nz63tI66CevH5iWqaOffKS+y/c/ZcvO5s9BrGd2nyyNW+igtT
 7mBQ2Ikdo+ri2nqyAf8EnBpOBzSib8cM1bi0OukBqb+GhWp9UAWpheJ2LkawO3JPCAQS
 2kRMwsKsNocAHUOtfXh1fWClNpSDq6hXYZFUlZqhWuHw/m/6lkQbeaJFvfJw71F5gYNZ
 F/gxtCRb6FOO9sOKlWgi/lS9Gw+BrZbQ1kcnarRsw8xDbLbZrSRUDyuHl4Tzf1Sj7sWF bA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q7dh2gfam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 04:11:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33R4BhMt019340
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 04:11:43 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 26 Apr 2023 21:11:39 -0700
Date:   Thu, 27 Apr 2023 09:41:35 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        "Rajendra Nayak" <quic_rjendra@quicinc.com>
Subject: Re: [PATCH V4 2/3] soc: qcom: boot_stat: Add Driver Support for Boot
 Stats
Message-ID: <20230427041135.GA247926@hu-pkondeti-hyd.qualcomm.com>
References: <cover.1681742910.git.quic_schowdhu@quicinc.com>
 <2ef76ce292c059c144e559123a9a54201ae2d0cf.1681742910.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2ef76ce292c059c144e559123a9a54201ae2d0cf.1681742910.git.quic_schowdhu@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: __PpZ6vkTpqKWt1m_hCbNgGuPnwOHwpn
X-Proofpoint-GUID: __PpZ6vkTpqKWt1m_hCbNgGuPnwOHwpn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_02,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 spamscore=0 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304270036
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 08:38:15PM +0530, Souradeep Chowdhury wrote:
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
>  Documentation/ABI/testing/debugfs-driver-bootstat |  17 ++++
>  drivers/soc/qcom/Kconfig                          |   9 ++
>  drivers/soc/qcom/Makefile                         |   1 +
>  drivers/soc/qcom/boot_stats.c                     | 101 ++++++++++++++++++++++
>  4 files changed, 128 insertions(+)
>  create mode 100644 Documentation/ABI/testing/debugfs-driver-bootstat
>  create mode 100644 drivers/soc/qcom/boot_stats.c
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
>  	  subsystems as well as controlling the debug clocks exposed by the Always On
>  	  Subsystem (AOSS) using Qualcomm Messaging Protocol (QMP).
>  
> +config QCOM_BOOTSTAT
> +	tristate "Qualcomm Technologies, Boot Stat driver"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	help
> +	  This option enables driver support for boot stats. Boot stat driver logs
> +	  the kernel bootloader information by accessing the imem region. These
> +	  information are exposed in the form of debugfs files. This is used to
> +	  determine if there is any regression in boot timings.

should this driver depend on DEBUG_FS?

> +
>  config QCOM_COMMAND_DB
>  	tristate "Qualcomm Command DB"
>  	depends on ARCH_QCOM || COMPILE_TEST
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 6e88da8..bdaa41a 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  CFLAGS_rpmh-rsc.o := -I$(src)
>  obj-$(CONFIG_QCOM_AOSS_QMP) +=	qcom_aoss.o
> +obj-$(CONFIG_QCOM_BOOTSTAT) += boot_stats.o
>  obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
>  obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
>  obj-$(CONFIG_QCOM_CPR)		+= cpr.o
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

Error handling missing.

> +	platform_set_drvdata(pdev, drvdata);
> +
> +	drvdata->dbg_dir = debugfs_create_dir(dev_name(bootstat_dev), NULL);
> +	if (IS_ERR(drvdata->dbg_dir))
> +		return dev_err_probe(bootstat_dev, -ENOENT, "failed to create debugfs directory");

%s/-ENOENT/PTR_ERR(drvdata->dbg_dir)

> +
> +	drvdata->b_stats = devm_of_iomap(bootstat_dev, bootstat_dev->of_node, 0, NULL);
> +	if (!drvdata->b_stats)
> +		return dev_err_probe(bootstat_dev, -ENOMEM, "failed to map imem region\n");

The error handling for devm_of_iomap() is different from usual
ioremap(). you should check for IS_ERR() and return the error code
approriately. Also when it fails, undo the stuff done above i.e delete
the debugfs directory.

> +
> +	debugfs_create_file("pre_abl_time", 0200, drvdata->dbg_dir,
> +			    drvdata->b_stats, &pre_abl_time_fops);
> +	debugfs_create_file("abl_time", 0200, drvdata->dbg_dir, drvdata->b_stats, &abl_time_fops);

Why 0200 permissions for read only entries?

Also consider using debugfs_create_str() which makes your driver
simpler.

> +
> +	return 0;
> +}
> +
> +void boot_stats_remove(struct platform_device *pdev)

static?

> +{
> +	struct bs_data *drvdata = platform_get_drvdata(pdev);
> +
> +	debugfs_remove_recursive(drvdata->dbg_dir);
> +	iounmap(drvdata->b_stats);

since you used devm_of_iomap(), explicit iounmap is not needed.

> +}
> +
> +static const struct of_device_id boot_stats_dt_match[] = {
> +	{ .compatible = "qcom,sm8450-bootstats" },
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
> -- 
> 2.7.4
> 
Thanks,
Pavan
