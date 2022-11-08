Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED2B620A26
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 08:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbiKHH0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 02:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiKHH0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 02:26:12 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D11063AF;
        Mon,  7 Nov 2022 23:26:11 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A876mvc002834;
        Tue, 8 Nov 2022 07:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OBgBkaL8Vj57NvULPs68OhWsCOi7W7XtYnTPU95lJOg=;
 b=cesU4SlWAHfWlh6aikDUMh/wViSpRWEh8eylNaaXpFHpldBZ7/qltXgyKBCC8D3mrLYj
 UvHFfWxctVwPtsDI2hzhSSz2fz6hxHA2JnxfFkxk0iJkcAO9dcSePTKg77Qs+KGJ4QFR
 okfMm8/+06hcMF6AcxWCwERMv2z0EEp9o8rdoB3wSMq0EOgfdNla4Hl3apWeBwsIf5WK
 8uHbjWcaejxnp+C6wM9GT/bSIrJ9vU4ePp+qcafwlCCQeAiEleq0s3hfoNO/hxKRxgj4
 s4nwLLEk3FF1TA9g/p5gswmM6zQ5sOXWDqQ/fcjSJKXxvmg1T/0i0v67vEpgAi3FWbb5 qw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kqht88450-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 07:26:04 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A87Q3Mg025480
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Nov 2022 07:26:03 GMT
Received: from [10.253.38.162] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 7 Nov 2022
 23:26:01 -0800
Message-ID: <e85961ce-c807-7a42-2748-9628f469c793@quicinc.com>
Date:   Tue, 8 Nov 2022 15:25:58 +0800
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
 <7dc5b87a-1413-f7cb-4fdc-93828252c4f1@quicinc.com>
 <20221101114554.GD54667@thinkpad> <20221103125531.GI8434@thinkpad>
From:   Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <20221103125531.GI8434@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1G6tUTKKv_mjPHw8QPE0B89QskQHA_Fd
X-Proofpoint-GUID: 1G6tUTKKv_mjPHw8QPE0B89QskQHA_Fd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 clxscore=1015 bulkscore=0 phishscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211080039
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/3/2022 8:55 PM, Manivannan Sadhasivam wrote:
> On Tue, Nov 01, 2022 at 05:15:54PM +0530, Manivannan Sadhasivam wrote:
>> On Mon, Oct 31, 2022 at 04:54:55PM +0800, Qiang Yu wrote:
>>> On 10/29/2022 1:20 AM, Manivannan Sadhasivam wrote:
>>>> On Mon, Oct 10, 2022 at 12:41:10PM +0800, Qiang Yu wrote:
>>>>> Session ID to be used during BHI transfers to recognize a
>>>>> particular session are currently not being stored in the MHI
>>>>> controller structure. Store them to allow for tracking and other
>>>>> future usage.
>>>>>
>>>>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>>>> Who/what is going to use this session id?
>>> Sometimes, we may find some error logs and want to see what happens on
>>> device when host is printing these error logs.
>>> Session id can help us find the logs we want.
>> Okay. Please add this info to the commit message.
>>
> Wait. I asked who is going to use session_id cached in the MHI controller
> structure? session_id is already printed in debug log.
When we repro issue, we often write a ramdom session id before host set 
M0, so that the session id can help us find key logs.
To avoid loss of logs containing seesion id, we need to print session id 
in different place. In some cases, we even print session
id every time when host prints logs as prefix.
>
>> Thanks,
>> Mani
>>
>>>> Thanks,
>>>> Mani
>>>>
>>>>> ---
>>>>>    drivers/bus/mhi/host/boot.c | 8 ++++----
>>>>>    include/linux/mhi.h         | 1 +
>>>>>    2 files changed, 5 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
>>>>> index 26d0edd..5bed8b51 100644
>>>>> --- a/drivers/bus/mhi/host/boot.c
>>>>> +++ b/drivers/bus/mhi/host/boot.c
>>>>> @@ -231,7 +231,7 @@ static int mhi_fw_load_bhi(struct mhi_controller *mhi_cntrl,
>>>>>    			   dma_addr_t dma_addr,
>>>>>    			   size_t size)
>>>>>    {
>>>>> -	u32 tx_status, val, session_id;
>>>>> +	u32 tx_status, val;
>>>>>    	int i, ret;
>>>>>    	void __iomem *base = mhi_cntrl->bhi;
>>>>>    	rwlock_t *pm_lock = &mhi_cntrl->pm_lock;
>>>>> @@ -253,16 +253,16 @@ static int mhi_fw_load_bhi(struct mhi_controller *mhi_cntrl,
>>>>>    		goto invalid_pm_state;
>>>>>    	}
>>>>> -	session_id = MHI_RANDOM_U32_NONZERO(BHI_TXDB_SEQNUM_BMSK);
>>>>> +	mhi_cntrl->session_id = MHI_RANDOM_U32_NONZERO(BHI_TXDB_SEQNUM_BMSK);
>>>>>    	dev_dbg(dev, "Starting image download via BHI. Session ID: %u\n",
>>>>> -		session_id);
>>>>> +		mhi_cntrl->session_id);
>>>>>    	mhi_write_reg(mhi_cntrl, base, BHI_STATUS, 0);
>>>>>    	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_HIGH,
>>>>>    		      upper_32_bits(dma_addr));
>>>>>    	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_LOW,
>>>>>    		      lower_32_bits(dma_addr));
>>>>>    	mhi_write_reg(mhi_cntrl, base, BHI_IMGSIZE, size);
>>>>> -	mhi_write_reg(mhi_cntrl, base, BHI_IMGTXDB, session_id);
>>>>> +	mhi_write_reg(mhi_cntrl, base, BHI_IMGTXDB, mhi_cntrl->session_id);
>>>>>    	read_unlock_bh(pm_lock);
>>>>>    	/* Wait for the image download to complete */
>>>>> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
>>>>> index a5441ad..8b3c934 100644
>>>>> --- a/include/linux/mhi.h
>>>>> +++ b/include/linux/mhi.h
>>>>> @@ -405,6 +405,7 @@ struct mhi_controller {
>>>>>    	u32 minor_version;
>>>>>    	u32 serial_number;
>>>>>    	u32 oem_pk_hash[MHI_MAX_OEM_PK_HASH_SEGMENTS];
>>>>> +	u32 session_id;
>>>>>    	struct mhi_event *mhi_event;
>>>>>    	struct mhi_cmd *mhi_cmd;
>>>>> -- 
>>>>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>>>>> a Linux Foundation Collaborative Project
>>>>>
>>>>>
>> -- 
>> மணிவண்ணன் சதாசிவம்
>>
