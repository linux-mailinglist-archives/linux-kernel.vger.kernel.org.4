Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D90770B5DF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjEVHGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjEVHGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:06:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F732698;
        Mon, 22 May 2023 00:02:54 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M5u1n7020749;
        Mon, 22 May 2023 07:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=72qg8PTgfaStonrGFU93wDu5peymBU0a+rgvFqPO01w=;
 b=kGimFEvKsvAp85h7N1bufQQ5rQat24hn85chXSweQjGOAdNCB5JxhFISGoox29NqofVM
 L+sugRYehHzUB9Q9p+35UOHbpAVI7tAnag8JrfQm9ieD0yUWkBatfiOrD/OTCJnYVsCu
 7JM0APglh7o1l2OFsS/nRB37pJuyD8FjPDEKNuWpFOSWge9aewxU1kMIlxkim+oV6d2g
 wOcXX2JlaAR0XNXmRbU6i8mh/0l7OPyVBDkZLWCwjhMdJSvSn4om6/2JkqXIdyj2wNl4
 Iu9/AeMwr1ARuXg/BJNbo0+K1Ub96oQGcD5r1h0u7rDn1k9/clEUmpkoueqGWnJme6Xo KQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qpkwmu273-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 07:02:24 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34M72Ne1020682
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 07:02:23 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 22 May
 2023 00:02:19 -0700
Message-ID: <fb8f0d17-555d-d74f-8fe0-1e5da8b3feb9@quicinc.com>
Date:   Mon, 22 May 2023 12:32:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/4] arm: dts: qcom: qdu1000: Add SDHCI node
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20230519085122.15758-1-quic_kbajaj@quicinc.com>
 <20230519085122.15758-3-quic_kbajaj@quicinc.com>
 <d606960d-8e0a-611b-579c-c49b5b970462@linaro.org>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <d606960d-8e0a-611b-579c-c49b5b970462@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FNU-zoXa3NGNzW639p62aNK8o50TKvmP
X-Proofpoint-ORIG-GUID: FNU-zoXa3NGNzW639p62aNK8o50TKvmP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 spamscore=0 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220059
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/20/2023 4:53 PM, Konrad Dybcio wrote:
>
> On 19.05.2023 10:51, Komal Bajaj wrote:
>> Add sdhc node for eMMC on QDU1000 and QRU1000 SoCs.
>>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qdu1000.dtsi | 60 +++++++++++++++++++++++++++
>>   1 file changed, 60 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> index 734438113bba..6113def66a08 100644
>> --- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>> @@ -19,6 +19,10 @@
>>
>>   	chosen: chosen { };
>>
>> +	aliases {
>> +		mmc0 = &sdhc_1; /*SDC1 eMMC slot*/
>> +	};
>> +
>>   	cpus {
>>   		#address-cells = <2>;
>>   		#size-cells = <0>;
>> @@ -842,6 +846,62 @@
>>   			#hwlock-cells = <1>;
>>   		};
>>
>> +		sdhc_1: mmc@8804000 {
>> +			compatible = "qcom,qdu1000-sdhci", "qcom,sdhci-msm-v5";
>> +			reg = <0x0 0x08804000 0x0 0x1000>,
>> +			      <0x0 0x08805000 0x0 0x1000>;
>> +
> confusing newline
Will remove it in the next patch set.
>> +			reg-names = "hc", "cqhci";
>> +
>> +			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "hc_irq", "pwr_irq";
>> +
>> +			clocks = <&gcc GCC_SDCC5_AHB_CLK>,
>> +				 <&gcc GCC_SDCC5_APPS_CLK>,
> SDCC>5<?
These names are used in accordance with the clock hardware.
>
>> +				 <&rpmhcc RPMH_CXO_CLK>;
>> +			clock-names = "iface", "core", "xo";
> Please keep one per line
Noted.
>
>> +
>> +			/* Add dt entry for gcc hw reset */
>> +			resets = <&gcc GCC_SDCC5_BCR>;
> 5?
Reason same as above.
>
>> +
>> +			interconnects = <&system_noc MASTER_SDCC_1 0 &mc_virt SLAVE_EBI1 0>,
>> +					<&gem_noc MASTER_APPSS_PROC 0 &system_noc SLAVE_SDCC_2 0>;
>> +			interconnect-names = "sdhc-ddr", "cpu-sdhc";
>> +			power-domains = <&rpmhpd QDU1000_CX>;
>> +			operating-points-v2 = <&sdhc1_opp_table>;
>> +
>> +			iommus = <&apps_smmu 0x0080 0x0>;
> Please remove the leading zeroes from the stream id
Sure, will do so.
>
>
>> +			dma-coherent;
>> +
>> +			bus-width = <8>;
>
> ----
>> +			non-removable;
>> +			supports-cqe;
>> +
>> +			no-sd;
>> +			no-sdio;
>> +
>> +			mmc-ddr-1_8v;
>> +			mmc-hs200-1_8v;
>> +			mmc-hs400-1_8v;
>> +			mmc-hs400-enhanced-strobe;
>> +			cap-mmc-hw-reset;
> ----
> This bit is board-specific
Okay, will move these bits to board specific file.
>
>> +
>> +			qcom,dll-config = <0x0007642c>;
>> +			qcom,ddr-config = <0x80040868>;
>> +
>> +			status = "disabled";
>> +
>> +			sdhc1_opp_table: opp-table {
>> +				compatible = "operating-points-v2";
>> +
>> +				opp-384000000 {
>> +					opp-hz = /bits/ 64 <384000000>;
>> +					required-opps = <&rpmhpd_opp_min_svs>;
> You added interconnects, but not any opp-peak-kBps / opp-avg-kBps,
> presumably mistakengly?
>
> Also, 384Mhz + min_svs sounds a bit weird? Is that the correct
> level for this SoC?
Yes, you are right, this is wrong configuration, will correct it in the 
next patch set.

Thanks
Komal
>
> Konrad
>> +				};
>> +			};
>> +		};
>> +
>>   		pdc: interrupt-controller@b220000 {
>>   			compatible = "qcom,qdu1000-pdc", "qcom,pdc";
>>   			reg = <0x0 0xb220000 0x0 0x30000>, <0x0 0x174000f0 0x0 0x64>;
>> --
>> 2.17.1
>>

