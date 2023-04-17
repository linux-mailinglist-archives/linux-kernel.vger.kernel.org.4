Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022126E4A1E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjDQNkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDQNkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:40:09 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03462BA
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:40:08 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4edb9039a4cso1368468e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681738806; x=1684330806;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OfX3jjRBAyejaneTA/BukJVT9hltWcZ6BOSo0XWuuHM=;
        b=dNipT0zxpVH9LwkSmnABRW+aAyMOBTh2UM7lpkx/alNQB8ME8CfWujTxsFD5lxGpMS
         XdphnWFzTRIKRSO2Yphyq++emqJc6dmUtPXFUaHBaQT7WFtyws3LUKhHboG1Hg7WQdsH
         L6oRnQtRUCu5S4P82N6ARSSEh43aZwN8snAF8TMLGa83o5sbTV1v0NLFO3Rw9gf8+v9Q
         ZUmk+mNH3hj8sSdBKhI53SpFVBnkoY9Xy6kJ3V3EpR7E5gzLtJMQJuaZkDbbdXlpxlhD
         c9dVDXJD/M2dLWGlBkvLh5wTYcAbp0qymcox+O3lMbXF7/jBimC8juDowkJlAK1VsLpc
         un/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681738806; x=1684330806;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OfX3jjRBAyejaneTA/BukJVT9hltWcZ6BOSo0XWuuHM=;
        b=Mhw1guo+IQAoIrdylnWGhyOKo9Smz44STQIUpTZzxyRCsFWENp07KjWHZ2EreG+Mat
         OHxobXy0OYHK7FLpRafKNVVJVAcImx7/rJMpJ+ojdl1XYbkfnGe/3E+AuwWxL3OZI6zF
         iSUofXV0KLjjUP8ROnNPSO8PZk67aqc2g58HwR8gZuLzgt3A4ZfhTOy/L0j7XYTzbaQ3
         2/E3IIurXOXLxWz6WD/g/Qyqm57oKbDlU5xNfZJqRni1HYXGuP/lXdco+Zs7h2mdhIZt
         ohsvuX3BvML67gImKkwgPhLcvoEbXrgCSA1iOcHFWhcR0CMGCVLvBI/FhiPbH4sBXB1p
         5tQQ==
X-Gm-Message-State: AAQBX9fw6RniNnFslstq5fffQVy7gFXRsSuH2sstlsWbvxQAlaSeHnSB
        4qLw3ccrW7bv2eFwo+Yt3vfoSg==
X-Google-Smtp-Source: AKy350asxBHx6SjgbH1XtrKGinYIJdyc3SlVGJPj7DhRHC8UfFIrz28WHGfnjB9MElGEfLJN7kY3BA==
X-Received: by 2002:ac2:4c2f:0:b0:4ec:b1bf:a55b with SMTP id u15-20020ac24c2f000000b004ecb1bfa55bmr1644966lfq.24.1681738806214;
        Mon, 17 Apr 2023 06:40:06 -0700 (PDT)
Received: from [192.168.1.101] (abyk99.neoplus.adsl.tpnet.pl. [83.9.30.99])
        by smtp.gmail.com with ESMTPSA id u6-20020ac243c6000000b004e7fa99f2b5sm2062181lfl.186.2023.04.17.06.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 06:40:05 -0700 (PDT)
Message-ID: <aefda5ed-fee3-8919-2b96-a5bda7c77d06@linaro.org>
Date:   Mon, 17 Apr 2023 15:40:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 2/2] soc: qcom: Introduce RPM master stats driver
Content-Language: en-US
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
 <ab6d9730-2eae-44c7-a809-b29174acdefc@linaro.org>
 <20230417082003.GA2874@thinkpad>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230417082003.GA2874@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.04.2023 10:20, Manivannan Sadhasivam wrote:
