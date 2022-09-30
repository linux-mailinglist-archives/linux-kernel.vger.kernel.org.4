Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85F15F0B2D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiI3L57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiI3L5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:57:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A884163B67;
        Fri, 30 Sep 2022 04:57:51 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28UAcTxO004250;
        Fri, 30 Sep 2022 11:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6r3IHl38uTfFy9rn6v0/eEMi3/2iLaVdrH1J1BCBHN8=;
 b=E1tthoWDAL8+R5uP/rXiLykkT/WDtID69h/mhV2cpx9Lswf0qdu0Grig4A5ha4kvkKvE
 33EwQSJSAw8pTC4pL19u4VcDSoxEMQ6EAjMW/zxLObBihEx3Oqf6LnUfP2l2joBmW3p6
 RHKLgYtysUE0uzriSq1ql+GwSBnVRXjLenMvZgGqstAaKD7MkAjsh/fBPvuyiaLCQsqA
 FXIKsALLXJLVDS/UP2UNcBk60B7NHsrY/uvla6OkBhKjytsC8P/98YDoiQXdyVw9xLVZ
 M4BumJn/GLFTyGExfCrknMKkvzIyl+gYiC5abrPzg85vErhI2Dn1cBrvol5sQMnNjxzR Kg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jwr49hh08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 11:57:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28UBvhmJ006966
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 11:57:43 GMT
Received: from [10.216.29.114] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 30 Sep
 2022 04:57:39 -0700
Message-ID: <30c95220-f3fd-3105-18a7-a9588af69b7d@quicinc.com>
Date:   Fri, 30 Sep 2022 17:27:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] clk: gcc-sc8280xp: use retention for USB power domains
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220929161124.18138-1-johan+linaro@kernel.org>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <20220929161124.18138-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: L6xfAgwQ05Xoyj1MyaDsMay5mYL3DJgS
X-Proofpoint-ORIG-GUID: L6xfAgwQ05Xoyj1MyaDsMay5mYL3DJgS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209300075
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/29/2022 9:41 PM, Johan Hovold wrote:
> Since commit d399723950c4 ("clk: qcom: gdsc: Fix the handling of
> PWRSTS_RET support) retention mode can be used on sc8280xp to maintain
> state during suspend instead of leaving the domain always on.
> 
> This is needed to eventually allow the parent CX domain to be powered
> down during suspend.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/clk/qcom/gcc-sc8280xp.c | 13 +++----------
>   1 file changed, 3 insertions(+), 10 deletions(-)
> 
> While we're not yet able to fully test this (since we're not hitting CX
> power down) this can still go in as we'll need it in some form
> eventually.

If sc8280xp supports CX power down, it would be good to also put in the
cxcs offsets so USB RET still works even when you do hit CX power down some
time in the future.

> 
> Note that the PCIe domains should remain always-on until we have driver
> support for suspend in place.
> 
> Johan
> 
> 
> diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
> index 7768e6901dcc..a18ed88f3b82 100644
> --- a/drivers/clk/qcom/gcc-sc8280xp.c
> +++ b/drivers/clk/qcom/gcc-sc8280xp.c
> @@ -6843,17 +6843,12 @@ static struct gdsc ufs_phy_gdsc = {
>   	.pwrsts = PWRSTS_OFF_ON,
>   };
>   
> -/*
> - * The Qualcomm DWC3 driver suspend implementation appears to be incomplete
> - * for sc8280xp so keep the USB power domains always-on for now.
> - */
>   static struct gdsc usb30_mp_gdsc = {
>   	.gdscr = 0xab004,
>   	.pd = {
>   		.name = "usb30_mp_gdsc",
>   	},
> -	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = ALWAYS_ON,
> +	.pwrsts = PWRSTS_RET_ON,
>   };
>   
>   static struct gdsc usb30_prim_gdsc = {
> @@ -6861,8 +6856,7 @@ static struct gdsc usb30_prim_gdsc = {
>   	.pd = {
>   		.name = "usb30_prim_gdsc",
>   	},
> -	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = ALWAYS_ON,
> +	.pwrsts = PWRSTS_RET_ON,
>   };
>   
>   static struct gdsc usb30_sec_gdsc = {
> @@ -6870,8 +6864,7 @@ static struct gdsc usb30_sec_gdsc = {
>   	.pd = {
>   		.name = "usb30_sec_gdsc",
>   	},
> -	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = ALWAYS_ON,
> +	.pwrsts = PWRSTS_RET_ON,
>   };
>   
>   static struct clk_regmap *gcc_sc8280xp_clocks[] = {
