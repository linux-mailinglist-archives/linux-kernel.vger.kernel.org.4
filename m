Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019A27096E1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 13:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjESL4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 07:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjESLz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 07:55:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A757118C;
        Fri, 19 May 2023 04:55:56 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JBlDAu025070;
        Fri, 19 May 2023 11:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=QItA3/BibegvONvjRtjHt0UfsQ3t4HsK7rw+OtQnvlU=;
 b=GdtWuShYM+u7uJrYZ6dg+5IlCh4EFCsRodeTWgCLjCJKF1UR9vHiQvMDJcW+lrlysNUp
 0V5gU4GfJTBN6p1j/Y5uqDI2yNCMCLrq0zlTHHUny8KXuvVSo1DYxmvIs4FQWvMh9dvi
 BkkibqIpr9MiUdYNgsGJl5HFlKnolViV9isSVXDA+WuofawTCHVwRlDNAODTJv8/oifG
 lPcyVr6rdSs2+V7CBu/c7X/eUvfm8GbRPym3oW+NHzn5PLl7pqldl+ssNRDej8Mn6lD6
 qQo+4NkF3rKlFb4ZoDCpq+4S3PoxvD1hvjKbdukQtvx1xZzsAVL1hexsF/6jlS92TEyn dQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qp2e98snd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 11:55:53 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34JBtq7p019573
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 11:55:52 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 19 May
 2023 04:55:48 -0700
Message-ID: <90b5da52-ce60-e225-88d5-4f171082c4da@quicinc.com>
Date:   Fri, 19 May 2023 17:25:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/4] arm: dts: qcom: qdu1000: Add SDHCI node
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20230519085122.15758-1-quic_kbajaj@quicinc.com>
 <20230519085122.15758-3-quic_kbajaj@quicinc.com>
 <7cf74a2b-21e3-4a0d-5791-d7d97e21cf30@linaro.org>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <7cf74a2b-21e3-4a0d-5791-d7d97e21cf30@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YW8eLFK9-LPfJtk8JYd9X8Hol1MeyT6d
X-Proofpoint-ORIG-GUID: YW8eLFK9-LPfJtk8JYd9X8Hol1MeyT6d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_08,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190101
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/2023 3:35 PM, Bhupesh Sharma wrote:
> Hi Komal,
>
> On 5/19/23 2:21 PM, Komal Bajaj wrote:
>> Add sdhc node for eMMC on QDU1000 and QRU1000 SoCs.
>>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qdu1000.dtsi | 60 +++++++++++++++++++++++++++
>>   1 file changed, 60 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi 
>> b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> index 734438113bba..6113def66a08 100644
>> --- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> @@ -19,6 +19,10 @@
>>
>>       chosen: chosen { };
>>
>> +    aliases {
>> +        mmc0 = &sdhc_1; /*SDC1 eMMC slot*/
>
> Please use the right comment formats /* text */
> Also, just /* eMMC */ would be fine here.
Sure, will keep just /* eMMC */ in comments.
>
>> +    };
>> +
>>       cpus {
>>           #address-cells = <2>;
>>           #size-cells = <0>;
>> @@ -842,6 +846,62 @@
>>               #hwlock-cells = <1>;
>>           };
>>
>> +        sdhc_1: mmc@8804000 {
>> +            compatible = "qcom,qdu1000-sdhci", "qcom,sdhci-msm-v5";
>> +            reg = <0x0 0x08804000 0x0 0x1000>,
>> +                  <0x0 0x08805000 0x0 0x1000>;
>> +
>> +            reg-names = "hc", "cqhci";
>> +
>> +            interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
>> +            interrupt-names = "hc_irq", "pwr_irq";
>> +
>> +            clocks = <&gcc GCC_SDCC5_AHB_CLK>,
>> +                 <&gcc GCC_SDCC5_APPS_CLK>,
>> +                 <&rpmhcc RPMH_CXO_CLK>;
>> +            clock-names = "iface", "core", "xo";
>> +
>> +            /* Add dt entry for gcc hw reset */
>
> Please drop the comment above - it's not needed.
Noted. Will remove it in the next patch set.
>
>> +            resets = <&gcc GCC_SDCC5_BCR>;
>> +
>> +            interconnects = <&system_noc MASTER_SDCC_1 0 &mc_virt 
>> SLAVE_EBI1 0>,
>> +                    <&gem_noc MASTER_APPSS_PROC 0 &system_noc 
>> SLAVE_SDCC_2 0>;
>> +            interconnect-names = "sdhc-ddr", "cpu-sdhc";
>> +            power-domains = <&rpmhpd QDU1000_CX>;
>> +            operating-points-v2 = <&sdhc1_opp_table>;
>> +
>> +            iommus = <&apps_smmu 0x0080 0x0>;
>> +            dma-coherent;
>> +
>> +            bus-width = <8>;
>> +            non-removable;
>> +            supports-cqe;
>> +
>> +            no-sd;
>> +            no-sd;
>
> Can we club the following 3 together:
> non-removable;
> no-sd;
> no-sd;
>
> And normally these is a part of board file (.dts), right?
Sure, will move these to board file.

Thanks
Komal
>
> Thanks,
> Bhupesh
>
>> +            mmc-ddr-1_8v;
>> +            mmc-hs200-1_8v;
>> +            mmc-hs400-1_8v;
>> +            mmc-hs400-enhanced-strobe;
>> +            cap-mmc-hw-reset;
>> +
>> +            qcom,dll-config = <0x0007642c>;
>> +            qcom,ddr-config = <0x80040868>;
>> +
>> +            status = "disabled";
>> +
>> +            sdhc1_opp_table: opp-table {
>> +                compatible = "operating-points-v2";
>> +
>> +                opp-384000000 {
>> +                    opp-hz = /bits/ 64 <384000000>;
>> +                    required-opps = <&rpmhpd_opp_min_svs>;
>> +                };
>> +            };
>> +        };
>> +
>>           pdc: interrupt-controller@b220000 {
>>               compatible = "qcom,qdu1000-pdc", "qcom,pdc";
>>               reg = <0x0 0xb220000 0x0 0x30000>, <0x0 0x174000f0 0x0 
>> 0x64>;
>> -- 
>> 2.17.1
>>

