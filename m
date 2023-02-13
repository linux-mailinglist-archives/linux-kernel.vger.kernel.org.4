Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4493695075
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjBMTOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjBMTOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:14:43 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26D22005B;
        Mon, 13 Feb 2023 11:14:41 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DIltTj021786;
        Mon, 13 Feb 2023 19:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HnBtElvnXrZSCZ4PL1ZqcA+S0cWvIUOfzUuIWVxThQM=;
 b=VKaDgv0Jh/sCFtnC0VeiGIsHTZJgxrVdpNrO0wktQGvI9Nng7FkI6yra+9LHMAP5zVdS
 Apms9hGZEDovumcjR0kfirQGkr45xygi69U1NBA3eKWxw7DiZJPYiDRXJl3m9YYA7q4l
 jhrXcwtu9SqVgaK4KfDAowiJK/Wy4d0JiX4SId/b/0yPiBV1VMj7epW6dHeQOgLStH2E
 6MU/sAYsjow3Nc0sQzYfteMsdjiS6gKRxaFuXbNP/cQckb5GOsde7dMYxMdag0uhBwQE
 wFsSVCFbgCrs5STJD742zQhcfVqQ5i5lVCs8igW9nMwN1OBszCR4GNegoYdPCkkxYE90 6w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqts7r1rr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 19:14:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31DJEOrG004697
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 19:14:24 GMT
Received: from [10.110.55.187] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 13 Feb
 2023 11:14:06 -0800
Message-ID: <cf77995f-3adf-d1a4-40ac-2f524b926835@quicinc.com>
Date:   Mon, 13 Feb 2023 11:14:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [Freedreno] [PATCH 06/10] drm/msm/dpu: Add SM6350 support
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
CC:     Vinod Koul <vkoul@kernel.org>, Liu Shixin <liushixin2@huawei.com>,
        "Robert Foss" <rfoss@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rob Clark" <robdclark@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        <freedreno@lists.freedesktop.org>,
        <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        "David Airlie" <airlied@gmail.com>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        "Sean Paul" <sean@poorly.run>, <linux-kernel@vger.kernel.org>
References: <20230211122656.1479141-1-konrad.dybcio@linaro.org>
 <20230211122656.1479141-7-konrad.dybcio@linaro.org>
 <a18cf663-115d-edc8-5e4b-3d19fcd9a02c@linaro.org>
 <cc364658-478a-f239-5d17-5ca2b7f7df8b@linaro.org>
 <20230213113008.ih7ii5m3cz4w3lmz@SoMainline.org>
 <8560b69f-8d42-995d-2f4d-11d6a64afef0@linaro.org>
 <20230213142831.hbzfp2chekshsqyy@SoMainline.org>
 <28c9ea04-fedb-16cf-f874-f4c965fbc445@linaro.org>
 <20230213151413.qhpzzcz4c6m6rynk@SoMainline.org>
 <56281f37-2c7f-5f70-6c9e-87e950f06b0e@linaro.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <56281f37-2c7f-5f70-6c9e-87e950f06b0e@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VOpkEuUlFtvzaWkPMOan774DL8v52Da9
X-Proofpoint-ORIG-GUID: VOpkEuUlFtvzaWkPMOan774DL8v52Da9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_12,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1011 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130168
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/13/2023 8:25 AM, Dmitry Baryshkov wrote:
> On 13/02/2023 17:14, Marijn Suijten wrote:
>> On 2023-02-13 16:58:00, Dmitry Baryshkov wrote:
>>> So, *possible* the merge order is the following:
>>> - fixes from https://patchwork.freedesktop.org/series/113910/ go to
>>> msm-fixes
>>> - fixes from your intf-te go to msm-fixes
>>> - https://patchwork.freedesktop.org/series/111751/
>>> - the rest of intf-te and catalog (*see below)
>>> - DPU features
>>> - new DPU platforms (might go together with DPU features)
>>>

Fixes from https://patchwork.freedesktop.org/series/113910/ can be 
pulled into -fixes. Will send it out in a MR. I can see that you have 
absorbed a couple of independent fixes into this too (which were already 
reviewed outside the HW catalog rework series)

And from the intf TE series only this one right?

https://patchwork.freedesktop.org/patch/516429/

Other than this there are no "fixes" in that series.

>>> * That really depends on the availability of the patchsets. Most
>>> probably, as your patchset also contains several fixups, it would be
>>> easier to land it before catalog split/rework.
>>>
>>> So, if you have the available timeslot, could you please finish & send
>>> intf te on top of msm-next.
>>
>> Ack, I'll get to that immediately.  You might even pull in the
>> intermediate patches linked above (that touch the catalog) to see how it
>> integrates, if I remember correctly (it has been a while) the catalog
>> changes should now be independent of driver changes...?
> 
> I'll check and if it goes well, I'll just cherry-pick them into my branch.
> 
>>
>>>> Sure, I will at least start looking at your 50-patch as part of 
>>>> catching
>>>> back up.  Do you want to process that on the mailing list or via
>>>> https://gitlab.freedesktop.org/drm/msm/-/merge_requests/44?
>>>
>>> I'd prefer to use email. The MR was open to doublecheck that nothing got
>>> broken on sc7180.
>>
>> Ack; will try providing feedback on the 50-patch series via email in
>> parallel to getting INTF TE v2 out ASAP.  As discussed before I should
>> probably add myself as reviewer to the drm/msm subsystem to have these
>> patches in my inbox from the get-go though...
> 

Jessica had some minor comments/questions on the intf te series. We have 
finished integrating and testing that on sm8350 while bringing up the 
DSC 1.2 panel and thats what led to 
https://patchwork.freedesktop.org/series/113851/

Please wait for her comments / R-b .

> I'd support this.
> 
> 
