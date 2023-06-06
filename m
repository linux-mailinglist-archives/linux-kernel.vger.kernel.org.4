Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4F77237C0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbjFFGdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjFFGdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:33:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8A9123;
        Mon,  5 Jun 2023 23:33:36 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3565kBw0021598;
        Tue, 6 Jun 2023 06:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wGNR35vj0lPMC8yPcOx3emygX/jN2PAWABJ3cTjLVpo=;
 b=UVzTF3a2IdxFbtx67yd9Fd8UKRt9dqqF9WJ1lPFog6lZ/7pe+MV4TT5SIf2G5fwzgL5o
 MXor21wmZzTj7v68wBCdMqs0hji001dMxESeUegDli/u9JRGvDIYi8gEhrEeTJGdmSzB
 x2WuWlePQ4608qwkDvcGUqjbXzYcfjIC6YrFKmLk4LCs7V5VBxlEsLH6Pzb8uRyEASGq
 nXL3uVA3+oxJ6OM0TJP+jUJWMaGot32cfeFpMZs3mZNiLNlovfx5e+DWFcgfmagfd0j4
 s226Mttgnr+ByiBgePKjmM48WN9LI/cHOohQERRNl9GUgjbfdMU43bU53AUKt4HTLqQ2 1w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r1xxr040m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 06:33:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3566X99S020873
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Jun 2023 06:33:09 GMT
Received: from [10.214.66.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 5 Jun 2023
 23:33:03 -0700
Message-ID: <3cd1d957-007e-d5d2-a33d-6b826916c892@quicinc.com>
Date:   Tue, 6 Jun 2023 12:03:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 08/10] arm64: dts: qcom: Add QUPv3 UART console node
 for SDX75
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <tglx@linutronix.de>, <maz@kernel.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <joro@8bytes.org>, <mani@kernel.org>,
        <robimarko@gmail.com>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
References: <1685982557-28326-1-git-send-email-quic_rohiagar@quicinc.com>
 <1685982557-28326-9-git-send-email-quic_rohiagar@quicinc.com>
 <7a6544b0-5c8d-8b61-71e8-32f59e93c2d4@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <7a6544b0-5c8d-8b61-71e8-32f59e93c2d4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: omBu5-ParGuCgWQyZRV6y31HxOW8NBcS
X-Proofpoint-ORIG-GUID: omBu5-ParGuCgWQyZRV6y31HxOW8NBcS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_03,2023-06-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0
 mlxlogscore=791 spamscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060055
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/6/2023 11:36 AM, Krzysztof Kozlowski wrote:
> On 05/06/2023 18:29, Rohit Agarwal wrote:
>> Add the debug uart console node in devicetree.
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sdx75.dtsi | 49 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 49 insertions(+)
> GCC and UART are parts of basic DTSI and do not make sense on their own.
> Otherwise, what exactly boots on your "basic DTSI" commit if you do not
> have any clocks and serial console?
Ok Will club all the additional patches into the same base dtsi patch.

Thanks,
Rohit.
>
> Best regards,
> Krzysztof
>
