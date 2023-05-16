Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E85705A10
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 23:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjEPV7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 17:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjEPV7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 17:59:39 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F51810EC;
        Tue, 16 May 2023 14:59:38 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GKRlO9013008;
        Tue, 16 May 2023 21:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6WBOdrp4MoRntPk4JTak4XppU+MY2+sHrZfFMGMjML8=;
 b=DMf+dTPgQgntwEMgqi6ZG+LAhviXPqdFnX6AnIf3JQ5vJ6gWdm34k4EmRFZgL7DkXnLG
 aHVU06r3oI/jq/YHbe6N/28+yDgALEibdjQXmh7wFAaLiii8fce4CjKSqjuAxdn0a67I
 EsuvAPvdXkWreMjBBb5/oI3dZeXcmPlVFxCgtl5KZFF6TksPi19qTzNo1Q1Vdw5bBcom
 gjYaPVDehvbETKzIAcck0PO29ZDCVKBvkkiVUDqKmdVae5HZVhbZFM94iHlfms8Y0lTg
 0wlQIrAEGPVX9fm6xEUO6c9JE6+50ZTKBN5tmEzHytsmy9VUjFAoyGjcf75B2t+1pSxG 4A== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qm36n21s9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 21:58:53 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34GLwqZF022335
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 21:58:52 GMT
Received: from [10.110.39.6] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 16 May
 2023 14:58:51 -0700
Message-ID: <db728b45-473a-e088-7296-160d93d79e0b@quicinc.com>
Date:   Tue, 16 May 2023 14:58:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V6 1/3] dt-bindings: sram: qcom,imem: Add Boot Stat region
 within IMEM
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1683628357.git.quic_schowdhu@quicinc.com>
 <343182748e12b6a4ac57d336405c50e36fc5520c.1683628357.git.quic_schowdhu@quicinc.com>
 <CAA8EJpp2x2OEB2sg+caKmjkDYJp_NJ9mXo85FxTZr-9zRXHNhw@mail.gmail.com>
 <7d397e67-5d56-4975-98af-1ac9746c07f4@app.fastmail.com>
 <CAA8EJpoMGyAJBTw1-=+NT=ysy+cpc4EpJSv1SABJVh2BscdJ+g@mail.gmail.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <CAA8EJpoMGyAJBTw1-=+NT=ysy+cpc4EpJSv1SABJVh2BscdJ+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 06qlANEolpxD5bkS0wOaTIjr0rpYHE67
X-Proofpoint-ORIG-GUID: 06qlANEolpxD5bkS0wOaTIjr0rpYHE67
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_12,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305160186
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/2023 12:17 PM, Dmitry Baryshkov wrote:
> On Tue, 16 May 2023 at 11:16, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Tue, May 9, 2023, at 13:35, Dmitry Baryshkov wrote:
>>> On Tue, 9 May 2023 at 13:53, Souradeep Chowdhury
>>> <quic_schowdhu@quicinc.com> wrote:
>>>>
>>>> All Qualcomm bootloaders log useful timestamp information related
>>>> to bootloader stats in the IMEM region. Add the child node within
>>>> IMEM for the boot stat region containing register address and
>>>> compatible string.
>>>
>>> I might have a minor vote here. Is there any reason why you have to
>>> instantiate the device from DT?
>>> It looks like a software interface. Ideally software should not be
>>> described in DT (e.g. this can be instantiated from imem
>>> driver-to-be).
>>
>> There is nothing wrong with describing firmware in DT, if that
>> firmware is part of the platform, we do that for a lot of
>> other bits of firmware.
>>
>> However, in this specific case, many things are wrong with the
>> implementation, and neither the DT binding nor the driver
>> makes sense to me in its current state.
>>
>>>> +  "^stats@[0-9a-f]+$":
>>>> +    type: object
>>>> +    description:
>>>> +      Imem region dedicated for storing timestamps related
>>>> +      information regarding bootstats.
>>>> +
>>>> +    additionalProperties: false
>>>> +
>>>> +    properties:
>>>> +      compatible:
>>>> +        items:
>>>> +          - enum:
>>>> +              - qcom,sm8450-bootstats
>>>> +          - const: qcom,imem-bootstats
>>>> +
>>>> +      reg:
>>>> +        maxItems: 1
>>
>> If I understand this right, this "qcom,imem-bootstats"
>> device serves as an indirection to store additional
>> properties of the system in a memory area, but the description
>> of that area is more complex than its contents, which
>> makes no sense to me.
>>
>> Just create a binding for a firmware node in the devicetree
>> itself, and put the values in properties of that. The first
>> stage firmware can still use the same interface, but the
>> actual loader that assembles the DT can get it out of that
>> and store it in the properties. With that done, there is also
>> no need for a kernel driver, as userspace can just get the
>> values from /sys/firmware/devicetree/ directly.
> 
> This sounds good, except the always-present issue of the devices which
> have already been released. Usually we can not expect a bootloader
> update for these devices.

Valid point. I don't expect current SOCs supported at upstream to update 
with the newer bootloader having this feature done through bootloader.

---Trilok Soni

