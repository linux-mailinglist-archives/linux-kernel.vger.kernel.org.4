Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A3C70B50F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjEVGcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjEVGcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:32:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FA39B;
        Sun, 21 May 2023 23:32:06 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M4R3FZ016327;
        Mon, 22 May 2023 06:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DQa30vKRm5JaFVF5epmievdfUoju+vGys7fNeVT8iEE=;
 b=JZEoz6xtZ76hqA77bVxRXHLH5644PG4PDyV50qc7fp2iC+UvaN3pHKuadNEnKOVfjSSw
 q+HHHzHYEv/gAPPOnj4bqAhZfCIXirepj03Y0wj32zagIzkG6ay7VTp4LA47+wn8RinG
 rSsTJ9FdmIz9v99wfEvqJVe+gRrJJvgJTkkAUqRQeLyhr7ZZgubB4nkR6MeSWPpLXFIW
 xAQb7j+E9JApnUypVQ8YQOPYIuxmqfLAOcu+c3gecDHNTgo8OO2VkQk5AAlOv5kOX5u/
 UdZUoncQcda1GBeQTvVN2QGSlgurmX1v9M+nP7NdBY1d2Z4Hw8QqyJb5M1fPdvpo6wL/ /A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qpkwmu0rc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 06:32:03 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34M6W23X012783
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 06:32:02 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 21 May
 2023 23:31:58 -0700
Message-ID: <478462f6-379f-afa8-dc44-11233e18460a@quicinc.com>
Date:   Mon, 22 May 2023 12:01:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 4/4] arm64: dts: qcom: qdu1000-idp: add SDHCI for emmc
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20230519085122.15758-1-quic_kbajaj@quicinc.com>
 <20230519085122.15758-5-quic_kbajaj@quicinc.com>
 <8e3c745a-2e37-2927-7dbf-e23a777702f3@linaro.org>
 <ed4c33d3-ae5d-d695-eda0-0b09a4a26644@linaro.org>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <ed4c33d3-ae5d-d695-eda0-0b09a4a26644@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: E5Tv7PCb8DHnIz5AvLsdiyecr4EtfRBC
X-Proofpoint-ORIG-GUID: E5Tv7PCb8DHnIz5AvLsdiyecr4EtfRBC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 spamscore=0 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=830 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220054
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/20/2023 4:54 PM, Konrad Dybcio wrote:
>
> On 19.05.2023 12:13, Bhupesh Sharma wrote:
>> On 5/19/23 2:21 PM, Komal Bajaj wrote:
>>> Add sdhci node for emmc in qdu1000-idp.
>>>
>>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>>> ---
>>>    arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 11 +++++++++++
>>>    1 file changed, 11 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>>> index 9e9fd4b8023e..b2526e991548 100644
>>> --- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>>> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>>> @@ -451,3 +451,14 @@
>>>    &uart7 {
>>>        status = "okay";
>>>    };
>>> +
>>> +&sdhc_1 {
>>> +    status = "okay";
>>> +
>>> +    pinctrl-0 = <&sdc1_on_state>;
>>> +    pinctrl-1 = <&sdc1_off_state>;
>>> +    pinctrl-names = "default", "sleep";
>>> +
>>> +    vmmc-supply = <&vreg_l10a_2p95>;
>>> +    vqmmc-supply = <&vreg_l7a_1p8>;
>>> +};
>> Again, please follow alphabetical order for adding new node entries.
Noted.
>>
>> Also, we have been placing 'status = .. ' entry at the end for new .dts (or .dts entry), but if that is the format used across this board dts
>> I am ok with the same.
Sure, will move status to end.
> Komal,
>
> since you're already touching this file, would you mind making a
> separate commit moving status last for all nodes?
Hi Konrad,
I don't notice any other nodes whose state is maintained at the 
beginning of the node.

Thanks
Komal
>
> Konrad
>> Thanks,
>> Bhupesh

