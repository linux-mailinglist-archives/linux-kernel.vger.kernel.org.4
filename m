Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7472D620E06
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbiKHLBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbiKHLBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:01:30 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C2345EDF;
        Tue,  8 Nov 2022 03:01:29 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A8AMfHC030637;
        Tue, 8 Nov 2022 11:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=b8ful+Ico9cTg5FCbvxSJcqiOop2CXximVnBcSFM/x4=;
 b=BFZLhCd25oN1JQXFyvawgxBXRCyYova+GKqwvJrLJTdhgL3BcdNS4YwapF8pQS3hZ2eI
 ioGxJ12has4fB8EFz/0KLYCro68hGOBUdPuvBQp/gDvJGNJjN5cO6fuK7COhUAY66VbI
 XyQSjkb4Sm6P0kOad7nhkbnlKmUikcE2Vht3RInenLeXrpJzcDRxMUVkTp/Hcm7/9pwR
 Zkd6kjHdkGFKzm5rteb1RcSHhjtrbm4+6AdZ6tD485Z2GHIa1Zg29J1e2mjiWOBBVs5W
 O2bTESNztHR4KSlkATBV+CVMY0dM4noOzNH+XpErytMizi2jMx7pTPcZmgrHkSVmbiFa /A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kqhmggj7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 11:01:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A8B1IkG021849
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Nov 2022 11:01:18 GMT
Received: from [10.79.43.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 8 Nov 2022
 03:01:15 -0800
Message-ID: <dad47960-6c91-3b77-4371-db649de0c147@quicinc.com>
Date:   Tue, 8 Nov 2022 16:31:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC 0/2] Add support for SCMI QTI Memlat Vendor Protocol
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <sudeep.holla@arm.com>, <agross@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <konrad.dybcio@somainline.org>,
        <quic_avajid@quicinc.com>, <souvik.chakravarty@arm.com>
References: <1667451512-9655-1-git-send-email-quic_sibis@quicinc.com>
 <Y2OMpiMXcaEiiA/2@e120937-lin>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <Y2OMpiMXcaEiiA/2@e120937-lin>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OVAiJ6J_y-sOXeBB5zq_9fDSTte_3FAD
X-Proofpoint-ORIG-GUID: OVAiJ6J_y-sOXeBB5zq_9fDSTte_3FAD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 impostorscore=0 adultscore=0 suspectscore=0 mlxlogscore=975
 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211080061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Cristian,
Thanks for taking time to review the series.

On 11/3/22 15:11, Cristian Marussi wrote:
> On Thu, Nov 03, 2022 at 10:28:30AM +0530, Sibi Sankar wrote:
>> The patch series documents the bindings and adds support for the
>> SCMI QTI memlat (memory latency) vendor protocol. The protocol takes
>> in several tuneables including the IPM ratio (Instructions Per Miss),
>> bus bandwidth requirements and PMU maps to enable frequency scaling
>> of various buses (L3/LLCC/DDR). The scaling is performed by the HW
>> memory latency governor running on the CPUSS Control Processor.
>>
>> Depends on CPUCP mailbox driver:
>> https://patchwork.kernel.org/project/linux-arm-msm/cover/1663135386-26270-1-git-send-email-quic_sibis@quicinc.com/
>>
> 
> [+ CC: souvik.chakravarty@arm.com ]
> 
> Hi Sibi,
> 
> Nice to see vendor protocols starting to make their way into upstream !
> 
> I only glanced through the series as of now, and I'd have a few
> questions before going on with the review:
> 
>   - why this protocol is dependent on a specific transport ?
>     Is it to compile it only on platform supoprting it without adding
>     a per-protocol Kconfig ?

It was done just to compile it on platforms supporting it but it doesn't
have to done that way. I remove the dependency during the next re-spin.

- Sibi

> 
> Protocols are anyway enumerated at SCMI stack probe time so even if it
> is not there it just won't be activated...I maybe missing something.
> 
> Thanks,
> Cristian
> 
> 
> 
