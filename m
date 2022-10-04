Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8E05F4CD3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 01:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJDXu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 19:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJDXuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 19:50:55 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D443D599;
        Tue,  4 Oct 2022 16:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1664927454; x=1696463454;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=8In7ktfTyv+rkvAJ1Ycb5/srhr0/wSuR4vknf0drpHs=;
  b=zRjTJg/GT3zipn9Cfj0PON7JdWWQZiCpCkyJi6CYTvfndN4kBBhMYZrC
   Ip7LSUfZqYy5+xLTDDA4OzbmxWiZZWwzLqJ5IsZBpnuhsl5D7ScnELsnG
   iDjBJHLKVTsp33uTT7zdSuMP89CnfmBD8Upq6OOavxMF5HUFh4JS6fE0R
   Y=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 04 Oct 2022 16:50:54 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 16:50:52 -0700
Received: from [10.110.114.145] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 16:50:52 -0700
Message-ID: <2a8c1752-818d-bf19-5a3a-095b969c5c5a@quicinc.com>
Date:   Tue, 4 Oct 2022 16:50:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH v4 06/14] virt: gunyah: Add sysfs nodes
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Will Deacon" <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Arnd Bergmann" <arnd@arndb.de>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
 <20220928195633.2348848-7-quic_eberman@quicinc.com>
 <Yzbcd0r768pRgRMr@kroah.com>
Content-Language: en-US
In-Reply-To: <Yzbcd0r768pRgRMr@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/2022 5:09 AM, Greg Kroah-Hartman wrote:
> On Wed, Sep 28, 2022 at 12:56:25PM -0700, Elliot Berman wrote:
>> Add /sys/hypervisor support when detecting that Linux is running in a
>> Gunyah environment. Export the version of Gunyah which is reported via
>> the hyp_identify hypercall.
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>   .../ABI/testing/sysfs-hypervisor-gunyah       | 15 ++++
>>   MAINTAINERS                                   |  1 +
>>   drivers/virt/Makefile                         |  1 +
>>   drivers/virt/gunyah/Makefile                  |  2 +
>>   drivers/virt/gunyah/sysfs.c                   | 71 +++++++++++++++++++
>>   5 files changed, 90 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-hypervisor-gunyah
>>   create mode 100644 drivers/virt/gunyah/Makefile
>>   create mode 100644 drivers/virt/gunyah/sysfs.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-hypervisor-gunyah b/Documentation/ABI/testing/sysfs-hypervisor-gunyah
>> new file mode 100644
>> index 000000000000..7d74e74e9edd
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-hypervisor-gunyah
>> @@ -0,0 +1,15 @@
>> +What:		/sys/hypervisor/gunyah/api
>> +Date:		October 2022
>> +KernelVersion:	6.1
>> +Contact:	linux-arm-msm@vger.kernel.org
>> +Description:	If running under Gunyah:
>> +		The Gunyah API version.
> 
> What does this version mean?  What format is it in?
> 

The version is incremented on backwards-incompatible API changes. It's 
an integer: I've updated the description to mention it's an integer. FYI 
-- we are still currently at "1" and not aiming to increment this 
number. I'd like to get it reported in sysfs in case the version is 
incremented later.

>> +
>> +What:		/sys/hypervisor/gunyah/variant
>> +Date:		October 2022
>> +KernelVersion:	6.1
>> +Contact:	linux-arm-msm@vger.kernel.org
>> +Description:	If running under Gunyah:
>> +		Reports the build variant of Gunyah:
>> +		The open source build of Gunyah will report "81".
>> +		The Qualcomm build of Gunyah will report "72".
> 
> So there are only 2 versions variants?  What happens when you get a
> third?  And why the odd numbers?
> 

The kernel isn't parsing the reported build variant and is passing the 
reported value up to the sysfs node. If a new third variant comes along, 
its build variant number would be reported. Would it be preferred to 
instead link to Gunyah's definitions for the build variant?

> What will userspace do with this information and what tool will parse
> it? >

The usecase I'm envisioning is to help user check what build of Gunyah 
is present on the host. We don't have any intention to require userspace 
(or kernel) to behave differently whether they are on Qualcomm-built 
Gunyah or the open-source Gunyah.

