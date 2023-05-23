Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5858F70D615
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbjEWHyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbjEWHyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:54:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388BFC5;
        Tue, 23 May 2023 00:54:04 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N5mBK6016579;
        Tue, 23 May 2023 07:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=lMTsWnIdpB+KcIi0KcEG0a0vP17nRieN0vuG7xoW+8c=;
 b=Sha68fJamuXwHbZxcDIPqg7xF74W/JzmlWJPP72dHDfN7lkvtsSIoHjK8HlREFG0yOAH
 1WGeBMO0ftWj/9gimS5msvQVBe+tyOUuxZzPynacODV94+yhajPPJyyXyKDd4ftVtkpK
 GzGTsCORSuOiOLpSS/SxvJWJgDzDhQEL4DXRZ4VIvGmaChr8/4hlswbl3sHe3OuLlKZM
 Bu9vne2Gh/Oz74chTHd1uNUxkzzLJ8gUGRVeGcFE19SLlgJO6acvPc+iAlQLzqhX1P4V
 wzKa1GbcOZxG+zss+cyHZqjY4naTJG4NgVl/2XYV2n6IGEumMEYy6ZA9qHeiT8V+OhZt ow== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qraasst87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 07:53:22 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34N7rLtM016883
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 07:53:21 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 23 May
 2023 00:53:18 -0700
Message-ID: <bdef28ed-20f5-3996-55a5-0e955d4c6317@quicinc.com>
Date:   Tue, 23 May 2023 13:23:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] Revert "firmware: qcom_scm: Clear download bit during
 reboot"
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>,
        Robert Marko <robimarko@gmail.com>
CC:     <agross@kernel.org>, <konrad.dybcio@linaro.org>,
        <p.zabel@pengutronix.de>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1684408823-5898-1-git-send-email-quic_mojha@quicinc.com>
 <20230520021201.t2zeermogm4s5fgq@ripper>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230520021201.t2zeermogm4s5fgq@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: THWoRExtuJUhawgntRkudD-WzIKCHRhF
X-Proofpoint-ORIG-GUID: THWoRExtuJUhawgntRkudD-WzIKCHRhF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_04,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230064
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Robert

On 5/20/2023 7:42 AM, Bjorn Andersson wrote:
> On Thu, May 18, 2023 at 04:50:23PM +0530, Mukesh Ojha wrote:
>> This reverts commit 781d32d1c970 as it causes regression(reboot
>> does not work) for target like IPQ4019 that does not support
>> download mode scm calls end to end.
>>
> 
> What do you mean with "reboot does not work"?
> 
> Does qcom_scm_set_download_mode() crash the board? Does the reboot
> always end up in download mode? Or some other form of "not work"?

As per the discussion here, it seems qcom_scm_set_download_mode()
does not work on some legacy target like IPQ4019..may be because
firmware does not have the support..

https://lore.kernel.org/lkml/76943268-3982-deaf-9736-429dd51e01b0@gmail.com/

-- Mukesh

> 
> Regards,
> Bjorn
> 
>> Fixes: 781d32d1c970 ("firmware: qcom_scm: Clear download bit during reboot")
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>>   drivers/firmware/qcom_scm.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>> index fde33acd46b7..a4bb9265d9c0 100644
>> --- a/drivers/firmware/qcom_scm.c
>> +++ b/drivers/firmware/qcom_scm.c
>> @@ -1508,7 +1508,8 @@ static int qcom_scm_probe(struct platform_device *pdev)
>>   static void qcom_scm_shutdown(struct platform_device *pdev)
>>   {
>>   	/* Clean shutdown, disable download mode to allow normal restart */
>> -	qcom_scm_set_download_mode(false);
>> +	if (download_mode)
>> +		qcom_scm_set_download_mode(false);
>>   }
>>   
>>   static const struct of_device_id qcom_scm_dt_match[] = {
>> -- 
>> 2.7.4
>>
