Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EA06C665B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjCWLRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjCWLRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:17:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAE928E7D;
        Thu, 23 Mar 2023 04:17:29 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N5uEqW011415;
        Thu, 23 Mar 2023 11:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UBQtHcLoBj1gvJaKvZeK+QVSnl95BO+2Eb/SvLRXf3g=;
 b=NaGQftmAT00lAn8UWa+3sdvj1eVu5XXflASdw4E0B+zPhp/BAzIJdEpPKi7OV8zVuPm7
 MK7uqVQ1i0IlD9N/elCCzMU7wnME7LuDNqlCwJn+rLAaW/GaWo3Yj7bZUmEVA5GIyTab
 u9AnoeV+eKj1O3YdWV+vuGDuZDcGoTYKpEGSwLsZBTFRukq87JAgoIW/8Hj9bMZoPeJp
 sXXx5N9AMLuiwSlqgEYBKTL2seLPCGClsl2xl3Udx4rsBTVDEcf2RFkBbz2XDjTXX1Xa
 0Ir442w17yG/eayakPYigjOKqyKS4LxnzLXryICo1KC69DuPto/pUTp6VHcE92VM3rCt mA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pg9nahj94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 11:17:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32NBHQUp016433
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 11:17:26 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 23 Mar
 2023 04:17:23 -0700
Message-ID: <c53ac749-0d19-b1ca-c5e9-0970a9e77106@quicinc.com>
Date:   Thu, 23 Mar 2023 16:47:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V2 2/2] arm64: dts: qcom: ipq5332: add support for the
 RDP468 variant
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230323093120.20558-1-quic_kathirav@quicinc.com>
 <20230323093120.20558-3-quic_kathirav@quicinc.com>
 <3b2e7b07-7598-45af-0dce-a60310aa5d60@linaro.org>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <3b2e7b07-7598-45af-0dce-a60310aa5d60@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NBji5t5HUHlDprz_08V63mT-CG-wlcVa
X-Proofpoint-ORIG-GUID: NBji5t5HUHlDprz_08V63mT-CG-wlcVa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=674 suspectscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230085
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/23/2023 4:26 PM, Krzysztof Kozlowski wrote:
> On 23/03/2023 10:31, Kathiravan T wrote:
>> Add the initial device tree support for the Reference Design
>> Platform(RDP) 468 based on IPQ5332 family of SoCs. This patch carries the
>> support for Console UART, SPI NOR, eMMC.
>>
>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>> ---
>> Changes in V2:
>> 	- Moved the 'reg' property after 'compatible'
>>
>>   arch/arm64/boot/dts/qcom/Makefile           |   1 +
>>   arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts | 103 ++++++++++++++++++++
>>   2 files changed, 104 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
> Hi,
>
> Your v1 was reported that it does not build. Does this patch build fine?
As mentioned in the cover letter,

This series depends on the below which adds support the SPI NOR

https://lore.kernel.org/linux-arm-msm/20230320104530.30411-1-quic_kathirav@quicinc.com/

Thanks,

Kathiravan T.

