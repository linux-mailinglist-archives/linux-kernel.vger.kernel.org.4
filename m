Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEC15FF767
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 01:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJNX7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 19:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiJNX7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 19:59:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1C7C7865;
        Fri, 14 Oct 2022 16:59:20 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29ENepDE013246;
        Fri, 14 Oct 2022 23:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LxzUFTZyoeF9LzO+23FdQxbMnYHWoNgbZ8NViMh+lA8=;
 b=TreGt4NUaqxGdol2JPV930rhL3uk305d7nw+8k9ZxUeCgiPNnycOLl56DEuunuM6MqDA
 YSG9as/v6XerhhOg8bQMCp9Zyp5EXJ7/04dkV94a+qJj7cs+rgZC/4QObT/sMSuwz7r4
 30I2IdcXkWV28OtTWTjquN5tTBS3gTDx0qSfDM+ILHHZbhnrUXtTMr2Vg1TXGM7phgrU
 wzNmzNnJeHzfu9vlV8BAKEskVZ+ADkjBSQlEwEEcynUhj2S3/7nLmQ4EeR6Zu9oUVQB1
 h70LO31k3wG/n/SfaSEVBolgA4Lt+MnBEAfMG4fOqpzSX7c2iEWiVh49kMqZX32qxCZb VQ== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k726w3udc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 23:59:17 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29ENxGJI013966
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 23:59:16 GMT
Received: from [10.110.77.177] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 14 Oct
 2022 16:59:16 -0700
Message-ID: <625ea783-56bd-6b1b-e161-cfa6870507f5@quicinc.com>
Date:   Fri, 14 Oct 2022 16:59:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 0/4] Add misc support for QDU1000/QRU1000 SoCs
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221014221121.7497-1-quic_molvera@quicinc.com>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <20221014221121.7497-1-quic_molvera@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LODvn8fRwiEppWb3VNabGKpaJ6Ayj0ll
X-Proofpoint-GUID: LODvn8fRwiEppWb3VNabGKpaJ6Ayj0ll
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_13,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140133
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/14/2022 3:11 PM, Melody Olvera wrote:
> This series firmware, SoC, rpmpd, tz-log, and mmc bindings as well as
> pmic, rpmpd, and socinfo support for QDU1000 and QRU1000 SoCs.
>
> The Qualcomm Technologies, Inc. Distributed Unit 1000 and Radio Unit
> 1000 are new SoCs meant for enabling Open RAN solutions. See more at
> https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm_5g_ran_platforms_product_brief.pdf
Changes from v1:
- fixed ordering
- removed instances of qdru
- moved CPU documentation patch to dt patchset
- added compatible fields to rpmhpd match table
>
> Melody Olvera (4):
>   dt-bindings: firmware: scm: Add QDU1000/QRU1000 compatibles
>   dt-bindings: power: rpmpd: Add QDU1000/QRU1000 to rpmpd binding
>   soc: qcom: rpmhpd: Add QDU1000/QRU1000 power domains
>   soc: qcom: socinfo: Add QDU1000/QRU1000 and variant IDs
>
>  .../devicetree/bindings/firmware/qcom,scm.yaml   | 16 ++++++++++++++++
>  .../devicetree/bindings/power/qcom,rpmpd.yaml    |  2 ++
>  drivers/soc/qcom/rpmhpd.c                        | 15 +++++++++++++++
>  drivers/soc/qcom/socinfo.c                       |  6 ++++++
>  include/dt-bindings/power/qcom-rpmpd.h           |  6 ++++++
>  5 files changed, 45 insertions(+)
>
>
> base-commit: dca0a0385a4963145593ba417e1417af88a7c18d

