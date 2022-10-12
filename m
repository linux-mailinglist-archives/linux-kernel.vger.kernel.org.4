Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674A05FC0D4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 08:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJLGmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 02:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiJLGmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 02:42:03 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F774D818;
        Tue, 11 Oct 2022 23:42:03 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29C5np1W030643;
        Wed, 12 Oct 2022 06:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MA5guw7a0c13JePpvNEp5lk8mucRGKkZURE+DJS4VhU=;
 b=Dv4oywekiMovuFhdZ5hLhjfi3MXw9X+az60i6JeD81A++Bu+lyXg+fRVG1xhQoLKBEeC
 aJq/m+6a0OBbMejfSikAVJHVwDXPKSF9z6zZXKl5C4vOGrKY3x/JhFXYhuZQc17fTxdQ
 SplVkCBA63eT/Kio3PWNdCQRBJBu8pQ5wThNBMTVF1gm2mtY1dA+zU/VOpnijIa9CpRX
 sFbmk6y4HaKi8mO3IHWfHU8D7mbrnX1FVFvb8SOWeX10rvq4CFDU9FvLIct1kMXCrRjB
 /fvfTczQXzL1ar4xHpPSccj30LceGtHCvhYapj0DkoZnPondhfM8bKfqO5UXRHkhzgXc 7A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k5e7fhdu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 06:41:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29C6fsMr015783
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 06:41:54 GMT
Received: from [10.110.0.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 11 Oct
 2022 23:41:49 -0700
Message-ID: <3e2a3f01-0283-1c9c-9d12-c171fc381813@quicinc.com>
Date:   Wed, 12 Oct 2022 12:11:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V14 1/7] dt-bindings: Added the yaml bindings for DCC
Content-Language: en-US
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, <vkoul@kernel.org>
References: <cover.1664383851.git.quic_schowdhu@quicinc.com>
 <e320555b2075c94946ef3f9c78732dc84ba39449.1664383851.git.quic_schowdhu@quicinc.com>
 <4d0f7a01-1995-1b1e-40b9-125c3447b8c7@kernel.org>
 <78b42aab-164a-7fe6-fec5-77f52199c641@quicinc.com>
 <e028ad6a-9687-5089-4938-e982764b9c58@kernel.org>
 <a1a79910-c697-3660-ddf8-5f4f164c1b34@quicinc.com>
In-Reply-To: <a1a79910-c697-3660-ddf8-5f4f164c1b34@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: p6yeGIy7_WJbPpgCJyUyyOwJplW7Bg2r
X-Proofpoint-GUID: p6yeGIy7_WJbPpgCJyUyyOwJplW7Bg2r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_03,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=927 spamscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120043
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2022 11:27 AM, Souradeep Chowdhury wrote:
> 
> On 10/11/2022 6:50 PM, Krzysztof Kozlowski wrote:
>> On 30/09/2022 02:59, Souradeep Chowdhury wrote:
>>> Also the ./script/maintainers.pl gives the below output
>>>
>>> Souradeep Chowdhury<quic_schowdhu@quicinc.com>  (maintainer:DCC QTI
>>> DRIVER,in file)
>>> Andy Gross<agross@kernel.org>  (maintainer:ARM/QUALCOMM SUPPORT)
>>> Bjorn Andersson<andersson@kernel.org>  (maintainer:ARM/QUALCOMM SUPPORT)
>>> Konrad Dybcio<konrad.dybcio@somainline.org>  (reviewer:ARM/QUALCOMM SUPPORT)
>>> Rob Herring<robh+dt@kernel.org>  (maintainer:OPEN FIRMWARE AND FLATTENED
>>> DEVICE TREE BINDINGS)
>>> Krzysztof Kozlowski<krzysztof.kozlowski+dt@linaro.org>  (maintainer:OPEN
>>> FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
>>> linux-arm-msm@vger.kernel.org  (open list:DCC QTI DRIVER)
>>> devicetree@vger.kernel.org  (open list:OPEN FIRMWARE AND FLATTENED DEVICE
>>> TREE BINDINGS)
>>> linux-kernel@vger.kernel.org  (open list)
>>>
>>> Will send out the next version accordingly, let me know in case of any
>>> further concerns.
>> v15 and v16 was still not sent according to what you wrote above...
> 
> I have copied all of the above in the mailing list, also I have 
> implemented all the previous comments.
> 
> [PATCH V16 0/7] soc: qcom: dcc: Add driver support for Data Capture and 
> Compare unit(DCC) - Souradeep Chowdhury (kernel.org) 
> <https://lore.kernel.org/lkml/cover.1664805059.git.quic_schowdhu@quicinc.com/#r>
> 
> Can you please let me know what is expected here so that I can correct 
> in the next version accordingly?

Apologies for sending the previous mail in html format.
My comments are as above.


> 
>> Best regards,
>> Krzysztof
>>
