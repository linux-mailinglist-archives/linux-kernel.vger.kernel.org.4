Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DF8701B7C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 06:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjENERL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 00:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjENERH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 00:17:07 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E1D1702;
        Sat, 13 May 2023 21:17:06 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34E47Rfs008754;
        Sun, 14 May 2023 04:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=co4vRrnTivwIzFDIwnV3dMAsjHlQ/SjpLfqX2dsGaik=;
 b=k23QVqg5w4yinxoAw3dYRHeFAfYqVk2BHZuL5zYY0M97waJIKEWDT06DiieWgBqvNeZY
 FRNQOzA2k9E5t54eO7UkDZYK+iWF23574W2dF2VZrrJics6p9ZxH8XqoAX8yiOOzwY0y
 Q+5s0UhOvyne4hgbMdT9BiL6wBtOx/4b1uGz8iptAyUMnwnYAm3LYKM7FyM8++tNRnQN
 STWj4jAMymLRs8peHQ71irPwwpvY/GKG6uW4hTP7FxXfI4FqbT9lABiLp8LocbV5YNpC
 V2WGE/E/F7djmrtVewkuVL6EGbmZkpPaUmYa+BevAkNgmUBhGjRkvsixTUyyazTXUIMD Bw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qj257sc73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 May 2023 04:16:34 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34E4GXxC003508
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 May 2023 04:16:33 GMT
Received: from [10.110.80.184] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sat, 13 May
 2023 21:16:32 -0700
Message-ID: <a8229e70-dd23-8a48-cf9b-fadc9db7ecdc@quicinc.com>
Date:   Sat, 13 May 2023 21:16:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 04/18] soc: qcom: Add Qualcomm minidump kernel driver
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <e714566e-39b7-d46b-13bd-3c0e20e9f944@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0Zr-_av0jVj5LIrEzqJPzDiF31cnJxEQ
X-Proofpoint-GUID: 0Zr-_av0jVj5LIrEzqJPzDiF31cnJxEQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-14_02,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1011
 spamscore=0 mlxscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305140036
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/2023 12:10 AM, Mukesh Ojha wrote:
> 
> 
> On 5/4/2023 10:04 PM, Krzysztof Kozlowski wrote:
>> On 04/05/2023 17:21, Krzysztof Kozlowski wrote:
>>>>>
>>>>>> +    ret = qcom_minidump_init_apss_subsystem(md);
>>>>>> +    if (ret) {
>>>>>> +        dev_err(&pdev->dev, "apss minidump initialization failed: 
>>>>>> %d\n", ret);
>>>>>> +        goto unlock;
>>>>>> +    }
>>>>>> +
>>>>>> +    __md = md;
>>>>>
>>>>> No. This is a platform device, so it can have multiple instances.
>>>>
>>>> It can have only one instance that is created from SMEM driver probe.
>>>
>>> Anyone can instantiate more of them.... how did you solve it?
>>
>> To clarify - sprinkling more of singletons makes everything tightly
>> coupled, difficult to debug and non-portable. You cannot have two
>> instances, you have to control concurrent initialization by yourself in
>> each of such singletons.
>>
>> I understand sometimes they are unavoidable, for example when this does
>> not map to hardware property. However here you have the parent - smem -
>> which can return you valid instance. Thus you avoid entire problem of
>> file-scope variables.
> 
> I get your point, why one's should avoid file scope variables.
> 
> 
> This is infrastructure driver and will not have multiple instances and 
> even if it happens could be avoided with with the help of global mutex 
> and protect below function which i am already doing at the moment and 
> fail the other probe if it is already initialized with proper logging..e.g

Another way to think here is what if you have chiplets? Two SOCs looks 
like one as a product? How does your driver will behave in those cases?

---Trilok Soni
