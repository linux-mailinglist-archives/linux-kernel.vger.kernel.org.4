Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A868614243
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 01:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiKAA1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 20:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiKAA1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 20:27:32 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926ECE02C;
        Mon, 31 Oct 2022 17:27:31 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A10AXsw009477;
        Tue, 1 Nov 2022 00:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=m40wkIfxhRz/6SMH0Z2EoeEUVLdwP5OqfRDJ4shsHN4=;
 b=VcveSa25jOAOeiQlpDuPI8dU289dSINq0zHFJ3ER7STS+Z4EfYXQDTg4xbLRGKrrHs9b
 p9dRa4FWof6VKCMiMQetlVkpB+LBBmTX0RuxHebFwozz1hRLslzGjaqmXB46/1Oo6T5h
 Xg9unIezDNXj43XJz+I7Jnt0ppeMVxT80oiZzf2h+h4Tetcri6g8PUAzcGZbUJn8yM4K
 kKIljGNPNpjMCWpwKMuc3RsfYHDAUCUT9ICHQnRr+cjfWXYrBwR4S42g3ojRCk5FtnpT
 MSFqyvcgEUHiH8uyJoAVPJLtlHNeV/IhaYZjWll5S6PFv4mdWwCdU0XK/5uFxoDqxzID eA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kjjubrq33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 00:27:21 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2A10RKch014545;
        Tue, 1 Nov 2022 00:27:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 3khdkx6v94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 00:27:20 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A10QXTF013229;
        Tue, 1 Nov 2022 00:27:20 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 2A10RKpC014539
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 00:27:20 +0000
Received: from [10.249.23.32] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 31 Oct
 2022 17:27:13 -0700
Message-ID: <8b1da0e8-4c8d-2fb8-9c7c-58b56f4bdf0a@quicinc.com>
Date:   Mon, 31 Oct 2022 17:26:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/msm: Fix return type of
 mdp4_lvds_connector_mode_valid
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nathan Huckleberry <nhuck@google.com>
CC:     Dan Carpenter <error27@gmail.com>, <llvm@lists.linux.dev>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20220913205551.155128-1-nhuck@google.com>
 <Y2BH7sx09nqwKNmt@dev-arch.thelio-3990X>
 <1c735bcc-d4f7-333f-58a5-e3f463bab10d@linaro.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <1c735bcc-d4f7-333f-58a5-e3f463bab10d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PjnCByUgn6zzL_J9m_AGqkPfO5ORQttJ
X-Proofpoint-ORIG-GUID: PjnCByUgn6zzL_J9m_AGqkPfO5ORQttJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_22,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=963 clxscore=1011 malwarescore=0 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211010001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/31/2022 5:24 PM, Dmitry Baryshkov wrote:
> On 01/11/2022 01:10, Nathan Chancellor wrote:
>> On Tue, Sep 13, 2022 at 01:55:48PM -0700, Nathan Huckleberry wrote:
>>> The mode_valid field in drm_connector_helper_funcs is expected to be of
>>> type:
>>> enum drm_mode_status (* mode_valid) (struct drm_connector *connector,
>>>                                       struct drm_display_mode *mode);
>>>
>>> The mismatched return type breaks forward edge kCFI since the underlying
>>> function definition does not match the function hook definition.
>>>
>>> The return type of mdp4_lvds_connector_mode_valid should be changed from
>>> int to enum drm_mode_status.
>>>
>>> Reported-by: Dan Carpenter <error27@gmail.com>
>>> Link: https://github.com/ClangBuiltLinux/linux/issues/1703
>>> Cc: llvm@lists.linux.dev
>>> Signed-off-by: Nathan Huckleberry <nhuck@google.com>
>>> ---
>>>   drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c 
>>> b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c
>>> index 7288041dd86a..7444b75c4215 100644
>>> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c
>>> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c
>>> @@ -56,8 +56,9 @@ static int mdp4_lvds_connector_get_modes(struct 
>>> drm_connector *connector)
>>>       return ret;
>>>   }
>>> -static int mdp4_lvds_connector_mode_valid(struct drm_connector 
>>> *connector,
>>> -                 struct drm_display_mode *mode)
>>> +static enum drm_mode_status
>>> +mdp4_lvds_connector_mode_valid(struct drm_connector *connector,
>>> +                   struct drm_display_mode *mode)
>>>   {
>>>       struct mdp4_lvds_connector *mdp4_lvds_connector =
>>>               to_mdp4_lvds_connector(connector);
>>> -- 
>>> 2.37.2.789.g6183377224-goog
>>>
>>>
>>
>> Did this patch get lost somewhere? I do not see it picked up. It is
>> needed to avoid a new WIP warning from clang for catching these CFI
>> failures:
>>
>> drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c:89:16: error: 
>> incompatible function pointer types initializing 'enum drm_mode_status 
>> (*)(struct drm_connector *, struct drm_display_mode *)' with an 
>> expression of type 'int (struct drm_connector *, struct 
>> drm_display_mode *)' 
>> [-Werror,-Wincompatible-function-pointer-types-strict]
>>          .mode_valid = mdp4_lvds_connector_mode_valid,
>>                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> 1 error generated.
> 
> It will be picked into 6.1-rc and then propagate through the stable 
> kernel updates.
> 
> Anyway:
> 
> Fixes: 3e87599b68e7 ("drm/msm/mdp4: add LVDS panel support")
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Yes, it was already merged to the -fixes tree and a PR with it was sent 
out for 6.1-rc

https://gitlab.freedesktop.org/drm/msm/-/commit/0b33a33bd15d5bab73b87152b220a8d0153a4587

> 
> 
