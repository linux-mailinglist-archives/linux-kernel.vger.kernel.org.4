Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB84560240A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 07:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiJRF4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 01:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJRF4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 01:56:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBD27A75E;
        Mon, 17 Oct 2022 22:56:20 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29I5ma46004214;
        Tue, 18 Oct 2022 05:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=iBYrOM6D+B3y1YMpOUSDbglLMKT4a9SUo60Ak3nsuCE=;
 b=YiH6tmfKcCJaM4ZGaEku1BZc99TKmJMeRstqWWqs6d9QFL7VIv7FS3YVP2sZfHGEX8YI
 oL8ir9zThIR/qgmzVLqHt9CF+OeiOydncX7NtY9hOv9lODzlhdk6+BRNAS/T0v+4mnaN
 cotJ11AQuRO+Qoe9V3dPWAcOy3OVwl5eJDPINZY7gGVY15iu8ng0EjR/iyMP33Z2ip4P
 H3OpG1QC9/a6Iqv8R0hmn9Tu1jS/4xNd+xk0gkZj/yCzC+v+zYDgJB4vfSqdqaFzcJoN
 TCbTTNvkL449qaZeVPVzu8TkHVzZx2sPoBEsLAUGJ8jVBtILgEFY/NsqWP6wwwlvhsXT Iw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k9n2p07p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 05:56:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29I5u833030166
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 05:56:08 GMT
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 17 Oct
 2022 22:56:04 -0700
Subject: Re: [RESEND PATCH v2 1/5] dt-bindings: firmware: qcom-scm: Add
 "allow-multi-call" property
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     David Heidelberg <david@ixit.cz>,
        Robert Marko <robimarko@gmail.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>
References: <1661898311-30126-1-git-send-email-quic_gurus@quicinc.com>
 <1661898311-30126-2-git-send-email-quic_gurus@quicinc.com>
 <453bce1e-e2d3-bf26-9954-774e1e267d82@linaro.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <2713bacb-922d-475c-e700-3107d4ebac90@quicinc.com>
Date:   Tue, 18 Oct 2022 11:26:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <453bce1e-e2d3-bf26-9954-774e1e267d82@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yEuMQUEGEApoljnrXPFep3iJTod9UN-U
X-Proofpoint-GUID: yEuMQUEGEApoljnrXPFep3iJTod9UN-U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_01,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180033
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Krzysztof,
Thanks for taking time to review the series.


On 8/31/22 1:30 PM, Krzysztof Kozlowski wrote:
> On 31/08/2022 01:25, Guru Das Srinagesh wrote:
>> For firmware that supports it, allow multiple SCM calls to be passed
>> down to it by removing the serialization lock in the SCM driver.
>>
>> This patch is based on this YAML conversion patch [1] that is in-flight
>> currently.
>>
>> [1] https://lore.kernel.org/lkml/20220708090431.30437-1-david@ixit.cz/
>>
>> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> If you make a resend, at least be sure you Cc proper people. Use
> scripts/get_maintainers.pl to CC all maintainers and relevant mailing lists.
> 
> This was not Cced to device tree maintainers, therefore it has to be NAK-ed.
> 
> 
>> ---
>>   Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>> index 9fdeee0..e279fd2 100644
>> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
>> @@ -70,6 +70,11 @@ properties:
>>     '#reset-cells':
>>       const: 1
>>   
>> +  allow-multi-call:
>> +    description:
>> +      Specify this flag to remove SCM call serialization. Need to ensure that
>> +      the firmware being used supports this feature first.
> 
> Missing vendor prefix, missing type.

Ack

> 
> Isn't support for this obvious from compatible?\

On further testing it looks like the property can't be truly enabled on
sm8450 yet so I'll drop the patch in the next re-spin.

> 
> Best regards,
> Krzysztof
> 
