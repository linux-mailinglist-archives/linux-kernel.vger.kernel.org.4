Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CBD62A183
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiKOSpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiKOSpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:45:08 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24618286D3;
        Tue, 15 Nov 2022 10:45:07 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFGU1sn017719;
        Tue, 15 Nov 2022 18:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NGu45BdBjZVyoRbcrPUvECK4GpTnQ11d3AWL4KAZka8=;
 b=T1u7EXYnEh3V8PU29EeVZmeFKTQdXwtPekU3jSuUipok/TSyhQIsmIe5+F/I7kPBv3Eh
 1p0qMhpzudKMiEChmTKOhHcliA3ckZRvqW8rwpY/P/xq6657hNdyTZRtjLZtxwhpBDKh
 ZcKOCdeF6+9EgJ8UI1GVTDPiCgES+35aBmwUO2QnSQ2ytRDLWJ/MRIBdxO4GxeBHgLmo
 mxDs0JHkkxfn3WxJakdfhu+9EZloE6IicniCkGJsJiE9HuWx9L2Q4OfMqVoPpHOSDhji
 3RaOtasgsGPQIf1qFI0qBPcmOB73Sut0KOLREQPmF20HZKKxoVoqIgdBp2X+YcL8422p cA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kveba8fvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 18:44:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AFIisJe002377
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 18:44:54 GMT
Received: from [10.110.17.80] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 15 Nov
 2022 10:44:53 -0800
Message-ID: <dcddd992-60e9-b802-b7a3-bab877545761@quicinc.com>
Date:   Tue, 15 Nov 2022 10:43:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] drm/msm/dp: remove limitation of link rate at 5.4G to
 support HBR3
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Doug Anderson <dianders@chromium.org>
CC:     <robdclark@gmail.com>, <sean@poorly.run>, <swboyd@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <agross@kernel.org>, <quic_abhinavk@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
References: <1667237245-24988-1-git-send-email-quic_khsieh@quicinc.com>
 <94b507e8-5b94-12ae-4c81-95f5d36279d5@linaro.org>
 <deb60200-5a37-ec77-9515-0c0c89022174@quicinc.com>
 <CAD=FV=X_fs_4JYcRvAwkU9mAafOten9WdyzPfSVWdAU=ZMo8zg@mail.gmail.com>
 <155e4171-187c-4ecf-5a9b-12f0c2207524@linaro.org>
 <CAD=FV=Wk5rBSq9Mx1GCO0QFYckKV9KUFKL36Ld7dQX1ypHVcYw@mail.gmail.com>
 <CAD=FV=XTOUjVAGFWZ6xTkcNOrCT1p73aU-=KJNYUOxsS-BQsyA@mail.gmail.com>
 <c5aedb31-3881-50e7-f747-e75b18c3f4b8@linaro.org>
 <CAD=FV=WPde5wVOGCKQYGuGwgCwRebox4FF0MgV_2pPCTsfo_UA@mail.gmail.com>
 <60643572-4148-cea5-e64d-ec6534b0c407@linaro.org>
 <a4127ba2-5968-e8a9-da63-fd709aa01e7f@quicinc.com>
 <adf5f80a-17e5-1163-a93c-2759ae57d77d@linaro.org>
Content-Language: en-US
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <adf5f80a-17e5-1163-a93c-2759ae57d77d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dYZIKt45zug6K3dB_nl6knU1AhP-aSpu
X-Proofpoint-GUID: dYZIKt45zug6K3dB_nl6knU1AhP-aSpu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211150127
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/9/2022 11:43 PM, Dmitry Baryshkov wrote:
> On 10/11/2022 02:47, Kuogee Hsieh wrote:
>>
>> On 11/2/2022 11:04 AM, Dmitry Baryshkov wrote:
>>> On 02/11/2022 20:28, Doug Anderson wrote:
>>>> Hi,
>>>>
>>>> On Wed, Nov 2, 2022 at 10:23 AM Dmitry Baryshkov
>>>> <dmitry.baryshkov@linaro.org> wrote:
>>>>>
>>>>>> 1. Someone figures out how to model this with the bridge chain and
>>>>>> then we only allow HBR3 if we detect we've got a TCPC that supports
>>>>>> it. This seems like the cleanest / best but feels like a long pole.
>>>>>> Not only have we been trying to get the TCPC-modeled-as-a-bridge 
>>>>>> stuff
>>>>>> landed for a long time but even when we do it we still don't have a
>>>>>> solution for how to communicate the number of lanes and other stuff
>>>>>> between the TCPC and the DP controller so we have to enrich the 
>>>>>> bridge
>>>>>> interface.
>>>>>
>>>>> I think we'd need some OOB interface. For example for DSI 
>>>>> interfaces we
>>>>> have mipi_dsi_device struct to communicate such OOB data.
>>>>>
>>>>> Also take a note regarding data-lanes from my previous email.
>>>>
>>>> Right, we can somehow communicate the max link rate through the bridge
>>>> chain to the DP controller in an OOB manner that would work.
>>>
>>> I'd note that our dp_panel has some notion of such OOB data. So do 
>>> AUX drivers including the panel-edp. My suggestion would be to 
>>> consider both of them while modelling the OOB data.
>>>
>>>>
>>>>
>>>>>> 2. We add in a DT property to the display controller node that says
>>>>>> the max link rate for use on this board. This feels like a hack, but
>>>>>> maybe it's not too bad. Certainly it would be incredibly simple to
>>>>>> implement. Actually... ...one could argue that even if we later 
>>>>>> model
>>>>>> the TCPC as a bridge that this property would still be valid / 
>>>>>> useful!
>>>>>> You could certainly imagine that the SoC supports HBR3 and the TCPC
>>>>>> supports HBR3 but that the board routing between the SoC and the 
>>>>>> TCPC
>>>>>> is bad and only supports HBR2. In this case the only way out is
>>>>>> essentially a "board constraint" AKA a DT property in the DP
>>>>>> controller.
>>>>>
>>>>> We have been discussing similar topics with Abhinav. Krzysztof 
>>>>> suggested
>>>>> using link-frequencies property to provide max and min values.
>>
>> questions,
>>
>> 1)is Krzysztof suggested had been implemented?
>
> I can not parse this question, please excuse me.
>
> Yes, Krzysztof suggested this being implemented as a link property, 
> see media/video-interfaces.txt.
>
> Moreover your implementation goes against both the existing definition 
> (array with the list of frequencies) and Krzysztof's suggested 
> extension (min and max). Listing just a single frequency goes against 
> both these suggestions. In case of DP we have a fixed set of 
> frequencies. Thus I'd suggest listing all supported frequencies instead.

I think this proposal is kind of strange.

According to DP spec, if a link support 5,4G, then it must support 1.6, 
2.7 and 5.4.

If it support 8.1G, then it must support 1.6 , 2.7 and 5.4.

There is no link can only support 2.7 and 5.4G without supporting 1.6G.

>
>> 2) where is link property i can add link-frequencies?
>
> link node. Create outbound graph node, add link-frequencies there. 
> Also as you are touching this part, please move the data-lanes 
> property too.
>
>>
>>
>>>>
>>>> This sounds good to me and seems worth doing even if we eventually 
>>>> do #1.
>>>
>>> And the bonus point is that it can be done easily.
>>>
>
