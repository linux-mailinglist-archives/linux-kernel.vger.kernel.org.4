Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F75E620E33
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbiKHLHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbiKHLHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:07:18 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEB44AF07;
        Tue,  8 Nov 2022 03:07:06 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A8AO8Ew002333;
        Tue, 8 Nov 2022 11:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=z0xaTcA6eeg6FMwTcztQpDpMBhDj8XeaUGKaH0GIGpI=;
 b=k0clqwUzVIb7f+oKM7w1M9H3gH+DrHO1jFc1M73kZmj45MBSbaaJ9nJ3LDWmllcuD14L
 ZTzaionK5rKeY28QZNK+fEToClpZEADFxayh9ntCWUMXpr4EqA2USHB+WzmN+FbndFMF
 SKyJ3gD7MGbTylhMQij+YqY2clisKPtHCDC5cKPBE51r2EbNbgeiLJEf+7vvQDcEtW7S
 1Yhjgd0AA2YgHHyw9BBiE9s5nPrMJ3acomMbnG6WdB+zgYvlfvIVkgamnIcVyONsUzBw
 C8pMPiq6K/r4L0NtcAlEi9W0ZWOteYLTh6Uoq02GbUTFnHdBO9qsEEZz+7aIGe1o6r2Y CQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kqhmggjj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 11:06:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A8B6tPd001297
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Nov 2022 11:06:55 GMT
Received: from [10.79.43.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 8 Nov 2022
 03:06:51 -0800
Message-ID: <06f59819-8e8c-bd57-76a2-3d548f8f427d@quicinc.com>
Date:   Tue, 8 Nov 2022 16:36:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC 2/2] firmware: arm_scmi: Add SCMI QTI Memlat vendor protocol
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <sudeep.holla@arm.com>,
        <cristian.marussi@arm.com>, <agross@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <konrad.dybcio@somainline.org>,
        <quic_avajid@quicinc.com>
References: <1667451512-9655-1-git-send-email-quic_sibis@quicinc.com>
 <1667451512-9655-3-git-send-email-quic_sibis@quicinc.com>
 <Y2QeVDQOZZ89+DR0@google.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <Y2QeVDQOZZ89+DR0@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v1siSt5-W4DY5Di2ybhU2na9WX7yFnwQ
X-Proofpoint-ORIG-GUID: v1siSt5-W4DY5Di2ybhU2na9WX7yFnwQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211080062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Matthias,

Thanks for taking time to review the series.

