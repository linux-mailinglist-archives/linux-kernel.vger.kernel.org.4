Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DFE5FBA97
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJKSk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJKSkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:40:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2EE7CB67;
        Tue, 11 Oct 2022 11:40:50 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29BBeKYZ030456;
        Tue, 11 Oct 2022 18:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=h1BvboPV+q0O/fs3qxdcsJfGYHdo3ib28v+3LY8CB1k=;
 b=JL5G78K3BcH4pq2z2MiK+KQ0tT7p1lAGpPEIkl3QFQJuEnd+BXe/srHQ394xZmr0K+5p
 IIcEYR1vANcO5xzA3TVeL5uVUzcBOB6/yCzYvcsglKS9Sat/jn+uCOs/HSBAjj7HJ2vG
 qDrYNJy6hsVCP6aq/XCPcGxcAzisvYxL11zf4vB5pvFYAPqv5po8RijuStA1Zjs+fxk+
 ObNEDMLsw6hyzef/y3Z4RBq96noQBPdtAtbRff+c5OHwwY/qSiBG9fL/V6WGraVfWNkR
 mTFusYn7drSOxdfa4libsT5eEdrAmDi4ZGpDUJ/ZS1mFb1ni03oqkmC0EO/QbLDrY5ga Zg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k4rwxuv48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 18:40:47 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29BIekZU032317
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 18:40:47 GMT
Received: from [10.110.3.66] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 11 Oct
 2022 11:40:46 -0700
Message-ID: <401219d2-43f1-5816-54c2-80be8a4afb1c@quicinc.com>
Date:   Tue, 11 Oct 2022 11:40:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 03/19] arm64: dts: qcom: qdru1000: Add tlmm nodes
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221001030656.29365-1-quic_molvera@quicinc.com>
 <20221001030656.29365-4-quic_molvera@quicinc.com>
 <CAA8EJpp2h3j9cPLPzCzgnYm07D5PPZg3H5_LkcXizhXt9ekkiQ@mail.gmail.com>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <CAA8EJpp2h3j9cPLPzCzgnYm07D5PPZg3H5_LkcXizhXt9ekkiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: i3X1gpRH1cqkzW_EGShuDoN16EMgwD3H
X-Proofpoint-GUID: i3X1gpRH1cqkzW_EGShuDoN16EMgwD3H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_08,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1015 malwarescore=0
 adultscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 mlxlogscore=819 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210110108
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/1/2022 12:26 AM, Dmitry Baryshkov wrote:
> On Sat, 1 Oct 2022 at 06:09, Melody Olvera <quic_molvera@quicinc.com> wrote:
>> Add tlmm node for the QDU1000 and QRU1000 SoCs and the uart pin
>> configuration.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/qdru1000.dtsi | 30 ++++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qdru1000.dtsi b/arch/arm64/boot/dts/qcom/qdru1000.dtsi
>> index 3610f94bef35..39b9a00d3ad8 100644
>> --- a/arch/arm64/boot/dts/qcom/qdru1000.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/qdru1000.dtsi
>> @@ -235,6 +235,8 @@ uart7: serial@99c000 {
>>                                 reg = <0x0 0x99c000 0x0 0x4000>;
>>                                 clock-names = "se";
>>                                 clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
>> +                               pinctrl-names = "default";
>> +                               pinctrl-0 = <&qup_uart7_default>;
>>                                 interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
>>                                 #address-cells = <1>;
>>                                 #size-cells = <0>;
>> @@ -248,6 +250,34 @@ tcsr_mutex: hwlock@1f40000 {
>>                         #hwlock-cells = <1>;
>>                 };
>>
>> +               tlmm: pinctrl@f000000 {
>> +                       compatible = "qcom,qdu1000-tlmm", "qcom,qru1000-tlmm";
>> +                       reg = <0x0 0xf000000 0x0 0x1000000>;
>> +                       interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>> +                       gpio-controller;
>> +                       #gpio-cells = <2>;
>> +                       interrupt-controller;
>> +                       #interrupt-cells = <2>;
>> +                       gpio-ranges = <&tlmm 0 0 151>;
>> +                       wakeup-parent = <&pdc>;
>> +
>> +                       qup_uart7_default: qup-uart7-default {
>> +                               tx {
>> +                                       pins = "gpio134";
>> +                                       function = "qup0_se7_l2";
> This looks strange. Usually we'd have a single 'qup7' function here.
> I'd go back to the interconnect driver. Maybe the functions are not
> correctly defined there.
Yeah; will correct. Pinctrl driver was not in line with upstream standards.
>
>> +                                       drive-strength = <2>;
>> +                                       bias-disable;
> 'drive-strength' and 'bias-disable' are to be patched in in the board dts file.
Really? Looking at sm8450.dtsi and sm8350.dtsi I see them defined in the dtsi file instead of the
dts file. Is this new?
>
>> +                               };
>> +
>> +                               rx {
>> +                                       pins = "gpio135";
>> +                                       function = "qup0_se7_l3";
>> +                                       drive-strength = <2>;
>> +                                       bias-disable;
>> +                               };
>> +                       };
>> +               };
>> +
>>                 pdc: interrupt-controller@b220000 {
>>                         compatible = "qcom,pdc";
>>                         reg = <0x0 0xb220000 0x0 0x30000>, <0x0 0x174000f0 0x0 0x64>;
>> --
>> 2.37.3
>>
>
Thanks,
Melody
