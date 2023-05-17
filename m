Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D1F705CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjEQCO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjEQCOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:14:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2C25B91;
        Tue, 16 May 2023 19:13:52 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GJwqMX019718;
        Wed, 17 May 2023 02:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=ppDk0NtdoPwnA/hqpFAWgsULT+yOKmYHv0B85aNUoEY=;
 b=gnbhIS9UxNMkxyYwFEkwDeEkNXZGrjqDIL3/3kUbYrSzkUSxi6Jk4ugmWirQgJc4KeQv
 IpBQulNVjBD4MXLFtwLF58rrMPViDeRfgzoKs2TIvT8qD4KnuLZJckny9rz3omBuZn5v
 /cGFmIOEyoerURQB7ZZrbofkoxhn7yE5gzTGrDq1JERO+qDj+dp87KM0isRgtcp86PpN
 GY44/cAFCZx4nKBN425qd3NKRZ1ZCZ1ALtZsmuoBEBZ/KqmnxJYZeKI/58u5SZ0kmjZE
 jXS3QQDrMN5OioHATSHm/bhEcFf1aHHAVv51icYLX2pa177OUiL3M4VeA+S48KP9Lyly fg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2kdmtpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 02:13:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34GN8fcQ040031;
        Wed, 17 May 2023 02:13:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj104k9w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 02:13:38 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34H29qF5039460;
        Wed, 17 May 2023 02:13:37 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3qj104k9sf-3;
        Wed, 17 May 2023 02:13:37 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Po-Wen Kao <powen.kao@mediatek.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        naomi.chu@mediatek.com, chun-hung.wu@mediatek.com,
        cc.chou@mediatek.com, eddie.huang@mediatek.com
Subject: Re: [PATCH v6 0/3] Several UFS MCQ Code Changes
Date:   Tue, 16 May 2023 22:13:27 -0400
Message-Id: <168428957876.722389.3023312263286378543.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230504154454.26654-1-powen.kao@mediatek.com>
References: <20230504154454.26654-1-powen.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170017
X-Proofpoint-GUID: FCjHcAqvovQ7ILZX5jjVT4jM7tPtyK8K
X-Proofpoint-ORIG-GUID: FCjHcAqvovQ7ILZX5jjVT4jM7tPtyK8K
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 May 2023 23:44:48 +0800, Po-Wen Kao wrote:

> v5 -> v6
> - Also fix call to sizeof_utp_transfer_cmd_desc() in
> `ufshcd_release_sdb_queue()` as suggested by Stanley Chu
> 
> v4 -> v5
> - Send MTK driver MCQ support as independent patch and address Bart's
> comment there
>     "[PATCH v1 0/2] Add MCQ support for MTK platform"
> 
> [...]

Applied to 6.4/scsi-fixes, thanks!

[1/3] scsi: ufs: core: Fix mcq tag calcualtion
      https://git.kernel.org/mkp/scsi/c/5149452ca662
[2/3] scsi: ufs: core: Rename symbol sizeof_utp_transfer_cmd_desc()
      https://git.kernel.org/mkp/scsi/c/06caeb536b2b
[3/3] scsi: ufs: core: Fix mcq nr_hw_queues
      https://git.kernel.org/mkp/scsi/c/72a81bb0b6fc

-- 
Martin K. Petersen	Oracle Linux Engineering
