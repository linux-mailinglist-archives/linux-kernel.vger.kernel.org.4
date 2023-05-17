Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98CB705CE1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjEQCM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjEQCMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:12:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68A11FCC;
        Tue, 16 May 2023 19:12:52 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GJwr1E019743;
        Wed, 17 May 2023 02:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=FBRa8aWwctXAiFd5MEiHUXgxE/7mieFcS33DMYSVSaQ=;
 b=NCOKGcab2yOACrhrt1QhLf3AZ4ajyhP8+1GkdBvul8ifju24850ijUjTxsn3mA73mAI1
 f1yCy43r9htiz/hQgIyZc7F8POPNk5HZPKabwHBK6A3pyv+8TFDtSM4ds2CSh7isKM7S
 M2SlK64Cmp1FUvkqkJ+cpfeVr8nxTxOCrFZo9RjZarDTjJjK6GRxqpe9/5VUwvDhBo7Y
 O9KwNS7atgWU3cmAN2uSH4myK3BrL0xGfSouyoeRnGSR6zy3bW6GGIaycb5ZHCA9yqRI
 yVH4SD/s1Mz87YGZ3USWUZouWhRNiBJa6rsJDDkQ/XJZnYuk3thCsOmq6oSFoCrbof4G dg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdmtnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 02:12:48 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34H1hGQI025011;
        Wed, 17 May 2023 02:12:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj104tw2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 02:12:47 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34H2CdOK016064;
        Wed, 17 May 2023 02:12:47 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3qj104tw04-6;
        Wed, 17 May 2023 02:12:47 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Pranav Prasad <pranavpp@google.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] scsi: pm80xx: Enhanced debug logs for HW events
Date:   Tue, 16 May 2023 22:12:29 -0400
Message-Id: <168428950403.722180.7287501289994686605.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418190101.696345-1-pranavpp@google.com>
References: <20230418190101.696345-1-pranavpp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170016
X-Proofpoint-GUID: jpjBDlj_lEiocJayR-PP8xwxEIQdgqqR
X-Proofpoint-ORIG-GUID: jpjBDlj_lEiocJayR-PP8xwxEIQdgqqR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023 19:00:55 +0000, Pranav Prasad wrote:

> This patch series enhances debug logs for pm80xx HW events, and provides
> a minor fix in the case of a hard reset. The log enhancement involves
> changing the log severity level to enable logging for HW events
> which consequently help debug disk discovery issues.
> 
> 1. Changed log severity level from MSG to EVENT for HW events.
> Enhanced the HW event logs by adding the phyid.
> 
> [...]

Applied to 6.5/scsi-queue, thanks!

[1/6] scsi: pm80xx: Log some HW events by default
      https://git.kernel.org/mkp/scsi/c/b7d26c1d8c51
[2/6] scsi: pm80xx: Enable init logging
      https://git.kernel.org/mkp/scsi/c/6a516506aad6
[3/6] scsi: pm80xx: Print port_id in HW events
      https://git.kernel.org/mkp/scsi/c/a6cf6b8bd6e2
[4/6] scsi: pm80xx: Log phy_id and port_id in the device registration request
      https://git.kernel.org/mkp/scsi/c/5f797120d853
[5/6] scsi: pm80xx: Log port state during HW event
      https://git.kernel.org/mkp/scsi/c/d309422d7dc6
[6/6] scsi: pm80xx: Update PHY state after hard reset
      https://git.kernel.org/mkp/scsi/c/3aa65f7e25ac

-- 
Martin K. Petersen	Oracle Linux Engineering
