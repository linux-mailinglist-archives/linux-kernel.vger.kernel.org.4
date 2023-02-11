Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62338692FF4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 11:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjBKKWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 05:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBKKWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 05:22:15 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF8035B0;
        Sat, 11 Feb 2023 02:22:14 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31B7JWRF015351;
        Sat, 11 Feb 2023 10:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2022-7-12; bh=tBTgJM0KkGvAb5FJlT7qRnEXVapWla1h3UTy1Xt65OM=;
 b=c/AMbQm5gAun2wtktYHg2D5pf4cVMwkaHLX3OIzwrxd03L3Jb4zC9ncE3QuB7qkxVZcy
 B9cUsNeuG6KZSqTmGpS6L9z2yTZi0LMN+lcGJNWZ2otfaUp+3+AC8atH8Ab3JxYGHTuU
 cqOjro9OdoEOJpnY1NIqnD90rFDCxmIc3F6TjtMci7W7fD9FyFP20gYtnNdasONnPMvh
 78+uO0FtV1ZegZiqqJILKZzlz75bt5kA1P/4WnSvg7/qflhbSFiExLjMu6111dt4Ryf4
 nHvS9f0Izxh8SwU5xwvHTmS4WYPvEZVZbqrfUKVGR6SGq4ukTsLtiqnvXrM1SGlYbvZB lw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2w9r925-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Feb 2023 10:22:13 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31B68LK8028837;
        Sat, 11 Feb 2023 10:22:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f22u7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Feb 2023 10:22:13 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31BAMCxc039215;
        Sat, 11 Feb 2023 10:22:12 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3np1f22u7a-1;
        Sat, 11 Feb 2023 10:22:12 +0000
From:   Alok Tiwari <alok.a.tiwari@oracle.com>
To:     linux-scsi@vger.kernel.org
Cc:     alok.a.tiwari@oracle.com, darren.kenny@oracle.com,
        michael.christie@oracle.com, linux-kernel@vger.kernel.org,
        martin.petersen@oracle.com, d.bogdanov@yadro.com,
        target-devel@vger.kernel.org
Subject: [PATCH v2] scsi: target: core: Added a blank line after target_remove_from_tmr_list()
Date:   Sat, 11 Feb 2023 02:15:03 -0800
Message-Id: <20230211101502.2615442-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-11_06,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302110093
X-Proofpoint-GUID: qlzNnlfVNT-Yz7wV2chDKEiNrxcyCzCt
X-Proofpoint-ORIG-GUID: qlzNnlfVNT-Yz7wV2chDKEiNrxcyCzCt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no separate blank line between target_remove_from_tmr_list() and
transport_cmd_check_stop_to_fabric
As per coding-style, it is require to separate functions with one blank line.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
v2: remove  "fixes:" line and cc: stable
---
 drivers/target/target_core_transport.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index 5926316252eb..f1cdf78fc5ef 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -691,6 +691,7 @@ static void target_remove_from_tmr_list(struct se_cmd *cmd)
 		spin_unlock_irqrestore(&dev->se_tmr_lock, flags);
 	}
 }
+
 /*
  * This function is called by the target core after the target core has
  * finished processing a SCSI command or SCSI TMF. Both the regular command
-- 
2.39.1

