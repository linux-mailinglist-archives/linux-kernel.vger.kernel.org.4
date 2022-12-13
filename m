Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7BB64B0C3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 09:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbiLMIGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 03:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbiLMIG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 03:06:27 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0334611833;
        Tue, 13 Dec 2022 00:06:25 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD7hs3q027625;
        Tue, 13 Dec 2022 08:06:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MeZ7LASqrJonyc43RPQHlyLqvNIQxunbB53nG2hUc5Y=;
 b=bvZvaCELzCracBw4kBup4wtRLj6TCrAlLB3kNajw3cX82H077nAK4IfiZc5qjn4gCMff
 0Xmor2PKP849BEz4uD68y6p2PyENFYDpdXl/gBUKXRDcd8iZGFKQ65sC6luCHinjiym8
 RXXV/GJZPzM7NvbMq3vnY8a6wW6j8tnarmYEb19ClVA+JKuTTzdYon4O22TnNrx8mh5q
 PlOSGmGiQuYlZx4jwLzH6c0LX5yv3CUUPJGv8w7GdJT3Y6XY74oW4CR1y5Anygyomi9p
 d+W5gGQdZZ1teQTA/ye/DmcSKuUPS4AYZN0H2htOIyfbMxCt0p9Ef07zte4C+q/QDAYp fg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mchq76gdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 08:06:20 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BD86FqL006916
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 08:06:16 GMT
Received: from [10.206.12.35] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 13 Dec
 2022 00:05:58 -0800
Message-ID: <09fbf4af-f1c6-828f-3ca6-3f06ff83b5ce@quicinc.com>
Date:   Tue, 13 Dec 2022 13:35:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4] arm64: dts: qcom: sa8540p-ride: enable pcie2a node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <johan@kernel.org>
CC:     <bmasney@redhat.com>, kernel test robot <lkp@intel.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221213051109.8685-1-quic_shazhuss@quicinc.com>
 <f4102715-45b7-1196-878e-e0adce0d8c96@linaro.org>
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
In-Reply-To: <f4102715-45b7-1196-878e-e0adce0d8c96@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qaj7h9EkGxGGdK2AZumREmS-Fjuw3OK2
X-Proofpoint-ORIG-GUID: qaj7h9EkGxGGdK2AZumREmS-Fjuw3OK2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 clxscore=1011 mlxlogscore=777 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212130074
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/2022 1:31 PM, Krzysztof Kozlowski wrote:
> On 13/12/2022 06:11, Shazad Hussain wrote:
>> Add the pcie2a, pcie2a_phy, and respective tlmm
>> nodes that are needed to get pcie 2a controller
>> enabled on Qdrive3.
>>
>> This patch enables 4GB 64bit memory space for
>> PCIE_2A to have BAR allocations of 64bit pref mem
>> needed on this Qdrive3 platform with dual SoCs
>> for root port and switch NT-EP. Hence this ranges
>> property is overridden in sa8540p-ride.dts only.
>>
>> Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
>> Reviewed-by: Brian Masney <bmasney@redhat.com>
>> Reported-by: kernel test robot <lkp@intel.com>
> 
> Drop, robot did not report this patch.
> 

You mean I should keep only Kernel test as Reported by ?

>> ---
>> Changes since v3:
>> - Fix syntax error and add Reported-by (Kernel test robot)
> 
> So the previous patch was not even build... thus 100% not tested. Is
> this one at least built?
> 

I built that, but after running checkpatch with --fix, I think it 
dropped the closing brace of tlmm. My bad :|

Yes, v4 is compiled and 100% tested.

-Shazad

> Best regards,
> Krzysztof
> 
