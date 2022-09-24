Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD765E8BEA
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 13:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiIXLwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 07:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiIXLw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 07:52:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B739FA96;
        Sat, 24 Sep 2022 04:52:25 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28OBpsW3024572;
        Sat, 24 Sep 2022 11:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dHm1EWWuungTPeKK2A5PKCuBH3XViDFVxl966L/3GJ8=;
 b=LqbTEKa5o/oAKMJ652Jd3tjVcmEcz5JMqfOWqiek5f8NH54f3yMioQbfLUAygaaySQjH
 MgnWA8lMFVzs+8T+2Q3VRHyGxTNLGfVJ/SBf1Cb4jvrtbXC6/dHTd+Yx3wzgo10/7ZaK
 dxpIfq0Ezk5C/RMVMpL7PvgFZ5R4eJty5IYjo54NCvg+ZZQSetPB8jNVdh0z//ofFbPy
 1RkXWDPf9s2+47MMURI8ckCSqumIBuP6kSQln4byT91Q/aPsqmgV9uYKLa/e61m/Svnv
 ul4OwJEOOImj0YcHrVyq4AFdn6jT/4C5dOVwGlyw2H5ld2h6cg7y2mhqrVC3cJmEl+36 vw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jsqkm8v5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Sep 2022 11:52:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28OBlIFf017536
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Sep 2022 11:47:19 GMT
Received: from [10.110.112.23] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sat, 24 Sep
 2022 04:47:13 -0700
Message-ID: <d7954d8e-e66c-7b69-e444-fd3f434156bc@quicinc.com>
Date:   Sat, 24 Sep 2022 17:17:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V13 3/7] MAINTAINERS: Add the entry for DCC(Data Capture
 and Compare) driver support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@ieee.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>, <vkoul@kernel.org>
References: <cover.1663642051.git.quic_schowdhu@quicinc.com>
 <cdd67dd71a6c8559d2771ac453b472a5c3ee1897.1663642052.git.quic_schowdhu@quicinc.com>
 <eceb4006-e5a5-fa8a-b855-f99306cc9593@linaro.org>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <eceb4006-e5a5-fa8a-b855-f99306cc9593@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xK2dDR5fsZT1m8zoRsilzF6mdOeR1fSm
X-Proofpoint-GUID: xK2dDR5fsZT1m8zoRsilzF6mdOeR1fSm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-24_04,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=834 lowpriorityscore=0
 suspectscore=0 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209240088
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/24/2022 1:33 AM, Krzysztof Kozlowski wrote:
> On 20/09/2022 05:57, Souradeep Chowdhury wrote:
>> Added the entries for all the files added as a part of driver support for
>> DCC(Data Capture and Compare).
>>
>
>> +F:	Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml
> arm is only for top level nodes/properties. Please put your bindings in
> respective subsystem.
Ack
>
> Best regards,
> Krzysztof
>
