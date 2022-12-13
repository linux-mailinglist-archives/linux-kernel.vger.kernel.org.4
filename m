Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA9E64B801
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbiLMPFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiLMPFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:05:14 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3D1DFEA;
        Tue, 13 Dec 2022 07:05:13 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDEEsSm025406;
        Tue, 13 Dec 2022 15:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=3mdHWz8hrvFV53AcHIB2oMArONg9HoIGdISTDDxqZi8=;
 b=K1b+/yosgFNYJU+/fvO+/57bszgmTqzXG1FU/9Jo8pyAggE1brtqEhqqptMumOoplgjj
 VKDHK3cw0fYFUGxKwfXnqHb3TL8C98TwNgqlc0kCoo/p9XlsKZ139tcqfD2FTIfEWzhc
 HTKoBWzvXkhCVRDx1npVB4HgihfdawRJyA475+4hbO79+IfyfemJ5RO0HcsXCIbWrbyl
 frP3siPxpr8TtmDqdvA/mRdLpKZNfXDfO6N10y6ykzjkQorFEAfeFoiqJUf9o6s0Q0cU
 EUXPrLoBsri6+B+/AlL+IEe54Y0hKyqPjvg46zFVvOkZYjEh/1ROk280/Ity237/i2ux Vg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mes4a8ejm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 15:05:06 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BDF55kU032253
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 15:05:05 GMT
Received: from [10.216.48.1] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 13 Dec
 2022 07:05:00 -0800
Message-ID: <5ac2a022-59e5-1189-bcba-e67b4974cbad@quicinc.com>
Date:   Tue, 13 Dec 2022 20:34:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sc8280xp: rename i2c5 to i2c21
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>, Brian Masney <bmasney@redhat.com>
CC:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <johan+linaro@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ahalaney@redhat.com>, <echanude@redhat.com>
References: <20221212182314.1902632-1-bmasney@redhat.com>
 <20221212182314.1902632-2-bmasney@redhat.com>
 <Y5iSDehp72mQPc+h@hovoldconsulting.com>
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
In-Reply-To: <Y5iSDehp72mQPc+h@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DXNr_Zn5E8fkrgaFJJXClRtI_8bplx1t
X-Proofpoint-ORIG-GUID: DXNr_Zn5E8fkrgaFJJXClRtI_8bplx1t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=974 adultscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212130133
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/2022 8:24 PM, Johan Hovold wrote:
> On Mon, Dec 12, 2022 at 01:23:11PM -0500, Brian Masney wrote:
>> According to the downstream 5.4 kernel sources for the sa8540p,
>> i2c@894000 is labeled i2c bus 21, not 5. The interrupts and clocks
>> also match. Let's go ahead and correct the name that's used in the
>> three files where this is listed.
>>
>> Signed-off-by: Brian Masney <bmasney@redhat.com>
>> Fixes: 152d1faf1e2f3 ("arm64: dts: qcom: add SC8280XP platform")
>> Fixes: ccd3517faf183 ("arm64: dts: qcom: sc8280xp: Add reference device")
>> Fixes: 32c231385ed43 ("arm64: dts: qcom: sc8280xp: add Lenovo Thinkpad X13s devicetree")
> 
>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> index 109c9d2b684d..875cc91324ce 100644
>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>> @@ -827,7 +827,7 @@ qup2_uart17: serial@884000 {
>>   				status = "disabled";
>>   			};
>>   
>> -			qup2_i2c5: i2c@894000 {
>> +			qup2_i2c21: i2c@894000 {
> 
> Note that the node is labelled qup2_i2c5 and not qup_i2c5.
> 
> That is, the QUP nodes are labelled using two indices, and specifically
> 
> 	qup2_i2c5
> 
> would be another name for
> 
> 	qup_i2c21
> 
> if we'd been using such a flat naming scheme (there are 8 engines per
> QUP).
> 
> So there's nothing wrong with how these nodes are currently named, but
> mixing the two scheme as you are suggesting would not be correct.

Wondering we might need to change qup2_uart17 to qup2_uart1 then ?

Shazad

> 
> Johan
