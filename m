Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A0370D96C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjEWJqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjEWJq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:46:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2564B94;
        Tue, 23 May 2023 02:46:26 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N9e2Jf018498;
        Tue, 23 May 2023 09:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=owNN41mPBR4N6l5tMzylyQVvAepv02meg5SqhJakPBg=;
 b=exjbTfH+ETzR2x2fc7QmvqgWFotckieBXfIIFZhWM8w9jQl0uMbY2AxFnuEKWuTqGAsI
 bkABHwL+BIRatKuRkT8HQ5uGOtNMOMb+ffWroK8D1XI62sRjIsWx6MMDkE0s9EpX9rPP
 Pir8MjRmf+zWxgIA0VM3x89PWJUCeiZTL0oAu/OygdTWUi3/JcUfJPJBUWK2N5T/cOT+
 ogtf612/wGUWMg1gsp/3IlOcMKuu5VwH4Qdn8pPV0RnMaq5PcaEzv4r9M0vbaGJ124pq
 lr8ThJWJatc/GVyP/eXPd2U2EdqtnQNZKEyHqrIF4Eyh2cp7ztj7nWkvXJy+UAspibgd YA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qre8p1hht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 09:46:22 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34N9kLfV024196
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 09:46:21 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 23 May
 2023 02:46:18 -0700
Message-ID: <3fc567f6-613c-1e03-c679-2c550a5eaac6@quicinc.com>
Date:   Tue, 23 May 2023 15:16:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] firmware: qcom_scm: use the SCM_CONVENTION based on ARM /
 ARM64
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Kathiravan T <quic_kathirav@quicinc.com>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_eberman@quicinc.com>
References: <20230522044512.4787-1-quic_kathirav@quicinc.com>
 <CAH=2NtydsLsTRhWEqocg4AQPzk5QURHeKNe7N-DhhV2-qnic6Q@mail.gmail.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <CAH=2NtydsLsTRhWEqocg4AQPzk5QURHeKNe7N-DhhV2-qnic6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Oj-fhDeVTA6RYdLIrQG0zMtYoyechcFz
X-Proofpoint-GUID: Oj-fhDeVTA6RYdLIrQG0zMtYoyechcFz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_06,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230080
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/2023 12:03 PM, Bhupesh Sharma wrote:
> Hi,
> 
> On Mon, 22 May 2023 at 10:15, Kathiravan T <quic_kathirav@quicinc.com> wrote:
>>
>> During SCM probe, to identify the SCM convention, scm call is made with
>> SMC_CONVENTION_ARM_64 followed by SMC_CONVENTION_ARM_32. Based on the
>> result what convention to be used is decided.
>>
>> IPQ chipsets starting from IPQ807x, supports both 32bit and 64bit kernel
>> variants, however TZ firmware runs in 64bit mode. When running on 32bit
>> kernel, scm call is made with SMC_CONVENTION_ARM_64 is causing the
>> system crash, due to the difference in the register sets between ARM and
>> AARCH64, which is accessed by the TZ.
> 
> If a crash is being fixed, should we use a Fixes tag as well?
> 
>> To avoid this, use SMC_CONVENTION_ARM_64 only on ARM64 builds.
>>
>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>> ---
>>   drivers/firmware/qcom_scm.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>> index fde33acd46b7..db6754db48a0 100644
>> --- a/drivers/firmware/qcom_scm.c
>> +++ b/drivers/firmware/qcom_scm.c
>> @@ -171,6 +171,7 @@ static enum qcom_scm_convention __get_convention(void)
>>          if (likely(qcom_scm_convention != SMC_CONVENTION_UNKNOWN))
>>                  return qcom_scm_convention;
>>
>> +#if IS_ENABLED(CONFIG_ARM64)
>>          /*
>>           * Device isn't required as there is only one argument - no device
>>           * needed to dma_map_single to secure world
>> @@ -191,6 +192,7 @@ static enum qcom_scm_convention __get_convention(void)
>>                  forced = true;
>>                  goto found;
>>          }
>> +#endif
> 
> If we are already inside a 'CONFIG_ARM64' define here ^^^, do we even
> need the following snippet now:
> 
> /*
>       * Some SC7180 firmwares didn't implement the
>       * QCOM_SCM_INFO_IS_CALL_AVAIL call, so we fallback to forcing ARM_64
>       * calling conventions on these firmwares. Luckily we don't make any
>       * early calls into the firmware on these SoCs so the device pointer
>       * will be valid here to check if the compatible matches.
>       */
>      if (of_device_is_compatible(__scm ? __scm->dev->of_node : NULL,
> "qcom,scm-sc7180")) {
>          forced = true;
>          goto found;
>      }
> 
> 'forced' will always be 'true' now that we are inside the CONFIG_ARM64
> check above, right?

Well, i think you can't get rid off the variable here as main purpose
of the variable seems to be print the mode is being forced here
(kind of workaround for a firmware) here and not natural.

is not that ?

-- Mukesh

> So, maybe you can clean-up that path as well.
> 
> Thanks,
> Bhupesh
