Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00FF74E66F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 07:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjGKFnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 01:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjGKFnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 01:43:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CD91A4;
        Mon, 10 Jul 2023 22:43:07 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B4kq3i018232;
        Tue, 11 Jul 2023 05:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=zclyKd5M7feDOJD0TxAB4JMsDpoxgn3XoH7HXdxFpS4=;
 b=h2bK0Wp2xk4g55Qkf11FkqLvEW+aUdcfzyEksaS/XcNzs13q36duIZK4ojERzextvRej
 qXzeHp0PhlbNq1KxavYCRk9OWw98cPR+ZG0K8DWR0dxTbE1JNKc7sSfs2Vz4zrhoNk7h
 Et7qUjrRQ4URAz7NYye/xHN0bhMnZJ3Ac0UZQMULHMa+gd2V4S4q1eC3E6hPD46mREnV
 +DbNwh7dSnPJZcnsIuGjcW5Z2RThtckSNhEjJqoik1hhAGBo33lpL2Alj0m68wi93ftL
 eoTGvlq/B5Jg+uwTqO/98n+QC837R7dy/hTKdgBTTwwfuGlGjVqFK2odlStmnWnon8PZ pg== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs0bxg2k8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 05:43:03 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36B5gxE9005022;
        Tue, 11 Jul 2023 05:42:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rq0vm2h7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Jul 2023 05:42:59 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36B5gw9H004990;
        Tue, 11 Jul 2023 05:42:58 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.213.106.138])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 36B5gw34004803;
        Tue, 11 Jul 2023 05:42:58 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id CC8055033; Tue, 11 Jul 2023 11:12:57 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH v3 0/3] Add rpmhpd support for SDX75
Date:   Tue, 11 Jul 2023 11:12:46 +0530
Message-Id: <1689054169-10800-1-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NyIX4MYBte8mQrvgQiy9CtOe0X-RFfpl
X-Proofpoint-ORIG-GUID: NyIX4MYBte8mQrvgQiy9CtOe0X-RFfpl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_02,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=748 bulkscore=0
 mlxscore=0 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110050
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes in v3:
 - Removed the macros from rpmpd.h and created new generic
   bindings in patch [1/3] for rpmhpd only.
 - Corrected the versioning in this version of patch series.
 - Updated the patch series subject.
 - Updated the drivers change according to the new binding in
   patch [3/3]

Changes in v2:
 - Link to v2 series [1] (Added because of versioning mismatch).
 - Breaking the original series [2] into smaller series.
 - Added new generic bindings for rpmpd and rpmhpd keeping the
   older ones intact as removing them would break ABI [3].

This series adds the support of rpmhpd for sdx75 and also
adds the generic bindings for the PD to be used henceforth.

[1] https://lore.kernel.org/all/1688647793-20950-1-git-send-email-quic_rohiagar@quicinc.com/
[2] https://lore.kernel.org/all/1688395346-3126-1-git-send-email-quic_rohiagar@quicinc.com/
[3] https://lore.kernel.org/all/1688635218-23779-1-git-send-email-quic_rohiagar@quicinc.com/

Thanks,
Rohit.

Rohit Agarwal (3):
  dt-bindings: power: rpmhpd: Add Generic RPMh PD indexes
  dt-bindings: power: Add compatible for sdx75
  soc: qcom: rpmhpd: Add SDX75 power domains

 .../devicetree/bindings/power/qcom,rpmpd.yaml      |  1 +
 drivers/soc/qcom/rpmhpd.c                          | 17 ++++++++++++
 include/dt-bindings/power/qcom-rpmhpd.h            | 30 ++++++++++++++++++++++
 3 files changed, 48 insertions(+)
 create mode 100644 include/dt-bindings/power/qcom-rpmhpd.h

-- 
2.7.4

