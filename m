Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D180F749F03
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbjGFObE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjGFObB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:31:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8249610F5;
        Thu,  6 Jul 2023 07:30:55 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366DNfe8000580;
        Thu, 6 Jul 2023 14:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=qPlggLFjPS2QVZzKlIOuh1K7ebzfqUoiDssBg+C2niY=;
 b=GEQO1IrzY2mlcPEMnP7aL6bm8VNRvV6Ja6dvnU7uzEKeWZ1q8f1vDuB2EAJUhy1AR5gy
 uZApI4Lju6yM9OV2ZAJ6n8tTU2uu1cyowFu/w9W8OA+9IOVePcKk5mkIZnR79Z0lmGGT
 wQmLeBYSI+yIwLkUw65wmTkGrcz/fFZ11H4VUukpwjoKI024UZcdeJQHhjsqrb7VSYR1
 mEY/jcmtbKNe/V+V5qFQ5BdjlTvuF1Za8PuEWZxKFK6Yj+aE5rp0t953TCcdApHAE3Jh
 EnU9Ah+7mepn3ivSRYY9Vwt/uxsbWCVZtlKZQbD2UO8dqETAwHIQbDI5sbf6zmybLk9x Ag== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rnvaa8ct1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 14:30:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 366EUoiM003707
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 14:30:50 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 6 Jul 2023 07:30:46 -0700
Date:   Thu, 6 Jul 2023 20:00:42 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: power: rpmpd: Add Generic RPM(h) PD
 indexes
Message-ID: <35b6b086-9b03-49df-b80d-863218b42fae@quicinc.com>
References: <1688647793-20950-1-git-send-email-quic_rohiagar@quicinc.com>
 <1688647793-20950-2-git-send-email-quic_rohiagar@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1688647793-20950-2-git-send-email-quic_rohiagar@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JRt-xBy429ft693H7D6XFz8B0GNOxvGL
X-Proofpoint-ORIG-GUID: JRt-xBy429ft693H7D6XFz8B0GNOxvGL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=546 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060129
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 06:19:51PM +0530, Rohit Agarwal wrote:
> Add Generic RPM(h) Power Domain indexes that can be used
> for all the Qualcomm SoC henceforth.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Does it make sense to give this link [1] so that we know what is
Konrad's suggestion and the discussion around it?

[1]
https://lore.kernel.org/all/0d468d08-6410-e424-b4f3-5245cdb0334a@linaro.org/
> ---
>  include/dt-bindings/power/qcom-rpmpd.h | 49 ++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
> index 83be996..6498251 100644
> --- a/include/dt-bindings/power/qcom-rpmpd.h
> +++ b/include/dt-bindings/power/qcom-rpmpd.h
> @@ -4,6 +4,55 @@
>  #ifndef _DT_BINDINGS_POWER_QCOM_RPMPD_H
>  #define _DT_BINDINGS_POWER_QCOM_RPMPD_H
>  
> +/* Generic RPMH Power Domain Indexes */
> +#define RPMHPD_CX		0
> +#define RPMHPD_MX		1
> +#define RPMHPD_CX_AO		2
> +#define RPMHPD_MX_AO		3
> +#define RPMHPD_GFX		4
> +#define RPMHPD_MSS		5
> +#define RPMHPD_EBI		6
> +#define RPMHPD_LCX		7
> +#define RPMHPD_LMX		8
> +#define RPMHPD_MMCX		9
> +#define RPMHPD_MMCX_AO		10
> +#define RPMHPD_MXC		11
> +#define RPMHPD_MXC_AO		12
> +#define RPMHPD_NSP		13
> +#define RPMHPD_NSP0		14
> +#define RPMHPD_NSP1		15
> +#define RPMHPD_QPHY		16
> +#define RPMHPD_DDR		17
> +#define RPMHPD_XO		18
> +
> +/* Generic RPM Power Domain Indexes */
> +#define RPMPD_VDDCX		0
> +#define RPMPD_VDDCX_AO		1
> +#define RPMPD_VDDMX		2
> +#define RPMPD_VDDMX_AO		3
> +#define RPMPD_VDDCX_VFL		4
> +#define RPMPD_VDDMX_VFL		5
> +#define RPMPD_VDDCX_VFC		6
> +#define RPMPD_LPI_CX		7
> +#define RPMPD_LPI_MX		8
> +#define RPMPD_SSCCX		9
> +#define RPMPD_SSCCX_VFL		10
> +#define RPMPD_SSCMX		11
> +#define RPMPD_SSCMX_VFL		12
> +#define RPMPD_VDDSSCX		13
> +#define RPMPD_VDDSSCX_VFC	14
> +#define RPMPD_VDDGFX		15
> +#define RPMPD_VDDGFX_VFC	16
> +#define RPMPD_VDDGX		17
> +#define RPMPD_VDDGX_AO		18
> +#define RPMPD_VDDMDCX		19
> +#define RPMPD_VDDMDCX_AO	20
> +#define RPMPD_VDDMDCX_VFC	21
> +#define RPMPD_VDDMD		22
> +#define RPMPD_VDDMD_AO		23
> +#define RPMPD_LPICX_VFL		24
> +#define RPMPD_LPIMX_VFL		25
> +

How did you come up with this list? A union of all SoCs supported by
RPMh driver?

>  /* SA8775P Power Domain Indexes */
>  #define SA8775P_CX	0
>  #define SA8775P_CX_AO	1
> -- 
> 2.7.4
> 

Thanks,
Pavan
