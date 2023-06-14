Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEC172FB15
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbjFNKfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbjFNKep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:34:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0BD2116;
        Wed, 14 Jun 2023 03:34:36 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35E9M5D1014210;
        Wed, 14 Jun 2023 10:34:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4p5rvgkIAjJA/XixhCrlrbWaTQx6zhjnxIkgPoWjSA0=;
 b=pyFHimqjuWqNg/UHlYkMZtBwxNT10buV+mWUNPdUEicypK5YGmieVInGUhYBclw01+0M
 kM2Me26RiWmoc6HuVhtkAmVqKIx3ChwtSRIF55/l1IKFZ0DqFmAwHWJRFfDOwuOTs/l3
 hEpIWnG31ubk57dha8ya+khwdB2tloIfXAvRJAoMvQybhxakk/GO886K8IovLzLyaCOj
 Os/CEQcUk931p4CyEdWrDBXGDpkVyj3VQ7R+KKaahK+LXz0CareAlwoywOP9Cs22J8zK
 u0LfAt7SmdMN32LHdce86rthFVF6GVIwiGrAI5VqvKYJ4dEEfjK6+3vi8yEqZlyBdNnh VA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7auy09kx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 10:34:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35EAYV3r031159
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 10:34:31 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 14 Jun
 2023 03:34:28 -0700
Message-ID: <1957b1cf-28b7-dbfc-1675-ee4534e5571b@quicinc.com>
Date:   Wed, 14 Jun 2023 16:04:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] arm64: dts: qcom: ipq9574: enable the SPI NOR support in
 RDP433
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230609081508.30982-1-quic_kathirav@quicinc.com>
 <c1c34aa4-ac7d-2c07-bf92-05d887aed3d2@linaro.org>
 <ed9d11cc-7ab4-b6c8-737b-bd89d3973e80@quicinc.com>
Content-Language: en-US
In-Reply-To: <ed9d11cc-7ab4-b6c8-737b-bd89d3973e80@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tr-EuPqlMoOiDfElvDPbS9l8kGcOjPJi
X-Proofpoint-GUID: tr-EuPqlMoOiDfElvDPbS9l8kGcOjPJi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_06,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140089
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/14/2023 12:02 PM, Kathiravan T wrote:
>
> On 6/9/2023 2:37 PM, Konrad Dybcio wrote:
>>
>> On 9.06.2023 10:15, Kathiravan T wrote:
>>> RDP433 has the support for SPI NOR, add the support for it.
>>>
>>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>>> ---
>>> Note: This patch was part of initial submission
>>> https://lore.kernel.org/linux-arm-msm/20230329053726.14860-1-quic_kathirav@quicinc.com/ 
>>>
>>> however this got missed in between, so sending it across again.
>>>
>>>   arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts | 21 
>>> +++++++++++++++++++++
>>>   1 file changed, 21 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts 
>>> b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>>> index 2b3ed8d351f7..31ee19112157 100644
>>> --- a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>>> @@ -48,6 +48,20 @@
>>>       };
>>>   };
>>>   +&blsp1_spi0 {
>>> +    pinctrl-0 = <&spi_0_pins>;
>>> +    pinctrl-names = "default";
>>> +    status = "okay";
>>> +
>>> +    flash@0 {
>>> +        compatible = "micron,n25q128a11", "jedec,spi-nor";
>>> +        reg = <0>;
>>> +        #address-cells = <1>;
>>> +        #size-cells = <1>;
>> If you're not adding a partition table, you can drop the address-
>> and size-cells properties, as they determine what the reg value of
>> the child looks like.
>
>
> Sorry, somehow I missed this query. Will check and update it.


Currently IPQ boot loaders patches the partition information into the 
SPI node. To parse that, we need the address-cells and size-cells 
properties.

Also, this patch is now integrated into the below series

https://lore.kernel.org/linux-arm-msm/20230614085040.22071-1-quic_anusha@quicinc.com/T/#t


Thanks,


>
>
>>
>> Konrad
>>> +        spi-max-frequency = <50000000>;
>>> +    };
>>> +};
>>> +
>>>   &sdhc_1 {
>>>       pinctrl-0 = <&sdc_default_state>;
>>>       pinctrl-names = "default";
>>> @@ -96,6 +110,13 @@
>>>               bias-pull-down;
>>>           };
>>>       };
>>> +
>>> +    spi_0_pins: spi-0-state {
>>> +        pins = "gpio11", "gpio12", "gpio13", "gpio14";
>>> +        function = "blsp0_spi";
>>> +        drive-strength = <8>;
>>> +        bias-disable;
>>> +    };
>>>   };
>>>     &xo_board_clk {
