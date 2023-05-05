Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E0E6F8459
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjEENs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbjEENsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:48:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E066CAB;
        Fri,  5 May 2023 06:48:24 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345CHTcd021048;
        Fri, 5 May 2023 13:47:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wrG3F3IhGoC8xojnPvd7JD0NO3NIj6eL4/3xLJ9gJZ8=;
 b=ZXHSA4IpOr3MNTmzAOZThgZOZDIdeT/dOQ3FLGdiadPpUS7690WylP7s9q/cote394Wq
 084VUtWXqWmoEI8CCRF7hzDZ4HW4D7Dy17rLAO1nSJnPLvXWUAXGESWm9H0k7EvnFcjF
 OFQIkEB3pkLsRLNTrnQfx9J/kXbrhIEikwDzUqY3+E0E5MA8Wlj3dEZTqm2jXz2yy2Yd
 kr8HVXtwe7mZ/WLbWoOvpjyNDV8DReNh4KrrcBJChP3gvs1ZXNMXp4fuVu7oWEkVQwtF
 Nl3bvYglwKjqWtWKNWjyrzTXfH46gXE7lcIKlJKpnlhkY2KdhlSxJABLf7KsGZlO8Ftd zQ== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qcf24jdjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 13:47:52 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 345Dlqr9031185
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 May 2023 13:47:52 GMT
Received: from [10.216.37.178] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 5 May 2023
 06:47:47 -0700
Message-ID: <5e696512-00bf-e2b4-5c5b-53aa8088bb70@quicinc.com>
Date:   Fri, 5 May 2023 19:17:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 14/18] media: venus: hfi_platform: Check vpu_version
 instead of device compatible
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
        "Marijn Suijten" <marijn.suijten@somainline.org>
References: <20230228-topic-venus-v2-0-d95d14949c79@linaro.org>
 <20230228-topic-venus-v2-14-d95d14949c79@linaro.org>
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <20230228-topic-venus-v2-14-d95d14949c79@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: A_qUJtSqUcPgiMPBEZ0089EO7zoplY1C
X-Proofpoint-GUID: A_qUJtSqUcPgiMPBEZ0089EO7zoplY1C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_21,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050115
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/2023 1:31 PM, Konrad Dybcio wrote:
> This is not a matter of the host SoC, but the VPU chip in Venus. Fix it.
>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>   drivers/media/platform/qcom/venus/hfi_platform.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/qcom/venus/hfi_platform.c b/drivers/media/platform/qcom/venus/hfi_platform.c
> index f07f554bc5fe..d163d5b0e6b7 100644
> --- a/drivers/media/platform/qcom/venus/hfi_platform.c
> +++ b/drivers/media/platform/qcom/venus/hfi_platform.c
> @@ -80,7 +80,7 @@ hfi_platform_get_codecs(struct venus_core *core, u32 *enc_codecs, u32 *dec_codec
>   	if (plat->codecs)
>   		plat->codecs(enc_codecs, dec_codecs, count);
>   
> -	if (of_device_is_compatible(core->dev->of_node, "qcom,sc7280-venus")) {
> +	if (IS_IRIS2_1(core)) {
>   		*enc_codecs &= ~HFI_VIDEO_CODEC_VP8;
>   		*dec_codecs &= ~HFI_VIDEO_CODEC_VP8;
>   	}
>
