Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85BF696A7D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjBNQ61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjBNQ54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:57:56 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F910CDD6;
        Tue, 14 Feb 2023 08:57:54 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EGY5g6024075;
        Tue, 14 Feb 2023 16:57:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=AmGECNd6St97LBoh+A9rIOqewIxcvxbPzSlIjKvVZ8g=;
 b=p0OWOTqOp42cOgdfrlkuLHqClmTK/BE9jeeolng3JP8mD/nNulfeV0QEeL3mJenHCSQB
 1ux+gnkaUQQOt5moPf3oYAVs2wdcynIpmRn1/tdnWDpep5xFQCTRscC6Gg1CCMKx2Zge
 yVNjRleogh1PPMwFMwHgGiK7eli09Zip7TAttxgCRgMyyYqXopQtkdyak2o0MHlKpyH0
 Ssf/bv/JkcbrFoZpjoLm0LdPSziMw7HzHs12xLXeIhK8Psjp9W993mEdju2uTJ4ulRQr
 H3opMszWIiyPn1KpnxjlEYbX8LRneSYiN0k5ngI4eAgwTaiY0qWeNd8OPduHwFY0vOlj nw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1m0x15k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 16:57:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31EGs0mU009566;
        Tue, 14 Feb 2023 16:57:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f5uuj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 16:57:44 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31EGuHop039739;
        Tue, 14 Feb 2023 16:57:43 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3np1f5uuff-8;
        Tue, 14 Feb 2023 16:57:43 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     agross@kernel.org, andersson@kernel.org, jejb@linux.ibm.com,
        Anjana Hari <quic_ahari@quicinc.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        konrad.dybcio@linaro.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_narepall@quicinc.com,
        quic_nitirawa@quicinc.com, quic_rampraka@quicinc.com
Subject: Re: [PATCH v5 0/1] scsi: ufs: Add hibernation callbacks
Date:   Tue, 14 Feb 2023 11:57:34 -0500
Message-Id: <167639371122.486235.4692041788950340868.b4-ty@oracle.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202161045.3956-1-quic_ahari@quicinc.com>
References: <20230202161045.3956-1-quic_ahari@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_11,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=841 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140144
X-Proofpoint-GUID: VC1GP91uLHtGyQIkzZGYzbRXBUmHjdX5
X-Proofpoint-ORIG-GUID: VC1GP91uLHtGyQIkzZGYzbRXBUmHjdX5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Feb 2023 21:40:44 +0530, Anjana Hari wrote:

> v5:
> -Removed extra hba->restore member introduced in previous
> patch, moved the concerned code to ufshcd_system_restore.
> 
> v4:
> -Addressed comments from Bart, removed runtime pm related
> code.
> -Address kernel bot compilation issues.
> 
> [...]

Applied to 6.3/scsi-queue, thanks!

[1/1] scsi: ufs: Add hibernation callbacks
      https://git.kernel.org/mkp/scsi/c/88441a8d355d

-- 
Martin K. Petersen	Oracle Linux Engineering
