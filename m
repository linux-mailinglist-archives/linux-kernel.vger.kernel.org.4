Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4556D729711
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjFIKg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjFIKgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:36:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD83184;
        Fri,  9 Jun 2023 03:34:25 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359AOKJY018195;
        Fri, 9 Jun 2023 10:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Mi1kipphmx0K8ypVZTGfsiKuZ0H06HTLT6Vy17PLGUU=;
 b=IeN2oUsuy8qflAQmw4bdv97GZ7zXtnpXzfB/UmekPVuEJEgyizheVXm4Cukvx/PEDjYM
 U6S1GakQd4bvNlGmTzDd/YjXTQIoZZ4f5xjkhartc6qNMvVfBnpQCyWjHJ6iVV76zhEx
 RclqU/7DeIf9cc0M/bRXqUe7jeuRhzeQ2FSEuUR7v8bnbizl0NC4uhxxZQ5YQxpfGMph
 mI1cejmM3zGYmgTt+Q72hTLupPYWig9QYq/Vrzjj3f+eAzG9+H0lxTOTeryvqUJaD1oJ
 SmjtTvFGHQF+eiDIQ1w5pPyMOlXKdf9c1jHIIs7D6KWc1HAxdlPzy075QLt/tUSHl+rB Vw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r3dkcagpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 10:34:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 359AYFXF023193
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Jun 2023 10:34:15 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 9 Jun 2023
 03:34:12 -0700
Message-ID: <59d77595-b0c7-e60d-2c89-691369defab5@quicinc.com>
Date:   Fri, 9 Jun 2023 16:04:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V3 0/3] Minor updates in the IPQ5332 DTS files
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230519133844.23512-1-quic_kathirav@quicinc.com>
 <b85216b3-8e6a-b3ea-4c01-680b1339a623@quicinc.com>
Content-Language: en-US
In-Reply-To: <b85216b3-8e6a-b3ea-4c01-680b1339a623@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: T6MsZurOWyip7MPVGi9E5g0qF5LgeDf_
X-Proofpoint-GUID: T6MsZurOWyip7MPVGi9E5g0qF5LgeDf_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_06,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=622 clxscore=1015 spamscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090089
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/30/2023 7:38 AM, Kathiravan T wrote:
>
> On 5/19/2023 7:08 PM, Kathiravan T wrote:
>> Rename the MI01.2 DTS after Reference Design Platform(RDP) number to 
>> align
>> with ipq5332-rdp468.dts, add UART1 node and reserve memory for U-boot
>> and SBL to avoid losing the RAM contents which will be used in post
>> morterm analysis.
>
>
> Gentle Reminder...


Bjorn, can this series picked up for v6.5? Since this is pending for 
long time...


>
>
>>
>> Kathiravan T (3):
>>    arm64: dts: qcom: ipq5332: rename mi01.2 dts to rdp441
>>    arm64: dts: qcom: ipq5332: define UART1
>>    arm64: dts: qcom: ipq5332: add few more reserved memory region
>>
>>   arch/arm64/boot/dts/qcom/Makefile             |  2 +-
>>   ...{ipq5332-mi01.2.dts => ipq5332-rdp441.dts} |  0
>>   arch/arm64/boot/dts/qcom/ipq5332.dtsi         | 24 ++++++++++++++++++-
>>   3 files changed, 24 insertions(+), 2 deletions(-)
>>   rename arch/arm64/boot/dts/qcom/{ipq5332-mi01.2.dts => 
>> ipq5332-rdp441.dts} (100%)
>>
