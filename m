Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA04B65602C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 06:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiLZFkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 00:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiLZFks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 00:40:48 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97307E8;
        Sun, 25 Dec 2022 21:40:47 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BQ5UZPa024990;
        Mon, 26 Dec 2022 05:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=aj/dFU/j7P3LxmLkkQI/79Xsrctnv4HD+wCspp1smKw=;
 b=VVPjjM9Xok/UEBBVd/7Qpl+1lM70iY6bkUicD8edkeJETTGzJ7Lbf6b2Mh25i5PRbNzv
 kXySoC5qwby8si2/iLUB1eVl1KiLfZthlpLpNdqoVVHsRulG9uIEXjIBiJBsf3LfYdxS
 xNsa0Lv6X4W5BtA6ANLpj5xtMDebvZJI+V8j3S+8OwU7aoZACvBo2TFuTYkBMYWoFLl2
 kOM6pGzlQ7saa4mhPMZ1cXggaEFb29yyw2ia6/67fXQH++62rUWc3ws0JW/0B4zLzHkm
 9AUbKvfflRtzU4B0+TYqgsClXaBzs6QvCD7DtWpVRsIuhBGCITinLVMuN65dId89KOcG dg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mnreg2rfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Dec 2022 05:40:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BQ5eVT1021340
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Dec 2022 05:40:31 GMT
Received: from [10.216.63.118] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 25 Dec
 2022 21:40:27 -0800
Message-ID: <dd9ff450-917d-792d-debc-a504ff6ca8bd@quicinc.com>
Date:   Mon, 26 Dec 2022 11:10:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] clk: qcom: lpasscc: Add resets for SC7280 audioreach
 clock controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <swboyd@chromium.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <quic_plai@quicinc.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <konrad.dybcio@somainline.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>
References: <1671618061-6329-1-git-send-email-quic_srivasam@quicinc.com>
 <1671618061-6329-3-git-send-email-quic_srivasam@quicinc.com>
 <efde6373-f788-5c0c-4712-7b9caf7ad3d4@linaro.org>
 <e7edd629-986f-3e64-f9db-5ee68cf4e6f3@quicinc.com>
 <60e388df-cd03-3e88-e9c5-460ebdde29c5@linaro.org>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <60e388df-cd03-3e88-e9c5-460ebdde29c5@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _y8M7bvYB71A7VqTqbyCWY0WqTTJOr9E
X-Proofpoint-ORIG-GUID: _y8M7bvYB71A7VqTqbyCWY0WqTTJOr9E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-26_02,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212260047
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/22/2022 4:14 PM, Krzysztof Kozlowski wrote:
Thanks for Your Time Krzyszto!!!
> On 21/12/2022 14:18, Srinivasa Rao Mandadapu wrote:
>> On 12/21/2022 4:09 PM, Krzysztof Kozlowski wrote:
>> Thanks for your time Krzysztof!!!
>>> On 21/12/2022 11:21, Srinivasa Rao Mandadapu wrote:
>>>> The clock gating control for TX/RX/WSA core bus clocks would be required
>>>> to be reset(moved from hardware control) from audio core driver. Thus
>>>> add the support for the reset clocks in audioreach based clock driver.
>>>>
>>>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>>>> ---
>>>>    drivers/clk/qcom/lpasscc-sc7280.c | 18 ++++++++++++++++++
>>>>    1 file changed, 18 insertions(+)
>>>>
>>>> diff --git a/drivers/clk/qcom/lpasscc-sc7280.c b/drivers/clk/qcom/lpasscc-sc7280.c
>>>> index 5c1e17b..d81d81b 100644
>>>> --- a/drivers/clk/qcom/lpasscc-sc7280.c
>>>> +++ b/drivers/clk/qcom/lpasscc-sc7280.c
>>>> @@ -12,10 +12,12 @@
>>>>    #include <linux/regmap.h>
>>>>    
>>>>    #include <dt-bindings/clock/qcom,lpass-sc7280.h>
>>>> +#include <dt-bindings/clock/qcom,lpassaudiocc-sc7280.h>
>>> These are bindings for different device.
>> They are not exactly for different device. It's for same device with
>> ADSP enabled platforms.
>>
>> Basically lpassaudiocc-sc7280.c and lpasscorecc-sc7280.c are for legacy
>> path.
>>
>> lpasscc-sc7280.c is for ADSP based AudioReach Solution.
> I see two different devices:
> lpasscc@3000000
> clock-controller@3300000
>
> clock inputs and outputs are different, so it does not look like for
> same device.

Actually, even though there are 2 different device nodes, they are being 
used exclusively.

In ADSP enabled path(on same sc7280 based platform it's enabled for some 
vendors) only lpasscc node is being used

and legacy path nodes are being disabled due to register region conflicts.

Below is the patch for the same:
https://patchwork.kernel.org/project/linux-arm-msm/patch/1671702170-24781-8-git-send-email-quic_srivasam@quicinc.com/

>
> Best regards,
> Krzysztof
>
