Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957F1745571
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 08:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjGCGXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 02:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjGCGWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 02:22:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AC8C0;
        Sun,  2 Jul 2023 23:22:50 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3634wx6r006027;
        Mon, 3 Jul 2023 06:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=lz8e5ZwZImHg3i0oIzXkv/yPT9vujL/l4PbLkBP+AfY=;
 b=mQkqiUI/NznR+KCfWYiKRv0OxcaXaOS9lbKAgNjk6G4/CFtEKJ4DNu1r4tnZcqlME98H
 +XMtSxOvfe7gPnl3+2Kq7fsk45cbSEpQt9iggUMHyj4ThqAiNtHy3mH7C1wYh/vMyhHE
 WHtPjDCNzJn2pTII9hEV4LQY7cn/ua5NOXhi7AcWlULBNQkgskSLpSpyBofL8Wwyybun
 7Tz/nnKbodWVux/17TDdrDZYcQl8sbjLnbFdhBck0/ruRtzdJlnxlOxJkIQRFOq2c4qo
 vTIPT704q1zad5nFjSUkb3ibuPjUKGEPPH1AKO0wf7MPE2+TUJZfFZz9bQU6kJKECKnj aA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rjdedu2wx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 06:22:09 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3636M8W1023447
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Jul 2023 06:22:08 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 2 Jul 2023
 23:22:02 -0700
Message-ID: <5447f9f8-55b4-8bed-66a6-1c9d62b02c79@quicinc.com>
Date:   Mon, 3 Jul 2023 11:51:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 08/21] dt-bindings: reserved-memory: Add qcom,ramoops
 binding
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <keescook@chromium.org>,
        <tony.luck@intel.com>, <gpiccoli@igalia.com>,
        <mathieu.poirier@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <linus.walleij@linaro.org>,
        <andy.shevchenko@gmail.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <1687955688-20809-9-git-send-email-quic_mojha@quicinc.com>
 <CAL_JsqJ_TTnGjjB2d8_FKHpWBRG5GHLoWnabCKjsdeZ4QFdNEg@mail.gmail.com>
 <cacbbb02-732e-076e-50bf-292d20a4d722@quicinc.com>
 <58a26b9e-a48d-d567-c310-193a2c52521e@linaro.org>
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <58a26b9e-a48d-d567-c310-193a2c52521e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: W_MW9N648fOAOVkEkWbqMJYXECrB4HD3
X-Proofpoint-ORIG-GUID: W_MW9N648fOAOVkEkWbqMJYXECrB4HD3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_04,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 mlxscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030058
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/2/2023 1:42 PM, Krzysztof Kozlowski wrote:
> On 28/06/2023 17:01, Mukesh Ojha wrote:
>>
>>
>> On 6/28/2023 8:17 PM, Rob Herring wrote:
>>> On Wed, Jun 28, 2023 at 6:36 AM Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>>>>
>>>> Qualcomm ramoops minidump logger provide a means of storing
>>>> the ramoops data to some dynamically reserved memory instead
>>>> of traditionally implemented ramoops where the region should
>>>> be statically fixed ram region. Its device tree binding
>>>> would be exactly same as ramoops device tree binding and is
>>>> going to contain traditional ramoops frontend data and this
>>>> content will be collected via Qualcomm minidump infrastructure
>>>> provided from the boot firmware.
>>>
>>> The big difference is if firmware is not deciding where this log
>>> lives, then it doesn't need to be in DT. How does anything except the
>>> kernel that allocates the log find the logs?
>>
>> Yes, you are correct, firmware is not deciding where the logs lives
>> instead here, Kernel has reserved the region where the ramoops region
>> lives and later with the minidump registration where, physical
>> address/size/virtual address(for parsing) are passed and that is how
>> firmware is able to know and dump those region before triggering system
>> reset.
> 
> Your explanation does not justify storing all this in DT. Kernel can
> allocate any memory it wishes, store there logs and pass the address to
> the firmware. That's it, no need for DT.

If you go through the driver, you will know that what it does, is
just create platform device for actual ramoops driver to probe and to
provide this it needs exact set of parameters of input what original 
ramoops DT provides, we need to keep it in DT as maintaining this in
driver will not scale well with different size/parameter size
requirement for different targets.

> 
>>
>> A part of this registration code you can find in 11/21
>>
>>> I'm pretty sure I already said all this before.
>>
>> Yes, you said this before but that's the reason i came up with vendor
>> ramoops instead of changing traditional ramoops binding.
> 
> That's unexpected conclusion. Adding more bindings is not the answer to
> comment that it should not be in the DTS in the first place.

Please suggest, what is the other way being above text as requirement..

-- Mukesh
> 
> Best regards,
> Krzysztof
> 
