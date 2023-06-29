Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837AF741EDE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 05:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjF2Dtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 23:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjF2DtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 23:49:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7107D273B;
        Wed, 28 Jun 2023 20:49:24 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T395SX018207;
        Thu, 29 Jun 2023 03:49:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=eJDuWULCHpBChnFjsBNFxg7emBlrA7VNawfhBgMo0Dk=;
 b=b/WwfTBzD5QW+nD/zp1ck0ddUrs6JbZUdcEyUFpMElQKL6CsygAK/qAK3zXXmAT6lpFJ
 fNykuwFD+ay8BTMaT9M9Tgo8QuVApGMrlUXozFZ0yUp5GSK6gU7NEozuQwjpAo2bWCHO
 kBr+LmIQXMqDPbWS1nhPvBwL6ZYjLoCJAcbFu2M6ClNL5HfbE4k3Pwn4jpzuVWLI/ORe
 kcEHPiRl5/xYntFvwIwLVW3nbEPUi0aXqMly/m8EIeU0GzdzkFvh+hwtFwN/g5XIBvFx
 Kp1ChegCrdzEffKr8yrhlL94cyB/2C8f9krAU6YyVvoQTlgQIZDwF5kqYnlXDR+z96b4 NA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgnxr9dr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 03:49:13 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35T3nCYv014961
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jun 2023 03:49:12 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 28 Jun 2023 20:49:09 -0700
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux@armlinux.org.uk>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_sricharan@quicinc.com>, Luo Jie <quic_luoj@quicinc.com>
Subject: [PATCH 2/3] net: phy: at803x: remove 1000BaseX mode of qca8081
Date:   Thu, 29 Jun 2023 11:48:45 +0800
Message-ID: <20230629034846.30600-3-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230629034846.30600-1-quic_luoj@quicinc.com>
References: <20230629034846.30600-1-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5klEJROxc8ZWh_AhZW026jTagmWaTp2Y
X-Proofpoint-GUID: 5klEJROxc8ZWh_AhZW026jTagmWaTp2Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=783
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290032
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCA808x does not support the link mode 1000BaseX.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/phy/at803x.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index 3339ca372b24..29aab7eaaa90 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -920,7 +920,7 @@ static int at803x_get_features(struct phy_device *phydev)
 		}
 	}
 
-	if (phydev->drv->phy_id != ATH8031_PHY_ID)
+	if (phydev->drv->phy_id != ATH8031_PHY_ID && phydev->drv->phy_id != QCA8081_PHY_ID)
 		return 0;
 
 	/* AR8031/AR8033 have different status registers
@@ -933,6 +933,8 @@ static int at803x_get_features(struct phy_device *phydev)
 	 *
 	 * Remove this mode from the supported link modes
 	 * when not operating in 1000BaseX mode.
+	 *
+	 * QCA808x does not support 1000BaseX mode.
 	 */
 	if (!priv->is_1000basex)
 		linkmode_clear_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
-- 
2.17.1

