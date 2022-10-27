Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F186100A2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 20:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236212AbiJ0SuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 14:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235851AbiJ0Stm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 14:49:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9E0DF30;
        Thu, 27 Oct 2022 11:49:37 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RIeTfB031496;
        Thu, 27 Oct 2022 18:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qU80G5IuJewnRXuhuLqjRrKAm2ZbJgQy4RLbVLj79cM=;
 b=JjAajOYr3YCxIC1ZpS2F2U3M/ozuYTNj5LYOGcLRztIeKeZSbfQnM6/9bpxRpO5lqX52
 VrOh70tbMefnTm0PInmJLCtYnrXpzpLP4IzN7qlULXpP9tyt8PbOyINFrJzI3/oLbkzh
 by6FFA6XcQPFXgU52LRCPdCNAMgn4DUfvo7uQHUVdS11c+AYlN0Mpfe/KXNhNc0ppNKd
 EbONDpWzb3nZ4F5wrxIl5UZaXXMHCHuRGCYhsBmHUJF9TTfX5e6Jk+twh4mEenyz0psm
 S5BJjL32527vcbLodVV7NR7l00rAXsctW0dApZHznNuC0xEYUXb5826o56FiyzUiAPdY pA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kfyf7g0jj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 18:49:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29RInVx2027745
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 18:49:31 GMT
Received: from [10.110.107.43] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 27 Oct
 2022 11:49:30 -0700
Message-ID: <b55ef95f-f400-9ef6-a427-525ae529d673@quicinc.com>
Date:   Thu, 27 Oct 2022 11:49:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] wifi: ath10k: Add WLAN firmware image version info into
 smem
Content-Language: en-US
To:     Youghandhar Chintala <quic_youghand@quicinc.com>,
        <ath10k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221026102257.19919-1-quic_youghand@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20221026102257.19919-1-quic_youghand@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hGvc-8cdkhodk9piGoKBBcbHnO_obbVa
X-Proofpoint-GUID: hGvc-8cdkhodk9piGoKBBcbHnO_obbVa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210270106
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/2022 3:22 AM, Youghandhar Chintala wrote:
> In a SoC based solution, it would be useful to know the versions of the
> various binary firmware blobs the system is running on. On a QCOM based
> SoC, this info can be obtained from socinfo debugfs infrastructure. For
> this to work, respective subsystem drivers have to export the firmware
> version information to an SMEM based version information table.
> 
> Having firmware version information at one place will help quickly
> figure out the firmware versions of various subsystems on the device
> instead of going through builds/logs in an event of a system crash.
> 
> Fill WLAN firmware version information in SMEM version table to be
> printed as part of socinfo debugfs infrastructure on a Qualcomm based
> SoC.
> 
> This change is applicable only for WCN399X targets.
> 
> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1
> 
> Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath10k/qmi.c | 28 +++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
> index 66cb7a1e628a..e88bcfd96859 100644
> --- a/drivers/net/wireless/ath/ath10k/qmi.c
> +++ b/drivers/net/wireless/ath/ath10k/qmi.c
> @@ -14,6 +14,7 @@
>   #include <linux/net.h>
>   #include <linux/platform_device.h>
>   #include <linux/qcom_scm.h>
> +#include <linux/soc/qcom/smem.h>
>   #include <linux/string.h>
>   #include <net/sock.h>
>   
> @@ -22,6 +23,8 @@
>   
>   #define ATH10K_QMI_CLIENT_ID		0x4b4e454c
>   #define ATH10K_QMI_TIMEOUT		30
> +#define ATH10K_SMEM_IMAGE_VERSION_TABLE       469
> +#define ATH10K_SMEM_IMAGE_TABLE_CNSS_INDEX     13
>   
>   static int ath10k_qmi_map_msa_permission(struct ath10k_qmi *qmi,
>   					 struct ath10k_msa_mem_info *mem_info)
> @@ -536,6 +539,29 @@ int ath10k_qmi_wlan_disable(struct ath10k *ar)
>   	return ath10k_qmi_mode_send_sync_msg(ar, QMI_WLFW_OFF_V01);
>   }
>   
> +static void ath10k_qmi_add_wlan_ver_smem(struct ath10k *ar, char *fw_build_id)

const char *fw_build_id?

> +{
> +	u8 *smem_table_ptr;
> +	size_t smem_block_size;
> +	const u32 version_string_size = 128;

should you s/128/MAX_BUILD_ID_LEN/ since that is what is used to size 
qmi->fw_build_id?

or alternately have the caller pass fw_build_id length as a separate param?


> +	const u32 smem_img_idx_wlan = ATH10K_SMEM_IMAGE_TABLE_CNSS_INDEX * 128;
> +
> +	smem_table_ptr = qcom_smem_get(QCOM_SMEM_HOST_ANY,
> +				       ATH10K_SMEM_IMAGE_VERSION_TABLE,
> +				       &smem_block_size);
> +	if (IS_ERR(smem_table_ptr)) {
> +		ath10k_dbg(ar, ATH10K_DBG_QMI, "smem image version table not found");
> +		return;
> +	}
> +	if (smem_img_idx_wlan + version_string_size > smem_block_size) {
> +		ath10k_dbg(ar, ATH10K_DBG_QMI, "smem block size too small: %i",
> +			   smem_block_size);
> +		return;
> +	}
> +	memcpy(smem_table_ptr + smem_img_idx_wlan, fw_build_id,
> +	       version_string_size);
> +}
> +
>   static int ath10k_qmi_cap_send_sync_msg(struct ath10k_qmi *qmi)
>   {
>   	struct wlfw_cap_resp_msg_v01 *resp;
> @@ -606,6 +632,8 @@ static int ath10k_qmi_cap_send_sync_msg(struct ath10k_qmi *qmi)
>   			    qmi->fw_version, qmi->fw_build_timestamp, qmi->fw_build_id);
>   	}
>   
> +	ath10k_qmi_add_wlan_ver_smem(ar, qmi->fw_build_id);
> +
>   	kfree(resp);
>   	return 0;
>   

