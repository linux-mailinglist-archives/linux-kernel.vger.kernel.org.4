Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B01173832A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjFULkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 07:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFULkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:40:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76530DC;
        Wed, 21 Jun 2023 04:40:07 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35L7kTlC019092;
        Wed, 21 Jun 2023 11:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=078OnJL9eWPbxIL0vwydxfSX62v4i63byCazg/1gUZY=;
 b=cH8cTCE/TZjpLxN7VquJJsFdADFnmPTlVZ0bRGfbeXTMlBTxnEz5D9FNe3teSMNlfWyf
 rM+hMoNUoNlAA+y81SLmvXXlwc2m7bsx5EIl0GcT58zRZfsH6NPNhC/krGqJCMeyPArC
 O/qBsv6DR4zGuav2t3WWSK+FwY1GCrT+rkAjzBlJJPC+CoEGYt/rHb4AwEPZXhryB/k8
 3yo7NnuBAHZw7mz2OQBJuQQCh59abzebyMApO+RHhgN7cGohuCFSxpfjHEHT8Uvlgg8g
 iamQ7UjrcJ0LRu4O1TTkER3gF4iRmgaPuoib6+I4m/OBLoPnF/P2Px5IOBYlkNNzKFFQ OQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rbqjb92qb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 11:40:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35LBe0Zc000699
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 11:40:00 GMT
Received: from [10.201.206.238] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 21 Jun
 2023 04:39:52 -0700
Message-ID: <59d92b83-f759-50de-9b8b-834c3c0bec5a@quicinc.com>
Date:   Wed, 21 Jun 2023 17:09:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH V2 01/13] dt-bindings: remoteproc: qcom: Add support for
 multipd model
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kalle Valo <kvalo@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <jassisinghbrar@gmail.com>, <mathieu.poirier@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_eberman@quicinc.com>, <quic_mojha@quicinc.com>,
        <loic.poulain@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_devipriy@quicinc.com>
References: <20230521222852.5740-1-quic_mmanikan@quicinc.com>
 <20230521222852.5740-2-quic_mmanikan@quicinc.com>
 <7940c743-815f-f864-d015-43d7e916ecfa@linaro.org>
 <a1456f62-d0a7-d5ec-b379-db1b6035c89c@quicinc.com>
 <d187eafb-4a80-9479-d063-3a01b47d8efa@linaro.org>
 <feb0d11d-0930-d0b8-ab6e-cf477bbf114b@quicinc.com>
 <87edmoitu3.fsf@kernel.org>
 <0555c089-9d0d-7d19-9646-f0f9b8630d12@quicinc.com>
 <5f9cc367-eaa5-4c19-4e5e-7052b0259ccf@linaro.org>
 <04f5e3cb-d2f5-747c-1fd0-4b61d845e2c5@quicinc.com>
 <36900050-2ffd-b5dd-f768-986624a83c70@linaro.org>
