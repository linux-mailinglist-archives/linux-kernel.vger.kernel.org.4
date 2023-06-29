Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B07D741E52
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 04:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjF2Ces (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 22:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjF2Cep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 22:34:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFC6213D;
        Wed, 28 Jun 2023 19:34:43 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T1peCM003075;
        Thu, 29 Jun 2023 02:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=d1xxjDKKxjYzsTNuy7Mx3AfwCH5hklFJ313CSEx4CDc=;
 b=UrL4p8AxZNvIkpoZ8lDGC/EXh2IB4JSGFiUlscNhRpy5tgpPRepBr1tnPjnmMyQwgTdH
 ZFL8C21xW9wy/yX1BB5ZZmLpc4bUdUAVWW91ar1DXwqRJjVdHj4HpXwEkv6xtFsJm68m
 4ya0mtsfmGpBdZpMLL0BOZa/XfLKZ5Xvoxoii0qvEZMSBJNyqeFU5IJBOv+hiEn1BMVF
 0xN36nzxugD1u7IQd4vg32HLJwgKnJ1J3Ij6QxmEwLstU5gDvG/i/TT31QI1P43VOh3S
 NcJAMXnZ0sMGUbS2MvQDsOMB76Vr5+BNhnHLKty4ENNF+JHrSBaxkLoKgjfJj2hMD47S 5g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgextjcvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 02:34:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35T2Xr8m004431
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 02:33:53 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Wed, 28 Jun 2023 19:33:45 -0700
Date:   Thu, 29 Jun 2023 08:03:42 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
CC:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v4 04/21] soc: qcom: Add Qualcomm APSS minidump
 (frontend) feature support
