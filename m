Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841F9741E71
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 04:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjF2CmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 22:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjF2Clm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 22:41:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07734213D;
        Wed, 28 Jun 2023 19:41:42 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35T1jdWI011098;
        Thu, 29 Jun 2023 02:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-03-30;
 bh=UvCn9ZNxcDPRHpVi/Z+CAyOuMROaxNkLOuH/lWROc1s=;
 b=G6Z+gxN5e5IQKR+aoDFIkeWJ0bMngm9cqTsK20RTTRrU7RiC9W4SBkSEaBxUk2Q7mDOq
 rW1domaRbUX187ipX82dGChdpPGZcRVZstiVUu/opGnn+dMueA2y4HNyyb9aTKUMIf+g
 8GOqCyP5XUhKlvoHaVAUMVxdpKLHbs13TdH4ztc24QPJSB3xfaBFfuAO8m6ZTKoBCw/8
 4Jg4NZKLJjnhL6No35UUW+gKDs/Z/YGVd8LwyEjnqA+VF8ppB0bZJOvmgLc4SLXNQyEM
 Z5YVp1NOpmxGSJjcMNEdU8B+jpoi3WdvBH/DJhj6KqauwxbLWrQmEO0etHfDPLsI5Vud HA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdqdtt4yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 02:41:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35T0DEH2004005;
        Thu, 29 Jun 2023 02:41:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxcvem5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 02:41:35 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35T2fYLH009945;
        Thu, 29 Jun 2023 02:41:34 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3rdpxcveka-3;
        Thu, 29 Jun 2023 02:41:34 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Don Brace <don.brace@microchip.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        storagedev@microchip.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] scsi: smartpqi: Replace one-element arrays with flexible-array members
Date:   Wed, 28 Jun 2023 22:41:29 -0400
Message-Id: <168800630155.587979.4081903286029728024.b4-ty@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <ZJNdKDkuRbFZpASS@work>
References: <ZJNdKDkuRbFZpASS@work>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_14,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=735 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306290022
X-Proofpoint-GUID: N1OEdKKqtfguBYFJ4t_gdKa9W3y1nod4
X-Proofpoint-ORIG-GUID: N1OEdKKqtfguBYFJ4t_gdKa9W3y1nod4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 14:27:20 -0600, Gustavo A. R. Silva wrote:

> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element arrays with flexible-array
> members in a couple of structures, and refactor the rest of the code,
> accordingly.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy().
> 
> [...]

Applied to 6.5/scsi-queue, thanks!

[1/1] scsi: smartpqi: Replace one-element arrays with flexible-array members
      https://git.kernel.org/mkp/scsi/c/6f0a92fd7db1

-- 
Martin K. Petersen	Oracle Linux Engineering
