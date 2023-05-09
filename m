Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5038A6FC7CB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 15:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbjEINXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 09:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjEINXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 09:23:45 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF373C01;
        Tue,  9 May 2023 06:23:43 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349Cc06g023990;
        Tue, 9 May 2023 13:23:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Ztn5cr2+ZzyLZNYlN4HERQHsgAwqhpff8Mu0TMY37L8=;
 b=F7yVdNngGGU/CXbalbwgLhlQEwRt+TdhgqARpq9VknRt30uts4zD3QXJgBI56wFXaGxa
 ygIVkYCstrCZFffzpSG3INe6+/LtMyaFQ1YgwFK/pihRBuQPKxDJ+JqtQQ2VQVjqWml5
 7jJQStJeXSKnSMpd/deWhjhSEETLpLFU2z9ivmAgo+T7By0innnKhh67rF09Pj+MJWbx
 fWmFz/Zbuxlg3T7YX+fx7crZgn92A8h9F7EHsTvyrQkGad/xZsu/0sd4TfIwy98rttXL
 hpcBqAQ3F1CdurL8KkNp2BwyEHyd0ba5XXSOq07Y41G60v0dJDsRFvlJSct1IdDCRRfz xQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qf77kstph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 13:23:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 349DNcNc025061
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 May 2023 13:23:38 GMT
Received: from [10.242.242.190] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 9 May 2023
 06:23:29 -0700
Message-ID: <1aa64a2f-fa57-2f06-b993-2e158512361c@quicinc.com>
Date:   Tue, 9 May 2023 18:53:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 01/11] dt-bindings: remoteproc: qcom: Add support for
 multipd model
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <mathieu.poirier@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_gurus@quicinc.com>,
        <loic.poulain@linaro.org>, <quic_eberman@quicinc.com>,
        <robimarko@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
 <1678164097-13247-2-git-send-email-quic_mmanikan@quicinc.com>
 <38a5a268-7d8a-6e61-4272-8e9155df0034@linaro.org>
 <790496d7-98dc-c92e-dedc-1c89395a1ad8@quicinc.com>
 <e63a3e34-1f73-3661-8655-e34e1e955804@linaro.org>
 <b8b30b77-31df-15c3-3914-1198f90299e6@quicinc.com>
 <c1833e5b-9397-8a87-07c5-1b8bd84bd457@linaro.org>
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <c1833e5b-9397-8a87-07c5-1b8bd84bd457@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zpdH6aWB3suKursu49WPMBHucX_FhXI9
X-Proofpoint-ORIG-GUID: zpdH6aWB3suKursu49WPMBHucX_FhXI9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=598 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305090109
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/9/2023 6:31 PM, Krzysztof Kozlowski wrote:
> On 09/05/2023 12:34, Manikanta Mylavarapu wrote:
>>>> Sure, will add.
>>>>>> +    description:
>>>>>> +      Qualcomm G-Link subnode which represents communication edge, channels
>>>>>> +      and devices related to the Modem.
>>>>>> +
>>>>>> +patternProperties:
>>>>>> +  "^remoteproc_pd1|remoteproc_pd2|remoteproc_pd3":
>>>>>
>>>>> No, underscores are not allowed. Also, what is pd?
>>>>>
>>>> Sure, will remove underscores.
>>>
>>> Shouldn't this be just pd-1?
>>>
>>>
>> I think 'pd-1' not enough. Because child's i.e userpd's also considered
>> as remote processor's, so name should be like "remoteproc-pd1".
> 
> "pd-1" is not enough for what? Why the node name has to be more specific?
> 
> 
> Best regards,
> Krzysztof
> 

Sure. "pd-1" also seems fine. I will change child node name to "pd-1".

Thanks & Regards,
Manikanta.
