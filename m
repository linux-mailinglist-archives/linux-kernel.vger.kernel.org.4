Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508245EC472
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbiI0N3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbiI0N2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:28:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97DE1B5244;
        Tue, 27 Sep 2022 06:24:02 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RC0YoU002831;
        Tue, 27 Sep 2022 13:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=REne0rFZeUne3WZwhw7vlLiRIJAbtmQ7qs7Su0Z39Tc=;
 b=CwAoNDT79g3u/ZXcIWYAG9kI9TuyKh13ryciVwfEdtj8k2yPdxv+7vH27YDEvLW+yPYG
 U5O2vGwCjIU1sZBa73ywTHLe8VEldgFi4Dq2dHSeqHEY8PrLIB/r/zNWib7dNwwwrHKt
 cFwudd360cfAO9xvuwj0ij63VJN1BeCt1mKV6R8duFHQ3zO2Lmaq73Mu2+hZAjobVjES
 ajLiLxTgdXeRu825AbID4B8CZU1scchukvFitADEfdpZRQKuneAT1geszdJ0eNKuA9xS
 0lRmaxLQl+BVaEMxFWoKb2QejWnwwPmIgY1Y/58Chhaf+r939PozoIru9UZrlMP53Qgh 8Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jupssspug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 13:21:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28RDLkpG016337
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 13:21:46 GMT
Received: from [10.216.22.231] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 27 Sep
 2022 06:21:41 -0700
Message-ID: <23dd9c44-df18-3b54-9150-e4e57f1d49bd@quicinc.com>
Date:   Tue, 27 Sep 2022 18:51:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 7/7] remoteproc: qcom: Add support for memory sandbox
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>
References: <1663938340-24345-1-git-send-email-quic_srivasam@quicinc.com>
 <1663938340-24345-8-git-send-email-quic_srivasam@quicinc.com>
 <a15fa97e-de7d-c2a6-e39a-2dd7ba8caf31@linaro.org>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <a15fa97e-de7d-c2a6-e39a-2dd7ba8caf31@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Cy_HqGZmPi03KkJOFvN13e8lVzurty3Q
X-Proofpoint-ORIG-GUID: Cy_HqGZmPi03KkJOFvN13e8lVzurty3Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_05,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=916
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209270081
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/23/2022 10:56 PM, Krzysztof Kozlowski wrote:
Thanks for Your time Krzyszto!!!
> On 23/09/2022 15:05, Srinivasa Rao Mandadapu wrote:
>> Update pil driver with SMMU mapping for allowing authorised
>> memory access to ADSP firmware, by carveout reserved adsp memory
>> region from device tree file.
>>
>
> Thank you for your patch. There is something to discuss/improve.
>
>> +	if (!rproc->domain)
>> +		return -EINVAL;
>> +
>> +	ret = of_parse_phandle_with_args(adsp->dev->of_node, "iommus", "#iommu-cells", 0, &args);
> I think your bindings do not allow iommus property.
Okay. Will add iommus in dt-bindings.
>
> Best regards,
> Krzysztof
>
