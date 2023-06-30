Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25CB744372
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 22:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbjF3Up1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 16:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjF3UpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 16:45:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBDDA2;
        Fri, 30 Jun 2023 13:45:22 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UBRRdS003723;
        Fri, 30 Jun 2023 20:45:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=FTdBeaEKG+g/KZpBbXvDp7XxMcSZMCNnU0rIonn47R4=;
 b=So91Zj0cwX1FahlfGEeJkJe6l7qSIiudHOrygrpv5KhhtfsvWSOJICrIVoln00V0wdXu
 KO9OqVT2O20nbwVHArXaksrNOnTpPkD7majF+fwarD8wUe63WFrWXuDkO9d5MgJOtDMa
 EpJa4gVUlChB3Is/CwAdc0MHJhL85WK9DYQqbUzeNmZMvQGROphbAc9nKmmC2hp+H2yM
 0lv+cwHYSUkZtnyFIkr66BDQ1JXkPglvClB70cd19P6QvecHgxyuwIPt6J/twQruyFEV
 ffG9YZCORjVFes2/5wTXInPWizrfm5OC9rAaAKyLXEv/oImfqRMu6icaokQP0n0OMUr8 Ww== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rhw70s9gu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 20:45:17 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35UKjGs6030156
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 20:45:16 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Fri, 30 Jun 2023 13:45:15 -0700
Date:   Fri, 30 Jun 2023 13:45:14 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Komal Bajaj <quic_kbajaj@quicinc.com>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 0/6] soc: qcom: llcc: Add support for QDU1000/QRU1000
Message-ID: <20230630204514.GD1059662@hu-bjorande-lv.qualcomm.com>
References: <20230623141806.13388-1-quic_kbajaj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230623141806.13388-1-quic_kbajaj@quicinc.com>
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: miKdGWwja1m9W9-vd5yCCxUG6Uj85btZ
X-Proofpoint-GUID: miKdGWwja1m9W9-vd5yCCxUG6Uj85btZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_12,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 bulkscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306300181
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 07:48:00PM +0530, Komal Bajaj wrote:
> From: Komal-Bajaj <quic_kbajaj@quicinc.com>
> 

The patches in this series are going to be merged by two different
maintainers, the interface between them is an existing, clean API, so it
will be possible to merge the two halfs independently.

So please split this into one series for the addition of the nvmem
driver and one for the llcc pieces (with the nvmem interface/stub update
in the llcc one).

Thanks,
Bjorn

> This patch series does the following -
>  * Add secure qfprom driver for reading secure fuse region in qfprom driver
>  * Add dt-bindings for secure qfprom
>  * Refactor LLCC driver to support multiple configuration
>  * Add support for multi channel DDR configuration in LLCC
>  * Add LLCC support for the Qualcomm QDU1000 and QRU1000 SoCs
> 
> Changes in v4 -
>  - Created a separate driver for reading from secure fuse region as suggested.
>  - Added patch for dt-bindings of secure qfprom driver accordingly.
>  - Added new properties in the dt-bindings for LLCC. 
>  - Implemented new logic to read the nvmem cell as suggested by Bjorn.
>  - Separating the DT patches from this series as per suggestion.
> 
> Changes in v3-
>  - Addressed comments from Krzysztof and Mani.
>  - Using qfprom to read DDR configuration from feature register.
> 
> Changes in v2:
>   - Addressing comments from Konrad.
> 
> Komal Bajaj (6):
>   dt-bindings: nvmem: sec-qfprom: Add bindings for secure qfprom
>   dt-bindings: cache: qcom,llcc: Add LLCC compatible for QDU1000/QRU1000
>   nvmem: sec-qfprom: Add Qualcomm secure QFPROM support.
>   soc: qcom: llcc: Refactor llcc driver to support multiple
>     configuration
>   soc: qcom: Add LLCC support for multi channel DDR
>   soc: qcom: llcc: Add QDU1000 and QRU1000 LLCC support
> 
>  .../devicetree/bindings/cache/qcom,llcc.yaml  |  10 +
>  .../bindings/nvmem/qcom,sec-qfprom.yaml       |  58 ++++
>  drivers/nvmem/Kconfig                         |  12 +
>  drivers/nvmem/Makefile                        |   2 +
>  drivers/nvmem/sec-qfprom.c                    | 116 +++++++
>  drivers/soc/qcom/Kconfig                      |   2 +
>  drivers/soc/qcom/llcc-qcom.c                  | 304 +++++++++++++-----
>  include/linux/soc/qcom/llcc-qcom.h            |   2 +-
>  8 files changed, 416 insertions(+), 90 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/qcom,sec-qfprom.yaml
>  create mode 100644 drivers/nvmem/sec-qfprom.c
> 
> -- 
> 2.40.1
> 
