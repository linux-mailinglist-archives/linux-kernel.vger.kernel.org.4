Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558C6707A5F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 08:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjERGtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 02:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjERGtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 02:49:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552AE2122;
        Wed, 17 May 2023 23:49:13 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34I6a5vp009104;
        Thu, 18 May 2023 06:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GdRg7Y9j4xrW11AwJfAZpy43hBuEn4tHcz/Itw1Jsto=;
 b=C/3Hc9KooNQVYypd4dGPnoFzkfHYGQfxYozTGBt81F/OttJxFDyTYMl9J9TC8yeebT6J
 iMzoU2zCjhIEeF9T4moV2EXFPAqeCcbVBJD1AJWVu7eRbTIl/E0Gm8Tsv90uydi6NXLq
 KsFXdcQLMjD5+Ge2YhIEV/SMqmFSMSDoWBL8FpVwJjthGSdjQxjp79TJbL3MT3QUWyLP
 paTLU8u/3wvwhbFsRiOLRKU0CGjQL883HlnpW0JpBzvJb9truum8hbLzqcCqGHNE7cYM
 4Qq3f58aS78LpjAGkO0AH+7rCGkJspL9PyhRPkHEjkr8F6z9Ym3710je9jeILeq8vpVl +Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qncbhr91a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 06:48:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34I6mpqZ028262
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 06:48:51 GMT
Received: from [10.216.51.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 17 May
 2023 23:48:43 -0700
Message-ID: <0374e88f-5b12-271a-41f0-32a31fbecbec@quicinc.com>
Date:   Thu, 18 May 2023 12:18:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V6 7/8] arm64: dts: Add ipq5018 SoC and rdp432-c2 board
 support
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <robimarko@gmail.com>,
        <andy.shevchenko@gmail.com>
References: <20230516165413.3361867-1-quic_srichara@quicinc.com>
 <20230516165413.3361867-8-quic_srichara@quicinc.com>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <20230516165413.3361867-8-quic_srichara@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3seELNgdxH5fZtduLxDlSRu1sBZ8GeU0
X-Proofpoint-ORIG-GUID: 3seELNgdxH5fZtduLxDlSRu1sBZ8GeU0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305180050
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/16/2023 10:24 PM, Sricharan Ramabadhran wrote:
> Add initial device tree support for the Qualcomm IPQ5018 SoC and
> rdp432-c2 board.
>
> Few things like 'reboot' does not work because, couple of more 'SCM'
> APIS are needed to clear some TrustZone settings. Those will be
> posted separately.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Co-developed-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
> Signed-off-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>    [v6] Added Reviewed by and fixed commit log as per comments from
>         robimarko@gmail.com
>
>   arch/arm64/boot/dts/qcom/Makefile             |   1 +
>   .../arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts |  72 +++++
>   arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 250 ++++++++++++++++++
>   3 files changed, 323 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
>   create mode 100644 arch/arm64/boot/dts/qcom/ipq5018.dtsi
>
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index d42c59572ace..57858e7f2095 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -3,6 +3,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-rdp432-c2.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-mi01.2.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp468.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq6018-cp01-c1.dtb
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
> new file mode 100644
> index 000000000000..e636a1cb9b77
> --- /dev/null


<snip>


> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		tz_region: tz@4ac00000 {
> +			reg = <0x0 0x4ac00000 0x0 0x400000>;


TZ size is 2MB not 4MB.

<snip>...

Thanks

