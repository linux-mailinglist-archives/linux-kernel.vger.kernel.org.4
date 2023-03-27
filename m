Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BE96C9B38
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 07:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjC0F7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 01:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjC0F7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 01:59:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28CF422E;
        Sun, 26 Mar 2023 22:59:01 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R3ZOv3006665;
        Mon, 27 Mar 2023 05:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7B3yW0+H7NpN6nj77BRnEY1kEY3Viw271PRPqL6QsAo=;
 b=DsOwfWEP5nccImcwdZvloriXv0U732SP7plfFjFe6GeORxVGxpq37yCZzr5X2ZyJ1gB3
 7hymE1ROG9e28J0CuHWorSf0PxHrMqQRbJohZDJ7W5phoVcQEo0cFaQ2kT/BCGgyQPrc
 xVytAZZzmvdraidQXNZ1VlPQ/6EyYA3uNnMAl7asVn1Krq/prwSRo8bIt3MK+k7joFdv
 5RFqzjd8eZ+ueeOsAKf2QwRhXJxHwm1CQfu64sr6NIhyk7PehqWWC9vQnDHnTMiL5c/H
 xGH+lF1yap7RI9dNdF6nnm8FBLDgExtUKir88gakTPpWP6XPL00ybuVi2wEBt+BFuSwz qQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3phsvj3fnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 05:58:44 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32R5whOw021923
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 05:58:43 GMT
Received: from [10.253.35.148] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 26 Mar
 2023 22:58:36 -0700
Message-ID: <f4be1a7e-589e-84a6-94a6-0f7c63ebd94b@quicinc.com>
Date:   Mon, 27 Mar 2023 13:58:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: Add Coresight Dummy Trace YAML
 schema
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>
CC:     Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-doc@vger.kernel.org>
References: <20230324061608.33609-1-quic_hazha@quicinc.com>
 <20230324061608.33609-3-quic_hazha@quicinc.com>
 <fed08b5e-737e-c253-38ac-5b29004b5eac@arm.com>
From:   Hao Zhang <quic_hazha@quicinc.com>
In-Reply-To: <fed08b5e-737e-c253-38ac-5b29004b5eac@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IJK8QiV9M4cumvCE_-64lYzc7nqQaLz1
X-Proofpoint-ORIG-GUID: IJK8QiV9M4cumvCE_-64lYzc7nqQaLz1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=857 impostorscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270049
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 3/24/2023 6:47 PM, Suzuki K Poulose wrote:
> On 24/03/2023 06:16, Hao Zhang wrote:
>> Add new coresight-dummy.yaml file describing the bindings required
>> to define coresight dummy trace in the device trees.
>>
>> Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
>> ---
>>   .../bindings/arm/qcom,coresight-dummy.yaml    | 118 ++++++++++++++++++
>>   1 file changed, 118 insertions(+)
>>   create mode 100644 
>> Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml
>>
>> diff --git 
>> a/Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml 
>> b/Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml
>> new file mode 100644
>> index 000000000000..7b719b084d72
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/qcom,coresight-dummy.yaml
>> @@ -0,0 +1,118 @@
>> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
>> +# Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/arm/qcom,coresight-dummy.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: QCOM Coresight Dummy component
> 
> As mentioned in the previous email, please make this Arm CoreSight. This
> is not specific to Qcom, rather something the CoreSight driver exposes
> as a dummy framework. Otherwise looks good to me.
> 
> Suzuki
> 

Thanks for your comment, I will take your advice and update it in the 
next version of patch.

Thanks,
Hao
