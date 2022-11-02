Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A883A6160F4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 11:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiKBKgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 06:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiKBKgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:36:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0D328E0D;
        Wed,  2 Nov 2022 03:36:19 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A2AaD2s004849;
        Wed, 2 Nov 2022 10:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=IOXrnu4nfCWWAcBT0iruUGV/X9DBpAlavLRv2buA7pE=;
 b=AEn1tST7MShIT9tYyT2HFTMVzq/QHJ8wfgga313biOYYXLfQs2FQSwnMC520LKTIpH/L
 YLwYYoX26Qz3U6MRL9L67eSaRnC+gUrYiqHWabcxkJXlp1L7omdHxiYAjZwnh7Mz3HRm
 xljk8VFVv6pgiWo4sTAJLF4j7Kmh7y4I7cWG03Ure6G4VKNe5YCY5YHA7foJzjuVtkK8
 4pFP5Dw9OQ8yGq0cy+xHAW//HVW6ZfWvQKNfKkKMZlNz6/62dTNROyz/ldXlgp4XNCvZ
 4JnqMRO4hn6yLIIyykCw6SyFSv4R9x8TH9ICXaqi5/gi9cAB/RESGXexrrffEYGjwwTy Nw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kkj7u8jtv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 10:36:13 +0000
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2AaCp9007386;
        Wed, 2 Nov 2022 10:36:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 3khdmjn53d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 10:36:12 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A2AaCEZ007381;
        Wed, 2 Nov 2022 10:36:12 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 2A2AaCRA007380
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 10:36:12 +0000
Received: from hu-ppareek-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 2 Nov 2022 03:36:08 -0700
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
Subject: [PATCH v7 0/2] arm64: dts: qcom: add dts for sa8540p-ride board
Date:   Wed, 2 Nov 2022 16:05:50 +0530
Message-ID: <20221102103552.29388-1-quic_ppareek@quicinc.com>
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
X-Proofpoint-ORIG-GUID: BniAViYznm5D0qLy3hY3SNCsFHyAY9Sf
X-Proofpoint-GUID: BniAViYznm5D0qLy3hY3SNCsFHyAY9Sf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_06,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=589 clxscore=1011 priorityscore=1501 adultscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020064
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

changes in v2:
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
 arch/arm64/boot/dts/qcom/sa8540p-ride.dts     | 227 ++++++++++++++++++
 4 files changed, 306 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8450a.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sa8540p-ride.dts

-- 
2.17.1

