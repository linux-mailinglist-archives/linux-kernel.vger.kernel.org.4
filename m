Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9646E666D18
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239879AbjALIze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240036AbjALIyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:54:03 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC95E13D71;
        Thu, 12 Jan 2023 00:53:33 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30C8hSQJ021476;
        Thu, 12 Jan 2023 08:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=nKrtavOLzhos4jS7/pjbahWCr89xXgBo8D/j7TgRiZI=;
 b=GGkkbt31UMqG8aE/Goqlfe14Kl4aJvB7OV+JhuEHCURJrPuH51j89rQn/Ir/F8Popsnd
 nPvPIp0+FRSEMZaqyoySmhpCc4sZnuOV8CIA6/KiWe47MO0GFBPARHA1Wy+m7cXD82Vv
 4aLTW5iw+b+ljK4rFJja4QyLRmBop02CNQX8Pi3YzF4nSIXq9hL362iDMvkalyMC5VBh
 UIDWCTCo0VKlmX+WfCnq9K1plqeTHUax5Aeycglt8DJzgHbRWPAN46hW5qkUuNEiVYNo
 sPb4Dhh0HPlm8CxeQYMQi9X9TlSBDxLXrito0L4usUTo2V7MKobmz4cwlvuyNDrzP9na kQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n1kxhkbsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 08:53:25 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30C8rOhO007784
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 08:53:24 GMT
Received: from [10.216.26.66] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 12 Jan
 2023 00:53:21 -0800
Message-ID: <1e891742-dfe5-a6bb-df61-2b72c4badfa1@quicinc.com>
Date:   Thu, 12 Jan 2023 14:23:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm8450: Add TCSR halt register
 space
Content-Language: en-US
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1673513501-29938-1-git-send-email-quic_mojha@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <1673513501-29938-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XYI1DBjpiXlMhGyqI7PjtTtkJdFbMFRF
X-Proofpoint-ORIG-GUID: XYI1DBjpiXlMhGyqI7PjtTtkJdFbMFRF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_04,2023-01-11_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 mlxlogscore=914
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120061
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a mistake, please ignore this patch.
Very sorry for the spam.

-Mukesh
On 1/12/2023 2:21 PM, Mukesh Ojha wrote:
> Add TCSR register space and refer it from scm node, so that
> it can be used by SCM driver.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 5704750..e0fa733 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -270,6 +270,7 @@
>   	firmware {
>   		scm: scm {
>   			compatible = "qcom,scm-sm8450", "qcom,scm";
> +			qcom,dload-mode = <&tcsr 0x13000>;
>   			interconnects = <&aggre2_noc MASTER_CRYPTO 0 &mc_virt SLAVE_EBI1 0>;
>   			#reset-cells = <1>;
>   		};
> @@ -1986,6 +1987,11 @@
>   			#hwlock-cells = <1>;
>   		};
>   
> +		tcsr: syscon@1fc0000 {
> +			compatible = "syscon";
> +			reg = <0x0 0x1fc0000 0x0 0x30000>;
> +		};
> +
>   		usb_1_hsphy: phy@88e3000 {
>   			compatible = "qcom,sm8450-usb-hs-phy",
>   				     "qcom,usb-snps-hs-7nm-phy";
