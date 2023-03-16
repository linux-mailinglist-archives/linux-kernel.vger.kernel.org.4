Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A89E6BD2E7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjCPPEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjCPPEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:04:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3E1B8616;
        Thu, 16 Mar 2023 08:04:35 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32G9aqFL031031;
        Thu, 16 Mar 2023 15:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Cfq5v3MJyp5BZhrEVFVRr5DtUcZrsl067gMMHV/82Co=;
 b=XCE3Vv7sYqdf6BuVJ1XHjw1BcfvqFQCT6tdDCcVdDg1zXrSxiDbruuSO2dJf6WMC2sDA
 PT/+CW7D+1JRdeqLfewIRRjtzIe0PeBj9FUv7XcUgvVjA8fi/2Nx4HZuBPxWM+blxbV3
 4Tn5XgXjPpZOvcehp6uRxEi9NW+MDnZ4jrtU3V81EP4P2cILTZZ646coWcEATH7s+FAR
 pusIzmO92vbIednK5ExHNMW9v7mAijzHWnbDa2UmaRWLRRqMD+OGRbXccB40dEnaVk6c
 EL0XTfiMeG1wW0/79FkFChzg308Q2sAt+XMwjG1eUiDsUhFgYIS1BUc6RNsw2rzIrBgh ow== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pbst91upc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 15:04:32 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32GF4VA1027303
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 15:04:31 GMT
Received: from [10.216.13.67] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 16 Mar
 2023 08:04:29 -0700
Message-ID: <bf17d901-5f0d-4f01-4498-9d1f254373f5@quicinc.com>
Date:   Thu, 16 Mar 2023 20:34:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/4] firmware: scm: Modify only the DLOAD bit in TCSR
 register for download mode
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1677664555-30191-1-git-send-email-quic_mojha@quicinc.com>
 <1677664555-30191-3-git-send-email-quic_mojha@quicinc.com>
 <86391f5a-ccbc-133b-47d2-2d98e40d7ef7@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <86391f5a-ccbc-133b-47d2-2d98e40d7ef7@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: riow7IP8sUyW6Xy0vop5PQq142IFniPT
X-Proofpoint-GUID: riow7IP8sUyW6Xy0vop5PQq142IFniPT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_10,2023-03-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303160122
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/8/2023 8:36 PM, Srinivas Kandagatla wrote:
> 
> 
> On 01/03/2023 09:55, Mukesh Ojha wrote:
>> CrashDump collection is based on the DLOAD bit of TCSR register.
>> To retain other bits, we read the register and modify only the
>> DLOAD bit as the other bits have their own significance.
>>
>> Originally-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>> Changes in v2:
>>   - Addressed comment made by Bjorn.
>>   - Added download mask from patch 3 to this.
>>
>>   drivers/firmware/qcom_scm.c | 17 +++++++++++++++--
>>   1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>> index 51eb853..c9f1fad 100644
>> --- a/drivers/firmware/qcom_scm.c
>> +++ b/drivers/firmware/qcom_scm.c
>> @@ -27,6 +27,8 @@ module_param(download_mode, bool, 0);
>>   #define SCM_HAS_IFACE_CLK    BIT(1)
>>   #define SCM_HAS_BUS_CLK        BIT(2)
>> +#define QCOM_DOWNLOAD_MODE_MASK 0x30
>> +
>>   struct qcom_scm {
>>       struct device *dev;
>>       struct clk *core_clk;
>> @@ -419,6 +421,7 @@ static void qcom_scm_set_download_mode(bool enable)
>>   {
>>       bool avail;
>>       int ret = 0;
>> +    u32 val;
>>       avail = __qcom_scm_is_call_available(__scm->dev,
>>                            QCOM_SCM_SVC_BOOT,
>> @@ -426,8 +429,18 @@ static void qcom_scm_set_download_mode(bool enable)
>>       if (avail) {
>>           ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
>>       } else if (__scm->dload_mode_addr) {
>> -        ret = qcom_scm_io_writel(__scm->dload_mode_addr,
>> -                enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
>> +        ret = qcom_scm_io_readl(__scm->dload_mode_addr, &val);
>> +        if (ret) {
>> +            dev_err(__scm->dev,
>> +                "failed to read dload mode address value: %d\n", ret);
>> +            return;
>> +        }
>> +
>> +        val &= ~QCOM_DOWNLOAD_MODE_MASK;
>> +        if (enable)
>> +            val |= QCOM_SCM_BOOT_SET_DLOAD_MODE;
>> +
>> +        ret = qcom_scm_io_writel(__scm->dload_mode_addr, val);
> 
> 
> This is the second instance of such pattern of usage one is already in 
> ./drivers/pinctrl/qcom/pinctrl-msm.c
> 
> I think it makes sense to move setting fields in register to a dedicated 
> function like this:
> 
> int qcom_scm_io_update_field(phys_addr_t addr, unsigned int mask, 
> unsigned int val)
> {
>      unsigned int old, new;
>      int ret;
> 
>      ret = qcom_scm_io_readl(addr, &old);
>      if (ret)
>          return ret;
> 
>      new = (old & ~mask) | (val << ffs(mask) - 1);
> 
>      return qcom_scm_io_writel(addr, new);
> }
> EXPORT_SYMBOL(qcom_scm_io_update_field);
> 
> 
> then we could use it like this:
> ret = qcom_scm_io_update_field(__scm->dload_mode_addr, 
> QCOM_DOWNLOAD_MODE_MASK, dl_mode)

Thanks for the review,

will do it in v2, will let /drivers/pinctrl/qcom/pinctrl-msm.c uses this.

-Mukesh
> 
> 
> --srini
>>       } else {
>>           dev_err(__scm->dev,
>>               "No available mechanism for setting download mode\n");
