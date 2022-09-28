Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B025EDFC7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbiI1PIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbiI1PIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:08:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4A8A61C3;
        Wed, 28 Sep 2022 08:07:57 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28SD7VxB025413;
        Wed, 28 Sep 2022 15:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/47Ht7//mhgwSWimy2C3slpI0VY99tiss+qSnQf+Sfw=;
 b=RB+nyOF5BKH9l9x72j6mwe6cTjqK8+V+snuF0a7Y9cfhSJ7XKA/6khGfVu3+uOccMGWG
 hr8LBR4/omYzcI2k5PjdLwFSFztf1GzNNstdVPSybKMLCODSTrqkcnyJeBhkMVi15A+J
 IgV41I21qQkUkgN2zPpH6hLVn7kgcwuZXa/+mMgvfGBuwZNwGrPdCcyspUs4tH0xtQ4o
 L5k8rjYynPnNzb/aCL/WCxxG6OYTPyqeDuVVSepsFqTB61czt+b9sRiQV+tedtG2SisJ
 H+bJZaC1Sx1c10pi5khNGoetHnNVyGOwXZbnwhhKL5VkuVGg3PHEoH25d8SCRgD4YMTa Aw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jvpuv8dv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 15:07:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28SF7jGa022777
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 15:07:45 GMT
Received: from [10.216.28.222] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 28 Sep
 2022 08:07:41 -0700
Message-ID: <fef52129-a2be-58a9-3725-a4fd345661c4@quicinc.com>
Date:   Wed, 28 Sep 2022 20:37:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] clk: qcom: gcc-sm6350: Update the .pwrsts for usb gdscs
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        <linux-arm-msm@vger.kernel.org>
CC:     <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220928132853.179425-1-luca.weiss@fairphone.com>
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <20220928132853.179425-1-luca.weiss@fairphone.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 49Yj00eN_HOGd0TL_YvxXg39YnWeUfAf
X-Proofpoint-ORIG-GUID: 49Yj00eN_HOGd0TL_YvxXg39YnWeUfAf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_06,2022-09-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209280089
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/28/2022 6:58 PM, Luca Weiss wrote:
> The USB controllers on sm6350 do not retain the state when
> the system goes into low power state and the GDSCs are
> turned off.
> 
> This can be observed by the USB connection not coming back alive after
> putting the device into suspend, essentially breaking USB.
> 
> Fix this by updating the .pwrsts for the USB GDSCs so they only
> transition to retention state in low power.
> 
> Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
> Similar to sc7180 & sc7280 patches that have been applied recently:
> https://lore.kernel.org/linux-arm-msm/20220927170516.zrkzn3xl7oedzi4l@builder.lan/T/
> 
> @Rajendra Nayak: Maybe you know a bit more about the internals of
> sm6350&sm7225. As described in the commit message USB just stops working
> after suspend, with this it comes back after wakeup from suspend and
> continues working. If any details in the commit message are somehow
> wrong or I can add something, please let me know!

ah right, this seems like the exact same case as sc7180 and sc7280,
the only additional thing to mention perhaps is that these SoCs
only support CX RET (I don't know but I am guessing they don't support
CX PowerCollapse since you said your change worked) and hence there are
no cxcs entries populated.

> Thanks for fixing this on sc7180&sc7280!
> 
>   drivers/clk/qcom/gcc-sm6350.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/gcc-sm6350.c b/drivers/clk/qcom/gcc-sm6350.c
> index 69412400efa4..9b4e4bb05963 100644
> --- a/drivers/clk/qcom/gcc-sm6350.c
> +++ b/drivers/clk/qcom/gcc-sm6350.c
> @@ -2316,7 +2316,7 @@ static struct gdsc usb30_prim_gdsc = {
>   	.pd = {
>   		.name = "usb30_prim_gdsc",
>   	},
> -	.pwrsts = PWRSTS_OFF_ON,
> +	.pwrsts = PWRSTS_RET_ON,
>   };
>   
>   static struct gdsc ufs_phy_gdsc = {
