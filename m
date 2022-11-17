Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B06E62E38F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbiKQRzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbiKQRyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:54:51 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514DE13D7C;
        Thu, 17 Nov 2022 09:54:50 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHHqWJa002066;
        Thu, 17 Nov 2022 17:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dmHG/a6iT5M+Wlk/pJMeQSjTn+VMW2+OXLY/p6k654c=;
 b=fTc42uJJy1aYogAwR0sW6eXzN27XWDSqXsrkiA0Y3WWFhCxRNnKMBYhkGNNMUqjrosDB
 kKmHYGTDBunn2zJE0RdFA5id65BZ6btgdVNShp8eV97VSlgaAarSrVTbgvNZ5oVWNvM1
 VjQlkYgXhmrHkLNhFyklThg6lS2t80Of3INWyRb80GcM/gFq9ekqvpAEpyPaowuheXqE
 seAtSxO8uDK6rj/g+t5kKY61zfkRPNCjBxSZPBmdr+CsPeeg+XKoAmVaa6hSyUE+0CPr
 XcPHZqNeXeLFK48pYtxSM+DvTRru3Owfq7VlwXFyj7/5AJphcA43oqwCOM1hP16N7tWu 1w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kwrwb0952-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 17:54:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AHHsanv018990
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 17:54:36 GMT
Received: from [10.216.15.99] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 17 Nov
 2022 09:54:34 -0800
Message-ID: <5d6c1894-5037-2267-eac6-8c6974ea3b51@quicinc.com>
Date:   Thu, 17 Nov 2022 23:24:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3] wifi: ath10k: Add WLAN firmware image version info
 into smem
To:     Bjorn Andersson <andersson@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_mpubbise@quicinc.com>, <ath10k@lists.infradead.org>
References: <20221111114235.10287-1-quic_youghand@quicinc.com>
 <20221111202302.nbzu53hir2azdb4o@builder.lan>
Content-Language: en-US
From:   "Youghandhar Chintala (Temp)" <quic_youghand@quicinc.com>
In-Reply-To: <20221111202302.nbzu53hir2azdb4o@builder.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vu3VxZdZJTK0m89o-74DPwGcy2p_7WMG
X-Proofpoint-GUID: vu3VxZdZJTK0m89o-74DPwGcy2p_7WMG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 priorityscore=1501 clxscore=1011
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211170129
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/12/2022 1:53 AM, Bjorn Andersson wrote:
> On Fri, Nov 11, 2022 at 05:12:35PM +0530, Youghandhar Chintala wrote:
>
> Can you please change the subject to:
> wifi: ath10k: Store WLAN firmware version in SMEM image table
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
> Why is this restricted to WCN399X? Is it not the case that it only
> relates to the SNOC/QMI-based implementation? Perhaps that's the same
> thing, but if so I think the comment could be improved.
>
>> Example:
>> cat /sys/kernel/debug/qcom_socinfo/cnss/name
>> QC_IMAGE_VERSION_STRING=WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1
>>
>> Reported-by: kernel test robot <lkp@intel.com>
> I don't think that kernel test robot reported the lack of this feature.
>
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
>>   	help
>> diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
>> index 66cb7a1e628a..6c3ddad26417 100644
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
>>   #define ATH10K_QMI_CLIENT_ID		0x4b4e454c
>>   #define ATH10K_QMI_TIMEOUT		30
>> +#define ATH10K_SMEM_IMAGE_VERSION_TABLE       469
> This isn't the ATH10K SMEM_IMAGE_VERSION_TABLE, it's the one and only
> SMEM_IMAGE_VERSION_TABLE. As that is defined in socinfo.c, you can
> use the same define here.
>
>> +#define ATH10K_SMEM_IMAGE_TABLE_CNSS_INDEX     13
> SMEM_IMAGE_TABLE_CNSS_INDEX
>
>>   
>>   static int ath10k_qmi_map_msa_permission(struct ath10k_qmi *qmi,
>>   					 struct ath10k_msa_mem_info *mem_info)
>> @@ -536,6 +539,35 @@ int ath10k_qmi_wlan_disable(struct ath10k *ar)
>>   	return ath10k_qmi_mode_send_sync_msg(ar, QMI_WLFW_OFF_V01);
>>   }
>>   
>> +static void ath10k_qmi_add_wlan_ver_smem(struct ath10k *ar, const char *fw_build_id)
>> +{
>> +	u8 *smem_table_ptr;
> I don't think "smem" or "ptr" adds any value in this variable name.
> "table" should be sufficient.
>
>> +	size_t smem_block_size;
> This is the "smem_item_size".
>
>> +	const u32 smem_img_idx_wlan = ATH10K_SMEM_IMAGE_TABLE_CNSS_INDEX * 128;
> Why not just "offset"?
>
> #define SMEM_IMAGE_VERSION_ENTRY_SIZE 128
>
> Instead of writing 128 here and abusing MAX_BUILD_ID_LEN below.
>
>> +
>> +	smem_table_ptr = qcom_smem_get(QCOM_SMEM_HOST_ANY,
>> +				       ATH10K_SMEM_IMAGE_VERSION_TABLE,
>> +				       &smem_block_size);
>> +	if (IS_ERR(smem_table_ptr)) {
>> +		ath10k_dbg(ar, ATH10K_DBG_QMI,
>> +			   "smem image version table not found\n");
>> +		return;
>> +	}
>> +
>> +	if (smem_img_idx_wlan + MAX_BUILD_ID_LEN > smem_block_size) {
>> +		ath10k_dbg(ar, ATH10K_DBG_QMI, "smem block size too small: %zu\n",
>> +			   smem_block_size);
> You found a IMAGE_VERSION_TABLE, but it's smaller than expected. That
> sounds like an ath10k_err() to me.
>
>> +		return;
>> +	}
>> +
>> +	if (strlen(fw_build_id) > MAX_BUILD_ID_LEN) {
> Is this really a concern, if the string is too long strscpy() below will
> truncate it.
>
>> +		ath10k_dbg(ar, ATH10K_DBG_QMI, "fw_build_id length more than max length\n");
>> +		return;
>> +	}
>> +
>> +	strscpy(smem_table_ptr + smem_img_idx_wlan, fw_build_id, MAX_BUILD_ID_LEN);
> MAX_BUILD_ID_LEN is the length of fw_build_id, which is 128.
>
> But the memory you're writing to is defined as:
>
> struct smem_image_version {
> 	char name[SMEM_IMAGE_VERSION_NAME_SIZE];
> 	char variant[SMEM_IMAGE_VERSION_VARIANT_SIZE];
> 	char pad;
> 	char oem[SMEM_IMAGE_VERSION_OEM_SIZE];
> };
>
> With SMEM_IMAGE_VERSION_NAME_SIZE being 75.
>
>> +}
>> +
>>   static int ath10k_qmi_cap_send_sync_msg(struct ath10k_qmi *qmi)
>>   {
>>   	struct wlfw_cap_resp_msg_v01 *resp;
>> @@ -606,6 +638,8 @@ static int ath10k_qmi_cap_send_sync_msg(struct ath10k_qmi *qmi)
>>   			    qmi->fw_version, qmi->fw_build_timestamp, qmi->fw_build_id);
>>   	}
>>   
>> +	ath10k_qmi_add_wlan_ver_smem(ar, qmi->fw_build_id);
> qmi->fw_build_id is only valid if resp->fw_build_id_valid is set...
>
> Regards,
> Bjorn
>
>> +
>>   	kfree(resp);
>>   	return 0;
>>   
>> -- 
>> 2.38.0


Thank you Andersson. I will address all your comments in my next version 
of patch.

