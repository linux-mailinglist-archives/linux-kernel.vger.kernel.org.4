Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8448374703A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 13:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjGDL4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 07:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGDL4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 07:56:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D49D10CA;
        Tue,  4 Jul 2023 04:56:30 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 364ALk2U000581;
        Tue, 4 Jul 2023 11:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=trWaaZV2bKzIMHop1+SFTvv6IsksPUMGmEKCtp5IxtU=;
 b=JdrIuW0o3gpUGGggTjbfHCH+QhYs8buD8e/aBB8/GiGZyffdBOpNnZFiP+smWW5/NRnR
 3BiLuOg+Z5zkbmriOTK/wxSswPXJc0e98N8xlV3egxtJyvXmnyr4gpM41mj1NjlHIu4Q
 VUHm88z1Kq38oaWI1WREpJZ2LKgAU0AOS1OHAJ6x2qo/gLSAu9mQN5R+C2Co9Q0yd5iE
 9UPgM6Wb3ihfOUCl3u/36qINJ1MQ1EGZuDlw6MrB8WYfYy3LU/8aMX3DexRACGHVsLKE
 L6ZagblXNyVUAOBh9nwvEaoGfzaC0uWEDN0D5E3lnF1UpEt3pWpedSGf8gmt98Vu6a9v Iw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rkyrra7g6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jul 2023 11:56:26 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 364BuP0I016728
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Jul 2023 11:56:25 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Tue, 4 Jul 2023
 04:56:22 -0700
Message-ID: <422ffe93-e390-7379-70ad-e56f73e1da44@quicinc.com>
Date:   Tue, 4 Jul 2023 17:26:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] arm64: dts: qcom: qdu1000: Add reserved gpio list
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230704102224.25052-1-quic_kbajaj@quicinc.com>
 <1c6bebd3-6799-5df5-fa46-25e1b7cfd60a@linaro.org>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <1c6bebd3-6799-5df5-fa46-25e1b7cfd60a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RJdJA10erTQzlfbmwrBv1t8265sYTek3
X-Proofpoint-ORIG-GUID: RJdJA10erTQzlfbmwrBv1t8265sYTek3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_06,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0
 mlxlogscore=702 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040101
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/4/2023 4:38 PM, Konrad Dybcio wrote:
> On 4.07.2023 12:22, Komal Bajaj wrote:
>> Add reserved gpio list for QDU1000 and QRU1000 SoCs
>> which will not be used by HLOS.
>>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
> Generally such changes to board files are split into per-board
> commits.

Sure, will split into per-board commits.

>
> Can you explain why these GPIOs will be inaccessible? Some secure
> I2C peripheral, I'd guess?

These GPIOs are needed by Modem subsystem.

Thanks
Komal

>
> Konrad
>>   arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 4 ++++
>>   arch/arm64/boot/dts/qcom/qru1000-idp.dts | 4 ++++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>> index 1d22f87fd238..0496e87ddfd5 100644
>> --- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>> @@ -471,6 +471,10 @@ &sdhc {
>>   	status = "okay";
>>   };
>>   
>> +&tlmm {
>> +	gpio-reserved-ranges = <28 2>;
>> +};
>> +
>>   &uart7 {
>>   	status = "okay";
>>   };
>> diff --git a/arch/arm64/boot/dts/qcom/qru1000-idp.dts b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
>> index 2cc893ae4d10..80dadd2f30a3 100644
>> --- a/arch/arm64/boot/dts/qcom/qru1000-idp.dts
>> +++ b/arch/arm64/boot/dts/qcom/qru1000-idp.dts
>> @@ -448,6 +448,10 @@ &qupv3_id_0 {
>>   	status = "okay";
>>   };
>>   
>> +&tlmm {
>> +	gpio-reserved-ranges = <28 2>;
>> +};
>> +
>>   &uart7 {
>>   	status = "okay";
>>   };

