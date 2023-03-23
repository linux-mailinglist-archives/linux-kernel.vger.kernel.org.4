Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D336C6A0C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 14:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjCWNyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 09:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjCWNxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 09:53:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7E91ACF1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 06:53:47 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NB65Jx030676;
        Thu, 23 Mar 2023 13:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=vJo0wVGYC5RZLt1+sY/GHDRgIaFyRoklJ7hvkdnd5hw=;
 b=P8XNamuKaCNiMLwDg1WhP0dRfYcx0HE2mH8O66FCu+0TneO1VZ88rgUJ0SmtyCElny36
 pife807h1tj6PBUAgez4pVyOWhlHIfoeG+2ojPiC1hTb+O0pkzkB4cqsogJkQUZmD4wf
 7oCGMpFWwkjgG7cnvEVnTtjdunqP3TpKhIknlk2ELYdruaVBlJYN8MJxRSWKhtwbqiHG
 5hatXSz5MspS0DNBIbTojM3OZk13akMOI99unEYaCCUjhDVMcDsRJ0L3y4+D0mcWwEig
 OFasMQYFYtucb0q/j9YpYIgohmqaUBuzwMzvBR9xoYbIFcKd5xuWD0/YqFjMLjJbTT9T WQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pg64k2ff9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 13:53:26 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32NDrPmE004916
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 13:53:25 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 23 Mar 2023 06:53:24 -0700
Date:   Thu, 23 Mar 2023 06:53:23 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bhavya Kapoor <b-kapoor@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <dmitry.baryshkov@linaro.org>, <arnd@arndb.de>,
        <krzysztof.kozlowski@linaro.org>, <geert+renesas@glider.be>,
        <nfraprado@collabora.com>, <broonie@kernel.org>, <rafal@milecki.pl>
Subject: Re: [PATCH v2] arm64: defconfig: Enable CAN PHY transceiver driver
Message-ID: <20230323135323.GA309305@hu-bjorande-lv.qualcomm.com>
References: <20230323113324.361991-1-b-kapoor@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230323113324.361991-1-b-kapoor@ti.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: G0pm7JZGZ7RmXrgvA_366z0pJWEdpAYM
X-Proofpoint-ORIG-GUID: G0pm7JZGZ7RmXrgvA_366z0pJWEdpAYM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 clxscore=1011 priorityscore=1501 adultscore=0 mlxlogscore=907 phishscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230105
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 05:03:24PM +0530, Bhavya Kapoor wrote:
> Enable CAN PHY transceiver driver to be built as a module.

Please use the commit message to describe why the driver should be
enabled. The patch and the subject already states clearly that the
driver is being enabled.

Regards,
Bjorn

> 
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---
> changelog v1->v2:
>  - changed position of config in the file
> 
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 7790ee42c68a..6e123de3a9cf 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1292,6 +1292,7 @@ CONFIG_RESET_QCOM_PDC=m
>  CONFIG_RESET_RZG2L_USBPHY_CTRL=y
>  CONFIG_RESET_TI_SCI=y
>  CONFIG_PHY_XGENE=y
> +CONFIG_PHY_CAN_TRANSCEIVER=m
>  CONFIG_PHY_SUN4I_USB=y
>  CONFIG_PHY_CADENCE_TORRENT=m
>  CONFIG_PHY_CADENCE_SIERRA=m
> -- 
> 2.34.1
> 
