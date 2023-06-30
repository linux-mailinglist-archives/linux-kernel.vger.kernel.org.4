Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A84874358D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 09:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjF3HNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 03:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjF3HMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 03:12:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78A2E61;
        Fri, 30 Jun 2023 00:12:49 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U6ceta030699;
        Fri, 30 Jun 2023 07:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=jt2pS5oCKPPpJdDr+9LeHYyKxWnudQFyLBE1tvyrWcg=;
 b=AOPWF5jDZBlgirlZUB4OMo1s3bfFRVgeK+r7H/u0+MeieIqW73Xepxmu8q3uhODvJnu0
 QEKkLdHot0feHKl20mALYfIoAeyjV8a+iO2qUwsEoZyT3owxLjMIqbZH+Hc3oT4uBPhI
 yroS43hpDnfq/GiOeVHz4qFXivnSDiz9RAJRcnFQOnUVdD6ZykCiAPOQMh2C3e+wBkzy
 iZFqdyI4yr+aLdbwb/pjmWmRPCsayepkbEG3HrGrsjde2MTB3rkxDh+3LrDNau2tmxyz
 aRLwu6KXPDPxxcMMKc9/7MLJX62Gg6bLrjpc2mjPREqQty9wDQ0kd1+/Pe0IgIFVNIgm tQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rhgpgs19u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 07:12:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35U7Cifm022544
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 07:12:44 GMT
Received: from [10.216.51.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Fri, 30 Jun
 2023 00:12:35 -0700
Message-ID: <c312824f-1438-d5de-d139-aaeb63f3c566@quicinc.com>
Date:   Fri, 30 Jun 2023 12:42:32 +0530
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
 <59d92b83-f759-50de-9b8b-834c3c0bec5a@quicinc.com>
 <8dbd8330-de83-b663-8105-e33c16687a88@linaro.org>
Content-Language: en-US
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <8dbd8330-de83-b663-8105-e33c16687a88@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bvBnhbVi4-n_4uI3Escbh0elivnyDBP5
X-Proofpoint-ORIG-GUID: bvBnhbVi4-n_4uI3Escbh0elivnyDBP5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_03,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=819 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306300060
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/24/2023 12:49 PM, Krzysztof Kozlowski wrote:
> On 21/06/2023 13:39, Manikanta Mylavarapu wrote:
>>>> on number of wcss radios connected on that board and only one instance
>>>> of 'qcom,ipq5018-q6-mpd'.
>>>>
>>>
>>> I don't understand why the user protection domains need a specific
>>> compatible. Why do they need compatible at all?
>>>
>>> Not mentioning that amount of your domains on Q6 is actually fixed per
>>> SoC and probably should not be in DT at all.
>>>
>>     root domain is fixed per soc (One Q6 DSP, one per soc)
>>     user domain(s) are variable (based on number of wcss radios attached)
>>
>>     The sequence to initialize, bring up, tear down the Q6 and wcss radios
>>     are completely different. So in order to differentiate them, we will
>>     need different compatibles. So this is a new rproc driver/architecture
>>     which has a parent/child topology (Q6 DSP -> Master/parent controls
>>     the WCSS (child)).
> 
> I understand you need different properties, but I don't see yet the
> benefit of creating here artificial compatibles. Look at your ipq9574
> DTSI change - it does not use even ipq9574 compatibles for 66% of its
> children.
> 
> Maybe you should have there just property describing type of device or
> bringup?
> 

	Yeah i got your point. Indeed the requirement here is to
	have device specific compatibles, so will have just two
	compatible one for Q6-MPD and another for WCSS-MPD device's


	"qcom,q6-mpd" --> For Q6-MPD device
	"qcom,wcss-mpd" --> For WCSS-MPD device

	Is this approach fine ?

> Given SoC cannot come with different amount of children (PD) and
> different amount of radios. You even fix the firmware name, so
> boards/customers cannot use anything else. It's fixed and the only
> variable element here is disabling some of the blocks per board, if they
> do not have physical interface (e.g. radio).
> 
> You even hard-code the number of PD by using "pd-[123]", without unit
> address, so you do not expect it will grow.
> 
> Unless you want to say that these are devices? But your binding does not
> really suggest it...
> 
> 
> 	Yes, as i mentioned above the requirement is to have device
	specific bindings. We will remove "PD-X" from soc dtsi and
	add it in board dts file.

	So soc dts would have "Q6-MPD" master node & board dts have
	"WCSS-MPD" child nodes based on number of radio's connected
	on board.

	Is this fine ?

Thanks & Regards,
Manikanta.
