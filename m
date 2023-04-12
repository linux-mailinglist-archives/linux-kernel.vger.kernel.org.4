Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694326DFC83
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjDLRQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjDLRQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:16:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA40A26E;
        Wed, 12 Apr 2023 10:15:54 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CFmsXn020907;
        Wed, 12 Apr 2023 16:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=V4dEkYorey7By1tNXbbLfY/Q4S/geiqX8oTuMm20t2I=;
 b=FgmU+8F2e+TwdvS6zwoibi5tUxJYQolJREE2/0lKl2KauBcBur4pPRhtOjdg/nkkW319
 Cn17q6oUDaBIfLEyVaVrZmtNztGD307/8m9m5/n0jZqgp4s7lWJ1V+YWOBEqUxjMh37y
 Xfrgv5B+W8ZfnlusxLJ3B2DHWwERJ74owQndIaAvc8BfUvqY4whIhQCQnyqqxMGXBV4G
 vAMece6vSVUd7aiakTyXTFBolavHiIlw/i0i4IUcLxeguBdmUtTEI3/UO/oLxBKmXWlO
 lrD6zp/BT4Kiuw+pOOPV2+zMG+gMbnudw7TktUG9nVyTIf0ZWHaJAgqUecngfwEARyAe kw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pwqnq1at1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 16:49:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33CGnbSb000440
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 16:49:37 GMT
Received: from kathirav-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 12 Apr 2023 09:49:34 -0700
From:   Kathiravan T <quic_kathirav@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kathiravan T <quic_kathirav@quicinc.com>
Subject: [PATCH 0/3] Minor updates in the IPQ5332 DTS files
Date:   Wed, 12 Apr 2023 22:19:17 +0530
Message-ID: <20230412164920.21862-1-quic_kathirav@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bgsgOs8qHbXt34oKDZDEatTwSo5z65rp
X-Proofpoint-GUID: bgsgOs8qHbXt34oKDZDEatTwSo5z65rp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_08,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 mlxlogscore=650
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120145
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the MI01.2 DTS after Reference Design Platform(RDP) number to align
with ipq5332-rdp468.dts, add UART1 node and reserve memory for U-boot
and SBL to avoid loosing the RAM contents which will be used in post
morterm analysis.

Bjorn, since these are minor updates, it would be great if you could
possibly pick up this series for v6.4.

Kathiravan T (3):
  arm64: dts: qcom: ipq5332: rename mi01.2 dts to rdp441
  arm64: dts: qcom: ipq5332: define UART1
  arm64: dts: qcom: ipq5332: add few more reserved memory region

 arch/arm64/boot/dts/qcom/Makefile             |  2 +-
 ...{ipq5332-mi01.2.dts => ipq5332-rdp441.dts} |  0
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         | 20 +++++++++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)
 rename arch/arm64/boot/dts/qcom/{ipq5332-mi01.2.dts => ipq5332-rdp441.dts} (100%)

-- 
2.17.1

