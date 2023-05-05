Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A776F7C74
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 07:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjEEFgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 01:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEEFgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 01:36:16 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA1611558;
        Thu,  4 May 2023 22:36:14 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3454HFDr023499;
        Fri, 5 May 2023 05:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+wjAs5fToFkOWO4a/n9QJ3tzstnM/tfFB2MeAAMz60c=;
 b=f9ugbWCN8pskJ70gZgJmGi3NsHJyf8jFkVGQl7S/y5zCkxfl56RxK1B2K2KpNj96vSKm
 ZBJFVLCzh4yQjX4rr02DMlSsVvuyFQXJIhM5/Je+hZmQocRhhrCZbAOuDkJPEG3R4Nwu
 bAx5W5wAqhlVHT8w6ld7tbF3wukNQU/EkQU+eNdG2HiZp0MOg5rmu4nfZZCXYLHZ420j
 hBL0UUfEG5Icb0q1xmQ1wtZRNRffSFdM8/liz9X6waDH7Ku7V79BT/mFtzIzeD8YJZ1f
 JFym1PGX0b1WxWtdS42tfsl7xbD0G7K4UcC5YCmQkIvlgEiTLTAEThwXcREkfAxU3Ukp hQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qctfu85h0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 05:34:45 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3455YiuX012035
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 May 2023 05:34:44 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 4 May 2023
 22:34:38 -0700
Message-ID: <04ead29c-7fd1-df0d-f313-2fc0edfe9010@quicinc.com>
Date:   Fri, 5 May 2023 11:04:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 04/18] soc: qcom: Add Qualcomm minidump kernel driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <corbet@lwn.net>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
 <1683133352-10046-5-git-send-email-quic_mojha@quicinc.com>
 <c6f730b6-f702-91d4-4abd-71546e02f869@linaro.org>
 <23b493f4-1a01-8d03-fc12-d588b2c6fd74@quicinc.com>
 <575a422d-6224-06b7-628c-8487b47882e9@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <575a422d-6224-06b7-628c-8487b47882e9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4R-6zqruaxS_Bvqy053CSofvBhq92lT-
