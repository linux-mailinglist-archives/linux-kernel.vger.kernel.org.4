Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D416705616
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjEPSfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjEPSey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:34:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ABB6199;
        Tue, 16 May 2023 11:34:39 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GFtEwd022637;
        Tue, 16 May 2023 18:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=b5xAOTaTPY53vSJ6L6XmV16E9+B3CwF4oU7B0VkWaDs=;
 b=LBhlDKrSQ8PsifWF1EnakPm7CqEmvIeYG3qhigL4FMO37GKhj3QsXJXhFwGHJMZRRYU1
 gBhRyakxIxVUyvshoelCsfTK0+Qis6rmj5IG7HPiVLvNP39NKR9qbYYk9g0iFsbAUMNd
 U6BxK3SNH3PB8zqTsc6nVIg2UIE9WlFeV14u6i0i/o9JDv/i28QiQVtypoM75GObc+4T
 YfrG/5DcjFrIRIrSsPAfUq8TAgH91FacosLM/ydtpuUfsPf/82ZWDXzTFt8Ywu1OF/wC
 OcXz1wSkod/zVLo2P2D1omh+Fz5s0tFWMBizQ07i3YObrpmpSmav+TUIsFWDg9S+xUZj NQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qmbk78kdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 18:34:03 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34GIY2ri013132
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 18:34:02 GMT
Received: from [10.110.39.6] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 16 May
 2023 11:34:01 -0700
Message-ID: <64cdd9b6-dae3-f335-63a7-c20ed9b63920@quicinc.com>
Date:   Tue, 16 May 2023 11:34:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V6 1/3] dt-bindings: sram: qcom,imem: Add Boot Stat region
 within IMEM
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        "Rajendra Nayak" <quic_rjendra@quicinc.com>
References: <cover.1683628357.git.quic_schowdhu@quicinc.com>
 <343182748e12b6a4ac57d336405c50e36fc5520c.1683628357.git.quic_schowdhu@quicinc.com>
 <CAA8EJpp2x2OEB2sg+caKmjkDYJp_NJ9mXo85FxTZr-9zRXHNhw@mail.gmail.com>
 <7d397e67-5d56-4975-98af-1ac9746c07f4@app.fastmail.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <7d397e67-5d56-4975-98af-1ac9746c07f4@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2t_hvxa8VYw2e5Mg9H-nk58GSVUcGBE_
X-Proofpoint-ORIG-GUID: 2t_hvxa8VYw2e5Mg9H-nk58GSVUcGBE_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_10,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 adultscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305160155
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/2023 1:16 AM, Arnd Bergmann wrote:
> On Tue, May 9, 2023, at 13:35, Dmitry Baryshkov wrote:
>> On Tue, 9 May 2023 at 13:53, Souradeep Chowdhury
>> <quic_schowdhu@quicinc.com> wrote:
>>>
>>> All Qualcomm bootloaders log useful timestamp information related
>>> to bootloader stats in the IMEM region. Add the child node within
>>> IMEM for the boot stat region containing register address and
>>> compatible string.
>>
>> I might have a minor vote here. Is there any reason why you have to
>> instantiate the device from DT?
>> It looks like a software interface. Ideally software should not be
>> described in DT (e.g. this can be instantiated from imem
>> driver-to-be).
> 
> There is nothing wrong with describing firmware in DT, if that
> firmware is part of the platform, we do that for a lot of
> other bits of firmware.
> 
> However, in this specific case, many things are wrong with the
> implementation, and neither the DT binding nor the driver
> makes sense to me in its current state.
> 
>>> +  "^stats@[0-9a-f]+$":
>>> +    type: object
>>> +    description:
>>> +      Imem region dedicated for storing timestamps related
>>> +      information regarding bootstats.
>>> +
>>> +    additionalProperties: false
>>> +
>>> +    properties:
>>> +      compatible:
>>> +        items:
>>> +          - enum:
>>> +              - qcom,sm8450-bootstats
>>> +          - const: qcom,imem-bootstats
>>> +
>>> +      reg:
>>> +        maxItems: 1
> 
> If I understand this right, this "qcom,imem-bootstats"
> device serves as an indirection to store additional
> properties of the system in a memory area, but the description
> of that area is more complex than its contents, which
> makes no sense to me.
> 
> Just create a binding for a firmware node in the devicetree
> itself, and put the values in properties of that. The first
> stage firmware can still use the same interface, but the
> actual loader that assembles the DT can get it out of that
> and store it in the properties. With that done, there is also
> no need for a kernel driver, as userspace can just get the
> values from /sys/firmware/devicetree/ directly.
> 

To understand bit better here, what you are suggesting here that
application bootloader (e.g., UEFI app for Linux) can read these
boot values from the IMEM and encode them into the devicetree properties
which can be later retrieved directly from the userspace.

I am fine with this approach as well and in this case we just
need to submit the bindings document, right?

---Trilok Soni

