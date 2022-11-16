Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5053262B441
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 08:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiKPHxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 02:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiKPHxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 02:53:12 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD5713E9B;
        Tue, 15 Nov 2022 23:53:11 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG6IZMf006972;
        Wed, 16 Nov 2022 07:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=e1eiauKe3XGd8wkBOWkUY0MJsPMu0ne6nXu8JZbpHiQ=;
 b=ntvVEWJdhZqNnejVAs9MKTKGaT49wFGXQDHbc9MgqxZqncj4osnaGcvMdMPNt4gGSuqY
 75cQdRZM3yMiMo8GC05i8qTbMlaTuJkcV2MbZEbnF+CIScYnuONS2MM61lrUAANdNV/W
 JdcLg/FhKg7pQLMqlaNjp6U1n6P+McE9p51DxdAU1UobgColg6ApciXApeOF9l4pAP7a
 ilYXuv1qsQUTg9SwyqkFE2dL6TotXtRWMxPzofVGHVdH9XaTlUrkqPWbCFccUpuKUSmD
 6CVtQVUoyHz4iS3JXe/sIA6PZJFaPsq9W6axIC+TMSqGTbWou8LUHk7LHE98hxwlpTAy GQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kvsud8ck8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 07:53:05 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2AG7r4AU002073;
        Wed, 16 Nov 2022 07:53:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 3kt4jkyng7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 07:53:04 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AG7r4JI002066;
        Wed, 16 Nov 2022 07:53:04 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 2AG7r3YI002062
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 07:53:04 +0000
Received: from hu-ppareek-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 15 Nov 2022 23:52:59 -0800
From:   Parikshit Pareek <quic_ppareek@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        "Shazad Hussain" <quic_shazhuss@quicinc.com>,
        Brian Masney <bmasney@redhat.com>,
        "Johan Hovold" <johan@kernel.org>,
        Parikshit Pareek <quic_ppareek@quicinc.com>
Subject: [PATCH v8 0/2] arm64: dts: qcom: add dts for sa8540p-ride board
Date:   Wed, 16 Nov 2022 13:22:05 +0530
Message-ID: <20221116075207.32363-1-quic_ppareek@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TiuwfQsL_aflZXze3QbsmiWL-XCnw6Yf
X-Proofpoint-GUID: TiuwfQsL_aflZXze3QbsmiWL-XCnw6Yf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 spamscore=0 clxscore=1011 bulkscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 mlxlogscore=672 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160054
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces the Qualcomm sa8540p-ride automotive development
  board, also called as Qdrive-3 board.

Changes in v8:
 - Changed the schema of the regulators(Krzysztof) 
 - Removed node remoteproc_adsp(Andrew)
 - Removed TODO comment for node usb_0_dwc3(Andrew)
 - Added Reviewed-by/Tested-by(Eric)

Changes in v7:
 - Put the smpi bus related pmic changes in sseparate dtsi files(Konrad)
 - Mention allowed regulator modes via DT property regulator-allowed-modes
   (Konrad and Brian)
 - Remove unused ldo nodes vreg_l3c and vreg_l10c(Shazad)

Changes in v6:
 - Introduced the new dts for the board, rather than moving common nodes
   between this one and SA8295 ADP board into dtsi file(Bjorn)
 - Drop 'adp' term to imply it being unrelated with ADP board(Internal
   discussion with Bjorn)
 - Removed Acked-by(Krzysztof) tag in dt-binding document, due to content
   change.
 - Not including Reviewed-by(Krzysztof), because of the content change.

Changes in v5:
 - Moved the usb and ufs nodes from sa8540p-adp.dtsi file to respective
   board specific dts files: sa8295p-adp.dts and sa8540p-adp-ride.dts.
   Took inputs from Shazad Hussain in this regard(John)
 - Added more description of the board differences(John)
 - Not including Reviewed-by for Krzysztof, because of the new changes to
   be reviewed.
 - Removed Reported-by tag(John).

Changes in v4:
- Removed the ufs_card_hc node, as it is not mounted on Qdrive-3 board.
- Removed usb_1 relared nodes, as usb1 doesn't have any port connected
   on Qdrive3 board.
- Added Reported-by tag for Shazad(for ufs and usb_1 node removals)

Changes in v3:
 - Added Acked-by tag (Krzysztof)
 - Renamed dtsi to sa8540p-adp.dtsi (John)
 - Removed copyright from sa8295-adp.dts and sa8295-adp.dtsi(John)
 - Added cover letter

Changes in v2:
 - Make dt-binding patch as the first one in the patch set
 - Add , after year 2022, in the license header

Initial version:
 - Move the common nodes to sa8540p-adp.dtsi, and create qrive-3 board
   specific file sa8540p-adp-ride.dts.

Parikshit Pareek (2):
  dt-bindings: arm: qcom: Document additional sa8540p device
  arm64: dts: qcom: add SA8540P ride(Qdrive-3)

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/pm8450a.dtsi         |  77 ++++++
 arch/arm64/boot/dts/qcom/sa8540p-ride.dts     | 221 ++++++++++++++++++
 4 files changed, 300 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8450a.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sa8540p-ride.dts

-- 
2.17.1

