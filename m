Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6CC737AFD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjFUGA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFUGA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:00:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D400A94;
        Tue, 20 Jun 2023 23:00:24 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35L5OlsW023073;
        Wed, 21 Jun 2023 06:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=xjY2SYNfv3RwEGW+uucTh9bt3QwnFzKvr/dlKJfaTl4=;
 b=JB6f+RnzBFvZYNkUb927gnK12732kWuDCE8LzxJi+9HKCMLbfgN55z6uoCreKiwq8llc
 yA6lKCApig4bb/aBFs2VGP9KY6u+h1ku6XZI1FZ7IZ6qT3CHmqx5H8QKusdigShpi2YG
 cZ4n+ypySkbdsOCd2A4SfWO85NAGU3Qt43PqD5UCVGyh37IAol9Uu4f0Kai68emVCPWj
 bRXGsl3hpu6EGJ5xst1FfRqaQBZpfESKX2IoHfU+fMRd9WHnYxyNWthVPsV/ky4gDEra
 zi4pNanQo5YuhXqNuLsOwk+w6fyIBhEzYzLGU6qrWBZSbantyHP05XH4YvNK6k20HhcZ 7Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rb1dtk93n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 06:00:19 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35L60HN0009259
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 06:00:17 GMT
Received: from [10.216.41.219] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 20 Jun
 2023 23:00:13 -0700
Message-ID: <c5302062-e66a-c943-9fed-d959a1b6a9ed@quicinc.com>
Date:   Wed, 21 Jun 2023 11:29:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RESEND v6 7/8] arm64: dts: qcom: sc7280: Modify LPASS_MCC reg
 region size in the lpass_tlmm node
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <swboyd@chromium.org>,
        <andersson@kernel.org>, <broonie@kernel.org>, <agross@kernel.org>
CC:     <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <judyhsiao@chromium.org>,
        <quic_visr@quicinc.com>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
References: <20230616103534.4031331-1-quic_mohs@quicinc.com>
 <20230616103534.4031331-8-quic_mohs@quicinc.com>
 <6a0a9fe7-d08e-4d1d-0085-f854f95c390f@linaro.org>
From:   Mohammad Rafi Shaik <quic_mohs@quicinc.com>
In-Reply-To: <6a0a9fe7-d08e-4d1d-0085-f854f95c390f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PCvf3pB22Dsytsb8SB8oPClhWgRck59z
X-Proofpoint-GUID: PCvf3pB22Dsytsb8SB8oPClhWgRck59z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_03,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=887 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306210051
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/16/2023 5:00 PM, Konrad Dybcio wrote:
> On 16.06.2023 12:35, Mohammad Rafi Shaik wrote:
>> From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>>
>> Modify LPASS_MCC register region size in "lpass_tlmm" node.
>> The pincntl driver requires access until slew-rate register region
>> and remaining register region related to the lpass_efuse register
>> is not required in pincntl driver as lpass_efuse register region is
>> required in adsp remoteproc driver.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
>> ---
> Fixes tag?
>
> Konrad
Thanks for comment,

okay, will add fixes tag.
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 36f9edabb9d7..ec38f2feb9bf 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -2509,7 +2509,7 @@ lpass_ag_noc: interconnect@3c40000 {
>>   		lpass_tlmm: pinctrl@33c0000 {
>>   			compatible = "qcom,sc7280-lpass-lpi-pinctrl";
>>   			reg = <0 0x033c0000 0x0 0x20000>,
>> -				<0 0x03550000 0x0 0x10000>;
>> +				<0 0x03550000 0x0 0xa100>;
>>   			qcom,adsp-bypass-mode;
>>   			gpio-controller;
>>   			#gpio-cells = <2>;
