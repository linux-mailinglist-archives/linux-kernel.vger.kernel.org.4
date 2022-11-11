Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166C662590A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbiKKLD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbiKKLDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:03:25 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC38F21F;
        Fri, 11 Nov 2022 03:03:22 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ABAtA8E017294;
        Fri, 11 Nov 2022 11:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+kDapjqqACohbJuPfP4OnvhVvSwqGQZLrRF43v/RLpc=;
 b=mhi0mSjwirBcH+gzNpDxcsud/GjjsfaIODwWLV2WBPYmGBge1/+zVJPToO9rs6Mp3DrV
 K/4skT5cLl3UKgf6EjMWyp9z+TeIFEoaC07lYeLx3E3EO2h3+bA+b4oGBvflsG59e8tk
 BnLWb9NCSj7rD+lQR1mV/2u1VzUF0w7a79SrurfrIeErepnzQNAtWxJnHuEj6iqGZAF7
 Eok3QucZxtpZQ0oBynPadg22HgtFsj/q3aIHcVnuMozscyJm5d/ofzgdhz7Co2pUMg/6
 evAFKO/nrXjbWVd+UrUxBK99IBNJGV6TjbeQn1CZoRrV9XmdWsyp3CZl5xqH+CbcJB8d BQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ksh98rjcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 11:03:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2ABB3DAp018726
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Nov 2022 11:03:13 GMT
Received: from [10.79.43.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 11 Nov
 2022 03:03:09 -0800
Message-ID: <57298a3b-443b-b49b-c395-e2d6420ad20b@quicinc.com>
Date:   Fri, 11 Nov 2022 16:33:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 10/10] arm64: dts: qcom: sc8280xp: Add bwmon instances
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rob Herring" <robh+dt@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221111032515.3460-1-quic_bjorande@quicinc.com>
 <20221111032515.3460-11-quic_bjorande@quicinc.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20221111032515.3460-11-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gzkRF2C_AY7zrZXj_bI6qJetK2WfAYJy
X-Proofpoint-ORIG-GUID: gzkRF2C_AY7zrZXj_bI6qJetK2WfAYJy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-11_06,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211110073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/22 08:55, Bjorn Andersson wrote:
> Add the two bwmon instances and define votes for CPU -> LLCC and LLCC ->
> DDR, with bandwidth values based on the downstream DeviceTree.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Tested-by: Steev Klimaszewski <steev@kali.org>

Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>

> ---
> 
> Changes since v1:
> - Added "cpu" to compatible for the CPU-subsystem bwmon instance
> 
>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 91 ++++++++++++++++++++++++++
>   1 file changed, 91 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 2ac8f5204905..62e9dd8a2f07 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -1287,6 +1287,97 @@
>   			};
>   		};
>   
> +		pmu@9091000 {
> +			compatible = "qcom,sc8280xp-llcc-bwmon", "qcom,sc7280-llcc-bwmon";
> +			reg = <0 0x9091000 0 0x1000>;
> +
> +			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			interconnects = <&mc_virt MASTER_LLCC 3 &mc_virt SLAVE_EBI1 3>;
> +
> +			operating-points-v2 = <&llcc_bwmon_opp_table>;
> +
> +			llcc_bwmon_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-0 {
> +					opp-peak-kBps = <762000>;
> +				};
> +				opp-1 {
> +					opp-peak-kBps = <1720000>;
> +				};
> +				opp-2 {
> +					opp-peak-kBps = <2086000>;
> +				};
> +				opp-3 {
> +					opp-peak-kBps = <2597000>;
> +				};
> +				opp-4 {
> +					opp-peak-kBps = <2929000>;
> +				};
> +				opp-5 {
> +					opp-peak-kBps = <3879000>;
> +				};
> +				opp-6 {
> +					opp-peak-kBps = <5161000>;
> +				};
> +				opp-7 {
> +					opp-peak-kBps = <5931000>;
> +				};
> +				opp-8 {
> +					opp-peak-kBps = <6515000>;
> +				};
> +				opp-9 {
> +					opp-peak-kBps = <7980000>;
> +				};
> +				opp-10 {
> +					opp-peak-kBps = <8136000>;
> +				};
> +				opp-11 {
> +					opp-peak-kBps = <10437000>;
> +				};
> +				opp-12 {
> +					opp-peak-kBps = <12191000>;
> +				};
> +			};
> +		};
> +
> +		pmu@90b6400 {
> +			compatible = "qcom,sc8280xp-cpu-bwmon", "qcom,msm8998-bwmon";
> +			reg = <0 0x090b6400 0 0x600>;
> +
> +			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			interconnects = <&gem_noc MASTER_APPSS_PROC 3 &gem_noc SLAVE_LLCC 3>;
> +			operating-points-v2 = <&cpu_bwmon_opp_table>;
> +
> +			cpu_bwmon_opp_table: opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-0 {
> +					opp-peak-kBps = <2288000>;
> +				};
> +				opp-1 {
> +					opp-peak-kBps = <4577000>;
> +				};
> +				opp-2 {
> +					opp-peak-kBps = <7110000>;
> +				};
> +				opp-3 {
> +					opp-peak-kBps = <9155000>;
> +				};
> +				opp-4 {
> +					opp-peak-kBps = <12298000>;
> +				};
> +				opp-5 {
> +					opp-peak-kBps = <14236000>;
> +				};
> +				opp-6 {
> +					opp-peak-kBps = <15258001>;
> +				};
> +			};
> +		};
> +
>   		system-cache-controller@9200000 {
>   			compatible = "qcom,sc8280xp-llcc";
>   			reg = <0 0x09200000 0 0x58000>, <0 0x09600000 0 0x58000>;
