Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C61E73C334
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 23:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjFWVsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 17:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjFWVri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 17:47:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD09826A5;
        Fri, 23 Jun 2023 14:47:35 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NLPXRv029340;
        Fri, 23 Jun 2023 21:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=14gEaeLW4pNISh2vGcTr8PgRp5tUlVAFcst+UrNXJTE=;
 b=dWOXmJui6IXd7u/rj1wEerZq/xamBnbAnn0VNJvk+OBGnS15EdJuvXy0apMMTMYhlRlJ
 5I05N+X1+kY9BSA141AgLrXv/e6NeDRWE/l88vE5QNErrvV4WnhoIdhk+FeqPQ2NvJ/2
 q8/ES1+VXDxxdSAVpBMYwPPfIV7ozqI9Yj5aXQo6Vz57c/BOXHwDxZOCg5be1FW17tdz
 b8a8yicmHhNmGu5jscS6d3H7tmGX07DWpguDljVHtT4uXWnSd5Z45UwMtUd/E6UKsoTF
 ia/yC0gKBt8gz8Bd9Vf8e9L94fvSoaxzqzs5ZvSNA38swDrjscEFwjqPuw7ABqVeCEls kg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rcju84jxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 21:47:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35NLlRS3019093
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 21:47:27 GMT
Received: from [10.110.61.170] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 23 Jun
 2023 14:47:26 -0700
Message-ID: <26e3a5a5-2fcb-34ca-4644-8c37bd17a1e9@quicinc.com>
Date:   Fri, 23 Jun 2023 14:47:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Freedreno] [PATCH 3/3] drm/msm/dsi: Enable DATABUS_WIDEN for DSI
 command mode
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>
CC:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        <freedreno@lists.freedesktop.org>, Sean Paul <sean@poorly.run>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        <linux-arm-msm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        David Airlie <airlied@gmail.com>
References: <20230525-add-widebus-support-v1-0-c7069f2efca1@quicinc.com>
 <20230525-add-widebus-support-v1-3-c7069f2efca1@quicinc.com>
 <ky7sgsaohak2pcdf6pbhedfyrwk4ea7y3ekfqlw7rn6cpk4rhe@rjuhb23n37oz>
 <cf968ab4-e4c4-dcad-f7d1-4edff6f08147@quicinc.com>
 <xrqiat4otnfwtss6zwubh77qx3frdyi77flna2xljzycvr6r2v@riimvmhoondt>
 <654ccc4c-40c2-bef6-9f47-847216e16cb0@quicinc.com>
 <daqhyz4rtgdxthsezmgk6t2egbdsvzsdy3cihrqrhyveoqbizi@etq2tafkucg2>
 <117d21da-aa44-9439-5d5b-9a9144b53979@quicinc.com>
 <q7ysvtgkhvc3fv4ib65li6hb3p5aw2hfp4ck3d4afuvqxjopzj@mbsg3zr3pint>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <q7ysvtgkhvc3fv4ib65li6hb3p5aw2hfp4ck3d4afuvqxjopzj@mbsg3zr3pint>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5Cp2f5JGdEU7wnTmFiO_bY3hGZC4K5Gr
X-Proofpoint-GUID: 5Cp2f5JGdEU7wnTmFiO_bY3hGZC4K5Gr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_12,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 phishscore=0 suspectscore=0 mlxlogscore=828
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306230196
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/23/2023 2:33 PM, Marijn Suijten wrote:
> On 2023-06-23 13:34:06, Abhinav Kumar wrote:
>>
>>
>> On 6/23/2023 1:14 PM, Marijn Suijten wrote:
>>> On 2023-06-23 10:29:51, Abhinav Kumar wrote:
>>> <snip>
>>>> The concept is quite simple
>>>>
>>>> one pixel per clock for uncompresssed without widebubus
>>>>
>>>> 2 pixels per clock for uncompressed with widebus (only enabled for DP
>>>> not DSI)
>>>>
>>>> 3 bytes worth of data for compressed without widebus
>>>>
>>>> 6 bytes worth of data for compressed with widebus
>>>>
>>>> When compression happens, we cannot quantify with pixels as the boundary
>>>> is not defined with respect to bytes.
>>>>
>>>> You brought up uncompressed in your below comment so I assumed your
>>>> question of /2 was about uncompressed too.
>>>
>>> No clue where things are going wrong, but you either avoid or
>>> misunderstand the question.
>>>
>>> (Talking exclusively about compressed data here!)
>>>
>>> pclk is determined based on the number of bytes.
>>>
>>> When widebus is enabled, we transfer twice as many bytes per pclk cycle.
>>>
>>> Can pclk be reduced by a factor two, as that should still be enough to
>>> transfer the same amount of bytes when widebus is enabled?
>>>
>>
>> I dont know where the misunderstanding is too.
>>
>> I already did answer that pclk can be /2 for uncompressed.
> 
> Except that my question is about compressed.
> 
>> But for compressed it will be divided by the compression ration.
> 
> The question here is "why exactly"?  I am looking for the argument that
> justifies pclk being twice as high for the number of bytes we need to
> send.
> 

Ok I think I finally got your question. So you are asking that "Why 
cannot we half the pclk even for the compressed case?"

So pclk / = comp_ratio and then
further on top of that
pclk /= 2 for widebus?

Is that your question?

If so pls see below

> Is that answer: pclk is not only used for the bus between DPU and DSI?
> 
> If the answer to that question is yes, then I'd ask what the advantage
> is of widebus.
> 

pclk is only used between DPU and DSI.

let me explain the purpose of widebus.

If we take an input of 30bpp, then without widebus DPU can only send 24 
bits out.

So the compression ratio which we can achieve would only be 2.4 and not 
3 (24/10)

But with widebus, it can output 48bits and now since your source bpp is 
only 30bits we can send it out fully and get the 3:1 compression ratio.

So widebus actually makes it possible to get the full compression in the 
30bpp case. That would be the benefit of widebus for DSI.

Hope i was able to explain it now.

> <snip>
> 
> Let's leave the rest for what it is.
> 
> - Marijn
