Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC8A6131FF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 09:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiJaIzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 04:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiJaIzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 04:55:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE4165EA;
        Mon, 31 Oct 2022 01:55:13 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 29V8fUT5022303;
        Mon, 31 Oct 2022 08:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2xOEgN8I2ys1RzJQHHjkg8jjAObptFGMUZWOGEDm02A=;
 b=Pkrq+Eq7mSoCx3SlVMyhTmb+8VlX7lUuKT2FyVWHJTZ08uAwJQk8ckcvqzIpTa9CTLUr
 hAkGKA8s0HHxld3UEz4z2fO36F2CqszuCuOc7TBIOj+kftDv/DG61wfmnzzSkbu3UkK4
 DR48qaYnZLfTT/rMJa7DzU7ynPUV84rAbCKaSlZk0kRGbE3RhVOepCOLGZJVIH6nkYJI
 3rthmEvyRLCoj2LLsoMqib2oOTMf35dQNRokgsybVx/0mzBVRoKILwvoHmX+CTgFRf17
 StHhLvujo1B6ZZSL9iTZ72WGdYlbZGUxzRBoLgrS/MtGuNBfe+do4sYcKscgNqEMjgvj Jw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kj7msrfev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Oct 2022 08:55:01 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29V8t0rL006660
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Oct 2022 08:55:00 GMT
Received: from [10.253.15.131] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 31 Oct
 2022 01:54:57 -0700
Message-ID: <7dc5b87a-1413-f7cb-4fdc-93828252c4f1@quicinc.com>
Date:   Mon, 31 Oct 2022 16:54:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] bus: mhi: host: Add session ID to MHI controller
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     <quic_hemantk@quicinc.com>, <loic.poulain@linaro.org>,
        <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <mrana@quicinc.com>
References: <1665376870-60668-1-git-send-email-quic_qianyu@quicinc.com>
 <20221028172022.GC13880@thinkpad>
From:   Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <20221028172022.GC13880@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: z7WyHsPObml9g3lJeo6Hmw9O55Sh9jZU
X-Proofpoint-ORIG-GUID: z7WyHsPObml9g3lJeo6Hmw9O55Sh9jZU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_06,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210310056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/29/2022 1:20 AM, Manivannan Sadhasivam wrote:
> On Mon, Oct 10, 2022 at 12:41:10PM +0800, Qiang Yu wrote:
>> Session ID to be used during BHI transfers to recognize a
>> particular session are currently not being stored in the MHI
>> controller structure. Store them to allow for tracking and other
>> future usage.
>>
>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> Who/what is going to use this session id?
Sometimes, we may find some error logs and want to see what happens on 
device when host is printing these error logs.
Session id can help us find the logs we want.
>
> Thanks,
> Mani
>
>> ---
>>   drivers/bus/mhi/host/boot.c | 8 ++++----
>>   include/linux/mhi.h         | 1 +
>>   2 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
>> index 26d0edd..5bed8b51 100644
>> --- a/drivers/bus/mhi/host/boot.c
>> +++ b/drivers/bus/mhi/host/boot.c
>> @@ -231,7 +231,7 @@ static int mhi_fw_load_bhi(struct mhi_controller *mhi_cntrl,
>>   			   dma_addr_t dma_addr,
>>   			   size_t size)
>>   {
>> -	u32 tx_status, val, session_id;
>> +	u32 tx_status, val;
>>   	int i, ret;
>>   	void __iomem *base = mhi_cntrl->bhi;
>>   	rwlock_t *pm_lock = &mhi_cntrl->pm_lock;
>> @@ -253,16 +253,16 @@ static int mhi_fw_load_bhi(struct mhi_controller *mhi_cntrl,
>>   		goto invalid_pm_state;
>>   	}
>>   
>> -	session_id = MHI_RANDOM_U32_NONZERO(BHI_TXDB_SEQNUM_BMSK);
>> +	mhi_cntrl->session_id = MHI_RANDOM_U32_NONZERO(BHI_TXDB_SEQNUM_BMSK);
>>   	dev_dbg(dev, "Starting image download via BHI. Session ID: %u\n",
>> -		session_id);
>> +		mhi_cntrl->session_id);
>>   	mhi_write_reg(mhi_cntrl, base, BHI_STATUS, 0);
>>   	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_HIGH,
>>   		      upper_32_bits(dma_addr));
>>   	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_LOW,
>>   		      lower_32_bits(dma_addr));
>>   	mhi_write_reg(mhi_cntrl, base, BHI_IMGSIZE, size);
>> -	mhi_write_reg(mhi_cntrl, base, BHI_IMGTXDB, session_id);
>> +	mhi_write_reg(mhi_cntrl, base, BHI_IMGTXDB, mhi_cntrl->session_id);
>>   	read_unlock_bh(pm_lock);
>>   
>>   	/* Wait for the image download to complete */
>> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
>> index a5441ad..8b3c934 100644
>> --- a/include/linux/mhi.h
>> +++ b/include/linux/mhi.h
>> @@ -405,6 +405,7 @@ struct mhi_controller {
>>   	u32 minor_version;
>>   	u32 serial_number;
>>   	u32 oem_pk_hash[MHI_MAX_OEM_PK_HASH_SEGMENTS];
>> +	u32 session_id;
>>   
>>   	struct mhi_event *mhi_event;
>>   	struct mhi_cmd *mhi_cmd;
>> -- 
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
>>
