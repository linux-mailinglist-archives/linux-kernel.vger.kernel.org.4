Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F92871278A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243707AbjEZNcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243655AbjEZNcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:32:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A099C19D;
        Fri, 26 May 2023 06:32:01 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QCg8G0027567;
        Fri, 26 May 2023 13:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=VTBKhe96qusf9VC+xh1sh4ATq24KvEomqfsFFvUVmbw=;
 b=jm0Q595p2cxrOYGIdGyanmZZ4RpK9R6GAxNsHW7OqXu4/Z7YwPoq+qNLbBFlHBDddih0
 gkYhYkJymmArVehFDK/UN1dRCxwaJa3fILiycparm0q55Rce5Ltgm6WMEFd5a0Ul+xQ+
 DXBaLtUVOg0jUz3lkmiUEda6d8aoT5ZnQuS314lc/YOkifQHWzoCQt2t9V+6Di7bi6mi
 GakNG8mbAM0JEEOdAEcNk5EkYjgqXTw2UM/qadgJ4avaMwt+YUY/H/GCog0soOK+jG1L
 mzIo7MYyBy5YmL2e2EqT8/8ACZ+c3lsVmBsQmd/7AF4S7N7SHdhTBTNwQCY6E3hqTRQW Zw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qt47eu6qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 13:31:58 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34QDVvCV023777
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 13:31:57 GMT
Received: from hu-shazhuss-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 26 May 2023 06:31:54 -0700
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <konrad.dybcio@linaro.org>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/5] dts: qcom: sa8775p: add missing qup id's, i2c,
Date:   Fri, 26 May 2023 19:01:16 +0530
Message-ID: <20230526133122.16443-1-quic_shazhuss@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dWRvRqJ-kcCjU-xTOs4uRuEctq5ZMTLm
X-Proofpoint-ORIG-GUID: dWRvRqJ-kcCjU-xTOs4uRuEctq5ZMTLm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=0 clxscore=1011 adultscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=314 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305260114
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the qupv3_id_0, qupv3_id_3, i2c, spi and uart
nodes that are missing on the sa8775p platform.

i2c11 is enabled for A2B controller and audio port expander. 

Shazad Hussain (5):
  arm64: dts: qcom: sa8775p: add the QUPv3 #0 and #3 node
  arm64: dts: qcom: sa8775p: add missing i2c nodes
  arm64: dts: qcom: sa8775p: add missing spi nodes
  arm64: dts: qcom: sa8775p: add uart5 and uart9 nodes
  arm64: dts: qcom: sa8775p-ride: enable i2c11

 arch/arm64/boot/dts/qcom/sa8775p-ride.dts |  15 +
 arch/arm64/boot/dts/qcom/sa8775p.dtsi     | 925 +++++++++++++++++++++-
 2 files changed, 915 insertions(+), 25 deletions(-)

-- 
2.17.1

