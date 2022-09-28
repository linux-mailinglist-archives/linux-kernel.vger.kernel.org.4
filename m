Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF815EE2DA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbiI1RQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234526AbiI1RPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:15:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698356155;
        Wed, 28 Sep 2022 10:14:51 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SFxknI013745;
        Wed, 28 Sep 2022 17:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DfWa4kYRbcl1hA6HyErjAiPFgCWYPvqbo8XU1ijh8sM=;
 b=UcVy8tDvs//4YmasbJWDXcVUqdroXf0wWoRUY8woy24h3q55t/H1zGqaF9zz+hrThBLm
 +qlWJCDV6g6PLobsDVkwaXf//GeFLcInJaFD5wjz8PiUoI1Wo/b60hwnIE4T9cMcxutp
 xi02J1K238z3V+le+2agnmcTgtJxkIYXaxIoUNJdmusTsSpbk/1+1M3MnP4qyKSSSUV1
 NKb9V18JnRb0hghleytCzTTRby7jrm2EDWK5N36UCD/0xwvyQzJDv/PrEWcmr8SXu656
 3TwC9kv2DJu8obEZmW9kvdUBWG/q3JEkGDwtUmwJyDNnaAqTc3F3u0vhWtoePqOfu82g eQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jvkbagysj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 17:14:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28SHEhBQ004791
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 17:14:43 GMT
Received: from [10.110.48.3] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 28 Sep
 2022 10:14:38 -0700
Message-ID: <e5e1846a-5e36-a911-ce06-d4c37b7151d9@quicinc.com>
Date:   Wed, 28 Sep 2022 22:44:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V13 1/7] dt-bindings: Added the yaml bindings for DCC
Content-Language: en-US
To:     Alex Elder <elder@ieee.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, <vkoul@kernel.org>
References: <cover.1663642051.git.quic_schowdhu@quicinc.com>
 <c6b55a5b44a8add13ea9015542522b2562cf8f60.1663642052.git.quic_schowdhu@quicinc.com>
 <f09fabec-f5a3-df21-f776-956732d60359@kernel.org>
 <353ae92d-57a2-5ca3-c3dc-c68b6a8f80ab@ieee.org>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <353ae92d-57a2-5ca3-c3dc-c68b6a8f80ab@ieee.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dhosHsx7C9le9DJynelbrEciHXeMM1iP
X-Proofpoint-ORIG-GUID: dhosHsx7C9le9DJynelbrEciHXeMM1iP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_07,2022-09-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 mlxlogscore=795 priorityscore=1501 clxscore=1015
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2209280102
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/28/2022 1:21 AM, Alex Elder wrote:
> On 9/23/22 2:27 PM, Krzysztof Kozlowski wrote:
>> On 20/09/2022 05:56, Souradeep Chowdhury wrote:
>>> Documentation for Data Capture and Compare(DCC) device tree bindings
>>> in yaml format.
>>>
>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>
> Souradeep, I will review v14 (of the code anyway--patch 3) when you 
> send it.
>
>                     -Alex
Thank you. I have posted the v14 of the patch series.
>
>>> ---
>>>   .../devicetree/bindings/arm/msm/qcom,dcc.yaml      | 44 
>>> ++++++++++++++++++++++
>>>   1 file changed, 44 insertions(+)
>>
>> Rebase your tree on some current Linux kernel (and use
>> scripts/get_maintainers.pl).
>>
>> Best regards,
>> Krzysztof
>>
>
