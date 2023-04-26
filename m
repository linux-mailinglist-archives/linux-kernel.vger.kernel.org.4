Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F256EFD9E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 00:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240087AbjDZWqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 18:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239905AbjDZWqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 18:46:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883D33A92;
        Wed, 26 Apr 2023 15:45:59 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QMD95P003700;
        Wed, 26 Apr 2023 22:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=G0fQd0sXxcEgA+C6uLc76o3sRPmLuIx8y7B1STcvrNs=;
 b=nt70d1eBznTWtgmAmpnFFFnne/pS6oMFa/++Qe92ihvOZm99WHr+IDWn7SdKeh6kEgth
 AXOZPk5MxU4nbEYo8FkFwWBwSve+D8YAUuDoBkxqTn+9E9cGM7xWfWMrkITvGL5/kfNf
 QFVX41Wk2OEE3W9LZf+pyrOFnANeK9m646+GiHtLB59RlDxaIdd0tHSxbczNh1puwD4n
 seUPIoWMY4fvm8NkRZ4gUdORWY7hcIuTEEvMVhCWh5gH9Y9HyDvAVherebMwWNtb+y7Y
 elERHgKmdXIxzuTOSj5Bq4GscaOr2iz1jXRjtFH1HuwvULcq7RI7xkIPvtKAYQKBhP8m cQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q6uuvjcgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 22:45:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33QMjFuV018290
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 22:45:15 GMT
Received: from [10.110.124.105] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 26 Apr
 2023 15:45:13 -0700
Message-ID: <4875712e-5d52-06d0-daae-eee2eba3e730@quicinc.com>
Date:   Wed, 26 Apr 2023 15:45:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [Freedreno] [PATCH v4 06/22] drm/msm/dpu: Use V2 DITHER PINGPONG
 sub-block in SM8[34]50/SC8280XP
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Sean Paul" <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Adam Skladowski <a39.skl@gmail.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Kuogee Hsieh" <quic_khsieh@quicinc.com>,
        Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
CC:     Jami Kettunen <jami.kettunen@somainline.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        <freedreno@lists.freedesktop.org>
References: <20230411-dpu-intf-te-v4-0-27ce1a5ab5c6@somainline.org>
 <20230411-dpu-intf-te-v4-6-27ce1a5ab5c6@somainline.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20230411-dpu-intf-te-v4-6-27ce1a5ab5c6@somainline.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: F04BaiKYxPErt1DI3RMlvCv0iNJTPC09
X-Proofpoint-GUID: F04BaiKYxPErt1DI3RMlvCv0iNJTPC09
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_10,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=980 spamscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 suspectscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304260197
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/2023 3:37 PM, Marijn Suijten wrote:
> According to downstream sources this DITHER sub-block sits at an offset
> of 0xe0 with version 0x20000.  The PP_BLK_DITHER macro is _not_ used as
> downstream still says the size of the PINGPONG block is 0xd4 and not 0.
> 
> Fixes: 4a352c2fc15a ("drm/msm/dpu: Introduce SC8280XP")
> Fixes: 0e91bcbb0016 ("drm/msm/dpu: Add SM8350 to hw catalog")
> Fixes: 100d7ef6995d ("drm/msm/dpu: add support for SM8450")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>

As discussed, will drop "The PP_BLK_DITHER macro is _not_ used as
downstream still says the size of the PINGPONG block is 0xd4 and not 0" 
from the commit text while applying, otherwise

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