> On Mon, Apr 17, 2023 at 09:14:39AM +0200, Konrad Dybcio wrote:
>>
>>
>> On 16.04.2023 16:20, Manivannan Sadhasivam wrote:
>>> On Fri, Apr 14, 2023 at 01:37:18PM +0200, Konrad Dybcio wrote:
>>>> Introduce a driver to query and expose detailed, per-subsystem (as opposed
>>>> to the existing qcom_stats driver which exposes SoC-wide data) about low
>>>> power mode states of a given RPM master. That includes the APSS (ARM),
>>>> MPSS (modem) and other remote cores, depending on the platform
>>>> configuration.
>>>>
>>>> This is a vastly cleaned up and restructured version of a similar
>>>> driver found in msm-5.4.
>>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>>  drivers/soc/qcom/Kconfig            |  11 +++
>>>>  drivers/soc/qcom/Makefile           |   1 +
>>>>  drivers/soc/qcom/rpm_master_stats.c | 160 ++++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 172 insertions(+)
>>>>
>>>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>>>> index a491718f8064..e597799e8121 100644
>>>> --- a/drivers/soc/qcom/Kconfig
>>>> +++ b/drivers/soc/qcom/Kconfig
>>>> @@ -135,6 +135,17 @@ config QCOM_RMTFS_MEM
>>>>  
>>>>  	  Say y here if you intend to boot the modem remoteproc.
>>>>  
>>>> +config QCOM_RPM_MASTER_STATS
>>>> +	tristate "Qualcomm RPM Master stats"
>>>> +	depends on ARCH_QCOM || COMPILE_TEST
>>>> +	help
>>>> +	  The RPM Master sleep stats driver provides detailed per-subsystem
>>>> +	  sleep/wake data, read from the RPM message RAM. It can be used to
>>>> +	  assess whether all the low-power modes available are entered as
>>>> +	  expected or to check which part of the SoC prevents it from sleeping.
>>>> +
>>>> +	  Say y here if you intend to debug or monitor platform sleep.
>>>> +
>>>>  config QCOM_RPMH
>>>>  	tristate "Qualcomm RPM-Hardened (RPMH) Communication"
>>>>  	depends on ARCH_QCOM || COMPILE_TEST
>>>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>>>> index 0f43a88b4894..7349371fdea1 100644
>>>> --- a/drivers/soc/qcom/Makefile
>>>> +++ b/drivers/soc/qcom/Makefile
>>>> @@ -14,6 +14,7 @@ obj-$(CONFIG_QCOM_QMI_HELPERS)	+= qmi_helpers.o
>>>>  qmi_helpers-y	+= qmi_encdec.o qmi_interface.o
>>>>  obj-$(CONFIG_QCOM_RAMP_CTRL)	+= ramp_controller.o
>>>>  obj-$(CONFIG_QCOM_RMTFS_MEM)	+= rmtfs_mem.o
>>>> +obj-$(CONFIG_QCOM_RPM_MASTER_STATS)	+= rpm_master_stats.o
>>>>  obj-$(CONFIG_QCOM_RPMH)		+= qcom_rpmh.o
>>>>  qcom_rpmh-y			+= rpmh-rsc.o
>>>>  qcom_rpmh-y			+= rpmh.o
>>>> diff --git a/drivers/soc/qcom/rpm_master_stats.c b/drivers/soc/qcom/rpm_master_stats.c
>>>> new file mode 100644
>>>> index 000000000000..73080c92bf89
>>>> --- /dev/null
>>>> +++ b/drivers/soc/qcom/rpm_master_stats.c
>>>> @@ -0,0 +1,160 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +/*
>>>> + * Copyright (c) 2012-2020, The Linux Foundation. All rights reserved.
>>>> + * Copyright (c) 2023, Linaro Limited
>>>> + *
>>>> + * This driver supports what is known as "Master Stats v2", which seems to be
>>>> + * the only version which has ever shipped, all the way from 2013 to 2023.
>>>
>>> It'd better to mention "Qualcomm downstream" in the somewhere above comment to
>>> make it clear for users.
>> Ack
>>
>>>
>>>> + */
>>>> +
>>>> +#include <linux/debugfs.h>
>>>> +#include <linux/io.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/of.h>
>>>> +#include <linux/of_address.h>
>>>> +#include <linux/platform_device.h>
>>>> +
>>>> +struct master_stats_data {
>>>> +	void __iomem *base;
>>>> +	const char *label;
>>>> +};
>>>> +
>>>> +struct rpm_master_stats {
>>>> +	uint32_t active_cores;
>>>> +	uint32_t num_shutdowns;
>>>> +	uint64_t shutdown_req;
>>>> +	uint64_t wakeup_idx;
>>>> +	uint64_t bringup_req;
>>>> +	uint64_t bringup_ack;
>>>> +	uint32_t wakeup_reason; /* 0 = "rude wakeup", 1 = scheduled wakeup */
>>>> +	uint32_t last_sleep_trans_dur;
>>>> +	uint32_t last_wake_trans_dur;
>>>> +
>>>> +	/* Per-subsystem (*not necessarily* SoC-wide) XO shutdown stats */
>>>> +	uint32_t xo_count;
>>>> +	uint64_t xo_last_enter;
>>>> +	uint64_t last_exit;
>>>> +	uint64_t xo_total_dur;
>>>
>>> Why can't you use u64, u32?
>> Brain derp!
>>
>>>
>>> Also, sort these members as below:
>>>
>>> u64
>>> u32
>> No, it's the way this data is structured in the
>> memory and we copy it as a whole.
>>
> 
> Ok, in that case you'd need __packed.
> 
>>>
>>>> +};
>>>> +
> 
> [...]
> 
>>>> +		/*
>>>> +		 * Generally it's not advised to fail on debugfs errors, but this
>>>> +		 * driver's only job is exposing data therein.
>>>> +		 */
>>>> +		dent = debugfs_create_file(d[i].label, 0444, root,
>>>> +					   &d[i], &master_stats_fops);
>>>> +		if (!dent) {
>>>
>>> Don't check for NULL, instead use IS_ERR() if you really care about error
>>> checking here.
>> "This function will return a pointer to a dentry if
>> it succeeds. This pointer must be passed to the
>> debugfs_remove function when the file is to be removed
>> (no automatic cleanup happens if your module is unloaded,
>> you are responsible here.) If an error occurs, NULL will
>> be returned."
> 
> This seems to be the old comment. Take a look at the updated one in mainline:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/debugfs/inode.c#n468
> 
> Greg changed the semantics of the debugfs APIs a while back but the kernel doc
> was updated recently:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/debugfs/inode.c?id=d3002468cb5d5da11e22145c9af32facd5c34352
Okay, ack to both. I'll fix all that and resend!

Konrad
> 
> - Mani
> 
>>
>>>
>>>> +			debugfs_remove_recursive(root);
>>>> +			return -EINVAL;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	device_set_pm_not_required(dev);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static void master_stats_remove(struct platform_device *pdev)
>>>> +{
>>>> +	struct dentry *root = platform_get_drvdata(pdev);
>>>> +
>>>> +	debugfs_remove_recursive(root);
>>>> +}
>>>> +
>>>> +static const struct of_device_id rpm_master_table[] = {
>>>> +	{ .compatible = "qcom,rpm-master-stats" },
>>>> +	{ },
>>>> +};
>>>> +
>>>> +static struct platform_driver master_stats_driver = {
>>>> +	.probe = master_stats_probe,
>>>> +	.remove_new = master_stats_remove,
>>>> +	.driver = {
>>>> +		.name = "rpm_master_stats",
>>>> +		.of_match_table = rpm_master_table,
>>>> +	},
>>>> +};
>>>> +module_platform_driver(master_stats_driver);
>>>> +
>>>> +MODULE_DESCRIPTION("RPM Master Statistics driver");
>>>
>>> Qualcomm RPM Master Statistics driver
>> Ack
>>
>> Konrad
>>>
>>> - Mani
>>>
>>>> +MODULE_LICENSE("GPL");
>>>>
>>>> -- 
>>>> 2.40.0
>>>>
>>>
> 
