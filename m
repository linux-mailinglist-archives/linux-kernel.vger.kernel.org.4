Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71CF6C4841
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjCVKwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjCVKw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:52:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD6E18E;
        Wed, 22 Mar 2023 03:52:26 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MAf2P0012721;
        Wed, 22 Mar 2023 10:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=60OWNRlXe0ot3c5VCrZO3+DqCLYnw5ggCs4T1AjOR4c=;
 b=X034lWNt0wmToGtCeYtj6BdGtrpxaQxmjROeN70x+2BaCcdla+nSU03MWaGtIWA5WECB
 6zXS7SBKuxLolX2US57pkDARzbf1fBdh+DYc+Z/QmHaJXUv9biNjOZFQ+aoyElceTyEp
 i88c0/T029HIedIvMyZvfbwpQ+6T2uBA9duRebTdTyHQQg5nuZDvldrtLJtSxgOACXTV
 0oIdJIphHLp09vYqXdlcs4DUAqs/W3fg+1SSu8F3GFrYXKPEh6DyOrGgq7IYB+ytUXCG
 4EvrUFmFYcLSr8d3IzqsxvN/59AWLhWwd3/xMi2tf3P0LVZdeupUa1ZMXeHhxR5/Nf9w IA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pfrk0s3x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 10:52:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32MAqKoA027963
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 10:52:20 GMT
Received: from [10.242.243.187] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Mar
 2023 03:52:11 -0700
Message-ID: <0bad147f-46b6-c52f-536f-92eeba8896ec@quicinc.com>
Date:   Wed, 22 Mar 2023 16:21:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 08/11] remoteproc: qcom: Add Hexagon based multipd rproc
 driver
To:     Robert Marko <robimarko@gmail.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <mathieu.poirier@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <quic_gurus@quicinc.com>,
        <loic.poulain@linaro.org>, <quic_eberman@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <quic_srichara@quicinc.com>,
        <quic_gokulsri@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_poovendh@quicinc.com>
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
 <1678164097-13247-9-git-send-email-quic_mmanikan@quicinc.com>
 <059bec3f-0c77-fc16-83a3-d78cf82d543f@linaro.org>
 <bb56bbb7-7b08-79f9-ad1b-a2de63eca5f6@quicinc.com>
 <CAOX2RU5H=fmxjAE+Er8n7qzrvUZmOpYwgqFox-RLc2C7BqJyjQ@mail.gmail.com>
Content-Language: en-US
From:   Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
In-Reply-To: <CAOX2RU5H=fmxjAE+Er8n7qzrvUZmOpYwgqFox-RLc2C7BqJyjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oax87b87NmZ1kh2Zb7s1o8l7ww_iyI7b
X-Proofpoint-ORIG-GUID: oax87b87NmZ1kh2Zb7s1o8l7ww_iyI7b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_07,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=549 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303220077
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/22/2023 3:51 PM, Robert Marko wrote:
> On Wed, 22 Mar 2023 at 11:19, Manikanta Mylavarapu
> <quic_mmanikan@quicinc.com> wrote:
>>
>>
>>
>> On 3/7/2023 9:09 PM, Krzysztof Kozlowski wrote:
>>> Why exactly do you need a new driver for this instead of extending
>>> existing PIL? I feel all this is growing because no one wants to touch
>>> existing code and merge with it...
>>
>> Previously we raised patch to add secure-pil to existing rproc driver.
>> Bjorn suggested to introduce a new secure-pil driver.
>>
>> https://patchwork.kernel.org/project/linux-arm-msm/patch/1611984013-10201-3-git-send-email-gokulsri@codeaurora.org/
>>
>>
>> Also IPQ5018, IPQ9574 soc's follows multipd model. So we decided to
>> have new driver which consists 'secure-pil + multi pd' in one
>> place.
> 
> Would it be possible to have IPQ8074 and IPQ6018 support in it as well?
> Cause, those are supported by ath11k but remoteproc support is missing,
> I have been upstreaming parts for IPQ8074 for years now and it is usable but
> we are still missing remoteproc.
> 
> Regards,
> Robert
> >>
>> Thanks & Regards,
>> Manikanta.

Yes. It's possible. Currently we added support for IPQ5018, IPQ9574.
In subsequent patches, we will add IPQ8074, IPQ6018 & IPQ5332 support
as well.

Regards,
Manikanta.
