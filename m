Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6456B349A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 04:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjCJDO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 22:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjCJDOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 22:14:40 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFB1F28A9;
        Thu,  9 Mar 2023 19:14:39 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32A14npV001842;
        Fri, 10 Mar 2023 03:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=xQWrPAxRSV+EGW99i7tiOci4rzdoO4Igctk2XbVM/Ho=;
 b=IEv5PD8y6p3id78kUUNoaq36Xc25fLOn///gHbrztdpopP48fAbJDgviRvK5eK7iMwxz
 B8ag3+aiVg7CxCDFAwh72/yelZAKEwJUYQJjD9MVEqD75e31NI67lS9y4RFg7gRdo/tp
 O026C/sYT6Do/Y0oV/QpUm4HHaNKCd0WJGTpcjvriJ/oMsySKveki8KVgTmhW7xs1liG
 NdvIuZoNzkr6sVf6TsUY80CdJYfyH9XIsJhr+scjVmqxG6JWfGx5BtutUcXsmKuvl7fQ
 KooYX6DLrN2MIvJJsMNbE6uMEncpF/6Wmd4DC0Oy00KJFhnheQypY8c5c8YYI+O2taqi cg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p7q0y0s5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 03:14:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32A3EXY9002855
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 03:14:33 GMT
Received: from [10.79.43.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 9 Mar 2023
 19:14:27 -0800
Message-ID: <139384c3-5ebc-84b6-9109-b98e4690ca68@quicinc.com>
Date:   Fri, 10 Mar 2023 08:44:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 09/15] arm64: dts: qcom: sm6375: Add CPUCP L3 node
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230303-topic-sm6375_features0_dts-v1-0-8c8d94fba6f0@linaro.org>
 <20230303-topic-sm6375_features0_dts-v1-9-8c8d94fba6f0@linaro.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20230303-topic-sm6375_features0_dts-v1-9-8c8d94fba6f0@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: N5LoSnEg8LgJ9YUzq6wC_c2TlhTQEy_t
X-Proofpoint-ORIG-GUID: N5LoSnEg8LgJ9YUzq6wC_c2TlhTQEy_t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_14,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303100022
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Konrad,

Thanks for the patch.

On 3/4/23 03:28, Konrad Dybcio wrote:
> Enable the CPUCP block responsible for scaling the L3 cache.

FWIW, the patch just enables the l3 provider, the CPUCP block would
already be up at this point. You would also want to include the
expansion for CPUCP at least once in your patch.

> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>

> ---
>   arch/arm64/boot/dts/qcom/sm6375.dtsi | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
> index 90f18754a63b..59d7ed25aa36 100644
> --- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
> @@ -1505,6 +1505,15 @@ frame@f42d000 {
>   			};
>   		};
>   
> +		cpucp_l3: interconnect@fd90000 {
> +			compatible = "qcom,sm6375-cpucp-l3", "qcom,epss-l3";
> +			reg = <0 0x0fd90000 0 0x1000>;
> +
> +			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>, <&gcc GPLL0>;
> +			clock-names = "xo", "alternate";
> +			#interconnect-cells = <1>;
> +		};
> +
>   		cpufreq_hw: cpufreq@fd91000 {
>   			compatible = "qcom,sm6375-cpufreq-epss", "qcom,cpufreq-epss";
>   			reg = <0 0x0fd91000 0 0x1000>, <0 0x0fd92000 0 0x1000>;
> 
