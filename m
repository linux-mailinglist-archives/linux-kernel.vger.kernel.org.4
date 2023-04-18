Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B162B6E5732
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 03:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjDRB4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 21:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjDRB4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:56:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFD261B4;
        Mon, 17 Apr 2023 18:55:24 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I0IZIw018180;
        Tue, 18 Apr 2023 01:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ZT6T8JazTUrOY0mEHFTu/RGzheZfZZgUG7SP163oiWw=;
 b=oIS8AdQ5k552DF8T2GFIx6H+oM74i8BJw7hoxxtudrpXrsy4fT3lzThcgfo6R6IbIgqa
 Eqw03+iJ22DTGHKhhjV4hB9FI0VrZOxyqQsdp+sObQvZnhxRPg2Klf/5UTBIPEqEseBE
 TrQ0HbMk5eauno9ukAIvG8b6WX5waqYbUzLqgIiRBRWA0p/ly0y4tK4gyc/DEKkoWVyF
 l98pRq3B0Fkq921nxFDS4//CfPEY/Qu45Q9peu5vRdexbUZK4s4LEcg4sE8IGek1Sneb
 9sIpi7NjQK4lOXyP7sP7HECJWxE2G6q3Glj0LpNePSAayYcAbuj4BaamONMZqHvtpMiI QQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q1bvkrksq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 01:54:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33I1sK5F014814
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 01:54:20 GMT
Received: from [10.110.98.241] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 17 Apr
 2023 18:54:18 -0700
Message-ID: <bb229562-b0af-88f4-1207-ac23a6076dff@quicinc.com>
Date:   Mon, 17 Apr 2023 18:54:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 1/3] drm/msm/dpu: Drop unused members from HW structs
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <~postmarketos/upstreaming@lists.sr.ht>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20230418-dpu-drop-useless-for-lookup-v1-0-b9897ceb6f3e@somainline.org>
 <20230418-dpu-drop-useless-for-lookup-v1-1-b9897ceb6f3e@somainline.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20230418-dpu-drop-useless-for-lookup-v1-1-b9897ceb6f3e@somainline.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ws0QCnfY6to6MboIchWekFAke3Jesusg
X-Proofpoint-ORIG-GUID: ws0QCnfY6to6MboIchWekFAke3Jesusg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_14,2023-04-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=623 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304180015
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/17/2023 4:14 PM, Marijn Suijten wrote:
> Some of these members were initialized while never read, while others
> were not even assigned any value at all.  Drop them to save some space,
> and above all confusion when looking at these members.
> 
> Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
> Fixes: 84a33d0fd921 ("drm/msm/dpu: add dpu_hw_wb abstraction for writeback blocks")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---

It seems like WB UBWC formats are not supported today. Because otherwise 
ctx->mdp would be used for writeback. I guess we can add a ubwc member 
similar to hw_sspp, when we do add the support for this. Hence this is,


Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>


