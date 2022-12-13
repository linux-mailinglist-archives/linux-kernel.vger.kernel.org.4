Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FF964B7B0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbiLMOqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbiLMOqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:46:16 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50188F39;
        Tue, 13 Dec 2022 06:46:14 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDDZLYf006070;
        Tue, 13 Dec 2022 14:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EGe9MlTvJ2aLFex6rOiIFHMOwOeimXkvfudSdAnLD/w=;
 b=QpJDUxGkHJTTBdPWkFn0njkCmMd/5C9Rdw4FcvdCXbSmUhbLrM2d1CrRouckzUvrURA6
 VYVAxKRmyXtO934EAMC7LHVzvmS7WhnolT7adC3JqP6s4KzJe51dLiYyyqOmeW3B2MN2
 4l0F+r1ud/yOpSHQ9iLFKfmTEyUckDnJGTOqPxIX4qb9lZ/AdZLuH+TqbYNz4sFmbIo4
 izbxtiMJf+KQFnlypTmQGDgkymofimh5f+iQyYCa/CUreFWItyj7p4PGnDEMKS95wHfC
 GiKbudaaob4F1yKEXFjcvKZo527AlC6wA4hrkVQgR4uDO4P58bvZ7TP9uZK/joCCM6uB Tw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3meq7qguua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 14:46:06 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BDEk6NO022048
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 14:46:06 GMT
Received: from [10.216.48.1] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 13 Dec
 2022 06:46:01 -0800
Message-ID: <91663103-b675-5b68-1cc7-21bce4579b9e@quicinc.com>
Date:   Tue, 13 Dec 2022 20:15:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sc8280xp: add missing spi nodes
Content-Language: en-US
To:     Brian Masney <bmasney@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <johan+linaro@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ahalaney@redhat.com>,
        <echanude@redhat.com>, <linux-spi@vger.kernel.org>
References: <20221212182314.1902632-1-bmasney@redhat.com>
 <20221212182314.1902632-5-bmasney@redhat.com>
 <c1c7b1eb-08e7-2ba5-d89a-e0be8f76fd69@quicinc.com> <Y5hvlX35nr8xQKEd@x1>
 <77c29d8c-34b3-f508-26bf-22520ccc1f2a@linaro.org>
 <13238048-f07c-3e8d-f170-5330ce94767c@redhat.com> <Y5iN48rA899u1++7@x1>
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
In-Reply-To: <Y5iN48rA899u1++7@x1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -pg7YRXxxA3ON0XKPz1esOtYT0GSG9Vy
X-Proofpoint-ORIG-GUID: -pg7YRXxxA3ON0XKPz1esOtYT0GSG9Vy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=747 suspectscore=0
 adultscore=0 priorityscore=1501 clxscore=1011 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212130131
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/2022 8:06 PM, Brian Masney wrote:
> On Tue, Dec 13, 2022 at 02:08:47PM +0100, Javier Martinez Canillas wrote:
>> On 12/13/22 14:02, Krzysztof Kozlowski wrote:
>>> On 13/12/2022 13:27, Brian Masney wrote:
>>> qcom,spi-video-codec is still not specific enough. You need to describe
>>> real device behind spidev. To be clear - you do not describe userspace,
>>> but the device.
>>>
>>
>> Agree.
>>
>> I believe Brian just used "qcom,spi-video-codec" as an example but is only
>> a make up name to illustrate the concept. QC needs to determine what would
>> be the correct <vendor,device> tuple for the IP block that the user-space
>> driver will drive.
> 
> Yes, that was just an example.
> 
> Shazad: Is this thread clear about what QC needs for spidev? I'll let QC
> take care of sending patch(es) to add the various compatibles since I'm
> not sure what hardware will be backed by spidev.
> 

I think for qup2_spi22 we can use qcom,spi-msm-codec-slave as 
compatible. As this is what used in downstream.

> I'll take care of making sure that sc8280xp.dtsi gets the spi controller
> nodes added.

Yes, for qup1_spi9 we can add it later when needed. This is for 
display/touch 2nd.

Shazad

> 
> Brian
> 
