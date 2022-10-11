Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280BB5FBB0B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiJKTFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiJKTFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:05:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC74895E8;
        Tue, 11 Oct 2022 12:05:23 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29BIw8mv015149;
        Tue, 11 Oct 2022 19:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EYm+I0EdSlNpd9mSd7z1h0MROHQQv6hwVSWzb1HFd6U=;
 b=D/3Q5HMstpCtUASMJXX88Ic3kJOf3zO9t8VkGSve/IgHJOxiQPkeJ+EbIK9rgMLzqHJF
 arvtdczrUPqW7RC4HTK2BsLeG0K3xF72mcV+epI45Ox8qMNS36/V5amKPLzX09mADX5a
 LmtLoHjSZ44dTg9dTD43TIICmHv/s1fJvZBu2cvCTbkardO64QmEEznwaNeDvEbRrYab
 LNlDmlfMsU6RVdgLUgtpVHlTFyB64WNUy/P0IqAKGhCGYWoYpqVtb4l3vGFBpCQpf+Fx
 MN+kPLyRXIh0u/2X7ReyZIWaQIWSWkIBmbqy2PaOyeQDjCIi1nfFDkehbANSMS+/Iv0W bg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k5e7fg0sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 19:05:20 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29BJ5JDW016241
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 19:05:19 GMT
Received: from [10.110.3.66] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 11 Oct
 2022 12:05:19 -0700
Message-ID: <3885c1d1-ab6f-2b30-2950-f4dc0ec54152@quicinc.com>
Date:   Tue, 11 Oct 2022 12:05:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 03/19] arm64: dts: qcom: qdru1000: Add tlmm nodes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221001030656.29365-1-quic_molvera@quicinc.com>
 <20221001030656.29365-4-quic_molvera@quicinc.com>
 <ad743621-8e2d-23f9-8c44-53f6681aa134@linaro.org>
 <7674b756-75d5-6ca3-d4fe-c54bd92a3fd7@quicinc.com>
 <ddb4566f-b420-6ee8-b3f5-3eeb83ad2d8b@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <ddb4566f-b420-6ee8-b3f5-3eeb83ad2d8b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: u4Mm87_TtmyBWd4HrZtw4i2Xk2pN-jEy
X-Proofpoint-GUID: u4Mm87_TtmyBWd4HrZtw4i2Xk2pN-jEy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_08,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=552 spamscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210110111
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2022 11:57 AM, Krzysztof Kozlowski wrote:
> On 11/10/2022 14:48, Melody Olvera wrote:
>>
>> On 10/1/2022 2:14 AM, Krzysztof Kozlowski wrote:
>>> On 01/10/2022 05:06, Melody Olvera wrote:
>>>> Add tlmm node for the QDU1000 and QRU1000 SoCs and the uart pin
>>>> configuration.
>>> The patchset should be squashed with previous. There is no point in
>>> bringing support piece by piece. You can bring support in steps if you
>>> submissions are separate in time. But if you have everything ready -
>>> your patch must be complete and bisectable.
>> To be clear, does it make more sense to submit the base dt first, then submit each
>> driver with all the dt changes as one patchset?
> No, because you have DTS ready. There is no incremental work here.
Ah ok so just squash all these commits into one and submit.
>
> Best regards,
> Krzysztof
>
Thanks,
Melody
