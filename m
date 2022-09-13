Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E175B6CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 14:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiIMMJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 08:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiIMMJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 08:09:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBE113A;
        Tue, 13 Sep 2022 05:09:27 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DBpEki029303;
        Tue, 13 Sep 2022 12:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=JCxc1Ojv95W6xf87b7UX1sIpoTQQTskpUVwH+4Fl1pA=;
 b=TJ6YsmGQkkQkLh8jT5eswx6/jFROP80jin8ty0k8KDha6YPt51OlSi00OJ/O1ZDfr8bF
 PAuilnCFiW6lXlnlCNE4+1Mn7bGfUqeI2lIacmeimW8sN/AjcONZjhJXTdtn3i/hmkXH
 B+XUHxtyH/gORWReTBYR7qO0u5oOcFLkRsCQXj2dP+DSRIIaB3xlaSxmAwJAt4/bpt5h
 qJ7V9oV1LIeC7XxtO3xm4zzXvnn37QcBHQG27XH8jQRvP0T8bBZBQHBxzzNENG6p4ern
 Po/TR/2ewfwl5gdxcmqxkDMTOVE++/3ZBkBeuhlIVcUqIzaL87+EFWOX4uDwzYUrl3Y1 HQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjrk0g6rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 12:09:16 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28DC9GJk000536
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 12:09:16 GMT
Received: from hu-vgarodia-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 05:09:14 -0700
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
To:     <linux-media@vger.kernel.org>, <stanimir.varbanov@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Vikash Garodia" <quic_vgarodia@quicinc.com>
Subject: [PATCH] MAINTAINERS: Add Vikash as VENUS video driver co-maintainer
Date:   Tue, 13 Sep 2022 17:39:00 +0530
Message-ID: <1663070940-8165-1-git-send-email-quic_vgarodia@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zM61q-G5cUAxWV7X9EHm-7cfD0m85nxO
X-Proofpoint-GUID: zM61q-G5cUAxWV7X9EHm-7cfD0m85nxO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_05,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=835 spamscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209130055
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the past several amendments in video driver, I have been working
with Stanimir in multiple design discussions or handling a given
issue. With this, adding myself as a co-maintainer.

Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 936490d..d3ef64f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16969,6 +16969,7 @@ F:	drivers/thermal/qcom/
 
 QUALCOMM VENUS VIDEO ACCELERATOR DRIVER
 M:	Stanimir Varbanov <stanimir.varbanov@linaro.org>
+M:	Vikash Garodia <quic_vgarodia@quicinc.com>
 L:	linux-media@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

