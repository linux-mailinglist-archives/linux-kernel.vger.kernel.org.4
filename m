Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29004616F28
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiKBUwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiKBUwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:52:11 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB4DE0D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 13:52:10 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2IpILr011131;
        Wed, 2 Nov 2022 20:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=NIusx8gvY/Jk9Tp5g6bdyvKxz9sPwLBhuxGSfZDJna4=;
 b=mVppHkhU0XpnrbEn35zErBujN4jUvZZXtrNBXl3xPLRcM3tY1if/7EBWAQFXmt6rPCRv
 TqenkEf/8oJsq49wjuCvbT1u5g9ueIRRdv7YRNjJKHgM/904Tm3kFK3yomNzQOAOLLvv
 9tgObzFZwOpCjtidFg6EAodHrAra4Kv7MMxNWVUYQu/l7HwGPJqeEuFzhrKUW2512QMf
 FsD8tfu6sE/4eHc173mo3fxn2fkMSgqhz5am0p2VFx1dSgpe/zg0e768cLrDm2BCzwGj
 KO4E5Z0hUZ5qLNTPCcpL5XNfr8FqOCCFKYgQO9oJZNr30a36H83oHS5bijmSGDqDcmcf OA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkvbyf4rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 20:51:56 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A2KojOT014815;
        Wed, 2 Nov 2022 20:51:55 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03dal.us.ibm.com with ESMTP id 3kgutam853-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 20:51:55 +0000
Received: from smtpav05.dal12v.mail.ibm.com ([9.208.128.132])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A2Kpq3C13239036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Nov 2022 20:51:52 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D4F358056;
        Wed,  2 Nov 2022 20:51:54 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 272A45805D;
        Wed,  2 Nov 2022 20:51:53 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.65.200.160])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  2 Nov 2022 20:51:52 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, jk@ozlabs.org,
        joel@jms.id.au, alistair@popple.id.au, eajames@linux.ibm.com
Subject: [PATCH v2 3/5] drivers: fsi: Rename sbefifo and occ sources
Date:   Wed,  2 Nov 2022 15:51:46 -0500
Message-Id: <20221102205148.1334459-4-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221102205148.1334459-1-eajames@linux.ibm.com>
References: <20221102205148.1334459-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QfWOknaRpM81Y6T_dGUXEVkXgKOcTC4W
X-Proofpoint-ORIG-GUID: QfWOknaRpM81Y6T_dGUXEVkXgKOcTC4W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=773
 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020135
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for some refactoring and adding multiple underlying
bus support for the SBEFIFO, rename the sources.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/Makefile                     | 4 ++--
 drivers/fsi/{fsi-occ.c => occ.c}         | 0
 drivers/fsi/{fsi-sbefifo.c => sbefifo.c} | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/fsi/{fsi-occ.c => occ.c} (100%)
 rename drivers/fsi/{fsi-sbefifo.c => sbefifo.c} (100%)

diff --git a/drivers/fsi/Makefile b/drivers/fsi/Makefile
index c49d7e65ee5b..850825556e9c 100644
--- a/drivers/fsi/Makefile
+++ b/drivers/fsi/Makefile
@@ -7,5 +7,5 @@ obj-$(CONFIG_FSI_MASTER_GPIO) += fsi-master-gpio.o
 obj-$(CONFIG_FSI_MASTER_AST_CF) += fsi-master-ast-cf.o
 obj-$(CONFIG_FSI_SCOM) += fsi-scom.o
 obj-$(CONFIG_FSI_I2CR) += i2cr.o
-obj-$(CONFIG_FSI_SBEFIFO) += fsi-sbefifo.o
-obj-$(CONFIG_FSI_OCC) += fsi-occ.o
+obj-$(CONFIG_FSI_SBEFIFO) += sbefifo.o
+obj-$(CONFIG_FSI_OCC) += occ.o
diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/occ.c
similarity index 100%
rename from drivers/fsi/fsi-occ.c
rename to drivers/fsi/occ.c
diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/sbefifo.c
similarity index 100%
rename from drivers/fsi/fsi-sbefifo.c
rename to drivers/fsi/sbefifo.c
-- 
2.31.1

