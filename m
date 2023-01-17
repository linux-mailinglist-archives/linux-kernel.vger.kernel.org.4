Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C7966E64D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 19:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjAQSnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 13:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234607AbjAQSi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 13:38:27 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6383803A
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:10:23 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HGZKhR015531;
        Tue, 17 Jan 2023 18:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=NcDDCrkTX4wtMuBqKMPjNce21bQxjTwahbcsqHHhL24=;
 b=Cn6s8IfGmD794s1p6KbLW9kAne0+LdXrNa8Ss2Mwszt9FxTHg74ctHf+bV5jJrRoWUhu
 HvMPJGaV3HomGonTqjpIt3cRl3EKtPZvfWoEu0yqmGvY1tIyt0z6bmBABQaPrFN4/ziK
 EndRQw6hR9kp+z1wkWmxvWpCcJTyex4I6kQTwIvvD/JtvjQI6bmlqvcYJdbrxS/rIBQI
 N4JiFZZEgUGdp0PYTs9RlmUdMD6fjQUk7OuQMT5Z77Zw1iLQHYPZv7rci4vbzDT0OLKQ
 +7j4UzAVhGg5urfn8oMmBMOmabU+oYYnhSeHH5EJW3yWKkgXcC8/PNvDw+hmED3dPLt6 HQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n5nkq9fgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 18:10:19 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30HIAIPm007665
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 18:10:18 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 17 Jan 2023 09:54:08 -0800
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <ogabbay@kernel.org>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Jeffrey Hugo" <quic_jhugo@quicinc.com>
Subject: [PATCH] MAINTAINERS/ACCEL: Add include/drm/drm_accel.h to the accel entry
Date:   Tue, 17 Jan 2023 10:52:05 -0700
Message-ID: <1673977925-8250-1-git-send-email-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KBPuh4XLw_ewJZvvbJaDSXcCbj8SdggC
X-Proofpoint-ORIG-GUID: KBPuh4XLw_ewJZvvbJaDSXcCbj8SdggC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_08,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 adultscore=0 mlxlogscore=931 bulkscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170144
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_maintainer.pl does not suggest Oded Gabbay, the DRM COMPUTE
ACCELERATORS DRIVERS AND FRAMEWORK maintainer for changes that touch
the Accel Subsystem header - drm_accel.h.  This is because that file is
missing from the Accel Subsystem entry.  Fix this.

Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 31ffd4b..7995ec7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6754,6 +6754,7 @@ C:	irc://irc.oftc.net/dri-devel
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/accel.git
 F:	Documentation/accel/
 F:	drivers/accel/
+F:	include/drm/drm_accel.h
 
 DRM DRIVERS FOR ALLWINNER A10
 M:	Maxime Ripard <mripard@kernel.org>
-- 
2.7.4

