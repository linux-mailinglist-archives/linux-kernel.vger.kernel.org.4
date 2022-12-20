Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B92E6520ED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiLTMq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbiLTMpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:45:50 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3131ADBB;
        Tue, 20 Dec 2022 04:44:28 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BK5o4sm025544;
        Tue, 20 Dec 2022 12:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FSMWxgDKQMOwzgSTST9Pgtght97hr5rsVLQw5XJgBGw=;
 b=C65nCko23dGsGy7Gn0RmtJ+/8VlyxniNowVYZmh02Hmkvwwe0Ud6Te4j1pzu3RChgdWS
 ydYxcLb6/zJzvxjY1hChvMHvQtMckTr+SBFOImjd6e0fbAAO6uLkLL4qL3hNr3DqNfdX
 H435bivCqX6aUc1+TJRDOiVQ/IhnyOGEKV7gGQI7GsIVlnlQLW5Rt9tMUBUlshTYVVJp
 9XcCtrDUBOCMZTt4ztZKMO/4ONy73y2ozKwARJDpSp6BHRSNoZeCl0Ay7pfXMyhv6wn7
 wIMCaf57K1rXXzz8jjcbMfewBlQ5V2J4hdFrd8vdTY3PbAusvIiOUGZzgkj3kDsQMnzo hA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mjkwqu24b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Dec 2022 12:44:23 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BKCiNC1003745
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Dec 2022 12:44:23 GMT
Received: from [10.206.12.35] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 20 Dec
 2022 04:44:19 -0800
Message-ID: <e49c2cec-56fd-a71e-0568-c56df3df4cbe@quicinc.com>
Date:   Tue, 20 Dec 2022 18:14:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom: sa8540p-ride: add i2c nodes
To:     Brian Masney <bmasney@redhat.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <johan+linaro@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ahalaney@redhat.com>, <echanude@redhat.com>
References: <20221214171145.2913557-1-bmasney@redhat.com>
 <20221214171145.2913557-7-bmasney@redhat.com>
Content-Language: en-US
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
In-Reply-To: <20221214171145.2913557-7-bmasney@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1cIIONfOkY1yuyXez2zIG4x9M_KwyjCF
X-Proofpoint-ORIG-GUID: 1cIIONfOkY1yuyXez2zIG4x9M_KwyjCF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-20_05,2022-12-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212200105
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/2022 10:41 PM, Brian Masney wrote:
> Add the necessary nodes in order to get i2c0, i2c1, i2c12, i2c15, and
> i2c18 functioning on the automotive board and exposed to userspace.
> 
> This work was derived from various patches that Qualcomm delivered
> to Red Hat in a downstream kernel. This change was validated by using
> i2c-tools 4.3.3 on CentOS Stream 9:
> 
> [root@localhost ~]# i2cdetect -l
> i2c-0  i2c             Geni-I2C                                I2C adapter
> i2c-1  i2c             Geni-I2C                                I2C adapter
> i2c-12 i2c             Geni-I2C                                I2C adapter
> i2c-15 i2c             Geni-I2C                                I2C adapter
> i2c-18 i2c             Geni-I2C                                I2C adapter
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
> Signed-off-by: Brian Masney <bmasney@redhat.com>

Tested-by: Shazad Hussain <quic_shazhuss@quicinc.com>

Verified on next-20221220.

> ---
> Changes since v1:
> - Dropped qupX_ prefix from labels. (Johan)
> - Reordered nodes based on new name.
> - Added i2c buses 0, 1, and 12 (Shazad)
> - Drop mux/config-pins and have the pin properties live directly
>    under the i2cX-default-state node. (Konrad)
> - Use decimal notation for drive strength (Johan)
> 
> A few things to note with this series applied on top of linux-next:
> - Reading from i2c-0 using 'i2cdetect -y -a 0' gives the following error
>    when reading from the ranges 0x30-0x37 and 0x50-0x5F.
>        geni_i2c 980000.i2c: Timeout abort_m_cmd > - i2c-1 and i2c-2 successfully read using i2cdetect, however it takes
>    several seconds.

expected, as no slaves are connected.

> - i2cdetect runs fast within a small fraction of a second for i2c-15
>    and i2c18.

slaves have ack on addr:0x18 ret:1 for i2c-15 and addr:0x6a ret:1 for i2c-18

> - 'i2cdetect -y -a $BUSNUM' shows the same address ranges 0x30-0x37
>    and 0x50-0x5F in use on all 5 buses.
> 
>   arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 83 +++++++++++++++++++++++
>   1 file changed, 83 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> index b6e0db5508c7..ccd2ea3c9d04 100644
> --- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> @@ -17,6 +17,11 @@ / {
>   	compatible = "qcom,sa8540p-ride", "qcom,sa8540p";
>   
>   	aliases {
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +		i2c12 = &i2c12;
> +		i2c15 = &i2c15;
> +		i2c18 = &i2c18;
>   		serial0 = &uart17;
>   	};
>   
> @@ -146,6 +151,41 @@ vreg_l8g: ldo8 {
>   	};
>   };
>   
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_default>;
> +
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_default>;
> +
> +	status = "okay";
> +};
> +
> +&i2c12 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c12_default>;
> +
> +	status = "okay";
> +};
> +
> +&i2c15 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c15_default>;
> +
> +	status = "okay";
> +};
> +
> +&i2c18 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c18_default>;
> +
> +	status = "okay";
> +};
> +
>   &pcie2a {
>   	ranges = <0x01000000 0x0 0x3c200000 0x0 0x3c200000 0x0 0x100000>,
>   		 <0x02000000 0x0 0x3c300000 0x0 0x3c300000 0x0 0x1d00000>,
> @@ -188,6 +228,14 @@ &pcie3a_phy {
>   	status = "okay";
>   };
>   
> +&qup0 {
> +	status = "okay";
> +};
> +
> +&qup1 {
> +	status = "okay";
> +};
> +
>   &qup2 {
>   	status = "okay";
>   };
> @@ -268,6 +316,41 @@ &xo_board_clk {
>   /* PINCTRL */
>   
>   &tlmm {
> +	i2c0_default: i2c0-default-state {
> +		pins = "gpio135", "gpio136";
> +		function = "qup15";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +
> +	i2c1_default: i2c1-default-state {
> +		pins = "gpio158", "gpio159";
> +		function = "qup15";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +
> +	i2c12_default: i2c12-default-state {
> +		pins = "gpio0", "gpio1";
> +		function = "qup15";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +
> +	i2c15_default: i2c15-default-state {
> +		pins = "gpio36", "gpio37";
> +		function = "qup15";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +
> +	i2c18_default: i2c18-default-state {
> +		pins = "gpio66", "gpio67";
> +		function = "qup18";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +
>   	pcie2a_default: pcie2a-default-state {
>   		perst-pins {
>   			pins = "gpio143";
