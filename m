Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E793B5BE56E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiITMOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiITMOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:14:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D66C6BD6E;
        Tue, 20 Sep 2022 05:14:10 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KBvox2032765;
        Tue, 20 Sep 2022 12:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=B5bAVCqRtxV8QojH9AHyQ2XSjZoPZlSwxN7uVzQrxog=;
 b=cX5l7BWcU/ZYPtZu2ZmfPHb77pRw+sl0t63C4JFQZQzMeE0aPqtJhZ1FHIwS/9zUKWyZ
 J57aQLA2cEp+z2VATYdVe29gqKFw7VeXv0qsp/1nKkz1ttEJD9EjQKuugfMmuBhXHvYf
 fP14Ce7fpdbanaOAZcd2ZGAHM3zCmZHPBl0txZkNCr3MN8go4GZ2TQJw4uT0pGKeYqsD
 O53P3P6ita8denIIFb+qRqXGVO+7ZyfMT1iJ7PFA8n7wbk4k1gip/2T0VqYpum8DjDb2
 lw1aUBuUF0xqAGP/ul1dcnRqJaOcPdqBTe1hp4RPTF4t6EBDKb1gKQYl0F1lUiJh92iD hw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jq8fw145t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 12:14:05 +0000
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 28KC5TuU030109;
        Tue, 20 Sep 2022 12:09:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 3jnqr7s243-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 12:09:03 +0000
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28KC93uI001507;
        Tue, 20 Sep 2022 12:09:03 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 28KC93n0001505
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 12:09:03 +0000
Received: from hu-ppareek-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 20 Sep 2022 05:08:59 -0700
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
        Parikshit Pareek <quic_ppareek@quicinc.com>
Subject: [PATCH v4 0/3] arm64: dts: qcom: add dts for sa8540p-ride board 
Date:   Tue, 20 Sep 2022 17:37:59 +0530
Message-ID: <20220920120802.14321-1-quic_ppareek@quicinc.com>
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
X-Proofpoint-GUID: Mj42Ip4fkQhnDVH0yIDPQzHIXd-2Qyyp
X-Proofpoint-ORIG-GUID: Mj42Ip4fkQhnDVH0yIDPQzHIXd-2Qyyp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_04,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=498 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209200073
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces the Qualcom sa8540p-ride automotive development
board, also called as Qdrive-3 board.

Changes in v4:
 - Removed the ufs_card_hc node, as it is not mounted on Qdrive-3 board.
 - Removed usb_1 related nodes, as usb1 doesn't have any port connected on
   Qdrive3 board.
 - Added Reported-by tag for Shazad(for ufs and usb_1 node removals)

Parikshit Pareek (3):
  dt-bindings: arm: qcom: Document additional sa8540p device
  arm64: dts: qcom: sa8295p: move common nodes to dtsi
  arm64: dts: qcom: introduce sa8540p-ride dts

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts      | 392 +-----------------
 arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts |  15 +
 .../{sa8295p-adp.dts => sa8540p-adp.dtsi}     |   0
 5 files changed, 31 insertions(+), 378 deletions(-)
 rewrite arch/arm64/boot/dts/qcom/sa8295p-adp.dts (96%)
 create mode 100644 arch/arm64/boot/dts/qcom/sa8540p-adp-ride.dts
 copy arch/arm64/boot/dts/qcom/{sa8295p-adp.dts => sa8540p-adp.dtsi} (100%)

-- 
2.17.1

