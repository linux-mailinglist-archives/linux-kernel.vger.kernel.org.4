Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7545C5B62B1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 23:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiILVXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 17:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiILVXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 17:23:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D432AC65;
        Mon, 12 Sep 2022 14:23:31 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28CK9kg1019828;
        Mon, 12 Sep 2022 21:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=c9DTEOEAoIHa2Rx+Yrnut8hcKibcNfTWoF6L03kLu6c=;
 b=i1rgvzQlHFJMUdOK8o7jAnylBTVIGFUmNYsCsb9CPuR6Iao1YUUOeh+7JSg4uwM2L6bo
 k9D1l85aC33+5hRroSVXDkO1UBfNUsA7KLSNCYpzfSVBEwvIFvyJuOnFpivBy0q8/M6p
 6isYGKr2iA7KevDxsSb0UwSFx9rphqUuIWzsu+YGvpBlxsVs8lGO2Ng4y+CI9uuXoRro
 PS4lUYYt/YjD9ebVDQ/eRFFNkl6XsXxnt90z/QFm0fyVqeSdZeZCy+bE+8ZMfnfGCtic
 +L50rguxuE3RCZajyOk8S3SY7xMZE54KnYVtwXs+5YS08VtJJ3fetyEt9vxlptfYH6ju XA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jgk635c2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 21:23:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28CLNNmt028792
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 21:23:23 GMT
Received: from [10.110.52.115] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 12 Sep
 2022 14:23:22 -0700
Message-ID: <ec1858fe-753f-c63a-4580-35851241fbcf@quicinc.com>
Date:   Mon, 12 Sep 2022 14:23:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/4] thermal: qcom: qmi_cooling: Add skeletal qmi cooling
 driver
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <daniel.lezcano@linaro.org>, <robh@kernel.org>,
        <andersson@kernel.org>, <rafael@kernel.org>,
        <bhupesh.linux@gmail.com>
References: <20220912085049.3517140-1-bhupesh.sharma@linaro.org>
 <20220912085049.3517140-2-bhupesh.sharma@linaro.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220912085049.3517140-2-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ij52ES8FZx2aawaEB_j-N9x_HPeFTn15
X-Proofpoint-ORIG-GUID: ij52ES8FZx2aawaEB_j-N9x_HPeFTn15
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_14,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 clxscore=1011 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2209120073
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/2022 1:50 AM, Bhupesh Sharma wrote:
> Add a skeleton driver for supporting Qualcomm QMI thermal mitigation
> (TMD) cooling devices.
> 
> The QMI TMD cooling devices are used for various mitigations for
> remote subsystem(s) including remote processor mitigation, rail
> voltage restriction etc. This driver uses kernel QMI interface
> to send the message to remote subsystem(s).
> 
> Each child node of the QMI TMD devicetree node should represent
> each remote subsystem and each child of this subsystem represents
> separate cooling devices.
> 
> Cc: daniel.lezcano@linaro.org
> Cc: rafael@kernel.org
> Cc: andersson@kernel.org
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>   .../qcom/qmi_cooling/qcom_qmi_cooling.c       | 632 ++++++++++++++++++
>   .../qcom/qmi_cooling/qcom_tmd_services.c      | 352 ++++++++++
>   .../qcom/qmi_cooling/qcom_tmd_services.h      | 120 ++++
>   3 files changed, 1104 insertions(+)
>   create mode 100644 drivers/thermal/qcom/qmi_cooling/qcom_qmi_cooling.c
>   create mode 100644 drivers/thermal/qcom/qmi_cooling/qcom_tmd_services.c
>   create mode 100644 drivers/thermal/qcom/qmi_cooling/qcom_tmd_services.h
> 
> diff --git a/drivers/thermal/qcom/qmi_cooling/qcom_qmi_cooling.c b/drivers/thermal/qcom/qmi_cooling/qcom_qmi_cooling.c
> new file mode 100644
> index 000000000000..4cb601533b9d
> --- /dev/null
> +++ b/drivers/thermal/qcom/qmi_cooling/qcom_qmi_cooling.c

[snip]

> +static char device_clients[][QMI_CLIENT_NAME_LENGTH] = {

can/should this be const?
can/should this use designated initializers?

> +	{"pa"},
> +	{"pa_fr1"},
> +	{"cx_vdd_limit"},
> +	{"modem"},
> +	{"modem_current"},
> +	{"modem_skin"},

[snip]

> diff --git a/drivers/thermal/qcom/qmi_cooling/qcom_tmd_services.c b/drivers/thermal/qcom/qmi_cooling/qcom_tmd_services.c
> new file mode 100644
> index 000000000000..5b950b8952f0
> --- /dev/null
> +++ b/drivers/thermal/qcom/qmi_cooling/qcom_tmd_services.c
> @@ -0,0 +1,352 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022, Linaro Limited
> + */
> +
> +#include <linux/soc/qcom/qmi.h>
> +
> +#include "qcom_tmd_services.h"
> +
> +static struct qmi_elem_info tmd_mitigation_dev_id_type_v01_ei[] = {

note that commit ff6d365898d ("soc: qcom: qmi: use const for struct
qmi_elem_info") allows QMI message encoding/decoding rules to be const

<https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/commit/?h=for-next&id=ff6d365898d4d31bd557954c7fc53f38977b491c>

I'm waiting for that to land in the soc tree before I submit my changes 
to all of the existing drivers, but you can do this now for the new driver

> +	{
> +		.data_type      = QMI_STRING,
> +		.elem_len       = QMI_TMD_MITIGATION_DEV_ID_LENGTH_MAX_V01 + 1,
> +		.elem_size      = sizeof(char),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0,
> +		.offset         = offsetof(
> +					struct tmd_mitigation_dev_id_type_v01,
> +					mitigation_dev_id),
> +	},
> +	{
> +		.data_type      = QMI_EOTI,
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = QMI_COMMON_TLV_TYPE,
> +	},
> +};

[snip]

> diff --git a/drivers/thermal/qcom/qmi_cooling/qcom_tmd_services.h b/drivers/thermal/qcom/qmi_cooling/qcom_tmd_services.h
> new file mode 100644
> index 000000000000..8af0bfd7eb48
> --- /dev/null
> +++ b/drivers/thermal/qcom/qmi_cooling/qcom_tmd_services.h

[snip]

> +extern struct qmi_elem_info tmd_get_mitigation_device_list_req_msg_v01_ei[];

don't forget to make the externs const as well

