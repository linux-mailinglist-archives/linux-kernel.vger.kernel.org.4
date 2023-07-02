Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF16974503F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjGBTM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGBTM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:12:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F294C2;
        Sun,  2 Jul 2023 12:12:26 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 362Iw0ch014151;
        Sun, 2 Jul 2023 19:12:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Lpmj/h3j8qx7NknLABp66XfmLij3bm+vdXJCHIylTDI=;
 b=Fz3MxfvBO95AbJjNZ7GosE2TRaYoYucsN1r5RzFlkK5nY7uL5syepHfvdtX1HypkIJsv
 q2wHE1avlHt8o5AB7WM7hGMR9C9UDoBKyLD9k7EzeP31M6efW+Cdi+2zi6fyn5ZoSeUA
 9SL7NWyxRPK8oDESk5OP8p9AlUnheL9cuCQA/6p7eAAsVf0ToQYk2tGQqWuGJkrsUQar
 Rn7K41HTRUL4nNgK1xBnKKlyQuVYGmB5Eh1V+0Na7mfREeVvdKd6IaQbNLmhkWYlCBmF
 AgIjQZ7OcPtf1jBzU36UFXwEyjXJpcsj/R3meUIA6SdIRL+k8YdPCa+n8CRKj6Svcfio Mw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rj9gttnrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 Jul 2023 19:12:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 362JC8R1025500
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 2 Jul 2023 19:12:08 GMT
Received: from [10.216.46.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Sun, 2 Jul 2023
 12:12:02 -0700
Message-ID: <548e35a7-984d-a62f-ea4b-a5aeace8009a@quicinc.com>
Date:   Mon, 3 Jul 2023 00:41:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v9 01/10] dt-bindings: usb: qcom,dwc3: Add bindings for
 SC8280 Multiport
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "Wesley Cheng" <quic_wcheng@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_harshq@quicinc.com>,
        <ahalaney@redhat.com>, <quic_shazhuss@quicinc.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-2-quic_kriskura@quicinc.com>
 <ZJrGG6FXWLacRLbg@hovoldconsulting.com>
 <ZJsCf3nYrikF7nZc@hovoldconsulting.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZJsCf3nYrikF7nZc@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: u4j87RUynHApAGbenT5MTQYauO3EGgN6
X-Proofpoint-ORIG-GUID: u4j87RUynHApAGbenT5MTQYauO3EGgN6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-02_15,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=441 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307020182
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/27/2023 9:08 PM, Johan Hovold wrote:
> On Tue, Jun 27, 2023 at 01:20:59PM +0200, Johan Hovold wrote:
>> On Wed, Jun 21, 2023 at 10:06:19AM +0530, Krishna Kurapati wrote:
> 
>>> +          items:
>>> +            - const: dp1_hs_phy_irq
>>> +            - const: dm1_hs_phy_irq
>>> +            - const: dp2_hs_phy_irq
>>> +            - const: dm2_hs_phy_irq
>>> +            - const: dp3_hs_phy_irq
>>> +            - const: dm4_hs_phy_irq
>>> +            - const: dp4_hs_phy_irq
>>> +            - const: dm4_hs_phy_irq
>>> +            - const: ss1_phy_irq
>>> +            - const: ss2_phy_irq
>>> +            - const: pwr_event_1
>>> +            - const: pwr_event_2
>>> +            - const: pwr_event_3
>>> +            - const: pwr_event_4
>>
>> The naming here is inconsistent and interrupts should not have "_irq"
>> suffixes (even if some of the current ones do for historical reasons).
>>
>> I believe these should be named
>>
>> 	pwr_event_1
>> 	dp_hs_phy_1
>> 	dm_hs_phy_1
>> 	ss_phy_1
>>
>> 	pwr_event_2
>> 	dp_hs_phy_2
>> 	dm_hs_phy_2
>> 	ss_phy_2
>>
>> 	pwr_event_3
>> 	dp_hs_phy_3
>> 	dm_hs_phy_3
>>
>> 	pwr_event_4
>> 	dp_hs_phy_4
>> 	dm_hs_phy_4
>>
>> or similar and be grouped by port while using the the
>> qcom,sc8280xp-dwc ordering for the individual lines.
> 
> Perhaps the ordering you suggested is fine too, but I'd probably move
> the pwr_event ones first to match qcom,sc8280xp-dwc then, that is:
> 
>   	pwr_event_1
>   	pwr_event_2
>   	pwr_event_3
>   	pwr_event_4
>   	dp_hs_phy_1
>   	dm_hs_phy_1
>   	dp_hs_phy_2
>   	dm_hs_phy_2
>   	dp_hs_phy_3
>   	dm_hs_phy_3
>   	dp_hs_phy_4
>   	dm_hs_phy_4
>   	ss_phy_1
>   	ss_phy_2
> 
> so we have them grouped as pwr_event followed by HS and with SS last.
> 
>> Side note: Please note how the above interrupt properties can also be
>> used to infer the number of HS and SS ports.
> 
> Johan

Can't we just cleanup all at once later ? Might not be a good idea for 
some properties in the file to have _irq and for some to not have it. I 
will modify the order though.

Regards,
Krishna,
