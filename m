Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219445B957E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 09:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiIOHgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 03:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiIOHfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 03:35:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914E88A7C1;
        Thu, 15 Sep 2022 00:35:49 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28F4nAWe014700;
        Thu, 15 Sep 2022 07:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LkOCqTWtTL5/+97RNV04n2J7GXFNzsYNOika+RKy+0I=;
 b=JhXpYtHefWR9ZzBBpAn+bXcoXxRP+QFXvJ3kLbLFvLjr4PWeXp+MQ5AOFLCPIo81PIF5
 btF3oep9+JZd9wJdCZTgvmxQXKrfD4HQLFASQewubXYETCdhDi8a/bbeLN+sYDgSLZa4
 4ZHVa8HfsqgPyhS/5qc77ryqHa3ktQdDZUTewv37+obecWtMZbVloDPyrNU2+uRIQYg2
 9A9D9pSb9HwwMi7WNylyqb6Ict6qW8KZbyq/IgtEgogKgW/XSQC/zOhr9kcDKZ/q3/Sz
 TEbWTGrt2n/aV7Jy4qVcJCZF4ic3sRYpqI4rWQoZdkyoZguTykBEYm5ceE1oIUg2/VC1 Ww== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jkd9hub6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 07:35:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28F7ZeoL028571
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 07:35:40 GMT
Received: from [10.216.56.33] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 15 Sep
 2022 00:35:35 -0700
Message-ID: <49b835f4-cea8-6422-fa53-7c0ef443873b@quicinc.com>
Date:   Thu, 15 Sep 2022 13:05:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Add required-opps for USB
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     <agross@kernel.org>, <konrad.dybcio@somainline.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sboyd@kernel.org>,
        <mka@chromium.org>, <johan+linaro@kernel.org>,
        <quic_kriskura@quicinc.com>, <dianders@chromium.org>
References: <20220914053017.23617-1-quic_rjendra@quicinc.com>
 <20220915022025.rwqooixqhhuott6n@builder.lan>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <20220915022025.rwqooixqhhuott6n@builder.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LBI3N4Xz_qV0i635FNECLvZO1tBb472p
X-Proofpoint-GUID: LBI3N4Xz_qV0i635FNECLvZO1tBb472p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_04,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209150040
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/15/2022 7:50 AM, Bjorn Andersson wrote:
> On Wed, Sep 14, 2022 at 11:00:17AM +0530, Rajendra Nayak wrote:
>> USB has a requirement to put a performance state vote on 'cx'
>> while active. Use 'required-opps' to pass this information from
>> device tree, and since all the GDSCs in GCC (including USB) are
>> sub-domains of cx, we also add cx as a power-domain for GCC.
>> Now when any of the consumers of the GDSCs (in this case USB)
>> votes on a perforamance state, genpd framework can identify that
>> the GDSC itself does not support a performance state and it
>> then propogates the vote to the parent, which in this case is cx.
>>
>> This change would also mean that any GDSC in GCC thats left enabled
>> during low power state (perhaps because its marked with a
>> ALWAYS_ON flag) can prevent the system from entering low power
>> since that would prevent cx from transitioning to low power.
>> Ideally any consumers that would need to have their devices
>> (partially) powered to support wakeups should look at making the
>> resp. GDSCs transtion to a Retention (PWRSTS_RET) state instead
>> of leaving them ALWAYS_ON.
>>
>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
>> ---
>> * This patch is a follow up based on the discussion on the previously
>>    posted version to support USB performance state voting [1]
>>
>> * Another patch that this approach depends on is the one to fix the
>>    handling of PWRSTS_RET in the GDSC driver [2] so we can have USB
>>    GDSC transtion to a RET state instead of marking it ALWAYS_ON
>>
>> [1] https://lore.kernel.org/linux-usb/YTduDqCO9aUyAsw1@ripper/
>> [2] https://lore.kernel.org/all/20220901101756.28164-1-quic_rjendra@quicinc.com/#t
>>
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index ad04025a8a1a..8a21446738bf 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -828,6 +828,7 @@
>>   			#clock-cells = <1>;
>>   			#reset-cells = <1>;
>>   			#power-domain-cells = <1>;
>> +			power-domains = <&rpmhpd SC7280_CX>;
>>   		};
>>   
>>   		ipcc: mailbox@408000 {
>> @@ -3456,6 +3457,7 @@
>>   					  "ss_phy_irq";
>>   
>>   			power-domains = <&gcc GCC_USB30_PRIM_GDSC>;
>> +			required-opps = <&rpmhpd_opp_svs>;
> 
> The patch looks really good, but don't you need &rpmhpd_opp_nom for the
> 200MHz assigned to GCC_USB30_PRIM_MASTER_CLK?

you are right, I wrote this patch a long while back, not sure if
we were on a lower clock back then, thanks for catching, I will fix it
and repost.
  
> Also, how about adding the same to &usb_2, while we're at it?

Sure, will do that as well. thanks.

> 
> Regards,
> Bjorn
> 
>>   
>>   			resets = <&gcc GCC_USB30_PRIM_BCR>;
>>   
>> -- 
>> 2.17.1
>>
