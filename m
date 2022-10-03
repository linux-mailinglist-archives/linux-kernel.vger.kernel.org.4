Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7215F308C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 14:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJCMze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 08:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJCMz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 08:55:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6BD1EEF7;
        Mon,  3 Oct 2022 05:55:28 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 293CTXkp012560;
        Mon, 3 Oct 2022 12:55:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=9gnSyCCU+i9185aBTgZmQNokBHoI3NwEOIoWdO9++io=;
 b=T+wQLP44Cns8OoS6wn/i3ix3PzdoOPltNQZP4R1MB6i7IbWIlaoEB80Gl8ocBCCiwR+h
 RlHU/l01jWG1lAcDsq2wTEl/4R6jRu+nXqItFvKTwwMCnzigZwrT4V317DZVWLnSrmw9
 1pLE2IOILy9/A50PFmCtvrz2CwxBJFlcQquPzadGY1u0lJa4Q0tZrHwT1+LCd5yVZOBp
 +nW3zHUuFtCTqNm7832x7XonPlrQgGbBdz/m17F2vKBbYPfaGLI5Unes2YL0YdaKJeZ9
 dAAXEc07IlIP7Q4oRCm6J80OVKr/yyk2Pjw7ATJuoTENjCk1SZ5c2h6MYqtYQ0V0YfxH Pw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jxeugkwf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Oct 2022 12:55:22 +0000
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 293CtL0D003002;
        Mon, 3 Oct 2022 12:55:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 3jxemkfkj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Oct 2022 12:55:21 +0000
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 293CtLiY002995;
        Mon, 3 Oct 2022 12:55:21 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 293CtLOH002994
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Oct 2022 12:55:21 +0000
Received: from hu-ppareek-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 3 Oct 2022 05:55:17 -0700
From:   Parikshit Pareek <quic_ppareek@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
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
Subject: [PATCH v5 0/3] arm64: dts: qcom: add dts for sa8540p-ride board
Date:   Mon, 3 Oct 2022 18:24:40 +0530
Message-ID: <20221003125444.12975-1-quic_ppareek@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: m1Oh3xGdefi9znSpyjJyusibcunjfdx7
X-Proofpoint-ORIG-GUID: m1Oh3xGdefi9znSpyjJyusibcunjfdx7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-03_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=753 spamscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210030079
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change in v5:
- Moved the usb and ufs nodes from sa8540p-adp.dtsi file to respective
  board specific dts files: sa8295p-adp.dts and sa8540p-adp-ride.dts.
  Took inputs from Shazad Hussain in this regard(John)
- Added more description of the board differences(John)
- Not including Reviewed-by for Krzysztof, because of the new changes to
  be reviewed.
- Removed Reported-by tag(John).

Changes in v4:
 - Removed the ufs_card_hc node, as it is not mounted on Qdrive-3 board.
 - Removed usb_1 relared nodes, as usb1 doesn't have any port connected on
   Qdrive3 board.
 - Added Reported-by tag for Shazad(for ufs and usb_1 node removals)

Changes in v3:
 - Added Acked-by tag (Krzysztof)
 - Renamed dtsi to sa8540p-adp.dtsi (John)
 - Removed copyright from sa8295-adp.dts and sa8295-adp.dtsi(John)
 - Added cover letter

change in v2:
- Make dt-binding patch as the first one in the patch set
- Add , after year 2022, in the license header

Initial version:
- Move the common nodes to sa8540p-adp.dtsi, and create qrive-3 board
  specific file sa8540p-adp-ride.dts.


Parikshit Pareek (3):
  dt-bindings: arm: qcom: Document additional sa8540p device
  arm64: dts: qcom: sa8295p: move common nodes to dtsi
  arm64: dts: qcom: introduce sa8540p-ride dts

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts      | 528 +++++-------------
 arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts |  71 +++
 .../{sa8295p-adp.dts => sa8540p-adp.dtsi}     | 133 -----
 5 files changed, 219 insertions(+), 515 deletions(-)
 rewrite arch/arm64/boot/dts/qcom/sa8295p-adp.dts (70%)
 create mode 100644 arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts
 copy arch/arm64/boot/dts/qcom/{sa8295p-adp.dts => sa8540p-adp.dtsi} (72%)

-- 
2.17.1

