Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3E76C68A5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjCWMmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjCWMmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:42:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30DD2BF15;
        Thu, 23 Mar 2023 05:42:18 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N4eBE5019609;
        Thu, 23 Mar 2023 12:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=SbsVD/80xz/JO37vTt1xOkF2LWOi4tktkZ+StMmxalc=;
 b=acBRM5/I2bm/1mof/T0M1N0pLOiCzYkaaz7EKUBKbPcqb/pe6Jvfg/H1zJ5UvqCYOLrB
 QXzEjUV4zMgRUr1MKiIZQV28YdNbyMBpNa0KhTl66ctesMQtVgc4ABjttjLk2DaxCjAO
 N1PodY7E6o2uRh3TH9pYmkaX/DvzOfOevC3yv5jgUJOzRYykWPXj0dBDgWxoX1MRyFPn
 VveY/YaD9ZOvC7BVFF8V8UP8fZ//UT1ZgDaRZzkBlwvW0Ua4xKHxCC2xflCzaW4s69WM
 izhWH8y/KdUFf65lQ2H86YD58KrgqVfw3UXOrndimyms29oCDq/16mo6r8JcadWkAuRd 2w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pg9nahs35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 12:42:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32NCgE8D003523
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 12:42:14 GMT
Received: from [10.50.17.125] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 23 Mar
 2023 05:42:11 -0700
Message-ID: <5e82e38e-502e-49ad-42d6-58f7aa1d70f7@quicinc.com>
Date:   Thu, 23 Mar 2023 18:12:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V2 2/2] arm64: dts: qcom: ipq5332: add support for the
 RDP468 variant
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230323093120.20558-1-quic_kathirav@quicinc.com>
 <20230323093120.20558-3-quic_kathirav@quicinc.com>
 <3b2e7b07-7598-45af-0dce-a60310aa5d60@linaro.org>
 <c53ac749-0d19-b1ca-c5e9-0970a9e77106@quicinc.com>
In-Reply-To: <c53ac749-0d19-b1ca-c5e9-0970a9e77106@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dqrquTyGhu75P-S9Zz51Pc20djIrbteW
X-Proofpoint-ORIG-GUID: dqrquTyGhu75P-S9Zz51Pc20djIrbteW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=635 suspectscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230095
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/23/2023 4:47 PM, Kathiravan T wrote:
>
> On 3/23/2023 4:26 PM, Krzysztof Kozlowski wrote:
>> On 23/03/2023 10:31, Kathiravan T wrote:
>>> Add the initial device tree support for the Reference Design
>>> Platform(RDP) 468 based on IPQ5332 family of SoCs. This patch 
>>> carries the
>>> support for Console UART, SPI NOR, eMMC.
>>>
>>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>>> ---
>>> Changes in V2:
>>>     - Moved the 'reg' property after 'compatible'
>>>
>>>   arch/arm64/boot/dts/qcom/Makefile           |   1 +
>>>   arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts | 103 
>>> ++++++++++++++++++++
>>>   2 files changed, 104 insertions(+)
>>>   create mode 100644 arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
>> Hi,
>>
>> Your v1 was reported that it does not build. Does this patch build fine?
> As mentioned in the cover letter,
>
> This series depends on the below which adds support the SPI NOR
>
> https://lore.kernel.org/linux-arm-msm/20230320104530.30411-1-quic_kathirav@quicinc.com/ 
>


Given that, this series and the dependent series has only DTS changes, 
and also both series has V2, is it okay If I squash them into single 
series and send it?


Thanks, Kathiravan T.