>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index feafac12db35..a26e67ef36b4 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8885,6 +8885,7 @@ M:	Elliot Berman <quic_eberman@quicinc.com>
>>   M:	Murali Nalajala <quic_mnalajal@quicinc.com>
>>   L:	linux-arm-msm@vger.kernel.org
>>   S:	Supported
>> +F:	Documentation/ABI/testing/sysfs-hypervisor-gunyah
>>   F:	Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
>>   F:	Documentation/virt/gunyah/
>>   F:	arch/arm64/gunyah/
>> diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
>> index 093674e05c40..10b87f934730 100644
>> --- a/drivers/virt/Makefile
>> +++ b/drivers/virt/Makefile
>> @@ -11,3 +11,4 @@ obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
>>   obj-$(CONFIG_ACRN_HSM)		+= acrn/
>>   obj-$(CONFIG_EFI_SECRET)	+= coco/efi_secret/
>>   obj-$(CONFIG_SEV_GUEST)		+= coco/sev-guest/
>> +obj-$(CONFIG_GUNYAH)		+= gunyah/
>> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
>> new file mode 100644
>> index 000000000000..e15f16c17142
>> --- /dev/null
>> +++ b/drivers/virt/gunyah/Makefile
>> @@ -0,0 +1,2 @@
>> +gunyah-y += sysfs.o
>> +obj-$(CONFIG_GUNYAH) += gunyah.o
>> diff --git a/drivers/virt/gunyah/sysfs.c b/drivers/virt/gunyah/sysfs.c
>> new file mode 100644
>> index 000000000000..ec11510cbece
>> --- /dev/null
>> +++ b/drivers/virt/gunyah/sysfs.c
>> @@ -0,0 +1,71 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#define pr_fmt(fmt) "gunyah: " fmt
>> +
>> +#include <linux/kobject.h>
>> +#include <linux/module.h>
>> +#include <linux/printk.h>
>> +#include <linux/init.h>
>> +#include <asm-generic/gunyah.h>
>> +
>> +static struct gh_hypercall_hyp_identify_resp gunyah_api;
>> +
>> +static ssize_t api_show(struct kobject *kobj, struct kobj_attribute *attr, char *buffer)
>> +{
>> +	return sysfs_emit(buffer, "%d\n", (int)GH_API_INFO_API_VERSION(gunyah_api.api_info));
>> +}
>> +static struct kobj_attribute api_attr = __ATTR_RO(api);
>> +
>> +static ssize_t variant_show(struct kobject *kobj, struct kobj_attribute *attr, char *buffer)
>> +{
>> +	return sysfs_emit(buffer, "%d\n", (int)GH_API_INFO_VARIANT(gunyah_api.api_info));
>> +}
>> +static struct kobj_attribute variant_attr = __ATTR_RO(variant);
>> +
>> +static struct attribute *gunyah_attrs[] = {
>> +	&api_attr.attr,
>> +	&variant_attr.attr,
>> +	NULL
>> +};
>> +
>> +static const struct attribute_group gunyah_group = {
>> +	.name = "gunyah",
>> +	.attrs = gunyah_attrs,
>> +};
>> +
>> +static int __init gunyah_init(void)
>> +{
>> +	u32 uid[4];
>> +
>> +	gh_hypercall_get_uid(uid);
> 
> No error checking?
> 

The UID is filled by the first 4 return registers of the hypercall. If 
running under some other hypervisor or no hypervisor is present, then 
our expectation is that the relevant handler would fill some error value 
that isn't the UUID.

KVM uses similar approach to allow guests to identify they are a KVM guest:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/firmware/smccc/kvm_guest.c?h=v6.0-rc7#n23

>> +
>> +	if (!(gh_uid_matches(GUNYAH, uid) || gh_uid_matches(QC_HYP, uid)))
>> +		return 0;
>> +
>> +	gh_hypercall_hyp_identify(&gunyah_api);
>> +
>> +	if (GH_API_INFO_API_VERSION(gunyah_api.api_info) != 1) {
>> +		pr_warn("Unrecognized gunyah version: %llu. Currently supported: 1\n",
>> +			GH_API_INFO_API_VERSION(gunyah_api.api_info));
> 
> Shouldn't the "1" be defined somewhere?
> 
>> +		return 0;
>> +	}
>> +
>> +	pr_notice("Running under Gunyah hypervisor %llx/v%lld\n",
>> +		  GH_API_INFO_VARIANT(gunyah_api.api_info),
>> +		  GH_API_INFO_API_VERSION(gunyah_api.api_info));
> 
> When kernel code is working properly, it is quiet.  What is this going
> to be used for?
> 

Xen and KVM guest drivers also report when they detect that they are 
running under a hypervisor. I'll drop this down to pr_info to match.

> thanks,
> 
> greg k-h
