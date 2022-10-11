Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA675FBCA9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 23:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJKVJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 17:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJKVJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 17:09:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE55D82D0E;
        Tue, 11 Oct 2022 14:09:13 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29BHRt91022976;
        Tue, 11 Oct 2022 21:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4TvZPf6k88ue2C+96q4x+1wNgC7chOfsmMecVzr037k=;
 b=XmkkTl7Mh9cbuOdNCmihHp/YlqFiWqIMr7zrygXyIavCZxFsY5015gZ6ByCEAX5wo+dl
 8/1+GeipOUeRkceob3DtPhGOev61rXYEu1nfLfs2ljuMV6Q76JgRB+N/74SXrReqlisd
 aXdSZs+jdxv6GRyVm5Z8/ch1/dW9GcZdyMmvw/OlexEilrdAT6GNXYOyv29anmIYMvcK
 rJcMJvpoEZIzP4VoX0RoM1Q3FuGGBE7Zow8L7Fq1QfLAgNTxQ8NDUjkixu+f4GSquJpz
 d5f3dA8iDexIu5GR9jTpwmPboHqSp7Xy+uA5OsImbkG+QNpHOSGiUxp98M4Kdbq4+pMO pA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k4rx1c6e9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 21:09:10 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29BL8egc011161
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 21:08:40 GMT
Received: from [10.110.3.66] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 11 Oct
 2022 14:08:40 -0700
Message-ID: <fd331b99-7e27-d562-26a7-b3c7ae07a5c6@quicinc.com>
Date:   Tue, 11 Oct 2022 14:08:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 08/19] arm64: dts: qcom: qru1000-idp: Add RPMH regulators
 nodes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221001030656.29365-1-quic_molvera@quicinc.com>
 <20221001030656.29365-9-quic_molvera@quicinc.com>
 <85d9efd8-41b2-f726-feb7-d934bde2c66a@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <85d9efd8-41b2-f726-feb7-d934bde2c66a@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: G0bLb1txylOrEUajbl4i4dqkrZKdnxTJ
X-Proofpoint-GUID: G0bLb1txylOrEUajbl4i4dqkrZKdnxTJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_08,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxlogscore=939 clxscore=1015 impostorscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210110122
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/1/2022 2:15 AM, Krzysztof Kozlowski wrote:
> On 01/10/2022 05:06, Melody Olvera wrote:
>> Add RPMH regulators for the QRU1000 IDP platform.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/qru1000-idp.dts | 200 +++++++++++++++++++++++
>>  1 file changed, 200 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qru1000-idp.dts b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
>> index ddb4ea17f7d2..8d27923dc470 100644
>> --- a/arch/arm64/boot/dts/qcom/qru1000-idp.dts
>> +++ b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
>> @@ -5,6 +5,7 @@
>>  
>>  /dts-v1/;
>>  
>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>  #include "qru1000.dtsi"
>>  
>>  / {
>> @@ -19,6 +20,205 @@ aliases {
>>  	chosen {
>>  		stdout-path = "serial0:115200n8";
>>  	};
>> +
>> +	ppvar_sys: ppvar-sys-regulator {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "ppvar_sys";
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +	};
>> +
>> +	vph_pwr: vph-pwr-regulator {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vph_pwr";
>> +		regulator-min-microvolt = <3700000>;
>> +		regulator-max-microvolt = <3700000>;
>> +
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +
>> +		vin-supply = <&ppvar_sys>;
>> +	};
>> +};
>> +
>> +&apps_rsc {
>> +	pm8150-rpmh-regulators {
> regulators
Will Fix.
>
> Best regards,
> Krzysztof
>
Thanks,
Melody
