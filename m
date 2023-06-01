Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6707193A9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjFAG5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjFAG5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 02:57:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DF4E7;
        Wed, 31 May 2023 23:57:14 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3515NU20007383;
        Thu, 1 Jun 2023 06:57:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Wi2WrqyhvQwK/NvSOq4/96nE5ftnyDJtskZxS3w7MUQ=;
 b=p879SifeoZK006GZ1D3kPoycEY/OuD6+QWOHflNYV8Zd7QGbWufM7duL+jsqdn0M0tw3
 5/1y/YG03+Chtl5KznQtKa9BhmMiMAJntrmdAPLN4FVFlWgqNOZjVamXiQS5AabXoLzF
 f+qnOOHZTnCHN3fUtLgI9zGATWN2x5wxHXPls0HN8k1pKGV2x8asarEQUL4MQF/LBxmH
 DoP0LKrT7AWNgUG98IwaXIFQEeQeKtcuNIs4MXqGYWIBQAPA7X9lr/Dhj3RVF4kGgZOT
 RIPahfUQAopWCFwJRzJWGo0XPhKl9duasej5T0w/Ssr0ZPK5KMY2hogXNdpUE+VXRbtQ eg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxdr98yu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 06:57:09 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3516v8SZ012159
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 06:57:08 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 31 May
 2023 23:57:04 -0700
Message-ID: <1912c75a-113b-01ad-8678-9ed941a1d8a9@quicinc.com>
Date:   Thu, 1 Jun 2023 12:27:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 4/4] arm64: dts: qcom: qdu1000-idp: add SDHCI for emmc
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
References: <20230523135733.3852-1-quic_kbajaj@quicinc.com>
 <20230523135733.3852-5-quic_kbajaj@quicinc.com>
 <76513a6b-a8c1-0bc3-a094-2cce1aa8ef87@linaro.org>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <76513a6b-a8c1-0bc3-a094-2cce1aa8ef87@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NiJ4zfVPxk7gfvsTvx4167SvGSR7s8B2
X-Proofpoint-GUID: NiJ4zfVPxk7gfvsTvx4167SvGSR7s8B2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_04,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306010061
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/27/2023 4:52 AM, Konrad Dybcio wrote:
>
> On 23.05.2023 15:57, Komal Bajaj wrote:
>> Add sdhci node for emmc in qdu1000-idp.
>>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>> index 9e9fd4b8023e..6e988e90aa50 100644
>> --- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>> @@ -448,6 +448,29 @@
>>   	status = "okay";
>>   };
>>
>> +&sdhc {
>> +	pinctrl-names = "default", "sleep";
>> +	pinctrl-0 = <&sdc_on_state>;
>> +	pinctrl-1 = <&sdc_off_state>;
> Please do
>
> property-n
> property-names
>
> we've had a little bit of a mess over the years but we're trying
> to unify that.
Sure, will change in the next patch set.

Thanks
Komal
>
> With that:
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>
> Konrad
>> +
>> +	cap-mmc-hw-reset;
>> +	mmc-ddr-1_8v;
>> +	mmc-hs200-1_8v;
>> +	mmc-hs400-1_8v;
>> +	mmc-hs400-enhanced-strobe;
>> +
>> +	non-removable;
>> +	no-sd;
>> +	no-sdio;
>> +
>> +	supports-cqe;
>> +
>> +	vmmc-supply = <&vreg_l10a_2p95>;
>> +	vqmmc-supply = <&vreg_l7a_1p8>;
>> +
>> +	status = "okay";
>> +};
>> +
>>   &uart7 {
>>   	status = "okay";
>>   };
>> --
>> 2.17.1
>>

