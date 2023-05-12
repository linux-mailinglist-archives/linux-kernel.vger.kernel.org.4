Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6ECF700C92
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242025AbjELQGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242003AbjELQGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:06:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AB35FD0;
        Fri, 12 May 2023 09:06:40 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CEd0h0009563;
        Fri, 12 May 2023 16:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=45xGjmzIzfSYZ1glcXNm8UnBod6ohVLumXn6e35KAfg=;
 b=cbcNFmKpHYWAZqRU9+Zdrzw7kKTK3VwUnuCr4STDwM6ZeV0TTgABk7aN6S863cboWFLt
 5pHoSwCWXOQWn9DwCxvhzq3YiyOWgPkCAZMISHwOZYgfohy6hIynMarZCH/haaPxShET
 cIxfY1VSPEpXFasgyyDrA+gV84VtFVXki6L+pivqOXrcG1HTfyUGisewh7pk3ORHEeOZ
 Of5cIGxV4J2/sqmKnWGRoLAAWLE3iHgC+KOFn7qpGOMXahSwDtH3yjmz1PYtZSF4inTA
 ExIYNG7ER2Fg9Iz5OgC+SPEVtewjvp6lxMyRx+0ahjYdshqCD5BOFwG8RgF0XgwGk4kh jA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qhj9s0x12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 16:06:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34CG6X2p022611
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 16:06:33 GMT
Received: from [10.216.40.14] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 12 May
 2023 09:06:30 -0700
Message-ID: <53182e14-d6bb-97d8-010d-b99789af8ba6@quicinc.com>
Date:   Fri, 12 May 2023 21:33:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] clk: qcom: ipq5332: fix the src parameter in
 ftbl_gcc_apss_axi_clk_src
Content-Language: en-US
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230417044342.9406-1-quic_kathirav@quicinc.com>
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <20230417044342.9406-1-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: j--XRIBXm0y0yHdxmyoIt9HTBLyJE5xL
X-Proofpoint-GUID: j--XRIBXm0y0yHdxmyoIt9HTBLyJE5xL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_10,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=927 mlxscore=0
 adultscore=0 clxscore=1011 phishscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305120133
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/17/2023 10:13 AM, Kathiravan T wrote:
> 480MHz is derived from P_GPLL4_OUT_AUX not from P_GPLL4_OUT_MAIN. Update
> the freq_tbl with the correct src.


Gentle Reminder...


>
> Fixes: 3d89d52970fd ("clk: qcom: add Global Clock controller (GCC) driver for IPQ5332 SoC")
> Reported-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
>   drivers/clk/qcom/gcc-ipq5332.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/qcom/gcc-ipq5332.c b/drivers/clk/qcom/gcc-ipq5332.c
> index bdb4a0a11d07..8cacbfb10c72 100644
> --- a/drivers/clk/qcom/gcc-ipq5332.c
> +++ b/drivers/clk/qcom/gcc-ipq5332.c
> @@ -366,7 +366,7 @@ static struct clk_rcg2 gcc_adss_pwm_clk_src = {
>   };
>   
>   static const struct freq_tbl ftbl_gcc_apss_axi_clk_src[] = {
> -	F(480000000, P_GPLL4_OUT_MAIN, 2.5, 0, 0),
> +	F(480000000, P_GPLL4_OUT_AUX, 2.5, 0, 0),
>   	F(533333333, P_GPLL0_OUT_MAIN, 1.5, 0, 0),
>   	{ }
>   };