Message-ID: <8f00beed-f07b-43b6-820e-87af719598c6@quicinc.com>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <1687955688-20809-5-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1687955688-20809-5-git-send-email-quic_mojha@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _PtAZJKIv8wUIJtY7Dr0KaYF-ZLooNex
X-Proofpoint-GUID: _PtAZJKIv8wUIJtY7Dr0KaYF-ZLooNex
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290021
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 06:04:31PM +0530, Mukesh Ojha wrote:
> Minidump is a best effort mechanism to collect useful and predefined
> data for first level of debugging on end user devices running on
> Qualcomm SoCs. It is built on the premise that System on Chip (SoC)
> or subsystem part of SoC crashes, due to a range of hardware and
> software bugs. Hence, the ability to collect accurate data is only
> a best-effort. The data collected could be invalid or corrupted,
> data collection itself could fail, and so on.
> 
> Qualcomm devices in engineering mode provides a mechanism for
> generating full system ramdumps for post mortem debugging. But in some
> cases it's however not feasible to capture the entire content of RAM.
> The minidump mechanism provides the means for selecting region should
> be included in the ramdump. The solution supports extracting the
> ramdump/minidump produced either over USB or stored to an attached
> storage device.
> 
> Minidump kernel driver implementation is divided into two parts for
> simplicity, one is minidump core which can also be called minidump
> frontend(As API gets exported from this driver for registration with
> backend) and the other part is minidump backend i.e, where the underlying
> implementation of minidump will be there. There could be different way
> how the backend is implemented like Shared memory, Memory mapped IO
> or Resource manager based where the guest region information is passed
> to hypervisor via hypercalls.
> 
> Minidump Client-1     Client-2      Client-5    Client-n
>          |               |              |             |
>          |               |    ...       |   ...       |
>          |               |              |             |
>          |               |              |             |
>          |               |              |             |
>          |               |              |             |
>          |               |              |             |
>          |               |              |             |
>          |           +---+--------------+----+        |
>          +-----------+  qcom_minidump(core)  +--------+
>                      |                       |
>                      +------+-----+------+---+
>                             |     |      |
>                             |     |      |
>             +---------------+     |      +--------------------+
>             |                     |                           |
>             |                     |                           |
>             |                     |                           |
>             v                     v                           v
>  +-------------------+      +-------------------+     +------------------+
>  |qcom_minidump_smem |      |qcom_minidump_mmio |     | qcom_minidump_rm |
>  |                   |      |                   |     |                  |
>  +-------------------+      +-------------------+     +------------------+
>    Shared memory              Memory mapped IO           Resource manager
>     (backend)                   (backend)                   (backend)
> 
> Here, we will be giving all analogy of backend with SMEM as it is the
> only implemented backend at present but general idea remains the same.
> 
> The core of minidump feature is part of Qualcomm's boot firmware code.
> It initializes shared memory (SMEM), which is a part of DDR and
> allocates a small section of it to minidump table i.e also called
> global table of content (G-ToC). Each subsystem (APSS, ADSP, ...) has
> their own table of segments to be included in the minidump, all
> references from a descriptor in SMEM (G-ToC). Each segment/region has
> some details like name, physical address and it's size etc. and it
> could be anywhere scattered in the DDR.
> 
> qcom_minidump(core or frontend) driver adds the capability to add APSS
> region to be dumped as part of ram dump collection. It provides
> appropriate symbol register/unregister client regions.
> 
> To simplify post mortem debugging, it creates and maintain an ELF
> header as first region that gets updated upon registration
> of a new region.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  drivers/soc/qcom/Kconfig                  |  15 +
>  drivers/soc/qcom/Makefile                 |   2 +
>  drivers/soc/qcom/qcom_minidump.c          | 456 ++++++++++++++++++++++++++++++
>  drivers/soc/qcom/qcom_minidump_internal.h |  75 +++++
>  include/soc/qcom/qcom_minidump.h          |  35 +++
>  5 files changed, 583 insertions(+)
>  create mode 100644 drivers/soc/qcom/qcom_minidump.c
>  create mode 100644 drivers/soc/qcom/qcom_minidump_internal.h
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 982310b5a1cb..874ee8c3efe0 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -279,6 +279,21 @@ config QCOM_INLINE_CRYPTO_ENGINE
>  	tristate
>  	select QCOM_SCM
>  
> +config QCOM_MINIDUMP
> +	tristate "QCOM Minidump APSS Core Infrastructure"
> +	depends on ARCH_QCOM
> +	help
> +	  This config allow linux core infrastructure for APSS minidump for
> +	  underlying backend(smem etc.) which can hook themselves to this and
> +	  work as one unit. So, this config should be selected in combination
> +	  with its backend.
> +
> +	  After this Linux clients driver can register their internal data
> +	  structures and debug messages as part of the apss minidump region
> +	  and when the SoC is crashed, and these selective regions will be
> +	  dumped instead of the entire DDR. This saves significant amount
> +	  of time and/or storage space.
> +
>  config QCOM_MINIDUMP_SMEM
>  	tristate "QCOM Minidump SMEM (as backend) Support"
>  	depends on ARCH_QCOM
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 89b775512bef..737d868757ac 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -34,3 +34,5 @@ obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
>  obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
>  qcom_ice-objs			+= ice.o
>  obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= qcom_ice.o
> +obj-$(CONFIG_QCOM_MINIDUMP) += qcom_minidump.o
> +obj-$(CONFIG_QCOM_MINIDUMP_SMEM) += qcom_minidump_smem.o
> diff --git a/drivers/soc/qcom/qcom_minidump.c b/drivers/soc/qcom/qcom_minidump.c
> new file mode 100644
> index 000000000000..7744e57843ab
> --- /dev/null
> +++ b/drivers/soc/qcom/qcom_minidump.c
> @@ -0,0 +1,456 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/device.h>
> +#include <linux/export.h>
> +#include <linux/kallsyms.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/printk.h>
> +#include <linux/string.h>
> +
> +#include "qcom_minidump_internal.h"
> +
> +/*
> + * In some of the Old Qualcomm devices, boot firmware statically allocates 300
> + * as total number of supported region (including all co-processors) in
> + * minidump table out of which linux was using 201. In future, this limitation
> + * from boot firmware might get removed by allocating the region dynamically.
> + * So, keep it compatible with older devices, we can keep the current limit for
> + * Linux to 201.
> + */
> +#define MAX_NUM_ENTRIES	  201
> +#define MAX_STRTBL_SIZE	  (MAX_NUM_ENTRIES * MAX_REGION_NAME_LENGTH)
> +

Should not we receive these constraints from backend?

> +/*
> + * md_lock protects "md" during calls to qcom_minidump_backend_register(),
> + * qcom_minidump_backend_unregister().
> + */
> +static DEFINE_MUTEX(md_lock);
> +
> +/* Only one front end will be attached to one back-end */
> +static struct minidump *md;
> +static char *md_backend;
> +

Can you explain this a bit more? There is just one fronend, correct?
Multiple possibilites of backend.

Is it a limitation at the moment that we support only one backend or
plan to support more backends later for the same frontend. Pls clarify.

> +static struct elf_shdr *elf_shdr_entry_addr(struct elfhdr *ehdr, int idx)
> +{
> +	struct elf_shdr *eshdr = (struct elf_shdr *)((size_t)ehdr + ehdr->e_shoff);
> +
> +	return &eshdr[idx];
> +}
> +

[...]

> +/**
> + * qcom_minidump_region_register() - Register region in APSS Minidump table.
> + * @region: minidump region.
> + *
> + * Return: On success, it returns 0 and negative error value on failure.
> + */

