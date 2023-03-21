Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221646C394E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 19:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjCUSlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 14:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjCUSlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 14:41:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995D112862;
        Tue, 21 Mar 2023 11:40:59 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LIap1p020941;
        Tue, 21 Mar 2023 18:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=L2AvPuVSi6wuvj6AAUFqI69gloHvDgwojcI8TR1lUBc=;
 b=BflUqde7EOWnOHhsPllqX1dRbbInC/E6AUHRi0OMBwh8W6g5sC/97D1eg2uT8k0j1a/u
 1Hvdlqeykiw3sC028HrkXPZTDiwNNOUVIKXoJewAyXQ3Om141v3viAAOaWwOy8/Q7Zto
 O3ho2DB+kAbMd0wwvcZIWS90PiKbOPnCd+0dCnOpFGBalhofFtDKO+EANb4f29sTnK6N
 yz392Oytf/cNRhpa/ELRQgFAhPUhMAiUL4UuuhpLJPOFyf1CwKekbYcjQYQcZV8IO5Av
 rQeBpAnjrM9QEuMmnVlysLtCpqCj/EkMS3N4iGEg2AS4HZlihVk2kEK+E4TgIi/yMKyv xQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pfc2ps7v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 18:40:41 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32LIeesg007433
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 18:40:40 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 21 Mar
 2023 11:40:39 -0700
Message-ID: <bc68f88e-81fd-e24c-30b6-73bff4652bae@quicinc.com>
Date:   Tue, 21 Mar 2023 11:40:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v11 16/26] firmware: qcom_scm: Register Gunyah platform
 ops
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Alex Elder <elder@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Prakruthi Deepak Heragu" <quic_pheragu@quicinc.com>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230304010632.2127470-1-quic_eberman@quicinc.com>
 <20230304010632.2127470-17-quic_eberman@quicinc.com>
 <6c2e3fac-1bd8-be10-6e10-e200ee9b55f2@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <6c2e3fac-1bd8-be10-6e10-e200ee9b55f2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: x1nn_l0acy1QnZG2zC3wJtcU9aDXbEoe
X-Proofpoint-GUID: x1nn_l0acy1QnZG2zC3wJtcU9aDXbEoe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 clxscore=1011 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210148
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/2023 7:24 AM, Srinivas Kandagatla wrote:
> Hi Elliot,
> 
> On 04/03/2023 01:06, Elliot Berman wrote:
>> Qualcomm platforms have a firmware entity which performs access control
>> to physical pages. Dynamically started Gunyah virtual machines use the
>> QCOM_SCM_RM_MANAGED_VMID for access. Linux thus needs to assign access
>> to the memory used by guest VMs. Gunyah doesn't do this operation for us
>> since it is the current VM (typically VMID_HLOS) delegating the access
>> and not Gunyah itself. Use the Gunyah platform ops to achieve this so
>> that only Qualcomm platforms attempt to make the needed SCM calls.
>>
>> Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>> Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   drivers/firmware/Kconfig       |   2 +
>>   drivers/firmware/qcom_scm.c    | 100 +++++++++++++++++++++++++++++++++
>>   include/linux/gunyah_rsc_mgr.h |   2 +-
>>   3 files changed, 103 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
>> index b59e3041fd62..b888068ff6f2 100644
>> --- a/drivers/firmware/Kconfig
>> +++ b/drivers/firmware/Kconfig
>> @@ -214,6 +214,8 @@ config MTK_ADSP_IPC
>>   config QCOM_SCM
>>       tristate
>> +    select VIRT_DRIVERS
>> +    select GUNYAH_PLATFORM_HOOKS
>>
> 
> I still have concerns with this selects in Kconfig on older Qualcomm 
> platforms that use SCM and do not have GUNYAH.
> 
> In our last discussing you mentioned the requirement for
> "CONFIG_GUNYAH=y and CONFIG_QCOM_SCM=m"
> 
> I think that should be doable and remove selecting if you can make a 
> separate GUNYAH_QCOM_PLATFORM_HOOKS driver
> 
> Does this work?