X-Proofpoint-ORIG-GUID: 4R-6zqruaxS_Bvqy053CSofvBhq92lT-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_15,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 phishscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050047
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/2023 8:51 PM, Krzysztof Kozlowski wrote:
> On 04/05/2023 14:38, Mukesh Ojha wrote:
>>
>>
>> On 5/4/2023 5:06 PM, Krzysztof Kozlowski wrote:
>>> On 03/05/2023 19:02, Mukesh Ojha wrote:
>>>> Minidump is a best effort mechanism to collect useful and predefined
>>>> data for first level of debugging on end user devices running on
>>>> Qualcomm SoCs. It is built on the premise that System on Chip (SoC)
>>>> or subsystem part of SoC crashes, due to a range of hardware and
>>>> software bugs. Hence, the ability to collect accurate data is only
>>>> a best-effort. The data collected could be invalid or corrupted,
>>>> data collection itself could fail, and so on.
>>>>
>>>> Qualcomm devices in engineering mode provides a mechanism for
>>>> generating full system ramdumps for post mortem debugging. But in some
>>>> cases it's however not feasible to capture the entire content of RAM.
>>>> The minidump mechanism provides the means for selecting region should
>>>> be included in the ramdump. The solution supports extracting the
>>>> ramdump/minidump produced either over USB or stored to an attached
>>>> storage device.
>>>>
>>>> The core of minidump feature is part of Qualcomm's boot firmware code.
>>>> It initializes shared memory(SMEM), which is a part of DDR and
>>>> allocates a small section of it to minidump table i.e also called
>>>> global table of content (G-ToC). Each subsystem (APSS, ADSP, ...) has
>>>> their own table of segments to be included in the minidump, all
>>>> references from a descriptor in SMEM (G-ToC). Each segment/region has
>>>> some details like name, physical address and it's size etc. and it
>>>> could be anywhere scattered in the DDR.
>>>>
>>>> Minidump kernel driver adds the capability to add linux region to be
>>>> dumped as part of ram dump collection. It provides appropriate symbol
>>>> to check its enablement and register client regions.
>>>>
>>>> To simplify post mortem debugging, it creates and maintain an ELF
>>>> header as first region that gets updated upon registration
>>>> of a new region.
>>>>
>>>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>>> ---
>>>>    drivers/soc/qcom/Kconfig         |  14 +
>>>>    drivers/soc/qcom/Makefile        |   1 +
>>>>    drivers/soc/qcom/qcom_minidump.c | 581 +++++++++++++++++++++++++++++++++++++++
>>>>    drivers/soc/qcom/smem.c          |   8 +
>>>>    include/soc/qcom/qcom_minidump.h |  61 +++-
>>>>    5 files changed, 663 insertions(+), 2 deletions(-)
>>>>    create mode 100644 drivers/soc/qcom/qcom_minidump.c
>>>>
>>>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>>>> index a491718..15c931e 100644
>>>> --- a/drivers/soc/qcom/Kconfig
>>>> +++ b/drivers/soc/qcom/Kconfig
>>>> @@ -279,4 +279,18 @@ config QCOM_INLINE_CRYPTO_ENGINE
>>>>    	tristate
>>>>    	select QCOM_SCM
>>>>    
>>>> +config QCOM_MINIDUMP
>>>> +	tristate "QCOM Minidump Support"
>>>> +	depends on ARCH_QCOM || COMPILE_TEST
>>>> +	select QCOM_SMEM
>>>> +	help
>>>> +	  Enablement of core minidump feature is controlled from boot firmware
>>>> +	  side, and this config allow linux to query and manages APPS minidump
>>>> +	  table.
>>>> +
>>>> +	  Client drivers can register their internal data structures and debug
>>>> +	  messages as part of the minidump region and when the SoC is crashed,
>>>> +	  these selective regions will be dumped instead of the entire DDR.
>>>> +	  This saves significant amount of time and/or storage space.
>>>> +
>>>>    endmenu
>>>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>>>> index 0f43a88..1ebe081 100644
>>>> --- a/drivers/soc/qcom/Makefile
>>>> +++ b/drivers/soc/qcom/Makefile
>>>> @@ -33,3 +33,4 @@ obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
>>>>    obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
>>>>    obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
>>>>    obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= ice.o
>>>> +obj-$(CONFIG_QCOM_MINIDUMP) += qcom_minidump.o
>>>> diff --git a/drivers/soc/qcom/qcom_minidump.c b/drivers/soc/qcom/qcom_minidump.c
>>>> new file mode 100644
>>>> index 0000000..d107a86
>>>> --- /dev/null
>>>> +++ b/drivers/soc/qcom/qcom_minidump.c
>>>> @@ -0,0 +1,581 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +
>>>> +/*
>>>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>>>> + */
>>>> +
>>>> +#include <linux/elf.h>
>>>> +#include <linux/err.h>
>>>> +#include <linux/errno.h>
>>>> +#include <linux/export.h>
>>>> +#include <linux/init.h>
>>>> +#include <linux/io.h>
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/string.h>
>>>> +#include <linux/soc/qcom/smem.h>
>>>> +#include <soc/qcom/qcom_minidump.h>
>>>> +
>>>> +/**
>>>> + * struct minidump_elfhdr - Minidump table elf header
>>>> + * @ehdr: Elf main header
>>>> + * @shdr: Section header
>>>> + * @phdr: Program header
>>>> + * @elf_offset: Section offset in elf
>>>> + * @strtable_idx: String table current index position
>>>> + */
>>>> +struct minidump_elfhdr {
>>>> +	struct elfhdr		*ehdr;
>>>> +	struct elf_shdr		*shdr;
>>>> +	struct elf_phdr		*phdr;
>>>> +	size_t			elf_offset;
>>>> +	size_t			strtable_idx;
>>>> +};
>>>> +
>>>> +/**
>>>> + * struct minidump - Minidump driver private data
>>>> + * @md_gbl_toc	: Global TOC pointer
>>>> + * @md_apss_toc	: Application Subsystem TOC pointer
>>>> + * @md_regions	: High level OS region base pointer
>>>> + * @elf		: Minidump elf header
>>>> + * @dev		: Minidump device
>>>> + */
>>>> +struct minidump {
>>>> +	struct minidump_global_toc	*md_gbl_toc;
>>>> +	struct minidump_subsystem	*md_apss_toc;
>>>> +	struct minidump_region		*md_regions;
>>>> +	struct minidump_elfhdr		elf;
>>>> +	struct device			*dev;
>>>> +};
>>>> +
>>>> +/*
>>>> + * In some of the Old Qualcomm devices, boot firmware statically allocates 300
>>>> + * as total number of supported region (including all co-processors) in
>>>> + * minidump table out of which linux was using 201. In future, this limitation
>>>> + * from boot firmware might get removed by allocating the region dynamically.
>>>> + * So, keep it compatible with older devices, we can keep the current limit for
>>>> + * Linux to 201.
>>>> + */
>>>> +#define MAX_NUM_ENTRIES	  201
>>>> +#define MAX_STRTBL_SIZE	  (MAX_NUM_ENTRIES * MAX_REGION_NAME_LENGTH)
>>>> +
>>>> +static struct minidump *__md;
>>>
>>> No, no file scope or global scope statics.
>>
>> Sorry, this is done as per recommendation given here [1] and this
>> matches both driver/firmware/qcom_scm.c and driver/soc/qcom/smem.c
>> implementations.
>>
>> [1]
>> https://lore.kernel.org/lkml/f74dfcde-e59b-a9b3-9bbc-a8de644f6740@linaro.org/
> 
> That's not true. You had the static already in v2, before Srini commented.
> 
> Look:
> https://lore.kernel.org/lkml/1679491817-2498-5-git-send-email-quic_mojha@quicinc.com/
> 
> +static struct minidump minidump;
> +static DEFINE_MUTEX(minidump_lock);
> 
> We do not talk about the names.

I apologize for this.

