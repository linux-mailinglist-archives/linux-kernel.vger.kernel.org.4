Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061B76F831B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjEEMiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjEEMit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:38:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C4B156A0;
        Fri,  5 May 2023 05:38:48 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345BcTsS029081;
        Fri, 5 May 2023 12:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6L57UHlfbZbQrLrdI9ayMjXGqDK0qe/6DbxerSWEKMU=;
 b=Vb5bBo2qSEU4V4jBDd3Ccw6Xf33VjVI4yMsJGf7VoeRi+/1kOwm+IzoFA7Sq4qNKxwuZ
 miJtzJMqHOrNNI7Zypptnd0mUalMHxIZBnlDTFYnH+J/BATlmPlGAP3pDCWoEnKzE1xb
 e5pq3MjxtkJOY0ZQ9YjoGgd0HW53KlWuHU6qIqMblJPeujxP2ug0SqjEZ3prGF8NU+V4
 e0Gpfqx73sEPCd2PPk1onrQe/QywftjBGol7dgahGI/xkxK+86Mp1VooXGx+DDHvWEdF
 D3oT7jw7MEVIyTZf5t+Km4oyVfmSUAjdrkUkRbIGACDRwY8fsiPv04UC62tqs0XLZXpl dw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qcumk8s21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 12:38:19 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 345CcI2U020107
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 May 2023 12:38:18 GMT
Received: from [10.216.37.178] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 5 May 2023
 05:38:13 -0700
Message-ID: <14b47c1e-8092-b2f9-1a53-90c42b306de3@quicinc.com>
Date:   Fri, 5 May 2023 18:08:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 03/18] media: venus: Remap bufreq fields on HFI6XX
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
CC:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Marijn Suijten" <marijn.suijten@somainline.org>,
        <stable@vger.kernel.org>
References: <20230228-topic-venus-v2-0-d95d14949c79@linaro.org>
 <20230228-topic-venus-v2-3-d95d14949c79@linaro.org>
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <20230228-topic-venus-v2-3-d95d14949c79@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4Hqr9V9-nXwCbkluKArb0wqxPGfYLs9r
X-Proofpoint-ORIG-GUID: 4Hqr9V9-nXwCbkluKArb0wqxPGfYLs9r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_20,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=934 clxscore=1015 adultscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050104
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/2023 1:30 PM, Konrad Dybcio wrote:
> Similarly to HFI4XX, the fields are remapped on 6XX as well. Fix it.
>
> Cc: stable@vger.kernel.org # v5.12+
> Fixes: 7ed9e0b3393c ("media: venus: hfi, vdec: v6 Add IS_V6() to existing IS_V4() if locations")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/media/platform/qcom/venus/hfi_helper.h | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
> index 105792a68060..e0c8f15644df 100644
> --- a/drivers/media/platform/qcom/venus/hfi_helper.h
> +++ b/drivers/media/platform/qcom/venus/hfi_helper.h
> @@ -1170,11 +1170,14 @@ struct hfi_buffer_display_hold_count_actual {
>   
>   /* HFI 4XX reorder the fields, use these macros */
>   #define HFI_BUFREQ_HOLD_COUNT(bufreq, ver)	\
> -	((ver) == HFI_VERSION_4XX ? 0 : (bufreq)->hold_count)
> +	((ver) == HFI_VERSION_4XX || (ver) == HFI_VERSION_6XX \
> +	? 0 : (bufreq)->hold_count)
>   #define HFI_BUFREQ_COUNT_MIN(bufreq, ver)	\
> -	((ver) == HFI_VERSION_4XX ? (bufreq)->hold_count : (bufreq)->count_min)
> +	((ver) == HFI_VERSION_4XX || (ver) == HFI_VERSION_6XX \
> +	? (bufreq)->hold_count : (bufreq)->count_min)
>   #define HFI_BUFREQ_COUNT_MIN_HOST(bufreq, ver)	\
> -	((ver) == HFI_VERSION_4XX ? (bufreq)->count_min : 0)
> +	((ver) == HFI_VERSION_4XX || (ver) == HFI_VERSION_6XX \
> +	? (bufreq)->count_min : 0)

This patch is not correct. The existing code handles the disparity of 
buffer requirement payload received from firmware.

Its applicable only for V4.

For V6, driver does not rely on firmware to get the buffer requirement. 
Refer the buffer platform code for more details.

-Vikash

>   struct hfi_buffer_requirements {
>   	u32 type;
>