On 11/4/22 01:32, Matthias Kaehlcke wrote:
> Hi Sibi,
> 
> On Thu, Nov 03, 2022 at 10:28:32AM +0530, Sibi Sankar wrote:
>> Add support for the SCMI QTI memlat (memory latency) vendor protocol.
>> The QTI memlat vendor protocol takes in several tuneables including the
>> IPM ratio (Instructions Per Miss), bus bandwidth requirements and PMU
>> maps to enable frequency scaling of various buses (L3/LLCC/DDR) performed
>> by the memory latency governor running on the CPUSS Control Processor.
>>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>   drivers/firmware/arm_scmi/Kconfig              |  10 +
>>   drivers/firmware/arm_scmi/Makefile             |   1 +
>>   drivers/firmware/arm_scmi/qcom_memlat_vendor.c | 269 +++++++++++++++++++++++++
>>   include/linux/scmi_protocol.h                  |  36 ++++
>>   4 files changed, 316 insertions(+)
>>   create mode 100644 drivers/firmware/arm_scmi/qcom_memlat_vendor.c
>>
>> diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
>> index a14f65444b35..814a3fc37dc1 100644
>> --- a/drivers/firmware/arm_scmi/Kconfig
>> +++ b/drivers/firmware/arm_scmi/Kconfig
>> @@ -136,6 +136,16 @@ config ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE
>>   
>>   endif #ARM_SCMI_PROTOCOL
>>   
>> +config QTI_SCMI_MEMLAT_PROTOCOL
>> +	tristate "Qualcomm Technologies, Inc. SCMI MEMLAT vendor Protocol"
>> +	depends on ARM_SCMI_PROTOCOL && QCOM_CPUCP_MBOX
>> +	help
>> +	  The SCMI QTI memlat vendor protocol adds support for the frequency
>> +	  scaling of buses (L3/LLCC/DDR) by the QTI HW memlat governor running
>> +	  on the CPUSS Control Processor (CPUCP).
>> +
>> +	  Say Y here if you want to build this driver.
>> +
>>   config ARM_SCMI_POWER_DOMAIN
>>   	tristate "SCMI power domain driver"
>>   	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
>> diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
>> index 9ea86f8cc8f7..78e6d72fb9bb 100644
>> --- a/drivers/firmware/arm_scmi/Makefile
>> +++ b/drivers/firmware/arm_scmi/Makefile
>> @@ -11,6 +11,7 @@ scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o volt
>>   scmi-module-objs := $(scmi-bus-y) $(scmi-driver-y) $(scmi-protocols-y) \
>>   		    $(scmi-transport-y)
>>   obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-module.o
>> +obj-$(CONFIG_QTI_SCMI_MEMLAT_PROTOCOL) += qcom_memlat_vendor.o
>>   obj-$(CONFIG_ARM_SCMI_POWER_DOMAIN) += scmi_pm_domain.o
>>   obj-$(CONFIG_ARM_SCMI_POWER_CONTROL) += scmi_power_control.o
>>   
>> diff --git a/drivers/firmware/arm_scmi/qcom_memlat_vendor.c b/drivers/firmware/arm_scmi/qcom_memlat_vendor.c
>> new file mode 100644
>> index 000000000000..4b7db309e633
>> --- /dev/null
>> +++ b/drivers/firmware/arm_scmi/qcom_memlat_vendor.c
>> @@ -0,0 +1,269 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/scmi_protocol.h>
>> +
>> +#include "protocols.h"
>> +
>> +#define MAX_MAP_ENTRIES 14
>> +#define MAX_PMU_ENTRIES 24
>> +
>> +enum scmi_memlat_protocol_cmd {
>> +	MEMLAT_SET_CPU_GROUP = 0x10,
>> +	MEMLAT_SET_MONITOR = 0x11,
>> +	MEMLAT_COMMON_PMU_MAP = 0x12,
>> +	MEMLAT_MON_PMU_MAP = 0x13,
>> +	MEMLAT_IPM_RATIO = 0x14,
>> +	MEMLAT_STALL_RATIO = 0x15,
>> +	MEMLAT_SAMPLE_MS = 0x18,
>> +	MEMLAT_MON_FREQ_MAP = 0x19,
>> +	MEMLAT_START_MONITOR = 0x1c,
>> +	MEMLAT_STOP_MONITOR = 0x1d,
>> +};
>> +
>> +struct node_msg {
>> +	u32 cpumask;
>> +	u32 mon_type;
>> +};
>> +
>> +struct scalar_param_msg {
>> +	u32 cpumask;
>> +	u32 mon_type;
>> +	u32 val;
>> +};
>> +
>> +struct map_table {
>> +	u32 v1;
>> +	u32 v2;
>> +};
>> +
>> +struct map_param_msg {
>> +	u32 cpumask;
>> +	u32 mon_type;
>> +	u32 nr_rows;
>> +	struct map_table tbl[MAX_MAP_ENTRIES];
>> +};
>> +
>> +struct pmu_map_msg {
>> +	u32 cpumask;
>> +	u32 mon_type;
>> +	u32 nr_entries;
>> +	u32 pmu[MAX_PMU_ENTRIES];
>> +};
>> +
>> +static int scmi_set_cpugrp_mon(const struct scmi_protocol_handle *ph,
>> +			       u32 cpus_mpidr, u32 mon_type, u32 msg_id)
>> +{
>> +	int ret = 0;
> 
> no need to initialize
> 
>> +	struct scmi_xfer *t;
>> +	struct node_msg *msg;
>> +
>> +	ret = ph->xops->xfer_get_init(ph, msg_id, sizeof(*msg), sizeof(*msg), &t);
>> +	if (ret)
>> +		return ret;
>> +
>> +	msg = t->tx.buf;
>> +	msg->cpumask = cpu_to_le32(cpus_mpidr);
>> +	msg->mon_type = cpu_to_le32(mon_type);
>> +	ret = ph->xops->do_xfer(ph, t);
>> +	ph->xops->xfer_put(ph, t);
>> +
>> +	return ret;
>> +}
>> +
>> +static int scmi_set_mon(const struct scmi_protocol_handle *ph, u32 cpus_mpidr, u32 mon_type)
>> +{
>> +	return scmi_set_cpugrp_mon(ph, cpus_mpidr, mon_type, MEMLAT_SET_MONITOR);
>> +}
>> +
>> +static int scmi_set_cpu_grp(const struct scmi_protocol_handle *ph, u32 cpus_mpidr, u32 mon_type)
>> +{
>> +	return scmi_set_cpugrp_mon(ph, cpus_mpidr, mon_type, MEMLAT_SET_CPU_GROUP);
>> +}
>> +
>> +static int scmi_send_pmu_map_command(const struct scmi_protocol_handle *ph, u32 cpus_mpidr,
>> +				     u32 mon_type, u32 nr_entries, void *buf, u32 msg_id)
>> +{
>> +	u32 *dst;
>> +	int ret, i = 0;
> 
> initialization is not needed
> 
>> +	struct scmi_xfer *t;
>> +	struct pmu_map_msg *msg;
>> +	struct map_table *src = buf;
>> +
>> +	if (nr_entries > MAX_PMU_ENTRIES)
>> +		return -EINVAL;
>> +
>> +	ret = ph->xops->xfer_get_init(ph, msg_id, sizeof(*msg), sizeof(*msg), &t);
>> +	if (ret)
>> +		return ret;
>> +
>> +	msg = t->tx.buf;
>> +	msg->cpumask = cpu_to_le32(cpus_mpidr);
>> +	msg->mon_type = cpu_to_le32(mon_type);
> 
> The above 7 lines are a recurring pattern. Might be worth to have a wrapper for
> it. The datatype of 'msg' varies though, so it would have to be a macro :(
> 
>> +	msg->nr_entries = cpu_to_le32(nr_entries);
>> +	dst = msg->pmu;
>> +
>> +	for (i = 0; i < nr_entries; i++)
>> +		dst[i] = cpu_to_le32(src[i].v2);
>> +
>> +	ret = ph->xops->do_xfer(ph, t);
>> +	ph->xops->xfer_put(ph, t);
>> +	return ret;
> 
> This above 3 lines also recurring, consider a wrapper. With that the above
> would become:
> 
> 	return scmi_do_xfer(ph, t);

Ack. Will drop the unnecessary initialisations during the next re-spin
as well.

>> +}
>> +
>> +static int scmi_common_pmu_map(const struct scmi_protocol_handle *ph, u32 cpus_mpidr,
>> +			       u32 mon_type, u32 nr_entries, void *buf)
>> +{
>> +	return scmi_send_pmu_map_command(ph, cpus_mpidr, mon_type, nr_entries,
>> +					 buf, MEMLAT_COMMON_PMU_MAP);
>> +}
>> +
>> +static int scmi_mon_pmu_map(const struct scmi_protocol_handle *ph, u32 cpus_mpidr,
>> +			    u32 mon_type, u32 nr_entries, void *buf)
>> +{
>> +	return scmi_send_pmu_map_command(ph, cpus_mpidr, mon_type, nr_entries,
>> +					 buf, MEMLAT_MON_PMU_MAP);
>> +}
>> +
>> +static int scmi_freq_map(const struct scmi_protocol_handle *ph, u32 cpus_mpidr,
>> +			 u32 mon_type, u32 nr_rows, void *buf)
>> +{
>> +	int ret, i = 0;
> 
> initialization is unnecessary
> 
>> +	struct scmi_xfer *t;
>> +	struct map_param_msg *msg;
>> +	struct map_table *tbl, *src = buf;
>> +
>> +	if (nr_rows > MAX_MAP_ENTRIES)
>> +		return -EINVAL;
>> +
>> +	ret = ph->xops->xfer_get_init(ph, MEMLAT_MON_FREQ_MAP, sizeof(*msg),
>> +				      sizeof(*msg), &t);
>> +	if (ret)
>> +		return ret;
>> +
>> +	msg = t->tx.buf;
>> +	msg->cpumask = cpu_to_le32(cpus_mpidr);
>> +	msg->mon_type = cpu_to_le32(mon_type);
>> +	msg->nr_rows = cpu_to_le32(nr_rows);
>> +	tbl = msg->tbl;
>> +
>> +	for (i = 0; i < nr_rows; i++) {
>> +		tbl[i].v1 = cpu_to_le32(src[i].v1);
>> +		tbl[i].v2 = cpu_to_le32(src[i].v2);
>> +	}
>> +
>> +	ret = ph->xops->do_xfer(ph, t);
>> +	ph->xops->xfer_put(ph, t);
>> +	return ret;
>> +}
>> +
>> +static int scmi_set_tunable(const struct scmi_protocol_handle *ph, u32 cpus_mpidr,
>> +			    u32 msg_id, u32 mon_type, u32 val)
>> +{
>> +	int ret = 0;
> 
> drop initialization
> 
>> +	struct scmi_xfer *t;
>> +	struct scalar_param_msg *msg;
>> +
>> +	ret = ph->xops->xfer_get_init(ph, msg_id, sizeof(*msg), sizeof(*msg), &t);
>> +	if (ret)
>> +		return ret;
>> +
>> +	msg = t->tx.buf;
>> +	msg->cpumask = cpu_to_le32(cpus_mpidr);
>> +	msg->mon_type = cpu_to_le32(mon_type);
>> +	msg->val = cpu_to_le32(val);
>> +	ret = ph->xops->do_xfer(ph, t);
>> +	ph->xops->xfer_put(ph, t);
>> +
>> +	return ret;
>> +}
>> +
>> +static int scmi_ipm_ratio(const struct scmi_protocol_handle *ph, u32 cpus_mpidr,
>> +			  u32 mon_type, u32 val)
>> +{
>> +	return scmi_set_tunable(ph, cpus_mpidr, MEMLAT_IPM_RATIO, mon_type, val);
>> +}
>> +
>> +static int scmi_stall_ratio(const struct scmi_protocol_handle *ph, u32 cpus_mpidr,
>> +			    u32 mon_type, u32 val)
>> +{
>> +	return scmi_set_tunable(ph, cpus_mpidr, MEMLAT_STALL_RATIO, mon_type, val);
>> +}
>> +
>> +static int scmi_sample_ms(const struct scmi_protocol_handle *ph, u32 cpus_mpidr,
>> +			  u32 mon_type, u32 val)
>> +{
>> +	return scmi_set_tunable(ph, cpus_mpidr, MEMLAT_SAMPLE_MS, mon_type, val);
>> +}
>> +
>> +static int scmi_send_start_stop(const struct scmi_protocol_handle *ph,
>> +				u32 cpus_mpidr, u32 mon_type, u32 msg_id)
>> +{
>> +	int ret = 0;
> 
> drop init
> 
>> +	struct scmi_xfer *t;
>> +	struct scalar_param_msg *msg;
>> +
>> +	ret = ph->xops->xfer_get_init(ph, msg_id, sizeof(*msg), sizeof(*msg), &t);
>> +	if (ret)
>> +		return ret;
>> +
>> +	msg = t->tx.buf;
>> +	msg->cpumask = cpu_to_le32(cpus_mpidr);
>> +	msg->mon_type = cpu_to_le32(mon_type);
>> +	ret = ph->xops->do_xfer(ph, t);
>> +	ph->xops->xfer_put(ph, t);
>> +
>> +	return ret;
>> +}
>> +
>> +static int scmi_stop_mon(const struct scmi_protocol_handle *ph, u32 cpus_mpidr, u32 mon_type)
>> +{
>> +	return scmi_send_start_stop(ph, cpus_mpidr, mon_type, MEMLAT_STOP_MONITOR);
>> +}
>> +
>> +static int scmi_start_mon(const struct scmi_protocol_handle *ph, u32 cpus_mpidr, u32 mon_type)
>> +{
>> +	return scmi_send_start_stop(ph, cpus_mpidr, mon_type, MEMLAT_START_MONITOR);
>> +}
>> +
>> +static struct scmi_vendor_memlat_ops memlat_ops = {
>> +	.set_cpu_grp = scmi_set_cpu_grp,
>> +	.freq_map = scmi_freq_map,
>> +	.set_mon = scmi_set_mon,
>> +	.common_pmu_map = scmi_common_pmu_map,
>> +	.mon_pmu_map = scmi_mon_pmu_map,
>> +	.ipm_ratio = scmi_ipm_ratio,
>> +	.stall_ratio = scmi_stall_ratio,
>> +	.sample_ms = scmi_sample_ms,
>> +	.start_monitor = scmi_start_mon,
>> +	.stop_monitor = scmi_stop_mon,
>> +};
>> +
>> +static int scmi_vendor_memlat_protocol_init(const struct scmi_protocol_handle *ph)
>> +{
>> +	int ret;
>> +	u32 version;
>> +
>> +	ret = ph->xops->version_get(ph, &version);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dev_dbg(ph->dev, "Memlat Version %d.%d\n",
>> +		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct scmi_protocol scmi_vendor_memlat = {
>> +	.id = SCMI_VENDOR_PROTOCOL_MEMLAT,
>> +	.owner = THIS_MODULE,
>> +	.instance_init = &scmi_vendor_memlat_protocol_init,
>> +	.ops = &memlat_ops,
>> +};
>> +module_scmi_protocol(scmi_vendor_memlat);
>> +
>> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. SCMI Memlat Protocol");
>> +MODULE_LICENSE("GPL");
>> diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
>> index 4f765bc788ff..57abb5be45c9 100644
>> --- a/include/linux/scmi_protocol.h
>> +++ b/include/linux/scmi_protocol.h
>> @@ -677,6 +677,40 @@ struct scmi_powercap_proto_ops {
>>   };
>>   
>>   /**
>> + * struct scmi_vendor_memlat_ops - represents the various operations provided
>> + * by SCMI QTI HW Memlat Vendor Protocol
>> + *
>> + * @cpu_grp: set the cpugrp
>> + * @set_mon: set the supported monitors
>> + * @common_pmu_map: sets the common PMU map supported by governor
>> + * @mon_pmu_map: sets the additional PMU map supported by governor
>> + * @ipm_ratio: sets the ratio_ceil needed for hw memlat governor
>> + * @stall_ratio: sets the stall_floor needed for hw memlat governor
>> + * @sample_ms: sets the poll iterval of the governor
>> + * @freq_map: sets the freq_map of the governor
>> + * @start_mon: starts the monitor in firmware
>> + * @stop_mon: stops the monitor in firmware
>> + */
>> +struct scmi_vendor_memlat_ops {
>> +	int (*set_cpu_grp)(const struct scmi_protocol_handle *ph, u32 cpus_mpidr, u32 mon_type);
>> +	int (*set_mon)(const struct scmi_protocol_handle *ph, u32 cpus_mpidr, u32 mon_type);
>> +	int (*common_pmu_map)(const struct scmi_protocol_handle *ph, u32 cpus_mpidr, u32 mon_type,
>> +			      u32 nr_rows, void *buf);
>> +	int (*mon_pmu_map)(const struct scmi_protocol_handle *ph, u32 cpus_mpidr, u32 mon_type,
>> +			   u32 nr_rows, void *buf);
>> +	int (*ipm_ratio)(const struct scmi_protocol_handle *ph, u32 cpus_mpidr,
>> +			 u32 mon_type, u32 val);
>> +	int (*stall_ratio)(const struct scmi_protocol_handle *ph, u32 cpus_mpidr,
>> +			   u32 mon_type, u32 val);
>> +	int (*sample_ms)(const struct scmi_protocol_handle *ph, u32 cpus_mpidr,
>> +			 u32 mon_type, u32 val);
>> +	int (*freq_map)(const struct scmi_protocol_handle *ph, u32 cpus_mpidr, u32 mon_type,
>> +			u32 nr_rows, void *buf);
>> +	int (*start_monitor)(const struct scmi_protocol_handle *ph, u32 cpus_mpidr, u32 mon_type);
>> +	int (*stop_monitor)(const struct scmi_protocol_handle *ph, u32 cpus_mpidr, u32 mon_type);
>> +};
>> +
>> +/**
>>    * struct scmi_notify_ops  - represents notifications' operations provided by
>>    * SCMI core
>>    * @devm_event_notifier_register: Managed registration of a notifier_block for
>> @@ -785,6 +819,8 @@ enum scmi_std_protocol {
>>   	SCMI_PROTOCOL_POWERCAP = 0x18,
>>   };
>>   
>> +#define SCMI_VENDOR_PROTOCOL_MEMLAT    0x80
>> +
>>   enum scmi_system_events {
>>   	SCMI_SYSTEM_SHUTDOWN,
>>   	SCMI_SYSTEM_COLDRESET,
>> -- 
>> 2.7.4
>>
> 
> 
