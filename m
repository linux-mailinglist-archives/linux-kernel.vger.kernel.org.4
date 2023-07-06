Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F83749C51
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjGFMqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjGFMqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:46:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77301BE3;
        Thu,  6 Jul 2023 05:45:54 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366BnXLk022020;
        Thu, 6 Jul 2023 12:45:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/eTRKvEprj4j5mhYYTy9ajJZ7xy0mmVqOmJ9KqT9W2o=;
 b=fd7tltda+naNyCbaAzc7N9DGJBZ39pL02ZkCjr005CX4UcZChaWl43wNkBTVd/Dy1p2x
 2G61ILVKRj9fM1j9l3Zav5G2UxMlR2fO6KgMHQzwCwjbbtICWcpCYN8ahQr1GkyxUUHN
 44z9Syx0vxTV2tz6jSIUWam64/glM5UIhrpkru4G+V1/PHAGbSxrQQ+sNFDMRW2kBYzI
 iYQFvYgz+LV6Z88uZir0zAq50AYAu26rvA0x2jU63jZ6lGSwl2eYJBPGVyRk1ylYE0M6
 FHurDK33Zfhgn4ZL/AGZxjxcx0HifMuboKJzJjFYORIf3vR5vVEd7bRCtv3bDXwWrR7g 3A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rntctrd9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 12:45:17 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 366CjGnB026709
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 12:45:16 GMT
Received: from [10.216.12.242] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 6 Jul
 2023 05:45:12 -0700
Message-ID: <0dbd4776-deeb-d62c-e640-c931eb0dd675@quicinc.com>
Date:   Thu, 6 Jul 2023 18:15:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: qdu1000-idp: Update reserved
 memory region
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230705110620.7687-1-quic_kbajaj@quicinc.com>
 <20230705110620.7687-2-quic_kbajaj@quicinc.com>
 <8bd8ffbe-f50d-6e4a-2fdf-3983a76fb5ad@linaro.org>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <8bd8ffbe-f50d-6e4a-2fdf-3983a76fb5ad@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sobp9K-3SxWSl3pyMkesWLsUugGXyhde
X-Proofpoint-ORIG-GUID: sobp9K-3SxWSl3pyMkesWLsUugGXyhde
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_09,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=630 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060114
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/5/2023 7:51 PM, Krzysztof Kozlowski wrote:
> On 05/07/2023 13:06, Komal Bajaj wrote:
>> Add missing reserved regions as described in QDU1000 memory map.
>>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>> index 1d22f87fd238..47e5e31dde23 100644
>> --- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>> @@ -448,6 +448,28 @@ &qupv3_id_0 {
>>   	status = "okay";
>>   };
>>
>> +&reserved_memory{
>> +	ecc_meta_data_mem: memory@e0000000{
> Missing spaces before '{'. I was correcting this already:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=66b14154e278807811d67de9fb0d5cc76638d07b
> so it seems I need to keep doing the same.
>
> Anyway, the names should follow purpose, not "memory". See link from Konrad.

Sure, will correct it in the next patch set.

>
>
> Best regards,
> Krzysztof
>

