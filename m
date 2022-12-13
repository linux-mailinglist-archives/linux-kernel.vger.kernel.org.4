Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD90664C059
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 00:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236841AbiLMXRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 18:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235640AbiLMXRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:17:32 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FE164F1;
        Tue, 13 Dec 2022 15:17:32 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDLniE2027653;
        Tue, 13 Dec 2022 23:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VLS6umlWEiAumMvWikmLxOElRoOqJhSWWdxzwzSWWN0=;
 b=n635dJkg82/QElfbKXvBeJcsx+edmknl1sKtXVAMMFJAY/yMP2sjQTtQKkqkau7DMBqY
 wzh1AMKyW7tIVGcCR1fQPtKYyRUw1WVwaav3036YtqKq3IbBs6wvE9ghN8+kzwHy8A4/
 MdTKkx+nWUBDMVYktsi2g2t4VSs2c/VpjPr4qre5SPfD0ZgGdI6UhCc44ObIJapO91OZ
 gBaDi1hEujnFTekh0bcCdsLnOFmBCsRT708m1eJvcCh/JLMDmsjRjHFn6Q6X1YibdkKI
 6LOfzRHZkwh6pqnHIIG9KHJEb4a/4LFY1Ef18w9TFLhx9UMT2qk19BewjWFWRsCGbJSc Hw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3meyfaggyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 23:17:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BDNHPg1011233
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 23:17:25 GMT
Received: from [10.111.167.12] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 13 Dec
 2022 15:17:23 -0800
Message-ID: <9c5935f2-38ef-d187-585e-9797aa1b854f@quicinc.com>
Date:   Tue, 13 Dec 2022 15:17:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH -next] drm/msm/dpu: Fix some kernel-doc comments
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, <robdclark@gmail.com>
CC:     <dmitry.baryshkov@linaro.org>, <sean@poorly.run>,
        <airlied@gmail.com>, <daniel@ffwll.ch>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20221115014902.45240-1-yang.lee@linux.alibaba.com>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20221115014902.45240-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: k9HQGMqfptHnzzEmDKDu43iNucbCRY18
X-Proofpoint-GUID: k9HQGMqfptHnzzEmDKDu43iNucbCRY18
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 clxscore=1011 impostorscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212130200
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/14/2022 5:49 PM, Yang Li wrote:
> Make the description of @init to @p in dpu_encoder_phys_wb_init()
> and remove @wb_roi in dpu_encoder_phys_wb_setup_fb() to clear the below
> warnings:
> 
> drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c:139: warning: Excess function parameter 'wb_roi' description in 'dpu_encoder_phys_wb_setup_fb'
> drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c:699: warning: Function parameter or member 'p' not described in 'dpu_encoder_phys_wb_init'
> drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c:699: warning: Excess function parameter 'init' description in 'dpu_encoder_phys_wb_init'
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3067
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Fixes: d7d0e73f7de3 ("drm/msm/dpu: introduce the dpu_encoder_phys_* for 
writeback")

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> index 7cbcef6efe17..62f6ff6abf41 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> @@ -132,7 +132,6 @@ static void dpu_encoder_phys_wb_set_qos(struct dpu_encoder_phys *phys_enc)
>    * dpu_encoder_phys_wb_setup_fb - setup output framebuffer
>    * @phys_enc:	Pointer to physical encoder
>    * @fb:		Pointer to output framebuffer
> - * @wb_roi:	Pointer to output region of interest
>    */
>   static void dpu_encoder_phys_wb_setup_fb(struct dpu_encoder_phys *phys_enc,
>   		struct drm_framebuffer *fb)
> @@ -692,7 +691,7 @@ static void dpu_encoder_phys_wb_init_ops(struct dpu_encoder_phys_ops *ops)
>   
>   /**
>    * dpu_encoder_phys_wb_init - initialize writeback encoder
> - * @init:	Pointer to init info structure with initialization params
> + * @p:	Pointer to init info structure with initialization params
>    */
>   struct dpu_encoder_phys *dpu_encoder_phys_wb_init(
>   		struct dpu_enc_phys_init_params *p)
