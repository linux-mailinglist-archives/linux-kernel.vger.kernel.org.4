Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D316EEA5A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 00:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbjDYWi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 18:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjDYWi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 18:38:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852B114468;
        Tue, 25 Apr 2023 15:38:56 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PMBapf002941;
        Tue, 25 Apr 2023 22:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=f+5A1qztiXhNmFaeF8ZnrVXAG1ddU+0Am4irhfVFlX4=;
 b=OmxFnS0T/lEN9FMVRmbiDpez8vE6uSJAW7DqNFdQgk/cYcXfDhZ983w38b1+Ama2pi1h
 1eM4A4Ms6RffZ5kvaAS9k3+/eGurD+hPJfQsu/LwiExKuQA22Bwlt2yLzotxBdg7kfws
 ZKpqhQy7vwQzN5eFJcKEujuhO8CgJVg31U6GJgzhFcsANie84GWIgC4LNschrESxvTXl
 TXq0qPVajmGTZkMJkcAIhw/i41UAeKRqP38ow7tsD3hg8X2zgEJSoCuk5hHoCPjuDaL7
 P7S7kqPGKwFQwRXk7OCHMtuFIpT4iRnr6GqtKScETZ6787Z1a5zyCZbzDKL3EKW/as0J lg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q6bgpa2hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 22:37:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33PMbkwt021702
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 22:37:46 GMT
Received: from [10.110.124.105] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 25 Apr
 2023 15:37:45 -0700
Message-ID: <a1501b6c-6859-549a-5739-67afdec8865b@quicinc.com>
Date:   Tue, 25 Apr 2023 15:37:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [Freedreno] [PATCH v2 04/17] drm/msm/dpu: Fix PP_BLK_DIPHER ->
 DITHER typo
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>
CC:     <dri-devel@lists.freedesktop.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Archit Taneja <architt@codeaurora.org>,
        Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>,
        Adam Skladowski <a39.skl@gmail.com>,
        Martin Botka <martin.botka@somainline.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Sean Paul <sean@poorly.run>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        "Jami Kettunen" <jami.kettunen@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <freedreno@lists.freedesktop.org>,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>
References: <bhatfkgdkjt2bih4lcwa5cxcp3w2tkjrqmbdhqhzqa2cizrmxs@py3gr5vifsoc>
 <65bb4d8a-c607-4152-0ae3-bf3134955925@quicinc.com>
 <5td7ikd76obc5bn5sndnt7fbzjuwmyxtu35ma3lykzmmbyfffk@b24jh6imaocy>
 <7541b780-482e-ea92-f788-18c8fbf45d77@quicinc.com>
 <o536qdkbrqob5wux7jvmo7expwn4bdlj7vy7egjfsyydxp5myb@xjhmolci5jzl>
 <cc537736-a555-dc3e-2e53-f1d4479eab21@quicinc.com>
 <6crk3acgxcdfdokpgcfjkojs2wdjoxalkmctqfgtc725wsgoep@kdj4zbavbe62>
 <a8f33707-b9ea-5595-e458-4f56c24c1167@quicinc.com>
 <klrcz6zw4syxllhtbuclo65lo73kdunl5syuuoiv6zzkf3fadl@rgjc7rlgaoxq>
 <5661d20d-81e9-61ba-b556-d90b5b8fdb4d@quicinc.com>
 <ztgyg2uplm7fbju7hfxvc6547zvttnslotwook2wmejiytlq7u@clq6zzwgvc5c>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <ztgyg2uplm7fbju7hfxvc6547zvttnslotwook2wmejiytlq7u@clq6zzwgvc5c>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: D1LDtd0Ggi10h9dwdda-EeVDWXxDZlcf
X-Proofpoint-ORIG-GUID: D1LDtd0Ggi10h9dwdda-EeVDWXxDZlcf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_08,2023-04-25_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 mlxlogscore=921 suspectscore=0 adultscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304250202
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/25/2023 3:15 PM, Marijn Suijten wrote:
> On 2023-04-25 14:55:56, Abhinav Kumar wrote:
> <snip>
>>> I'll see whether I can include these fixes before sending v3 (got all
>>> the other changes in and am all-ready to send it): is there any other
>>> SoC you're seeing this issue on?
>>>
>>
>> Thats alright, you can have it in a separate series not v3 of this one.
>>
>> I am picking up the fixes from this one now.
>>
>> I will update the other SOCs on IRC or even better i will take up this
>> cleanup.
> 
> I already have the fix patch in my tree that is compatible with the
> other patches, and will send those in a minute.  All DPU >= 7.0.0 seems
> to be affected, both SM8350 and SM8450 need to use the SC7280 sblk with
> DITHER V2 at 0xe0 (SM8250 is still V1).  I believe SC8280XP should also
> be updated but do not have access to DTS: where can I find that (what is
> its codename again?) or can you otherwise confirm this for me?
> 

Sure, I can wait another day too. Dont want to rush you too much for this.

8280xp still has dither at 0xe0 and yes its version is V2.

8280xp's DTS is not located in the techpack. Its a different tree.


> - Marijn
