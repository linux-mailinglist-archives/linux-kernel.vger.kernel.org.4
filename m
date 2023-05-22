Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723CF70C210
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbjEVPMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbjEVPMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:12:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94609BB;
        Mon, 22 May 2023 08:12:19 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MDrLhw003378;
        Mon, 22 May 2023 15:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=97r4Q0EyNuirNJzWAVVdWotxvvNun0l3fubqls5DQXM=;
 b=g7WUhvlJIPnKDAoa7qXObTrAjveLqML+YG7UFT1uWqNT3YjmKAy+CkE1ERoGBt9F9o8p
 4k738wvGUl/hlZrargjtkaL0qUD3znVl6XYGHnlABSulcncBXdj3BH5rYFpFWS9D3FH4
 8gvvAQnt1MxCjy1jh3/JUryirnucec/TQ7xrpNFgT862rOMtP8MM1lGp5aDcvw0U+N78
 qRcUMQe2VriBf67bm48QEsW45GS5osAGSaHsQWK5wprmMMj3OZjx0ymt8FXiPBzraaXj
 oIByBelrM5/yfZGUsW7rnvmgf8D2i0XeXka3HYplpRpoCP3BmAFgE+C3J5vjmyjYopdq ig== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qr6h0rngv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 15:12:13 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 34MFC9em028911;
        Mon, 22 May 2023 15:12:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3qpq9kppmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 22 May 2023 15:12:09 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34MFC8Fl028906;
        Mon, 22 May 2023 15:12:08 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-kbajaj-hyd.qualcomm.com [10.147.247.189])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 34MFC86h028904;
        Mon, 22 May 2023 15:12:08 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2340697)
        id BB8495001C2; Mon, 22 May 2023 20:42:07 +0530 (+0530)
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: dts: qcom: qdu1000: add IMEM
Date:   Mon, 22 May 2023 20:42:04 +0530
Message-Id: <20230522151206.22654-1-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PPHR5EilTl6XYuSTEmccl9Gnog4hJ_-Y
X-Proofpoint-ORIG-GUID: PPHR5EilTl6XYuSTEmccl9Gnog4hJ_-Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_10,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=560 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220126
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IMEM on QDU1000 and QRU1000 SoCs.

Komal Bajaj (2):
  dt-bindings: sram: qcom,imem: document qdu1000
  arm64: dts: qcom: qdu1000: Add IMEM and PIL info region

 .../devicetree/bindings/sram/qcom,imem.yaml         |  1 +
 arch/arm64/boot/dts/qcom/qdu1000.dtsi               | 13 +++++++++++++
 2 files changed, 14 insertions(+)

-- 
2.17.1

