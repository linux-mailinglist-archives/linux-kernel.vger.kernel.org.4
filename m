Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7ADF5ECC59
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 20:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiI0Spa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 14:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiI0SpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 14:45:19 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667BD65B2;
        Tue, 27 Sep 2022 11:45:18 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RG7GeM023779;
        Tue, 27 Sep 2022 18:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8zFROM2RlQ7RRfoAHZ/wSZkZ7Y/QNzLlk21ueeDp2Aw=;
 b=Bf6VoEx8gS89gu8wIMD20KUPTzsvfbcgnJRwTG06ZQzi/76PTJxWl9fjcoQSGuhfh6jO
 CCiG6qc3hw4WjlpFocThJTigJqasDnslvvqA7rSDBMJ52HThLy5ITGvNgVVjLFpJHfhA
 YFGOPufYFapOlLemUbmgIZc28/iBq8ko40a2PksOGPz3HshDUkLRSVqxJuXIwtYi+HeX
 urIBJETEBVj3JZewdVtj+4yED79c7qjy6gLHDYWdl0VlEa2FvdCZmMSqQ4PZNDY6LcRi
 zvsxgiz0209b6yXGQnm7EN9OoxMaqUDN1gba8di5FBQ7PRcWgcQvdCfQjeKf/8jYb/x3 zQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jv28a1dmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 18:44:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28RIisfc029098
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 18:44:54 GMT
Received: from [10.111.168.84] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 27 Sep
 2022 11:44:50 -0700
Message-ID: <7f611ed6-747f-5232-8d34-3187e4da9ac4@quicinc.com>
Date:   Tue, 27 Sep 2022 11:44:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [Freedreno] [PATCH v2 10/10] drm/msm/dsi: drop modeset sanity
 checks
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
CC:     Johan Hovold <johan+linaro@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Rob Clark" <robdclark@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Jonas Karlman" <jonas@kwiboo.se>, <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Steev Klimaszewski <steev@kali.org>,
        "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>
References: <20220913085320.8577-1-johan+linaro@kernel.org>
 <20220913085320.8577-11-johan+linaro@kernel.org>
 <dc33f8c9-761a-deec-d1e5-ea30c4120729@quicinc.com>
 <YzKjODjbQMx/hEk1@hovoldconsulting.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <YzKjODjbQMx/hEk1@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: l2ZM5xG7GvtYyCymGZXueeAcnhDHuNzp
X-Proofpoint-GUID: l2ZM5xG7GvtYyCymGZXueeAcnhDHuNzp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_09,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=703
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209270117
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/2022 12:16 AM, Johan Hovold wrote:
> On Mon, Sep 26, 2022 at 11:21:38AM -0700, Abhinav Kumar wrote:
>>
>>
>> On 9/13/2022 1:53 AM, Johan Hovold wrote:
>>> Drop the overly defensive modeset sanity checks of function parameters
>>> which have already been checked or used by the callers.
>>>
>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>
>> The change LGTM, hence
>>
>> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>>
>> I think we can use below fixes tag so that we can pick up this entire
>> series for the fixes cycle.
>>
>> Fixes: 3f0689e66352 ("drm/msm/dsi: check msm_dsi and dsi pointers before
>> use")
> 
> Same here. I wouldn't add a Fixes tag unless required by some DRM
> process.
> 
> Johan

Same response as the prev one, we will apply everything except the last 
two patches of this series in the -fixes and take these two for the next 
kernel rev push.
