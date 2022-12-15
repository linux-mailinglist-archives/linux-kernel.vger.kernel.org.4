Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385B864E162
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiLOSxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiLOSxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:53:48 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86F937225;
        Thu, 15 Dec 2022 10:53:47 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFBRhK7007448;
        Thu, 15 Dec 2022 18:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=X4+Wss1oWAfIh82TyUWECs+jRW05yRh2D8M9j9TbQH8=;
 b=JrGSOVZmBfQWBRe+oE3e2g3ogVGHkKohRU2IfCNhoeWly50hIrwy+UwwblESvMB6EQxr
 wqZlwv22NnDJAfffo/QEMe1FLMzpEQ0Mm0T0gem+I/06kWriTAEKDqBzrhtIBngh0meO
 hOyYD6BYUgeW1UNsCChO3qbaYJ1R31oBJa+ctbZhlQ1pVYXkVLGuJ9HoUBwcizRLC8K/
 VnbMdG9vXTOBNJ+ZGkjaOO2hpYQkhWiS4iNynGefa7XpGVaHo045hq5q03s4gfXavQ+Q
 FvOfx9VFHaZBCMa1twTJpjavt4smL7UXoxXTBtl2qBuEDqYvcALHNTH8nAxLyonUN7q2 tA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mg2891sj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 18:53:44 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BFIrhlt008512
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 18:53:43 GMT
Received: from [10.110.78.226] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 15 Dec
 2022 10:53:42 -0800
Message-ID: <6cbf5cb8-f34a-af94-85b3-6acaf76f3f14@quicinc.com>
Date:   Thu, 15 Dec 2022 10:53:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: Add base QDU1000/QRU1000 IDP DTs
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221118192241.29384-1-quic_molvera@quicinc.com>
 <20221118192241.29384-3-quic_molvera@quicinc.com>
 <20221202033721.4slwz2utw5u6rv7b@builder.lan>
 <9e4e6149-bc24-b727-fff7-3fb7038fc066@quicinc.com>
 <5cd9e71c-8147-2ce1-b137-0342e271031b@linaro.org>
 <82620abd-105a-6ebc-ae58-e77fa058852b@quicinc.com>
 <fd8b7bbb-088c-59ce-2b2a-c6c9edb3f1af@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <fd8b7bbb-088c-59ce-2b2a-c6c9edb3f1af@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZhTWLLyUzCfIiyjWRMVrg_8R8OaZaCVv
X-Proofpoint-ORIG-GUID: ZhTWLLyUzCfIiyjWRMVrg_8R8OaZaCVv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_11,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=921
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212150157
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/15/2022 10:47 AM, Dmitry Baryshkov wrote:
> On 15/12/2022 19:56, Melody Olvera wrote:
>>
>>
>> On 12/15/2022 12:44 AM, Krzysztof Kozlowski wrote:
>>> On 14/12/2022 19:59, Melody Olvera wrote:
>>>>>> +            #clock-cells = <0>;
>>>>>> +        };
>>>>>> +
>>>>>> +        sleep_clk: sleep-clk {
>>>>>> +            compatible = "fixed-clock";
>>>>>> +            clock-frequency = <32000>;
>>>>>> +            #clock-cells = <0>;
>>>>>> +        };
>>>>>> +
>>>>>> +        pcie_0_pipe_clk: pcie-0-pipe-clk {
>>>>> Afaict these clocks are not referenced anywhere, so please skip them.
>>>> Yes, so I included them to be consistent with the bindings. They will be needed later;
>>>> should I still remove?
>>>>
>>> If they are not referenced anywhere, how is it consistent with bindings?
>>> Where do the bindings require defining such nodes?
>>
>> These bindings here: https://lore.kernel.org/all/20221118181826.28269-2-quic_molvera@quicinc.com/
>> I believe you commented that we either have these clocks or we don't, correct? I added them to
>> the dt since these clocks exist and will be needed later when USB and PCIE nodes are added.
>> As Konrad noted, these technically belong in the PHYs, but I was told to put stub fixed
>> clocks instead here: https://lore.kernel.org/lkml/2c8c4642-8aee-3da3-7698-5e08b4c5894d@linaro.org/
>>
>> How is this to be handled? Should I remove the clocks from the dt and the bindings and add them
>> later when we need them? Do I leave stub clocks here with frequency 0 until needed? I am
>> very confused right now.
>
> You were told to use stub clocks in the bindings, not in the dtsi file. You can use <0> in the dtsi instead.

Oh ok that makes more sense. I appreciate the clarification.

Thanks,
Melody
>
>>
>> Thanks,
>> Melody
>>
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>

