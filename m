Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08995FF5EB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 00:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiJNWGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 18:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiJNWGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 18:06:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073C81911CF
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 15:06:00 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29EL09cG022839;
        Fri, 14 Oct 2022 22:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=faTbQoKY2pSJZJpFSoEXAj0P1nMyezAGQciOXb1I2s8=;
 b=kuPQYPBA0e4B6Sgas+h8fZAtWpGsqLUBgI9bjwKkhNAEZyVE2a8bsBV4v58QRFCckhY8
 oEFLu5LN1CEUpmkOiDI9QP70puVhXAv41VK4s6unLORCX/KnClS0FMToudYlVmjJL7Of
 GehkyqrP3Omdg8DoxPkCC+C87+dtvMLA0FRPrjDWno8fAJ9v2G290auPVZ+g8bGzBWQc
 Eluk+0DkjL49dydBkxNvHvJDBEC0ZQxIJJfTZ3OI+J6UNiOUNU/KJdjUW4lQt1koANrM
 GTnisTRtmndOjXIjlvmDSks0+8nGR2EDEMudclcxST/F4Gy05bz7moPNYqMtjRXnRqmO Pg== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k7f9v9f5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 22:05:48 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29EM5Cio011299;
        Fri, 14 Oct 2022 22:05:47 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04dal.us.ibm.com with ESMTP id 3k30uawk9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 22:05:47 +0000
Received: from smtpav06.wdc07v.mail.ibm.com ([9.208.128.115])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29EM5kh253019114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 22:05:47 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3868958079;
        Fri, 14 Oct 2022 22:05:46 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17AF25807A;
        Fri, 14 Oct 2022 22:05:45 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.160.52.204])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 14 Oct 2022 22:05:44 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     joel@jms.id.au
Cc:     broonie@kernel.org, jk@ozlabs.org, alistair@popple.id.au,
        linux-kernel@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        eajames@linux.ibm.com
Subject: [PATCH 3/5] drivers: fsi: Rename sbefifo and occ sources
Date:   Fri, 14 Oct 2022 17:05:38 -0500
Message-Id: <20221014220540.55570-4-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221014220540.55570-1-eajames@linux.ibm.com>
References: <20221014220540.55570-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SuC3DpewvchSB6IaS8M17lajkAAvIB1o
X-Proofpoint-GUID: SuC3DpewvchSB6IaS8M17lajkAAvIB1o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_11,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=788 mlxscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140121
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
index da218a1ad8e1..7fcd70ee0b10 100644
--- a/drivers/fsi/Makefile
+++ b/drivers/fsi/Makefile
@@ -6,5 +6,5 @@ obj-$(CONFIG_FSI_MASTER_ASPEED) += fsi-master-aspeed.o
 obj-$(CONFIG_FSI_MASTER_GPIO) += fsi-master-gpio.o
 obj-$(CONFIG_FSI_MASTER_AST_CF) += fsi-master-ast-cf.o
 obj-$(CONFIG_FSI_SCOM) += fsi-scom.o
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

