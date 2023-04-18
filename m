Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4446E6548
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjDRNEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjDRNEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:04:00 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED7812C94
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:03:29 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2a8b3ecf59fso20107431fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681823002; x=1684415002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tc4cZZll2wEDAWOepyPrCVXqprnCEGfvlOgqas412+4=;
        b=B94gg7hk8fJYSlS0qaOie52Ncb+9MsTogtcyhFsE0s4dl3wS9/ay2shmXbGfWl70Sh
         AxCBSPb833gIpFz86rIEHknEm5BiB04R3rzBFTy46UcDRvj8fNG02/7qjrp2ggir3VZJ
         zvUyfPjNZTA5AXTZHKZUKFI4cZmgrEnQcIy0pIahb74LwpVqrXyAgDxKm5hUAtVCNsMd
         VKnbXFFjRwqfmirI9fRf+ohXXXybR8tIre+buKHJ3tYhbXq+hwZC1p1/nXxM4mQnNtZE
         plcHZMKda5ftfhCbIMroQ+tOHrFHaqDyXZX7jw2OvUlj+q0AbB/iPjjuZH9de3aYLfzB
         kqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681823002; x=1684415002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tc4cZZll2wEDAWOepyPrCVXqprnCEGfvlOgqas412+4=;
        b=XU02/v+6gBiVhJYbTGzTvkd67hxdBt5dnijM8cPtaHyz/YjMEjFXdHBqwj7IPYsPNK
         IN6q/6g8VvBCsaHPnp4t+cdNFiqMoagpC+WSAIDLfBqW8kbd/OoKdpGSYl4tGJX31T0T
         hbW9fPdvu9/5Hug+k619hCVNXx0hN8Ygt5Vqq0DHvLak/GG52vRfz9YMZKYnt0YDxkNd
         TidEQ1OmPkp+m1UE2GqmqC6+k/5bBRrN822ciTLi07ZkK2yzr9IpPl9+N15AKMPfc0Xv
         RLTdR91Yq6CNV1BdTfGjngoZ0XW33oSOGuX2Ew/O934cH2IASN/iO3YaFConcNkcD7R6
         Jneg==
X-Gm-Message-State: AAQBX9dnuJBOamVpknJPn1A2FWHb5/INJN70kXLsf7vctSXVOpNtjIoB
        yS7hvWNizuO+mmFadrj13y783g==
X-Google-Smtp-Source: AKy350bPaAJzJrN+uYKNpuBwYqlr4QKjjlHvhuzI4vz0LvBfu2tWpxSEEEXN0b5o47hTK2q0NKHk4A==
X-Received: by 2002:a19:c207:0:b0:4eb:c30:2777 with SMTP id l7-20020a19c207000000b004eb0c302777mr2638300lfc.54.1681823002584;
        Tue, 18 Apr 2023 06:03:22 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id u3-20020a056512040300b004eafa141a12sm2378181lfk.9.2023.04.18.06.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 06:03:22 -0700 (PDT)
Message-ID: <41840389-4ccb-ce0e-b798-919d09e2f0f1@linaro.org>
Date:   Tue, 18 Apr 2023 15:03:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 2/2] soc: qcom: Introduce RPM master stats driver
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230405-topic-master_stats-v4-0-4217362fcc79@linaro.org>
 <20230405-topic-master_stats-v4-2-4217362fcc79@linaro.org>
 <20230418125047.GB5530@thinkpad>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230418125047.GB5530@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.04.2023 14:50, Manivannan Sadhasivam wrote:
> On Mon, Apr 17, 2023 at 07:37:53PM +0200, Konrad Dybcio wrote:
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
>>  drivers/soc/qcom/rpm_master_stats.c | 162 ++++++++++++++++++++++++++++++++++++
>>  3 files changed, 174 insertions(+)
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
>> index 000000000000..ac87401e2217
>> --- /dev/null
>> +++ b/drivers/soc/qcom/rpm_master_stats.c
>> @@ -0,0 +1,162 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2012-2020, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2023, Linaro Limited
>> + *
>> + * This driver supports what is known as "Master Stats v2" in Qualcomm
>> + * downstream kernel terms, which seems to be the only version which has
>> + * ever shipped, all the way from 2013 to 2023.
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
> Still no u64, u32.
Right, missed that part..

> 
>> +} __packed;
>> +
> 
> [...]
> 
>> +		/*
>> +		 * Generally it's not advised to fail on debugfs errors, but this
>> +		 * driver's only job is exposing data therein.
>> +		 */
>> +		dent = debugfs_create_file(data[i].label, 0444, root,
>> +					   &data[i], &master_stats_fops);
>> +		if (IS_ERR(dent)) {
>> +			debugfs_remove_recursive(root);
>> +			return -EINVAL;
> 
> PTR_ERR(dent). Also it doesn't hurt to use dev_err_probe() here.
Totally makes sense.

> 
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
> 
> qcom_rpm_master_stats
> 
Fixed it everywhere else except here, will do!

Konrad
> - Mani
> 
>> +		.of_match_table = rpm_master_table,
>> +	},
>> +};
>> +module_platform_driver(master_stats_driver);
>> +
>> +MODULE_DESCRIPTION("Qualcomm RPM Master Statistics driver");
>> +MODULE_LICENSE("GPL");
>>
>> -- 
>> 2.40.0
>>
> 
