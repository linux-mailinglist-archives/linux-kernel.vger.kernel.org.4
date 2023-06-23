Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C1D73BDCE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjFWRaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 13:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjFWRaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:30:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9662C1993;
        Fri, 23 Jun 2023 10:30:01 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NDuPwG007161;
        Fri, 23 Jun 2023 17:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=lnIbIf7NmudFilKAbXIrXRh3WR7inmW/SzqPR4v7r0Q=;
 b=Af1iYuTBzGUrutsebEwLC4KhmkN4yGIbqtWYGDTHSAXMYzKqe1aXIU7QjgtKmjkXqYBX
 dRlhArdD7PiP8Wq4KlVim72n3Do4yawWbEzBWphsW4D66wTjBOoJ8lJWncoZ1v/4DyvW
 naMO2GR7MgDFtLvVAI13bAVu7Ipe568AVChp5WmiEaIYnRbkEBOF3eTOVVx9na5JR7ml
 scyyRQU2OU714aVgYl/YdR4d+iJ6fyDSEPn1SwPNQJoNd8tY86Bl0a2gVQKZcduV9a7k
 f2P4FBIq33nEUfOAaTXHKQ/X7zyEasAK20ws+l5A0xmLRPB81B25zUjPquwVrnGQOsit tA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rc6b2da9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 17:29:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35NHTsLN001132
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 17:29:54 GMT
Received: from [10.110.6.30] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 23 Jun
 2023 10:29:52 -0700
Message-ID: <654ccc4c-40c2-bef6-9f47-847216e16cb0@quicinc.com>
Date:   Fri, 23 Jun 2023 10:29:51 -0700
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
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <xrqiat4otnfwtss6zwubh77qx3frdyi77flna2xljzycvr6r2v@riimvmhoondt>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0rJIduGmZPurT6kYCsCNdSHZsqJs1pW1
X-Proofpoint-GUID: 0rJIduGmZPurT6kYCsCNdSHZsqJs1pW1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_08,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=740 lowpriorityscore=0 impostorscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306230156
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/23/2023 12:19 AM, Marijn Suijten wrote:
> On 2023-06-22 17:01:34, Abhinav Kumar wrote:
> <snip>
>>> More interesting would be a link to the Mesa MR upstreaming this
>>> bitfield to dsi.xml [2] (which I have not found on my own yet).
>>>
>>> [2]: https://gitlab.freedesktop.org/mesa/mesa/-/blame/main/src/freedreno/registers/dsi/dsi.xml
>>>
>>
>> Thats because we havent submitted a MR yet for this on mesa.
>>
>> Generally, our team does not have legal permissions yet for mesa MRs
>> other than mesa drm because we got permissions for the modetest.
>>
>> Rob/Dmitry, can one of you pls help with the corresponding mesa MR for this?
> 
> Thanks!
> 
>> The xml file change was autogenerated so this patch can go in.
> <snip>
>>>>    		 *
>>>>    		 * hdisplay will be divided by 3 here to account for the fact
>>>>    		 * that DPU sends 3 bytes per pclk cycle to DSI.
>>>> +		 *
>>>> +		 * If widebus is supported, set DATABUS_WIDEN register and divide hdisplay by 6
>>>> +		 * instead of 3
>>>
>>> So this should allow us to divide pclk by 2, or have much lower latency?
>>> Otherwise it'll tick enough times to transmit the data twice.
>>>
>>> Note that I brought up the exact same concerns when you used the 3:1
>>> ratio from dsi_bpp / dsc_bpp in your pclk reduction patch (instad of the
>>> number of bits/bytes that DPU sends to DSI per pclk), but no-one has
>>> replied to my inquiry yet.
>>>
>>
>> Ideally yes, we could have done pclk/2 on uncompressed pixels but we are
>> not going to add support for widebus on DSI without DSC as that is not
>> recommended in our docs.
> 
> No-one here mentioned uncompressed pixels?
> 
> None of this code suddenly makes DPU send twice as many pixels/bytes to
> the DSI, yet we are enabling a feature that makes the bus twice as wide,
> so the clock can be halved *for comressed pixels*?
> 

The concept is quite simple

one pixel per clock for uncompresssed without widebubus

2 pixels per clock for uncompressed with widebus (only enabled for DP 
not DSI)

3 bytes worth of data for compressed without widebus

6 bytes worth of data for compressed with widebus

When compression happens, we cannot quantify with pixels as the boundary 
is not defined with respect to bytes.

You brought up uncompressed in your below comment so I assumed your 
question of /2 was about uncompressed too.


>> So this cannot be done.
>>
>> We tried our best to respond and explain to all your queries both on the
>> bug and the patch but i guess it just kept coming :)
> 
> Then send less patches!  As long as there is activity on the mailing
> list there'll always be questions going back and forth, and I don't
> think that's unreasonable.
> 
> Unless you want to push patches into mainline without questioning.
> 

the comments were bordering the line of becoming irrelevant to the 
patches like discussing video mode on a command mode patch when we had 
explained many many times that we did not validate them.

I dont want to add more comments to this. Lets stop discussing this and 
focus more on this patch.

>> I am going to try one more time to explain it in the documentation change.
> 
> Would love to hear, why, for compressed streams, the bus is twice as
> wide yet pclk is not reduced to account for that.
> 
> <snip>
>>> Can we also support widebus for uncompressed streams (sending 2 pixels
>>> of bpp=24 per pclk), and if so, is that something you want to add in the
>>> future (a comment would be nice)?
>>
>> No, we cannot support widebus on uncompressed streams on DSI so we wont
>> be adding that.
> 
> And here we start talking about uncompressed pixels *separately*.  Okay,
> if it is not supported (e.g. widebus is specific to / reserved for DSC)
> it of course makes no sense to add it.
> 
> - Marijn
