Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9AD6C8282
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjCXQjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjCXQjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:39:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDC71A480
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:39:07 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OEVtA9003202;
        Fri, 24 Mar 2023 16:38:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=Q/Aacm9/iMqLoLcNYoJTHtvo1Owzsbt+WnBpEV/Bt7g=;
 b=LpsNiIH0yaFNhJRA3QD+sMovqGfOWF5MZIqfZPr/DjQiCQ8G825SJud/py5ze64FR180
 mpaJDmmP6UtF87DrCxEKR8mcB22xJfwCIqLgFAbLntpf5HfboPTgIjbBdFIlF+klIk+P
 vuGEjv1Wqg/F/fH/uPwUlINlIwQ84VgeQDKjGP1o9/DlxV++O7WfFcYzRnQMRhv7w2yT
 yL3n8wCg4JKArLbB4OrdjxJdbnrwtBpR+RgZ4aPBb1V5oBZ8rPdo7dMuzw27avap1xfj
 lUdQft2AFFCTHcd/JgVuHJlqNcqHz64f6NnfgvJ3SJ4u+VpV/M0uIg4ypgx846jZ9j4E iA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pgyeeagmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 16:38:39 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32OGcc4w019267
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 16:38:38 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 24 Mar 2023 09:38:38 -0700
Date:   Fri, 24 Mar 2023 09:38:36 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Bhavya Kapoor <b-kapoor@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <dmitry.baryshkov@linaro.org>, <arnd@arndb.de>,
        <krzysztof.kozlowski@linaro.org>, <geert+renesas@glider.be>,
        <nfraprado@collabora.com>, <broonie@kernel.org>, <rafal@milecki.pl>
Subject: Re: [PATCH v3] arm64: defconfig: Enable CAN PHY transceiver driver
Message-ID: <20230324163836.GB309305@hu-bjorande-lv.qualcomm.com>
References: <20230324072443.395080-1-b-kapoor@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230324072443.395080-1-b-kapoor@ti.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dkfRFf72f55jk3vJX0ROHQtI91pUZ-5B
X-Proofpoint-ORIG-GUID: dkfRFf72f55jk3vJX0ROHQtI91pUZ-5B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_10,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 mlxlogscore=799
 malwarescore=0 phishscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2303240131
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 12:54:43PM +0530, Bhavya Kapoor wrote:
> Enable CAN PHY transceiver driver to be built as a module which will
> add support for generic CAN transceivers used by TI K3 specific SoCs.
> 

Thanks for the update.

Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Regards,
Bjorn

> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> 
> Changelog v2->v3:
>  - Modified Commit message to be more descriptive
> 
> Link to V2 : https://lore.kernel.org/all/20230323113324.361991-1-b-kapoor@ti.com/
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
