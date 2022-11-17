Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE1462E39A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240140AbiKQR4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiKQR4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:56:52 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361382EF0A;
        Thu, 17 Nov 2022 09:56:50 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHHpvnP007922;
        Thu, 17 Nov 2022 17:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=CWJAfnwyh5Q9V5PWdy4ziO9VlLOg/mrmsCUrHWibKhM=;
 b=hSuESqvVxDH4K0PFc83716rKu7EQE+N/6UQ1SJqF5oURw+3BqcoOrjcOv6Qf6dW767NW
 R8QAZBvGg1FMyq2lfCXg74ZuntF4Z2fx02Bjwgq9Qubpqjixgj4JmWvIvmjtdI7cIwRh
 JXxgJdvK01U3j1aEjm29FgYOMhPM2Umep74Yf0BKBxKvGRmA7aSGfy+J8wuaIsXKiU2U
 F7a803nBKNz+vaA4MDRhio9elVJdooxnUmm26GkO2nNoTY6wss580aJpKywxA9nszie6
 o5lt3bQTinOvpLkb7WmXudcPkNgSN+u4G8MBSKqd6G8XR1GdkicGQx+AcC6np0g+ylox cw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kws2m87sd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 17:56:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AHHubOr013696
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 17:56:37 GMT
Received: from [10.216.15.99] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 17 Nov
 2022 09:56:35 -0800
Message-ID: <9ba8f115-9f21-9edd-059d-638ad11b781f@quicinc.com>
Date:   Thu, 17 Nov 2022 23:26:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3] wifi: ath10k: Add WLAN firmware image version info
 into smem
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_mpubbise@quicinc.com>, <ath10k@lists.infradead.org>
References: <20221111114235.10287-1-quic_youghand@quicinc.com>
 <87edu5bsjw.fsf@kernel.org>
From:   "Youghandhar Chintala (Temp)" <quic_youghand@quicinc.com>
In-Reply-To: <87edu5bsjw.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JvzufnOMUDgRPdNxsOKLbd7ZmP2wWX92
X-Proofpoint-GUID: JvzufnOMUDgRPdNxsOKLbd7ZmP2wWX92
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211170130
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/14/2022 6:29 PM, Kalle Valo wrote:
> Youghandhar Chintala <quic_youghand@quicinc.com> writes:
>
>> In a SoC based solution, it would be useful to know the versions of the
>> various binary firmware blobs the system is running on. On a QCOM based
>> SoC, this info can be obtained from socinfo debugfs infrastructure. For
>> this to work, respective subsystem drivers have to export the firmware
>> version information to an SMEM based version information table.
>>
>> Having firmware version information at one place will help quickly
>> figure out the firmware versions of various subsystems on the device
>> instead of going through builds/logs in an event of a system crash.
>>
>> Fill WLAN firmware version information in SMEM version table to be
>> printed as part of socinfo debugfs infrastructure on a Qualcomm based
>> SoC.
>>
>> This change is applicable only for WCN399X targets.
>>
>> Example:
>> cat /sys/kernel/debug/qcom_socinfo/cnss/name
>> QC_IMAGE_VERSION_STRING=WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1
>>
>> Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
>> ---
>> Changes from v2:
>>   - Removed blank line between trailers
>>   - Changed memcpy to strscpy
>>   - Removed version_string_size
>>   - Added new condition fw_build_id against max length
>>   - Added depends on QCOM_SMEM for ath10k_snoc
>> ---
>>   drivers/net/wireless/ath/ath10k/Kconfig |  1 +
>>   drivers/net/wireless/ath/ath10k/qmi.c   | 34 +++++++++++++++++++++++++
>>   2 files changed, 35 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath10k/Kconfig b/drivers/net/wireless/ath/ath10k/Kconfig
>> index ca007b800f75..e6ea884cafc1 100644
>> --- a/drivers/net/wireless/ath/ath10k/Kconfig
>> +++ b/drivers/net/wireless/ath/ath10k/Kconfig
>> @@ -44,6 +44,7 @@ config ATH10K_SNOC
>>   	tristate "Qualcomm ath10k SNOC support"
>>   	depends on ATH10K
>>   	depends on ARCH_QCOM || COMPILE_TEST
>> +	depends on QCOM_SMEM
>>   	select QCOM_SCM
>>   	select QCOM_QMI_HELPERS
> Is there a reason why you used "depends on"? Other QCOM dependencies
> used "select", so I'm wondering if QCOM_SMEM should also use select?
Sure Kalle. As suggested will change it to select.
>
> Please also use ath10k list for ath10k patches, not ath11k.
Apologies, My bad.
