Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8E7747DE0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjGEHHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjGEHG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:06:58 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60B4CA;
        Wed,  5 Jul 2023 00:06:57 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3654FZa7017578;
        Wed, 5 Jul 2023 07:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rEM368YRnqn41jsg/aSUs6ygVV/RoLHVCaBrIX1eK/o=;
 b=nMywXl8jWPnIQnsqn6U+zC375AwZ4BkUwSkhFohouOXw8tVB2v7BVyvrQrNxp56PRNq/
 m7X9UkxcXrn0OrNatfO25RGIivBQkVwiMa47Dbchu9HzB8PmoubRU+jJpaXok53v2gUm
 M9k7PL+oxRwq1v2kxC6LAicZc7bHYr2x8Zm58Fw1vYcjM9uM8P6eDn1mCE7oWdJJkDax
 URAhJKnwjBoBk7w4TOiszm1OzT8JzFL8doqKpCjElR9BAueLEe4EqZKZrJ+o7Jgk/dzo
 zwKGIqydArIvGWoslwTQktpiptmT6YxC45xr3LOYc16IVUAPKvq2hcmepqJwi8W0N8DJ 3A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rmhf12781-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jul 2023 07:06:54 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36576r4p021077
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Jul 2023 07:06:53 GMT
Received: from [10.214.230.142] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Wed, 5 Jul 2023
 00:06:49 -0700
Message-ID: <db283531-36a2-0535-4fe2-d1571b3fa8cb@quicinc.com>
Date:   Wed, 5 Jul 2023 12:36:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/2] arm64: dts: qcom: qdu1000-idp: Update reserved memory
 region
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230705053914.9759-1-quic_kbajaj@quicinc.com>
 <20230705053914.9759-2-quic_kbajaj@quicinc.com>
 <CAA8EJpo406gV-5H8+y4SJbbRqnWFRo5wrR6a9KJ2arbN61tS2Q@mail.gmail.com>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <CAA8EJpo406gV-5H8+y4SJbbRqnWFRo5wrR6a9KJ2arbN61tS2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uaV8lcOLbK13ZG0c39-1cqIj44sRRm1-
X-Proofpoint-ORIG-GUID: uaV8lcOLbK13ZG0c39-1cqIj44sRRm1-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_16,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=821 spamscore=0
 bulkscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307050063
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/5/2023 11:19 AM, Dmitry Baryshkov wrote:
> On Wed, 5 Jul 2023 at 08:40, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>> Add missing reserved regions as described in QDU1000 memory map.
>>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 26 ++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>> index 1d22f87fd238..3f5512ec0a90 100644
>> --- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>> @@ -448,6 +448,32 @@ &qupv3_id_0 {
>>          status = "okay";
>>   };
>>
>> +&reserved_memory{
>> +       #address-cells = <2>;
>> +       #size-cells = <2>;
>> +       ranges;
>> +
>> +       ecc_meta_data_reserved_mem:ecc_meta_data_reserved_region@e0000000{
> no_underscores_in_node_names. Ever.
>
> Also, if you have checked other platforms, you'd have seen that other
> platforms use a much more generic node name for 'memory' nodes (which
> you should have used too).

These memory nodes are new to QDU platform, so will it be okay if I keep 
these names without region suffix?

Thanks
Komal

>
>> +               no-map;
>> +               reg = <0x0 0xe0000000 0x0 0x20000000>;
>> +       };
>> +
>> +       harq_buffer_mem:harq_buffer_region@800000000{
>> +               no-map;
>> +               reg = <0x8 0x0 0x0 0x80000000>;
>> +       };
>> +
>> +       tenx_sp_buffer_mem:tenx_sp_buffer_region@880000000{
>> +               no-map;
>> +               reg = <0x8 0x80000000 0x0 0x50000000>;
>> +       };
>> +
>> +       fapi_buffer_mem:fapi_buffer_region@8d0000000{
>> +               no-map;
>> +               reg = <0x8 0xd0000000 0x0 0x20000000>;
>> +       };
>> +};
>> +
>>   &sdhc {
>>          pinctrl-0 = <&sdc_on_state>;
>>          pinctrl-1 = <&sdc_off_state>;
>> --
>> 2.40.1
>>
>

