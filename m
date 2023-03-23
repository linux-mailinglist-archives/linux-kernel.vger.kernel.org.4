Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00326C69DB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjCWNrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCWNrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:47:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B052941F;
        Thu, 23 Mar 2023 06:47:17 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N0E7xS008940;
        Thu, 23 Mar 2023 13:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tn5oN4OGY3D8ogJm99PdOQJFXFp0aIXrB2RsMtn6Kpg=;
 b=TpmnKBxfQU1kPWn0nBkCp6Et5ApDhHedaMR8fSkihXyrowCdJkGKRKkj3ozWQCkBslj1
 dzVCBHCirllo6Ubwssoz7jpq3PqfQBhz/72FNpxIa1RNfeWWLipNz3wcH71pSgzBCkgt
 2Kidwr8m2Xd3GyjivP5Vk40r4U2OFgPX1PK1ZTxjQD0cE5WNvNOvrjhwQI9Kvv0LiXq0
 /GshXRHuG8ckMxm2/uOJO9CIy4KBmNddcPOzS1gUEDH3rbU2VjsxQercDXjCVV+A6Snd
 xGIB7DkRcS3Jil6EOiprZoXRAMWlo9tQth4KVX5JhU1GOjktgqWh8Q/86D/jQ/QIkRrD kQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pg64k2f2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 13:47:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32NDkxwI002480
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 13:46:59 GMT
Received: from [10.50.6.215] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 23 Mar
 2023 06:46:56 -0700
Message-ID: <c1ff949f-64bd-fd1b-5e84-484b641691fb@quicinc.com>
Date:   Thu, 23 Mar 2023 19:16:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V1 1/4] dt-bindings: sram: qcom,imem: Add Boot Stat region
 within IMEM
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1679403696.git.quic_schowdhu@quicinc.com>
 <1589f33deda07cb9f9e6c3c26bce6e02e53c168e.1679403696.git.quic_schowdhu@quicinc.com>
 <c0c6c79b-ac77-cdbf-5b08-38b89e4fe481@linaro.org>
 <260cf3ae-1acd-c4ac-a42d-4ca848ec5664@quicinc.com>
 <e1d53083-82b6-d193-517e-02af281a066a@linaro.org>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <e1d53083-82b6-d193-517e-02af281a066a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bTkrskqnnOGt77AB0J3QXND3vZzUiDqA
X-Proofpoint-ORIG-GUID: bTkrskqnnOGt77AB0J3QXND3vZzUiDqA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxlogscore=608 phishscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230104
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/22/2023 9:57 PM, Krzysztof Kozlowski wrote:
> On 22/03/2023 14:34, Souradeep Chowdhury wrote:
>>>
>>>> +          - const: qcom,imem-boot_stats
>>>
>>> No underscores in compatibles. Why this is not SoC specific compatible?
>>
>> Ack. The boot_stats module is not specific to a device. It is written to
>> read some values from this imem region which is present for almost all
>> QCOM SoCs. So SoC specific compatible is not given in this case.
> 
> Yeah, but the generic rule is that we always want SoC specific
> compatibles. If this is not specific to a device, then you do not need
> anything in DT and just instantiate it from some soc-driver...

Ack. Will add SoC specific compatible here.

> 
> Best regards,
> Krzysztof
> 