> 
> 
>>>> +
>>>> +	if (size < sizeof(*mdgtoc) || !mdgtoc->status) {
>>>> +		ret = -EINVAL;
>>>> +		dev_err(&pdev->dev, "minidump table is not initialized: %d\n", ret);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	mutex_lock(&minidump_lock);
>>>> +	md->dev = &pdev->dev;
>>>> +	md->md_gbl_toc = mdgtoc;
>>>
>>> What are you protecting here? It's not possible to have concurrent
>>> access to md, is it?
>>
>> Check qcom_apss_minidump_region_{register/unregister} and it is possible
>> that these API gets called parallel to this probe.
> 
> Wait, you say that something can modify local variable md before it is
> assigned to __md? How?

No.

>>
>> I agree, i made a mistake in not protecting __md in {register} API
>> but did it unregister API in this patch, which i have fixed in later patch.
> 
> No, you are protecting random things. Nothing will concurrently modify
> md and &pdev->dev in this moment. mdgtoc is allocated above, so also
> cannot by modified.
> 
> Otherwise show me the hypothetical scenario.

You are correct, it should just protect the assignment.
__md = md;

Thanks
> 
> 
>>
>>>
>>>> +	ret = qcom_minidump_init_apss_subsystem(md);
>>>> +	if (ret) {
>>>> +		dev_err(&pdev->dev, "apss minidump initialization failed: %d\n", ret);
>>>> +		goto unlock;
>>>> +	}
>>>> +
>>>> +	__md = md;
>>>
>>> No. This is a platform device, so it can have multiple instances.
>>
>> It can have only one instance that is created from SMEM driver probe.
> 
> Anyone can instantiate more of them.... how did you solve it?
> 
> 
>>
>>>
>>>> +	/* First entry would be ELF header */
>>>> +	ret = qcom_apss_minidump_add_elf_header();
>>>> +	if (ret) {
>>>> +		dev_err(&pdev->dev, "Failed to add elf header: %d\n", ret);
>>>> +		memset(md->md_apss_toc, 0, sizeof(struct minidump_subsystem));
>>>> +		__md = NULL;
>>>> +	}
>>>> +
>>>> +unlock:
>>>> +	mutex_unlock(&minidump_lock);
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int qcom_minidump_remove(struct platform_device *pdev)
>>>> +{
>>>> +	memset(__md->md_apss_toc, 0, sizeof(struct minidump_subsystem));
>>>> +	__md = NULL;
>>>
>>> Don't use __ in variable names. Drop it everywhere.
>>
>> As i said above, this is being followed in other drivers, so followed
>> it here as per recommendation.
>>
>> Let @srini comeback on this.
> 
> Which part of coding style recommends __ for driver code?

Will fix this.

> 
>>
>>>
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static struct platform_driver qcom_minidump_driver = {
>>>> +	.probe = qcom_minidump_probe,
>>>> +	.remove = qcom_minidump_remove,
>>>> +	.driver  = {
>>>> +		.name = "qcom-minidump",
>>>> +	},
>>>> +};
>>>> +
>>>> +module_platform_driver(qcom_minidump_driver);
>>>> +
>>>> +MODULE_DESCRIPTION("Qualcomm APSS minidump driver");
>>>> +MODULE_LICENSE("GPL v2");
>>>> +MODULE_ALIAS("platform:qcom-minidump");
>>>> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
>>>> index 6be7ea9..d459656 100644
>>>> --- a/drivers/soc/qcom/smem.c
>>>> +++ b/drivers/soc/qcom/smem.c
>>>> @@ -279,6 +279,7 @@ struct qcom_smem {
>>>>    
>>>>    	u32 item_count;
>>>>    	struct platform_device *socinfo;
>>>> +	struct platform_device *minidump;
>>>>    	struct smem_ptable *ptable;
>>>>    	struct smem_partition global_partition;
>>>>    	struct smem_partition partitions[SMEM_HOST_COUNT];
>>>> @@ -1151,12 +1152,19 @@ static int qcom_smem_probe(struct platform_device *pdev)
>>>>    	if (IS_ERR(smem->socinfo))
>>>>    		dev_dbg(&pdev->dev, "failed to register socinfo device\n");
>>>>    
>>>> +	smem->minidump = platform_device_register_data(&pdev->dev, "qcom-minidump",
>>>> +						      PLATFORM_DEVID_NONE, NULL,
>>>> +						      0);
>>>> +	if (IS_ERR(smem->minidump))
>>>> +		dev_dbg(&pdev->dev, "failed to register minidump device\n");
>>>> +
>>>>    	return 0;
>>>>    }
>>>>    
>>>>    static int qcom_smem_remove(struct platform_device *pdev)
>>>>    {
>>>>    	platform_device_unregister(__smem->socinfo);
>>>> +	platform_device_unregister(__smem->minidump);
>>>
>>> Wrong order. You registered first socinfo, right?
>>
>> Any order is fine here, they are not dependent.
>> But, will fix this.
> 
> No, the order is always reversed from allocation. It does not matter if
> they are dependent or not.

Ok

> 
> Best regards,
> Krzysztof
> 

-- Mukesh
