Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0242170CE47
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 00:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbjEVWrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 18:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbjEVWqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 18:46:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA26109;
        Mon, 22 May 2023 15:46:40 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MKOOQj021249;
        Mon, 22 May 2023 22:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=jBkF9Iwl3VGmV4YD/DiO7Vduyh84oEogKnoF2BSAbdk=;
 b=tvUqootR64P7mDuxM5OykobdagzGnAw+ADfTCi9RNxb9dkiJxc1YUDlm5axOiW7cgzRg
 M3Y8S2TE/RQ/lek1d30fJpqr0MA0Y4faT8yBvmg2hGtE4XIf5eNlODNpz/DQOdB9pGPV
 zEas6JNS7AtiATTJvnJrTgZb/8I+LpHOITNQ94K/5e887c2vZN3PLv0EmWbJljEhzfUQ
 dOsHKDoJMF/CdJ7nyr9rSZU09ad5T3mBMqshba/DOv1fgdaUEeME5aJcvrso/8Ja9eL8
 5R1MjwjSlOhZymJCmRRCJ3w/bl6gVhrtugKIsKV+e9Ns9VdBmTrEr92ZcuoRGimYsHzL bg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp5bku4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 22:46:32 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34MLrZsC027323;
        Mon, 22 May 2023 22:46:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2ctfcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 22:46:31 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34MMkPxc017332;
        Mon, 22 May 2023 22:46:30 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3qqk2ctfa8-5;
        Mon, 22 May 2023 22:46:30 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Linux SCSI <linux-scsi@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Oliver Neukum <oliver@neukum.org>,
        Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 0/3] dc395x stale reference cleanup
Date:   Mon, 22 May 2023 18:46:16 -0400
Message-Id: <168479035950.1118074.6844851556275166076.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510093933.19985-1-bagasdotme@gmail.com>
References: <20230510093933.19985-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_16,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=614 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305220192
X-Proofpoint-GUID: k3t2HNhSIWTlQrDQzIPa6gTrpTd65s_8
X-Proofpoint-ORIG-GUID: k3t2HNhSIWTlQrDQzIPa6gTrpTd65s_8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2023 16:39:30 +0700, Bagas Sanjaya wrote:

> A small stale reference cleanup series for DC395x driver. The shortlog
> below should be self-explanatory.
> 
> This series is based on fixes branch of scsi tree.
> 
> Changes since v1 [1]:
>   * Do not explicitly mention linux-scsi list in MAINTAINERS
>   * Keep the attribution to the 2.4 driver but reword it to remove mention
>     to 2.5/2.6 version
>   * Use web.archive.org snapshot of 2.4 driver link.
> 
> [...]

Applied to 6.5/scsi-queue, thanks!

[1/3] MAINTAINERS: Drop DC395x list and site
      https://git.kernel.org/mkp/scsi/c/332aac6f0dc0
[2/3] Documentation: scsi: dc395x: Replace non-functional twibble.org list
      https://git.kernel.org/mkp/scsi/c/7a94a131aa10
[3/3] Documentation: scsi: dc395x: Reword original driver attribution
      https://git.kernel.org/mkp/scsi/c/16853cd8f6d4

-- 
Martin K. Petersen	Oracle Linux Engineering
