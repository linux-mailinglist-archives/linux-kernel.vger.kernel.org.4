Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773CF64B050
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 08:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbiLMHTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 02:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbiLMHTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 02:19:05 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6254610050;
        Mon, 12 Dec 2022 23:19:04 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD29wAh027003;
        Tue, 13 Dec 2022 07:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6qGTJOWPaIZECVkkJTVgj51Er97rmWLBc69TPGqYejk=;
 b=gxNgwfUlIOP8DEtkxRVZPF/uZ0ugV/KpK/E0lchRl9l3xqg/j1ak2/qysHDqZfbVVekM
 x3MesMUUrVyss5xEcEP50EU780FgAnPleT566GFjUNHe2Mp9awId8+c5X+omup2+0X1d
 Nhy+nkveDuVKLYG3ir5cjr7llIVyYtdvSwA+32jWYoc9iI4Hp79BMv3c8CVCZyjEwiAM
 CByqeo6amzd4JQUi4lGpS8eKO9mqCO5rAgkng/W0bIDkn9Y6PRIsEemOKzOV3wR26ZnW
 dW/iwMbqzntU/RFLRwjj6qNPgjH5kl10Ffcq9225HtZW3VniSfcmGEZkfNqyuYptsa6I JQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3megc5rr8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 07:18:59 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BD7IuBT017871
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 07:18:56 GMT
Received: from [10.252.221.242] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 12 Dec
 2022 23:18:52 -0800
Message-ID: <4891c42a-c320-4316-7eac-4e8d33bad5c0@quicinc.com>
Date:   Tue, 13 Dec 2022 12:48:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sa8540p-ride: add qup1_i2c15 and
 qup2_i2c18 nodes
Content-Language: en-US
To:     Brian Masney <bmasney@redhat.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <johan+linaro@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ahalaney@redhat.com>, <echanude@redhat.com>
References: <20221212182314.1902632-1-bmasney@redhat.com>
 <20221212182314.1902632-4-bmasney@redhat.com>
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
In-Reply-To: <20221212182314.1902632-4-bmasney@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yWpnZGVNeUbZLRKI2FzrQHluWfZ32o11
X-Proofpoint-GUID: yWpnZGVNeUbZLRKI2FzrQHluWfZ32o11
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212130066
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/2022 11:53 PM, Brian Masney wrote:
> Add the necessary nodes in order to get qup1_i2c15 and qup2_i2c18
> functioning on the automotive board and exposed to userspace.
> 
> This work was derived from various patches that Qualcomm delivered
> to Red Hat in a downstream kernel. This change was validated by using
> i2c-tools 4.3.3 on CentOS Stream 9:
> 
> [root@localhost ~]# i2cdetect -l
> i2c-15  i2c             Geni-I2C                                I2C adapter
> i2c-18  i2c             Geni-I2C                                I2C adapter
> 
> [root@localhost ~]# i2cdetect -a -y 15
> Warning: Can't use SMBus Quick Write command, will skip some addresses
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:
> 10:
> 20:
> 30: -- -- -- -- -- -- -- --
> 40:
> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 60:
> 70:
> 
> Bus 18 has the same output. I validated that we get the same output on
> the downstream kernel.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>   arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 46 +++++++++++++++++++++++
>   1 file changed, 46 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> index d70859803fbd..6dc3f3ff8ece 100644
> --- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> @@ -17,6 +17,8 @@ / {
>   	compatible = "qcom,sa8540p-ride", "qcom,sa8540p";
>   
>   	aliases {
> +		i2c15 = &qup1_i2c15;
> +		i2c18 = &qup2_i2c18;

I was listing out all the i2c devices to be enabled apart from above and 
below are applicable for Qdrive3 as well:
i2c0  980000
i2c1  984000
i2c12 0x00A90000

-Shazad

>   		serial0 = &qup2_uart17;
>   	};
>   
> @@ -188,10 +190,28 @@ &pcie3a_phy {
>   	status = "okay";
>   };
>   
> +&qup1 {
> +	status = "okay";
> +};
> +
> +&qup1_i2c15 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&qup1_i2c15_default>;
> +
> +	status = "okay";
> +};
> +
>   &qup2 {
>   	status = "okay";
>   };
>   
> +&qup2_i2c18 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&qup2_i2c18_default>;
> +
> +	status = "okay";
> +};
> +
>   &qup2_uart17 {
>   	compatible = "qcom,geni-debug-uart";
>   	status = "okay";
> @@ -313,4 +333,30 @@ wake-pins {
>   			bias-pull-up;
>   		};
>   	};
> +
> +	qup1_i2c15_default: qup1-i2c15-state {
> +		mux-pins {
> +			pins = "gpio36", "gpio37";
> +			function = "qup15";
> +		};
> +
> +		config-pins {
> +			pins = "gpio36", "gpio37";
> +			drive-strength = <0x02>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	qup2_i2c18_default: qup2-i2c18-state {
> +		mux-pins {
> +			pins = "gpio66", "gpio67";
> +			function = "qup18";
> +		};
> +
> +		config-pins {
> +			pins = "gpio66", "gpio67";
> +			drive-strength = <0x02>;
> +			bias-pull-up;
> +		};
> +	};
>   };