This works for Android and all the Qualcomm vendor (downstream) 
platforms where we can explicitly load modules. I don't think this 
module would be implicitly loaded by any kernel mechanism.

>  >----------------------->cut<-------------------------------
>  From 1fb7995aecf17caefd09ffb516579bc4ac9ac301 Mon Sep 17 00:00:00 2001
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Date: Tue, 21 Mar 2023 13:34:02 +0000
> Subject: [PATCH] virt: gunyah: add qcom platform hooks
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   drivers/firmware/Kconfig                      |  2 --
>   drivers/firmware/qcom_scm.c                   | 14 +++-----
>   drivers/virt/gunyah/Kconfig                   |  5 +++
>   drivers/virt/gunyah/Makefile                  |  1 +
>   .../virt/gunyah/gunyah_qcom_platform_hooks.c  | 35 +++++++++++++++++++
>   include/linux/firmware/qcom/qcom_scm.h        |  3 ++
>   6 files changed, 48 insertions(+), 12 deletions(-)
>   create mode 100644 drivers/virt/gunyah/gunyah_qcom_platform_hooks.c
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index b888068ff6f2..b59e3041fd62 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -214,8 +214,6 @@ config MTK_ADSP_IPC
> 
>   config QCOM_SCM
>       tristate
> -    select VIRT_DRIVERS
> -    select GUNYAH_PLATFORM_HOOKS
> 
>   config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
>       bool "Qualcomm download mode enabled by default"
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 5273cf64ee2a..194ea2bc9a1d 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -1301,7 +1301,7 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 
> payload_reg, u32 payload_val,
>   }
>   EXPORT_SYMBOL(qcom_scm_lmh_dcvsh);
> 
> -static int qcom_scm_gh_rm_pre_mem_share(struct gh_rm *rm, struct 
> gh_rm_mem_parcel *mem_parcel)
> +int qcom_scm_gh_rm_pre_mem_share(struct gh_rm_mem_parcel *mem_parcel)
>   {
>       struct qcom_scm_vmperm *new_perms;
>       u64 src, src_cpy;
> @@ -1359,8 +1359,9 @@ static int qcom_scm_gh_rm_pre_mem_share(struct 
> gh_rm *rm, struct gh_rm_mem_parce
>       kfree(new_perms);
>       return ret;
>   }
> +EXPORT_SYMBOL_GPL(qcom_scm_gh_rm_pre_mem_share);
> 
> -static int qcom_scm_gh_rm_post_mem_reclaim(struct gh_rm *rm, struct 
> gh_rm_mem_parcel *mem_parcel)
> +int qcom_scm_gh_rm_post_mem_reclaim(struct gh_rm_mem_parcel *mem_parcel)
>   {
>       struct qcom_scm_vmperm new_perms;
>       u64 src = 0, src_cpy;
> @@ -1388,11 +1389,7 @@ static int qcom_scm_gh_rm_post_mem_reclaim(struct 
> gh_rm *rm, struct gh_rm_mem_pa
> 
>       return ret;
>   }
> -
> -static struct gh_rm_platform_ops qcom_scm_gh_rm_platform_ops = {
> -    .pre_mem_share = qcom_scm_gh_rm_pre_mem_share,
> -    .post_mem_reclaim = qcom_scm_gh_rm_post_mem_reclaim,
> -};
> +EXPORT_SYMBOL_GPL(qcom_scm_gh_rm_post_mem_reclaim);
> 
>   static int qcom_scm_find_dload_address(struct device *dev, u64 *addr)
>   {
> @@ -1597,9 +1594,6 @@ static int qcom_scm_probe(struct platform_device 
> *pdev)
>       if (download_mode)
>           qcom_scm_set_download_mode(true);
> 
> -    if (devm_gh_rm_register_platform_ops(&pdev->dev, 
> &qcom_scm_gh_rm_platform_ops))
> -        dev_warn(__scm->dev, "Gunyah RM platform ops were already 
> registered\n");
> -
>       return 0;
>   }
> 
> diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
> index bd8e31184962..a9c48d6518f7 100644
> --- a/drivers/virt/gunyah/Kconfig
> +++ b/drivers/virt/gunyah/Kconfig
> @@ -16,6 +16,11 @@ config GUNYAH
>   config GUNYAH_PLATFORM_HOOKS
>       tristate
> 
> +config GUNYAH_QCOM_PLATFORM_HOOKS
> +    tristate "Gunyah Platform hooks for Qualcomm"
> +        depends on ARCH_QCOM && QCOM_SCM
> +    depends on GUNYAH
> +
>   config GUNYAH_VCPU
>       tristate "Runnable Gunyah vCPUs"
>       depends on GUNYAH
> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
> index 7347b1470491..c33f701bb5c8 100644
> --- a/drivers/virt/gunyah/Makefile
> +++ b/drivers/virt/gunyah/Makefile
> @@ -2,6 +2,7 @@
> 
>   obj-$(CONFIG_GUNYAH) += gunyah.o
>   obj-$(CONFIG_GUNYAH_PLATFORM_HOOKS) += gunyah_platform_hooks.o
> +obj-$(CONFIG_GUNYAH_QCOM_PLATFORM_HOOKS) += gunyah_qcom_platform_hooks.o
> 
>   gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o vm_mgr_mm.o
>   obj-$(CONFIG_GUNYAH) += gunyah_rsc_mgr.o
> diff --git a/drivers/virt/gunyah/gunyah_qcom_platform_hooks.c 
> b/drivers/virt/gunyah/gunyah_qcom_platform_hooks.c
> new file mode 100644
> index 000000000000..3332f84134d3
> --- /dev/null
> +++ b/drivers/virt/gunyah/gunyah_qcom_platform_hooks.c
> @@ -0,0 +1,35 @@
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/gunyah_rsc_mgr.h>
> +
> +static int qcom_gh_rm_pre_mem_share(struct gh_rm *rm, struct 
> gh_rm_mem_parcel *mem_parcel)
> +{
> +    return qcom_scm_gh_rm_pre_mem_share(mem_parcel);
> +}
> +
> +static int qcom_gh_rm_post_mem_reclaim(struct gh_rm *rm, struct 
> gh_rm_mem_parcel *mem_parcel)
> +{
> +    return qcom_scm_gh_rm_post_mem_reclaim(mem_parcel);
> +}
> +
> +static struct gh_rm_platform_ops qcom_gh_platform_hooks_ops = {
> +    .pre_mem_share = qcom_gh_rm_pre_mem_share,
> +    .post_mem_reclaim = qcom_gh_rm_post_mem_reclaim,
> +};
> +
> +static int __init qcom_gh_platform_hooks_register(void)
> +{
> +    return gh_rm_register_platform_ops(&qcom_gh_platform_hooks_ops);
> +}
> +
> +static void __exit qcom_gh_platform_hooks_unregister(void)
> +{
> +    gh_rm_unregister_platform_ops(&qcom_gh_platform_hooks_ops);
> +}
> +
> +module_init(qcom_gh_platform_hooks_register);
> +module_exit(qcom_gh_platform_hooks_unregister);
> +
> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Gunyah Platform Hooks 
> driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/firmware/qcom/qcom_scm.h 
> b/include/linux/firmware/qcom/qcom_scm.h
> index 1e449a5d7f5c..9b0d33db803d 100644
> --- a/include/linux/firmware/qcom/qcom_scm.h
> +++ b/include/linux/firmware/qcom/qcom_scm.h
> @@ -121,5 +121,8 @@ extern int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 
> payload_reg, u32 payload_val,
>                     u64 limit_node, u32 node_id, u64 version);
>   extern int qcom_scm_lmh_profile_change(u32 profile_id);
>   extern bool qcom_scm_lmh_dcvsh_available(void);
> +struct gh_rm_mem_parcel;
> +extern int qcom_scm_gh_rm_post_mem_reclaim(struct gh_rm_mem_parcel 
> *mem_parcel);
> +extern int qcom_scm_gh_rm_pre_mem_share(struct gh_rm_mem_parcel 
> *mem_parcel);
> 
>   #endif
> --------------------------->cut<-----------------------
> 
>>   config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
>>       bool "Qualcomm download mode enabled by default"
>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>> index b95616b35bff..89a261a9e021 100644
>> --- a/drivers/firmware/qcom_scm.c
>> +++ b/drivers/firmware/qcom_scm.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/clk.h>
>>   #include <linux/reset-controller.h>
>>   #include <linux/arm-smccc.h>
>> +#include <linux/gunyah_rsc_mgr.h>
>>   #include "qcom_scm.h"
>> @@ -30,6 +31,9 @@ module_param(download_mode, bool, 0);
>>   #define SCM_HAS_IFACE_CLK    BIT(1)
>>   #define SCM_HAS_BUS_CLK        BIT(2)
>> +#define QCOM_SCM_RM_MANAGED_VMID    0x3A
>> +#define QCOM_SCM_MAX_MANAGED_VMID    0x3F
>> +
>>   struct qcom_scm {
>>       struct device *dev;
>>       struct clk *core_clk;
>> @@ -1299,6 +1303,99 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 
>> payload_reg, u32 payload_val,
>>   }
>>   EXPORT_SYMBOL(qcom_scm_lmh_dcvsh);
>> +static int qcom_scm_gh_rm_pre_mem_share(struct gh_rm *rm, struct 
>> gh_rm_mem_parcel *mem_parcel)
>> +{
>> +    struct qcom_scm_vmperm *new_perms;
>> +    u64 src, src_cpy;
>> +    int ret = 0, i, n;
>> +    u16 vmid;
>> +
>> +    new_perms = kcalloc(mem_parcel->n_acl_entries, 
>> sizeof(*new_perms), GFP_KERNEL);
>> +    if (!new_perms)
>> +        return -ENOMEM;
>> +
>> +    for (n = 0; n < mem_parcel->n_acl_entries; n++) {
>> +        vmid = le16_to_cpu(mem_parcel->acl_entries[n].vmid);
>> +        if (vmid <= QCOM_SCM_MAX_MANAGED_VMID)
>> +            new_perms[n].vmid = vmid;
>> +        else
>> +            new_perms[n].vmid = QCOM_SCM_RM_MANAGED_VMID;
>> +        if (mem_parcel->acl_entries[n].perms & GH_RM_ACL_X)
>> +            new_perms[n].perm |= QCOM_SCM_PERM_EXEC;
>> +        if (mem_parcel->acl_entries[n].perms & GH_RM_ACL_W)
>> +            new_perms[n].perm |= QCOM_SCM_PERM_WRITE;
>> +        if (mem_parcel->acl_entries[n].perms & GH_RM_ACL_R)
>> +            new_perms[n].perm |= QCOM_SCM_PERM_READ;
>> +    }
>> +
>> +    src = (1ull << QCOM_SCM_VMID_HLOS);
>> +
>> +    for (i = 0; i < mem_parcel->n_mem_entries; i++) {
>> +        src_cpy = src;
>> +        ret = 
>> qcom_scm_assign_mem(le64_to_cpu(mem_parcel->mem_entries[i].ipa_base),
>> +                        le64_to_cpu(mem_parcel->mem_entries[i].size),
>> +                        &src_cpy, new_perms, mem_parcel->n_acl_entries);
>> +        if (ret) {
>> +            src = 0;
>> +            for (n = 0; n < mem_parcel->n_acl_entries; n++) {
>> +                vmid = le16_to_cpu(mem_parcel->acl_entries[n].vmid);
>> +                if (vmid <= QCOM_SCM_MAX_MANAGED_VMID)
>> +                    src |= (1ull << vmid);
>> +                else
>> +                    src |= (1ull << QCOM_SCM_RM_MANAGED_VMID);
>> +            }
>> +
>> +            new_perms[0].vmid = QCOM_SCM_VMID_HLOS;
>> +
>> +            for (i--; i >= 0; i--) {
>> +                src_cpy = src;
>> +                WARN_ON_ONCE(qcom_scm_assign_mem(
>> +                        
>> le64_to_cpu(mem_parcel->mem_entries[i].ipa_base),
>> +                        le64_to_cpu(mem_parcel->mem_entries[i].size),
>> +                        &src_cpy, new_perms, 1));
>> +            }
>> +            break;
>> +        }
>> +    }
>> +
>> +    kfree(new_perms);
>> +    return ret;
>> +}
>> +
>> +static int qcom_scm_gh_rm_post_mem_reclaim(struct gh_rm *rm, struct 
>> gh_rm_mem_parcel *mem_parcel)
>> +{
>> +    struct qcom_scm_vmperm new_perms;
>> +    u64 src = 0, src_cpy;
>> +    int ret = 0, i, n;
>> +    u16 vmid;
>> +
>> +    new_perms.vmid = QCOM_SCM_VMID_HLOS;
>> +    new_perms.perm = QCOM_SCM_PERM_EXEC | QCOM_SCM_PERM_WRITE | 
>> QCOM_SCM_PERM_READ;
>> +
>> +    for (n = 0; n < mem_parcel->n_acl_entries; n++) {
>> +        vmid = le16_to_cpu(mem_parcel->acl_entries[n].vmid);
>> +        if (vmid <= QCOM_SCM_MAX_MANAGED_VMID)
>> +            src |= (1ull << vmid);
>> +        else
>> +            src |= (1ull << QCOM_SCM_RM_MANAGED_VMID);
>> +    }
>> +
>> +    for (i = 0; i < mem_parcel->n_mem_entries; i++) {
>> +        src_cpy = src;
>> +        ret = 
>> qcom_scm_assign_mem(le64_to_cpu(mem_parcel->mem_entries[i].ipa_base),
>> +                        le64_to_cpu(mem_parcel->mem_entries[i].size),
>> +                        &src_cpy, &new_perms, 1);
>> +        WARN_ON_ONCE(ret);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static struct gh_rm_platform_ops qcom_scm_gh_rm_platform_ops = {
>> +    .pre_mem_share = qcom_scm_gh_rm_pre_mem_share,
>> +    .post_mem_reclaim = qcom_scm_gh_rm_post_mem_reclaim,
>> +};
>> +
>>   static int qcom_scm_find_dload_address(struct device *dev, u64 *addr)
>>   {
>>       struct device_node *tcsr;
>> @@ -1502,6 +1599,9 @@ static int qcom_scm_probe(struct platform_device 
>> *pdev)
>>       if (download_mode)
>>           qcom_scm_set_download_mode(true);
>> +    if (devm_gh_rm_register_platform_ops(&pdev->dev, 
>> &qcom_scm_gh_rm_platform_ops))
>> +        dev_warn(__scm->dev, "Gunyah RM platform ops were already 
>> registered\n");
>> +
>>       return 0;
>>   }
>> diff --git a/include/linux/gunyah_rsc_mgr.h 
>> b/include/linux/gunyah_rsc_mgr.h
>> index 515087931a2b..acf8c1545a6c 100644
>> --- a/include/linux/gunyah_rsc_mgr.h
>> +++ b/include/linux/gunyah_rsc_mgr.h
>> @@ -145,7 +145,7 @@ int gh_rm_get_hyp_resources(struct gh_rm *rm, u16 
>> vmid,
>>                   struct gh_rm_hyp_resources **resources);
>>   int gh_rm_get_vmid(struct gh_rm *rm, u16 *vmid);
>> -struct gunyah_rm_platform_ops {
>> +struct gh_rm_platform_ops {
>>       int (*pre_mem_share)(struct gh_rm *rm, struct gh_rm_mem_parcel 
>> *mem_parcel);
>>       int (*post_mem_reclaim)(struct gh_rm *rm, struct 
>> gh_rm_mem_parcel *mem_parcel);
>>   };