Are we not going to return any cookie upon success which can be passed
to us during unregistration?

> +int qcom_minidump_region_register(const struct qcom_minidump_region *region)
> +{
> +	int ret;
> +
> +	if (!qcom_minidump_valid_region(region))
> +		return -EINVAL;
> +
> +	mutex_lock(&md_lock);
> +	if (!md) {
> +		mutex_unlock(&md_lock);
> +		pr_err("No backend registered yet, try again..");
> +		return -EPROBE_DEFER;
> +	}
> +
> +	ret = md->ops->md_region_register(md, region);
> +	if (ret)
> +		goto unlock;
> +

The md_lock description in the beginning does not seems to be correct.
It is not limited to backend registration. It has much wider usage.

You are holding the lock while calling into backend. Basically the
synchronization is done in the front end.

> +	qcom_md_update_elf_header(region);
> +unlock:
> +	mutex_unlock(&md_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(qcom_minidump_region_register);
> +
> +/**
> + * qcom_minidump_region_unregister() - Unregister region from APSS Minidump table.
> + * @region: minidump region.
> + *
> + * Return: On success, it returns 0 and negative error value on failure.
> + */
> +int qcom_minidump_region_unregister(const struct qcom_minidump_region *region)
> +{
> +	int ret;
> +
> +	if (!qcom_minidump_valid_region(region))
> +		return -EINVAL;
> +
> +	mutex_lock(&md_lock);
> +	if (!md) {
> +		mutex_unlock(&md_lock);
> +		pr_err("No backend registered yet, try again..");
> +		return -EPROBE_DEFER;
> +	}
> +
> +	ret = md->ops->md_region_unregister(md, region);
> +	if (ret)
> +		goto unlock;
> +

The frontend is not validing that it is actually a registered client, it
is left to backend. Seems that is more duplication in the backend(s).

> +	ret = qcom_minidump_clear_header(region);
> +unlock:
> +	mutex_unlock(&md_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(qcom_minidump_region_unregister);

can we create a namespace for exporting these symbols?

> +
> +static int qcom_minidump_add_elf_header(struct minidump *md_data)
> +{

[...]

> +
> +/**
> + * qcom_minidump_backend_register() - Register backend minidump device.
> + * @md_data: minidump backend driver data
> + *
> + * Return: On success, it returns 0 and negative error value on failure.
> + */
> +int qcom_minidump_backend_register(struct minidump *md_data)
> +{
> +	int ret;
> +
> +	if (!md_data->name || !md_data->dev ||
> +	    !md_data->ops ||
> +	    !md_data->ops->md_table_init ||
> +	    !md_data->ops->md_region_register ||
> +	    !md_data->ops->md_region_unregister ||
> +	    !md_data->ops->md_table_exit) {
> +		pr_warn("backend '%s' must fill/implement necessary fields\n", md->name);
> +		return -EINVAL;
> +	}
> +
> +	if (md_backend && strcmp(md_backend, md_data->name)) {
> +		pr_warn("backend '%s' already in use: ignoring '%s'\n",
> +			 md_backend, md_data->name);
> +		return -EBUSY;
> +	}
> +
> +	mutex_lock(&md_lock);
> +	if (md) {
> +		dev_warn(md->dev, "backend '%s' already loaded: ignoring '%s'\n",
> +			 md->name, md_data->name);
> +		ret = -EBUSY;
> +		goto unlock;
> +	}
> +
> +	if (!md_data->max_region_limit || md_data->max_region_limit > MAX_NUM_ENTRIES)
> +		md_data->max_region_limit = MAX_NUM_ENTRIES;
> +
> +	ret = md_data->ops->md_table_init(md_data);
> +	if (ret) {
> +		dev_err(md_data->dev, "minidump backend initialization failed: %d\n", ret);
> +		goto unlock;
> +	}
> +
> +	/* First entry would be ELF header */
> +	ret = qcom_minidump_add_elf_header(md_data);
> +	if (ret) {
> +		dev_err(md_data->dev, "Failed to add elf header: %d\n", ret);
> +		md_data->ops->md_table_exit(md_data);
> +		goto unlock;
> +	}
> +
> +	md = md_data;
> +	md_backend = kstrdup(md->name, GFP_KERNEL);
> +	dev_info(md->dev, "Registered minidump backend : %s\n", md->name);
> +

What is the need for keeping md_backend separately? md::name is already
present.

Also, how do we prevent backend module unloading while it is inuse? or
we don't need that constraint?

> +unlock:
> +	mutex_unlock(&md_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(qcom_minidump_backend_register);

Thanks,
Pavan
