Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EC366A8D7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 04:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjANDHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 22:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjANDHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 22:07:13 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E7088A3E;
        Fri, 13 Jan 2023 19:07:12 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30E1hiNe031197;
        Sat, 14 Jan 2023 03:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2022-7-12;
 bh=DRWz60+jXLiy5CLT9C9dWNjDnDMYuYjwjLSulxV02SA=;
 b=Tjl9g9yB+wDYUDRtjQCo4MZv2Glndi8jU5XLy1weGyZhyO3ppJ8OXcoJBnD5eviZ56hX
 RBxMEiE0g7rw1+gVEQLorcgold7oc9SvVsz/3u7V44HeBVHKToKVtSQ1ZVwluTTrF4Q6
 2xXzz6vDiomp1iKA3OO/itm+ObtTxMoYTGjy2GK4Mh522xV2/L6Rhdf5dWzSTOfAzv8W
 bgGHjRNGGzWeC3QmQR3+E9xIUF++XM0wJ2ECinITvQXVlcJUTPeqi0D6URgd9vQ+Zqpc
 vQ+otS/vTZwqyGfypiWqfwRVrBZ2MjLtGzR+ASFRzixHzPxjKF24nkPtXlU+WGL5OITi 1A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k00r1u8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Jan 2023 03:07:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30E2xOL8018859;
        Sat, 14 Jan 2023 03:07:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n3m3d85t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Jan 2023 03:07:06 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30E375hD035466;
        Sat, 14 Jan 2023 03:07:06 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3n3m3d85sp-2;
        Sat, 14 Jan 2023 03:07:06 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Adam Radford <aradford@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: 3w-sas: Replace 1-element arrays with flexible array members
Date:   Fri, 13 Jan 2023 22:06:40 -0500
Message-Id: <167366469093.3069139.1897721173635562878.b4-ty@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230105004757.never.017-kees@kernel.org>
References: <20230105004757.never.017-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_12,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 mlxlogscore=996 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301140019
X-Proofpoint-GUID: Th2nMqJH9zDeqxRz1fk09OvIf8ZmNzEk
X-Proofpoint-ORIG-GUID: Th2nMqJH9zDeqxRz1fk09OvIf8ZmNzEk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Jan 2023 16:48:01 -0800, Kees Cook wrote:

> One-element arrays (and multi-element arrays being treated as
> dynamically sized) are deprecated[1] and are being replaced with
> flexible array members in support of the ongoing efforts to tighten the
> FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
> with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.
> 
> Replace one-element arrays with flexible-array member in TW_Ioctl_Buf_Apache
> and TW_Param_Apache, adjusting the explicit sizing calculations at the
> same time.
> 
> [...]

Applied to 6.3/scsi-queue, thanks!

[1/1] scsi: 3w-sas: Replace 1-element arrays with flexible array members
      https://git.kernel.org/mkp/scsi/c/45b379f20bc0

-- 
Martin K. Petersen	Oracle Linux Engineering
