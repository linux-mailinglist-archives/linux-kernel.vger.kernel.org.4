Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD1268048A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 04:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjA3D7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 22:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjA3D7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 22:59:49 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9AE241EA
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 19:59:22 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30U35CdC008228;
        Mon, 30 Jan 2023 03:59:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=TE8ds2RYF8W+18i7g6Iedlx3bXoIktMKdH7PSgyNdvc=;
 b=Dp7CxUc/Wa9BYjp4cYKX70WZ+5P2PuYSAXTzPd4YLdUDRtZ8yOHfrtYujKuwEWSthnzm
 h22fE8HP510B/Xwz6aDaCN7tOBgWAhlYnpW9siwU990Ooq+y+Ef1bM5pLTbGm+gRnE3X
 HpxjwFuzpn8LURhRsfj5D1QCfDq5gWeHVS291FiNWwxTDhWZ4t8i9kFX9l89hroP+9M7
 ZEhQy42OV4g/pEl3L4pTNVp6U/eB9NFqoR2iTqWGoyMPNg75QJY6c9dnqEHIuT9xpI3t
 BujlbkoZz9dXx24KKjGdD1jQSM16JzARfU6NYCwqY+n3XcvU1aTb1tQyChBkFhW3ynjJ 6Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncuxajnvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 03:59:13 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30U3xCQ5012760
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 03:59:12 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 29 Jan 2023 19:59:12 -0800
Date:   Sun, 29 Jan 2023 19:59:10 -0800
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: max20411: Directly include bitfield.h
Message-ID: <20230130035910.GC464800@hu-bjorande-lv.qualcomm.com>
References: <20230126225403.522121-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230126225403.522121-1-broonie@kernel.org>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IzTGTy8zI5_i_YXRzBd6IsoGGmCm6_S9
X-Proofpoint-GUID: IzTGTy8zI5_i_YXRzBd6IsoGGmCm6_S9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_01,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 mlxlogscore=642 impostorscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301300037
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 10:54:03PM +0000, broonie@kernel.org wrote:
> From: Mark Brown <broonie@kernel.org>
> 
> The max20411 driver uses bitfield.h but does not directly include
> it, add an inclusion to avoid build errors in configurations
> which do not result in an implicit inclusion.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

> ---
>  drivers/regulator/max20411-regulator.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/regulator/max20411-regulator.c b/drivers/regulator/max20411-regulator.c
> index 69f04cbe69f1..b4faad54c458 100644
> --- a/drivers/regulator/max20411-regulator.c
> +++ b/drivers/regulator/max20411-regulator.c
> @@ -4,6 +4,7 @@
>   * Copyright (c) 2022, Linaro Ltd.
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
>  #include <linux/module.h>
> -- 
> 2.34.1
> 
