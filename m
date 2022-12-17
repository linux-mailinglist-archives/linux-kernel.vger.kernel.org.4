Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B0C64F64E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 01:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiLQAc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 19:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQAcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 19:32:25 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3768E15FDF;
        Fri, 16 Dec 2022 16:32:24 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGNvgfc025586;
        Sat, 17 Dec 2022 00:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FafqiLihfvYH5H7Y7SIlIE8yTDE/hyI2tDCM/GdByH8=;
 b=hTic8mXYodZ8Xrhu5RrCiezRSrJeg6os5cFO1ymuYJApKOxRW2adj0FaqubJoKa76ffh
 JM1aPZGtc3QdMpnmMrGZY97aYr++qwYmfsf18W4iGqopYzYyhdBRuXHi+j3cf9Dtl+jv
 iDVgcI5QYCZZhjl2TmioZP/ht9tMwTVHjKVqqXd+Rmqwj4MhK78nOi3LDa3nY9L2CyGn
 G+hC4FD68Ni4jrU07CsEkPiWcva+/iLwqPaN1XU5wQDI3JRiO9tiQmKYJQIk9m3jUrJ5
 LuDd6J1j12DB4pcnnlqVFwrs+vTEeTsQLhM6kefqxMl1oqZJ98+NwRBZzP7aPYDgbz0y +g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mg2vwdp4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Dec 2022 00:31:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BH0VvwA007108
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Dec 2022 00:31:57 GMT
Received: from [10.110.127.101] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 16 Dec
 2022 16:31:55 -0800
Message-ID: <642b0063-b3b1-fb01-b761-dfd30cea1c8c@quicinc.com>
Date:   Fri, 16 Dec 2022 16:31:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [RFC PATCH 5/6] drm/msm/dsi: Flip greater-than check for
 slice_count and slice_per_intf
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        <phone-devel@vger.kernel.org>, Rob Clark <robdclark@gmail.com>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     <~postmarketos/upstreaming@lists.sr.ht>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Stephen Boyd" <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Jessica Zhang" <quic_jesszhan@quicinc.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        "Jani Nikula" <jani.nikula@intel.com>,
        sunliming <sunliming@kylinos.cn>,
        "Sam Ravnborg" <sam@ravnborg.org>,
        Haowen Bai <baihaowen@meizu.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        "Vinod Polimera" <quic_vpolimer@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20221213232207.113607-1-marijn.suijten@somainline.org>
 <20221213232207.113607-6-marijn.suijten@somainline.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20221213232207.113607-6-marijn.suijten@somainline.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FK0lp_-c3vUi5LUMC6uEjQ8ZD6Xz6TkT
X-Proofpoint-ORIG-GUID: FK0lp_-c3vUi5LUMC6uEjQ8ZD6Xz6TkT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_15,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1015 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212170002
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/2022 3:22 PM, Marijn Suijten wrote:
> According to downstream /and the comment copied from it/ this comparison
> should be the other way around.  In other words, when the panel driver
> requests to use more slices per packet than what could be sent over this
> interface, it is bumped down to only use a single slice per packet (and
> strangely not the number of slices that could fit on the interface).
> 
> Fixes: 08802f515c3c ("drm/msm/dsi: Add support for DSC configuration")

Like others have said, with SOB,
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dsi/dsi_host.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 0686c35a6fd4..9bdfa0864cdf 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -855,11 +855,11 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
>   	 */
>   	slice_per_intf = DIV_ROUND_UP(hdisplay, dsc->slice_width);
>   
> -	/* If slice_per_pkt is greater than slice_per_intf
> +	/* If slice_count is greater than slice_per_intf
>   	 * then default to 1. This can happen during partial
>   	 * update.
>   	 */
> -	if (slice_per_intf > dsc->slice_count)
> +	if (dsc->slice_count > slice_per_intf)
>   		dsc->slice_count = 1;
>   
>   	total_bytes_per_intf = dsc->slice_chunk_size * slice_per_intf;
