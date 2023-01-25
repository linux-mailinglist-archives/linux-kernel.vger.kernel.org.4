Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C005E67BA32
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 20:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbjAYTGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 14:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbjAYTGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 14:06:15 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD7C2D70;
        Wed, 25 Jan 2023 11:06:14 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PGNr7F021983;
        Wed, 25 Jan 2023 19:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7ct5Rt3pOxMGa20qtKL3XVMdB2+4ud9qJhbLvN9tT1s=;
 b=K+bbDpHSfSrab6XylAx57erMpgql7dXgEaMLWcA09804Sm7/HKv94HF8GqeiYrmDNu9q
 ze28IlwR4u6PkIBleT5a73MjUj/n7JDz5ZS4LdTFrX2q8/NoTKxff3U1MBO22Mijg7+Q
 VtaQgtsBlJaaNVRO9SvwW+mur7OUrP4GRvl2eAvW3Qy3wPEQtPcHsmp2/q6k0UirZ4rO
 fflgmjZ8iKr/qKL4iUPsc65xRF3aEFGxjgKydX8Kk7WJtjWUZchrE92gIGo4mlb0yAum
 ZtEWa+BpY58lulLqIZ8gyaAZshukfwreGrFh4YPLMfY0Wifevl4RD5Mn9q6A2abRTk7H Uw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3najkhangs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 19:05:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30PJ5t2u008804
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 19:05:55 GMT
Received: from [10.110.33.211] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 25 Jan
 2023 11:05:54 -0800
Message-ID: <7d3b9275-a800-9b18-0710-416fd80eb479@quicinc.com>
Date:   Wed, 25 Jan 2023 11:05:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2] drm/msm/dpu: Add DSC hardware blocks to register
 snapshot
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        <phone-devel@vger.kernel.org>
CC:     <~postmarketos/upstreaming@lists.sr.ht>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        "Jami Kettunen" <jami.kettunen@somainline.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        "Rob Clark" <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        "Liu Shixin" <liushixin2@huawei.com>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20230125101412.216924-1-marijn.suijten@somainline.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20230125101412.216924-1-marijn.suijten@somainline.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vPLX5ut4GzAcMl3hF0FsWSMpApEx65T7
X-Proofpoint-GUID: vPLX5ut4GzAcMl3hF0FsWSMpApEx65T7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_12,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250168
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/25/2023 2:14 AM, Marijn Suijten wrote:
> Add missing DSC hardware block register ranges to the snapshot utility
> to include them in dmesg (on MSM_DISP_SNAPSHOT_DUMP_IN_CONSOLE) and the
> kms debugfs file.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Huge ack from me,

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

> ---
> Changes since v1:
> - Rebase on next-20230125 to solve conflicts with 43e3293fc614
>    ("drm/msm/dpu: add support for MDP_TOP blackhole").
> 
> v1: https://lore.kernel.org/linux-arm-msm/20230125091315.133283-1-marijn.suijten@somainline.org/T/#u
> 
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index d612419118a2..a683bd9b5a04 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -937,6 +937,11 @@ static void dpu_kms_mdp_snapshot(struct msm_disp_state *disp_state, struct msm_k
>   				dpu_kms->mmio + cat->mdp[0].base, "top");
>   	}
>   
> +	/* dump DSC sub-blocks HW regs info */
> +	for (i = 0; i < cat->dsc_count; i++)
> +		msm_disp_snapshot_add_block(disp_state, cat->dsc[i].len,
> +				dpu_kms->mmio + cat->dsc[i].base, "dsc_%d", i);
> +
>   	pm_runtime_put_sync(&dpu_kms->pdev->dev);
>   }
>   
