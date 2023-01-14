Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C8A66A8DB
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 04:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjANDH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 22:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjANDHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 22:07:18 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FC8892CD;
        Fri, 13 Jan 2023 19:07:17 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30E2vunb023657;
        Sat, 14 Jan 2023 03:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=5PJ9XeEkwfrQvKnXCHlQ2rF70kDlcqxpnDahK4D+4OQ=;
 b=EP7lcwF3Fm69ylqvJ0+mVDbApuOiZnLT7vwLoLbZGAEQZLdKtJYZvQ4zuvcKW+XCwxuV
 yndCnR0UQl7OBrmnWIopmweUfzPx90YJ1f8OxefJgo1mt7leGNnq++KXQ9QDAfUpu1Nt
 h9DWJ3xkrrNtqg/KncwCyBOdnjAqm5AA8k4mFwPHPoLvmiSnl3wUXfwhide+BgfOOJYo
 85/g0viEipBgOsFJNb9TfH2ytQ66s2dWG4C05irdtTPVYqD/sVt8Dnqr0RNdN6LDpb97
 sNczkGGNvlKnE6kxbEzr8u4kYK0SRlOI8B77N6puHPYj9aI8fJ7XtmooJBMHaQxibJ2Y 0Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3kaa80vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Jan 2023 03:07:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30E2xHml018474;
        Sat, 14 Jan 2023 03:07:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n3m3d85su-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Jan 2023 03:07:06 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30E375hB035466;
        Sat, 14 Jan 2023 03:07:05 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3n3m3d85sp-1;
        Sat, 14 Jan 2023 03:07:05 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        beanhuo@micron.com, bvanassche@acm.org, quic_cang@quicinc.com,
        quic_xiaosenh@quicinc.com, Bean Huo <beanhuo@iokpp.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Several compilation warnings fixes for UFS Advanced RPMB
Date:   Fri, 13 Jan 2023 22:06:39 -0500
Message-Id: <167366469091.3069139.15644571425518842715.b4-ty@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230108224057.354438-1-beanhuo@iokpp.de>
References: <20230108224057.354438-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_12,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 mlxlogscore=866 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301140019
X-Proofpoint-GUID: fJBu-MVgQMHAN15Pyg0r_CtxwkKDUSqP
X-Proofpoint-ORIG-GUID: fJBu-MVgQMHAN15Pyg0r_CtxwkKDUSqP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 08 Jan 2023 23:40:54 +0100, Bean Huo wrote:

> These patches are to fix several compilation warnings introduced by my commit:
> 6ff265fc5ef6 ("scsi: ufs: core: bsg: Add advanced RPMB support in ufs_bsg"),
> please consider this patch series for the next your merge window.
> Apologies for this!!
> 
> 
> 
> [...]

Applied to 6.3/scsi-queue, thanks!

[1/3] scsi: ufs: core: bsg: Fix sometimes-uninitialized warnings
      https://git.kernel.org/mkp/scsi/c/5e87c51f186e
[2/3] scsi: core: Fix invisible definition compilation warning
      https://git.kernel.org/mkp/scsi/c/f3e57da52812
[3/3] scsi: ufs: core: bsg: Fix cast to restricted __be16 warning
      https://git.kernel.org/mkp/scsi/c/e2cb6e8db69e

-- 
Martin K. Petersen	Oracle Linux Engineering
