Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3406DE94B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 04:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjDLCFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 22:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjDLCFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 22:05:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CCC4C2D;
        Tue, 11 Apr 2023 19:05:21 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BL9fxF016846;
        Wed, 12 Apr 2023 02:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=XyddacQrOEObd5inHWKPd8K2BW12A6LoR4IjfefzZHI=;
 b=B5Eg0d8NEZO9bQqV5/j7wCWwH5wXFgK1xE//pTyRWpGcxp6RGp+MwGc6s7REXOApk8Dy
 CNMr8j7PKC2t+PBiy8J2sMdumxxYZRJ7PfuXkAtcVdh5EtNHkhj3w/Fn+vj2x/fyDQqU
 kNwlj5UZyvEkIdfWVc0mUnrkAAZuDXJQCBWJItA7Yjql94PTzNZr2mv9DFrf60I2hNua
 Z1Lf7oE+hRV9r88xWz4bHVMKT2/PadD+HGxHyH8r6XC2AdrWJ1CmKewPjmthmsDoyg+B
 tpbgbdtxi1+0wAiUz9DYpTrck/aBGOzIebiLGguHDxjVKDVOgYb6XCaGHCre7CyUbzgg MQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0hc6xdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 02:05:04 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33BNxJS0008203;
        Wed, 12 Apr 2023 02:05:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3puwc54tvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 02:05:02 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33C24xea031283;
        Wed, 12 Apr 2023 02:05:02 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3puwc54tqc-8;
        Wed, 12 Apr 2023 02:05:02 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     kartilak@cisco.com, sebaddel@cisco.com, jejb@linux.ibm.com,
        nathan@kernel.org, ndesaulniers@google.com,
        Tom Rix <trix@redhat.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] scsi: snic: remove unused xfer_len variable
Date:   Tue, 11 Apr 2023 22:04:48 -0400
Message-Id: <168126077055.185856.5469142120830492047.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230328001647.1778448-1-trix@redhat.com>
References: <20230328001647.1778448-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=723 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304120016
X-Proofpoint-GUID: r7T-t7Ft99JbyOsFmOMKZpFIYbPvMiv1
X-Proofpoint-ORIG-GUID: r7T-t7Ft99JbyOsFmOMKZpFIYbPvMiv1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Mar 2023 20:16:47 -0400, Tom Rix wrote:

> clang with W=1 reports
> drivers/scsi/snic/snic_scsi.c:490:6: error: variable
>   'xfer_len' set but not used [-Werror,-Wunused-but-set-variable]
>         u64 xfer_len = 0;
>             ^
> This variable is not used so remove it.
> 
> [...]

Applied to 6.4/scsi-queue, thanks!

[1/1] scsi: snic: remove unused xfer_len variable
      https://git.kernel.org/mkp/scsi/c/4e0966a48291

-- 
Martin K. Petersen	Oracle Linux Engineering
