Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9280262599C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbiKKLjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbiKKLjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:39:20 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA5185445;
        Fri, 11 Nov 2022 03:37:58 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ABAt9tV023290;
        Fri, 11 Nov 2022 11:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cEpjjc/lvZUdP9CiszCyq3MM6Y/+aEP2AO6k/8Du84c=;
 b=GimkxAkueN0AxWa5ZAIf7M3cQ6hvKIFrjpw0AtkC3I62OCYDX/W0d3FebflIrSCI00Wg
 NSySeduJgkOMTtxCCJJNALBFGrPhln4XKVtfA4IADyjpfxbP9dUIJxmteM7C6M3apj5d
 wjrw/qRensvHScn5kp9UJVZ+/o8IUzJGyii451DKJQWgSbiZFmiQr/mi4Yuhy5zSy0+D
 xhSAJCnVmVrgzC+EYHE4NNyuVHq26HmCoPoJR2TZ/Pu8a/EED2+aJCpHUmtmR389Lh+c
 AqGUmlmmu7+bXehvsh1EOTP5XqwefvDvKB76enjCQKEjG0cfeRk4x0lAFUzSxetJ/Ngn UA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kshkj0pd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 11:37:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ABBblOW022575
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 11:37:47 GMT
Received: from [10.216.1.108] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 11 Nov
 2022 03:37:44 -0800
Message-ID: <95f9b87a-3de8-7703-2472-2327acc789b4@quicinc.com>
Date:   Fri, 11 Nov 2022 17:07:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2] wifi: ath10k: Add WLAN firmware image version info
 into smem
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_mpubbise@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        "kernel test robot" <lkp@intel.com>
References: <20221104082828.14386-1-quic_youghand@quicinc.com>
 <CAE-0n5260hssngqWE6j4A_YK0Rq_OSnscpkyVTTiPEMEDz6AGg@mail.gmail.com>
From:   "Youghandhar Chintala (Temp)" <quic_youghand@quicinc.com>
In-Reply-To: <CAE-0n5260hssngqWE6j4A_YK0Rq_OSnscpkyVTTiPEMEDz6AGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: os3zDyeKeVarzYV3ZDj7MRZOIGHxcMQl
X-Proofpoint-GUID: os3zDyeKeVarzYV3ZDj7MRZOIGHxcMQl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_06,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 impostorscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211110077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/7/2022 11:05 PM, Stephen Boyd wrote:
> Quoting Youghandhar Chintala (2022-11-04 01:28:28)
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
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1
>>
>> Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
> The trailers go together, no blank lines between them.
>
>> ---
>> Changes from v1:
>>   - Changed print format specifier to %zu from %i
>>   - Changed ath10k_qmi_add_wlan_ver_smem() API argument
>>            to const char *fw_build_id from char *fw_build_id
>>   - Changed version_string_size with MACRO
>> ---
>>   drivers/net/wireless/ath/ath10k/qmi.c | 28 +++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
>> index 66cb7a1e628a..928d78f6d494 100644
>> --- a/drivers/net/wireless/ath/ath10k/qmi.c
>> +++ b/drivers/net/wireless/ath/ath10k/qmi.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/net.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/qcom_scm.h>
>> +#include <linux/soc/qcom/smem.h>
>>   #include <linux/string.h>
>>   #include <net/sock.h>
>>
>> @@ -22,6 +23,8 @@
>>
>>   #define ATH10K_QMI_CLIENT_ID           0x4b4e454c
>>   #define ATH10K_QMI_TIMEOUT             30
>> +#define ATH10K_SMEM_IMAGE_VERSION_TABLE       469
>> +#define ATH10K_SMEM_IMAGE_TABLE_CNSS_INDEX     13
>>
>>   static int ath10k_qmi_map_msa_permission(struct ath10k_qmi *qmi,
>>                                           struct ath10k_msa_mem_info *mem_info)
>> @@ -536,6 +539,29 @@ int ath10k_qmi_wlan_disable(struct ath10k *ar)
>>          return ath10k_qmi_mode_send_sync_msg(ar, QMI_WLFW_OFF_V01);
>>   }
>>
>> +static void ath10k_qmi_add_wlan_ver_smem(struct ath10k *ar, const char *fw_build_id)
>> +{
>> +       u8 *smem_table_ptr;
>> +       size_t smem_block_size;
>> +       const u32 version_string_size = MAX_BUILD_ID_LEN;
> Why not make this size_t as well so the type is the same for the
> comparison with smem_block_size?
>
>> +       const u32 smem_img_idx_wlan = ATH10K_SMEM_IMAGE_TABLE_CNSS_INDEX * 128;
>> +
>> +       smem_table_ptr = qcom_smem_get(QCOM_SMEM_HOST_ANY,
>> +                                      ATH10K_SMEM_IMAGE_VERSION_TABLE,
>> +                                      &smem_block_size);
>> +       if (IS_ERR(smem_table_ptr)) {
>> +               ath10k_dbg(ar, ATH10K_DBG_QMI, "smem image version table not found");
> Is this missing a newline?
>
>> +               return;
>> +       }
>> +       if (smem_img_idx_wlan + version_string_size > smem_block_size) {
>> +               ath10k_dbg(ar, ATH10K_DBG_QMI, "smem block size too small: %zu",
> Same newline question.
>
>> +                          smem_block_size);
>> +               return;
>> +       }
>> +       memcpy(smem_table_ptr + smem_img_idx_wlan, fw_build_id,
> Is it a string? Does it need to be NUL terminated? Should this use some
> sort of strcpy()? Does the comparison above need to leave a space for
> the NUL terminator?
>
>> +              version_string_size);
>> +}
>> +
>>   static int ath10k_qmi_cap_send_sync_msg(struct ath10k_qmi *qmi)
>>   {
>>          struct wlfw_cap_resp_msg_v01 *resp;


Thank you Stephen.

I will address all your comments in next version of patch.

Regards,

Youghandhar

