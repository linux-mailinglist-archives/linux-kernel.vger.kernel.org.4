Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE20F5BCE7B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiISOWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiISOV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:21:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AAD326DA;
        Mon, 19 Sep 2022 07:21:47 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JDcfNR020931;
        Mon, 19 Sep 2022 14:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=xZ5OWClDGB58iBbXLFI8ZdqVbFd0FSAV7uGYMKu/0Fs=;
 b=U0WuXGDLGaQ8dHBnPNd+2BpjlUAddovRsY6jeqThgBas+kgAFhZxMoG/NGTtrxRVhd6c
 nOfxNAs1NwzArjm311sEjZalcnR2Qqg1ikVD0la8+Ex2RbukMx+ZPYCWa16ml2jSy0r8
 MDCofgB9oHoS6M/NxR9cgZ5dpypNoMEq7wpXwMQMdEaj8zDDeH1gRY4zUvmvCbFNJ7sJ
 FwJOkAAJiZH/tdP76cpPC40wxrOs5qoAITojma0j5Th53xa21cFgfsy8ZEfZLb+Z6Zhz
 re2YJ7aLn3iNP8dly6rUEuF0mJMEQWNIq+OE8v9WYhUzu5vcRtEsWx300OrjrMkO3Cj2 1A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jn6bumf5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 14:21:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28JEL59l011434
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 14:21:05 GMT
Received: from [10.216.41.172] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 19 Sep
 2022 07:20:59 -0700
Message-ID: <64d65ee2-1aa4-7e9f-db0c-b4d592574916@quicinc.com>
Date:   Mon, 19 Sep 2022 19:50:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v6 8/8] remoteproc: qcom: Update QDSP6 out-of-reset
 timeout value
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>,
        <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>
References: <1662643422-14909-1-git-send-email-quic_srivasam@quicinc.com>
 <1662643422-14909-9-git-send-email-quic_srivasam@quicinc.com>
 <5dbdf924-784d-9cf1-84d5-a03f18f98768@quicinc.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <5dbdf924-784d-9cf1-84d5-a03f18f98768@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: O6g6NjYzc3fp7l4mHw9xiRuZVYCpZMKc
X-Proofpoint-GUID: O6g6NjYzc3fp7l4mHw9xiRuZVYCpZMKc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 mlxlogscore=999 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190096
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/14/2022 3:15 PM, Sibi Sankar wrote:
Thanks for Your time Sibi Sankar!!!
>
> On 9/8/22 6:53 PM, Srinivasa Rao Mandadapu wrote:
>> Update QDSP6 out-of-reset timeout value to 1 second, as sometimes
>> ADSP boot failing on SC7280 based platforms with existing value.
>> Also add few micro seconds sleep after enabling boot core
>> start register.
>
> Please do check if the timeout that you hit is due to lack of
> required clock/bus scaling. If so increasing the timeout would
> be just an interim hack and might stop working in the future.
Okay. Will check and update it as per new findings.
>
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>> ---
>>   drivers/remoteproc/qcom_q6v5_adsp.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c 
>> b/drivers/remoteproc/qcom_q6v5_adsp.c
>> index e55d593..4414e23 100644
>> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
>> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
>> @@ -34,7 +34,7 @@
>>   /* time out value */
>>   #define ACK_TIMEOUT            1000
>>   #define ACK_TIMEOUT_US            1000000
>> -#define BOOT_FSM_TIMEOUT        10000
>> +#define BOOT_FSM_TIMEOUT        1000000
>>   /* mask values */
>>   #define EVB_MASK            GENMASK(27, 4)
>>   /*QDSP6SS register offsets*/
>> @@ -422,13 +422,14 @@ static int adsp_start(struct rproc *rproc)
>>         /* De-assert QDSP6 stop core. QDSP6 will execute after out of 
>> reset */
>>       writel(LPASS_BOOT_CORE_START, adsp->qdsp6ss_base + 
>> CORE_START_REG);
>> +    usleep_range(100, 110);
>>         /* Trigger boot FSM to start QDSP6 */
>>       writel(LPASS_BOOT_CMD_START, adsp->qdsp6ss_base + BOOT_CMD_REG);
>>         /* Wait for core to come out of reset */
>>       ret = readl_poll_timeout(adsp->qdsp6ss_base + BOOT_STATUS_REG,
>> -            val, (val & BIT(0)) != 0, 10, BOOT_FSM_TIMEOUT);
>> +            val, (val & BIT(0)) != 0, 100, BOOT_FSM_TIMEOUT);
>>       if (ret) {
>>           dev_err(adsp->dev, "failed to bootup adsp\n");
>>           goto disable_adsp_clks;
>>
