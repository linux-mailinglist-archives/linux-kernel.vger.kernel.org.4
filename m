Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF636530C9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 13:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiLUM2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 07:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiLUM2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 07:28:10 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCBD23150;
        Wed, 21 Dec 2022 04:28:08 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BLBtJ9U014578;
        Wed, 21 Dec 2022 12:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MzegHwyungJP8at2Tw5NExRsmohwgdnjXBTsPH0lPJ8=;
 b=Rrn7MJqk99AYVmVtXHUdL1/3NBbdYht1SPEu61HlpqOHfRCqf68wupHkzr3O5nAVDPRE
 /XThY789TqcYF93WEmFpuyXgfGpNnNLdyiuETAkSVoOBbGRtjBsP2lbQtBt2da5yC5TB
 hF/7EhzQIyM0CF4DknGFsHDGcDmswJHHOaDlhoBtO42AM0IrGM6rcDjrfb0IditRLnWP
 Dg/r0s1ZSDhW75WRVL3Zt1Aaz12fcai2gXvImZKFHqQSIqNs86UBLL99SLTsy+Rybvgp
 ATigkt22K1pBJ7Ad3HtNVGMcZGeTJpwSj/8qMWr0WOeIYHXe8oBrn8HfTdDxdu8E32vP jA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mm0wfg4qb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 12:28:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BLCS09v001063
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 12:28:00 GMT
Received: from [10.216.2.240] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 21 Dec
 2022 04:27:55 -0800
Message-ID: <ce8c2208-b4a2-70ea-bf87-a2baba292a28@quicinc.com>
Date:   Wed, 21 Dec 2022 17:57:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] dt-bindings: clock: SC7280: Add resets for LPASS
 audio clock controller
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
 <1671618061-6329-2-git-send-email-quic_srivasam@quicinc.com>
 <f138f9de-4ecf-3126-97bd-668c96612913@linaro.org>
 <b6172e20-114a-b7e2-2200-0932f803cb20@quicinc.com>
 <5ff6e569-ad9f-f884-ea0e-41114afcaf7d@linaro.org>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <5ff6e569-ad9f-f884-ea0e-41114afcaf7d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _348LdYM0GSeg0L3Pt4OozUmDzVlGM2b
X-Proofpoint-GUID: _348LdYM0GSeg0L3Pt4OozUmDzVlGM2b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_05,2022-12-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212210101
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/21/2022 5:54 PM, Krzysztof Kozlowski wrote:
> On 21/12/2022 13:22, Srinivasa Rao Mandadapu wrote:
>> On 12/21/2022 4:12 PM, Krzysztof Kozlowski wrote:
>> Thanks for your time Krzyszto!!!
>>> On 21/12/2022 11:21, Srinivasa Rao Mandadapu wrote:
>>>> Add support for LPASS audio clock gating for RX/TX/SWA core bus clocks
>>>> for audioreach based SC7280 platforms.
>>> Use subject prefixes matching the subsystem (git log --oneline -- ...).
>>> The final prefix should be "qcom,sc7280-lpasscc" and then the actual
>                                  ^^^^^^^ it's written here
>
>>> subject should drop redundant pieces.
>> Sorry. I didn't understand much from your statement.
>>
>> Do you mean subject should something like below?
>>
>>    dt-bindings: clock: qcom: sc7280-lpasscc: Add resets for audio clock
>> controller
> 1. The last prefix should be "qcom,sc7280-lpasscc:".
> 2. And then drop "audio clock controller" because it is obvious, isn't it?
Okay!. Thanks for clarifying. I will change accordingly. Actually I 
followed previous similar commits.
>
>>>>    ...
>>> Best regards,
>>> Krzysztof
>>>
> Best regards,
> Krzysztof
>
