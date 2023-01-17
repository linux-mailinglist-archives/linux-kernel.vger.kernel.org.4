Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C59F66E649
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 19:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjAQSm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 13:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbjAQSi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 13:38:27 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A3D3803F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:10:17 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HHueDE005859;
        Tue, 17 Jan 2023 18:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=NcDDCrkTX4wtMuBqKMPjNce21bQxjTwahbcsqHHhL24=;
 b=CwK6sKDbIaIvzp/WUQ0hASkJWX4NdqZXKQeBp14DaRhQEUf1AMC6xvo17W3Em+PUYIqR
 mJUb0OusNnv5wMBuZ2YKh52NujYhsCYpXfBVpDWRHIoLtCO6z0BOxgu/+cPyZQRvU2uN
 DfsFQQlRI8fqCk4Wk2WaPlSCJlR5JsJG2R+l7C+u42j0xV5UvotmmHNt6tIrYsYyijth
 6UwJhR3l92LbAzqtUvKlRtlrYmSrWbh3XJIFQz3KwnSfEgQpWo7S5AJyH4D6nGaReNqQ
 VCLyAn8izIpCXIaVNSFyxJCfvSIrIoiieLOpsIk/nVsobGTS3bzzfDpmDBWNgtUR9qWk cg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n5t4j90kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 18:10:11 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30HIAAat008993
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 18:10:10 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 17 Jan 2023 10:04:52 -0800
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
To:     <ogabbay@kernel.org>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Jeffrey Hugo" <quic_jhugo@quicinc.com>
Subject: [PATCH] MAINTAINERS/ACCEL: Add include/drm/drm_accel.h to the accel entry
Date:   Tue, 17 Jan 2023 11:04:30 -0700
Message-ID: <1673978670-10110-1-git-send-email-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vsXpI4nrplNA7WmZ6Izmp3Yo9vTxIDNX
X-Proofpoint-ORIG-GUID: vsXpI4nrplNA7WmZ6Izmp3Yo9vTxIDNX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_09,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxscore=0 spamscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=948
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170144
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