Content-Language: en-US
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <36900050-2ffd-b5dd-f768-986624a83c70@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YT6PFLoYh6swOLeOEz0csnKkTh6Q8MyP
X-Proofpoint-GUID: YT6PFLoYh6swOLeOEz0csnKkTh6Q8MyP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_07,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxlogscore=758
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306210097
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/2023 7:29 PM, Krzysztof Kozlowski wrote:
> On 14/06/2023 13:43, Manikanta Mylavarapu wrote:
>>>>>>>>>> +    properties:
>>>>>>>>>> +      compatible:
>>>>>>>>>> +        enum:
>>>>>>>>>> +          - qcom,ipq5018-wcss-ahb-mpd
>>>>>>>>>> +          - qcom,ipq9574-wcss-ahb-mpd
>>>>>>>>>> +          - qcom,ipq5018-wcss-pcie-mpd
>>>>>>>>>
>>>>>>>>> Keep rather alphabetical order (so both 5018 together).
>>>>>>>>>
>>>>>>>>> I also do not understand these at all. Why adding bus type to
>>>>>>>>> compatible? This rarely is allowed (unless it is PCIe controller within
>>>>>>>>> soc).
>>>>>>>>>
>>>>>>>> IPQ5018 SOC has in-built PCIE controller. Here QDSP6 will bring up
>>>>>>>> external(PCIE) and internal (AHB) wifi radio's. To separate AHB, PCIE
>>>>>>>> radio's properties, i have added bus type to compatible.
>>>>>>>
>>>>>>> It's the same device - WCSS - right? We do not create multiple nodes and
>>>>>>> compatibles for the same devices. Bus suffixes are almost never parts of
>>>>>>> compatibles.
>>>>>>
>>>>>>
>>>>>> No it's not the same device. WCSS on inside IPQ5018 and WCSS attached
>>>>>> via pcie to IPQ5018. Here QDSP6 managing both WCSS's.
>>>>>>
>>>>>> So for better clarity i will use attached SOC ID in compatible.
>>>>>> Below are the new compatible's.
>>>>>>
>>>>>> - qcom,ipq5018-wcss-mpd //IPQ5018 internal radio
>>>>>> - qcom,ipq9574-wcss-mpd	//IPQ9574 internal radio
>>>>>> - qcom,qcn6122-wcss-mpd //IPQ5018 attached radio
>>>>>
>>>>> What mandates that there's just one QCN6122 device attached to PCI?
>>>>> Assuming fixed PCI configurations like that makes me worried.
>>>>>
>>>>
>>>> IPQ5018 always has one internal radio, attached pcie radio's depends on
>>>> no of pcie ports. IPQ5018 has 2 pcie ports, so it supports max two
>>>> qcn6122 devices. One compatible (qcom,qcn6122-wcss-mpd) itself support's
>>>> number of pcie devices controlled by QDSP6.
>>>
>>> So this is hot-pluggable (or at least board-pluggable), then should not
>>> be a part of static DTS.
>>>
>>> Some concepts of virtual-processes is anyway far away from hardware
>>> description, thus does not fit into DTS. Adding now to the equation PCIe
>>> with variable number of such processes, brings us even further.
>>>
>>> This is not a DT property. Remember - DT describes hardware.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> In the multipd architecture based Socs, There is one Q6 DSP which runs
>> the OS/kernel and there are one or more instances of WCSS radios
>> (It can be either internal or pcie attached).
>> These WCSS cores are controlled by the Q6 (Q6 DSP brings wcss radios out
>> of reset/ shuts it down etc). Q6 forms the 'root Protection domain' and
>> the wcss radios are termed as the 'user protection domain'.
>> The compatible's that is being added here are to manage the 'root
>> domain' and 'user domain'.
>> Not sure if using the words 'pcie'/'ahb' made it confusing.
>> So, 'qcom,ipq5018-q6-mpd' and 'qcom,ipq5018-wcss-mpd'.
>>
>> There will be multiple instances of 'qcom,ipq5018-wcss-mpd' in DT based
>> on number of wcss radios connected on that board and only one instance
>> of 'qcom,ipq5018-q6-mpd'.
>>
> 
> I don't understand why the user protection domains need a specific
> compatible. Why do they need compatible at all?
> 
> Not mentioning that amount of your domains on Q6 is actually fixed per
> SoC and probably should not be in DT at all.
> 
   root domain is fixed per soc (One Q6 DSP, one per soc)
   user domain(s) are variable (based on number of wcss radios attached)

   The sequence to initialize, bring up, tear down the Q6 and wcss radios
   are completely different. So in order to differentiate them, we will
   need different compatibles. So this is a new rproc driver/architecture
   which has a parent/child topology (Q6 DSP -> Master/parent controls
   the WCSS (child)).

> Qualcomm puts so many so weird stuff into DT which is not a hardware
> description. I understand that everything is there a firmware, but then
> make it discoverable for example...
> 

    Hmm, in order to init/bring up these domains, clks, resets
    and some more register access are required. Q6 FW does not have
    access to all these resources. Also, HLOS rproc driver is needed to
    listen on all the events related to  these domains just like any
    other rproc driver.

Regards,
Manikanta
