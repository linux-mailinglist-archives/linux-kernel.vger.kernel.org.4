Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1BC74DBA5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjGJQyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjGJQyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:54:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F5410C0;
        Mon, 10 Jul 2023 09:53:48 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36AGSd40021649;
        Mon, 10 Jul 2023 16:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=E9e+S4RTkTmosg86zIZupvfEJdyllZyc0Xf2MkrqOZw=;
 b=Ay5VLjm+Hgo0O1eWfngPTKmTY4GK/VHcySc8qhlc8/50lbzxjYew/BWL+i4BpyzP6isk
 wR2seSoW4fmiKfdFdH1TPTFK7WhmkMKux/JsYvidUbfTVI5ohjMiFUr/sLs8/M0ukj7a
 E7hNV/bE5uvzKnQYkPTpH9ewxj2j+l6t2Of6aRzLXSok1rxfXbdZEwHEX3+8+n2eZTBC
 NU4COAAJdbxHiQIp2Jqfxb8KPOL5iQQmQMoazrCvWDx7yt0o2O7A0lNKDp1IlZJR84pf
 b47015ndJ/H7sDZnH1xUPCmYLpChJ5ooEmlTrFpfl/KStmAOxH4SJYDXmxihjvxLgorh tQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rrg5mh290-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 16:53:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36AGr1Z8015118
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jul 2023 16:53:01 GMT
Received: from [10.110.55.196] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 10 Jul
 2023 09:53:00 -0700
Message-ID: <c1a6f23d-17d9-6f4b-407a-142913e88a35@quicinc.com>
Date:   Mon, 10 Jul 2023 09:52:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 3/5] drm/msm/dp: delete EV_HPD_INIT_SETUP
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@gmail.com>,
        <agross@kernel.org>, <andersson@kernel.org>
CC:     <quic_abhinavk@quicinc.com>, <quic_jesszhan@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <marijn.suijten@somainline.org>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1688773943-3887-1-git-send-email-quic_khsieh@quicinc.com>
 <1688773943-3887-4-git-send-email-quic_khsieh@quicinc.com>
 <b70e6e98-e5a8-71d7-891a-889c268a7e06@linaro.org>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <b70e6e98-e5a8-71d7-891a-889c268a7e06@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Bki10N1UghQumq-vGKZ8Q-beFnD87KIi
X-Proofpoint-ORIG-GUID: Bki10N1UghQumq-vGKZ8Q-beFnD87KIi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_12,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307100152
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/7/2023 5:34 PM, Dmitry Baryshkov wrote:
> On 08/07/2023 02:52, Kuogee Hsieh wrote:
>> EV_HPD_INIT_SETUP flag is used to trigger the initialization of external
>> DP host controller. Since external DP host controller initialization had
>> been incorporated into pm_runtime_resume(), this flag become obsolete.
>> Lets get rid of it.
>
> And another question. Between patches #2 and #3 we have both 
> INIT_SETUP event and the PM doing dp_display_host_init(). Will it work 
> correctly?

yes,  i had added  if (!dp->core_initialized)  into dp_display_host_init().

should I merge this patch into patch #2?

>
>>
>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_display.c | 12 ------------
>>   1 file changed, 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c 
>> b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 2c5706a..44580c2 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -55,7 +55,6 @@ enum {
>>   enum {
>>       EV_NO_EVENT,
>>       /* hpd events */
>> -    EV_HPD_INIT_SETUP,
>>       EV_HPD_PLUG_INT,
>>       EV_IRQ_HPD_INT,
>>       EV_HPD_UNPLUG_INT,
>> @@ -1119,9 +1118,6 @@ static int hpd_event_thread(void *data)
>>           spin_unlock_irqrestore(&dp_priv->event_lock, flag);
>>             switch (todo->event_id) {
>> -        case EV_HPD_INIT_SETUP:
>> -            dp_display_host_init(dp_priv);
>> -            break;
>>           case EV_HPD_PLUG_INT:
>>               dp_hpd_plug_handle(dp_priv, todo->data);
>>               break;
>> @@ -1483,15 +1479,7 @@ void __exit msm_dp_unregister(void)
>>     void msm_dp_irq_postinstall(struct msm_dp *dp_display)
>>   {
>> -    struct dp_display_private *dp;
>> -
>> -    if (!dp_display)
>> -        return;
>> -
>> -    dp = container_of(dp_display, struct dp_display_private, 
>> dp_display);
>>   -    if (!dp_display->is_edp)
>> -        dp_add_event(dp, EV_HPD_INIT_SETUP, 0, 0);
>>   }
>>     bool msm_dp_wide_bus_available(const struct msm_dp *dp_display)
>
