Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DA1713932
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 13:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjE1Lag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 07:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1Lad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 07:30:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503529C;
        Sun, 28 May 2023 04:30:30 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34SBOPBM024011;
        Sun, 28 May 2023 11:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jdM3HzsaV7JScZljybz8uxp47jRGdtnCoIrsyHQwbM0=;
 b=TfgCiPvzSdIi5Z+uc+xbTLjYSTFXb0mqTWsn8RDS1y2kg+aTf/yUlsc7uWN+NXhEQN2/
 ZIoJMO4ZM5o5bXVclCuCS+Ol5gSSw5F6FR5uV+sdAEYdsUTkBGWDub/wABhtav0vpkN7
 J5ZJIPEEN/aQX/Ss1fLosnNBGWmFhPKpHg7scxR9Mno7UEC6fDo2SCRb1BeSEhE/Xf0C
 GGCq1XooUTazixCwlp06+qQvYtu4ZriNib5inZgfr1QXOrtk85MSPJQtfCjsW+jBJ9wT
 LHQRm5asVC874Qc4C3gGMPsDRxUO/23zcM4/FxO1iaztTqnNilDmtHOUH9j8g71zRZZd fg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3quanx9kdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 May 2023 11:30:01 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34SBU0et003198
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 May 2023 11:30:00 GMT
Received: from [10.216.57.186] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 28 May
 2023 04:29:53 -0700
Message-ID: <c2496855-113a-56e6-f6e2-9a9bd03a1267@quicinc.com>
Date:   Sun, 28 May 2023 16:59:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 04/18] soc: qcom: Add Qualcomm minidump kernel driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <corbet@lwn.net>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
 <1683133352-10046-5-git-send-email-quic_mojha@quicinc.com>
 <c6f730b6-f702-91d4-4abd-71546e02f869@linaro.org>
 <23b493f4-1a01-8d03-fc12-d588b2c6fd74@quicinc.com>
 <575a422d-6224-06b7-628c-8487b47882e9@linaro.org>
 <500e5abc-fb71-8468-a6b0-3ced2676b57c@linaro.org>
 <e714566e-39b7-d46b-13bd-3c0e20e9f944@quicinc.com>
 <7777c016-4875-a6c9-cd5e-78c2ac686448@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <7777c016-4875-a6c9-cd5e-78c2ac686448@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Wq_YQJJaMTn_p0i8IQNdSFF-sgN61CTi
X-Proofpoint-GUID: Wq_YQJJaMTn_p0i8IQNdSFF-sgN61CTi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-28_08,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 mlxscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305280099
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 5/9/2023 12:41 PM, Krzysztof Kozlowski wrote:
> On 08/05/2023 09:10, Mukesh Ojha wrote:
>>
>>
>> On 5/4/2023 10:04 PM, Krzysztof Kozlowski wrote:
>>> On 04/05/2023 17:21, Krzysztof Kozlowski wrote:
>>>>>>
>>>>>>> +	ret = qcom_minidump_init_apss_subsystem(md);
>>>>>>> +	if (ret) {
>>>>>>> +		dev_err(&pdev->dev, "apss minidump initialization failed: %d\n", ret);
>>>>>>> +		goto unlock;
>>>>>>> +	}
>>>>>>> +
>>>>>>> +	__md = md;
>>>>>>
>>>>>> No. This is a platform device, so it can have multiple instances.
>>>>>
>>>>> It can have only one instance that is created from SMEM driver probe.
>>>>
>>>> Anyone can instantiate more of them.... how did you solve it?
>>>
>>> To clarify - sprinkling more of singletons makes everything tightly
>>> coupled, difficult to debug and non-portable. You cannot have two
>>> instances, you have to control concurrent initialization by yourself in
>>> each of such singletons.
>>>
>>> I understand sometimes they are unavoidable, for example when this does
>>> not map to hardware property. However here you have the parent - smem -
>>> which can return you valid instance. Thus you avoid entire problem of
>>> file-scope variables.
>>
>> I get your point, why one's should avoid file scope variables.
>>
>>
>> This is infrastructure driver and will not have multiple instances and
>> even if it happens could be avoided with with the help of global mutex
>> and protect below function which i am already doing at the moment and
> 
> But we do not want global mutexes... so incorrect design is being
> improved by more incorrect design.
> 
>> fail the other probe if it is already initialized with proper logging..e.g
>>
>> "already initialized..."
>>
>>
>> ret = qcom_minidump_init_apss_subsystem(md);
>>
>>
>> And this will be in-lined with
>>
>> /* Pointer to the one and only smem handle */
>> static struct qcom_smem *__smem;
>>
>> Let me know if you still disagree...and have some other way ?
> 
> Why the parent - smem - cannot return every consumer the instance it
> has? There will be one smem having only one minidump, so all problems
> solved?

Sorry, I am extending this discussion but it is needed to avoid rework
in upcoming patches.

I am inline with the thought of each smem has its own minidump instance, 
which is basically one at this moment as SMEM has only instance in DT.
In that way, Client driver calling qcom_apss_minidump_region_register()
will also need to know the instance it need to register with right?

However, I do have a use case [1] where SMEM or similar region 
supporting memory mapped region could be virtualized and guest vm does
not have direct access to it, that way it will only have one backend at 
a time.But even if they exist together that can be done with below approach.

File scope variable is still needed in minidump core but can be avoided 
in backend drivers where each backend register with core and get added 
itself in the list and for list protection, list mutex would be needed.


#define SMEM       0;
#define MMIO       1;
or enum may be..

And client can call this to the instance it need to register with..
int qcom_apss_minidump_region_register(region, SMEM);
int qcom_apss_minidump_region_register(region, MMIO);

Do you agree with this approach?

[1]

            +----------------+
            |                |
            | client A-Z     |
            +-----+----------+
                  |
                  |
                  |
                  |
                  v
       +------------------------+
       |                        |                other backends
       |    minidump core       +----------------------------+
       |                        |                            |
       +--+---------------------+                            |
          |                     |                            |
          |                     |                            |
          |                     |                            |e.g,
          |                     |                            |gunyah-rm
+--------v------+        +-----v-----------+             +--+---------+
|               |        |                 |             |            |
|minidump_smem  |        | minidump_mmio   |             | .....      |
+---------------+        +-----------------+             +------------+
  SMEM backend              mmio backend where
                            smem may be virtualized


-- Mukesh
> 
> Best regards,
> Krzysztof
> 
