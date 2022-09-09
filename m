Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CB55B3816
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiIIMpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiIIMpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:45:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04933ECC3;
        Fri,  9 Sep 2022 05:45:42 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289B976h015111;
        Fri, 9 Sep 2022 12:45:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ar7A4xWY39x5TIOEoGnLC7/u6KWTqMdjPSb48DbJUdM=;
 b=No7oYQ3UXStB8XUQJ+FJhTFKnXAzrEMfzjJNcUjCturF+/8+POUsqx5rao7ueLzgOWC6
 s9amxi7gjsO4ZP/tyf+uhBGlsj8dE2bxy9LSQPq9sGm4OeTCA14sN/pnCAylNt5wACrI
 ooNhcSSZxuGj0P1O+pHcFxEagVTwdBmh+T0dQfTsGLNkKne3DpQXVArLL0BJJ2Rd82hZ
 aJJXqPZL2X7VF4JACx9NzjYAJ6ksA1SUTdjunJfcmpCMZayRUFSFFdi0vM3lwCjxm1Jf
 TxGDy7dn+VJaT+2nS2dQyG/VQZ4HzO4rnLkocFb6eR1SwHYCHF/KeuETkSTki91HXOcu FQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jfuwwanj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 12:45:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 289CjZPK003514
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Sep 2022 12:45:35 GMT
Received: from [10.216.47.92] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 9 Sep 2022
 05:45:31 -0700
Message-ID: <1e89f2c8-1deb-3772-7cb7-52b2e4370a1f@quicinc.com>
Date:   Fri, 9 Sep 2022 18:15:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: correct CPU BWMON unit address
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Stephen Boyd <swboyd@chromium.org>
References: <20220908085830.39141-1-krzysztof.kozlowski@linaro.org>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <20220908085830.39141-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JtOtAhnJUqKxtKr0OrWEE_KPmB7vzdQ8
X-Proofpoint-ORIG-GUID: JtOtAhnJUqKxtKr0OrWEE_KPmB7vzdQ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_07,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1011 bulkscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2209090044
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/2022 2:28 PM, Krzysztof Kozlowski wrote:
> Correct CPU BWMON unit address to match the "reg" property.
> 
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Fixes: b2f3eac1b77c ("arm64: dts: qcom: sc7280: Add cpu and llcc BWMON")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks for catching this,
Acked-by: Rajendra Nayak <quic_rjendra@quicinc.com>

> 
> ---
> 
> Fixes tag for commit in current Bjorn's for-next.
> ---
>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index ad04025a8a1a..a58916009281 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -3328,7 +3328,7 @@ opp-7 {
>   			};
>   		};
>   
> -		pmu@90b6000 {
> +		pmu@90b6400 {
>   			compatible = "qcom,sc7280-cpu-bwmon", "qcom,msm8998-bwmon";
>   			reg = <0 0x090b6400 0 0x600>;
>   
