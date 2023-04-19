Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6816E825C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 22:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjDSUHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 16:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjDSUHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 16:07:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCFF4C20;
        Wed, 19 Apr 2023 13:07:30 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33JJkkeH009429;
        Wed, 19 Apr 2023 20:07:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GxeYKIlHm35YxMKMlQ09kxfFp4tfm/D2UircT7i4c5Q=;
 b=W9mmrNv3Hle+M9txgrFpZX32dKu0ijeAKpiEh1viU8FLrBKs6Ny4nfs73wOrlkOE3pMh
 ArmPJDmQf5NEf/9f4c+5+8nlwRb/lZb5o13aU9eTLqX6I+ED69/FlnF3FtDFZbjIirni
 wwjFnoUmlUgI/EOVnDX5KKCleXDv2kDfhI3vSCBEHQfL274RXPUeZXrJ0AS/ZmbyQ9TH
 ZdOtcRLmQZfsAO///rOj5QWEw7O6KYsnnBQgcZU8yBhMAgyQ23ruJe2v8GOBnpl/K3IU
 c2llugZe9EtTWp33m9NkOLYHGyNkf3BBujlo0gZ5Nx7sdlRWr7wViaoQWQ1kRH3ca0AM Eg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q26wy2dpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 20:07:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33JK7KEa015638
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 20:07:20 GMT
Received: from [10.134.71.70] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 19 Apr
 2023 13:07:18 -0700
Message-ID: <4ce0aee2-4abf-36ea-37b7-063bc8332913@quicinc.com>
Date:   Wed, 19 Apr 2023 13:07:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [Freedreno] [PATCH 0/5] MDSS reg bus interconnect
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
CC:     <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        "Marijn Suijten" <marijn.suijten@somainline.org>,
        <freedreno@lists.freedesktop.org>
References: <20230417-topic-dpu_regbus-v1-0-06fbdc1643c0@linaro.org>
From:   Jeykumar Sankaran <quic_jeykumar@quicinc.com>
In-Reply-To: <20230417-topic-dpu_regbus-v1-0-06fbdc1643c0@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YbULUBUEUXCpkzUk7K87NdvQ6cs-e6oP
X-Proofpoint-ORIG-GUID: YbULUBUEUXCpkzUk7K87NdvQ6cs-e6oP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_14,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304190174
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/17/2023 8:30 AM, Konrad Dybcio wrote:
> Apart from the already handled data bus (MAS_MDP_Pn<->DDR), there's
> another path that needs to be handled to ensure MDSS functions properly,
> namely the "reg bus", a.k.a the CPU-MDSS interconnect.
> 
> Gating that path may have a variety of effects.. from none to otherwise
> inexplicable DSI timeouts..
Current DPU driver already votes on the "reg bus" indirectly through the 
display AHB clock handle[<&dispcc DISP_CC_MDSS_AHB_CLK>] in DTSI. Can 
you provide more details on the issues that warrants this patch series?

Thanks
Jeykumar S
> 
> This series tries to address the lack of that.
> 
> Example path:
> 
> interconnects = <&bimc MASTER_AMPSS_M0 0 &config_noc SLAVE_DISPLAY_CFG 0>;
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Konrad Dybcio (5):
>        dt-bindings: display/msm: Add reg bus interconnect
>        drm/msm/dpu1: Rename path references to mdp_path
>        drm/msm/mdss: Rename path references to mdp_path
>        drm/msm/mdss: Handle the reg bus ICC path
>        drm/msm/dpu1: Handle the reg bus ICC path
> 
>   .../bindings/display/msm/mdss-common.yaml          |  1 +
>   drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c      | 10 +++----
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            | 34 ++++++++++++++++-----
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h            |  5 ++--
>   drivers/gpu/drm/msm/msm_mdss.c                     | 35 ++++++++++++++--------
>   5 files changed, 57 insertions(+), 28 deletions(-)
> ---
> base-commit: d3f2cd24819158bb70701c3549e586f9df9cee67
> change-id: 20230417-topic-dpu_regbus-abc94a770952
> 
> Best regards,
