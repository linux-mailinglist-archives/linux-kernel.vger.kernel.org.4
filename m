Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A8F63BD7B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 11:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiK2KFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 05:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiK2KFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 05:05:18 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3314C5C77A;
        Tue, 29 Nov 2022 02:05:17 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AT8Zd0P009615;
        Tue, 29 Nov 2022 10:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=bcU1Cz33wc+5pqdkkQnRDcKJ+Q19F6js9Zw3sAIyvhY=;
 b=VeNAoflVyjQjU4YZd/cZLW9NxFk8iRpzPx6SZFvziVbsE7fSBs3wBbAvUPdU7NpY39qi
 Ma8EviUa3qhQZX9F01bqtf1sNJU+GKrqaihCMOk4YR391kTkXcmBAud7xgq7aFqO8tZp
 R6OG/YLvfDHRQuBOdItY4oF5oG/lTCUFHwx/wUXh3+iI1+20E7+v8XHy0/v7aSccwFYf
 3zO+Jyud4s4PL7MPNPW0QB83ulnRZ852Iuj1rFX8b0B+ziq/lUzKrR38t8e++KvTiM3v
 roZXzRQjR/IPKL3iK9aq0MJU77gnyNS94DRKezE8jEGlYx/HJUccoBABRr71ZMhCU6W5 HQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m5a52h1fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 10:05:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ATA59au026032
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 10:05:09 GMT
Received: from [10.79.43.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 29 Nov
 2022 02:05:05 -0800
Message-ID: <c21737b3-cb72-6a4e-0ab2-b8231a7119fe@quicinc.com>
Date:   Tue, 29 Nov 2022 15:35:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V5 1/2] dt-bindings: firmware: qcom-scm: Add optional
 interrupt
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <konrad.dybcio@somainline.org>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>, <quic_rjendra@quicinc.com>
References: <20221123204615.25358-1-quic_sibis@quicinc.com>
 <20221123204615.25358-2-quic_sibis@quicinc.com>
 <3cda9005-d7a5-56f0-d1d2-fd6c1cb36fc3@linaro.org>
 <7b6ffbb4-80fb-610a-c839-e3bf1668d4ed@quicinc.com>
 <61f1a1e5-bd2c-4a22-66f7-1935154b35ad@linaro.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <61f1a1e5-bd2c-4a22-66f7-1935154b35ad@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SlLFheIA1SsYwJjUg1zlz4b6AE40QSUZ
X-Proofpoint-ORIG-GUID: SlLFheIA1SsYwJjUg1zlz4b6AE40QSUZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_07,2022-11-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=663 mlxscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290061
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/22 14:00, Krzysztof Kozlowski wrote:
> On 28/11/2022 06:57, Sibi Sankar wrote:
> 
>>>
>>> Which devices have interrupts?
>>>
>>> We talked about it here:
>>> https://lore.kernel.org/all/2464d90f-64e9-5e3c-404b-10394c3bc302@quicinc.com/
>>> and here:
>>> https://lore.kernel.org/all/c20edd0d-7613-5683-60e7-54317cac6e0b@linaro.org/
>>>
>>> But I still don't get which devices support it and which do not.
>>
>> lol, I thought we reached a consensus earlier because of the "ok" and
>> R-b. Like I explained earlier the bootloader would be adding interrupt
>> on the fly, wouldn't such cases cause binding check failure if we list
>> all the devices supporting it?
> 
> What type of failure? I don't get. Is this interrupt valid for SM8250?
> SDM845? MSM8996? and so on? Now you make it valid.

ok if we mark the interrupt as required for SM8450 and not specify the
interrupt in the board file (since the bootloader will be adding it on
the fly), dtbs_check will throw 'interrupts' is a required property for
the board file. This was the failure I was talking about.

> 
>> Also some of the SM8450 devices in the
>> wild would be running firmware not having the feature but I guess
>> eventually most of the them will end up supporting the feature in the
>> end.
> 
> That's not what I meant. Your patch describes the case for one variant
> but you are affecting all of them.

Not really, the driver treats interrupts as optional. If the interrupt
isn't present we assume that the feature isn't supported. If the
bootloader adds the property during boot then we assume the fw has
waitqueue support.

- Sibi

> 
> 
> 
> Best regards,
> Krzysztof
> 
